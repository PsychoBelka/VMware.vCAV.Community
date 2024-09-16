---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Get-vCAVProviderVDCs

## SYNOPSIS
This cmdlet returns the Provider VDCs available in the vCloud instance currently connected vCloud Availability service.

## SYNTAX

### Default (Default)
```
Get-vCAVProviderVDCs [-Site <String>] [<CommonParameters>]
```

### ByName
```
Get-vCAVProviderVDCs [-Name <String>] [-Site <String>] [<CommonParameters>]
```

### ById
```
Get-vCAVProviderVDCs [-Id <String>] [-Site <String>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet returns the Provider VDCs available in the vCloud instance currently connected vCloud Availability service.

## EXAMPLES

### EXAMPLE 1
```
Get-vCAVProviderVDCs
```

Returns all the Provider Virtual Datacenter in the local site.

### EXAMPLE 2
```
Get-vCAVProviderVDCs -Name "SiteA-PVDC-1"
```

Returns the Provider Virtual Datacenter with the Provder VDC Name "SiteA-PVDC-1" in the local site.

### EXAMPLE 3
```
Get-vCAVProviderVDCs -Id "2241c7fe-7319-4d89-bf0e-3eb647474416"
```

Returns the Provider Virtual Datacenter with the Provder VDC Id "2241c7fe-7319-4d89-bf0e-3eb647474416" in the local site.

## PARAMETERS

### -Name
A Name of a vCloud Provider Virtual Datacenter (PVDC) to filter results by

```yaml
Type: String
Parameter Sets: ByName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
A Id of a vCloud Provider Virtual Datacenter (PVDC) to filter results by

```yaml
Type: String
Parameter Sets: ById
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Site
Optionally the vCloud Availability site.
Default is the local site.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: ((Get-vCAVSites -SiteType "Local").site)
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
AUTHOR: PsychoBelka (Original Adrian Begg)
LASTEDIT: 2024-09-16
VERSION: 1.0

## RELATED LINKS
