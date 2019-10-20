function Deploy-vCAVReplicator(){
    <#
    .SYNOPSIS
    This cmdlet deploys a vCloud Availability Replicator to the currently connected vCenter Server and registers it with the provided vCloud Availabity Replication Manager.

    .DESCRIPTION
    This cmdlet deploys a vCloud Availability Replicator to the currently connected vCenter Server and registers it with the provided vCloud Availabity Replication Manager.
    The steps taken are as follows:
    - The basic appliance is deployed and configured using the New-vCAVAppliance cmdlet
    - The vSphere Lookup Service is registered with the appliance
    - If provided, the self-certificate is replaced on the appliance with the one provided
    - The Replicator is registered with the local vCloud Availability Replicator

    Note: Only IPv4 addressing is available using this command at this time.

    .PARAMETER vSphereLookupService
    The URI of the vSphere Lookup Service for the vCloud Resource vCenter hosting the VMs the Replicator will replicate

    .PARAMETER vSphereAPICredentials
    Credentials for the vCloud Resource vCenter. This account should have vi-admin rights to the vCenter specified in the Lookup Service parameter.

    .PARAMETER ReplicationManager
    The IP or FQDN of the vCAV Replication Manager to pair the replicator to

    .PARAMETER ManagerPassword
    Root Password for the vCAV Replication Manager

    .PARAMETER PKCS12CertificateFile
    Path to the PKCS12 certificate store which contains the certificate to install of the Replicator.

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
	LASTEDIT: 2019-06-14
	VERSION: 1.0
    #>
    Param(
        [Parameter(Mandatory=$True)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [string] $vSphereLookupService,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [PSCredential] $vSphereAPICredentials,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [string] $ReplicationManager,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [SecureString] $ManagerPassword,
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
    # Step 2. Deploy a vCloud Availability Replicator appliance from Image
    $ReplicatorAppliance = @{
        Component = "replicator"
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
        $ReplicatorAppliance.Add("HostEntries",$HostEntries)
    }
    if($vNIC0_StaticRoutes.Length -ne 0){
        $ReplicatorAppliance.Add("vNIC0_StaticRoutes",$vNIC0_StaticRoutes)
    }

    # Need to remove any values that are not set before calling the Splat to prevent $null values from being passed ?
    New-vCAVAppliance @ReplicatorAppliance
    # Step 3. Establish an API session with the vCloud Availability Replicator
    $ReplicatorAPICred = New-Object System.Management.Automation.PSCredential ("root", $RootPassword)
    try{
        Connect-vCAVService -Server $vNIC0_IP -Credentials $ReplicatorAPICred -AuthProvider "Local"
    } catch {
        throw "Exception occured connecting to the vCloud Replicator. Exception is $_"
    }
    # Step 3.1 Register the vSphere Lookup Service
    try{
        $result = Set-vCAVResourcevCenterLookupService -LookupServiceURI $vSphereLookupService
    } catch {
        throw "An error occured attempting to set the vSphere SSO Lookup Service for the appliance. Exception is $_"
    }
    # Step 4. Replace the TLS Certificates
    if($PSBoundParameters.ContainsKey("PKCS12CertificateFile")){
        # Call the API to replace the certificates on the appliance with the provided certificates
        try{
            $result = Install-vCAVCertificate -Certificate $PKCS12CertificateFile -CertificateFileSecret $CertificateFileSecret -Force $true
        } catch {
            throw "An error has occurred attempting to change the certificates on the appliance. The Exception is $_"
        }
    }
    # Disconnect from the Replicator API Service
    Disconnect-vCAVService

    # Step 4. Connect to the API Service of the vCAV Replication Manager
    $ManagerAPICred = New-Object System.Management.Automation.PSCredential ("root", $ManagerPassword)
    try{
        Connect-vCAVService -Server $ReplicationManager -Credentials $ManagerAPICred -AuthProvider "Local" -Port 8044
    } catch {
        throw "Exception occured connecting to the vCloud Availability Replication Manager. Exception is $_"
    }
    # Step 4. Register the Replictor with the VCAV Replication Manager
    $ReplicatorAPIURI = "https://$($vNIC0_IP):8043"
    try{
        $Site = Get-vCAVSites
        $result = Register-vCAVReplicator -SiteName $Site -ReplicatorAPIURI $ReplicatorAPIURI -ReplicatorPassword $RootPassword -vSphereAPICredentials $vSphereAPICredentials
    } catch {
        throw $_
    }
    # Finally disconnect
    Disconnect-vCAVService
}