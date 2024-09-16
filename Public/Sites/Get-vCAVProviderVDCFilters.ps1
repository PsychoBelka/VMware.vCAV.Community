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
    if($DefaultvCAVServer.DefaultAPIVersion -lt "4"){
        throw "This cmdlet is only supported on vCloud Availability API version 4 or higher. The current default API version is $($DefaultvCAVServer.DefaultAPIVersion)"
    }
    if($DefaultvCAVServer.buildVersion -lt "3.5"){
        throw "This cmdlet is only supported on vCloud Availability 3.5+. The current connected version is $($DefaultvCAVServer.buildVersion)"
    }
    $URI = $global:DefaultvCAVServer.ServiceURI + "config/pvdc-filter"
    $colFilters = (Invoke-vCAVAPIRequest -URI $URI -Method Get ).JSONData
    [PSObject[]] $colPVDCs = @()
    foreach($pVDCId in $colFilters){
        $colPVDCs += Get-vCAVProviderVDCs -Id $pVDCId
    }
    $colPVDCs
}