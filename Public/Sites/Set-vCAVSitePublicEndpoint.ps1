function Set-vCAVSitePublicEndpoint(){
    <#
    .SYNOPSIS
    Sets the Public Endpoint addresses for the local site of the currently connected vCloud Availability service.

    .DESCRIPTION
    Sets the Public Endpoint addresses for the local site of the currently connected vCloud Availability service.

    .PARAMETER APIPublicAddress
    The URI of the Publicly accessable API Service endpoint for vCloud Availability (e.g. https://vcav.pigeonnuggets.com)

    .PARAMETER ManagementPublicAddress
    The URI of the Publicly accessable API Service endpoint for vCloud Availability. (e.g. https://vcav.internal.pigeonnuggets.com:8047)

    .EXAMPLE
    Set-vCAVSitePublicEndpoint -APIPublicAddress "https://vcav.pigeonnuggets.com" -ManagementPublicAddress "https://vcav.internal.pigeonnuggets.com:8047"
    Sets the Public API Endpoint for the current vCloud installation to https://vcav.pigeonnuggets.com and the Management (internal) API to https://vcav.pigeonnuggets.com:8047

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-09-16
	VERSION: 3.0
    #>
    Param(
        [Parameter(Mandatory=$True)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [String] $APIPublicAddress,
        [Parameter(Mandatory=$False)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [String] $ManagementPublicAddress
    )
    # Cast the provided URI's into URI objects to extract what we need for the API calls
    [system.uri] $PublicAPIURI = $APIPublicAddress
    [system.uri] $InternalAPIURI = $ManagementPublicAddress

    # Make the API call to adjust the endpoints
    $URI = $global:DefaultvCAVServer.ServiceURI + "config/endpoints"
    $objSiteConfig = New-Object System.Management.Automation.PSObject
    $objSiteConfig | Add-Member Note* apiPublicAddress $PublicAPIURI.Host
    $objSiteConfig | Add-Member Note* apiPublicPort $PublicAPIURI.Port
    $objSiteConfig | Add-Member Note* mgmtPublicAddress $InternalAPIURI.Host
    $objSiteConfig | Add-Member Note* mgmtPublicPort $InternalAPIURI.Port
    $RequestResponse = (Invoke-vCAVAPIRequest -URI $URI -Data (ConvertTo-JSON $objSiteConfig) -Method Post -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
    $RequestResponse
}