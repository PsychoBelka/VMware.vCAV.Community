function Connect-vCAVService(){
    <#
    .SYNOPSIS
    This cmdlet establishes a connection to the specified vCloud Availability server.

    .DESCRIPTION
    This cmdlet establishes a connection to the specified vCloud Availability server. The cmdlet starts a new session or re-establishes a previous session with a cloud server using the specified parameters. If a connection to a server already exists, the cmdlet will disconnect the session and re-attempt the connection.

    In order to perform replication management operations that involve remote sites, your session needs to be "extended" with credentials (vCD auth cookie or org user and password) to the related remote site. The -Extend switch can be used for this purpose.

    To set the default behavior of PowerCLI when no valid certificates are recognized, use the InvalidCertificateAction parameter of the Set-PowerCLIConfiguration cmdlet. For more information about invalid certificates, run 'Get-Help about_invalid_certificates'.

    To set the proxy usage behavior of PowerCLI (eg. to bypass a proxy or to use the System Proxy), use the ProxyPolicy parameter of the Set-PowerCLIConfiguration cmdlet.

    The connection details are kept in a global variable called $DefaultvCAVServer. When you disconnect from a server, the server is removed from the $DefaultvCAVServer variable. You can modify the value of the $DefaultCIServers variable manually.

    You can also use the -SaveCredentials switches to export credentials that can be used with the -UseSavedCredentials switch for use in Automation.

    .PARAMETER Server
    Specifies the IP address or DNS Hostname of the vCloud Availability server

    .PARAMETER AuthProvider
    The Authentication Provider which should be used to connect. Local or vSphere SSO for Administrative access and vCloud or vCD Session for vCloud Director based logon. The default is Local authentication

    .PARAMETER Port
    Specifies the TCP Port for the connection; the Default is TCP 443.

    .PARAMETER Credentials
    Specifies a PSCredential object that contains credentials for authenticating with the server.

    .PARAMETER APIVersion
    The API Version to use for the connection. Default is Version 3. (vCloud Availability 3.0.X)
    During connection if a higher version of the API detected as supported it will be used.

    .PARAMETER Extend
    Indicates that the session should be extended with a connection to the specified remote vCloud Availability site.

    .PARAMETER Site
    The registered Remote Site to Extend the session to

    .PARAMETER SaveCredentials
    Indicates that you want to only save the specified credentials. The credentials and connection details are outputed (with the password encrypted using the local user account) to the local console. Optionally if -CredentialStoreFile is provided the output is also saved into a local file specified in the -CredentialStoreFile parameter. This file can be used in scripts later use in automation.

    .PARAMETER CredentialStoreFile
    File path to store or read the connection properties.

    .PARAMETER UseSavedCredentials
    Indicates that saved credentials generated from using the -SaveCredentials should be read for the connection. The credentials are read from the well-formed JSON file provided in paramter -CredentialStoreFile

    .EXAMPLE
    Connect-vCAVService -Server "vcav.pigeonnuggets.com" -Port 8044
    Connects to the vCloud Availability server "vcav.pigeonnuggets.com" on TCP 8044 using the Local Authentication method prompting the user for credentials.

    .EXAMPLE
    Connect-vCAVService -Server "vcav.pigeonnuggets.com" -Port 8044 -AuthProvider "vCDSession"
    Connects to the vCloud Availability server "vcav.pigeonnuggets.com" on TCP 8044 using the vCloud Director credentials stored in the PowerCLI global variable $DefaultCIServers.

    .EXAMPLE
    Connect-vCAVService -Server "vcav.pigeonnuggets.com" -AuthProvider "vCDLogin"
    Connects to the vCloud Availability server "vcav.pigeonnuggets.com" on TCP 443 prompting the user for vCloud Director credentials. (eg. administrator@system)

    .EXAMPLE
    Connect-vCAVService -Server "vcav.pigeonnuggets.com" -AuthProvider "SSO"
    Connects to the vCloud Availability server "vcav.pigeonnuggets.com" on TCP 443 prompting the user for the SSO Lookup Service vSphere SSO Credentials (eg. administrator@vsphere.local)

    .EXAMPLE
    Connect-vCAVService -Server "vcav.pigeonnuggets.com" -SaveCredentials -CredentialStoreFile "vcav-pigeonnuggets-com.json"
    Creates a new saved credential for the "vcav.pigeonnuggets.com" vCAV service and outputs it to "vcav-pigeonnuggets-com.json" in the local directory.

    .EXAMPLE
    Connect-vCAVService -UseSavedCredentials -CredentialStoreFile "vcav-pigeonnuggets-com.json"
    Connects to the vCloud Availability Server specified in the credential store file "vcav-pigeonnuggets-com.json"

    .EXAMPLE
    Connect-vCAVService -Extend -Site "Brisbane" -AuthProvider "vcdSession"
    Extends the current session to the remote site named "Brisbane" using the currently logged in PowerCLI vCloud Director session.

    .EXAMPLE
    Connect-vCAVService -Extend -Site "Brisbane" -AuthProvider "vcdLogin"
    Extends the current session to the remote site named "Brisbane" using the provided vCloud Director credentials. (eg. administrator@testorg)

    .NOTES
    This cmdlet does not currently support the SAML authentication method.

    AUTHOR: Adrian Begg
	LASTEDIT: 2019-09-10
	VERSION: 4.0
    #>
    [CmdletBinding(DefaultParameterSetName="Standard")]
    Param(
        [Parameter(Mandatory=$False, ParameterSetName="SaveCredentials")]
            [switch] $SaveCredentials,
        [Parameter(Mandatory=$False, ParameterSetName="UseSaved")]
            [switch] $UseSavedCredentials,
        [Parameter(Mandatory=$False, ParameterSetName="Extend")]
            [switch] $Extend,
        [Parameter(Mandatory=$True, ParameterSetName="Standard")]
        [Parameter(Mandatory=$True, ParameterSetName="SaveCredentials")]
			[ValidateNotNullorEmpty()] [string] $Server,
        [Parameter(Mandatory=$False, ParameterSetName="Standard")]
        [Parameter(Mandatory=$False, ParameterSetName="SaveCredentials")]
        [Parameter(Mandatory=$False, ParameterSetName="Extend")]
            [ValidateSet("Local","SSO","vCDLogin","vCDSession")]  [string] $AuthProvider="Local",
        [Parameter(Mandatory=$False, ParameterSetName="Standard")]
        [Parameter(Mandatory=$False, ParameterSetName="SaveCredentials")]
			[ValidateRange(1,65536)] [int] $Port=443,
        [Parameter(Mandatory=$False, ParameterSetName="Standard")]
        [Parameter(Mandatory=$False, ParameterSetName="SaveCredentials")]
        [Parameter(Mandatory=$False, ParameterSetName="Extend")]
            [PSCredential] $Credentials = [System.Management.Automation.PSCredential]::Empty,
        [Parameter(Mandatory=$False, ParameterSetName="Standard")]
        [Parameter(Mandatory=$False, ParameterSetName="SaveCredentials")]
            [ValidateSet(1,2,3,4)] [int] $APIVersion=3,
        [Parameter(Mandatory=$True, ParameterSetName="Extend")]
            [ValidateNotNullorEmpty()] [string] $Site,
        [Parameter(Mandatory=$True, ParameterSetName="UseSaved")]
        [Parameter(Mandatory=$False, ParameterSetName="SaveCredentials")]
            [ValidateNotNullorEmpty()] [string] $CredentialStoreFile
    )
    # Check if we are using a credential file first, this ensures that some checks are skipped
    if ($PSBoundParameters.ContainsKey("UseSavedCredentials")){
        # Attempt to load the credential store
        if(!(Test-Path -Path $CredentialStoreFile)){
            throw "Unable to find a saved credential file $CredentialStoreFile. Please check the path and try again."
        }
        # Next try and read the file
        try{
            $JSONvCAVCreds = Get-Content -Raw -Path $CredentialStoreFile | ConvertFrom-Json
        } catch {
            throw "An error occured reading the JSON in the credential file $CredentialStoreFile for vCAV login. Please check that the file is well formed."
        }
        # Now load the values into memory
        try{
            [SecureString] $APIPassword = $JSONvCAVCreds.EncyptedPassword | ConvertTo-SecureString
        } catch {
            throw "Unable to decrypt the encrypted password in the configuration file. Please ensure you are executing as the same user session that generated the file."
        }
        # Set the properites
        $Credentials = New-Object System.Management.Automation.PSCredential ($JSONvCAVCreds.Username, $APIPassword)
        [string] $Server = $JSONvCAVCreds.Server
        [int] $Port = $JSONvCAVCreds.Port
        [string] $AuthProvider = $JSONvCAVCreds.AuthProvider
        [int] $APIVersion = $JSONvCAVCreds.APIVersion
    }
    # Next we need to check if a Parameter for Credentials was provided; this needs to be done here instead of during parameter checking for UseSavedCredentials not to prompt
    if($Credentials -eq [System.Management.Automation.PSCredential]::Empty) {
        $Credentials = $Host.ui.PromptForCredential("Enter credentials for $Server", "Please enter your user name and password for the provided auth type.", "", "")
    }
    if($PSBoundParameters.ContainsKey("SaveCredentials")){
        # Construct an object with the required values for authentication
        $objAuthCache = New-Object System.Management.Automation.PSObject
        $objAuthCache | Add-Member Note* Server $Server
        $objAuthCache | Add-Member Note* Port $Port
        $objAuthCache | Add-Member Note* AuthProvider $AuthProvider
        $objAuthCache | Add-Member Note* Username $Credentials.UserName
        $objAuthCache | Add-Member Note* EncyptedPassword ($Credentials.GetNetworkCredential().Password | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString)
        $objAuthCache | Add-Member Note* APIVersion $APIVersion

        # Check if a credential file has been specified
        if($PSBoundParameters.ContainsKey("CredentialStoreFile")){
            # Next check if it already exists
            if(Test-Path -Path $CredentialStoreFile){
                Write-Warning "A saved credential file $CredentialStoreFile already exists in the specified path and will be overwritten if you continue." -WarningAction Inquire
            }
            # Write the credentials out to file and screen
            ConvertTo-Json $objAuthCache | Out-File $CredentialStoreFile
        }
        # Output to local console
        ConvertTo-Json $objAuthCache
    } elseif($PSBoundParameters.ContainsKey("Extend")){
        # Check if connected and warn if already connected to a server
        if(!$global:DefaultvCAVServer.IsConnected){
            throw "You are not currently connected to a local vCAV Service. In order to extend your session to a remote site you must first authenticate with the local site."
            Break
        }
        # Next check if the Site provided is registered in the locally connected vCAV Site
        if((Get-vCAVSites | Where-Object {$_.site -eq $Site} -ne $null)){
            $AuthURI = $global:DefaultvCAVServer.ServiceURI + "sessions/extend"
            # Construct the JSON payload for authentication
            $objAuthPayload = New-Object System.Management.Automation.PSObject
            if($AuthProvider -eq "vCDLogin"){
                $objAuthPayload | Add-Member Note* type "credentials"
                $objAuthPayload | Add-Member Note* site $Site
                $objAuthPayload | Add-Member Note* vcdUser $Credentials.UserName
                $objAuthPayload | Add-Member Note* vcdPassword $Credentials.GetNetworkCredential().Password
            } elseif($AuthProvider -eq "vCDSession"){
                if($global:DefaultCIServers.IsConnected){
                    $objAuthPayload | Add-Member Note* type "cookie"
                    $objAuthPayload | Add-Member Note* site $Site
                    $objAuthPayload | Add-Member Note* vcdCookie $global:DefaultCIServers.SessionSecret
                } else {
                    throw "You are currently not connected to vCloud Director. This Authentication option is only available when connected to vCloud using Connect-CIServer."
                }
            } else {
                throw "The provided AuthProvider is not valid for session extention. Only the vCDLogin and vCDSession methods are supported with this option."
            }
            # Make the API call to extend the session and update the Global
            $JSONExtendRequest = (Invoke-vCAVAPIRequest -URI $AuthURI -Method Post -APIVersion $DefaultvCAVServer.DefaultAPIVersion -Data (ConvertTo-JSON $objAuthPayload)).JSONData
            $DefaultvCAVServer.Roles = $JSONExtendRequest.roles
            $DefaultvCAVServer.User = $JSONExtendRequest.user
            $DefaultvCAVServer.AuthenticatedSites = $JSONExtendRequest.authenticatedSites
        } else {
            throw "A Site with the name $Site is not currently paired with the locally connected vCAV installation. Please check the Site configuration and try again."
        }
    } else {
        # Now for main entry point to create a local session
        # Check if already connected and warn if already connected to a server
        if($global:DefaultvCAVServer.IsConnected){
            Write-Warning "You are currently already connected to the vCAV Service $($global:DefaultvCAVServer.Server). Your existing session will be disconnected if you continue." -WarningAction Inquire
            Disconnect-vCAVService
        }
        # Construct the URI for the API call to connect to the vCAV Service
        [string] $AuthURI = "https://" + $Server + ":" + $Port + "/sessions"

        # Construct the JSON payload for authentication
        $objAuthPayload = New-Object System.Management.Automation.PSObject
        if($AuthProvider -eq "SSO"){
            $objAuthPayload | Add-Member Note* type "ssoCredentials"
            $objAuthPayload | Add-Member Note* username $Credentials.UserName
            $objAuthPayload | Add-Member Note* password $Credentials.GetNetworkCredential().Password
        } elseif($AuthProvider -eq "Local"){
            $objAuthPayload | Add-Member Note* type "localUser"
            $objAuthPayload | Add-Member Note* localUser $Credentials.UserName
            $objAuthPayload | Add-Member Note* localPassword $Credentials.GetNetworkCredential().Password
        } elseif($AuthProvider -eq "vCDLogin"){
            $objAuthPayload | Add-Member Note* type "vcdCredentials"
            $objAuthPayload | Add-Member Note* vcdUser $Credentials.UserName
            $objAuthPayload | Add-Member Note* vcdPassword $Credentials.GetNetworkCredential().Password
        } elseif($AuthProvider -eq "vCDSession"){
            if($global:DefaultCIServers.IsConnected){
                $objAuthPayload | Add-Member Note* type "vcdCookie"
                $objAuthPayload | Add-Member Note* vcdCookie $global:DefaultCIServers.SessionSecret
            } else {
                throw "You are currently not connected to vCloud Director. This Authentication option is only available when connected to vCloud using Connect-CIServer."
            }
        }
        # Now make the call to the Logon Service; if no exception is thrown store the session details.
        $JSONAuthRequest = Invoke-vCAVAPIRequest -URI $AuthURI -Data (ConvertTo-JSON $objAuthPayload) -Method Post -APIVersion $APIVersion -CheckConnection $false
        $objAuthData = $JSONAuthRequest.JSONData
        $objvCAVService = New-Object System.Management.Automation.PSObject
        $objvCAVService | Add-Member Note* Name $Server
        $objvCAVService | Add-Member Note* ServiceURI ("https://" + $Server + ":" + $Port + "/")
        $objvCAVService | Add-Member Note* Port $Port
        $objvCAVService | Add-Member Note* AuthenticationProvider $AuthProvider
        $objvCAVService | Add-Member Note* AccessToken $($JSONAuthRequest.Headers.'X-VCAV-Auth')
        $objvCAVService | Add-Member Note* IsConnected $true
        $objvCAVService | Add-Member Note* Roles $objAuthData.roles
        $objvCAVService | Add-Member Note* User $objAuthData.user
        $objvCAVService | Add-Member Note* AuthenticatedSites $objAuthData.authenticatedSites
        $objvCAVService | Add-Member Note* DefaultAPIVersion $APIVersion
        $objvCAVService | Add-Member Note* serviceType ""
        $objvCAVService | Add-Member Note* productName ""
        $objvCAVService | Add-Member Note* buildVersion ""
        $objvCAVService | Add-Member Note* buildDate ""
        Set-Variable -Name "DefaultvCAVServer" -Value $objvCAVService -Scope Global

        # Next make a call to get version infomration for the endpoint; we need to check the API version first by examining the header from the Auth request
        [string] $AboutURI = $Global:DefaultvCAVServer.ServiceURI + "diagnostics/about"
        try{
            $JSONAboutRequest = Invoke-vCAVAPIRequest -URI $AboutURI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion -CheckConnection $false
            $DefaultvCAVServer.serviceType = $JSONAboutRequest.JSONData.serviceType
            $DefaultvCAVServer.productName = $JSONAboutRequest.JSONData.productName
            $DefaultvCAVServer.buildVersion = $JSONAboutRequest.JSONData.buildVersion
            $DefaultvCAVServer.buildDate = $JSONAboutRequest.JSONData.buildDate
        } catch {
            # If an exception is thrown clear the connection
            Set-Variable -Name "DefaultvCAVServer" -Value $null -Scope Global
            throw "An error occured during the connection; check the API Version provided is correct and try again. $($_)"
        }
        # Finally check the highest version of the API is being used for newer version of the product
        if($DefaultvCAVServer.buildVersion -ge "3.5"){
            $DefaultvCAVServer.DefaultAPIVersion = 4
        }
    }
}