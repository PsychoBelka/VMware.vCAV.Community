function Remove-vCAVReplication(){
    <#
    .SYNOPSIS
    Removes a configured VM or vApp-level Replications from the currently connected vCloud Availability service.

    .DESCRIPTION
    Removes a configured VM or vApp-level Replications from the currently connected vCloud Availability service.

    Returns the vCloud Availability Task object for the operation.

    .PARAMETER VM
    Switch to use to remove a VM Replication

    .PARAMETER vApp
    Switch to use to remove a vApp Replication

    .PARAMETER ReplicationId
    The Id of the Replication object in the vCloud Availability installation

    .PARAMETER Async
    Indicates that the command returns immediately without waiting for the task to complete. In this mode, the output of the cmdlet is a Task object.

    .EXAMPLE
    Remove-vCAVReplication -vApp -ReplicationId "C4VAPP-26b6d9eb-61f9-4808-a3b0-32c9089c361b"
    Removes the Replication Protection for the vApp with the Id C4VAPP-26b6d9eb-61f9-4808-a3b0-32c9089c361b

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-07-19
	VERSION: 2.0
    #>
    [CmdletBinding(DefaultParameterSetName="vApp")]
    Param(
        [Parameter(Mandatory=$False, ParameterSetName="VM")]
            [switch]$VM,
        [Parameter(Mandatory=$False, ParameterSetName="vApp")]
            [switch]$vApp,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [String] $ReplicationId,
        [Parameter(Mandatory = $False)]
            [switch]$Async
    )
    if($PSCmdlet.ParameterSetName -eq "vApp"){
        $Replication = Get-vCAVReplications -vApp -ReplicationId $ReplicationId
        if($Replication.Count -eq 0){
            throw "A vApp Replication with the Replication Id $ReplicationId can not be found in the installation."
        } else {
            $URI = $global:DefaultvCAVServer.ServiceURI + "vapp-replications/$ReplicationId"
        }
    } elseif($PSCmdlet.ParameterSetName -eq "VM"){
        $Replication = Get-vCAVReplications -VM -ReplicationId $ReplicationId
        if($Replication.Count -eq 0){
            throw "A VM Replication with the Replication Id $ReplicationId can not be found in the installation."
        } else {
            $URI = $global:DefaultvCAVServer.ServiceURI + "vm-replications/$ReplicationId"
        }
    }
    try{
        # Make the API call to execute the vCAV Operation
        $ReplicationRemoveTask = (Invoke-vCAVAPIRequest -URI $URI -Method Delete -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
        if(!$PSBoundParameters.ContainsKey("Async")){
            Watch-TaskCompleted -Task $ReplicationRemoveTask -Timeout ((Get-PowerCLIConfiguration -Scope Session).WebOperationTimeoutSeconds) > $null
        }
        Get-vCAVTasks -Id $ReplicationRemoveTask.id
    } catch {
        throw "An unexpected error occured during the Remove-vCAVReplication operation."
    }
}
