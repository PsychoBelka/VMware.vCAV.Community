---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Deploy-vCAVTunnel

## SYNOPSIS
This cmdlet deploys a vCloud Availability H4 Tunnel appliance to the currently connected vCenter Server and registers it with the provided vCloud Availabity installation.

## SYNTAX

```
Deploy-vCAVTunnel -vSphereLookupService <String> -PublicEndpointAddress <String>
 -InternalManagementAddress <String> [-PKCS12CertificateFile <String>] [-CertificateFileSecret <SecureString>]
 -OVAImage <String> -Cluster <String> -VMFolder <String> -VMName <String> [-StorageType <String>]
 -Datastore <String> -RootPassword <SecureString> -vNIC0_PortGroup <String> -vNIC0_IP <String>
 -vNIC0_Netmask <String> -DefaultGatewayIP <String> -HostName <String> [-SSHEnabled <Boolean>]
 [-NTPServers <String>] -DNSServers <String> -DNSSearchPath <String> [-HostEntries <String>]
 [-vNIC0_StaticRoutes <String>] [-SecondaryNIC] -vNIC1_PortGroup <String> -vNIC1_IP <String>
 -vNIC1_Netmask <String> -vNIC0_BuildGateway <String> [-vNIC1_StaticRoutes <String>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet deploys a vCloud Availability H4 Tunnel appliance to the currently connected vCenter Server and registers it with the provided vCloud Availabity Services in the installation.
The steps taken are as follows:
- The basic appliance is deployed and configured using the New-vCAVAppliance cmdlet
- The vSphere Lookup Service is registered with the appliance
- If provided, the self-certificate is replaced on the appliance with the one provided
- The Tunnel Endpoint addressing is configured

These steps must be executed manually after the tunnel has been deployed before it can be used:
- The Cloud Manager is registered with the Tunnel
- The Cloud Manager is restarted
- All of the Replicators in the installation are restarted

Note: Only IPv4 addressing is available using this command at this time.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -vSphereLookupService
{{ Fill vSphereLookupService Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PublicEndpointAddress
{{ Fill PublicEndpointAddress Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InternalManagementAddress
{{ Fill InternalManagementAddress Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PKCS12CertificateFile
{{ Fill PKCS12CertificateFile Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CertificateFileSecret
{{ Fill CertificateFileSecret Description }}

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OVAImage
{{ Fill OVAImage Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Cluster
{{ Fill Cluster Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VMFolder
{{ Fill VMFolder Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VMName
{{ Fill VMName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StorageType
{{ Fill StorageType Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Datastore
Accept pipeline input: False
Accept wildcard characters: False
```

### -Datastore
{{ Fill Datastore Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RootPassword
{{ Fill RootPassword Description }}

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vNIC0_PortGroup
{{ Fill vNIC0_PortGroup Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vNIC0_IP
{{ Fill vNIC0_IP Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vNIC0_Netmask
{{ Fill vNIC0_Netmask Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultGatewayIP
{{ Fill DefaultGatewayIP Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HostName
{{ Fill HostName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SSHEnabled
{{ Fill SSHEnabled Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -NTPServers
{{ Fill NTPServers Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DNSServers
{{ Fill DNSServers Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DNSSearchPath
{{ Fill DNSSearchPath Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HostEntries
{{ Fill HostEntries Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vNIC0_StaticRoutes
{{ Fill vNIC0_StaticRoutes Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecondaryNIC
{{ Fill SecondaryNIC Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -vNIC1_PortGroup
{{ Fill vNIC1_PortGroup Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vNIC1_IP
{{ Fill vNIC1_IP Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vNIC1_Netmask
{{ Fill vNIC1_Netmask Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vNIC0_BuildGateway
{{ Fill vNIC0_BuildGateway Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vNIC1_StaticRoutes
{{ Fill vNIC1_StaticRoutes Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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

## RELATED LINKS
