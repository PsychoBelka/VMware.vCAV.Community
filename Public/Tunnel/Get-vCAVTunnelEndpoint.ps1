function Get-vCAVTunnelEndpoint(){
    <#
    .SYNOPSIS
    The cmdlet returns the current vCloud Availability Tunnel Endpoint configuration (if configured).

    .DESCRIPTION
    The cmdlet returns the current vCloud Availability Tunnel Endpoint configuration (if configured).

    .EXAMPLE
    Get-vCAVTunnelEndpoint
    Returns the current configuration of the vCloud Availability Tunnel Endpoint for the connected instance.

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2018-12-24
	VERSION: 2.0
    #>
    $URI = $global:DefaultvCAVServer.ServiceURI + "config/endpoints"
    $objEndpointResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
    $objEndpointResponse.configured
}