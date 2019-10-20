function New-vCAVSupportBundle(){
    <#
    .SYNOPSIS
    Generate a new support bundle. This operation requires administrative permissions and may take a while.

    .DESCRIPTION
    Generate a new support bundle. This operation requires administrative permissions and may take a while.

    .PARAMETER Download
    If the parameter is set to $true after the support bundle has been generated it will be download to the current working directory

    .EXAMPLE
    New-vCAVSupportBundle
    Generates a new vCloud Availability support bundle and returns the details of the support bundle object generated.

    .EXAMPLE
    New-vCAVSupportBundle -Download $true
    Generates a new vCloud Availability support bundle and returns the details of the support bundle object generated and downloads the buddle to the current working directory.

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-02-22
	VERSION: 2.0
    #>
    Param(
        [Parameter(Mandatory=$False)]
            [bool]$Download = $false
    )
    [string] $URI = $global:DefaultvCAVServer.ServiceURI + "diagnostics/bundles"
    $SupportBundle = (Invoke-vCAVAPIRequest -URI $URI -Method Post -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
    # Returns a Task
    if((Watch-TaskCompleted -Task $SupportBundle -Timeout 3600)){
        $SupportBundleId = $SupportBundle.workflowInfo.resourceId
        if($Download){
            # Wait 10 seconds after the bundle has completed id downloading
            Start-Sleep -Seconds 10
        }
        $objSupportBundle = Get-vCAVSupportBundle -BundleId $SupportBundleId -Download $Download
        $objSupportBundle
    }
}