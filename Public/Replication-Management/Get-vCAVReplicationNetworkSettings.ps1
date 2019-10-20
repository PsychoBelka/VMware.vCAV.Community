function Get-vCAVReplicationNetworkSettings(){
    <#
    .SYNOPSIS
    Return the Network Settings for a configured VM or vApp-level Replications from the currently connected vCloud Availability service.

    .DESCRIPTION
    Return the Network Settings for a configured VM or vApp-level Replications from the currently connected vCloud Availability service.

    .PARAMETER VM
    Switch to indicate the Replication is of type "VM Replication"

    .PARAMETER vApp
    Switch to indicate the Replication is of type "vApp Replication"

    .PARAMETER vAppName
    The vApp Name of the Replication to query

    .PARAMETER VMName
    The VM Name of the Replication to query

    .PARAMETER ReplicationId
    The vCloud Availability C4 vApp/VM replication IDs

    .EXAMPLE
    Get-vCAVReplicationNetworkSettings -ReplicationId C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d
    Returns the Replication Network Settings for the vApp Replication with the Id C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d

    .EXAMPLE
    Get-vCAVReplicationNetworkSettings -VM -VMName "TEST2"
    Returns the Replication Network Settings for the VM Replication with the VM Name "Test2"

    .EXAMPLE
    Get-vCAVReplicationNetworkSettings -vApp -vAppName "Test-2VMs"
    Returns the Replication Network Settings for the vApp Replication with the vApp Name "Test-2VMs"

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-05-27
	VERSION: 1.0
    #>
    [CmdletBinding(DefaultParameterSetName="vApp")]
    Param(
        [Parameter(Mandatory=$False, ParameterSetName="VM")]
            [switch]$VM,
        [Parameter(Mandatory=$False, ParameterSetName="vApp")]
            [switch]$vApp,
        [Parameter(Mandatory=$False, ParameterSetName="vApp")]
            [ValidateNotNullorEmpty()] [String] $vAppName,
        [Parameter(Mandatory=$False, ParameterSetName="VM")]
            [ValidateNotNullorEmpty()] [String] $VMName,
        [Parameter(Mandatory=$False, ParameterSetName="VM")]
        [Parameter(Mandatory=$False, ParameterSetName="vApp")]
            [ValidateNotNullorEmpty()] [String] $ReplicationId
    )
    # Build a Hashtable for splatting to the Get-vCAVReplications
    if($PSCmdlet.ParameterSetName -eq "vApp"){
        $ReplicatorSpecification = @{
            vApp = $vApp
        }
        if($PSBoundParameters.ContainsKey("ReplicationId")){
            $ReplicatorSpecification.Add("ReplicationId",$ReplicationId)
        } else {
            $ReplicatorSpecification.Add("vAppName",$vAppName)
        }
        $URI = $global:DefaultvCAVServer.ServiceURI + "vapp-replications"
    }
    if($PSCmdlet.ParameterSetName -eq "VM"){
        $ReplicatorSpecification = @{
            VM = $VM
        }
        if($PSBoundParameters.ContainsKey("ReplicationId")){
            $ReplicatorSpecification.Add("ReplicationId",$ReplicationId)
        } else {
            $ReplicatorSpecification.Add("VMName",$VMName)
        }
        $URI = $global:DefaultvCAVServer.ServiceURI + "vm-replications"
    }
    # Check if the vApp/VM Replication exists
    $ReplicationObject = Get-vCAVReplications @ReplicatorSpecification
    if($ReplicationObject.Count -eq 0){
        throw "A Replication with the provided specification can not be found. Please check the parameters and retry."
    }
    # Build the URI to the API
    $URI += "/$($ReplicationObject.id)/network-settings"
    $colReplicationNetwork = (Invoke-vCAVAPIRequest -URI $URI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
    $colReplicationNetwork
}