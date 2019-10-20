function Invoke-vCAVApplianceUpdate(){
    <#
    .SYNOPSIS
    Update the connected vCloud Availability service with any updates available in the currently configured Update Repository.

    .DESCRIPTION
    Update the connected vCloud Availability service with any updates available in the currently configured Update Repository.

    .PARAMETER CheckOnly
    If switch is provided will only check if an update is available

    .PARAMETER AcceptEULA
    If True will install the update without displaying/prompting for acceptance of the End User Licence Agreeement

    .EXAMPLE
    Invoke-vCAVApplianceUpdate -CheckOnly
    Only checks if an update is available and returns the version if one is available. Does not install the update.

    .EXAMPLE
    Invoke-vCAVApplianceUpdate
    Installs any available updates from the Update Repo.

    .EXAMPLE
    Invoke-vCAVApplianceUpdate -AcceptEULA $true
    Installs any available updates from the Update Repo accepting the EULA and not prompting during installation.  

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-04-23
	VERSION: 1.0
    #>
    [CmdletBinding(DefaultParameterSetName="Update")]
    Param(
        [Parameter(Mandatory=$False, ParameterSetName="Check")]
            [switch]$CheckOnly,
        [Parameter(Mandatory=$False, ParameterSetName="Update")]
            [boolean]$AcceptEULA = $False
    )
    [string] $URI = $global:DefaultvCAVServer.ServiceURI + "update"
    $UpdateStatusTask = (Invoke-vCAVAPIRequest -URI $URI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
    if((Watch-TaskCompleted -Task $UpdateStatusTask -Timeout ((Get-PowerCLIConfiguration -Scope Session).WebOperationTimeoutSeconds))){
        $UpdateStatus = Get-vCAVTasks -Id $UpdateStatusTask.id
        # If only checking if the updates are available just return the available version
        if($CheckOnly){
            $UpdateStatus.result    
        } else {
            # If the EULA has not been accepted retreive and force the user to accept before installation
            if(!$AcceptEULA){
                [string] $EULAURI = $global:DefaultvCAVServer.ServiceURI + "update/eula"
                $UpdateEULATask = (Invoke-vCAVAPIRequest -URI $EULAURI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
                if(Watch-TaskCompleted -Task $UpdateEULATask -Timeout ((Get-PowerCLIConfiguration -Scope Session).WebOperationTimeoutSeconds)){
                    $UpdateEULA = Get-vCAVTasks -Id $UpdateEULATask.id
                    Write-Warning $($UpdateEULA.result.eula) -WarningAction Inquire
                }
            }
            # Execute the update of the connected appliance
            $UpdateApplianceTask = (Invoke-vCAVAPIRequest -URI $URI -Method Post -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
            if((Watch-TaskCompleted -Task $UpdateApplianceTask -Timeout ((Get-PowerCLIConfiguration -Scope Session).WebOperationTimeoutSeconds))){
                $UpdateStatus.result   
            }
        }
    }
}