function Invoke-vCAVServicesReboot(){
    <#
    .SYNOPSIS
    Issues a systemctl restart to the vCloud Availability Services running on the connected vCloud Availability service.

    .DESCRIPTION
    Issues a systemctl restart to the vCloud Availability Services running on the connected vCloud Availability service.

    .EXAMPLE
    Invoke-vCAVServicesReboot
    Issues a systemctl restart to the vCloud Availability Services running on the connected vCloud Availability service.

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2018-12-24
	VERSION: 2.0
    #>
    [string] $URI = $global:DefaultvCAVServer.ServiceURI + "os/reboot-services"
    $RebootResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Post -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
    $RebootResponse
}