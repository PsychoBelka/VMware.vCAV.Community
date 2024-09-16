---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Set-vCAVTenantPolicy

## SYNOPSIS
Adjusts the settings for an existing vCloud Availability Tenant Policy on the connected vCloud Availability service.

## SYNTAX

### ById (Default)
```
Set-vCAVTenantPolicy [-Id <String>] [-MinRPOMinutes <Int32>] [-MaximumSnapshotsPerVMs <Int32>]
 [-MaximumReplicatedVMs <Int32>] [-AllowInboundReplication <Boolean>] [-AllowOutboundReplication <Boolean>]
 [<CommonParameters>]
```

### ByName
```
Set-vCAVTenantPolicy [-Name <String>] [-MinRPOMinutes <Int32>] [-MaximumSnapshotsPerVMs <Int32>]
 [-MaximumReplicatedVMs <Int32>] [-AllowInboundReplication <Boolean>] [-AllowOutboundReplication <Boolean>]
 [<CommonParameters>]
```

## DESCRIPTION
Adjusts the settings for an existing vCloud Availability Tenant Policy on the connected vCloud Availability service.

## EXAMPLES

### EXAMPLE 1
```
Set-vCAVTenantPolicy -Id "default" -MinRPOMinutes 20 -MaximumSnapshotsPerVMs 15
```

Sets the minimum MPO for the policy to 20 minutes and the maximum Multiple Point-in-time (MPIT) recovery points to 15 for the default policy.

### EXAMPLE 2
```
Set-vCAVTenantPolicy -Id "e4a4fdf8-c6fc-4f80-a186-1bb4e99ff291" -MaximumReplicatedVMs -1
```

Sets the maximum number of incoming VMs replications for policy with Id "e4a4fdf8-c6fc-4f80-a186-1bb4e99ff291" to unlimited.

### EXAMPLE 3
```
Set-vCAVTenantPolicy -Name "Test Policy" -MaximumSnapshotsPerVMs 1
```

Sets the Maximum number of Multiple Point-in-time (MPIT) recovery points for the policy with the name "Test Policy" to 1.

### EXAMPLE 4
```
Set-vCAVTenantPolicy -Name "Test Policy" -MaximumSnapshotsPerVMs 10 -MaximumReplicatedVMs 6 -AllowOutboundReplication $false
```

Sets the Maximum number of Multiple Point-in-time (MPIT) recovery points for the policy with the name "Test Policy" to 10, the maximum number of replicated VMs to 6 and disables Outbound replication.

## PARAMETERS

### -Name
The Display Name of the policy to amend

```yaml
Type: String
Parameter Sets: ByName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The Policy Id of the policy to amend

```yaml
Type: String
Parameter Sets: ById
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinRPOMinutes
The minimum recovery point objective (RPO) in minutes for the policy.
Default is 5 minutes.
Minimum is 5 minutes.
Maximum is 1440 minutes (24 hours).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumSnapshotsPerVMs
The Maximum number of Multiple Point-in-time (MPIT) recovery points (snapshots) that are allowed to be configured for a protected instance.
Default is 24
Maximum is 24
Minimum is 1

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumReplicatedVMs
The maximum number of VMs that can be protected by the tenant organisation.
Default is 10
For unlimitted set to -1

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowInboundReplication
If $true sets the tenant policy to allow Inbound replication to the local cloud site.
(e.g.
allows replication from on-premise to vCloud or from a remote vCloud deploymnet inbound to the local vCloud site).

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowOutboundReplication
If $true sets the tenant policy to allow Outbound replication from the local cloud site.
(e.g.
allows replication from Cloud site to a remote on-premise vSphere environment or a remote vCloud site).

```yaml
Type: Boolean
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
VERSION: 3.0

## RELATED LINKS
