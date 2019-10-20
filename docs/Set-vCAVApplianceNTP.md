---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Set-vCAVApplianceNTP

## SYNOPSIS
This cmdlet sets the NTP Servers for the vCloud Availability appliance.

## SYNTAX

```
Set-vCAVApplianceNTP [-NTPServers] <String[]> [<CommonParameters>]
```

## DESCRIPTION
This cmdlet sets the NTP Servers for the vCloud Availability appliance.

## EXAMPLES

### EXAMPLE 1
```
Set-vCAVApplianceNTP -NTPServers ("192.168.88.10","192.168.88.11")
```

Sets the NTP Servers for the connected installation to "192.168.88.10" and "192.168.88.11"

## PARAMETERS

### -NTPServers
An array of NTP Servers (IP or DNS)

```yaml
Type: String[]
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
LASTEDIT: 2019-09-10
VERSION: 1.0

## RELATED LINKS
