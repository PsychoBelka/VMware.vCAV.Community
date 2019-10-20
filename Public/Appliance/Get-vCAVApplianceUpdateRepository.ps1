function Get-vCAVApplianceUpdateRepository(){
    <#
    .SYNOPSIS
    This cmdlet returns the current update repository configuration of the connected vCloud Availability service.

    .DESCRIPTION
    This cmdlet returns the current update repository configuration of the connected vCloud Availability service.

    .EXAMPLE
    Get-vCAVApplianceUpdateRepository
    Returns the configuration of the update service for the connected vCloud Availability service.

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-04-23
	VERSION: 1.0
    #>
    $UpdateConfigURI = $global:DefaultvCAVServer.ServiceURI + "update/repository-url"
    $Configresponse = (Invoke-vCAVAPIRequest -URI $UpdateConfigURI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
    $Configresponse
}