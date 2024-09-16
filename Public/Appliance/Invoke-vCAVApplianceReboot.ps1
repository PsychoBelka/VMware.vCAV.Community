function Invoke-vCAVApplianceReboot(){
    <#
    .SYNOPSIS
    Reboots the guest OS of the virtual appliance of the connected vCloud Availability service.

    .DESCRIPTION
    Reboots the guest OS of the virtual appliance of the connected vCloud Availability service.

    .EXAMPLE
    Invoke-vCAVApplianceReboot
    Reboots the guest OS of the virtual appliance of the connected vCloud Availability service.

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 2.0
    #>
    [string] $URI = $global:DefaultvCAVServer.ServiceURI + "os/reboot"
    $RebootResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Post).JSONData
    $RebootResponse
}