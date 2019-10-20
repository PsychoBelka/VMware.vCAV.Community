function Set-vCAVReplication() {
    <#<#
    .SYNOPSIS
    Reconfigure the Replication settings for an existing VM or vApp protected by vCloud Availability.

    .DESCRIPTION
    Reconfigure the Replication settings for an existing VM or vApp protected by vCloud Availability.

    Changing Ownership: Allows administrators to change the owner of the respective vApp replication. Replications are by default owned by the user that started them, which means that any replications started by an administrator user would not be visible to the involved org, unless the admin explicitly hands the replication to the org. Alternatively, an admin may sometimes temporarily take ownership of a replication in order to prevent the tenant from seeing or managing the respective replication while troubleshooting/emergency recovery is ongoing. Changing the vApp replication owner results in the child VM replications' owner being set to the same value.

    If a vApp Replication is provided the changes are set for all VMs in the vApp Replication job to the specified values. Caution should be taken when using this cmdlet with the -vApp paramter as Replication Settings are scoped at the VM level; this can lead to VM specific settings being overwitten with undesired values.
    It is recommended to use the -VM switch when changing Replication Settings unless the settings should be identical for all VMs.

    .PARAMETER ReplicationType
    vApp or VM Replication

    .PARAMETER ReplicationId
    The Id of the Replication object in the vCloud Availability installation

    .PARAMETER Async
    Indicates that the command returns immediately without waiting for the task to complete. In this mode, the output of the cmdlet is a Task object.

    .PARAMETER Chown
    Allows administrators to change the owner of the respective vApp replication
    Requires Administrator priviledges

    .PARAMETER Owner
    Optional owner of the replication, if omitted the currently logged in user becomes the owner.

    .PARAMETER StorageProfile
    Switch to indicate a change to the Storage Profile for the replica at the Destination

    .PARAMETER StorageProfileName
    The Storage Profile Name of the Storage Profile at the Destination OrgVDC

    .PARAMETER Description
    The Description of the vApp or VM Replication job

    .PARAMETER Quiesced
    If True during Replication the guest OS will attempt to Quiesce the Virtual machine via the VMware Tools driver for a crash consistent replication.

    .PARAMETER MPITSnapshots
    The number of Muliple Point in Time Snapshots that should be set for the virtual machine

    .PARAMETER RPOMinutes
    The Recovery Point Objective (RPO) in minutes for the Replication

    .PARAMETER SnapshotDistance
    The distance (time in minutes) that the MPIT Snapshots should be spread across

    .EXAMPLE
    Set-vCAVReplication -ReplicationType VM -ReplicationId C4-aef12910-9f62-4a51-a100-12faeedbaaf4 -Chown -Owner "TestOrg@vCloud-Test-Site1"

    Changes the Owner of VM Replication with the Id C4-aef12910-9f62-4a51-a100-12faeedbaaf4 to Org TestOrg@vCloud-Test-Site1

    .EXAMPLE
    Set-vCAVReplication -ReplicationType VM -ReplicationId C4-aef12910-9f62-4a51-a100-12faeedbaaf4 -Quiesced $True

    Enable Guest OS Quiesce for the VM with Replication Id C4-aef12910-9f62-4a51-a100-12faeedbaaf4

    .EXAMPLE
    Set-vCAVReplication -ReplicationType vApp -ReplicationId C4-aef12910-9f62-4a51-a100-12faeedbaaf4 -Quiesced $True -RPOMinutes 120 -Async
    Enable Guest OS Quiesce and adjusts the RPO for the vApp with Replication Id C4-aef12910-9f62-4a51-a100-12faeedbaaf4. The task runs asynchronously

    .EXAMPLE
    Set-vCAVReplication -ReplicationType vApp -ReplicationId C4-aef12910-9f62-4a51-a100-12faeedbaaf4 -StorageProfile -StorageProfileName "Gold"
    Sets the Destination Storage Profile for the vApp with Replication Id C4-aef12910-9f62-4a51-a100-12faeedbaaf4 to the Storage Profile with the name "Gold".

    .EXAMPLE
    Set-vCAVReplication -ReplicationType vApp -ReplicationId C4-aef12910-9f62-4a51-a100-12faeedbaaf4 -Quiesced $True -RPOMinutes 120 -SnapshotDistance 15 -Async
    Enable Guest OS Quiesce and adjusts the RPO for the vApp with Replication Id C4-aef12910-9f62-4a51-a100-12faeedbaaf4. The task runs asynchronously

    AUTHOR: Adrian Begg
	LASTEDIT: 2019-09-22
	VERSION: 2.0
    #>
    [CmdletBinding(DefaultParameterSetName = "ReplicationSettings")]
    Param(
        [Parameter(Mandatory = $True)]
            [ValidateSet("VM", "vApp")] [string]$ReplicationType,
        [Parameter(Mandatory = $True)]
            [ValidateNotNullorEmpty()] [String] $ReplicationId,
        [Parameter(Mandatory = $False)]
            [switch]$Async,
        [Parameter(Mandatory = $True, ParameterSetName = "Owner")]
            [switch]$Chown,
            [ValidateNotNullorEmpty()] [String] $Owner,
        [Parameter(Mandatory = $True, ParameterSetName = "StorageProfile")]
            [switch]$StorageProfile,
            [ValidateNotNullorEmpty()] [String] $StorageProfileName,
        [Parameter(Mandatory = $False, ParameterSetName = "ReplicationSettings")]
            [ValidateNotNullorEmpty()] [String] $Description,
            [bool] $Quiesced,
            [ValidateRange(1, 24)] [int] $MPITSnapshots,
            [ValidateRange(5, 1440)] [int] $RPOMinutes,
            [ValidateRange(1, [int]::MaxValue)]  [int] $SnapshotDistance
    )
    # First set the API endpoint based on if the query type is for VM or vApp Replications and check if the Replication with Id exists
    if ($ReplicationType -eq "vApp") {
        try {
            $ReplicationObject = Get-vCAVReplications -vApp -ReplicationId $ReplicationId
            $URI = $global:DefaultvCAVServer.ServiceURI + "vapp-replications/$ReplicationId"
            if($null -eq $ReplicationObject){
                throw "The vApp Replication with the ID $ReplicationId has not been found on the connected system. Please check the Replication Id and the connected Site Id and try again."
            }
        }
        catch {
            throw "The vApp Replication with the ID $ReplicationId has not been found on the connected system. Please check the Replication Id and the connected Site Id and try again."
        }
    }
    elseif ($ReplicationType -eq "VM") {
        try {
            $ReplicationObject = Get-vCAVReplications -VM -ReplicationId $ReplicationId
            $URI = $global:DefaultvCAVServer.ServiceURI + "vm-replications/$ReplicationId"
            if($null -eq $ReplicationObject){
                throw "The VM Replication with the ID $ReplicationId has not been found on the connected system. Please check the Replication Id and the connected Site Id and try again."
            }
        }
        catch {
            throw "The VM Replication with the ID $ReplicationId has not been found on the connected system. Please check the Replication Id and the connected Site Id and try again."
        }
    }
    # Change the main replication config
    if ($PSCmdlet.ParameterSetName -eq "ReplicationSettings") {
        # A variable to track if changes have occured in the policy
        $boolValuesAdjusted = $false
        $boolTaskReturned = $true # A task is returned by the API call
        $OperationMethod = "Patch"
        $URI += "?site=$($ReplicationObject.source.site)"# Need to add the site as a query paramter for the PATCH
        # For vApp Replications : Replication settings are VM specific but can be applied at the vApp level in order to get the base settings the first element is used as the template object
        # The other option would be to iterate over the VMs and apply each setting individually...for simplicity and top match GUI functionality just using first element for now
        if ($ReplicationType -eq "vApp") {
            $ReplicationSettings = $ReplicationObject.vmReplications[0].settings
        } else {
            $ReplicationSettings = $ReplicationObject.settings
        }
        # Check if the Description has been updated
        if ($PSBoundParameters.ContainsKey("Description")) {
            $boolValuesAdjusted = $true
            $ReplicationSettings.description = $Description
        }
        # Check if Qiescing has been set
        if ($PSBoundParameters.ContainsKey("Quiesced")) {
            $boolValuesAdjusted = $true
            $ReplicationSettings.quiesced = $Quiesced
        }
        # Create a new object for the Retention Policy rules in case it is required and if the object doesnt already exist
        $Rule = $ReplicationSettings.retentionPolicy.rules | Select-Object numberOfInstances,distance
        if($null -eq $Rule){
            $Rule = New-Object System.Management.Automation.PSObject @{
                numberOfInstances = $null
                distance = $null
            }
        }
        # Check if the Replication Policy and RPO settings are being changed
        if ($PSBoundParameters.ContainsKey("MPITSnapshots")){
            $boolValuesAdjusted = $true
            if($MPITSnapshots -gt 1){
                # We need to check here if the SnapshotDistance is defined already or provided if more then 1 MPIT is provided
                if(($null -eq $ReplicationSettings.retentionPolicy.rules.distance) -and !($PSBoundParameters.ContainsKey("SnapshotDistance"))){
                    throw "If the number of Muliple Point in Time Snapshots (MPIT) are greater then 1, the -SnapshotDistance parameter must be provided or the value already set."
                }
                # Initalise the empty set, if "1" is set then there is no requirement for retentionPolicy rules to be defined
                $ReplicationSettings.retentionPolicy.rules = @()
                $Rule.numberOfInstances = $MPITSnapshots
                $ReplicationSettings.retentionPolicy.rules += $Rule
            } else {
                $ReplicationSettings.retentionPolicy.rules = @()
            }
        }
        if ($PSBoundParameters.ContainsKey("SnapshotDistance")){
            # Need a bit of a messy check if the Snapshot Distance is provided - first check if we have any MPIT snapshots in use
            if($null -eq $ReplicationSettings.retentionPolicy.rules.numberOfInstances){
                # Check if a parameter has been provided in this
                throw "If the number of Muliple Point in Time Snapshots (MPIT) is not set or set to 1 then -SnapshotDistance can not be used. Please ensure that -MPITSnapshots is greater than 1."
            }
            # Need to use a Select-Object to prevent a Read-Only Hash table being returned
            $Rule = $ReplicationSettings.retentionPolicy.rules | Select-Object numberOfInstances,distance
            $boolValuesAdjusted = $true
            $Rule.distance = $SnapshotDistance
            $ReplicationSettings.retentionPolicy.rules = @()
            $ReplicationSettings.retentionPolicy.rules += $Rule
        }
        if ($PSBoundParameters.ContainsKey("RPOMinutes")) {
            $boolValuesAdjusted = $true
            $ReplicationSettings.rpo = $RPOMinutes
        }
        # Need to construct the payload correctly for the PATCH
        $objPayload = $ReplicationSettings | Select-Object -Property description,rpo,dataConnectionType,quiesced,retentionPolicy
        if($DefaultvCAVServer.buildVersion -lt "3.5"){
            $objPayload | Add-Member Note* sourceReconfigure $null
        }
    }
    # Set the Storage Profile
    if ($PSCmdlet.ParameterSetName -eq "StorageProfile") {
        # Always execute a Storage Profile Change
        $boolValuesAdjusted = $true
        $boolTaskReturned = $true # A task is returned by the API call
        $URI += "storage-profile"
        $OperationMethod = "Post"
        # Check if the Storage Profile exists in the Destination OrgVDC for the Replication
        $destinationOrgVDCStorageProfile = Get-vCAVStorageProfile -Site $ReplicationObject.destination.Site -OrgVDCName $ReplicationObject.destination.vdcName -StorageProfile $StorageProfileName
        if ($destinationOrgVDCStorageProfile.Count -eq 0) {
            throw "A Storage Profile with the name $StorageProfileName does not exist in the Destination Org VDC $($ReplicationObject.destination.vdcName)."
        }
        else {
            $StorageProfileId = $destinationOrgVDCStorageProfile.id
            # Create the JSON payload
            $objPayload = New-Object System.Management.Automation.PSObject
            $objPayload | Add-Member Note* storageProfileId $StorageProfileId
        }
    }
    # Change the Owner
    if ($PSCmdlet.ParameterSetName -eq "Owner") {
        # Check if the current user is an Administrator
        if($DefaultvCAVServer.Roles.Contains("ADMINISTRATORS")){
            # Always execute a the Chown
            $boolValuesAdjusted = $true
            $boolTaskReturned = $false # This operation returns the Replication Object not the task
            $URI += "chown"
            $OperationMethod = "Patch"
            # Check if the provided vOrg exists in the installation
            $OrgName = ($Owner.Split('@')[0])
            $SiteName = ($Owner.Split('@')[1])
            if(($OrgName -ne "System") -and ($null -eq (Get-vCAVTenantOrg -OrgName $OrgName -Site $SiteName))){
                throw "An organisation with the Org Name $OrgName can not be found for the site $SiteName"
            }
            # Create the JSON payload
            $objPayload = New-Object System.Management.Automation.PSObject
            $objPayload | Add-Member Note* owner $Owner
        } else {
            throw "The change owner operation requires Administrator priviledges. The current sessions does not contain the role 'ADMINISTRATORS'"
        }
    }
    # Now execute the call to adjust the Replication settings if we had an actual configuration change
    if ($boolValuesAdjusted) {
        $ReplicationOp = (Invoke-vCAVAPIRequest -URI $URI -Method $OperationMethod -Data (ConvertTo-JSON $objPayload -Depth 6) -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
        if($boolTaskReturned){
            if (!$PSBoundParameters.ContainsKey("Async")) {
                Watch-TaskCompleted -Task $ReplicationOp -Timeout ((Get-PowerCLIConfiguration -Scope Session).WebOperationTimeoutSeconds) > $null
            }
            Get-vCAVTasks -Id $ReplicationOp.id
        } else {
            $ReplicationOp
        }
    }
    else {
        Write-Warning -Message "No values have changed from the current configuration. Nothing has been executed."
    }

}
