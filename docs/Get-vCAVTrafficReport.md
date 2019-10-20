---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Get-vCAVTrafficReport

## SYNOPSIS
Retrieves Traffic Reporting data from vCloud Availability for a provided tenant or Virtual Machine Replication

## SYNTAX

### OrgHistory
```
Get-vCAVTrafficReport -OrgName <String> [-Site <String>] [-Resolution <Int32>] -StartTime <DateTime>
 -EndTime <DateTime> [<CommonParameters>]
```

### VMRealTime
```
Get-vCAVTrafficReport -VMReplicationId <String> [-Site <String>] [-Realtime] [<CommonParameters>]
```

### VMHistory
```
Get-vCAVTrafficReport -VMReplicationId <String> [-Site <String>] [-Resolution <Int32>] -StartTime <DateTime>
 -EndTime <DateTime> [<CommonParameters>]
```

## DESCRIPTION
Retrieves Traffic Reporting data from vCloud Availability for a provided tenant or Virtual Machine Replication.

vCloud Availability Replication Manager collects the traffic information for all replications to cloud sites and to on premises sites and for all replications from cloud sites and from on premises sites and aggregates the traffic information by organization.

The replication data traffic is always collected by the cloud vCloud Availability Replicator instance, regardless of the direction of the replication.
The traffic count includes the replication protocol overhead and TLS overhead and excludes TCP/IP/Ethernet/VPN overhead.
If the stream is compressed, the vCloud Availability Replicator counts the compressed bytes.

Every 300 seconds, the vCloud Availability Replication Manager records to its persistent storage the historical traffic information from all connected vCloud Availability Replicator instances.

## EXAMPLES

### EXAMPLE 1
```
Get-vCAVTrafficReport -VMReplicationId "C4-b01fb143-609d-4d84-9864-f1250b184180" -Realtime
```

Returns the current replication data traffic of the Replication with the replication Id "C4-b01fb143-609d-4d84-9864-f1250b184180"

### EXAMPLE 2
```
Get-vCAVTrafficReport -VMReplicationId "C4-b01fb143-609d-4d84-9864-f1250b184180" -StartTime ((Get-Date).AddDays(-1)) -EndTime (Get-Date)
```

Returns the replication data traffic for the Replication with the replication Id "C4-b01fb143-609d-4d84-9864-f1250b184180" in 5 minute samples for the last 24 hours

### EXAMPLE 3
```
Get-vCAVTrafficReport -VMReplicationId "C4-b01fb143-609d-4d84-9864-f1250b184180" -Resolution 3600 -StartTime ((Get-Date).AddDays(-7)) -EndTime (Get-Date)
```

Returns the replication data traffic for the Replication with the replication Id "C4-b01fb143-609d-4d84-9864-f1250b184180" in hourly minute samples for the last week.

### EXAMPLE 4
```
Get-vCAVTrafficReport -OrgName "PigeonNuggets" -StartTime ((Get-Date).AddDays(-1)) -EndTime (Get-Date)
```

Returns a summary of all replication data traffic for the vOrg PigeonNuggets for the last day in 5 minute samples.

### EXAMPLE 5
```
Get-vCAVTrafficReport -OrgName "PigeonNuggets" -Resolution 3600 -StartTime ((Get-Date).AddDays(-7)) -EndTime (Get-Date)
```

Returns a summary of all replication data traffic for the vOrg PigeonNuggets in hourly minute samples for the last week.

## PARAMETERS

### -OrgName
The vOrg Name of the Organisation for generating a Org Based summary report

```yaml
Type: String
Parameter Sets: OrgHistory
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VMReplicationId
The vCloud Availability C4 VM replication ID for generating a VM Replication report

```yaml
Type: String
Parameter Sets: VMRealTime, VMHistory
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Site
The Site (used for scoping the where the data transfer is reported)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: ((Get-vCAVSites -SiteType "Local").site)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Resolution
The resolution or interval in seconds that the traffic usage data points should be aggegated.
Default: 300 (5 minutes)

```yaml
Type: Int32
Parameter Sets: OrgHistory, VMHistory
Aliases:

Required: False
Position: Named
Default value: 300
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartTime
The Start Time for the Reporting Period

```yaml
Type: DateTime
Parameter Sets: OrgHistory, VMHistory
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndTime
The End Time for the Reporting Period

```yaml
Type: DateTime
Parameter Sets: OrgHistory, VMHistory
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Realtime
If set only the single point-in-time (current) data transfer rate will be returned.

```yaml
Type: SwitchParameter
Parameter Sets: VMRealTime
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
LASTEDIT: 2019-09-18
VERSION: 1.0

## RELATED LINKS
