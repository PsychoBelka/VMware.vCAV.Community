function New-vCAVTenantPolicy(){
    <#
    .SYNOPSIS
    Creates a new vCloud Availability Tenant Policy on the connected vCloud Availability service.

    .DESCRIPTION
    Creates a new vCloud Availability Tenant Policy on the connected vCloud Availability service.

    .PARAMETER Name
    The display name for the policy

    .PARAMETER MinRPOMinutes
    The minimum recovery point objective (RPO) in minutes for the policy.
    Default is 5 minutes.
    Minimum is 5 minutes.
    Maximum is 1440 minutes (24 hours).

    .PARAMETER MaximumSnapshotsPerVMs
    The Maximum number of Multiple Point-in-time (MPIT) recovery points (snapshots) that are allowed to be configured for a protected instance.
    Default is 24
    Maximum is 24
    Minimum is 1

    .PARAMETER MaximumReplicatedVMs
    The maximum number of VMs that can be protected by the tenant organisation.
    Default is 10
    For unlimitted set to -1

    .PARAMETER AllowInboundReplication
    If $true sets the tenant policy to allow Inbound replication to the local cloud site. (e.g. allows replication from on-premise to vCloud or from a remote vCloud deploymnet inbound to the local vCloud site).

    .PARAMETER AllowOutboundReplication
    If $true sets the tenant policy to allow Outbound replication from the local cloud site. (e.g. allows replication from Cloud site to a remote on-premise vSphere environment or a remote vCloud site).

    .EXAMPLE
    New-vCAVTenantPolicy -name "Test-Automtion" -MinRPOMinutes 90 -MaximumSnapshotsPerVMs 5
    Creates a new vCloud Availability tenant policy on the currently connected service named "Test-Automation" with a minimum RPO of 90 minutes and a maximum number of 5 MPIT (Multiple-Point-in-Time) recovery points. The policy will also allow for inbound and outbound replication and have a maximum number of protected VMs of 10 (as per the cmdlet defaults).

    .EXAMPLE
    New-vCAVTenantPolicy -name "Gold" -MinRPOMinutes 5 -MaximumSnapshotsPerVMs 24 -MaximumReplicatedVms -1
    Creates a new vCloud Availability tenant policy on the currently connected service named "Gold" with a minimum RPO of 5 minutes and a maximum number of 24 MPIT (Multiple-Point-in-Time) recovery points and allows the tenant to protect an unlimmited number of VMs/vApps. The policy will also allow for inbound and outbound replication (as per the cmdlet defaults).


    .EXAMPLE
    New-vCAVTenantPolicy -name "Bronze" -MinRPOMinutes 1440 -MaximumSnapshotsPerVMs 5 -MaximumReplicatedVms -1 -AllowOutboundReplication $false
    Creates a new vCloud Availability tenant policy on the currently connected service named "Bronze" with a minimum RPO of 1440 minutes (24 hours) and a maximum number of 5 MPIT (Multiple-Point-in-Time) recovery points and allows the tenant to protect an unlimmited number of VMs/vApps. The policy will only allow inbound replication and will deny outbound replicaiton.

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 2.0
    #>
    Param(
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [String] $Name,
        [Parameter(Mandatory=$False)]
            [ValidateRange(5,1440)] [int] $MinRPOMinutes=5,
        [Parameter(Mandatory=$False)]
            [ValidateRange(1,24)] [int] $MaximumSnapshotsPerVMs=24,
        [Parameter(Mandatory=$False)]
            [ValidateRange(-1,[int]::MaxValue)] [int] $MaximumReplicatedVMs=10,
        [Parameter(Mandatory=$False)]
            [bool] $AllowInboundReplication = $true,
        [Parameter(Mandatory=$False)]
            [bool] $AllowOutboundReplication = $true
    )
    # Create the JSON payload and post to the config URI
    $URI = $global:DefaultvCAVServer.ServiceURI + "policies"
    $objTenantPolicy = New-Object System.Management.Automation.PSObject
    $objTenantPolicy | Add-Member Note* displayName $Name
    $objTenantPolicy | Add-Member Note* minRpo $MinRPOMinutes
    $objTenantPolicy | Add-Member Note* maxInstances $MaximumSnapshotsPerVMs
    $objTenantPolicy | Add-Member Note* maxIncoming $MaximumReplicatedVMs
    $objTenantPolicy | Add-Member Note* allowIncoming $AllowInboundReplication
    $objTenantPolicy | Add-Member Note* allowOutgoing $AllowOutboundReplication

    $RequestResponse = Invoke-vCAVAPIRequest -URI $URI -Data (ConvertTo-JSON $objTenantPolicy) -Method Post 
    $RequestResponse.JSONData
}