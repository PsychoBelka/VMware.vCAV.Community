function Get-vCAVOrgVDCNetwork(){
    <#
    .SYNOPSIS
    This cmdlet returns the Org VDC Networks available to a provided Org VDC.

    .DESCRIPTION
    This cmdlet returns the Org VDC Networks available to a provided Org VDC.

    .PARAMETER OrgVDCName
    The Name of a vCloud Organisational Virtual Datacenter (OrgVDC)

    .EXAMPLE
    Get-vCAVOrgVDCNetwork -OrgVDCName "payg-dca-pigeonnuggets"
    Returns the vCloud Org VDC Networks assosicated with the OrgVDC "payg-dca-pigeonnuggets" if it exists.

    Get-vCAVOrgVDCNetwork -OrgVDCName "payg-dca-pigeonnuggets" -NetworkName "Test"
    Returns the vCloud Org VDC Networks named "Test" assosicated with the OrgVDC "payg-dca-pigeonnuggets" if it exists.

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 1.0
    #>
    Param(
		[Parameter(Mandatory=$True, ValueFromPipeline=$True)]
            [ValidateNotNullorEmpty()] [String] $OrgVDCName,
        [Parameter(Mandatory=$False, ValueFromPipeline=$True)]
            [ValidateNotNullorEmpty()] [String] $NetworkName,
        [Parameter(Mandatory=$False, ValueFromPipeline=$True)]
            [ValidateNotNullorEmpty()] [String] $Site = ((Get-vCAVSites -SiteType "Local").site)
    )
    #Create a Hashtable with the base filters
    [HashTable]$QueryFilters = @{
        offset = 0
        limit = 1000
        site = $Site
    }
    # First try and get the OrgVDC
    $OrgVDC = Get-vCAVOrgVDC -Name $OrgVDCName -Site $Site
    if($OrgVDC.count -eq 0){
        throw "An OrgVDC with the provided name $OrgVDCName can not be found in site $Site. Please check the values and that you have access to this resource."
    }
    # Next construct the API endpoint address from the OrgVDC Id
    $URI = $global:DefaultvCAVServer.ServiceURI + "inventory/vdcs/$($OrgVDC.id)/networks"

    $colOrgVDCNetworkQueryResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Get  -QueryParameters $QueryFilters).JSONData
    $colOrgVDCNets = $colOrgVDCNetworkQueryResponse.items
    # Check if more then 1000 results were returned and continue to query until all items have been returned
    [int] $OffsetPosition = 1000 # Set the starting offset to 1000 results
    while($OffsetPosition -lt $colOrgVDCNetworkQueryResponse.total){
        $QueryFilters.offset = $OffsetPosition
        $RequestResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Get  -QueryParameters $QueryFilters).JSONData
        $colOrgVDCNets += $RequestResponse.items
        $OffsetPosition += 1000
    }
    # Finally filter on the Network Name if required (this has to be done post call at present)
    if($PSBoundParameters.ContainsKey("NetworkName")){
    # Check if a filter has been provided for the name
        $colOrgVDCNets | Where-Object {$_.name -eq $NetworkName}
    } else {
        $colOrgVDCNets
    }
}