function Get-vCAVApplianceHealth(){
    <#
    .SYNOPSIS
    Returns the health of the currently connected vCloud Availability Service.

    .DESCRIPTION
    Returns the health of the currently connected vCloud Availability Service.

    .EXAMPLE
    Get-vCAVApplianceHealth
    Returns the current health of the currently connected vCloud Availability Service. 

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 2.0
    #>
    $URI = $global:DefaultvCAVServer.ServiceURI + "diagnostics/health"
    $RequestResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Get).JSONData
    $RequestResponse
}
