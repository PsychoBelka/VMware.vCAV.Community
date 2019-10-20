---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Invoke-vCAVReplicationOperation

## SYNOPSIS
Invokes the specified vCloud Availability operation against a currently configured VM or vApp Replication on the currently connected vCloud Availability service.

## SYNTAX

### Default (Default)
```
Invoke-vCAVReplicationOperation -ReplicationType <String> [-Async] -ReplicationId <String> [<CommonParameters>]
```

### Failover
```
Invoke-vCAVReplicationOperation -ReplicationType <String> [-Async] -ReplicationId <String> [-Failover]
 [-PowerOn <Boolean>] [-Consolidate <Boolean>] [-UseDefaultNetworking <Boolean>] [-OrgVDCNetwork <String>]
 [<CommonParameters>]
```

### Migrate
```
Invoke-vCAVReplicationOperation -ReplicationType <String> [-Async] -ReplicationId <String> [-Migrate]
 [-PowerOn <Boolean>] [-Consolidate <Boolean>] [-UseDefaultNetworking <Boolean>] [-OrgVDCNetwork <String>]
 [<CommonParameters>]
```

### Test
```
Invoke-vCAVReplicationOperation -ReplicationType <String> [-Async] -ReplicationId <String> [-Test]
 [-PowerOn <Boolean>] [-UseDefaultNetworking <Boolean>] [-OrgVDCNetwork <String>] [-SyncBeforeTest <Boolean>]
 [<CommonParameters>]
```

### TestCleanup
```
Invoke-vCAVReplicationOperation -ReplicationType <String> [-Async] -ReplicationId <String> [-TestCleanup]
 [<CommonParameters>]
```

### Pause
```
Invoke-vCAVReplicationOperation -ReplicationType <String> [-Async] -ReplicationId <String> [-PauseReplication]
 [<CommonParameters>]
```

### Resume
```
Invoke-vCAVReplicationOperation -ReplicationType <String> [-Async] -ReplicationId <String> [-ResumeReplication]
 [<CommonParameters>]
```

### Reverse
```
Invoke-vCAVReplicationOperation -ReplicationType <String> [-Async] -ReplicationId <String>
 [-ReverseReplication] [<CommonParameters>]
```

### Sync
```
Invoke-vCAVReplicationOperation -ReplicationType <String> [-Async] -ReplicationId <String> [-Sync]
 [<CommonParameters>]
```

## DESCRIPTION
Invokes the specified vCloud Availability operation against a currently configured VM or vApp Replication on the currently connected vCloud Availability service.

This cmdlet currently only provides a very basic implementation of vCloud Availability functions and focuses on the vCloud-side Operations only.
Further development is required for full support.

## EXAMPLES

### EXAMPLE 1
```
Invoke-vCAVReplicationOperation -ReplicationType "vApp" -ReplicationId C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d -PauseReplication
```

Pauses the vApp Replication with the vApp Replication Id of "C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d"

### EXAMPLE 2
```
Invoke-vCAVReplicationOperation -ReplicationType VM -ReplicationId C4-1909c491-b445-4ee1-9c09-cff64e1d29ba -PauseReplication
```

Pauses the VM Replication with the VM Replication Id of "C4-1909c491-b445-4ee1-9c09-cff64e1d29ba"

### EXAMPLE 3
```
Invoke-vCAVReplicationOperation -ReplicationType "vApp" -ReplicationId C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d -Sync
```

Performs a manual Sync of the vApp Replication with the vApp Replication Id of "C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d"

### EXAMPLE 4
```
Invoke-vCAVReplicationOperation -ReplicationType VM -ReplicationId C4-1909c491-b445-4ee1-9c09-cff64e1d29ba -Sync
```

Performs a manual Sync of the VM Replication with the VM Replication Id of "C4-1909c491-b445-4ee1-9c09-cff64e1d29ba"

### EXAMPLE 5
```
Invoke-vCAVReplicationOperation -ReplicationType "vApp" -ReplicationId C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d -ResumeReplication -Async
```

Performs a Resume Replication operation on the vApp Replication with the vApp Replication Id of "C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d" and returns the Task; runs asynchronously

### EXAMPLE 6
```
Invoke-vCAVReplicationOperation -ReplicationType VM -ReplicationId C4-1909c491-b445-4ee1-9c09-cff64e1d29ba -ResumeReplication
```

Performs a Resume Replication operation on the VM Replication with the VM Replication Id of "C4-1909c491-b445-4ee1-9c09-cff64e1d29ba"

### EXAMPLE 7
```
Invoke-vCAVReplicationOperation -ReplicationType "vApp" -ReplicationId C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d -TestCleanUp
```

Removes the Test Image created by a "Test Failover" for vApp C4VAPP-e7544cad-dc01-42a2-bd07-7d3f5fc8385d from the recovery destination.

### EXAMPLE 8
```
Invoke-vCAVReplicationOperation -ReplicationType VM -ReplicationId C4-1909c491-b445-4ee1-9c09-cff64e1d29ba -TestCleanUp
```

Removes the Test Image created by a "Test Failover" for VM Replication C4-1909c491-b445-4ee1-9c09-cff64e1d29ba from the recovery destination.

