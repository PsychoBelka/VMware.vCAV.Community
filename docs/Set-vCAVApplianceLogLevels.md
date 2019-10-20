---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Set-vCAVApplianceLogLevels

## SYNOPSIS
Updates the log level setting for a specific logback logger at runtime on the currently connected vCloud Availability Service.

## SYNTAX

```
Set-vCAVApplianceLogLevels [-Logger] <String> [-LogLevel] <String> [<CommonParameters>]
```

## DESCRIPTION
Updates the log level setting for a specific logback logger at runtime on the currently connected vCloud Availability Service without requiring a service restart.
Please Note: Changes to the log levels are not persisted across service restarts or server reboots.

## EXAMPLES

### EXAMPLE 1
```
Set-vCAVApplianceLogLevels -Logger "com.vmware.rest.client.AbstractRestClient" -LogLevel "TRACE"
```

Sets the vCloud Availability REST API Client log level to TRACE.

## PARAMETERS

### -Logger
The Logger Name

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

### -LogLevel
The new log level for the given logger
Valid values are : ALL,TRACE,DEBUG,INFO,WARN,ERROR,OFF

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
AUTHOR: Adrian Begg
LASTEDIT: 2019-07-18
VERSION: 2.0

## RELATED LINKS
