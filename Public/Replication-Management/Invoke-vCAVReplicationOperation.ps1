function Invoke-vCAVReplicationOperation(){
    <#
    .SYNOPSIS
    Invokes the specified vCloud Availability operation against a currently configured VM or vApp Replication on the currently connected vCloud Availability service.

    .DESCRIPTION
    Invokes the specified vCloud Availability operation against a currently configured VM or vApp Replication on the currently connected vCloud Availability service.

    This cmdlet currently only provides a very basic implementation of vCloud Availability functions and focuses on the vCloud-side Operations only. Further development is required for full support.

    .PARAMETER ReplicationType
    vApp or VM Replication

    .PARAMETER Async
    Indicates that the command returns immediately without waiting for the task to complete. In this mode, the output of the cmdlet is a Task object.

    .PARAMETER ReplicationId
    The vCloud Availability C4 vApp/VM replication ID

    .PARAMETER Failover
    Peforms a Failover of the selected vApp/VM to the latest recovery instance. Currently this cmdlet only supports failover to the latest available instance.

    .PARAMETER Migrate
    Peforms a Migration of the selected vApp/VM.

    .PARAMETER Test
    Peforms a Test Failover of the selected vApp/VM to the specified recovery instance. Currently this cmdlet only supports test failover to the latest available instance.

    .PARAMETER TestCleanup
    Removes the Test Image created by a "Test Failover" from the recovery destination. Currently this cmdlet only supports test failover to the latest available instance.

    .PARAMETER PauseReplication
    Pauses the selected replication. Paused replications will not send data to the destination and may not meet their RPO settings.

    .PARAMETER ResumeReplication
    Resumes a paused replication. The resumed replications will start sending data to the destination and may temporarily cause higher network traffic.

    .PARAMETER ReverseReplication
    Executes reverse for all the vApp's child VM replications. The VM replications that are being reversed need to be recovered (using failover/planned migration). The disks of the original source VMs will be used as seeds. The original source VMs will be removed. The original source Vapp will be powered off and left behind (with no vms in it eventually).

    .PARAMETER Sync
    Executes a manual creation of an instance for the selected replications. This will reschedule the next automatic instance with regard to the RPO settings.

    .PARAMETER PowerOn
    Whether to Power On the vApp/VM after the operation.

    .PARAMETER Consolidate
    Turning on this option will consolidate all instances into the recovered disk. This can improve the runtime performance of the recovered VM, but may greatly increase RTO.

    .PARAMETER UseDefaultNetworking
    If true the operation will apply preconfigured network settings; otherwise the OrgVDCNetwork provided will be set.

    .PARAMETER OrgVDCNetwork
    The OrgVDCNetwork to connect if UseDefaultNetworking is set as false. If no OrgVDCNetwork is provided the failover will be performed with the networks disconnected.

    .PARAMETER SyncBeforeTest
    If set to $true before the Test Failover a new instance of the replication will be created.

    .EXAMPLE
    Invoke-vCAVReplicationOperation -ReplicationType "vApp" -ReplicationId C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d -PauseReplication
    Pauses the vApp Replication with the vApp Replication Id of "C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d"

    .EXAMPLE
    Invoke-vCAVReplicationOperation -ReplicationType VM -ReplicationId C4-1909c491-b445-4ee1-9c09-cff64e1d29ba -PauseReplication
    Pauses the VM Replication with the VM Replication Id of "C4-1909c491-b445-4ee1-9c09-cff64e1d29ba"

    .EXAMPLE
    Invoke-vCAVReplicationOperation -ReplicationType "vApp" -ReplicationId C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d -Sync
    Performs a manual Sync of the vApp Replication with the vApp Replication Id of "C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d"

    .EXAMPLE
    Invoke-vCAVReplicationOperation -ReplicationType VM -ReplicationId C4-1909c491-b445-4ee1-9c09-cff64e1d29ba -Sync
    Performs a manual Sync of the VM Replication with the VM Replication Id of "C4-1909c491-b445-4ee1-9c09-cff64e1d29ba"

    .EXAMPLE
    Invoke-vCAVReplicationOperation -ReplicationType "vApp" -ReplicationId C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d -ResumeReplication -Async
    Performs a Resume Replication operation on the vApp Replication with the vApp Replication Id of "C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d" and returns the Task; runs asynchronously

    .EXAMPLE
    Invoke-vCAVReplicationOperation -ReplicationType VM -ReplicationId C4-1909c491-b445-4ee1-9c09-cff64e1d29ba -ResumeReplication
    Performs a Resume Replication operation on the VM Replication with the VM Replication Id of "C4-1909c491-b445-4ee1-9c09-cff64e1d29ba"

    .EXAMPLE
    Invoke-vCAVReplicationOperation -ReplicationType "vApp" -ReplicationId C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d -TestCleanUp
    Removes the Test Image created by a "Test Failover" for vApp C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d from the recovery destination.

    .EXAMPLE
    Invoke-vCAVReplicationOperation -ReplicationType VM -ReplicationId C4-1909c491-b445-4ee1-9c09-cff64e1d29ba -TestCleanUp
    Removes the Test Image created by a "Test Failover" for VM Replication C4-1909c491-b445-4ee1-9c09-cff64e1d29ba from the recovery destination.

    .EXAMPLE
    Invoke-vCAVReplicationOperation -ReplicationType vApp -ReplicationId C4VAPP-9d4b1ae0-1ea8-4777-94c8-32e02d958998 -Test -Async
    Performs a Test Failover of the vApp with the Replication Id C4VAPP-9d4b1ae0-1ea8-4777-94c8-32e02d958998 using the pre-defined TestFailover networks and settings and returns the Task; runs asynchronously.

    .EXAMPLE
    Invoke-vCAVReplicationOperation -ReplicationType VM -ReplicationId C4-1909c491-b445-4ee1-9c09-cff64e1d29ba -Test
    Performs a Test Failover of the VM Replication with the VM Replication Id of "C4-1909c491-b445-4ee1-9c09-cff64e1d29ba" with the pre-defined TestFailover network

    .EXAMPLE
    Invoke-vCAVReplicationOperation -ReplicationType vApp -ReplicationId C4VAPP-9d4b1ae0-1ea8-4777-94c8-32e02d958998 -Test -UseDefaultNetworking $false -OrgVDCNetwork CustomerNetwork1
    Performs a Test Failover of the vApp with the Replication Id C4VAPP-9d4b1ae0-1ea8-4777-94c8-32e02d958998 and connects the failed over machine to the OrgVDCNetwork CustomerNetwork1.

    .EXAMPLE
    Invoke-vCAVReplicationOperation -ReplicationType vApp -ReplicationId C4VAPP-9d4b1ae0-1ea8-4777-94c8-32e02d958998 -Test -UseDefaultNetworking $false -OrgVDCNetwork CustomerNetwork -PowerOn $true -SyncBeforeTest $false
    Performs a Test Failover of the vApp with the REplication Id C4VAPP-9d4b1ae0-1ea8-4777-94c8-32e02d958998 and connects the failed over machine to the OrgVDCNetwork CustomerNetwork1. The machines will be Powered On after the Test Failover and a Sync will not be performed before the test.

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-10-19
	VERSION: 2.0
    #>
    [CmdletBinding(DefaultParameterSetName="Default")]
    Param(
        [Parameter(Mandatory=$True)]
            [ValidateSet("VM","vApp")] [string]$ReplicationType,
            [switch]$Async,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [String] $ReplicationId,
        [Parameter(Mandatory=$True, ParameterSetName="Failover")]
            [switch]$Failover,
        [Parameter(Mandatory=$True, ParameterSetName="Migrate")]
            [switch]$Migrate,
        [Parameter(Mandatory=$True, ParameterSetName="Test")]
            [switch]$Test,
        [Parameter(Mandatory=$True, ParameterSetName="TestCleanup")]
            [switch]$TestCleanup,
        [Parameter(Mandatory=$True, ParameterSetName="Pause")]
            [switch]$PauseReplication,
        [Parameter(Mandatory=$True, ParameterSetName="Resume")]
            [switch]$ResumeReplication,
        [Parameter(Mandatory=$True, ParameterSetName="Reverse")]
            [switch]$ReverseReplication,
        [Parameter(Mandatory=$True, ParameterSetName="Sync")]
            [switch]$Sync,
        [Parameter(Mandatory=$False, ParameterSetName="Failover")]
        [Parameter(Mandatory=$False, ParameterSetName="Migrate")]
        [Parameter(Mandatory=$False, ParameterSetName="Test")]
            [bool] $PowerOn = $false,
        [Parameter(Mandatory=$False, ParameterSetName="Failover")]
        [Parameter(Mandatory=$False, ParameterSetName="Migrate")]
            [bool] $Consolidate = $False,
        [Parameter(Mandatory=$False, ParameterSetName="Failover")]
        [Parameter(Mandatory=$False, ParameterSetName="Test")]
        [Parameter(Mandatory=$False, ParameterSetName="Migrate")]
            [bool] $UseDefaultNetworking = $True,
        [Parameter(Mandatory=$False, ParameterSetName="Failover")]
        [Parameter(Mandatory=$False, ParameterSetName="Test")]
        [Parameter(Mandatory=$False, ParameterSetName="Migrate")]
            [ValidateNotNullorEmpty()] [String] $OrgVDCNetwork,
        [Parameter(Mandatory=$False, ParameterSetName="Test")]
            [ValidateNotNullorEmpty()] [bool] $SyncBeforeTest = $true
    )
    # First set the API endpoint based on if the query type is for VM or vApp Replications and check if the Replication with Id exists
    if($PSCmdlet.ParameterSetName -eq "vApp"){
        $URI = $global:DefaultvCAVServer.ServiceURI + "vapp-replications"
    } elseif($PSCmdlet.ParameterSetName -eq "VM"){
        $URI = $global:DefaultvCAVServer.ServiceURI + "vm-replications"
    }
    if($ReplicationType -eq "vApp"){
        try{
            # Get the Replication and all instances
            $ReplicationObject = Get-vCAVReplications -vApp -ReplicationId $ReplicationId -IncludeInstances
            $URI = $global:DefaultvCAVServer.ServiceURI + "vapp-replications/$ReplicationId/"
            if($false -in $ReplicationObject.vmReplications.IsPaused){
                # A variable for tracking if at least one VM is paused in the Replication Job; for determining if work should be performed
                $AllReplicationsPaused = $false
            } else {
                $AllReplicationsPaused = $true
            }
            if($ReplicationObject.vmReplications.destinationState.recoveryInfo.recoveryState -eq "TEST"){
                $FailedOver = $false
                $TestExists = $true
                # When Test Failover
            } elseif($ReplicationObject.vmReplications.destinationState.recoveryInfo.recoveryState -eq "NOT_STARTED") {
                $FailedOver = $false
                $TestExists = $false
            } elseif($ReplicationObject.vmReplications.destinationState.recoveryInfo.recoveryState -eq "COMPLETE"){
                $FailedOver = $true
                $TestExists = $false
            }
        } catch {
            throw "The vApp Replication with the ID $ReplicationId has not been found on the connected system. Please check the Replication Id and the connected Site Id and try again."
        }
    } elseif($ReplicationType -eq "VM"){
        try{
            $ReplicationObject = Get-vCAVReplications -VM -ReplicationId $ReplicationId -IncludeInstances
            $URI = $global:DefaultvCAVServer.ServiceURI + "vm-replications/$ReplicationId/"
            if($ReplicationObject.isPaused){
                $AllReplicationsPaused = $true
            } else {
                $AllReplicationsPaused = $false
            }
            if($ReplicationObject.destinationState.recoveryInfo.recoveryState -eq "TEST"){
                $FailedOver = $false
                $TestExists = $true
                # When Test Failover
            } elseif($ReplicationObject.destinationState.recoveryInfo.recoveryState -eq "NOT_STARTED") {
                $FailedOver = $false
                $TestExists = $false
            } elseif($ReplicationObject.destinationState.recoveryInfo.recoveryState -eq "COMPLETE"){
                $FailedOver = $true
                $TestExists = $false
            }
        } catch {
            throw "The VM Replication with the ID $ReplicationId has not been found on the connected system. Please check the Replication Id and the connected Site Id and try again."
        }
    }
    # Create the payload and URI path for the requested Operation
    if($PSCmdlet.ParameterSetName -eq "Pause"){
        $URI += "pause"
        $OperationMethod = "Post"
        # Check if the object state to determine if it is currently paused, if all machines are paused do nothing otherwise perform the Operation
        if($AllReplicationsPaused){
            Write-Warning "The Replication is currently paused for $($ReplicationObject.id) nothing will be performed."
            $boolValuesAdjusted = $false
        } else {
            $boolValuesAdjusted = $true
        }
    }
    if($PSCmdlet.ParameterSetName -eq "Resume"){
        $URI += "resume"
        $OperationMethod = "Post"
        $boolValuesAdjusted = $true
    }
    if($PSCmdlet.ParameterSetName -eq "Sync"){
        $URI += "sync"
        $OperationMethod = "Post"
        if($AllReplicationsPaused){
            Write-Warning "The Replication is currently paused for $($ReplicationObject.id) nothing will be performed."
            $boolValuesAdjusted = $false
        } else {
            $boolValuesAdjusted = $true
        }
    }
    # For a Failover, FailoverTest and Migrate the Payload (FailoverTestSettings) object is constructed in the same manner.
    if($PSCmdlet.ParameterSetName -in ("Migrate","Failover","Test")){
        # Create the failover test payload
        $failoverSettings = New-Object System.Management.Automation.PSObject
        if($PSCmdlet.ParameterSetName -eq "Test"){
            $failoverSettings | Add-Member Note* consolidate $False
        } else {
            $failoverSettings | Add-Member Note* consolidate $Consolidate
        }
        $failoverSettings | Add-Member Note* powerOn $PowerOn
        if($UseDefaultNetworking){
            $failoverSettings | Add-Member Note* preconfiguredNetwork $UseDefaultNetworking
        } else {
            # Check if an Org Network has been provided
            if(!$PSBoundParameters.ContainsKey("OrgVDCNetwork")){
                $OrgNetworkId = "" # Set as disconnected
                Write-Warning -Message "The -UseDefaultNetworking has been set to false and no OrgVDCNetwork network has been provided. The Operation $($PSCmdlet.ParameterSetName) will proceed with the networks disconnected for all machines."
            } else {
                # Check if the provided OrgVDC network exists
                $OrgNetworkId = (Get-vCAVOrgVDCNetwork -OrgVDCName $ReplicationObject.destination.vdcName -NetworkName $OrgVDCNetwork)
                if($OrgNetworkId.Length -eq 0){
                    Write-Warning -Message "An OrgVDCNetwork with the name $OrgVDCNetwork can not be found in the destination Org VDC $($ReplicationObject.destination.vdcName). The Operation $($PSCmdlet.ParameterSetName) will proceed with the networks disconnected for all machines."
                } else {
                    $failoverSettings | Add-Member Note* orgVdcNetwork $OrgNetworkId
                }
            }
        }
        $failoverSettings | Add-Member Note* snapshotOptions "DO_NOTHING"
        $failoverSettings | Add-Member Note* exposePITsAsSnapshots $True
        # We must retireve the preconfigured network settings
        if($UseDefaultNetworking){
            if($ReplicationType -eq "vApp"){
                $FailoverNetworkSettings = Get-vCAVReplicationNetworkSettings -vApp -ReplicationId $ReplicationId
            } else {
                $FailoverNetworkSettings = Get-vCAVReplicationNetworkSettings -VM -ReplicationId $ReplicationId
            }
        } else {
            $failoverSettings | Add-Member Note* orgVdcNetworkId $OrgNetworkId.id
        }
        # Initalise a collection for the instance map
        # TO DO : Build something to select the instances that should be used for Failover and Failover Test
        # Should be able to have this as an input or Interactive option, development effort is to great for current purpose.
        $colVMReplicationInstances = $null
        $failoverSettings | Add-Member Note* instanceMap $colVMReplicationInstances
        $failoverSettings | Add-Member Note* sync $SyncBeforeTest
        if($PSCmdlet.ParameterSetName -eq "Test"){
            $failoverSettings | Add-Member Note* vAppNetworkSettings $FailoverNetworkSettings.failoverTestSettings.vAppNetworkSettings
            $failoverSettings | Add-Member Note* vmNetworkSettings $FailoverNetworkSettings.failoverTestSettings.vmNetworkSettings
        } else {
            $failoverSettings | Add-Member Note* vAppNetworkSettings $FailoverNetworkSettings.failoverSettings.vAppNetworkSettings
            $failoverSettings | Add-Member Note* vmNetworkSettings $FailoverNetworkSettings.failoverSettings.vmNetworkSettings
        }
        $failoverSettings | Add-Member Note* type "vcloud"
        # Now set the Payload
        $Payload = ConvertTo-JSON $failoverSettings -Depth 6

        # Next we need to set the Operation parameters
        if($PSCmdlet.ParameterSetName -eq "Test"){
            $URI += "failover-test"
            $OperationMethod = "Post"
            if($TestExists){
                throw "A Test Image currently exists for the Replication with the Replication Id $ReplicationId. Please remove the old Test Image using the -TestCleanup switch before creating a new one."
            }
            if($FailedOver){
                throw "The Replication with the Replication Id $ReplicationId is currently in a Failed Over state. A Test can not be performed until the workload is Reversed and Re-protected."
            }
            # Go ahead otherwise
            $boolValuesAdjusted = $true
        }
        if($PSCmdlet.ParameterSetName -eq "Failover"){
            $URI += "failover"
            $OperationMethod = "Post"
            if($TestExists){
                throw "A Test Image currently exists for the Replication with the Replication Id $ReplicationId. Please remove the Test Image using the -TestCleanup switch before performing a Failover."
            }
            if($FailedOver){
                throw "The Replication with the Replication Id $ReplicationId is currently in a Failed Over state. Perform a -Reverse operation to Re-Protect the workload and retry the operation again."
            }
            # Go ahead otherwise
            $boolValuesAdjusted = $true
        }
        if($PSCmdlet.ParameterSetName -eq "Migrate"){
            $URI += "migrate"
            $OperationMethod = "Post"
            if($FailedOver){
                throw "The Replication with the Replication Id $ReplicationId is currently in a Failed Over state. You can not migrate whilst the workloads is already failed over."
            }
            $boolValuesAdjusted = $true
        }
    }
    if($PSCmdlet.ParameterSetName -eq "TestCleanup"){
        $URI += "failover-test"
        $OperationMethod = "Delete"
        if($TestExists){
            $boolValuesAdjusted = $true
        } else {
            Write-Warning -Message "No Test Image currently exists for the Replication with the Replication Id $ReplicationId. Nothing will be performed."
        }
    }
    if($PSCmdlet.ParameterSetName -eq "Reverse"){
        $URI += "reverse"
        $OperationMethod = "Post"
        if($FailedOver){
            $boolValuesAdjusted = $true
        } else {
            throw "The Replication with the Replication Id $ReplicationId is not currently Failed Over. A -Reverse operation can only be performed when the workload is failed over."
        }
    }
    if($boolValuesAdjusted){
        try{
            # Create a Hashtable for spatting the input to Invoke-vCAVAPIRequest
            $APICallParamters = @{
                URI = $URI
                Method = $OperationMethod
                APIVersion = $DefaultvCAVServer.DefaultAPIVersion
            }
            # Now check if we are sending any data
            if($Payload.Length -ne 0){
                $APICallParamters.Add("Data",$Payload)
            }
            # Make the API call to execute the vCAV Operation
            $ReplicationOpTask = (Invoke-vCAVAPIRequest @APICallParamters).JSONData
            if(!$PSBoundParameters.ContainsKey("Async")){
                Watch-TaskCompleted -Task $ReplicationOpTask -Timeout ((Get-PowerCLIConfiguration -Scope Session).WebOperationTimeoutSeconds) > $null
            }
            Get-vCAVTasks -Id $ReplicationOpTask.id
        } catch {
            throw "An unexpected error occured during the Invoke-vCAVAPIRequest operation."
        }
    }
}
