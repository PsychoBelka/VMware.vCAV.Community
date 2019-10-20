---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Get-vCAVReplicationNetworkSettings

## SYNOPSIS
Return the Network Settings for a configured VM or vApp-level Replications from the currently connected vCloud Availability service.

## SYNTAX

### vApp (Default)
```
Get-vCAVReplicationNetworkSettings [-vApp] [-vAppName <String>] [-ReplicationId <String>] [<CommonParameters>]
```

### VM
```
Get-vCAVReplicationNetworkSettings [-VM] [-VMName <String>] [-ReplicationId <String>] [<CommonParameters>]
```

## DESCRIPTION
Return the Network Settings for a configured VM or vApp-level Replications from the currently connected vCloud Availability service.

## EXAMPLES

### EXAMPLE 1
```
Get-vCAVReplicationNetworkSettings -ReplicationId C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d
```

Returns the Replication Network Settings for the vApp Replication with the Id C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d

### EXAMPLE 2
```
Get-vCAVReplicationNetworkSettings -VM -VMName "TEST2"
```

Returns the Replication Network Settings for the VM Replication with the VM Name "Test2"

### EXAMPLE 3
```
Get-vCAVReplicationNetworkSettings -vApp -vAppName "Test-2VMs"
```

Returns the Replication Network Settings for the vApp Replication with the vApp Name "Test-2VMs"

## PARAMETERS

### -VM
Switch to indicate the Replication is of type "VM Replication"

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
Switch to indicate the Replication is of type "vApp Replication"

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

### -vAppName
The vApp Name of the Replication to query

```yaml
Type: String
Parameter Sets: vApp
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VMName
The VM Name of the Replication to query

```yaml
Type: String
Parameter Sets: VM
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReplicationId
The vCloud Availability C4 vApp/VM replication IDs

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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
AUTHOR: Adrian Begg
LASTEDIT: 2019-05-27
VERSION: 1.0

## RELATED LINKS
