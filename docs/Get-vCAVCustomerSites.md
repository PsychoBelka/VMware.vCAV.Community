---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Get-vCAVCustomerSites

## SYNOPSIS
Returns a collection of configured On-Premise Customer-side vCloud Availability Sites in the connected installation.

## SYNTAX

```
Get-vCAVCustomerSites [-SiteName <String>] [-Owner <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns a collection of configured On-Premise Customer-side vCloud Availability Sites in the connected installation.

## EXAMPLES

### EXAMPLE 1
```
Get-vCAVCustomerSites
```

Returns the currently configured On-Premise vCloud Sites.

### EXAMPLE 2
```
Get-vCAVCustomerSites -SiteName "PigeonNuggets-SiteA"
```

Returns the currently configured On-Premise vCloud Sites with the name "PigeonNuggets-SiteA" if it exists in the installation.
If the site does not exist an Exception is thrown.

### EXAMPLE 3
```
Get-vCAVCustomerSites -Owner "ExampleOrg"
```

Returns the On-Premise Customer-side vCloud Availability sites configured for the vOrg ExampleOrg.

## PARAMETERS

### -SiteName
Optionally the Site Name to filter.

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

### -Owner
The vCloud vOrg that owns the Site.

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
AUTHOR: PsychoBelka (Original Adrian Begg)
LASTEDIT: 2024-09-16
VERSION: 1.0

## RELATED LINKS
