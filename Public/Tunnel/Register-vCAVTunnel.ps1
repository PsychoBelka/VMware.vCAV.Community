function Register-vCAVTunnel(){
    <#
    .SYNOPSIS
    Registers a H4 Tunnel Node with the currently connected vCloud Availability Service.

    .DESCRIPTION
    Registers a H4 Tunnel Node with the currently connected vCloud Availability service. After the tunnel has been configured all vCloud Availability components will route all incoming/outgoing traffic to the specified local tunnel service.

    After the tunnel service has been configured all components must be restarted before the changes will take effect.

    .PARAMETER TunnelServiceURI
    The URI of the H4 Tunnel Service Management Service (eg. https://vcav-sitea.pigeonnuggets.com:8047)

    .PARAMETER TunnelServiceRootPassword
    The H4 Tunnel Service Root Password (encypted as a SecureString)

    .EXAMPLE
    Register-vCAVTunnel -TunnelServiceURI "https://vcav-sitea.pigeonnuggets.com:8047" -TunnelServiceRootPassword (ConvertTo-SecureString -String "Password!123" -AsPlainText -Force)
    Registers the vCloud Availability Runnel Service with the FQDN vcav-sitea.pigeonnuggets.com on TCP 8047 and the root password "Password!123" as the H4 Tunnel Service for this installation.

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 3.0
    #>
    Param(
        [Parameter(Mandatory=$True)]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [String] $TunnelServiceURI,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [SecureString] $TunnelServiceRootPassword
    )
    # First retrieve the certificate using the API
    [string] $certURI = $global:DefaultvCAVServer.ServiceURI + "config/remote-certificate?url=$TunnelServiceURI"
    $tunnelCertificate = (Invoke-vCAVAPIRequest -URI $certURI -Method Get ).JSONData
    # Cast to a PSCredential for passing to the API
    $TunnelCredentials = New-Object System.Management.Automation.PSCredential("root",$TunnelServiceRootPassword)
    # Next construct the object for the API
    $tunnelURI = $global:DefaultvCAVServer.ServiceURI + "config/tunnel-service"
    $objTunnelEndpoint = New-Object System.Management.Automation.PSObject
    $objTunnelEndpoint | Add-Member Note* url $TunnelServiceURI
    $objTunnelEndpoint | Add-Member Note* certificate $tunnelCertificate.encoded
    $objTunnelEndpoint | Add-Member Note* rootPassword ($TunnelCredentials.GetNetworkCredential().Password)

    $RequestResponse = (Invoke-vCAVAPIRequest -URI $tunnelURI -Data (ConvertTo-JSON $objTunnelEndpoint) -Method Post ).JSONData
    $RequestResponse
}