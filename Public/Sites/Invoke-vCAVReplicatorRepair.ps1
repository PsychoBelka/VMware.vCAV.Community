function Invoke-vCAVReplicatorRepair(){
    <#
    .SYNOPSIS
    Invokes a Repair (Cookie Reset) against a H4 Replicator which is regsitered with the  currently connected vCloud Availability H4 Manager Service.

    .DESCRIPTION
    Invokes a Repair (Cookie Reset) against a H4 Replicator which is regsitered with the  currently connected vCloud Availability H4 Manager Service.

    .PARAMETER Id
    The Replicator Id for the Replicator to be repaired

    .PARAMETER ReplicatorPassword
    The root password of the Replicator appliance to be repaired

    .PARAMETER vSphereAPICredentials
    A vSphere SSO account with VI Administrator rights on the Resoruce vCenter. These credentials will be used for performing the H4 primative calls to the hypervisors for Replication operations.

    .EXAMPLE
    Invoke-vCAVReplicatorRepair -Id "0661dbf4-4105-4754-aae5-f7c7674c044f" -ReplicatorPassword (ConvertTo-SecureString -String "Password!123" -AsPlainText -Force) -vSphereCredentials (Get-Credentials)
    Repairs a replicator with the Id "0661dbf4-4105-4754-aae5-f7c7674c044f" using the Password Password!123 and the vSphere Credentials provided at execution for the Resource vCenter Server.

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 2.0
    #>
    Param(
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [String] $Id,
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
    # First check if the Replicator with the Id exists
    if(Test-VCAVServiceEnvironment -ServiceType "Manager"){
        try{
            $Replicator = Get-vCAVReplicators -Id $Id
        } catch {
            throw "A Replicator with the provided Id $Id could not be found in this installation. Please check the provided parameters and try the cmdlet again."
        }
    }
    # Next we need to try and retrieve the Remote Certificate
    [string] $RemoteLookupServiceURI = $global:DefaultvCAVServer.ServiceURI + "config/remote-certificate?url=$($Replicator.apiURL)"
    try{
        $RemoteCertificate = (Invoke-vCAVAPIRequest -URI $RemoteLookupServiceURI -Method Get ).JSONData
    } catch {
        throw "An error occured retrieving the X.509 certificate for the Replicator API Service : $($Replicator.apiURL) . Please check that it is online and accessible from  the Manager."
    }
    [string] $URI = $global:DefaultvCAVServer.ServiceURI + "replicators/$Id/reset-cookie"
    # Prepare the payload for the cookie reset
    $objReplicatorDetails = New-Object System.Management.Automation.PSObject
    $objReplicatorDetails | Add-Member Note* apiThumbprint $RemoteCertificate.certificate.thumbPrint
    $objReplicatorDetails | Add-Member Note* apiUrl $Replicator.apiURL
    $objReplicatorDetails | Add-Member Note* rootPassword $ReplicatorPasswordPlain
    $objReplicatorDetails | Add-Member Note* ssoPassword $vSphereUsername
    $objReplicatorDetails | Add-Member Note* ssoUser $vSpherePassword

    # Now try and make the POST to reset the cookie for the Replicator
    try{
        $ReplicatorAPIResponse = (Invoke-vCAVAPIRequest -URI $URI -Data (ConvertTo-JSON $objReplicatorDetails) -Method Post ).JSONData
    } catch {
        throw "An error occured during the API call to Invoke the Repair Operation against the Replicator with Id: $Id"
    }
    $ReplicatorAPIResponse
}