function Deploy-vCAVManager(){
    <#
    .SYNOPSIS
    This cmdlet deploys a vCloud Availability Cloud Manager appliance to the currently connected vCenter Server. This cmdlet creates the core components for a vCloud Availability Installation.

    .DESCRIPTION
    This cmdlet deploys a vCloud Availability Cloud Manager appliance to the currently connected vCenter Server. This cmdlet creates the core components for a vCloud Availability Installation.
    The steps taken are as follows:
    - The basic appliance is deployed and configured using the New-vCAVAppliance cmdlet
    - The product licence is installed
    - The vSphere Lookup Service is registered with the appliance (C4 Manager and the H4 Replication Manager)
    - If provided, the self-certificate is replaced on the appliance with the one provided (C4 Cloud Manager)
    - A local vCloud Availability Cloud Site is created and the vSphere SSO Credentials for the Cloud Manager is set
    - The Site is linked with vCloud Director
    - Public API Address endpoints for the Local Site are configured

    Note: Only IPv4 addressing is available using this command at this time.

    .PARAMETER vSphereLookupService
    The URI of the vSphere Lookup Service for the vCloud Resource vCenter hosting the VMs for the local site e.g. https://mgtvc1.pigeonnuggets.com/lookupservice/sdk

    .PARAMETER vSphereAPICredentials
    Credentials for the vCloud Resource vCenter. This account should have vi-admin rights to the vCenter specified in the Lookup Service parameter.

    .PARAMETER vCloudURI
    The URI of the vCloud Director API endpoint. e.g. https://vcd.pigeonnuggets.com/api

    .PARAMETER vCloudAPICredentials
    Credentials for vCloud Director with System Administrator priviledges to use for vCloud Availability system tasks.

    .PARAMETER LicenceKey
    The Product Key to install. The product key must be valid for the installation to succeed.

    .PARAMETER SiteName
    The Site Name for the vCloud Availability site. This must not include spaces.

    .PARAMETER SiteDescription
    A description for the vCloud Availability Site.

    .PARAMETER PublicAPIEndpoint
    The public address to be used when accessing the vCloud Availability service.

    .PARAMETER PVDCScope
    Optionally the names of the ProviderVDCs that should be enabled for this vCloud Site. If not specified all PVDCs are enabled.

    .PARAMETER InternalAPIEndpoint
    The private or management address that should be set for the vCloud Availability service.

    .PARAMETER PKCS12CertificateFile
    Path to the PKCS12 certificate store which contains the certificate to install of the C4 Cloud Service.

    .PARAMETER CertificateFileSecret
    Password for the PKCS12CertificateFile if one is provided

    .PARAMETER OVAImage
    The fully qualified path to the vCloud Availability OVA

    .PARAMETER Cluster
    The vSphere HA/DRS Cluster the OVA should be deployed to

    .PARAMETER VMFolder
    The VM Folder (Virtual Machines and Templates folder) the object should be placed

    .PARAMETER VMName
    The VM Name in vSphere

    .PARAMETER StorageType
    A switch to specify if the value provided in -Datastore is a DatastoreCluster or Datastore.
    Valid: "DatastoreCluster","Datastore"
    Default: Datastore

    .PARAMETER RootPassword
    The Root Password to be set for the vCAV Appliance

    .PARAMETER Datastore
    The Datastore or Datastore Cluster to place the VM on

    .PARAMETER vNIC0_PortGroup
    The vSphere dvPort Group for vNIC with Index 0 (Admin/Main Interface)

    .PARAMETER vNIC0_IP
    The IPv4 address for the vNIC with Index 0 (Admin/Main Interface)

    .PARAMETER vNIC0_Netmask
    The IPv4 subnet mask for the vNIC with Index 0 (Admin/Main Interface) eg. 255.255.255.0 (for 24-bit)

    .PARAMETER vNIC0_BuildGateway
    IPv4 Routable Gateway for build. This is the gateway/router for vNIC0 when the -SecondaryNIC switch is set. It is set so that during build a routable gateway is set to continue to communicate with the machine for configuration. This address is discarded after first boot.

    .PARAMETER DefaultGatewayIP
    The default gateway IP address that should be set.
    NOTE: If -SecondaryNIC is set this is set on the vNIC1 adapater otherwise is set on vNIC0

    .PARAMETER SecondaryNIC
    If this parameter is set two vNICs are added to the machine with the default gateway set on vNIC Index 1 (North)

    .PARAMETER vNIC1_PortGroup
    The vSphere dvPort Group for vNIC with Index 1 (Public Interface)

    .PARAMETER vNIC1_IP
    The IPv4 address for the vNIC with Index 1 (Public Interface)

    .PARAMETER vNIC1_Netmask
    The IPv4 subnet mask for the vNIC with Index 1 (Public Interface) eg. 255.255.255.0 (for 24-bit)

    .PARAMETER NTPServers
    A comma-seperated list of NTP Servers to configure for the appliance

    .PARAMETER DNSServers
    A comma-seperated list of DNS Servers to configure for the appliance

    .PARAMETER HostName
    The hostname for the appliance.

    .PARAMETER SSHEnabled
    Specifies if the SSH daemon should be enabled. This can be set via the API after deployment also.
    Default: $True

    .PARAMETER DNSSearchPath
    The DNS Search Path for the to configure for the appliance

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-09-17
	VERSION: 1.0
    #>
    Param(
        [Parameter(Mandatory=$True)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [string] $vSphereLookupService,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [PSCredential] $vSphereAPICredentials,
        [Parameter(Mandatory=$True)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [string] $vCloudURI,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [PSCredential] $vCloudAPICredentials,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [string] $LicenceKey,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [string] $SiteName,
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [string] $SiteDescription,
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [string[]] $PVDCScope,
        [Parameter(Mandatory=$False)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [string] $InternalAPIEndpoint,
        [Parameter(Mandatory=$False)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [string] $PublicAPIEndpoint,
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [string] $PKCS12CertificateFile,
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [SecureString] $CertificateFileSecret,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [string] $OVAImage,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [string] $Cluster,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [string] $VMFolder,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [string] $VMName,
        [Parameter(Mandatory=$False)]
            [ValidateSet("DatastoreCluster","Datastore")]  [string] $StorageType="Datastore",
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [string] $Datastore,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [SecureString] $RootPassword,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [string] $vNIC0_PortGroup,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [string] $vNIC0_IP,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [string] $vNIC0_Netmask,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [string] $DefaultGatewayIP,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [string] $HostName,
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [bool] $SSHEnabled = $true,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [string] $NTPServers,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [string] $DNSServers,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [string] $DNSSearchPath,
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [string] $HostEntries,
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [string] $vNIC0_StaticRoutes
    )
    # Step 1. Validate inputs
    if($PSBoundParameters.ContainsKey("PKCS12CertificateFile")){
        # Check if a password has been provided at least, this needs to be validated...eq $null?
        if($CertificateFileSecret -eq $null){
            throw "If the -PKCS12CertificateFile switch is provided you must provide a password for the file using the -CertfilcateFileSecret parameter"
        }
    }
    # Remove any spaces from the Site Name
    $SiteName = $SiteName.Trim()

    # Step 2. Deploy a vCloud Availability Manager appliance from Image
    $CloudAppliance = @{
        Component = "cloud"
        OVAImage = $OVAImage
        Cluster = $Cluster
        VMFolder = $VMFolder
        VMName = $VMName
        StorageType = $StorageType
        Datastore = $Datastore
        RootPassword = $RootPassword
        vNIC0_PortGroup = $vNIC0_PortGroup
        vNIC0_IP = $vNIC0_IP
        vNIC0_Netmask = $vNIC0_Netmask
        DefaultGatewayIP = $DefaultGatewayIP
        HostName = $HostName
        DNSServers = $DNSServers
        DNSSearchPath = $DNSSearchPath
        SSHEnabled = $SSHEnabled
        NTPServers = $NTPServers
    }
    # Now check if the non-mandatory have been provided and add them if they exist
    if($HostEntries.Length -ne 0){
        $CloudAppliance.Add("HostEntries",$HostEntries)
    }
    if($vNIC0_StaticRoutes.Length -ne 0){
        $CloudAppliance.Add("vNIC0_StaticRoutes",$vNIC0_StaticRoutes)
    }
    # Need to remove any values that are not set before calling the Splat to prevent $null values from being passed ?
    New-vCAVAppliance @CloudAppliance

    # Step 3. Establish an API session with the vCloud Availability Cloud Manager and Install the product key
    $vCAVAPICred = New-Object System.Management.Automation.PSCredential ("root", $RootPassword)
    try{
        Connect-vCAVService -Server $vNIC0_IP -Port 443 -Credentials $vCAVAPICred -AuthProvider "Local"
    } catch {
        throw "Exception occured connecting to the vCloud Availability Cloud Manager service. Exception is $_"
    }
    try{
        Set-vCAVLicenceKey -Key $LicenceKey > $null
    } catch {
        throw "Exception occured attempting to install the Product Key for the vCloud Availability service. Please check it is valid and try the cmdlet again. Exception is $_"
    }

    # Step 4. Need to set the vSphere Lookup Service for the C4 Cloud Service
    try{
        Set-vCAVResourcevCenterLookupService -LookupServiceURI $vSphereLookupService
    } catch {
        throw "Exception occured attempting to set the Resource vSphere SSO Service for the vCloud Availability service. Please check it is valid and try the cmdlet again. Exception is $_"
    }

    # Step 5. Replace the TLS Certificate on the C4 Cloud Service and wait for the operation to complete
    if($PSBoundParameters.ContainsKey("PKCS12CertificateFile")){
        # Call the API to replace the certificates on the appliance with the provided certificates
        try{
            Install-vCAVCertificate -Certificate $PKCS12CertificateFile -CertificateFileSecret $CertificateFileSecret -Force $true > $null
            Start-Sleep -Seconds 60
        } catch {
            throw "An error has occurred attempting to change the certificates on the appliance. The Exception is $_"
        }
    }
    Disconnect-vCAVService

    # Step 6. Need to set the vSphere Lookup Service for the Replication Manager
    try{
        Connect-vCAVService -Server $vNIC0_IP -Port 8044 -Credentials $vCAVAPICred -AuthProvider "Local"
    } catch {
        throw "Exception occured connecting to the vCloud Availability Replication Manager service. Exception is $_"
    }
    try{
        Set-vCAVResourcevCenterLookupService -LookupServiceURI $vSphereLookupService
    } catch {
        throw "Exception occured attempting to set the Resource vSphere SSO Service for the vCloud Availability service. Please check it is valid and try the cmdlet again. Exception is $_"
    }
    Disconnect-vCAVService

    # Step 7. Configure the local Site
    try{
        Connect-vCAVService -Server $vNIC0_IP -Port 443 -Credentials $vCAVAPICred -AuthProvider "Local"
    } catch {
        throw "Exception occured connecting to the vCloud Availability Cloud Manager service. Exception is $_"
    }
    try{
        Add-vCAVSite -SiteName $SiteName -SiteDescription $SiteDescription
    } catch {
        throw "Exception occured attempting to configure the local site for the vCloud Availability service. Please check it is valid and try the cmdlet again. Exception is $_"
    }

    # Step 8. Configure the SSO Credentials for Resource vCenter
    # NOTE: The behaviour changes and this API endpoint/configuration is no longer possible/required in vCAV v3.5 (To be confirmed)
    if($DefaultvCAVServer.buildVersion -lt "3.5"){
        try{
            Set-vCAVReplicationManagerCred -SSOCredentials $vSphereAPICredentials
        } catch {
            throw "Exception occured attempting to configure the SSO Credentials for the H4 Manager. Please check it is valid and try the cmdlet again. Exception is $_"
        }
    }
    # Step 9. Set the Public and Internal API Endpoints for the Service
    try{
        Set-vCAVSitePublicEndpoint -APIPublicAddress $PublicAPIEndpoint -ManagementPublicAddress $InternalAPIEndpoint
    } catch {
        throw "Exception occured attempting to configure the API endpoint addresses for the vCloud Availability service. Exception is $_"
    }

    # Step 9. Register vCAV local site with vCloud
    try{
        Set-vCAVSitevCloud -vCloudAPIURI $vCloudURI -vcdCredentials $vCloudAPICredentials
    } catch {
        throw "Exception occured attempting to register the local vCloud Availability service with vCloud. Please check it is valid and try the cmdlet again. Exception is $_"
    }

    # Step 10. Set the Provider VDC scope if provided
    if($PSBoundParameters.ContainsKey("PVDCScope")){
        $ProviderVDCIds = @()
        foreach($ProviderVDCName in $PVDCScope){
            $ProviderVDCIds += (Get-vCAVProviderVDCs -Name $ProviderVDCName).id
        }
        # Normalise the collection
        $ProviderVDCIds = $ProviderVDCIds | Where-Object {$_}
        try{
            Set-vCAVProviderVDCFilters -ProvidedVDCIds $ProviderVDCIds > $null
        } catch {
            Write-Warning "An error occured attempting to set the Provider VDC filter for the installation, continuing with scope set to all Provider VDCs"
        }
    }

    # Step 11. Attempt to reboot the services after the site configuration is complete to refresh the configuration.
    try{
        Invoke-vCAVServicesReboot > $null
    } catch {
        Write-Warning "An error occured restarting the manager appliance services. This may cause the Site configuration to not apply correctly."
    }
    Disconnect-vCAVService
}