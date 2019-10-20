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
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-02-21
	VERSION: 1.0
    #>
    # Validate the environment is ready based on the input parameters
    if(!(Test-VCAVServiceEnvironment -Version 3)){
        Break
    }
    $URI = $global:DefaultvCAVServer.ServiceURI + "config/certificate"
    $RequestResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
    $RequestResponse.certificate
}