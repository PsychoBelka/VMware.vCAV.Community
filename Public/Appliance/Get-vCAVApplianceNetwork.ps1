function Get-vCAVApplianceNetwork(){
    <#
    .SYNOPSIS
    Returns the network settings for the currently connected vCloud Availability Appliance.

    .DESCRIPTION
    Returns the network settings for the currently connected vCloud Availability Appliance.

    .EXAMPLE
    Get-vCAVApplianceNetwork
    Returns the current network configuration.

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 1.0
    #>
    $URI = $global:DefaultvCAVServer.ServiceURI + "config/network"
    # Get the current network configuration
    $CurrentNetworkConfig = ((Invoke-vCAVAPIRequest -URI $URI -Method Get).JSONData)
    $CurrentNetworkConfig
}