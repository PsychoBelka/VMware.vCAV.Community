function Set-vCAVTenantPolicy(){
    <#
    .SYNOPSIS
    Adjusts the settings for an existing vCloud Availability Tenant Policy on the connected vCloud Availability service.

    .DESCRIPTION
    Adjusts the settings for an existing vCloud Availability Tenant Policy on the connected vCloud Availability service.

    .PARAMETER Name
    The Display Name of the policy to amend

    .PARAMETER Id
    The Policy Id of the policy to amend

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
    Set-vCAVTenantPolicy -Id "default" -MinRPOMinutes 20 -MaximumSnapshotsPerVMs 15
    Sets the minimum MPO for the policy to 20 minutes and the maximum Multiple Point-in-time (MPIT) recovery points to 15 for the default policy.

    .EXAMPLE
    Set-vCAVTenantPolicy -Id "e4a4fdf8-c6fc-4f80-a186-1bb4e99ff291" -MaximumReplicatedVMs -1
    Sets the maximum number of incoming VMs replications for policy with Id "e4a4fdf8-c6fc-4f80-a186-1bb4e99ff291" to unlimited.

    .EXAMPLE
    Set-vCAVTenantPolicy -Name "Test Policy" -MaximumSnapshotsPerVMs 1
    Sets the Maximum number of Multiple Point-in-time (MPIT) recovery points for the policy with the name "Test Policy" to 1.

    .EXAMPLE
    Set-vCAVTenantPolicy -Name "Test Policy" -MaximumSnapshotsPerVMs 10 -MaximumReplicatedVMs 6 -AllowOutboundReplication $false
    Sets the Maximum number of Multiple Point-in-time (MPIT) recovery points for the policy with the name "Test Policy" to 10, the maximum number of replicated VMs to 6 and disables Outbound replication.

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-07-19
	VERSION: 3.0
    #>
    [CmdletBinding(DefaultParameterSetName="ById")]
    Param(
        [Parameter(Mandatory=$False, ParameterSetName = "ByName")]
            [ValidateNotNullorEmpty()] [String] $Name,
        [Parameter(Mandatory=$False, ParameterSetName = "ById")]
            [ValidateNotNullorEmpty()] [String] $Id,
        [Parameter(Mandatory=$False)]
            [ValidateRange(5,1440)] [int] $MinRPOMinutes,
        [Parameter(Mandatory=$False)]
            [ValidateRange(1,24)] [int] $MaximumSnapshotsPerVMs,
        [Parameter(Mandatory=$False)]
            [ValidateRange(-1,[int]::MaxValue)]  [int] $MaximumReplicatedVMs,
        [Parameter(Mandatory=$False)]
            [bool] $AllowInboundReplication,
        [Parameter(Mandatory=$False)]
            [bool] $AllowOutboundReplication
    )
    # First test if the policy exists
    if($PSCmdlet.ParameterSetName -eq "ByName"){
        $objPolicy = Get-vCAVTenantPolicy -Name $Name
    }
    if($PSCmdlet.ParameterSetName -eq "ById"){
        $objPolicy = Get-vCAVTenantPolicy -Id $Id
    }
    if($null -eq $objPolicy){
        throw "A Policy with the provided Name or Id is not currently configured. Please check the values provided and try again."
    }
    # Create the JSON payload and post to the config URI
    $URI = $global:DefaultvCAVServer.ServiceURI + "policies/" + $objPolicy.Id
    $objTenantPolicy = New-Object System.Management.Automation.PSObject
    $objTenantPolicy | Add-Member Note* displayName $objPolicy.displayName
    # Next check which paramters should be updated based on the provided inputs
    if($PSBoundParameters.ContainsKey("MinRPOMinutes")){
        $objTenantPolicy | Add-Member Note* minRpo $MinRPOMinutes
    } else {
        $objTenantPolicy | Add-Member Note* minRpo $objPolicy.minRpo
    }
    if($PSBoundParameters.ContainsKey("MaximumSnapshotsPerVMs")){
        $objTenantPolicy | Add-Member Note* maxInstances $MaximumSnapshotsPerVMs
    } else {
        $objTenantPolicy | Add-Member Note* maxInstances $objPolicy.maxInstances
    }
    if($PSBoundParameters.ContainsKey("MaximumReplicatedVMs")){
        $objTenantPolicy | Add-Member Note* maxIncoming $MaximumReplicatedVMs
    } else {
        $objTenantPolicy | Add-Member Note* maxIncoming $objPolicy.maxIncoming
    }
    if($PSBoundParameters.ContainsKey("AllowInboundReplication")){
        $objTenantPolicy | Add-Member Note* allowIncoming $AllowInboundReplication
    } else {
        $objTenantPolicy | Add-Member Note* allowIncoming $objPolicy.allowIncoming
    }
    if($PSBoundParameters.ContainsKey("AllowOutboundReplication")){
        $objTenantPolicy | Add-Member Note* allowOutgoing $AllowOutboundReplication
    } else {
        $objTenantPolicy | Add-Member Note* allowOutgoing $objPolicy.allowOutgoing
    }
    # Make the call to update the policy
    $RequestResponse = Invoke-vCAVAPIRequest -URI $URI -Data (ConvertTo-JSON $objTenantPolicy) -Method Put -APIVersion $DefaultvCAVServer.DefaultAPIVersion
    $RequestResponse.JSONData
}