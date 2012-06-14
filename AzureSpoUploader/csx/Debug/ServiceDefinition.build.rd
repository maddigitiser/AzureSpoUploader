<?xml version="1.0" encoding="utf-8"?>
<serviceModel xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" name="AzureSpoUploader" generation="1" functional="0" release="0" Id="ea759542-ad7f-499d-bab1-cb10da53c394" dslVersion="1.2.0.0" xmlns="http://schemas.microsoft.com/dsltools/RDSM">
  <groups>
    <group name="AzureSpoUploaderGroup" generation="1" functional="0" release="0">
      <componentports>
        <inPort name="WebUploader:Endpoint1" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/AzureSpoUploader/AzureSpoUploaderGroup/LB:WebUploader:Endpoint1" />
          </inToChannel>
        </inPort>
      </componentports>
      <settings>
        <aCS name="WebUploader:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/AzureSpoUploader/AzureSpoUploaderGroup/MapWebUploader:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="WebUploader:SharepointSiteUrl" defaultValue="">
          <maps>
            <mapMoniker name="/AzureSpoUploader/AzureSpoUploaderGroup/MapWebUploader:SharepointSiteUrl" />
          </maps>
        </aCS>
        <aCS name="WebUploaderInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/AzureSpoUploader/AzureSpoUploaderGroup/MapWebUploaderInstances" />
          </maps>
        </aCS>
      </settings>
      <channels>
        <lBChannel name="LB:WebUploader:Endpoint1">
          <toPorts>
            <inPortMoniker name="/AzureSpoUploader/AzureSpoUploaderGroup/WebUploader/Endpoint1" />
          </toPorts>
        </lBChannel>
      </channels>
      <maps>
        <map name="MapWebUploader:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/AzureSpoUploader/AzureSpoUploaderGroup/WebUploader/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapWebUploader:SharepointSiteUrl" kind="Identity">
          <setting>
            <aCSMoniker name="/AzureSpoUploader/AzureSpoUploaderGroup/WebUploader/SharepointSiteUrl" />
          </setting>
        </map>
        <map name="MapWebUploaderInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/AzureSpoUploader/AzureSpoUploaderGroup/WebUploaderInstances" />
          </setting>
        </map>
      </maps>
      <components>
        <groupHascomponents>
          <role name="WebUploader" generation="1" functional="0" release="0" software="C:\Users\Tom\Documents\Visual Studio 2010\Projects\AzureSpoSc\AzureSpoUploader\AzureSpoUploader\csx\Debug\roles\WebUploader" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaIISHost.exe " memIndex="1792" hostingEnvironment="frontendadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="Endpoint1" protocol="http" portRanges="80" />
            </componentports>
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="SharepointSiteUrl" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;WebUploader&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;WebUploader&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/AzureSpoUploader/AzureSpoUploaderGroup/WebUploaderInstances" />
            <sCSPolicyFaultDomainMoniker name="/AzureSpoUploader/AzureSpoUploaderGroup/WebUploaderFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
      </components>
      <sCSPolicy>
        <sCSPolicyFaultDomain name="WebUploaderFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyID name="WebUploaderInstances" defaultPolicy="[1,1,1]" />
      </sCSPolicy>
    </group>
  </groups>
  <implements>
    <implementation Id="5afb107a-ebdf-4c8b-af84-a3f5fb83590d" ref="Microsoft.RedDog.Contract\ServiceContract\AzureSpoUploaderContract@ServiceDefinition.build">
      <interfacereferences>
        <interfaceReference Id="95f9b255-21a9-4a17-9e01-4dde141d8b7e" ref="Microsoft.RedDog.Contract\Interface\WebUploader:Endpoint1@ServiceDefinition.build">
          <inPort>
            <inPortMoniker name="/AzureSpoUploader/AzureSpoUploaderGroup/WebUploader:Endpoint1" />
          </inPort>
        </interfaceReference>
      </interfacereferences>
    </implementation>
  </implements>
</serviceModel>