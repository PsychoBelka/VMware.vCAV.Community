---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Set-vCAVApplianceHostname

## SYNOPSIS
This cmdlet sets the appliance machine hostname for the currently connected vCloud Availability appliance.

## SYNTAX

```
Set-vCAVApplianceHostname [-Hostname] <String> [<CommonParameters>]
```

## DESCRIPTION
This cmdlet sets the appliance machine hostname for the currently connected vCloud Availability appliance.

## EXAMPLES

### EXAMPLE 1
```
Set-vCAVApplianceHostname -Hostname "Replication-A"
```

Sets the hostname of the connected to "Replication-A"

## PARAMETERS

### -Hostname
The hostname for the appliance.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
AUTHOR: Adrian Begg
LASTEDIT: 2019-02-12
VERSION: 3.0

## RELATED LINKS
