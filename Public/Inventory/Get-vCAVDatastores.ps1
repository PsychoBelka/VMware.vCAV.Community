function Get-vCAVDatastores(){
    <#
    .SYNOPSIS
    Returns a collection of datastores availabile to the registered vCloud for the currently connected vCloud Availability service.

    .DESCRIPTION
    Returns a collection of datastores availabile to the registered vCloud for the currently connected vCloud Availability service.

    .PARAMETER Name
    A filter for the Name of the Datastore

    .PARAMETER Id
    A filter for the Id of the Datastore

    .EXAMPLE
    Get-vCAVDatastores
    Returns all the datastores on the currently connected site.

    .EXAMPLE
    Get-vCAVDatastores -Id 51471a0e-2f83-4d3b-bc9b-b86a06598da3
    Returns the datastore with the Id 51471a0e-2f83-4d3b-bc9b-b86a06598da3 on the currently connected site.

    .EXAMPLE
    Get-vCAVDatastores -Name vCloud-NFS-1
    Returns the datastore with the Name vCloud-NFS-1 on the currently connected site.

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 1.0
    #>
    [CmdletBinding(DefaultParameterSetName="Default")]
    Param(
        [Parameter(Mandatory=$False, ParameterSetName="ByName")]
            [ValidateNotNullorEmpty()] [String] $Name,
        [Parameter(Mandatory=$False, ParameterSetName="ById")]
            [ValidateNotNullorEmpty()] [String] $Id
    )
    # Set the API endpoint
    $URI = $global:DefaultvCAVServer.ServiceURI + "inventory/datastores"
    $colDatastoreQueryResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Get ).JSONData
    # Now filter if required
    if($PSBoundParameters.ContainsKey("Name")){
    # Check if a filter has been provided for the name
        $colDatastoreQueryResponse | Where-Object {$_.name -eq $Name}
    } elseif($PSBoundParameters.ContainsKey("Id")){
        $colDatastoreQueryResponse | Where-Object {$_.id -eq $Id}
    } else {
        $colDatastoreQueryResponse
    }
}