## NOT TESTED - 15/3/2019
function Get-vCAVSupportBundle(){
    <#
    .SYNOPSIS
    Returns a support bundle from the currently connected vCloud Availability service.

    .DESCRIPTION
    Returns a support bundle from the currently connected vCloud Availability service. A Support Bundle can be generated by calling the New-vCAVSupportBundle cmdlet.

    .PARAMETER BundleId
    The Support Bundle ID to query, if not provided all support bundles will be returned

    .PARAMETER Download
    If True will download the support bundle retunred to the current directory with the filename specified in the Support Bundle

    .EXAMPLE
    Get-vCAVSupportBundle
    Returns all availabile support bundles for the currently connected vCloud Availability Service

    .EXAMPLE
    Get-vCAVSupportBundle -BundleId "1676f615-aa4b-4c16-ae59-ab8c8ec7f28b"
    Returns the details of the support bundle with the Id "1676f615-aa4b-4c16-ae59-ab8c8ec7f28b" on the currently connected vCloud Availability Service if it exists

    .EXAMPLE
    Get-vCAVSupportBundle -BundleId "1676f615-aa4b-4c16-ae59-ab8c8ec7f28b" -Download $true
    Returns the details of the support bundle with the Id "1676f615-aa4b-4c16-ae59-ab8c8ec7f28b" on the currently connected vCloud Availability Service if it exists and downloads the buddle to the current working directory

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 1.0
    #>
    [CmdletBinding(DefaultParameterSetName="Default")]
    Param(
        [Parameter(Mandatory=$True, ParameterSetName = "ById", ValueFromPipeline=$True)]
            [string]$BundleId,
        [Parameter(Mandatory=$False, ParameterSetName = "ById")]
            [bool]$Download = $false
    )
    [string] $URI = $global:DefaultvCAVServer.ServiceURI + "diagnostics/bundles"
    $SupportBundles = (Invoke-vCAVAPIRequest -URI $URI -Method Get).JSONData
    if(!($PSBoundParameters.ContainsKey('BundleId'))){
        $SupportBundles
    } else {
        $SupportBundles = $SupportBundles | Where-Object {$_.id -eq $BundleId}
        if($Download -and ($null -ne $SupportBundles)){
            # First generate a one-time cookie for the download of the support bundle
            [string] $SupportBundleURI = $global:DefaultvCAVServer.ServiceURI + "diagnostics/bundles/cookie/$($SupportBundles.id)"
            $DownloadCookie = (Invoke-vCAVAPIRequest -URI $SupportBundleURI -Method Post).JSONData.cookie
            $SupportBundleURI += "?&cookie=$DownloadCookie"
            $SupportBundleOutput = (Invoke-vCAVAPIRequest -URI $SupportBundleURI -Method Get)
            # Generate the Filename after the download
            $OutputFileName = $SupportBundleOutput.Headers.'Content-Disposition'.Trim("inline; filename=").Replace("""","")
            $OutputFileName = "$($pwd.Path)\" + $OutputFileName
            $SupportBundles | Add-Member Note* OutputFileName $OutputFileName
            Set-Content -Path $OutputFileName -AsByteStream -Value $SupportBundleOutput.RawData
        }
        $SupportBundles
    }
}