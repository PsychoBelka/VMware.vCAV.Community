function Set-vCAVLicenceKey(){
    <#
    .SYNOPSIS
    This cmdlet installs a new licence key to the currently connected vCloud Availability service.

    .DESCRIPTION
    This cmdlet installs a new licence key to the currently connected vCloud Availability service.

    .PARAMETER Key
    A valid vCloud Availability licence key.

    .EXAMPLE
    Set-vCAVLicenceKey -Key "AAAA-BBBB-CCCCC-EEEEE-FFFFF-11111"
    Sets the vCloud Availability licence key to "AAAA-BBBB-CCCCC-EEEEE-FFFFF-11111"

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 3.0
    #>
    Param(
		[Parameter(Mandatory=$True, ValueFromPipeline=$True)]
            [ValidateNotNullorEmpty()] [String] $Key
    )
    $URI = $global:DefaultvCAVServer.ServiceURI + "license"
    $objLicenseKey = New-Object System.Management.Automation.PSObject
    $objLicenseKey | Add-Member Note* key $Key
    $RequestResponse = Invoke-vCAVAPIRequest -URI $URI -Data (ConvertTo-JSON $objLicenseKey) -Method Post
    $RequestResponse.JSONData
}
