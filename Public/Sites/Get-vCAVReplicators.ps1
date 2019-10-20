function Get-vCAVReplicators(){
    <#
    .SYNOPSIS
    Returns a collection of configured vCloud Availability Replicators.

    .DESCRIPTION
    Returns a collection of configured vCloud Availability Replicators.

    .PARAMETER Id
    Optionally the Id of the Replicator

    .EXAMPLE
    Get-vCAVReplicators
    Returns the currently configured replicators managed by this device.

    .EXAMPLE
    Get-vCAVReplicators -Id "0661dbf4-4105-4754-aae5-f7c7674c044f"
    Returns the replicator with the Id 0661dbf4-4105-4754-aae5-f7c7674c044f.

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-05-08
	VERSION: 1.0
    #>
     Param(
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [String] $Id
     )
    # Check if any filtering should be performed
    if($PSBoundParameters.ContainsKey("Id")){
        [string] $ReplicatorsURI = $global:DefaultvCAVServer.ServiceURI + "replicators/$Id"
    } else {
        [string] $ReplicatorsURI = $global:DefaultvCAVServer.ServiceURI + "replicators"
    }
    if(Test-VCAVServiceEnvironment -ServiceType "Manager"){
        try{
            $Replicators = (Invoke-vCAVAPIRequest -URI $ReplicatorsURI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
        } catch {
            throw "A Replicator with the provided Id can not be found or an error has occured during the API call. Please check the provided parameters before trying again."
        }
    }
    $Replicators
}