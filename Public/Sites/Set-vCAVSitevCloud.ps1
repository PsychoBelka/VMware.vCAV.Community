function Set-vCAVSitevCloud(){
    <#
    .SYNOPSIS
    This cmdlet sets the vCloud Director configuration for the local site of the currently connected vCloud Availability service.

    .DESCRIPTION
    This cmdlet sets the vCloud Director configuration for the local site of the currently connected vCloud Availability service.

    .PARAMETER vCloudAPIURI
    The URI for the vCloud API Service

    .PARAMETER vcdCredentials
    A PSCredential object with a user account with System Administrator access to the System Org in the vCloud Organisation.

    .EXAMPLE
    Set-vCAVSitevCloud -vCloudAPIURI "https://vcd.pigeonnuggets.com/api" -vcdCredentials (New-Object System.Management.Automation.PSCredential("administrator@system",(ConvertTo-SecureString "Password!" -AsPlainText -Force)))
    Sets the vCloud configuration for all vCloud operations in the local site to https://vcd.pigeonnuggets.com/api using the bultin-in administrator account for vCloud and a Password of "Password!123"

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-09-10
	VERSION: 3.0
    #>

    Param(
		[Parameter(Mandatory=$True)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [string] $vCloudAPIURI,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [PSCredential] $vcdCredentials
    )
    # First make a call to get the Thumbprint of the vCloud API Certificate
    [string] $RemoteLookupServiceURI = $global:DefaultvCAVServer.ServiceURI + "config/remote-certificate?url=$vCloudAPIURI"
    $RemoteCertificate = (Invoke-vCAVAPIRequest -URI $RemoteLookupServiceURI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData

    # Configure the vCloud connection for the Site
    [string] $ConfigVCDURI = $global:DefaultvCAVServer.ServiceURI + "config/vcloud"
    $objvCloudConfig = New-Object System.Management.Automation.PSObject
    $objvCloudConfig | Add-Member Note* vcdPassword ($vcdCredentials.GetNetworkCredential().Password)
    $objvCloudConfig | Add-Member Note* vcdThumbprint $RemoteCertificate.certificate.thumbPrint
    $objvCloudConfig | Add-Member Note* vcdUrl $vCloudAPIURI
    $objvCloudConfig | Add-Member Note* vcdUsername ($vcdCredentials.UserName)
    $vCloudConfigResponse = Invoke-vCAVAPIRequest -URI $ConfigVCDURI -Data (ConvertTo-JSON $objvCloudConfig) -Method Post -APIVersion $DefaultvCAVServer.DefaultAPIVersion
    $vCloudConfigResponse.JSONData
}
