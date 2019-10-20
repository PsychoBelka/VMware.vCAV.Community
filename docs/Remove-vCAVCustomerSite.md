---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Remove-vCAVCustomerSite

## SYNOPSIS
Removes a registered On-prem site from the vCloud Availability installation.

## SYNTAX

```
Remove-vCAVCustomerSite [-SiteName] <String> [-Async] [<CommonParameters>]
```

## DESCRIPTION
Removes a registered On-prem site from the vCloud Availability installation.

## EXAMPLES

### EXAMPLE 1
```
Remove-vCAVCustomerSite -SiteName "Pigeon_OnPrem"
```

Removes the vCenter Site with the Site Name "Pigeon_OnPrem" from the current installation.

## PARAMETERS

### -SiteName
The On-Prem site name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Async
Indicates that the command returns immediately without waiting for the task to complete.
In this mode, the output of the cmdlet is a Task object.

```yaml
Type: SwitchParameter
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
AUTHOR: Adrian Begg
LASTEDIT: 2019-07-19
VERSION: 1.0

## RELATED LINKS
