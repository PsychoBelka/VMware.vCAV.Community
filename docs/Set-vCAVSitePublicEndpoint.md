---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Set-vCAVSitePublicEndpoint

## SYNOPSIS
Sets the Public Endpoint addresses for the local site of the currently connected vCloud Availability service.

## SYNTAX

```
Set-vCAVSitePublicEndpoint [-APIPublicAddress] <String> [[-ManagementPublicAddress] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Sets the Public Endpoint addresses for the local site of the currently connected vCloud Availability service.

## EXAMPLES

### EXAMPLE 1
```
Set-vCAVSitePublicEndpoint -APIPublicAddress "https://vcav.pigeonnuggets.com" -ManagementPublicAddress "https://vcav.internal.pigeonnuggets.com:8047"
```

Sets the Public API Endpoint for the current vCloud installation to https://vcav.pigeonnuggets.com and the Management (internal) API to https://vcav.pigeonnuggets.com:8047

## PARAMETERS

### -APIPublicAddress
The URI of the Publicly accessable API Service endpoint for vCloud Availability (e.g.
https://vcav.pigeonnuggets.com)

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
The URI of the Publicly accessable API Service endpoint for vCloud Availability.
(e.g.
https://vcav.internal.pigeonnuggets.com:8047)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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
LASTEDIT: 2019-09-16
VERSION: 3.0

## RELATED LINKS
