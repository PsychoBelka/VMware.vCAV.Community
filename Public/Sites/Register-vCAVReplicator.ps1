function Register-vCAVReplicator(){
    <#
    .SYNOPSIS
    Registers a H4 Replicator with the currently connected vCloud Availability H4 Manager Service.

    .DESCRIPTION
    Registers a H4 Replicator with the currently connected vCloud Availability H4 Manager Service.

    .PARAMETER SiteName
    The Site Name to register the Replicator against.

    .PARAMETER Description
    A description for the site.

    .PARAMETER ReplicatorAPIURI
    The API URI for the Replicator to be registered

    .PARAMETER ReplicatorPassword
    The root password of the Replicator appliance to be registered

    .PARAMETER vSphereCredentials
    A vSphere SSO account with VI Administrator rights on the Resoruce vCenter. These credentials will be used for performing the H4 primative calls to the hypervisors for Replication operations.

    .EXAMPLE
    Register-vCAVReplicator -SiteName "Brisbane" -SiteDescription "Test Site" -ReplicatorAPIURI "https://vcav-replicator.pigeonnuggets.com:8043/" -ReplicatorPassword (ConvertTo-SecureString -String "Password!123" -AsPlainText -Force) -vSphereCredentials (Get-Credentials)
    Registers the H4 Replciator with the API URI https://vcav-replicator.pigeonnuggets.com:8043/ and a root password of Password!123 with the connected H4 Manager on Site "Brisbane". The replicator will using the SSO User provided at the command prompt during execution.

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 2.1
    #>
    Param(
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [String] $SiteName,
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [String] $Description,
        [Parameter(Mandatory=$True)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [string] $ReplicatorAPIURI,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [SecureString] $ReplicatorPassword,
        [Parameter(Mandatory=$True)]
            [PSCredential] $vSphereAPICredentials
    )
    # Translate the SecureString for the Replicator Password to plain-text for the API Call
    $ReplciatorCredentials = New-Object System.Management.Automation.PSCredential("root", $ReplicatorPassword)
    $ReplicatorPasswordPlain = $ReplciatorCredentials.GetNetworkCredential().Password
    # Decode the vSphere Credentials for the API Call in plain text
    $vSphereUsername = $vSphereAPICredentials.GetNetworkCredential().UserName
    $vSpherePassword = $vSphereAPICredentials.GetNetworkCredential().Password

    # TO DO: Add check that the currently connected Service is the Replicator Manager - this cmdlet should only allow execution when connected to the Manager
    # First make a call to get the Thumbprint of the Replicator Certificate
    [string] $RemoteLookupServiceURI = $global:DefaultvCAVServer.ServiceURI + "config/remote-certificate?url=$ReplicatorAPIURI"
    $RemoteCertificate = (Invoke-vCAVAPIRequest -URI $RemoteLookupServiceURI -Method Get ).JSONData

    # Now make the call to the Replicator Config namespace
    [string] $ConfigURI = $global:DefaultvCAVServer.ServiceURI + "replicators"

    $objReplicatorDetails = New-Object System.Management.Automation.PSObject
    $objReplicatorDetails | Add-Member Note* apiUrl $ReplicatorAPIURI
    $objReplicatorDetails | Add-Member Note* apiThumbprint $RemoteCertificate.certificate.thumbPrint
    $objReplicatorDetails | Add-Member Note* rootPassword $ReplicatorPasswordPlain
    $objReplicatorDetails | Add-Member Note* ssoUser $vSphereUsername
    $objReplicatorDetails | Add-Member Note* ssoPassword $vSpherePassword
    $objReplicatorConfig = New-Object System.Management.Automation.PSObject
    $objReplicatorConfig | Add-Member Note* owner "*"
    $objReplicatorConfig | Add-Member Note* site $SiteName
    $objReplicatorConfig | Add-Member Note* description $Description
    $objReplicatorConfig | Add-Member Note* details $objReplicatorDetails
    $ConfigResponse = (Invoke-vCAVAPIRequest -URI $ConfigURI -Data (ConvertTo-JSON $objReplicatorConfig) -Method Post ).JSONData
    $ConfigResponse
}