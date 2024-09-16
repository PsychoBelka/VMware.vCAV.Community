---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Remove-vCAVTenantPolicy

## SYNOPSIS
Removes a new vCloud Availability Tenant Policy from the connected vCloud Availability service.

## SYNTAX

### Default (Default)
```
Remove-vCAVTenantPolicy [-Force <Boolean>] [<CommonParameters>]
```

### ByName
```
Remove-vCAVTenantPolicy -Name <String> [-Force <Boolean>] [<CommonParameters>]
```

### ById
```
Remove-vCAVTenantPolicy -Id <String> [-Force <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Removes a new vCloud Availability Tenant Policy from the connected vCloud Availability service.

The policy must not be assigned to any Organisations for the cmdlet to succeed.

## EXAMPLES

### EXAMPLE 1
```
Remove-vCAVTenantPolicy -Name "Test"
```

Removes the vCloud Availability Tenant Policy with the Name "Test" from the currently connected vCloud Availability installation.

### EXAMPLE 2
```
Remove-vCAVTenantPolicy -Id "823f8baa-4543-44ae-9b15-5bb9e531cf412"
```

Removes the vCloud Availability Tenant Policy with the Id "823f8baa-4543-44ae-9b15-5bb9e531cf412" from the currently connected vCloud Availability installation.

### EXAMPLE 3
```
Remove-vCAVTenantPolicy -Id "823f8baa-4543-44ae-9b15-5bb9e531cf412" -Force $true
```

Removes the vCloud Availability Tenant Policy with the Id "823f8baa-4543-44ae-9b15-5bb9e531cf412" from the currently connected vCloud Availability installation.
If there are currently any Organisations assigned to this policy they will be reassigned to the "default" policy for the installation.

## PARAMETERS

### -Name
The Tenant Policy Display Name

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
The Tenant Policy

```yaml
Type: String
Parameter Sets: ById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Force
If $true will forcibly remove the policy.
Any vCloud Organisations assigned to this policy will be assigned the default policy after removal.

```yaml
Type: Boolean
Parameter Sets: (All)
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
VERSION: 2.0

## RELATED LINKS
