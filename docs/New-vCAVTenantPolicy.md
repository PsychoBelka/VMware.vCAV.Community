---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# New-vCAVTenantPolicy

## SYNOPSIS
Creates a new vCloud Availability Tenant Policy on the connected vCloud Availability service.

## SYNTAX

```
New-vCAVTenantPolicy [-Name] <String> [[-MinRPOMinutes] <Int32>] [[-MaximumSnapshotsPerVMs] <Int32>]
 [[-MaximumReplicatedVMs] <Int32>] [[-AllowInboundReplication] <Boolean>]
 [[-AllowOutboundReplication] <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Creates a new vCloud Availability Tenant Policy on the connected vCloud Availability service.

## EXAMPLES

### EXAMPLE 1
```
New-vCAVTenantPolicy -name "Test-Automtion" -MinRPOMinutes 90 -MaximumSnapshotsPerVMs 5
```

Creates a new vCloud Availability tenant policy on the currently connected service named "Test-Automation" with a minimum RPO of 90 minutes and a maximum number of 5 MPIT (Multiple-Point-in-Time) recovery points.
The policy will also allow for inbound and outbound replication and have a maximum number of protected VMs of 10 (as per the cmdlet defaults).

### EXAMPLE 2
```
New-vCAVTenantPolicy -name "Gold" -MinRPOMinutes 5 -MaximumSnapshotsPerVMs 24 -MaximumReplicatedVms -1
```

Creates a new vCloud Availability tenant policy on the currently connected service named "Gold" with a minimum RPO of 5 minutes and a maximum number of 24 MPIT (Multiple-Point-in-Time) recovery points and allows the tenant to protect an unlimmited number of VMs/vApps.
The policy will also allow for inbound and outbound replication (as per the cmdlet defaults).

### EXAMPLE 3
```
New-vCAVTenantPolicy -name "Bronze" -MinRPOMinutes 1440 -MaximumSnapshotsPerVMs 5 -MaximumReplicatedVms -1 -AllowOutboundReplication $false
```

Creates a new vCloud Availability tenant policy on the currently connected service named "Bronze" with a minimum RPO of 1440 minutes (24 hours) and a maximum number of 5 MPIT (Multiple-Point-in-Time) recovery points and allows the tenant to protect an unlimmited number of VMs/vApps.
The policy will only allow inbound replication and will deny outbound replicaiton.

## PARAMETERS

### -Name
The display name for the policy

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
Position: 2
Default value: 5
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
Position: 3
Default value: 24
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
Position: 4
Default value: 10
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
Position: 5
Default value: True
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
Position: 6
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
AUTHOR: Adrian Begg
LASTEDIT: 2018-12-24
VERSION: 2.0

## RELATED LINKS
