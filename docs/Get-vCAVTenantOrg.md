---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Get-vCAVTenantOrg

## SYNOPSIS
Get a list of vCloud Tenant Organisations available to vCloud Availability.

## SYNTAX

```
Get-vCAVTenantOrg [[-OrgName] <String>] [[-SiteName] <String>] [<CommonParameters>]
```

## DESCRIPTION
Get a list of vCloud Tenant Organisations available to vCloud Availability.

## EXAMPLES

### EXAMPLE 1
```
Get-vCAVTenantOrg -SiteName "PigeonNuggets-SiteA"
```

Returns all vOrgs in the  site "PigeonNuggets-SiteA"

### EXAMPLE 2
```
Get-vCAVTenantOrg -SiteName "PigeonNuggets-SiteA" -OrgName "TestOrg"
```

Returns the object for the vOrgs "TestOrg" in the  site "PigeonNuggets-SiteA" if it exists.

## PARAMETERS

### -OrgName
A vCloud Director vOrg Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteName
A vCloud Availability Site Name
Default: Local Site

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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
VERSION: 2.0

## RELATED LINKS
