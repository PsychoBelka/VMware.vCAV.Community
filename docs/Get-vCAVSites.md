---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Get-vCAVSites

## SYNOPSIS
Returns a collection of configured vCloud Availability Sites in the connected installation.

## SYNTAX

### Default (Default)
```
Get-vCAVSites [<CommonParameters>]
```

### ByType
```
Get-vCAVSites [-SiteName <String>] -SiteType <String> [<CommonParameters>]
```

### ByName
```
Get-vCAVSites -SiteName <String> [<CommonParameters>]
```

## DESCRIPTION
Returns a collection of configured vCloud Availability Sites in the connected installation.

## EXAMPLES

### EXAMPLE 1
```
Get-vCAVSites
```

Returns the currently configured sites.

### EXAMPLE 2
```
Get-vCAVSites -SiteName "PigeonNuggets-SiteA"
```

Returns the vCloud Availability site "PigeonNuggets-SiteA" if it exists in the installation.
If the site does not exist an Exception is thrown.

### EXAMPLE 3
```
Get-vCAVSites -SiteType "Local"
```

Returns the local vCloud Availability site for the currently connected installation.

### EXAMPLE 4
```
Get-vCAVSites -SiteType "Remote"
```

Returns the local vCloud Availability sites configured for the currently connected installation.
If none exist nothing is returned.

## PARAMETERS

### -SiteName
Optionally the Site Name to filter.

```yaml
Type: String
Parameter Sets: ByType
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: ByName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteType
Optionally the Site Type (Local or Remote) to filter results.

```yaml
Type: String
Parameter Sets: ByType
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
AUTHOR: Adrian Begg
LASTEDIT: 2019-05-10
VERSION: 3.0

## RELATED LINKS
