function Set-vCAVTunnelEndpoint(){
    <#
    .SYNOPSIS
    ** DEPRICATED ** Configures the H4 Tunnel Endpoint address for vCloud Availability.

    .DESCRIPTION
    ** DEPRICATED ** This cmdlet is depricated and was used in vCAV 1.5/3.0 for Tunnel configuration.
    Please use Register-vCAVTunnel cmdlet against the Manager to configure Tunnelling.

    .PARAMETER ManagementAddress
    The URI to advertise to the components on the local site as the internal management address (eg. http://vcav.internal.pigeonnuggets.com:8047)

    .PARAMETER ManagementPublicAddress
    The URI to advertise to the components as the public management address (eg. http://vcav.pigeonnuggets.com:8047)

    .PARAMETER TunnelAddress
    The URI to advertise to the components on the local site as the internal Tunnel endpoint address (eg. http://vcav.internal.pigeonnuggets.com:8048)

    .PARAMETER TunnelPublicAddress
    The URI to advertise to the components on the local site as the public Tunnel endpoint address (eg. http://vcav.pigeonnuggets.com:8048)

    .EXAMPLE
    Set-vCAVTunnelEndpoint -ManagementAddress "https://vcav.internal.pigeonnuggets.com:8047" -ManagementPublicAddress "https://vcav.pigeonnuggets.com:8047" -TunnelAddress "http://vcav.internal.pigeonnuggets.com:8048" -TunnelPublicAddress "http://vcav.pigeonnuggets.com:8048"
    Sets the Public Tunnel Endpoint for the current vCloud installation to vcav.pigeonnuggets.com and the internal address to vcav.internal.pigeonnuggets.com on TCP 8048 (management on TCP 8047)

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 2.0
    #>
    Param(
        [Parameter(Mandatory=$True)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [String] $ManagementAddress,
        [Parameter(Mandatory=$True)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [String] $ManagementPublicAddress,
        [Parameter(Mandatory=$True)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [String] $TunnelAddress,
        [Parameter(Mandatory=$True)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [String] $TunnelPublicAddress
    )
    Write-Warning -Message "This cmdlet has been depricated and will be removed in a furture release. Please use Register-vCAVTunnel cmdlet against the Manager to configure Tunnelling."
    # Cast the provided URI's into URI objects to extract what we need for the API calls
    [system.uri] $ManagementAddressURI = $ManagementAddress
    [system.uri] $ManagementAddressPublicURI = $ManagementPublicAddress
    [system.uri] $TunnelAddressURI = $TunnelAddress
    [system.uri] $TunnelAddressPublicURI = $TunnelPublicAddress

    # Create the JSON payload and post to the config URI
    $URI = $global:DefaultvCAVServer.ServiceURI + "config/endpoints"
    $objTunnelEndpoint = New-Object System.Management.Automation.PSObject
    $objTunnelEndpoint | Add-Member Note* mgmtAddress $ManagementAddressURI.Host
    $objTunnelEndpoint | Add-Member Note* mgmtPort $ManagementAddressURI.Port
    $objTunnelEndpoint | Add-Member Note* mgmtPublicAddress $ManagementAddressPublicURI.Host
    $objTunnelEndpoint | Add-Member Note* mgmtPublicPort $ManagementAddressPublicURI.Port
    $objTunnelEndpoint | Add-Member Note* tunnelAddress $TunnelAddressURI.Host
    $objTunnelEndpoint | Add-Member Note* tunnelPort $TunnelAddressURI.Port
    $objTunnelEndpoint | Add-Member Note* tunnelPublicAddress $TunnelAddressPublicURI.Host
    $objTunnelEndpoint | Add-Member Note* tunnelPublicPort $TunnelAddressPublicURI.Port

    $RequestResponse = (Invoke-vCAVAPIRequest -URI $URI -Data (ConvertTo-JSON $objTunnelEndpoint) -Method Post ).JSONData
    $RequestResponse
}