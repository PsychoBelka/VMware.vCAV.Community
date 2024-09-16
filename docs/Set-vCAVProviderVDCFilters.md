---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Set-vCAVProviderVDCFilters

## SYNOPSIS
Sets a filter on the currently connected vCloud Availability service to restrict the accessible Provider VDCs to vCloud Availability.

## SYNTAX

### Set
```
Set-vCAVProviderVDCFilters -ProvidedVDCIds <String[]> [-Preserve] [<CommonParameters>]
```

### Reset
```
Set-vCAVProviderVDCFilters [-Reset] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet can be used in order to support the following use cases for vCloud Availability:
- Datacenters in different locations managed by a single vCD (for example when seperate vCloud Availability instances are in each DC and scope/backed by PVDCs in each location)
- For leveraging vCloud Availability with multiple unfederated VCs as well as with dedicated customer VCs

## EXAMPLES

### EXAMPLE 1
```
Set-vCAVProviderVDCFilters -ProvidedVDCIds @("2241c7fe-7319-4d89-bf0e-3eb647474416","38d407ce-9d5c-4c96-90d5-63e9749dfa44")
```

Sets the Provider VDC filter for the currently connected vCloud Availabilty service to the Provider VDCs with the Ids "2241c7fe-7319-4d89-bf0e-3eb647474416" and "38d407ce-9d5c-4c96-90d5-63e9749dfa44" overwriting any currently configured filters

### EXAMPLE 2
```
Set-vCAVProviderVDCFilters -ProvidedVDCIds "2241c7fe-7319-4d89-bf0e-3eb647474416" -Preserve
```

Adds a new Provider VDC with the Id "2241c7fe-7319-4d89-bf0e-3eb647474416" to the Provider VDC filter for the currently connected vCloud Availabilty service and preserves the currently configured filters.

### EXAMPLE 3
```
Set-vCAVProviderVDCFilters -Reset
```

Removes any Provider VDC filters and makes all Provider VDCs in the currently connected vCloud Availabilty service available.

## PARAMETERS

### -ProvidedVDCIds
{{ Fill ProvidedVDCIds Description }}

```yaml
Type: String[]
Parameter Sets: Set
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Preserve
{{ Fill Preserve Description }}

```yaml
Type: SwitchParameter
Parameter Sets: Set
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Reset
{{ Fill Reset Description }}

```yaml
Type: SwitchParameter
Parameter Sets: Reset
Aliases:

Required: False
Position: Named
Default value: False
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
