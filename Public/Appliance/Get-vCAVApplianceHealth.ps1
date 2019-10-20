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
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-02-21
	VERSION: 2.0
    #>
    $URI = $global:DefaultvCAVServer.ServiceURI + "diagnostics/health"
    $RequestResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
    $RequestResponse
}
