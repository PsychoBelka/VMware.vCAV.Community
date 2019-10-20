---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Set-vCAVTunnelEndpoint

## SYNOPSIS
** DEPRICATED ** Configures the H4 Tunnel Endpoint address for vCloud Availability.

## SYNTAX

```
Set-vCAVTunnelEndpoint [-ManagementAddress] <String> [-ManagementPublicAddress] <String>
 [-TunnelAddress] <String> [-TunnelPublicAddress] <String> [<CommonParameters>]
```

## DESCRIPTION
** DEPRICATED ** This cmdlet is depricated and was used in vCAV 1.5/3.0 for Tunnel configuration.
Please use Register-vCAVTunnel cmdlet against the Manager to configure Tunnelling.

## EXAMPLES

### EXAMPLE 1
```
Set-vCAVTunnelEndpoint -ManagementAddress "https://vcav.internal.pigeonnuggets.com:8047" -ManagementPublicAddress "https://vcav.pigeonnuggets.com:8047" -TunnelAddress "http://vcav.internal.pigeonnuggets.com:8048" -TunnelPublicAddress "http://vcav.pigeonnuggets.com:8048"
```

Sets the Public Tunnel Endpoint for the current vCloud installation to vcav.pigeonnuggets.com and the internal address to vcav.internal.pigeonnuggets.com on TCP 8048 (management on TCP 8047)

## PARAMETERS

### -ManagementAddress
The URI to advertise to the components on the local site as the internal management address (eg.
http://vcav.internal.pigeonnuggets.com:8047)

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

### -ManagementPublicAddress
The URI to advertise to the components as the public management address (eg.
http://vcav.pigeonnuggets.com:8047)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TunnelAddress
The URI to advertise to the components on the local site as the internal Tunnel endpoint address (eg.
http://vcav.internal.pigeonnuggets.com:8048)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TunnelPublicAddress
The URI to advertise to the components on the local site as the public Tunnel endpoint address (eg.
http://vcav.pigeonnuggets.com:8048)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
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
LASTEDIT: 2019-08-22
VERSION: 2.0

## RELATED LINKS
