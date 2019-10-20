function Get-vCAVTasks(){
    <#
    .SYNOPSIS
    Shows information about tasks within the currently connected vCloud Availability service.

    .DESCRIPTION
    Shows information about tasks within the currently connected vCloud Availability service.

    .PARAMETER Id
    A vCloud Availability Task Id

    .PARAMETER Replications
    If provided filters tasks to only displays Replication Tasks

    .PARAMETER System
    If provided filters tasks to only displays System Tasks

    .PARAMETER Site
    Optionally the Site to retrieve the task from. This could be a local or remote site.

    .PARAMETER SourceOrg
    Filter tasks by the Source vOrg
    Note: Case sensitive

    .PARAMETER DestinationOrg
    Filter tasks by the Destination vOrg
    Note: Case sensitive

    .PARAMETER TaskState
    Filter tasks by the State of the Task. Available values are: "RUNNING","SUCCEEDED","FAILED"

    .PARAMETER User
    Filter for tasks by the username of the user initating the task. Available only to system admins.

    .PARAMETER OperationId
    Filter tasks by the vCAV Operation Id.

    .PARAMETER StartTimeAfter
    If provided filter tasks that have a Start Time greater-than the provided time.

    .PARAMETER StartTimeBefore
    If provided filter tasks that have a Start Time less-than the provided time.

    .EXAMPLE
    Get-vCAVTasks
    Returns all of the Tasks for the connected vCloud Availability installation.

    .EXAMPLE
    Get-vCAVTasks -Id "XXXX-XXXXX-XXXX-XXXX-XXXXX"
    Get the details of the Task with the Task Id "XXXX-XXXXX-XXXX-XXXX-XXXXX".

    .EXAMPLE
    Get-vCAVTasks -System
    Get all the System Administration Tasks for the connected vCloud Availability Service.

    .EXAMPLE
    Get-vCAVTasks -Replications
    Get all the Replication Tasks for the connected vCloud Availability Service.

    .EXAMPLE
    Get-vCAVTasks -StartTimeAfter ((Get-Date).AddDays(-1)) -StartTimeBefore (Get-Date) -TaskState "FAILED"
    Get all tasks for the last 24 hours that failed  for the connected vCloud Availability Service.

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-07-19
	VERSION: 4.0
    #>
    [CmdletBinding(DefaultParameterSetName="Default")]
    Param(
        [Parameter(Mandatory=$False, ParameterSetName="ById")]
            [ValidateNotNullorEmpty()] [String] $Id,
        [Parameter(Mandatory=$False)]
            [switch] $Replications,
            [switch] $System,
            [ValidateNotNullorEmpty()] [String] $Site,
            [ValidateNotNullorEmpty()] [String] $DestinationOrg,
            [ValidateNotNullorEmpty()] [String] $SourceOrg,
            [ValidateNotNullorEmpty()] [String] $User,
            [ValidateSet("RUNNING","SUCCEEDED","FAILED")] [String] $TaskState,
            [ValidateNotNullorEmpty()] [String] $OperationId,
            [ValidateNotNullorEmpty()] [DateTime] $StartTimeAfter,
            [ValidateNotNullorEmpty()] [DateTime] $StartTimeBefore
    )
    # Set the API Endpoint
    [string] $TasksURI = $global:DefaultvCAVServer.ServiceURI + "tasks"
    # Check if query is for single task
    if ($PSCmdlet.ParameterSetName -eq "ById") {
        $TasksURI += "/$id"
        (Invoke-vCAVAPIRequest -URI $TasksURI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
    } else {
        #Create a Hashtable with the base filters
        [HashTable]$QueryFilters = @{
            offset = 0
            limit = 100
        }
        # If a Site has been provided check that the site exists and add to the query parameter
        if($PSBoundParameters.ContainsKey("Site")){
            [bool] $SiteExists = ($null -ne (Get-vCAVSites -SiteName $Site))
            if($SiteExists){
                $QueryFilters.Add("site", $Site)
            } else {
                throw "The provided site does not exist in this installation. Please check the site name and try again."
            }
        }
        if($PSBoundParameters.ContainsKey("Replications")){
            # Add the Replications Filters
            $QueryFilters.Add("resourceType", "replication,vmReplication,vappReplication")
        }
        if($PSBoundParameters.ContainsKey("System")){
            $QueryFilters.Add("resourceType","site,pair,repair,inventory,appliance,replicator,supportBundle,policies")
        }
        # Filter for the Task User if provided
        if($PSBoundParameters.ContainsKey("User")){
            $QueryFilters.Add("user",$User)
        }
        if($PSBoundParameters.ContainsKey("TaskState")){
            $QueryFilters.Add("state",$TaskState)
        }
        if($PSBoundParameters.ContainsKey("DestinationOrg")){
            $QueryFilters.Add("destinationOrg",$DestinationOrg)
        }
        if($PSBoundParameters.ContainsKey("SourceOrg")){
            $QueryFilters.Add("sourceOrg",$SourceOrg)
        }
        if($PSBoundParameters.ContainsKey("StartTimeAfter")){
            # Convert the provided DateTime into Unix epoch time
            $EPOCHStartTimeAfter = ([DateTimeOffset]$StartTimeAfter).ToUnixTimeMilliseconds()
            $QueryFilters.Add("startTimeAfter",$EPOCHStartTimeAfter)
        }
        if($PSBoundParameters.ContainsKey("StartTimeBefore")){
            # Convert the provided DateTime into Unix epoch time
            $EPOCHStartTimeBefore = ([DateTimeOffset]$StartTimeBefore).ToUnixTimeMilliseconds()
            $QueryFilters.Add("startTimeBefore",$EPOCHStartTimeBefore)
        }
        if($PSBoundParameters.ContainsKey("OperationId")){
            $QueryFilters.Add("operationID",$OperationId)
        }
        # All filters have been applied now make the call to get the items
        # Now make the first call to the API and add the items to a collection
        $TaskQueryResponse = (Invoke-vCAVAPIRequest -URI $TasksURI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion -QueryParameters $QueryFilters).JSONData
        $colTasks = $TaskQueryResponse.items
        # Check if more then 100 results were returned and continue to query until all items have been returned
        [int] $OffsetPosition = 100 # Set the starting offset to 100 results
        while($OffsetPosition -lt $TaskQueryResponse.total){
            $QueryFilters.offset = $OffsetPosition
            $TaskQueryResponse = (Invoke-vCAVAPIRequest -URI $TasksURI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion -QueryParameters $QueryFilters).JSONData
            $colTasks += $TaskQueryResponse.items
            $OffsetPosition += 100
        }
        $colTasks
    }
}