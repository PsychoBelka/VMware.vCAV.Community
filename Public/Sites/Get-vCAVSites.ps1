function Get-vCAVSites(){
    <#
    .SYNOPSIS
    Returns a collection of configured vCloud Availability Sites in the connected installation.

    .DESCRIPTION
    Returns a collection of configured vCloud Availability Sites in the connected installation.

    .PARAMETER SiteName
    Optionally the Site Name to filter.

    .PARAMETER SiteType
    Optionally the Site Type (Local or Remote) to filter results.

    .EXAMPLE
    Get-vCAVSites
    Returns the currently configured sites.

    .EXAMPLE
    Get-vCAVSites -SiteName "PigeonNuggets-SiteA"
    Returns the vCloud Availability site "PigeonNuggets-SiteA" if it exists in the installation. If the site does not exist an Exception is thrown.

    .EXAMPLE
    Get-vCAVSites -SiteType "Local"
    Returns the local vCloud Availability site for the currently connected installation.

    .EXAMPLE
    Get-vCAVSites -SiteType "Remote"
    Returns the local vCloud Availability sites configured for the currently connected installation. If none exist nothing is returned.

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 3.0
    #>
    [CmdletBinding(DefaultParameterSetName="Default")]
    Param(
        [Parameter(Mandatory=$True, ParameterSetName = "ByName")]
        [Parameter(Mandatory=$False, ParameterSetName = "ByType")]
            [ValidateNotNullorEmpty()] [String] $SiteName,
        [Parameter(Mandatory=$True, ParameterSetName = "ByType")]
            [ValidateSet("Local","Remote")] [String] $SiteType
    )
    [string] $SitesURI = $global:DefaultvCAVServer.ServiceURI + "sites"
    $colSites = (Invoke-vCAVAPIRequest -URI $SitesURI -Method Get ).JSONData
    if($PSCmdlet.ParameterSetName -eq "ByType"){
        # Filter the site by type
        if($SiteType -eq "Local"){
            $colSites = $colSites | Where-Object{$_.isLocal -eq $true}
        } else {
            $colSites = $colSites | Where-Object{$_.isLocal -eq $false}
        }
    }
    # Filter the results if a filter parameter was provided
    if($PSBoundParameters.ContainsKey("SiteName")){
        $colSites = $colSites | Where-Object{$_.site -eq $SiteName}
        if($null -eq $colSites){
            throw "A Site with the name $SiteName is not configured in the connected installation with the provided filters. Please check the site name and site type and try again."
        }
    }
    $colSites
}