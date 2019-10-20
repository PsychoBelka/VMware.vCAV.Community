function Get-vCAVTenantOrg(){
    <#
    .SYNOPSIS
    Get a list of vCloud Tenant Organisations available to vCloud Availability.

    .DESCRIPTION
    Get a list of vCloud Tenant Organisations available to vCloud Availability.

    .PARAMETER OrgName
    A vCloud Director vOrg Name

    .PARAMETER SiteName
    A vCloud Availability Site Name
    Default: Local Site

    .EXAMPLE
    Get-vCAVTenantOrg -SiteName "PigeonNuggets-SiteA"
    Returns all vOrgs in the  site "PigeonNuggets-SiteA"

    .EXAMPLE
    Get-vCAVTenantOrg -SiteName "PigeonNuggets-SiteA" -OrgName "TestOrg"
    Returns the object for the vOrgs "TestOrg" in the  site "PigeonNuggets-SiteA" if it exists.

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-07-19
	VERSION: 2.0
    #>
    Param(
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [String] $OrgName,
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [String] $SiteName = ((Get-vCAVSites -SiteType "Local").site)
    )
    #Create a Hashtable with the base filters
    [HashTable]$QueryFilters = @{
        offset = 0
        limit = 100
        site = $SiteName
    }
    $URI = $global:DefaultvCAVServer.ServiceURI + "inventory/orgs"
    # Now make the first call to the API and add the items to a collection
    $RequestResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion -QueryParameters $QueryFilters).JSONData
    $colOrganisations = $RequestResponse.items
    # Check if more then 100 results were returned and continue to query until all items have been returned
    [int] $OffsetPosition = 100 # Set the starting offset to 100 results
    while($OffsetPosition -lt $RequestResponse.total){
        $QueryFilters.offset = $OffsetPosition
        $RequestResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion -QueryParameters $QueryFilters).JSONData
        $colOrganisations += $RequestResponse.items
        $OffsetPosition += 100
    }
    if($PSBoundParameters.ContainsKey("OrgName")){
        $colOrganisations | Where-Object {$_.name -eq $OrgName}
    } else {
        $colOrganisations
    }
}