### EXAMPLE 9
```
Invoke-vCAVReplicationOperation -ReplicationType vApp -ReplicationId C4VAPP-9d4b1ae0-1ea8-4777-94c8-32e02d958998 -Test -Async
```

Performs a Test Failover of the vApp with the Replication Id C4VAPP-9d4b1ae0-1ea8-4777-94c8-32e02d958998 using the pre-defined TestFailover networks and settings and returns the Task; runs asynchronously.

### EXAMPLE 10
```
Invoke-vCAVReplicationOperation -ReplicationType VM -ReplicationId C4-1909c491-b445-4ee1-9c09-cff64e1d29ba -Test
```

Performs a Test Failover of the VM Replication with the VM Replication Id of "C4-1909c491-b445-4ee1-9c09-cff64e1d29ba" with the pre-defined TestFailover network

### EXAMPLE 11
```
Invoke-vCAVReplicationOperation -ReplicationType vApp -ReplicationId C4VAPP-9d4b1ae0-1ea8-4777-94c8-32e02d958998 -Test -UseDefaultNetworking $false -OrgVDCNetwork CustomerNetwork1
```

Performs a Test Failover of the vApp with the Replication Id C4VAPP-9d4b1ae0-1ea8-4777-94c8-32e02d958998 and connects the failed over machine to the OrgVDCNetwork CustomerNetwork1.

### EXAMPLE 12
```
Invoke-vCAVReplicationOperation -ReplicationType vApp -ReplicationId C4VAPP-9d4b1ae0-1ea8-4777-94c8-32e02d958998 -Test -UseDefaultNetworking $false -OrgVDCNetwork CustomerNetwork -PowerOn $true -SyncBeforeTest $false
```

Performs a Test Failover of the vApp with the REplication Id C4VAPP-9d4b1ae0-1ea8-4777-94c8-32e02d958998 and connects the failed over machine to the OrgVDCNetwork CustomerNetwork1.
The machines will be Powered On after the Test Failover and a Sync will not be performed before the test.

## PARAMETERS

### -ReplicationType
vApp or VM Replication

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

### -ReplicationId
The vCloud Availability C4 vApp/VM replication ID

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

### -Failover
Peforms a Failover of the selected vApp/VM to the latest recovery instance.
Currently this cmdlet only supports failover to the latest available instance.

```yaml
Type: SwitchParameter
Parameter Sets: Failover
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Migrate
Peforms a Migration of the selected vApp/VM.

```yaml
Type: SwitchParameter
Parameter Sets: Migrate
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Test
Peforms a Test Failover of the selected vApp/VM to the specified recovery instance.
Currently this cmdlet only supports test failover to the latest available instance.

```yaml
Type: SwitchParameter
Parameter Sets: Test
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestCleanup
Removes the Test Image created by a "Test Failover" from the recovery destination.
Currently this cmdlet only supports test failover to the latest available instance.

```yaml
Type: SwitchParameter
Parameter Sets: TestCleanup
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PauseReplication
Pauses the selected replication.
Paused replications will not send data to the destination and may not meet their RPO settings.

```yaml
Type: SwitchParameter
Parameter Sets: Pause
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResumeReplication
Resumes a paused replication.
The resumed replications will start sending data to the destination and may temporarily cause higher network traffic.

```yaml
Type: SwitchParameter
Parameter Sets: Resume
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReverseReplication
Executes reverse for all the vApp's child VM replications.
The VM replications that are being reversed need to be recovered (using failover/planned migration).
The disks of the original source VMs will be used as seeds.
The original source VMs will be removed.
The original source Vapp will be powered off and left behind (with no vms in it eventually).

```yaml
Type: SwitchParameter
Parameter Sets: Reverse
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sync
Executes a manual creation of an instance for the selected replications.
This will reschedule the next automatic instance with regard to the RPO settings.

```yaml
Type: SwitchParameter
Parameter Sets: Sync
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PowerOn
Whether to Power On the vApp/VM after the operation.

```yaml
Type: Boolean
Parameter Sets: Failover, Migrate, Test
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Consolidate
Turning on this option will consolidate all instances into the recovered disk.
This can improve the runtime performance of the recovered VM, but may greatly increase RTO.

```yaml
Type: Boolean
Parameter Sets: Failover, Migrate
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseDefaultNetworking
If true the operation will apply preconfigured network settings; otherwise the OrgVDCNetwork provided will be set.

```yaml
Type: Boolean
Parameter Sets: Failover, Migrate, Test
Aliases:

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -OrgVDCNetwork
The OrgVDCNetwork to connect if UseDefaultNetworking is set as false.
If no OrgVDCNetwork is provided the failover will be performed with the networks disconnected.

```yaml
Type: String
Parameter Sets: Failover, Migrate, Test
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SyncBeforeTest
If set to $true before the Test Failover a new instance of the replication will be created.

```yaml
Type: Boolean
Parameter Sets: Test
Aliases:

Required: False
Position: Named
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
LASTEDIT: 2019-10-19
VERSION: 2.0

## RELATED LINKS
