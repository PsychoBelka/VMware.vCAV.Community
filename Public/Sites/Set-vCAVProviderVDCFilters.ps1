function Set-vCAVProviderVDCFilters(){
    <#
    .SYNOPSIS
    Sets a filter on the currently connected vCloud Availability service to restrict the accessible Provider VDCs to vCloud Availability.

    .DESCRIPTION
    This cmdlet can be used in order to support the following use cases for vCloud Availability:
    - Datacenters in different locations managed by a single vCD (for example when seperate vCloud Availability instances are in each DC and scope/backed by PVDCs in each location)
    - For leveraging vCloud Availability with multiple unfederated VCs as well as with dedicated customer VCs

    .EXAMPLE
    Set-vCAVProviderVDCFilters -ProvidedVDCIds @("2241c7fe-7319-4d89-bf0e-3eb647474416","38d407ce-9d5c-4c96-90d5-63e9749dfa44")
    Sets the Provider VDC filter for the currently connected vCloud Availabilty service to the Provider VDCs with the Ids "2241c7fe-7319-4d89-bf0e-3eb647474416" and "38d407ce-9d5c-4c96-90d5-63e9749dfa44" overwriting any currently configured filters

    .EXAMPLE
    Set-vCAVProviderVDCFilters -ProvidedVDCIds "2241c7fe-7319-4d89-bf0e-3eb647474416" -Preserve
    Adds a new Provider VDC with the Id "2241c7fe-7319-4d89-bf0e-3eb647474416" to the Provider VDC filter for the currently connected vCloud Availabilty service and preserves the currently configured filters.

    .EXAMPLE
    Set-vCAVProviderVDCFilters -Reset
    Removes any Provider VDC filters and makes all Provider VDCs in the currently connected vCloud Availabilty service available.

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-09-17
	VERSION: 1.0
    #>
    Param(
        [Parameter(Mandatory=$True, ParameterSetName="Set", ValueFromPipeline=$True)]
            [ValidateNotNullorEmpty()] [String[]] $ProvidedVDCIds,
        [Parameter(Mandatory=$False, ParameterSetName="Set")]
            [switch]$Preserve,
        [Parameter(Mandatory=$False, ParameterSetName="Reset")]
            [switch]$Reset
    )
    # Check the environment is correct/supported
    if($DefaultvCAVServer.DefaultAPIVersion -lt "4"){
        throw "This cmdlet is only supported on vCloud Availability API version 4 or higher. The current default API version is $($DefaultvCAVServer.DefaultAPIVersion)"
    }
    if($DefaultvCAVServer.buildVersion -lt "3.5"){
        throw "This cmdlet is only supported on vCloud Availability 3.5+. The current connected version is $($DefaultvCAVServer.buildVersion)"
    }
    # First check if a set or a reset Operation
    [PSObject[]] $colFilters = @()
    if(!$PSBoundParameters.ContainsKey("Reset")){
        # Check if the provided Provider VDCs are valid
        foreach($objProviderVDC in $ProvidedVDCIds){
            if($null -eq (Get-vCAVProviderVDCs -Id $objProviderVDC)){
                throw "The Provider VDC with the Id $objProviderVDC does not exist in the current installation. Please check the Id and try the cmdlet again."
            }
        }
        # If the preserve filter is provided retrieve a list of currently configured filters
        [PSObject[]] $colFilters = @()
        if($PSBoundParameters.ContainsKey("Preserve")){
            $colFilters += (Get-vCAVProviderVDCFilters | Select-Object Id).id
            $colFilters += $ProvidedVDCIds
        } else {
            $colFilters = $ProvidedVDCIds
        }
        # Filter any duplicates in the event that Preserve was provided
        $colFilters = $colFilters | Select-Object -Unique
    }

    # Make the API call to set the filters
    $URI = $global:DefaultvCAVServer.ServiceURI + "config/pvdc-filter"
    (Invoke-vCAVAPIRequest -URI $URI -Method Post -Data (ConvertTo-JSON $colFilters) -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData > $null
    # Now return the currently connected filters
    Get-vCAVProviderVDCFilters
}