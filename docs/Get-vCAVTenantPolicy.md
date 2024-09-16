---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Get-vCAVTenantPolicy

## SYNOPSIS
Returns the vCloud avilability Tenant Policies that are currently configured for the connected vCloud Availability service.

## SYNTAX

### Default (Default)
```
Get-vCAVTenantPolicy [<CommonParameters>]
```

### ByName
```
Get-vCAVTenantPolicy [-Name <String>] [<CommonParameters>]
```

### ById
```
Get-vCAVTenantPolicy [-Id <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns the vCloud avilability Tenant Policies that are currently configured for the connected vCloud Availability service.

## EXAMPLES

### EXAMPLE 1
```
Get-vCAVTenantPolicy
```

Returns all vCloud Availability tenant policies configured on the currently connected service.

### EXAMPLE 2
```
Get-vCAVTenantPolicy -Name "default"
```

Returns the vCloud Availability tenant policy with the Id "default" if it exists

### EXAMPLE 3
```
Get-vCAVTenantPolicy -Id "1"
```

Returns the vCloud Availability tenant policy with the Id 1 if it exists

## PARAMETERS

### -Name
The name of the Tenant Policy

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
The ID of the Tenant Policy

```yaml
Type: String
Parameter Sets: ById
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
VERSION: 2.0

## RELATED LINKS
