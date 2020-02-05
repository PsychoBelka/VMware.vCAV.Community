
function Invoke-vCAVAPIRequest(){
    <#
    .SYNOPSIS
    This cmdlet will send a REST API call to a vCloud Availability Service and return an object containing the headers and the JSON data payload to the caller. If JSON is not returned by the call the Raw Data is returned to the caller.

    .DESCRIPTION
    The cmdlet acts as a wrapper to construct well formed HTTP headers and payload for a REST API call to a vCloud Availability Cloud-to-Cloud for DR service using the Invoke-WebRequest native method.

    To set the default behavior of PowerCLI when no valid certificates are recognized, use the InvalidCertificateAction parameter of the Set-PowerCLIConfiguration cmdlet. For more information about invalid certificates, run 'Get-Help about_invalid_certificates'.

    To set the proxy usage behavior of PowerCLI (eg. to bypass a proxy or to use the System Proxy), use the ProxyPolicy parameter of the Set-PowerCLIConfiguration cmdlet.

    .PARAMETER URI
    The fully qualified URI of the vCloud Availability API endpoint.

    .PARAMETER Method
    The HTTP Method to send for the API call

    .PARAMETER APIVersion
    The API version to be used for the API call

    .PARAMETER Data
    JSON data to be sent as the HTTP Payload in the API call.

    .PARAMETER CheckConnection
    If true, the current session/connection for vCloud Availability service set in $global:DefaultvCAVServer before making the API call.

    .PARAMETER Headers
    A Hashtable containing additional headers that should be passed during the API call. Any default headers will be overwritten.

    .PARAMETER QueryParameters
    A Hashtable containing a list of query parameters or specify the content of the response for a GET Request.

    .EXAMPLE
    Invoke-vCAVAPIRequest -URI ($global:DefaultvCAVServer.ServiceURI + "config/is-configured") -Method "Get" -APIVersion 1
    Performs a HTTP GET request against the connected server/config/is-configured using API Version 1 and returns the JSON response.

    .EXAMPLE
    Invoke-vCAVAPIRequest -URI ($global:DefaultvCAVServer.ServiceURI + "license"") -Method "Get" -APIVersion 2
    Performs a HTTP GET request against the connected server licnecing namespace using API Version 2 and returns the JSON response.

    .EXAMPLE
    Invoke-vCAVAPIRequest -URI ($global:DefaultvCAVServer.ServiceURI + "license"") -Method "Get" -APIVersion 2 -QueryParameters $htParameters
    Performs a HTTP GET request against the connected server licnecing namespace using API Version 2 and passes the parameters in the Hashatable $htParemeters as Query paremeters and returns the JSON response.

    .EXAMPLE
    Invoke-vCAVAPIRequest -URI  ($global:DefaultvCAVServer.ServiceURI + "config/root-password") -Data (ConvertTo-JSON $objRootPassword) -Method Post -APIVersion 1
    Performs a HTTP Post to reset the root password using the API verson 1 and forcing a certificate check.

    .NOTES
    This cmdlet obeys the ProxyPolicy and InvalidCertificateAction parameters set in the VMWare PowerCLI Configuration.
    There is a limitation for PowershellCore that at the cmdlet can only be used with the "UseSystemProxy" policy on Windows netsh winhttp show proxy settings; this will be changed in future

    AUTHOR: Adrian Begg
	LASTEDIT: 2019-09-10
	VERSION: 3.2
    #>
    Param(
        [Parameter(Mandatory=$True)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [string] $URI,
        [Parameter(Mandatory=$True)]
            [ValidateSet("Get","Put","Post","Delete","Patch")] [string] $Method,
        [Parameter(Mandatory=$True)]
            [ValidateSet(1,2,3,4)] [int] $APIVersion,
        [Parameter(Mandatory=$False)]
            [ValidateNotNullorEmpty()] [string] $Data,
        [Parameter(Mandatory=$False)]
            [bool] $CheckConnection = $true,
        [Parameter(Mandatory=$False)]
            [Hashtable] $Headers,
        [Parameter(Mandatory=$False)]
            [Hashtable] $QueryParameters
	)
    # Validate the environment is ready based on the input parameters
    if($CheckConnection){
        if(!(Test-VCAVServiceEnvironment)){
		    Break
        }
    }
    # Construct the headers for the API call
    $APIHeaders = @{
            'Content-Type' = 'application/json'
    }
    # Add the API Version Header
    if($APIVersion -eq 1){
        $APIHeaders.Add('Accept','application/vnd.vmware.h4-v1+json')
    } elseif($APIVersion -eq 2){
        $APIHeaders.Add('Accept','application/vnd.vmware.h4-v2+json')
    } elseif($APIVersion -eq 3){
        $APIHeaders.Add('Accept','application/vnd.vmware.h4-v3+json')
    } elseif($APIVersion -eq 4){
        $APIHeaders.Add('Accept','application/vnd.vmware.h4-v3.5+json')
    }
    # Add an Operation Id for Tracking Transactions in logs
    $APIHeaders.Add('operationID',("Powershell__$(New-Guid)"))

    # If not null add the Access Token for the API call to the header
    if(!([string]::IsNullOrEmpty($global:DefaultvCAVServer.AccessToken))){
        $APIHeaders.Add('X-VCAV-Auth',$global:DefaultvCAVServer.AccessToken)
    }
    # Check if any custom headers have been provided and if they have set them
    if($Headers.Count -ne 0){
        foreach($Key in $Headers.Keys){
            $APIHeaders.$Key = $Headers.$Key
        }
    }

    # Create a Hashtable with base paramters to use for splatting to Invoke-WebRequest
    $HashInvokeArguments = @{
        Uri = $URI
        Method = $Method
        Headers = $APIHeaders
    }
    # Next check the PowerCLI Proxy policy to determine if what Proxy Policy should be used for the API call and set accordingly
    if((Get-PowerCLIConfiguration -Scope "User" | Select-Object ProxyPolicy).ProxyPolicy -eq "NoProxy") {
        $HashInvokeArguments.Add("NoProxy",$true)
    } elseif((Get-PowerCLIConfiguration -Scope "User" | Select-Object ProxyPolicy).ProxyPolicy -eq "UseSystemProxy") {
        # Check the PowerShell edition first
        if($Global:PSEdition -eq "Desktop"){
            $Proxy = ([System.Net.WebRequest]::GetSystemWebProxy()).GetProxy($URI)
            $HashInvokeArguments.Add("Proxy",$Proxy.AbsoluteUri)
            $HashInvokeArguments.Add("ProxyUseDefaultCredentials",$true)
        } elseif($Global:PSEdition -eq "Core") {
            # For PowerShell Core you can not use the [System.Net.WebProxy]::GetDefaultProxy() or [System.Net.WebRequest]::GetSystemWebproxy() static method as its not supported
            # Really not happy with this implementation but temporary until can write a better handler or support is added for GetDefaultProxy static method
            $Proxy = Get-WinHttpProxy
            if($Proxy.'Winhttp proxy' -ne "Direct Access"){
                [string] $ProxyString = "http://$($Proxy.'Winhttp proxy')"
                $HashInvokeArguments.Add("Proxy",$ProxyString)
                $HashInvokeArguments.Add("ProxyUseDefaultCredentials",$true)
            }
        }
    }
    # Check if the Certificate Check should be performed and add the argument if not
    if((Get-PowerCLIConfiguration -Scope "User" | Select-Object InvalidCertificateAction).InvalidCertificateAction -eq "Ignore") {
        $HashInvokeArguments.Add("SkipCertificateCheck",$true)
    }
    # Check first if the method is a GET, if it is check if the a set of QueryParameters has been provided and set as the body, else if anything else then Body should be set as the $Data
    if(($Method -eq "Get") -and ($PSBoundParameters.ContainsKey("QueryParameters"))){
        $HashInvokeArguments.Add("Body", $QueryParameters)
    } elseif($PSBoundParameters.ContainsKey("Data")){
        $HashInvokeArguments.Add("Body", $Data)
    }
    # Now try and make the API call
    try{
        $Request = Invoke-WebRequest @HashInvokeArguments
        $objResponse = New-Object System.Management.Automation.PSObject
        $objResponse | Add-Member Note* Headers $Request.Headers
        if($null -ne $Request.Content){
            try{
                $objResponse | Add-Member Note* JSONData (ConvertFrom-JSON ([System.Text.Encoding]::UTF8.GetString($Request.Content)))
            } catch {
                # For non-JSON payloads
                $objResponse | Add-Member Note* RawData $Request.Content
            }
        }
        $objResponse
    } catch {
        if($_.Exception.Response.StatusCode -eq "Unauthorized"){
            throw [System.UnauthorizedAccessException] "An Unauhorized Exception was thrown attempting to make the API call to $URI. Please check that you have the required permissions to execute this call and that you have a current connected session."
        } else {
            throw "An error occurred making an API call to $URI. Exception details: $($_.Exception)"
        }
    }
}
