---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Set-VCAVApplianceRootPassword

## SYNOPSIS
This cmdlet sets the Appliance Root Password for the currently connected vCloud Availability appliance.

## SYNTAX

```
Set-VCAVApplianceRootPassword [-OldPassword] <String> [-NewPassword] <String> [<CommonParameters>]
```

## DESCRIPTION
This cmdlet sets the Appliance Root Password for the the currently connected vCloud Availability appliance.

## EXAMPLES

### EXAMPLE 1
```
Set-VCAVApplianceRootPassword -OldPassword "Password!234" -NewPassword "Password!345"
```

Resets the root password of the connected vCloud Availability appliance from "Password!234" to "Password!345"

## PARAMETERS

### -OldPassword
The current root password for the appliance.

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

### -NewPassword
The new root password for the appliance.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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
VERSION: 3.0

## RELATED LINKS
