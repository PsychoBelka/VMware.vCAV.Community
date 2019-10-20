function Install-vCAVCertificate(){
    <#
    .SYNOPSIS
    Replaces the certificate that is currently installed on the appliance with a custom certificate.

    .DESCRIPTION
    Replaces the certificate that is currently installed on the appliance with a custom certificate. The old certificate will be backed up and stored on the appliance. This will restart the service.

    .PARAMETER Certificate
    Full file path to PKCS#12 file which contains one private key and its corresponding certificate.

    .PARAMETER CertificateFileSecret
    A secure string with the keystore password. The keystore password and the password for the private key must be the same.

    .PARAMETER Force
    If set as True, the user will not be warned and the cmdlet will execute without prompting for confirmation

    .EXAMPLE
    Install-vCAVCertificate -Certificate "D:\Tools\Scripts\vSphere\vCAV\vcav-site-a-pigeonnuggets-com.pfx" -Password ("Password!" | ConvertTo-SecureString)
    Installs the certificate in PKCS#12 file D:\Tools\Scripts\vSphere\vCAV\vcav-site-a-pigeonnuggets-com.pfx with keystore and private key password of Password! to the connected vCloud Availability service.

    .EXAMPLE
    Install-vCAVCertificate -Certificate "D:\Tools\Scripts\vSphere\vCAV\vcav-site-a-pigeonnuggets-com.pfx" -Password ("Password!" | ConvertTo-SecureString) -Force $true
    Installs the certificate in PKCS#12 file D:\Tools\Scripts\vSphere\vCAV\vcav-site-a-pigeonnuggets-com.pfx with keystore and private key password of Password! to the connected vCloud Availability service without prompting for confirmation.

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-09-16
	VERSION: 2.0
    #>
    Param(
		[Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [String] $Certificate,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [SecureString] $CertificateFileSecret,
        [Parameter(Mandatory=$False)]
            [bool]$Force = $false
    )
    # First validate if the certificate and password are valid and the Usage Type contains Server Authentication
    try{
        $objCertVerify = Get-PfxCertificate -FilePath $Certificate -Password $CertificateFileSecret
    } catch {
        if($_.Exception.Message -eq "The specified network password is not correct"){
            throw "The password provided for the PKCS#12 certificate $Certificate is not correct."
        } elseif($_.Exception.Message -eq "Command cannot find any of the specified files"){
            throw "The file $Certificate does not exist. Please check the path and try the cmdlet again."
        } elseif($_.Exception.Message -eq "Cannot find the requested object"){
            throw "The file $Certificate is corrupt or does not appear to be a valid PKCS#12 file. Please check the path and try the cmdlet again."
        } else {
            throw $_
        }
    }
    if($objCertVerify.EnhancedKeyUsageList.FriendlyName -notcontains "Server Authentication"){
        throw "The provided certificate does not have a Enhanced Key Usage of type Server Authentication. vCAV requires a certificate with this Usage Type."
    }
    # As non-JSON/standard API call need to directly create the request for the Payload
    # Validate the environment is ready based on the input parameters
    if($DefaultvCAVServer.buildVersion -lt "3.0"){
        throw "This cmdlet is only supported on vCloud Availability 3.0+. The current connected version is $($DefaultvCAVServer.buildVersion)"
    }
    $PlainTextCertSecret = New-Object System.Management.Automation.PSCredential ("empty", $CertificateFileSecret)

    # Construct the headers for the API call
    $APIHeaders = @{
            'Content-Type' = 'application/octet-stream'
            'Accept' = 'application/vnd.vmware.h4-v3+json'
            'X-VCAV-Auth' = $global:DefaultvCAVServer.AccessToken
            'Secret' = $PlainTextCertSecret.GetNetworkCredential().Password
    }
    # Create a Hashtable with base paramters to use for splatting to Invoke-WebRequest
    $HashInvokeArguments = @{
        Uri = ($global:DefaultvCAVServer.ServiceURI + "config/certificate")
        Method = "Post"
        Headers = $APIHeaders
        InFile = $Certificate
    }
    # Next check the PowerCLI Proxy policy to determine if what Proxy Policy should be used for the API call,
    if((Get-PowerCLIConfiguration -Scope "User" | Select-Object ProxyPolicy).ProxyPolicy -eq "NoProxy") {
        $HashInvokeArguments.Add("NoProxy",$true)
    }
    # Check if the Certificate Check should be performed and add the argument if not
    if((Get-PowerCLIConfiguration -Scope "User" | Select-Object InvalidCertificateAction).InvalidCertificateAction -eq "Ignore") {
        $HashInvokeArguments.Add("SkipCertificateCheck",$true)
    }
    # Warn the users that this is dangerous
    if(!$Force){
        Write-Warning "This cmdlet overwrites the currently installed certificate on the connected vCAV Service. This will cause all existing trusts with other sites and customer on-pemise appliances to become invalid. Please proceed with caution/during an organised and planned maintenance window." -WarningAction Inquire
    }

    # Now try and make the API call
    try{
        $Request = Invoke-WebRequest @HashInvokeArguments
        $objResponse = New-Object System.Management.Automation.PSObject
        $objResponse | Add-Member Note* Headers $Request.Headers
        if($null -ne $Request.Content){
            $objResponse | Add-Member Note* JSONData (ConvertFrom-JSON ([System.Text.Encoding]::UTF8.GetString($Request.Content)))
        }
        $objResponse.JSONData
        Write-Warning "Certificate installation complete. The service will automatically restart. You must reconnect to vCloud Availability."
        Disconnect-vCAVService
    } catch {
        if($_.Exception.Response.StatusCode -eq "Unauthorized"){
            throw "An Unauhorized Exception was thrown attempting to make the API call to $($global:DefaultvCAVServer.ServiceURI + "config/certificate"). Please check that you have the required permissions to execute this call and that you have a current connected session."
        } else {
            throw "An error occured making an API call to $($global:DefaultvCAVServer.ServiceURI + "config/certificate"). Exception details: $($_.Exception)"
        }
    }
}
