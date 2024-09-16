function Remove-vCAVCustomerSite(){
    <#
    .SYNOPSIS
    Removes a registered On-prem site from the vCloud Availability installation.

    .DESCRIPTION
    Removes a registered On-prem site from the vCloud Availability installation.

    .PARAMETER SiteName
    The On-Prem site name

    .PARAMETER Async
    Indicates that the command returns immediately without waiting for the task to complete. In this mode, the output of the cmdlet is a Task object.

    .EXAMPLE
    Remove-vCAVCustomerSite -SiteName "Pigeon_OnPrem"
    Removes the vCenter Site with the Site Name "Pigeon_OnPrem" from the current installation.

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 1.0
    #>
    Param(
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [String] $SiteName,
        [Parameter(Mandatory = $False)]
            [switch]$Async
    )
    # First check if the vCenter Site exists
    Get-vCAVCustomerSites -SiteName $SiteName > $null
    [string] $SitesURI = $global:DefaultvCAVServer.ServiceURI + "vc-sites/$SiteName"
    try{
        $RemoveSites = (Invoke-vCAVAPIRequest -URI $SitesURI -Method Delete ).JSONData
        if(!$PSBoundParameters.ContainsKey("Async")){
            Watch-TaskCompleted -Task $RemoveSites -Timeout ((Get-PowerCLIConfiguration -Scope Session).WebOperationTimeoutSeconds) > $null
        }
        Get-vCAVTasks -Id $RemoveSites.id
    } catch {
        throw "An unexpected error occured during the Remove-vCAVCustomerSite operation."
    }
}