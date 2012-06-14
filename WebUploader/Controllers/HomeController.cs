using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using ClaimsAuth;
using Microsoft.SharePoint.Client;
using System.IO;
using System.Text;
using Microsoft.WindowsAzure.ServiceRuntime;

namespace WebUploader.Controllers
{
    public class HomeController : Controller
    {      
        private readonly String sharepointSiteUrl;
        private readonly String sharepointUsername;
        private readonly String sharepointPassword;
        private readonly String sharepointLibrary;
        private readonly ClaimsWrapper wrapper;

        public HomeController()
        {
            if (RoleEnvironment.IsAvailable)
            {
                sharepointSiteUrl = RoleEnvironment.GetConfigurationSettingValue("SharepointSiteUrl");
                sharepointUsername = RoleEnvironment.GetConfigurationSettingValue("SharepointUsername");
                sharepointPassword = RoleEnvironment.GetConfigurationSettingValue("SharepointPassword");
                sharepointLibrary = RoleEnvironment.GetConfigurationSettingValue("SharepointLibrary");
            }

            wrapper = new ClaimsWrapper(sharepointSiteUrl, sharepointUsername, sharepointPassword);
        }

        /// <summary>
        /// Query for the names of all the files in a specified library
        /// </summary>
        /// <param name="context">The SP Client OM</param>
        /// <param name="libraryName">The name of library to quesy</param>
        /// <returns></returns>
        [NonAction]
        private IEnumerable<String> LoadLibraryDocuments(ClientContext context, String libraryName)
        {
            List<String> fileNames = new List<String>();

            List sharedDocumentsList = context.Web.Lists.GetByTitle(libraryName);
            ListItemCollection listItems = sharedDocumentsList.GetItems(CamlQuery.CreateAllItemsQuery());
            context.Load(sharedDocumentsList);
            context.Load(listItems);
            context.ExecuteQuery();

            foreach (var item in listItems)
            {
                fileNames.Add(item["FileLeafRef"].ToString()); //load the name of the file
            }

            return fileNames;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            ViewBag.Message = "Upload a document to the library";

            ClientContext context = new ClientContext(sharepointSiteUrl);
            context.ExecutingWebRequest += wrapper.ClientContextExecutingWebRequest;

            ViewBag.fileNames = LoadLibraryDocuments(context, sharepointLibrary);

            return View();
        }

        /// <summary>
        /// Post the uploaded file to the sharepoint server and update our list of file
        /// </summary>
        /// <param name="file">File to upload</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Index(HttpPostedFileBase file)
        {
            if (file.ContentLength > 0)
            {
                ClientContext context = new ClientContext(sharepointSiteUrl);
                context.ExecutingWebRequest += wrapper.ClientContextExecutingWebRequest;

                Web web = context.Web;
                List library = web.Lists.GetByTitle(sharepointLibrary);
                Byte[] input = new Byte[file.ContentLength];
                file.InputStream.Read(input, 0, file.ContentLength);
                var fileToCreate = library.RootFolder.Files.Add(new FileCreationInformation
                {
                    Content = input,
                    Url = file.FileName,
                    Overwrite = true
                });

                context.Load(fileToCreate);
                context.ExecuteQuery();

                ViewBag.fileNames = LoadLibraryDocuments(context, sharepointLibrary); //fetch the updated list of documents

            }
            return View();
        }
    }
}
