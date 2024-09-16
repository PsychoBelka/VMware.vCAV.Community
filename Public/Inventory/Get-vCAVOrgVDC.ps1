function Get-vCAVOrgVDC(){
    <#
    .SYNOPSIS
    This cmdlet returns the Org VDCs available to the logged in user in the currently connected vCloud Availability service.

    .DESCRIPTION
    This cmdlet returns the Org VDCs available to the logged in user in the currently connected vCloud Availability service.

    .PARAMETER Name
    A Name of a vCloud Organisational Virtual Datacenter (OrgVDC)

    .PARAMETER Id
    An Id of vCloud Organisational Virtual Datacenter (OrgVDC)

    .PARAMETER Site
    Optionally the vCloud Availability site. Default is the local site.

    .EXAMPLE
    Get-vCAVOrgVDC -Name "payg-dca-pigeonnuggets"
    Returns the vCloud Org VDC with the name "payg-dca-pigeonnuggets" if it exists.

    .EXAMPLE
    Get-vCAVOrgVDC -Id "49c2a2f1-721f-4b29-88bc-333be435102a"
    Returns the vCloud Org VDC with the Id "49c2a2f1-721f-4b29-88bc-333be435102a" if it exists.

    .EXAMPLE
    Get-vCAVOrgVDC -Id "49c2a2f1-721f-4b29-88bc-333be435102a" -Site "PigeonNuggets-SiteA"
    Returns the vCloud Org VDC with the Id "49c2a2f1-721f-4b29-88bc-333be435102a" in Site "PigeonNuggets-SiteA" if it exists.

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 1.0
    #>
    [CmdletBinding(DefaultParameterSetName="Default")]
    Param(
        [Parameter(Mandatory=$True, ParameterSetName="ByName")]
            [ValidateNotNullorEmpty()] [String] $Name,
        [Parameter(Mandatory=$True, ParameterSetName="ById")]
            [ValidateNotNullorEmpty()] [String] $Id,
        [Parameter(Mandatory=$False, ValueFromPipeline=$False)]
            [ValidateNotNullorEmpty()] [String] $Site = ((Get-vCAVSites -SiteType "Local").site)
    )
    #Create a Hashtable with the base filters
    [HashTable]$QueryFilters = @{
        offset = 0
        limit = 100
    }
    # Set the API endpoint
    $URI = $global:DefaultvCAVServer.ServiceURI + "inventory/vdcs"
    if($PSBoundParameters.ContainsKey("Name")){
        # Check if a filter has been provided for the name
        $QueryFilters.Add("name", $Name)
    }
    # Make the API call for the OrgVDC inventory
    $colOrgVDCQueryResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Get  -QueryParameters $QueryFilters).JSONData
    $colOrgVDC = $colOrgVDCQueryResponse.items
    # Check if more then 100 results were returned and continue to query until all items have been returned
    [int] $OffsetPosition = 100 # Set the starting offset to 100 results
    while($OffsetPosition -lt $colOrgVDCQueryResponse.total){
        $QueryFilters.offset = $OffsetPosition
        $RequestResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Get  -QueryParameters $QueryFilters).JSONData
        $colOrgVDC += $RequestResponse.items
        $OffsetPosition += 100
    }
    # Finally filter on the Id if required (this has to be done post call at present)
    if($PSBoundParameters.ContainsKey("Id")){
        # Check if a filter has been provided for the name
        $colOrgVDC | Where-Object {$_.id -eq $Id}
    } else {
        $colOrgVDC
    }
}