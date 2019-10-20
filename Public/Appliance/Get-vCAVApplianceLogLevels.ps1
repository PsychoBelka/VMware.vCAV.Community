function Get-vCAVApplianceLogLevels(){
    <#
    .SYNOPSIS
    Retrieves all logback log levels currently in effect for the connected vCloud Availability service.

    .DESCRIPTION
    Retrieves all logback log levels currently in effect for the connected vCloud Availability service.

    .EXAMPLE
    Get-vCAVApplianceLogLevels

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-07-18
	VERSION: 2.0
    #>
    $LogLevelsURIU = $global:DefaultvCAVServer.ServiceURI + "diagnostics/loglevels"
    $LogLevelResponse = (Invoke-vCAVAPIRequest -URI $LogLevelsURIU -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
    $LogLevelResponse
}