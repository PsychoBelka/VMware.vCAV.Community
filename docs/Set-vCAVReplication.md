---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Set-vCAVReplication

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

### ReplicationSettings (Default)
```
Set-vCAVReplication -ReplicationType <String> -ReplicationId <String> [-Async] [-Owner <String>]
 [-StorageProfileName <String>] [-Description <String>] [-Quiesced <Boolean>] [-MPITSnapshots <Int32>]
 [-RPOMinutes <Int32>] [-SnapshotDistance <Int32>] [<CommonParameters>]
```

### Owner
```
Set-vCAVReplication -ReplicationType <String> -ReplicationId <String> [-Async] [-Chown] [-Owner <String>]
 [-StorageProfileName <String>] [-Quiesced <Boolean>] [-MPITSnapshots <Int32>] [-RPOMinutes <Int32>]
 [-SnapshotDistance <Int32>] [<CommonParameters>]
```

### StorageProfile
```
Set-vCAVReplication -ReplicationType <String> -ReplicationId <String> [-Async] [-Owner <String>]
 [-StorageProfile] [-StorageProfileName <String>] [-Quiesced <Boolean>] [-MPITSnapshots <Int32>]
 [-RPOMinutes <Int32>] [-SnapshotDistance <Int32>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Async
{{ Fill Async Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Chown
{{ Fill Chown Description }}

```yaml
Type: SwitchParameter
Parameter Sets: Owner
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
{{ Fill Description Description }}

```yaml
Type: String
Parameter Sets: ReplicationSettings
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MPITSnapshots
{{ Fill MPITSnapshots Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Owner
{{ Fill Owner Description }}

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

### -Quiesced
{{ Fill Quiesced Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RPOMinutes
{{ Fill RPOMinutes Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReplicationId
{{ Fill ReplicationId Description }}

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

### -ReplicationType
{{ Fill ReplicationType Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: VM, vApp

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SnapshotDistance
{{ Fill SnapshotDistance Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StorageProfile
{{ Fill StorageProfile Description }}

```yaml
Type: SwitchParameter
Parameter Sets: StorageProfile
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StorageProfileName
{{ Fill StorageProfileName Description }}

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

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
