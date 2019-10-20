function Get-vCAVProviderVDCs(){
    <#
    .SYNOPSIS
    This cmdlet returns the Provider VDCs available in the vCloud instance currently connected vCloud Availability service.

    .DESCRIPTION
    This cmdlet returns the Provider VDCs available in the vCloud instance currently connected vCloud Availability service.

    .PARAMETER Name
    A Name of a vCloud Provider Virtual Datacenter (PVDC) to filter results by

    .PARAMETER Id
    A Id of a vCloud Provider Virtual Datacenter (PVDC) to filter results by

    .PARAMETER Site
    Optionally the vCloud Availability site. Default is the local site.

    .EXAMPLE
    Get-vCAVProviderVDCs
    Returns all the Provider Virtual Datacenter in the local site.

    .EXAMPLE
    Get-vCAVProviderVDCs -Name "SiteA-PVDC-1"
    Returns the Provider Virtual Datacenter with the Provder VDC Name "SiteA-PVDC-1" in the local site.

    .EXAMPLE
    Get-vCAVProviderVDCs -Id "2241c7fe-7319-4d89-bf0e-3eb647474416"
    Returns the Provider Virtual Datacenter with the Provder VDC Id "2241c7fe-7319-4d89-bf0e-3eb647474416" in the local site.

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-09-17
	VERSION: 1.0
    #>
    [CmdletBinding(DefaultParameterSetName="Default")]
    Param(
        [Parameter(Mandatory=$False, ParameterSetName="ByName")]
            [ValidateNotNullorEmpty()] [String] $Name,
        [Parameter(Mandatory=$False, ParameterSetName="ById", ValueFromPipeline=$True)]
            [ValidateNotNullorEmpty()] [String] $Id,
        [Parameter(Mandatory=$False, ValueFromPipeline=$False)]
            [ValidateNotNullorEmpty()] [String] $Site = ((Get-vCAVSites -SiteType "Local").site)
    )
    #Create a Hashtable with the base filters
    [HashTable]$QueryFilters = @{
        site = $Site
    }
    # API Endpoint for Provider VDCs
    $URI = $global:DefaultvCAVServer.ServiceURI + "inventory/provider-vdcs"
    $colProviderVDC = (Invoke-vCAVAPIRequest -URI $URI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion -QueryParameters $QueryFilters).JSONData

    # Finally filter on the Provider VDC Name if required
    if($PSBoundParameters.ContainsKey("Name")){
    # Check if a filter has been provided for the name
            $colProviderVDC | Where-Object {$_.name -eq $Name}
    } elseif($PSBoundParameters.ContainsKey("Id")){
        $colProviderVDC | Where-Object {$_.id -eq $Id}
    } else {
            $colProviderVDC
    }
}