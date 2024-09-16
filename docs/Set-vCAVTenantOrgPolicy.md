---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Set-vCAVTenantOrgPolicy

## SYNOPSIS
Assigns a vCloud Availability tenant policy to a vCloud Organisation

## SYNTAX

### ById (Default)
```
Set-vCAVTenantOrgPolicy -OrgName <String> -PolicyId <String> [<CommonParameters>]
```

### ByName
```
Set-vCAVTenantOrgPolicy -OrgName <String> -PolicyName <String> [<CommonParameters>]
```

## DESCRIPTION
Assigns a vCloud Availability tenant policy to a vCloud Organisation

## EXAMPLES

### EXAMPLE 1
```
Set-vCAVTenantOrgPolicy -OrgName "TestOrg" -PolicyId (Get-vCAVTenantPolicy -Name "TestPolicy").id
```

Will assign the vCloud Availability tenent policy with the name "TestPolicy" to the vCloud Organisation "TestOrg"

## PARAMETERS

### -OrgName
The vCloud Director Organisation Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PolicyId
The Policy Id of a vCloud Availability tenant policy

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

### -PolicyName
{{ Fill PolicyName Description }}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
AUTHOR: PsychoBelka (Original Adrian Begg)
LASTEDIT: 2024-09-16
VERSION: 2.0

## RELATED LINKS
