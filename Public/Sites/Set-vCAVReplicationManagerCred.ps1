function Set-vCAVReplicationManagerCred(){
    <#
    .SYNOPSIS
    Configures the SSO Credentials used by the H4 Manager to perform replication operations against the registered vCloud Resource vCenter

    .DESCRIPTION
    Configures the SSO Credentials used by the H4 Manager to perform replication operations against the registered vCloud Resource vCenter

    .PARAMETER ManagerURL
    The API URI for the H4 Manager Service

    .PARAMETER SSOCredentials
    A PSCredential object with a user account with administrator rights to the SSO domain set as the vSphere Lookup Service

    .EXAMPLE
    Set-vCAVReplicationManagerCred -SSOCredentials (New-Object System.Management.Automation.PSCredential("administrator@vsphere.local",(ConvertTo-SecureString "Password!123" -AsPlainText -Force)))
    Sets the Resource vCenter Service Account for the H4 Manager to "administrator@vsphere.local"

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 2.0
    #>

    Param(
        [Parameter(Mandatory=$False)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [string] $ManagerURL,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [PSCredential] $SSOCredentials
    )
    # Configure the SSO Credentials for the Resource vCenter
    [string] $ConfigURI = $global:DefaultvCAVServer.ServiceURI + "config/manager"
    $objvCenterConfig = New-Object System.Management.Automation.PSObject
    $objvCenterConfig | Add-Member Note* managerUrl $ManagerURL
    $objvCenterConfig | Add-Member Note* managerCertificate ""
    $objvCenterConfig | Add-Member Note* ssoUsername ($SSOCredentials.Username)
    $objvCenterConfig | Add-Member Note* ssoPassword ($SSOCredentials.GetNetworkCredential().Password)
    $vCenterConfigResponse = Invoke-vCAVAPIRequest -URI $ConfigURI -Data (ConvertTo-JSON $objvCenterConfig) -Method Post 
    $vCenterConfigResponse.JSONData
}