---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Get-vCAVStorageProfile

## SYNOPSIS
This cmdlet returns the Storage Profiles available to a provided Org VDCs in the currently connected vCloud Availability service.

## SYNTAX

```
Get-vCAVStorageProfile [-OrgVDCName] <String> [[-StorageProfile] <String>] [[-Site] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
This cmdlet returns the Storage Profiles available to a provided Org VDCs in the currently connected vCloud Availability service.

## EXAMPLES

### EXAMPLE 1
```
Get-vCAVStorageProfile -OrgVDCName "payg-dca-pigeonnuggets"
```

Returns the Storage Profiles assosicated with the vCloud Org VDC with the name "payg-dca-pigeonnuggets".

### EXAMPLE 2
```
Get-vCAVStorageProfile -OrgVDCName "payg-dca-pigeonnuggets" -StorageProfile "Gold"
```

Returns the Storage Profiles named "Gold" assosicated with the vCloud Org VDC with the name "payg-dca-pigeonnuggets" if it exists.

## PARAMETERS

### -OrgVDCName
A Name of a vCloud Organisational Virtual Datacenter (OrgVDC)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -StorageProfile
Optionally the name of the Storage Profile to filter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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
Position: 3
Default value: ((Get-vCAVSites -SiteType "Local").site)
Accept pipeline input: True (ByValue)
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
