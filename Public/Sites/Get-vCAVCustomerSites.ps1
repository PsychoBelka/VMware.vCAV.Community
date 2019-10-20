
function Get-vCAVCustomerSites(){
    <#
    .SYNOPSIS
    Returns a collection of configured On-Premise Customer-side vCloud Availability Sites in the connected installation.

    .DESCRIPTION
    Returns a collection of configured On-Premise Customer-side vCloud Availability Sites in the connected installation.

    .PARAMETER SiteName
    Optionally the Site Name to filter.

    .PARAMETER Owner
    The vCloud vOrg that owns the Site.

    .EXAMPLE
    Get-vCAVCustomerSites
    Returns the currently configured On-Premise vCloud Sites.

    .EXAMPLE
    Get-vCAVCustomerSites -SiteName "PigeonNuggets-SiteA"
    Returns the currently configured On-Premise vCloud Sites with the name "PigeonNuggets-SiteA" if it exists in the installation. If the site does not exist an Exception is thrown.

    .EXAMPLE
    Get-vCAVCustomerSites -Owner "ExampleOrg"
    Returns the On-Premise Customer-side vCloud Availability sites configured for the vOrg ExampleOrg.

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-07-19
	VERSION: 1.0
    #>
    Param(
        [Parameter(Mandatory=$False, ParameterSetName = "ByType")]
            [ValidateNotNullorEmpty()] [String] $SiteName,
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [String] $Owner
    )
    [string] $SitesURI = $global:DefaultvCAVServer.ServiceURI + "vc-sites"
    $colSites = (Invoke-vCAVAPIRequest -URI $SitesURI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
    if($PSBoundParameters.ContainsKey("SiteName")){
        $colSites = $colSites | Where-Object {$_.site -eq $SiteName}
        if($null -eq $colSites){
            throw "A On-Premise Site with the name $SiteName is not configured in the connected installation with the provided filters. Please check the site name and site type and try again."
        }
    }
    if($PSBoundParameters.ContainsKey("Owner")){
        $colSites = $colSites | Where-Object {$_.owner -eq $Owner}
    }
    # Now return the vCenter objects for each of the objects in the collection
    foreach($site in $colSites){
        try{
            [string] $vCenterURI = $global:DefaultvCAVServer.ServiceURI + "vc-sites/$($site.site)/vcenters"
            $colvCenters = (Invoke-vCAVAPIRequest -URI $vCenterURI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
            $site | Add-Member Note* vCenters $colvCenters
        } catch {
            Write-Warning -Message "Unable to retireve the data for the vCenters for $($site.site). This usually means there is a connection issue with the remote customer Tunnel Service."
        }
    }
    $colSites
}