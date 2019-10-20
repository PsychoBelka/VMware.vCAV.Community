---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Get-vCAVOrgVDCNetwork

## SYNOPSIS
This cmdlet returns the Org VDC Networks available to a provided Org VDC.

## SYNTAX

```
Get-vCAVOrgVDCNetwork [-OrgVDCName] <String> [[-NetworkName] <String>] [[-Site] <String>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet returns the Org VDC Networks available to a provided Org VDC.

## EXAMPLES

### EXAMPLE 1
```
Get-vCAVOrgVDCNetwork -OrgVDCName "payg-dca-pigeonnuggets"
```

Returns the vCloud Org VDC Networks assosicated with the OrgVDC "payg-dca-pigeonnuggets" if it exists.

Get-vCAVOrgVDCNetwork -OrgVDCName "payg-dca-pigeonnuggets" -NetworkName "Test"
Returns the vCloud Org VDC Networks named "Test" assosicated with the OrgVDC "payg-dca-pigeonnuggets" if it exists.

## PARAMETERS

### -OrgVDCName
The Name of a vCloud Organisational Virtual Datacenter (OrgVDC)

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

### -NetworkName
{{ Fill NetworkName Description }}

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
{{ Fill Site Description }}

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
AUTHOR: Adrian Begg
LASTEDIT: 2019-06-27
VERSION: 1.0

## RELATED LINKS
