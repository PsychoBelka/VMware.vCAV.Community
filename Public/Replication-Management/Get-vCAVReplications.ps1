function Get-vCAVReplications() {
    <#
    .SYNOPSIS
    Query and return a collection of configured VM or vApp-level Replications from the currently connected vCloud Availability service.

    .DESCRIPTION
    Query and return a collection of configured VM or vApp-level Replications from the currently connected vCloud Availability service.

    By default the cmdlet will return the vApp Replications for the currently connected vCloud Availability Service.

    .PARAMETER VM
    Switch to query Replications by VM

    .PARAMETER vApp
    Switch to query Replications by vApp

    .PARAMETER ReplicationId
    The vCloud Availability C4 vApp/VM replication IDs
    If present, the returned Replications with the matching Id's will be returned. Comma-separated C4 vApp replication IDs are expected.

    .PARAMETER SourceSite
    The Name of the Source vCloud Availability Site Name to filter Replications

    .PARAMETER DestinationSite
    The Name of the Destination vCloud Availability Site Name to filter Replications

    .PARAMETER SourceSiteType
    The source site type. The allowed allows are vcloud or vcenter.
    Default: vcloud

    .PARAMETER DestinationSiteType
    The destination site type. The allowed allows are vcloud or vcenter.

    .PARAMETER DestinationOrg
    The Name of the Destination vCloud Director Organisation to filter Replications

    .PARAMETER DestinationOrgVdcId
    The Id of the destination vCloud Director Org VDC to filter Replications

    .PARAMETER DestinationOrgVdcName
    The Name of the destination vCloud Director Org VDC to filter Replications

    .PARAMETER SourceOrg
    The Name of the Source vCloud Director Organisation to filter Replications

    .PARAMETER SourceOrgVdcId
    The Id of the source vCloud Director Org VDC to filter Replications

    .PARAMETER SourceOrgVdcName
    The Name of the source vCloud Director Org VDC to filter Replications

    .PARAMETER ReplicationOwner
    The User Id of the Replication Owner in <user>@<org> format.
    If present, returned replications will be filtered by replication owner. Filtering option available only to vCloud Availability administrators.

    .PARAMETER vAppId
    The Source vApp Id

    .PARAMETER vAppName
    The vCloud Director vApp Name

    .PARAMETER VMId
    The Source VM Id

    .PARAMETER VMName
    The vCloud Director VM Name

    .EXAMPLE
    Get-vCAVReplications -VM -ReplicationId "C4-979cf8cc-fcda-4772-907b-6aa1ba929243"
    Returns the vCloud Availability VM replications with the Replication Id of C4-979cf8cc-fcda-4772-907b-6aa1ba929243

    .EXAMPLE
    Get-vCAVReplications -vApp -ReplicationId "C4VAPP-b1d604d4-e2fb-411a-9c6e-47cb81f8741c"
    Returns the vCloud Availability vApp replications with the Replication Id of C4VAPP-b1d604d4-e2fb-411a-9c6e-47cb81f8741c

    .EXAMPLE
    Get-vCAVReplications -VM
    Returns all vApp Replications from the local vCloud Availability Service

    .EXAMPLE
    Get-vCAVReplications -vApp
    Returns all vApp Replications from the local vCloud Availability Service

    .EXAMPLE
    Get-vCAVReplications -vApp -SourceSite "Pigeon-Nuggets-Site-A" -DestinationSite "Pigeon-Nuggets-Site-B"
    Returns all vApp Replications between source site "Pigeon-Nuggets-Site-A"  and destination site "Pigeon-Nuggets-Site-B". Please note this requires the local session to be extended to the remote site to succeed.

    .EXAMPLE
    Get-vCAVReplications -VM -VMName "VM%"
    Returns all VM Replications with the VM name starts with VM

    .EXAMPLE
    Get-vCAVReplication -Summary
    Returns a summary of vCAV Replications (Dashboard View).

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-06-27
	VERSION: 2.1
    #>
    [CmdletBinding(DefaultParameterSetName = "vApp")]
    Param(
        [Parameter(Mandatory=$False, ParameterSetName="VM")]
            [switch]$VM,
        [Parameter(Mandatory=$False, ParameterSetName="vApp")]
            [switch]$vApp,
        [Parameter(Mandatory=$False, ParameterSetName="Summary")]
            [switch]$Summary,
        [Parameter(Mandatory=$False, ValueFromPipeline=$True)]
            [ValidateNotNullorEmpty()] [String] $ReplicationId,
        [Parameter(Mandatory=$False)]
            [ValidateSet("vcloud","vcenter")] [string] $SourceSiteType = "vcloud",
            [ValidateSet("vcloud","vcenter")] [string] $DestinationSiteType,
            [ValidateNotNullorEmpty()] [String] $SourceSite,
            [ValidateNotNullorEmpty()] [String] $DestinationSite,
            [ValidateNotNullorEmpty()] [String] $DestinationOrg,
            [ValidateNotNullorEmpty()] [String] $DestinationOrgVdcId,
            [ValidateNotNullorEmpty()] [String] $DestinationOrgVdcName,
            [ValidateNotNullorEmpty()] [String] $SourceOrg,
            [ValidateNotNullorEmpty()] [String] $SourceOrgVdcId,
            [ValidateNotNullorEmpty()] [String] $SourceOrgVdcName,
            [ValidateNotNullorEmpty()] [String] $ReplicationOwner,
            [switch] $IncludeInstances,
            [ValidateSet("GREEN","YELLOW","RED")] [String] $OverallHealth,
        [Parameter(Mandatory=$False, ParameterSetName="vApp")]
            [ValidateNotNullorEmpty()] [String] $vAppId,
        [Parameter(Mandatory=$False, ParameterSetName="vApp")]
            [ValidateNotNullorEmpty()] [String] $vAppName,
        [Parameter(Mandatory=$False, ParameterSetName="VM")]
            [ValidateNotNullorEmpty()] [String] $VMId,
        [Parameter(Mandatory=$False, ParameterSetName="VM")]
            [ValidateNotNullorEmpty()] [String] $VMName
    )
    #region: Filters
    #Create a Hashtable with the base filters
    [HashTable]$QueryFilters = @{
        offset         = 0
        limit          = 100
        sourceSiteType = $SourceSiteType
    }
    # Check the replication types
    if($PSBoundParameters.ContainsKey("DestinationSiteType")){
        $QueryFilters.Add("destinationSiteType", $DestinationSiteType)
    }
    # Check if a Replication Id has been provided and add to the filter if present
    if ($PSBoundParameters.ContainsKey("ReplicationId")) {
        $QueryFilters.Add("ids", $ReplicationId)
    }
    # If a Source Site has been provided check that the site exists and add to the query parameter
    if($PSBoundParameters.ContainsKey("SourceSite")){
        [bool] $SiteExists = ($null -ne (Get-vCAVSites -SiteName $SourceSite))
        if($SiteExists){
            $QueryFilters.Add("sourceSite", $SourceSite)
        }
        else {
            throw "The provided source site does not exist in this installation. Please check the site name and try again."
        }
    }
    if($PSBoundParameters.ContainsKey("DestinationSite")){
        [bool] $SiteExists = ($null -ne (Get-vCAVSites -SiteName $DestinationSite))
        if($SiteExists){
            $QueryFilters.Add("site", $DestinationSite)
        }
        else {
            throw "The provided destination site does not exist in this installation. Please check the site name and try again."
        }
    }
    if ($PSBoundParameters.ContainsKey("DestinationOrg")) {
        $QueryFilters.Add("destinationOrg", $DestinationOrg)
    }
    if ($PSBoundParameters.ContainsKey("DestinationOrgVdcId")) {
        $QueryFilters.Add("destinationVdcId", $DestinationOrgVdcId)
    }
    if ($PSBoundParameters.ContainsKey("DestinationOrgVdcName")) {
        $QueryFilters.Add("destinationVdcName", $DestinationOrgVdcName)
    }
    if ($PSBoundParameters.ContainsKey("SourceOrg")) {
        $QueryFilters.Add("sourceOrg", $SourceOrg)
    }
    if ($PSBoundParameters.ContainsKey("SourceOrgVdcId")) {
        $QueryFilters.Add("sourceVdcId", $SourceOrgVdcId)
    }
    if ($PSBoundParameters.ContainsKey("SourceOrgVdcName")) {
        $QueryFilters.Add("sourceVdcName", $SourceOrgVdcName)
    }
    if ($PSBoundParameters.ContainsKey("ReplicationOwner")) {
        $QueryFilters.Add("owner", $ReplicationOwner)
    }
    if ($PSCmdlet.ParameterSetName -eq "vApp") {
        if ($PSBoundParameters.ContainsKey("vAppId")) {
            $QueryFilters.Add("vappId", $vAppId)
        }
        if ($PSBoundParameters.ContainsKey("vAppName")) {
            $QueryFilters.Add("vappName", $vAppName)
        }
    }
    if ($PSCmdlet.ParameterSetName -eq "VM") {
        if ($PSBoundParameters.ContainsKey("VMId")) {
            $QueryFilters.Add("vmId", $VMId)
        }
        if ($PSBoundParameters.ContainsKey("VMName")) {
            $QueryFilters.Add("vmName", $VMName)
        }
    }
    #endrgeion
    # Set the API endpoint based on if the query type is for VM or vApp Replications
    if ($PSCmdlet.ParameterSetName -eq "vApp") {
        $URI = $global:DefaultvCAVServer.ServiceURI + "vapp-replications"
    }
    elseif ($PSCmdlet.ParameterSetName -eq "VM") {
        $URI = $global:DefaultvCAVServer.ServiceURI + "vm-replications"
    }
    if ($PSCmdlet.ParameterSetName -eq "Summary") {
        $URI = $global:DefaultvCAVServer.ServiceURI + "vapp-replications/summary"
        $colvAppReplications = (Invoke-vCAVAPIRequest -URI $URI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
    }
    else {
        # Now make the first call to the API and add the items to a collection
        $ReplicationQueryResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion -QueryParameters $QueryFilters).JSONData
        $colvAppReplications = $ReplicationQueryResponse.items
        # Check if more then 100 results were returned and continue to query until all items have been returned
        [int] $OffsetPosition = 100 # Set the starting offset to 100 results
        while ($OffsetPosition -lt $ReplicationQueryResponse.total) {
            $QueryFilters.offset = $OffsetPosition
            $RequestResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion -QueryParameters $QueryFilters).JSONData
            $colvAppReplications += $RequestResponse.items
            $OffsetPosition += 100
        }
    }
    if($PSBoundParameters.ContainsKey("OverallHealth")){
        $colvAppReplications = $colvAppReplications | Where-Object{$_.overallHealth -eq $OverallHealth}
    }
    # If provided need to query the instances as well
    if ($PSBoundParameters.ContainsKey("IncludeInstances")) {
        foreach ($objReplication in $colvAppReplications) {
            # If vApp Replication, need to get the instances per VM; so for vApp need to iterate over all the VMs and build a collection
            if ($objReplication.vmReplications.Count -gt 0) {
                foreach ($objVMReplication in $objReplication.vmReplications) {
                    $URI = $global:DefaultvCAVServer.ServiceURI + "vm-replications/$($objVMReplication.id)/instances"
                    $colInstances = (Invoke-vCAVAPIRequest -URI $URI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
                    $objVMReplication | Add-Member Note* ReplicationInstances $colInstances
                }
            }
            else {
                # If VM Replications just need to get the Instances for the VM
                $URI = $global:DefaultvCAVServer.ServiceURI + "vm-replications/$($objReplication.id)/instances"
                $colInstances = (Invoke-vCAVAPIRequest -URI $URI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
                $objReplication | Add-Member Note* ReplicationInstances $colInstances
            }
        }
    }
    # After all results have been collected return the results
    $colvAppReplications
}
