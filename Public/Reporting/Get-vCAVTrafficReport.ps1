function Get-vCAVTrafficReport(){
    <#
    .SYNOPSIS
    Retrieves Traffic Reporting data from vCloud Availability for a provided tenant or Virtual Machine Replication

    .DESCRIPTION
    Retrieves Traffic Reporting data from vCloud Availability for a provided tenant or Virtual Machine Replication.

    vCloud Availability Replication Manager collects the traffic information for all replications to cloud sites and to on premises sites and for all replications from cloud sites and from on premises sites and aggregates the traffic information by organization.

    The replication data traffic is always collected by the cloud vCloud Availability Replicator instance, regardless of the direction of the replication. The traffic count includes the replication protocol overhead and TLS overhead and excludes TCP/IP/Ethernet/VPN overhead. If the stream is compressed, the vCloud Availability Replicator counts the compressed bytes.

    Every 300 seconds, the vCloud Availability Replication Manager records to its persistent storage the historical traffic information from all connected vCloud Availability Replicator instances.

    .PARAMETER VMReplicationId
    The vCloud Availability C4 VM replication ID for generating a VM Replication report

    .PARAMETER OrgName
    The vOrg Name of the Organisation for generating a Org Based summary report

    .PARAMETER Site
    The Site (used for scoping the where the data transfer is reported)

    .PARAMETER Resolution
    The resolution or interval in seconds that the traffic usage data points should be aggegated.
    Default: 300 (5 minutes)

    .PARAMETER StartTime
    The Start Time for the Reporting Period

    .PARAMETER EndTime
    The End Time for the Reporting Period

    .PARAMETER Realtime
    If set only the single point-in-time (current) data transfer rate will be returned.

    .EXAMPLE
    Get-vCAVTrafficReport -VMReplicationId "C4-b01fb143-609d-4d84-9864-f1250b184180" -Realtime
    Returns the current replication data traffic of the Replication with the replication Id "C4-b01fb143-609d-4d84-9864-f1250b184180"

    .EXAMPLE
    Get-vCAVTrafficReport -VMReplicationId "C4-b01fb143-609d-4d84-9864-f1250b184180" -StartTime ((Get-Date).AddDays(-1)) -EndTime (Get-Date)
    Returns the replication data traffic for the Replication with the replication Id "C4-b01fb143-609d-4d84-9864-f1250b184180" in 5 minute samples for the last 24 hours

    .EXAMPLE
    Get-vCAVTrafficReport -VMReplicationId "C4-b01fb143-609d-4d84-9864-f1250b184180" -Resolution 3600 -StartTime ((Get-Date).AddDays(-7)) -EndTime (Get-Date)
    Returns the replication data traffic for the Replication with the replication Id "C4-b01fb143-609d-4d84-9864-f1250b184180" in hourly minute samples for the last week.

    .EXAMPLE
    Get-vCAVTrafficReport -OrgName "PigeonNuggets" -StartTime ((Get-Date).AddDays(-1)) -EndTime (Get-Date)
    Returns a summary of all replication data traffic for the vOrg PigeonNuggets for the last day in 5 minute samples.

    .EXAMPLE
    Get-vCAVTrafficReport -OrgName "PigeonNuggets" -Resolution 3600 -StartTime ((Get-Date).AddDays(-7)) -EndTime (Get-Date)
    Returns a summary of all replication data traffic for the vOrg PigeonNuggets in hourly minute samples for the last week.

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-09-18
	VERSION: 1.0
    #>
    Param(
        [Parameter(Mandatory=$True, ParameterSetName="OrgHistory")]
            [ValidateNotNullorEmpty()] [String] $OrgName,
        [Parameter(Mandatory=$True, ParameterSetName="VMHistory")]
        [Parameter(Mandatory=$True, ParameterSetName="VMRealTime")]
            [ValidateNotNullorEmpty()] [String] $VMReplicationId,
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [String] $Site = ((Get-vCAVSites -SiteType "Local").site),
        [Parameter(Mandatory=$False, ParameterSetName="VMHistory")]
        [Parameter(Mandatory=$False, ParameterSetName="OrgHistory")]
            [int] $Resolution = 300,
        [Parameter(Mandatory=$True, ParameterSetName="VMHistory")]
        [Parameter(Mandatory=$True, ParameterSetName="OrgHistory")]
            [ValidateNotNullorEmpty()] [DateTime] $StartTime,
        [Parameter(Mandatory=$True, ParameterSetName="VMHistory")]
        [Parameter(Mandatory=$True, ParameterSetName="OrgHistory")]
            [ValidateNotNullorEmpty()] [DateTime] $EndTime,
        [Parameter(Mandatory=$False, ParameterSetName="VMRealTime")]
            [switch]$Realtime
    )

    # Check API/Version compatibility for this cmdlet
    if($DefaultvCAVServer.DefaultAPIVersion -lt "4"){
        throw "This cmdlet is only supported on vCloud Availability API version 4 or higher. The current default API version is $($DefaultvCAVServer.DefaultAPIVersion)"
    }
    if($DefaultvCAVServer.buildVersion -lt "3.5"){
        throw "This cmdlet is only supported on vCloud Availability 3.5+. The current connected version is $($DefaultvCAVServer.buildVersion)"
    }
    # Check the parameter set to determine the URI and Filters
    if ($PSCmdlet.ParameterSetName -eq "VMRealTime"){
        # Check if the VM Replication Exists
        if($null -eq (Get-vCAVReplications -VM -ReplicationId $VMReplicationId)){
            throw "A VM replication with the Replication Id $VMReplicationId does not exist in the site $Site. Please check the Id and try again."
        }
        $URI = $global:DefaultvCAVServer.ServiceURI + "vm-replications/$VMReplicationId/rt-traffic"
        [HashTable]$QueryFilters = @{
            site = $Site
        }
    } else {
        # Validate the time arguments are valid (StartTime must be before EndTime, if this is true a Timespace between the dates will be positive)
        if((New-TimeSpan -Start $StartTime -End $EndTime) -lt 0){
            throw "The provided Start Time $StartTime occurs after the provided end time $EndTime. The StarTime must be before the EndTime."
        }

        # For all other cases we need to calculate the Start and End Times in Unix epoch time and add the resolution to the headers
        [HashTable]$QueryFilters = @{
           resolution = $Resolution
        }
        $EPOCHStartTime = ([DateTimeOffset]$StartTime).ToUnixTimeMilliseconds()
        $QueryFilters.Add("start",$EPOCHStartTime)
        $EPOCHEndTime = ([DateTimeOffset]$EndTime).ToUnixTimeMilliseconds()
        $QueryFilters.Add("end",$EPOCHEndTime)
    }
    # Next check if the VMHistory or Org, for VMHistroy need to add site
    if($PSCmdlet.ParameterSetName -eq "VMHistory"){
        # Check if the VM Replication Exists
        $VMReplication = (Get-vCAVReplications -VM -ReplicationId $VMReplicationId)
        if($null -eq $VMReplication){
            throw "A VM replication with the Replication Id $VMReplicationId does not exist in the site $Site. Please check the Id and try again."
        }
        $QueryFilters.Add("site",$Site)
        $URI = $global:DefaultvCAVServer.ServiceURI + "vm-replications/$VMReplicationId/traffic"
    } elseif($PSCmdlet.ParameterSetName -eq "OrgHistory"){
        # Check that the provided Org exists in the provided Site
        if($null -eq (Get-vCAVTenantOrg -SiteName $Site -OrgName $OrgName)){
            throw "An organisation with the name $OrgName can not be found in the specified vCloud Availability site $Site. Please check the parameters and try again."
        }
        $URI = $global:DefaultvCAVServer.ServiceURI + "owner/$OrgName%40$Site/traffic"
    }

    # Make the API call and return the data to the caller
    $RequestResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion -QueryParameters $QueryFilters).JSONData

    # Now need to make the Reported output more readable/usable for processing in PowerShell for other applications
    # Convert the response to a meaning values for Time (DateTime)
    if($null -ne $RequestResponse.timestamp){
        # Need to convert the Unix time which is in UTC to the local time in DateTime
        $RequestResponse.timestamp = [timezone]::CurrentTimeZone.ToLocalTime((([System.DateTimeOffset]::FromUnixTimeMilliSeconds($RequestResponse.timestamp)).DateTime))
    }
    # If a StartTime is provided then the Report is a Org/Historic and need to convert the dates on all objects
    if($null -ne $RequestResponse.start){
        $RequestResponse.start = [timezone]::CurrentTimeZone.ToLocalTime((([System.DateTimeOffset]::FromUnixTimeMilliSeconds($RequestResponse.start)).DateTime))
        $RequestResponse.end = [timezone]::CurrentTimeZone.ToLocalTime((([System.DateTimeOffset]::FromUnixTimeMilliSeconds($RequestResponse.end)).DateTime))
        foreach($sample in $RequestResponse.samples){
            $sample.timestamp = [timezone]::CurrentTimeZone.ToLocalTime((([System.DateTimeOffset]::FromUnixTimeMilliSeconds($sample.timestamp)).DateTime))
        }
    }
    # Rename the labels to more meaningful things and output the result
    if($PSCmdlet.ParameterSetName -eq "VMHistory"){
        # Add the VM Replication object to the output
        $RequestResponse | Select-Object -Property @{Name = 'VMReplicationId'; Expression = {$_.label}},resolution,start,end,samples
    } elseif($PSCmdlet.ParameterSetName -eq "OrgHistory"){
        $RequestResponse | Select-Object -Property @{Name = 'vOrg'; Expression = {$_.label}},resolution,start,end,samples
    } else {
        $RequestResponse
    }
}