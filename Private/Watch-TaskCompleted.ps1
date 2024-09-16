function Watch-TaskCompleted(){
	<#
	.SYNOPSIS
	 This cmdlet monitors a running task and returns True when the task completes.

	.DESCRIPTION
	 This cmdlet monitors a running task and returns True when the task completes

	.PARAMETER Task
	A PSObject containing a Task object returned by an API POST call

	.PARAMETER Timeout
	Optionally the timeout in seconds before the cmdlet should terminate if the task has not completed.

    Default is 180 seconds.
	For no timeout set to -1

	.EXAMPLE
	Watch-TaskCompleted -Task $RemoveTask -Timeout 180

	Monitors the task in the object $RemoveTask for a maximum of 60 seconds and returns True when the task completes

	.NOTES
	NAME: Watch-TaskCompleted
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	#>
	Param(
		[Parameter(Mandatory=$True)]
			[ValidateNotNullorEmpty()] [PSObject] $Task,
		[Parameter(Mandatory=$False)]
            [ValidateRange(-1,3600)] [int] $Timeout = 180
	)
	$boolTaskComplete = $false
    Do {
        [string] $URI = $global:DefaultvCAVServer.ServiceURI + "tasks/" + $Task.id
        $objTaskStatus = (Invoke-vCAVAPIRequest -URI $URI -Method Get ).JSONData
        # Write debug message
        Write-Debug $objTaskStatus
        Write-Progress -Activity "Task Id: $($Task.id)" -PercentComplete $($objTaskStatus.progress)
		if($objTaskStatus.state -ne "RUNNING"){
            $boolTaskComplete = $true
            if($objTaskStatus.state -ne "SUCCEEDED"){
                throw "An error occured execuitng Task Id $($Task.id). Errors: $($objTaskStatus.error.code) $($objTaskStatus.error.msg)"
                Break
            }
		}
		if($Timeout -ne -1){
			$Timeout--
		}
        Start-Sleep -Seconds 1
    } Until (($Timeout -eq 0) -or $boolTaskComplete)
	if(($Timeout -eq 0) -and !$boolTaskComplete){
		throw "A timeout occured waiting for the Task Id $($Task.id) to complete."
	}
	$boolTaskComplete
}