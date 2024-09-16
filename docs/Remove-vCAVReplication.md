---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Remove-vCAVReplication

## SYNOPSIS
Removes a configured VM or vApp-level Replications from the currently connected vCloud Availability service.

## SYNTAX

### vApp (Default)
```
Remove-vCAVReplication [-vApp] -ReplicationId <String> [-Async] [<CommonParameters>]
```

### VM
```
Remove-vCAVReplication [-VM] -ReplicationId <String> [-Async] [<CommonParameters>]
```

## DESCRIPTION
Removes a configured VM or vApp-level Replications from the currently connected vCloud Availability service.

Returns the vCloud Availability Task object for the operation.

## EXAMPLES

### EXAMPLE 1
```
Remove-vCAVReplication -vApp -ReplicationId "C4VAPP-26b6d9eb-61f9-4808-a3b0-32c9089c361b"
```

Removes the Replication Protection for the vApp with the Id C4VAPP-26b6d9eb-61f9-4808-a3b0-32c9089c361b

## PARAMETERS

### -VM
Switch to use to remove a VM Replication

```yaml
Type: SwitchParameter
Parameter Sets: VM
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -vApp
Switch to use to remove a vApp Replication

```yaml
Type: SwitchParameter
Parameter Sets: vApp
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReplicationId
The Id of the Replication object in the vCloud Availability installation

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
AUTHOR: PsychoBelka (Original Adrian Begg)
LASTEDIT: 2024-09-16
VERSION: 2.0

## RELATED LINKS
