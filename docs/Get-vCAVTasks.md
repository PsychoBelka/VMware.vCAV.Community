---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Get-vCAVTasks

## SYNOPSIS
Shows information about tasks within the currently connected vCloud Availability service.

## SYNTAX

### Default (Default)
```
Get-vCAVTasks [-Replications] [-System] [-Site <String>] [-DestinationOrg <String>] [-SourceOrg <String>]
 [-User <String>] [-TaskState <String>] [-OperationId <String>] [-StartTimeAfter <DateTime>]
 [-StartTimeBefore <DateTime>] [<CommonParameters>]
```

### ById
```
Get-vCAVTasks [-Id <String>] [-Replications] [-System] [-Site <String>] [-DestinationOrg <String>]
 [-SourceOrg <String>] [-User <String>] [-TaskState <String>] [-OperationId <String>]
 [-StartTimeAfter <DateTime>] [-StartTimeBefore <DateTime>] [<CommonParameters>]
```

## DESCRIPTION
Shows information about tasks within the currently connected vCloud Availability service.

## EXAMPLES

### EXAMPLE 1
```
Get-vCAVTasks
```

Returns all of the Tasks for the connected vCloud Availability installation.

### EXAMPLE 2
```
Get-vCAVTasks -Id "XXXX-XXXXX-XXXX-XXXX-XXXXX"
```

Get the details of the Task with the Task Id "XXXX-XXXXX-XXXX-XXXX-XXXXX".

### EXAMPLE 3
```
Get-vCAVTasks -System
```

Get all the System Administration Tasks for the connected vCloud Availability Service.

### EXAMPLE 4
```
Get-vCAVTasks -Replications
```

Get all the Replication Tasks for the connected vCloud Availability Service.

### EXAMPLE 5
```
Get-vCAVTasks -StartTimeAfter ((Get-Date).AddDays(-1)) -StartTimeBefore (Get-Date) -TaskState "FAILED"
```

Get all tasks for the last 24 hours that failed  for the connected vCloud Availability Service.

## PARAMETERS

### -Id
A vCloud Availability Task Id

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

### -Replications
If provided filters tasks to only displays Replication Tasks

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

### -System
If provided filters tasks to only displays System Tasks

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

### -Site
Optionally the Site to retrieve the task from.
This could be a local or remote site.

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

### -DestinationOrg
Filter tasks by the Destination vOrg
Note: Case sensitive

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

### -SourceOrg
Filter tasks by the Source vOrg
Note: Case sensitive

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

### -User
Filter for tasks by the username of the user initating the task.
Available only to system admins.

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

### -TaskState
Filter tasks by the State of the Task.
Available values are: "RUNNING","SUCCEEDED","FAILED"

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

### -OperationId
Filter tasks by the vCAV Operation Id.

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

### -StartTimeAfter
If provided filter tasks that have a Start Time greater-than the provided time.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartTimeBefore
If provided filter tasks that have a Start Time less-than the provided time.

```yaml
Type: DateTime
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
AUTHOR: PsychoBelka (Original Adrian Begg)
LASTEDIT: 2024-09-16
VERSION: 4.0

## RELATED LINKS
