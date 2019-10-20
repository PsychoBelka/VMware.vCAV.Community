function Deploy-vCAVTunnel(){
    <#
    .SYNOPSIS
    This cmdlet deploys a vCloud Availability H4 Tunnel appliance to the currently connected vCenter Server and registers it with the provided vCloud Availabity installation.

    .DESCRIPTION
    This cmdlet deploys a vCloud Availability H4 Tunnel appliance to the currently connected vCenter Server and registers it with the provided vCloud Availabity Services in the installation.
    The steps taken are as follows:
    - The basic appliance is deployed and configured using the New-vCAVAppliance cmdlet
    - The vSphere Lookup Service is registered with the appliance
    - If provided, the self-certificate is replaced on the appliance with the one provided
    - The Tunnel Endpoint addressing is configured

    These steps must be executed manually after the tunnel has been deployed before it can be used:
    - The Cloud Manager is registered with the Tunnel
    - The Cloud Manager is restarted
    - All of the Replicators in the installation are restarted

    Note: Only IPv4 addressing is available using this command at this time.
    #>
    Param(
        [Parameter(Mandatory=$True)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [string] $vSphereLookupService,
        [Parameter(Mandatory=$True)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [string] $PublicEndpointAddress,
        [Parameter(Mandatory=$True)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [string] $InternalManagementAddress,
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
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [string] $NTPServers,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [string] $DNSServers,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [string] $DNSSearchPath,
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [string] $HostEntries,
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [string] $vNIC0_StaticRoutes,
        [Parameter(Mandatory=$False, ParameterSetName="NorthSouthNic")]
            [switch] $SecondaryNIC,
        [Parameter(Mandatory=$True, ParameterSetName="NorthSouthNic")]
            [ValidateNotNullorEmpty()] [string] $vNIC1_PortGroup,
        [Parameter(Mandatory=$True, ParameterSetName="NorthSouthNic")]
            [ValidateNotNullorEmpty()] [string] $vNIC1_IP,
        [Parameter(Mandatory=$True, ParameterSetName="NorthSouthNic")]
            [ValidateNotNullorEmpty()] [string] $vNIC1_Netmask,
        [Parameter(Mandatory=$True, ParameterSetName="NorthSouthNic")]
            [ValidateNotNullorEmpty()] [string] $vNIC0_BuildGateway,
        [Parameter(Mandatory=$False, ParameterSetName="NorthSouthNic")]
            [ValidateNotNullorEmpty()] [string] $vNIC1_StaticRoutes
    )
    # Step 1. Validate inputs
    if($PSBoundParameters.ContainsKey("PKCS12CertificateFile")){
    # Check if a password has been provided at least, this needs to be validated...eq $null?
        if($CertificateFileSecret -eq $null){
            throw "If the -PKCS12CertificateFile switch is provided you must provide a password for the file using the -CertfilcateFileSecret parameter"
        }
    }
    # Step 2. Deploy a vCloud Availability Tunnel  appliance from Image
    $TunnelAppliance = @{
        Component = "tunnel"
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
        $TunnelAppliance.Add("HostEntries",$HostEntries)
    }
    if($vNIC0_StaticRoutes.Length -ne 0){
        $TunnelAppliance.Add("vNIC0_StaticRoutes",$vNIC0_StaticRoutes)
    }
    # Check if a second NIC will specified
    if($PSBoundParameters.ContainsKey("SecondaryNIC")){
        $TunnelAppliance.Add("SecondaryNIC",$true)
        $TunnelAppliance.Add("vNIC1_PortGroup",$vNIC1_PortGroup)
        $TunnelAppliance.Add("vNIC1_IP",$vNIC1_IP)
        $TunnelAppliance.Add("vNIC0_BuildGateway",$vNIC0_BuildGateway)
        $TunnelAppliance.Add("vNIC1_Netmask",$vNIC1_Netmask)
        if($H4Tunnel.vNIC1_StaticRoutes.Length -ne 0){
            $TunnelAppliance.Add("vNIC1_StaticRoutes",$vNIC1_StaticRoutes)
        }
    }
    # Need to remove any values that are not set before calling the Splat to prevent $null values from being passed ?
    New-vCAVAppliance @TunnelAppliance

    # Step 3. Establish an API session with the vCloud Availability Tunnel Service
    $vCAVAPICred = New-Object System.Management.Automation.PSCredential ("root", $RootPassword)
    try{
        Connect-vCAVService -Server $vNIC0_IP -Port 443 -Credentials $vCAVAPICred -AuthProvider "Local"
    } catch {
        throw "Exception occured connecting to the vCloud Availability Tunnel service. Exception is $_"
    }
    # Step 3.1 Register the vSphere Lookup Service
    try{
        Set-vCAVResourcevCenterLookupService -LookupServiceURI $vSphereLookupService > $null
    } catch {
        throw "An error occured attempting to set the vSphere SSO Lookup Service for the appliance. Exception is $_"
    }
    # Step 4. Replace the TLS Certificates
    if($PSBoundParameters.ContainsKey("PKCS12CertificateFile")){
        # Call the API to replace the certificates on the appliance with the provided certificates
        try{
            Install-vCAVCertificate -Certificate $PKCS12CertificateFile -CertificateFileSecret $CertificateFileSecret -Force $true > $null
        } catch {
            throw "An error has occurred attempting to change the certificates on the appliance. The Exception is $_"
        }
    }
    # Disconnect from the Tunnel API Service
    Disconnect-vCAVService

    # Step 4. Configure the Tunnel Endpoint addresses
    $vCAVAPICred = New-Object System.Management.Automation.PSCredential ("root", $RootPassword)
    try{
        Connect-vCAVService -Server $vNIC0_IP -Port 443 -Credentials $vCAVAPICred -AuthProvider "Local"
    } catch {
        throw "Exception occured connecting to the vCloud Availability Tunnel service. Exception is $_"
    }
    Disconnect-vCAVService
}