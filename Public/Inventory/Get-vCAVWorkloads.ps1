function Get-vCAVWorkloads(){
    <#
    .SYNOPSIS
    Returns an inventory of Cloud or On-Premises workloads available in the connected vCloud Availability installation.

    .DESCRIPTION
    Returns an inventory of Cloud or On-Premises workloads available in the connected vCloud Availability installation.

    Default for vCloud is to return the vApp worklods. This behaviour can be controlled by using the -VM/-vApp switches

    .PARAMETER vCloud
    Specifies that vCloud based workloads should be returned

    .PARAMETER vCenter
    Specifies that On-Premises based workloads should be returned

    .PARAMETER SiteName
    The On-Premises or Cloud Site Name

    .PARAMETER VM
    Switch to return VM workloads

    .PARAMETER vApp
    Switch to return vApp workloads

    .PARAMETER Id
    An optional Id of the Workload to filter on

    .EXAMPLE
    Get-vCAVWorkloads
    Returns the vCloud vApp based workloads in the local site.

    .EXAMPLE
    Get-vCAVWorkloads -vCloud -VM
    Returns the vCloud VM based workloads in the local site.

    .EXAMPLE
    Get-vCAVWorkloads -vCloud -SiteName "Site-B"
    Returns the vCloud vApp based workloads in the vCloud Availability site "Site-B".

    .EXAMPLE
    Get-vCAVWorkloads -vCenter -SiteName "PigeonNuggets_OnPrem"
    Returns the vCenter based workloads for all registered vCenters in the customer site "PigeonNuggets_OnPrem"

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 1.0
    #>
    [CmdletBinding(DefaultParameterSetName="vCloud-vApp")]
    Param(
        [Parameter(Mandatory=$False, ParameterSetName="vCloud-vApp")]
        [Parameter(Mandatory=$False, ParameterSetName="vCloud-VM")]
            [switch]$vCloud,
        [Parameter(Mandatory=$False, ParameterSetName="vCloud-VM")]
            [switch]$VM,
        [Parameter(Mandatory=$False, ParameterSetName="vCloud-vApp")]
            [switch]$vApp,
        [Parameter(Mandatory=$False, ParameterSetName="vCenter")]
            [switch]$vCenter,
        [Parameter(Mandatory=$False, ParameterSetName="vCloud-vApp")]
        [Parameter(Mandatory=$False, ParameterSetName="vCloud-VM")]
        [Parameter(Mandatory=$True, ParameterSetName="vCenter")]
            [ValidateNotNullorEmpty()] [String] $SiteName,
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [String] $Id
    )
    # Set the API endpoint
    if($PSCmdlet.ParameterSetName -in ("vCloud-VM","vCloud-vApp")){
        if(!$PSBoundParameters.ContainsKey("SiteName")){
            $SiteName = ((Get-vCAVSites -SiteType "Local").site)
        }
        if($PSBoundParameters.ContainsKey("VM")){
            $URI = $global:DefaultvCAVServer.ServiceURI + "inventory/vms"
        } else {
            $URI = $global:DefaultvCAVServer.ServiceURI + "inventory/vapps"
        }
        #Create a Hashtable with the base filters
        [HashTable]$QueryFilters = @{
            offset = 0
            limit = 100
            site = $SiteName
        }
        # Now make the API call for the objects
        # Now make the first call to the API and add the items to a collection
        $RequestResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Get  -QueryParameters $QueryFilters).JSONData
        $colWorkloads = $RequestResponse.items
        [int] $OffsetPosition = 100 # Set the starting offset to 100 results
        while($OffsetPosition -lt $RequestResponse.total){
            $QueryFilters.offset = $OffsetPosition
            $RequestResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Get  -QueryParameters $QueryFilters).JSONData
            $colWorkloads += $RequestResponse.items
            $OffsetPosition += 100
        }
        if($PSBoundParameters.ContainsKey("Id")){
            $colWorkloads | Where-Object {$_.id -eq $Id}
        } else {
            $colWorkloads
        }
    } elseif($PSCmdlet.ParameterSetName -eq "vCenter"){
        # Check if the Site with the provided Name exists
        $vCenterSite = (Get-vCAVCustomerSites -SiteName $SiteName)
        $URI = $global:DefaultvCAVServer.ServiceURI + "vc-sites/$SiteName"
        # Make the API call for each vCenter
        foreach($vCenterServer in $vCenterSite.vCenters){
            $vCenterURI = "$URI/$($vCenterServer.vcId)/vms"
            $RequestResponse = (Invoke-vCAVAPIRequest -URI $vCenterURI -Method Get  -QueryParameters $QueryFilters).JSONData
            $colVMs += $RequestResponse.items
            while($OffsetPosition -lt $RequestResponse.total){
                $QueryFilters.offset = $OffsetPosition
                $RequestResponse = (Invoke-vCAVAPIRequest -URI $vCenterURI -Method Get  -QueryParameters $QueryFilters).JSONData
                $colVMs += $RequestResponse.items
                $OffsetPosition += 100
            }
        }
        if($PSBoundParameters.ContainsKey("Id")){
            $colVMs | Where-Object {$_.id -eq $Id}
        } else {
            $colVMs
        }
    }
}
