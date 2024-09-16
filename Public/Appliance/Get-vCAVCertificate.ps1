function Get-vCAVCertificate(){
    <#
    .SYNOPSIS
    Returns the currently installed certificate on the currently connected vCloud Availability Service.

    .DESCRIPTION
    Returns the currently installed certificate on the currently connected vCloud Availability Service.

    .EXAMPLE
    Get-vCAVCertificate
    Returns the currently installed certificate on the currently connected vCloud Availability Service.

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 1.0
    #>
    # Validate the environment is ready based on the input parameters
    if(!(Test-VCAVServiceEnvironment -Version 3)){
        Break
    }
    $URI = $global:DefaultvCAVServer.ServiceURI + "config/certificate"
    $RequestResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Get).JSONData
    $RequestResponse.certificate
}