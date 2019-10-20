function Add-vCAVSite(){
    <#
    .SYNOPSIS
    Creates a new vCloud Availability Site in the connected installation.

    .DESCRIPTION
    Creates a new vCloud Availability Site in the connected installation.

    .PARAMETER SiteName
    The Site Name

    .PARAMETER SiteDescription
    The Site Description

    .PARAMETER SiteType
    The Site Type (Local or Remote)

    .PARAMETER APIURL
    Parameter The API URL for the remote vCloud Availability installation

    .PARAMETER RemoteRootPassword
    The Root Password for the remote vCloud Availability installation

    .EXAMPLE
    Add-vCAVSite -SiteName "Berlin" -SiteDescription "Berlin Site"
    Adds a local site to the installation named Berlin with the description "Berlin Site".

    .EXAMPLE
    Add-vCAVSite -SiteName "Brisbane" -SiteType "Remote" -APIURL "https://brisbane.example.com:8048" -RemoteRootPassword (ConvertTo-SecureString -String "Password!123" -AsPlainText -Force)
    Adds a new remote site to the installation "Brisbane" using the API endpoint "https://brisbane.example.com:8048" and the Remote Root Password of Password!123

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-07-31
	VERSION: 3.0
    #>

    Param(
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [String] $SiteName,
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [String] $SiteDescription,
        [Parameter(Mandatory=$False)]
            [ValidateSet("Local","Remote")]  [string] $SiteType="Local",
        [Parameter(Mandatory=$False)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [string] $APIURL,
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [SecureString] $RemoteRootPassword
    )
    # Check if a site with the provided name already exists
    try{
       $siteExists = ((Get-vCAVSite -SiteName $SiteName).Length -gt 0)
    } catch {
       $siteExists = $false
    }
    if($siteExists){
        throw "A Site with the provided name $SiteName already exists."
    }
    $objSite = New-Object System.Management.Automation.PSObject
    if($SiteType -eq "Local"){
        [string] $ConfigURI = $global:DefaultvCAVServer.ServiceURI + "config/site"

        $objSite | Add-Member Note* localSite $SiteName
        if(!([string]::IsNullOrEmpty($SiteDescription))){
            $objSite | Add-Member Note* localSiteDescription $SiteDescription
        }
        if(!([string]::IsNullOrEmpty($APIURL))){
            $objSite | Add-Member Note* apiUrl $APIURL
        }
    }
    if($SiteType -eq "Remote"){
        # Cast the Password to plain text for the API call
        $ReplciatorCredentials = New-Object System.Management.Automation.PSCredential("root", $RemoteRootPassword)
        $ReplicatorPasswordPlain = $ReplciatorCredentials.GetNetworkCredential().Password
        [string] $ConfigURI = $global:DefaultvCAVServer.ServiceURI + "sites"
        # Get the Thumbprint of the Remote Certificate
        [string] $RemoteServiceCertURI = $global:DefaultvCAVServer.ServiceURI + "config/remote-certificate?url=$APIURL"
        $RemoteCertificate = (Invoke-vCAVAPIRequest -URI $RemoteServiceCertURI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
        $objSite | Add-Member Note* site $SiteName
        if(!([string]::IsNullOrEmpty($SiteDescription))){
            $objSite | Add-Member Note* description $SiteDescription
        }
        $objSite | Add-Member Note* apiUrl $APIURL
        $objSite | Add-Member Note* apiThumbprint $RemoteCertificate.certificate.thumbPrint
        $objSite | Add-Member Note* remoteRootPassword $ReplicatorPasswordPlain

    }
    $objSiteResponse = Invoke-vCAVAPIRequest -URI $ConfigURI -Data (ConvertTo-JSON $objSite) -Method Post -APIVersion $DefaultvCAVServer.DefaultAPIVersion
    $objSiteResponse.JSONData
}
