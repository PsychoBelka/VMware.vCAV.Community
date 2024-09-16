function Set-vCAVResourcevCenterLookupService(){
    <#
    .SYNOPSIS
    This cmdlet sets the vCenter Lookup Service to use for the currently connected vCloud Availability service.

    .DESCRIPTION
    This cmdlet sets the vCenter Lookup Service to use for the currently connected vCloud Availability service.

    .PARAMETER LookupServiceURI
    The URI for the vCenter Lookup Service API Service for the PSC for the Resource vCenter.

    .EXAMPLE
    Set-vCAVResourcevCenterLookupService -LookupServiceURI "https://labvc1.pigeonnuggets.com/lookupservice/sdk"
    Sets the Resource vCenter Lookup Service for the currently connected vCloud Availability service to "https://labvc1.pigeonnuggets.com/lookupservice/sdk"

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 3.0
    #>
    Param(
		[Parameter(Mandatory=$True)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [string] $LookupServiceURI
    )
    # First make a call to get the Thumbprint of the Lookup Service Certificate
    [string] $RemoteLookupServiceURI = $global:DefaultvCAVServer.ServiceURI + "config/remote-certificate?url=$LookupServiceURI"
    $RemoteCertificate = (Invoke-vCAVAPIRequest -URI $RemoteLookupServiceURI -Method Get).JSONData

    # Configure the lookup Service for the appliance
    [string] $ConfigLookupServiceURI = $global:DefaultvCAVServer.ServiceURI + "config/lookup-service"
    $objLookupService = New-Object System.Management.Automation.PSObject
    $objLookupService | Add-Member Note* url $LookupServiceURI
    $objLookupService | Add-Member Note* thumbprint $RemoteCertificate.certificate.thumbPrint
    $ConfigurationRequest = Invoke-vCAVAPIRequest -URI $ConfigLookupServiceURI -Data (ConvertTo-JSON $objLookupService) -Method Post
    $ConfigurationRequest.JSONData
}