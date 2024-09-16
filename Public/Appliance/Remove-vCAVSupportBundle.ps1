function Remove-vCAVSupportBundle(){
    <#
    .SYNOPSIS
    Deletes a support bundle from the currently connected vCloud Availability service.

    .DESCRIPTION
    Deletes a support bundle from the currently connected vCloud Availability service.

    .PARAMETER BundleId
    The Support Bundle ID to delete

    .EXAMPLE
    Remove-vCAVSupportBundle -BundleId -BundleId "1676f615-aa4b-4c16-ae59-ab8c8ec7f28b"
    Deletes the support bundle with the Id "1676f615-aa4b-4c16-ae59-ab8c8ec7f28b" from the currently connected vCloud Availability Service if it exists

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 1.0
    #>
    Param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
            [string]$BundleId
    )
    # Check if the Bundle exists
    $SupportBundle = Get-vCAVSupportBundle -BundleId $BundleId
    if($null -ne $SupportBundle){
        [string] $URI = $global:DefaultvCAVServer.ServiceURI + "diagnostics/bundles/$BundleId"
        $SupportBundle = (Invoke-vCAVAPIRequest -URI $URI -Method Delete).JSONData
    } else {
        throw "A Support Bundle with the ID $BundleId could not be found."
    }
}
