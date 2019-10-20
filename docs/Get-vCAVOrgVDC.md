---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Get-vCAVOrgVDC

## SYNOPSIS
This cmdlet returns the Org VDCs available to the logged in user in the currently connected vCloud Availability service.

## SYNTAX

### Default (Default)
```
Get-vCAVOrgVDC [-Site <String>] [<CommonParameters>]
```

### ByName
```
Get-vCAVOrgVDC -Name <String> [-Site <String>] [<CommonParameters>]
```

### ById
```
Get-vCAVOrgVDC -Id <String> [-Site <String>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet returns the Org VDCs available to the logged in user in the currently connected vCloud Availability service.

## EXAMPLES

### EXAMPLE 1
```
Get-vCAVOrgVDC -Name "payg-dca-pigeonnuggets"
```

Returns the vCloud Org VDC with the name "payg-dca-pigeonnuggets" if it exists.

### EXAMPLE 2
```
Get-vCAVOrgVDC -Id "49c2a2f1-721f-4b29-88bc-333be435102a"
```

Returns the vCloud Org VDC with the Id "49c2a2f1-721f-4b29-88bc-333be435102a" if it exists.

### EXAMPLE 3
```
Get-vCAVOrgVDC -Id "49c2a2f1-721f-4b29-88bc-333be435102a" -Site "PigeonNuggets-SiteA"
```

Returns the vCloud Org VDC with the Id "49c2a2f1-721f-4b29-88bc-333be435102a" in Site "PigeonNuggets-SiteA" if it exists.

## PARAMETERS

### -Name
A Name of a vCloud Organisational Virtual Datacenter (OrgVDC)

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

### -Id
An Id of vCloud Organisational Virtual Datacenter (OrgVDC)

```yaml
Type: String
Parameter Sets: ById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
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
AUTHOR: Adrian Begg
LASTEDIT: 2019-06-24
VERSION: 1.0

## RELATED LINKS
