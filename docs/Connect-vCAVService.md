---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Connect-vCAVService

## SYNOPSIS
This cmdlet establishes a connection to the specified vCloud Availability server.

## SYNTAX

### Standard (Default)
```
Connect-vCAVService -Server <String> [-AuthProvider <String>] [-Port <Int32>] [-Credentials <PSCredential>]
 [-APIVersion <Int32>] [<CommonParameters>]
```

### SaveCredentials
```
Connect-vCAVService [-SaveCredentials] -Server <String> [-AuthProvider <String>] [-Port <Int32>]
 [-Credentials <PSCredential>] [-APIVersion <Int32>] [-CredentialStoreFile <String>] [<CommonParameters>]
```

### UseSaved
```
Connect-vCAVService [-UseSavedCredentials] -CredentialStoreFile <String> [<CommonParameters>]
```

### Extend
```
Connect-vCAVService [-Extend] [-AuthProvider <String>] [-Credentials <PSCredential>] -Site <String>
 [<CommonParameters>]
```

## DESCRIPTION
This cmdlet establishes a connection to the specified vCloud Availability server.
The cmdlet starts a new session or re-establishes a previous session with a cloud server using the specified parameters.
If a connection to a server already exists, the cmdlet will disconnect the session and re-attempt the connection.

In order to perform replication management operations that involve remote sites, your session needs to be "extended" with credentials (vCD auth cookie or org user and password) to the related remote site.
The -Extend switch can be used for this purpose.

To set the default behavior of PowerCLI when no valid certificates are recognized, use the InvalidCertificateAction parameter of the Set-PowerCLIConfiguration cmdlet.
For more information about invalid certificates, run 'Get-Help about_invalid_certificates'.

To set the proxy usage behavior of PowerCLI (eg.
to bypass a proxy or to use the System Proxy), use the ProxyPolicy parameter of the Set-PowerCLIConfiguration cmdlet.

The connection details are kept in a global variable called $DefaultvCAVServer.
When you disconnect from a server, the server is removed from the $DefaultvCAVServer variable.
You can modify the value of the $DefaultCIServers variable manually.

You can also use the -SaveCredentials switches to export credentials that can be used with the -UseSavedCredentials switch for use in Automation.

## EXAMPLES

### EXAMPLE 1
```
Connect-vCAVService -Server "vcav.pigeonnuggets.com" -Port 8044
```

Connects to the vCloud Availability server "vcav.pigeonnuggets.com" on TCP 8044 using the Local Authentication method prompting the user for credentials.

### EXAMPLE 2
```
Connect-vCAVService -Server "vcav.pigeonnuggets.com" -Port 8044 -AuthProvider "vCDSession"
```

Connects to the vCloud Availability server "vcav.pigeonnuggets.com" on TCP 8044 using the vCloud Director credentials stored in the PowerCLI global variable $DefaultCIServers.

### EXAMPLE 3
```
Connect-vCAVService -Server "vcav.pigeonnuggets.com" -AuthProvider "vCDLogin"
```

Connects to the vCloud Availability server "vcav.pigeonnuggets.com" on TCP 443 prompting the user for vCloud Director credentials.
(eg.
administrator@system)

### EXAMPLE 4
```
Connect-vCAVService -Server "vcav.pigeonnuggets.com" -AuthProvider "SSO"
```

Connects to the vCloud Availability server "vcav.pigeonnuggets.com" on TCP 443 prompting the user for the SSO Lookup Service vSphere SSO Credentials (eg.
administrator@vsphere.local)

### EXAMPLE 5
```
Connect-vCAVService -Server "vcav.pigeonnuggets.com" -SaveCredentials -CredentialStoreFile "vcav-pigeonnuggets-com.json"
```

Creates a new saved credential for the "vcav.pigeonnuggets.com" vCAV service and outputs it to "vcav-pigeonnuggets-com.json" in the local directory.

### EXAMPLE 6
```
Connect-vCAVService -UseSavedCredentials -CredentialStoreFile "vcav-pigeonnuggets-com.json"
```

Connects to the vCloud Availability Server specified in the credential store file "vcav-pigeonnuggets-com.json"

### EXAMPLE 7
```
Connect-vCAVService -Extend -Site "Brisbane" -AuthProvider "vcdSession"
```

Extends the current session to the remote site named "Brisbane" using the currently logged in PowerCLI vCloud Director session.

### EXAMPLE 8
```
Connect-vCAVService -Extend -Site "Brisbane" -AuthProvider "vcdLogin"
```

Extends the current session to the remote site named "Brisbane" using the provided vCloud Director credentials.
(eg.
administrator@testorg)

## PARAMETERS

### -SaveCredentials
Indicates that you want to only save the specified credentials.
The credentials and connection details are outputed (with the password encrypted using the local user account) to the local console.
Optionally if -CredentialStoreFile is provided the output is also saved into a local file specified in the -CredentialStoreFile parameter.
This file can be used in scripts later use in automation.

```yaml
Type: SwitchParameter
Parameter Sets: SaveCredentials
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSavedCredentials
Indicates that saved credentials generated from using the -SaveCredentials should be read for the connection.
The credentials are read from the well-formed JSON file provided in paramter -CredentialStoreFile

```yaml
Type: SwitchParameter
Parameter Sets: UseSaved
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Extend
Indicates that the session should be extended with a connection to the specified remote vCloud Availability site.

```yaml
Type: SwitchParameter
Parameter Sets: Extend
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Server
Specifies the IP address or DNS Hostname of the vCloud Availability server

```yaml
Type: String
Parameter Sets: Standard, SaveCredentials
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AuthProvider
The Authentication Provider which should be used to connect.
Local or vSphere SSO for Administrative access and vCloud or vCD Session for vCloud Director based logon.
The default is Local authentication

```yaml
Type: String
Parameter Sets: Standard, SaveCredentials, Extend
Aliases:

Required: False
Position: Named
Default value: Local
Accept pipeline input: False
Accept wildcard characters: False
```

### -Port
Specifies the TCP Port for the connection; the Default is TCP 443.

```yaml
Type: Int32
Parameter Sets: Standard, SaveCredentials
Aliases:

Required: False
Position: Named
Default value: 443
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credentials
Specifies a PSCredential object that contains credentials for authenticating with the server.

```yaml
Type: PSCredential
Parameter Sets: Standard, SaveCredentials, Extend
Aliases:

Required: False
Position: Named
Default value: [System.Management.Automation.PSCredential]::Empty
Accept pipeline input: False
Accept wildcard characters: False
```

### -APIVersion
The API Version to use for the connection.
Default is Version 3.
(vCloud Availability 3.0.X)
During connection if a higher version of the API detected as supported it will be used.

```yaml
Type: Int32
Parameter Sets: Standard, SaveCredentials
Aliases:

Required: False
Position: Named
Default value: 3
Accept pipeline input: False
Accept wildcard characters: False
```

### -Site
The registered Remote Site to Extend the session to

```yaml
Type: String
Parameter Sets: Extend
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CredentialStoreFile
File path to store or read the connection properties.

```yaml
Type: String
Parameter Sets: SaveCredentials
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: UseSaved
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
This cmdlet does not currently support the SAML authentication method.

AUTHOR: PsychoBelka (Original Adrian Begg)
LASTEDIT: 2024-09-16
VERSION: 4.0

## RELATED LINKS
