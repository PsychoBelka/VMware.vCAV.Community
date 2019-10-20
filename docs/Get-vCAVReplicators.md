---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Get-vCAVReplicators

## SYNOPSIS
Returns a collection of configured vCloud Availability Replicators.

## SYNTAX

```
Get-vCAVReplicators [[-Id] <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns a collection of configured vCloud Availability Replicators.

## EXAMPLES

### EXAMPLE 1
```
Get-vCAVReplicators
```

Returns the currently configured replicators managed by this device.

### EXAMPLE 2
```
Get-vCAVReplicators -Id "0661dbf4-4105-4754-aae5-f7c7674c044f"
```

Returns the replicator with the Id 0661dbf4-4105-4754-aae5-f7c7674c044f.

## PARAMETERS

### -Id
Optionally the Id of the Replicator

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
LASTEDIT: 2019-05-08
VERSION: 1.0

## RELATED LINKS
