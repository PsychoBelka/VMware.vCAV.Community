function Get-vCAVStorageProfile(){
    <#
    .SYNOPSIS
    This cmdlet returns the Storage Profiles available to a provided Org VDCs in the currently connected vCloud Availability service.

    .DESCRIPTION
    This cmdlet returns the Storage Profiles available to a provided Org VDCs in the currently connected vCloud Availability service.

    .PARAMETER OrgVDCName
    A Name of a vCloud Organisational Virtual Datacenter (OrgVDC)

    .PARAMETER Site
    Optionally the vCloud Availability site. Default is the local site.

    .PARAMETER StorageProfile
    Optionally the name of the Storage Profile to filter.

    .EXAMPLE
    Get-vCAVStorageProfile -OrgVDCName "payg-dca-pigeonnuggets"
    Returns the Storage Profiles assosicated with the vCloud Org VDC with the name "payg-dca-pigeonnuggets".

    .EXAMPLE
    Get-vCAVStorageProfile -OrgVDCName "payg-dca-pigeonnuggets" -StorageProfile "Gold"
    Returns the Storage Profiles named "Gold" assosicated with the vCloud Org VDC with the name "payg-dca-pigeonnuggets" if it exists.

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 1.0
    #>
    Param(
		[Parameter(Mandatory=$True, ValueFromPipeline=$True)]
            [ValidateNotNullorEmpty()] [String] $OrgVDCName,
        [Parameter(Mandatory=$False, ValueFromPipeline=$True)]
            [ValidateNotNullorEmpty()] [String] $StorageProfile,
        [Parameter(Mandatory=$False, ValueFromPipeline=$True)]
            [ValidateNotNullorEmpty()] [String] $Site = ((Get-vCAVSites -SiteType "Local").site)
    )
    #Create a Hashtable with the base filters
    [HashTable]$QueryFilters = @{
        site = $Site
    }
    # First try and get the OrgVDC
    $OrgVDC = Get-vCAVOrgVDC -Name $OrgVDCName -Site $Site
    if($OrgVDC.count -eq 0){
        throw "An OrgVDC with the provided name $OrgVDCName can not be found in site $Site. Please check the values and that you have access to this resource."
    }
    # Next construct the API endpoint address from the OrgVDC Id
    $URI = $global:DefaultvCAVServer.ServiceURI + "inventory/vdcs/$($OrgVDC.id)/storage-profiles"
    $colOrgVDCStorageResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Get  -QueryParameters $QueryFilters).JSONData
    $colOrgVDCStorageProfiles = $colOrgVDCStorageResponse
    # Finally filter on the Storage Profile Name if required (this has to be done post call at present)
    if($PSBoundParameters.ContainsKey("StorageProfile")){
    # Check if a filter has been provided for the name
        $colOrgVDCStorageProfiles | Where-Object {$_.name -eq $StorageProfile}
    } else {
        $colOrgVDCStorageProfiles
    }
}