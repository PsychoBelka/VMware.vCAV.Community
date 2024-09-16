function New-vCAVAppliance(){
    <#
    .SYNOPSIS
    This cmdlet deploys a vCloud Availability componet to the currently connected vCenter Server and configures the basic networking.

    .DESCRIPTION
    The cmdlet deploys the vCloud Availability OVA and configures the basic settings for the appliance (regardless of the deployment type).
    The steps taken are as follows:
    - Set the parameters for the OVA
    - Validate the provided vSphere objects
    - Deploy the appliance and Power On
    - Optionally add an additional northbound adapter (for Tunnel DMZ if required)
    - Set the root password (after first boot) and hostname of the appliance
    - Configure any static routing or host file entires

    Note: Only IPv4 addressing is available using this command at this time.
    The vNIC0 IP address must be routable from the machine executing this cmdlet.

    .PARAMETER Component
    The vCloud Availability component type to deploy.
    Valid: "cloud","replicator","tunnel"

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

    .PARAMETER SSHEnabled
    Specifies if the SSH daemon should be enabled. This can be set via the API after deployment also.

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

    .PARAMETER DNSSearchPath
    The DNS Search Path for the to configure for the appliance

    .EXAMPLE
    New-vCAVAppliance @ApplianceConfig
    Deploys a new appliance to the connected vCenter Server by splatting the configuration in the hashtable ApplianceConfig. Deploys the appliance and configures the base networking.

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 1.0
    #>
    Param(
        [Parameter(Mandatory=$True, ParameterSetName="Default")]
        [Parameter(Mandatory=$True, ParameterSetName="NorthSouthNic")]
            [ValidateSet("cloud","replicator","tunnel")]  [string] $Component,
            [ValidateNotNullorEmpty()] [string] $OVAImage,
            [ValidateNotNullorEmpty()] [string] $Cluster,
            [ValidateNotNullorEmpty()] [string] $VMFolder,
            [ValidateNotNullorEmpty()] [string] $VMName,
        [Parameter(Mandatory=$False, ParameterSetName="Default")]
        [Parameter(Mandatory=$False, ParameterSetName="NorthSouthNic")]
            [ValidateSet("DatastoreCluster","Datastore")]  [string] $StorageType="Datastore",
        [Parameter(Mandatory=$True, ParameterSetName="Default")]
        [Parameter(Mandatory=$True, ParameterSetName="NorthSouthNic")]
            [ValidateNotNullorEmpty()] [string] $Datastore,
            [ValidateNotNullorEmpty()] [SecureString] $RootPassword,
            [ValidateNotNullorEmpty()] [string] $vNIC0_PortGroup,
            [ValidateNotNullorEmpty()] [string] $vNIC0_IP,
            [ValidateNotNullorEmpty()] [string] $vNIC0_Netmask,
            [ValidateNotNullorEmpty()] [string] $DefaultGatewayIP,
            [ValidateNotNullorEmpty()] [string] $HostName,
            [ValidateNotNullorEmpty()] [string] $NTPServers,
            [ValidateNotNullorEmpty()] [string] $DNSServers,
            [ValidateNotNullorEmpty()] [string] $DNSSearchPath,
            [ValidateNotNullorEmpty()] [bool] $SSHEnabled,
        [Parameter(Mandatory=$False, ParameterSetName="Default")]
        [Parameter(Mandatory=$False, ParameterSetName="NorthSouthNic")]
            [ValidateNotNullorEmpty()] [string] $HostEntries,
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
    # First check if vCenter is connected and if not prompt for details
    if(!($Global:DefaultVIServer.IsConnected)){
        try{
            Connect-VIServer -Server (Read-Host -Prompt "Enter the Management vCenter Server address to deploy the new appliance")
        } catch {
            throw "An error occured connecting to the Management vCenter, not continuing with Execution. Exception: $_"
        }
    }
    # Set the required values for the deploy the OVA to vSphere
    try{
        $targetCluster = Get-Cluster -Name $Cluster
    } catch {
        throw "An error occured attempting to retrieve the vSphere Cluster $Cluster. Exception: $_"
    }
    try{
        $targetVMHost = (Get-VMHost -Location $targetCluster -State "Connected")[0]
    } catch {
        throw "An error occured attempting to retrieve a connected vSphere Host in cluster $Cluster. Exception: $_"
    }
    try{
        $targetFolder = Get-Folder -Name $VMFolder
    } catch {
        throw "An error occured attempting to retrieve the vSphere Folder $VMFolder. Exception: $_"
    }
    try{
        if($StorageType -eq "DatastoreCluster"){
            $targetDatastore = Get-DatastoreCluster -Name $Datastore
        } else {
            $targetDatastore = Get-Datastore -Name $Datastore
        }
    } catch {
        throw "An error occured attempting to retrieve the vSphere storage object $Datastore. Exception: $_"
    }
    # Load the OVA and set the variables for vCAV
    try {
        $ComponentOVA = Get-OvfConfiguration -Ovf $OVAImage
    } catch {
        throw "An error occured reading the OVA file $OVAImage. The following Exception was thrown $_"
    }
    # Set the main networking elements
    $ComponentOVA.Common.guestinfo.cis.appliance.root.password.Value = "Password!123" # This is a temp password, it needs to be set here to overcome plain-text password transmission by OVF deploy
    # Appears that the SSHEnabled flag is ignored
    if($SSHEnabled){
        $ComponentOVA.Common.guestinfo.cis.appliance.ssh.enabled.Value = "True"
    } else {
        $ComponentOVA.Common.guestinfo.cis.appliance.ssh.enabled.Value = "False"
    }
    $ComponentOVA.DeploymentOption.Value = $Component
    $ComponentOVA.vami.VMware_vCloud_Availability.domain.Value = $HostName
    $ComponentOVA.vami.VMware_vCloud_Availability.DNS.Value = $DNSServers
    $ComponentOVA.vami.VMware_vCloud_Availability.searchpath.Value = $DNSSearchPath
    $ComponentOVA.IpAssignment.IpProtocol.Value = "IPv4"
    if($PSBoundParameters.ContainsKey("NTPServers")){
        $ComponentOVA.Common.guestinfo.cis.appliance.net.ntp.Value = $NTPServers
    }
    # Set the Network addresses for vNIC0
    $ComponentOVA.NetworkMapping.VM_Network.Value = $vNIC0_PortGroup
    $ComponentOVA.vami.VMware_vCloud_Availability.ip0.Value = $vNIC0_IP
    $ComponentOVA.vami.VMware_vCloud_Availability.netmask0.Value = $vNIC0_Netmask
    # Now customise depending on if a Second NIC is added or not
    if($PSBoundParameters.ContainsKey("SecondaryNIC")){
        # If multi-NIC configuration is to be used (e.g. DMZ dual-homed for the tunnel) a temporary default gateway on the Management Network interface for inital configuration
        $ComponentOVA.vami.VMware_vCloud_Availability.gateway.Value = $vNIC0_BuildGateway
    } else {
        # Only one NIC set the default gateway to be NIC0
        $ComponentOVA.vami.VMware_vCloud_Availability.gateway.Value = $DefaultGatewayIP
    }
    # Deploy the OVA Component
    try{
        $result = $targetVMHost | Import-VApp $OVAImage -Name $VMName -OvfConfiguration $ComponentOVA -Datastore $targetDatastore -DiskStorageFormat "Thin" -InventoryLocation $targetfolder
    } catch {
        throw "Deployment of the the OVA to vSphere has failed. The following exception was thrown $_"
    }
    # Check if a second Network Adapter is required for the component, add the adapter to the appliance
    if($PSBoundParameters.ContainsKey("SecondaryNIC")){
        try {
            $DVPortGroup = Get-VDPortgroup -Name $vNIC1_PortGroup
            $result = New-NetworkAdapter -VM $VMName -Portgroup $DVPortGroup -StartConnected -Type "Vmxnet3"
        } catch {
            throw "An error occured adding additional NIC to $VMName. The following exception was thrown $_"
        }
    }
    # Now Power On the VM and Wait for the Tools Service to Start
    try{
        $result = Start-VM -VM $VMName
    } catch {
        throw "An error occured Powering On VM $VMName. The following exception was thrown $_"
    }
    Write-Information -Message "Waiting for the VMWare Tools Service and application services to start after inital Power On. This may take up to 5 minutes."
    $result = Wait-Tools -VM $VMName -TimeoutSeconds 300
    Start-Sleep -Seconds 45

    # Connect to the appliance via the API and set basic parameters (root password and the hostname for the appliance)
    $APIPassword = ConvertTo-SecureString "Password!123" -AsPlainText -Force
    $APICred = New-Object System.Management.Automation.PSCredential ("root", $APIPassword)
    $ApplianceCredentials = New-Object System.Management.Automation.PSCredential ("root", $RootPassword)
    try{
        Connect-vCAVService -Server $vNIC0_IP -Port 443 -Credentials $APICred -AuthProvider "Local"
        # Create a PSCredential for the New Password
        $result = Set-vCAVApplianceRootPassword -OldPassword "Password!123" -NewPassword ($ApplianceCredentials.GetNetworkCredential().Password)
        $result = Set-VCAVApplianceHostname -Hostname $HostName
    } catch {
        throw "An error occurred conencting to the vCAV API Service to reset the root password and Hostname. Exception was thrown $_"
    }
    # Disconnect from the service
    Disconnect-vCAVService

    # Prepare custom network configuration scripts (/etc/hosts)
    if($PSBoundParameters.ContainsKey("HostEntries")){
        try{
            $hostFileConfig = "cat << 'EOF' >> /etc/hosts`n$($HostEntries.Replace("\n","`n"))`nEOF`n"
            $result = Invoke-VMScript -VM $VMName -ScriptText $hostFileConfig -GuestUser "root" -GuestPassword ($ApplianceCredentials.GetNetworkCredential().Password) -ScriptType "Bash"
        } catch {
            throw "$_"
        }
    }
    # Configure the Second adapter (Public) for Northbound traffic as default route if required
    # If a second NIC exists; Remove the gateway used to configure during build from /etc/systemd/network/10-eth0.network and configure the adapter
    if($PSBoundParameters.ContainsKey("SecondaryNIC")){
        [string] $strNetConfigScript = "" # Initalise
        # Network configuration must be manually re-written due to a limitation with /opt/vmware/share/vami/vami_set_network cmd which does not allow an address to be set without an IPv4 gateway
        [string] $strNetConfigScript += "sed '/^Gateway=/ d' /etc/systemd/network/10-eth0.network > /tmp/10-eth0.network`n"
        [string] $strNetConfigScript += "cp /tmp/10-eth0.network /etc/systemd/network/10-eth0.network`n"
        [string] $strNetConfigScript += "/opt/vmware/share/vami/vami_set_network eth1 STATICV4 $($vNIC1_IP) $($vNIC1_Netmask) $($DefaultGatewayIP)`n"
    }
    # Add any static routing required to the Network configuration files
    if($PSBoundParameters.ContainsKey("vNIC0_StaticRoutes")){
        [string] $strNetConfigScript += "cat << 'EOF' >> /etc/systemd/network/10-eth0.network`n$($vNIC0_StaticRoutes.Replace("\n","`n"))`nEOF`n"
    }
    if($PSBoundParameters.ContainsKey("vNIC1_StaticRoutes")){
        [string] $strNetConfigScript += "cat << 'EOF' >> /etc/systemd/network/10-eth1.network`n$($vNIC1_StaticRoutes.Replace("\n","`n"))`nEOF`n"
    }
    $strNetConfigScript += "`nsystemctl restart systemd-networkd`n"

    # Execute using VMWare Tools to inject the script to the guest
    try{
        $result = Invoke-VMScript -VM $VMName -ScriptText $strNetConfigScript -GuestUser "root" -GuestPassword ($ApplianceCredentials.GetNetworkCredential().Password) -ScriptType "Bash"
    } catch {
        throw "An error occured during customisation of network configuration Exception: $_"
    }
    # Return something
    $true
}