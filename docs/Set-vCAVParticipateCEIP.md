---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Set-vCAVParticipateCEIP

## SYNOPSIS
Sets the option for participation in the Customer Experience Improvement Program (CEIP) for the connected installation.

## SYNTAX

### Disable
```
Set-vCAVParticipateCEIP [-Disable] [<CommonParameters>]
```

### Enable
```
Set-vCAVParticipateCEIP [-Enable] [<CommonParameters>]
```

## DESCRIPTION
Sets the option for participation in the Customer Experience Improvement Program (CEIP) for the connected installation.

## EXAMPLES

### EXAMPLE 1
```
Set-vCAVParticipateCEIP -Disable
```

Disables sending telemetry data to VMWare

### EXAMPLE 2
```
Set-vCAVParticipateCEIP -Enable
```

Enables sending telemetry data to VMWare

## PARAMETERS

### -Disable
Switch to disable (not participate).

```yaml
Type: SwitchParameter
Parameter Sets: Disable
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Enable
Sets to enabled and send telemetry data to VMWare.

```yaml
Type: SwitchParameter
Parameter Sets: Enable
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
LASTEDIT: 2019-07-18
VERSION: 1.0

## RELATED LINKS
