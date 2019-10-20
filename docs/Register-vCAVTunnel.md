---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Register-vCAVTunnel

## SYNOPSIS
Registers a H4 Tunnel Node with the currently connected vCloud Availability Service.

## SYNTAX

```
Register-vCAVTunnel [-TunnelServiceURI] <String> [-TunnelServiceRootPassword] <SecureString>
 [<CommonParameters>]
```

## DESCRIPTION
Registers a H4 Tunnel Node with the currently connected vCloud Availability service.
After the tunnel has been configured all vCloud Availability components will route all incoming/outgoing traffic to the specified local tunnel service.

After the tunnel service has been configured all components must be restarted before the changes will take effect.

## EXAMPLES

### EXAMPLE 1
```
Register-vCAVTunnel -TunnelServiceURI "https://vcav-sitea.pigeonnuggets.com:8047" -TunnelServiceRootPassword (ConvertTo-SecureString -String "Password!123" -AsPlainText -Force)
```

Registers the vCloud Availability Runnel Service with the FQDN vcav-sitea.pigeonnuggets.com on TCP 8047 and the root password "Password!123" as the H4 Tunnel Service for this installation.

## PARAMETERS

### -TunnelServiceURI
The URI of the H4 Tunnel Service Management Service (eg.
https://vcav-sitea.pigeonnuggets.com:8047)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TunnelServiceRootPassword
The H4 Tunnel Service Root Password (encypted as a SecureString)

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
AUTHOR: Adrian Begg
LASTEDIT: 2019-06-14
VERSION: 3.0

## RELATED LINKS
