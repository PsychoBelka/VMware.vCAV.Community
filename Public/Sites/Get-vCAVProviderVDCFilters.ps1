function Get-vCAVProviderVDCFilters(){
    <#
    .SYNOPSIS
    Returns a collection of filtered Provider VDCs for the currently connected vCloud Availability Service.

    .DESCRIPTION
    Returns a collection of filtered Provider VDCs for the currently connected vCloud Availability Service.

    If no filters are applied the service can access all Provider VDCs which are returned by Get-vCAVProviderVDCs.

    .EXAMPLE
    Get-vCAVProviderVDCFilters
    Returns a collection of the accessible Provider VDCs if a filter is applied. If nothing is returned all Provider VDCs are accessible.

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 1.0
    #>
    $URI = $global:DefaultvCAVServer.ServiceURI + "config/pvdc-filter"
    $colFilters = (Invoke-vCAVAPIRequest -URI $URI -Method Get ).JSONData
    [PSObject[]] $colPVDCs = @()
    foreach($pVDCId in $colFilters){
        $colPVDCs += Get-vCAVProviderVDCs -Id $pVDCId
    }
    $colPVDCs
}