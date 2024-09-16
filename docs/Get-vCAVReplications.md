---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Get-vCAVReplications

## SYNOPSIS
Query and return a collection of configured VM or vApp-level Replications from the currently connected vCloud Availability service.

## SYNTAX

### vApp (Default)
```
Get-vCAVReplications [-vApp] [-ReplicationId <String>] [-SourceSiteType <String>]
 [-DestinationSiteType <String>] [-SourceSite <String>] [-DestinationSite <String>] [-DestinationOrg <String>]
 [-DestinationOrgVdcId <String>] [-DestinationOrgVdcName <String>] [-SourceOrg <String>]
 [-SourceOrgVdcId <String>] [-SourceOrgVdcName <String>] [-ReplicationOwner <String>] [-IncludeInstances]
 [-OverallHealth <String>] [-vAppId <String>] [-vAppName <String>] [<CommonParameters>]
```

### VM
```
Get-vCAVReplications [-VM] [-ReplicationId <String>] [-SourceSiteType <String>] [-DestinationSiteType <String>]
 [-SourceSite <String>] [-DestinationSite <String>] [-DestinationOrg <String>] [-DestinationOrgVdcId <String>]
 [-DestinationOrgVdcName <String>] [-SourceOrg <String>] [-SourceOrgVdcId <String>]
 [-SourceOrgVdcName <String>] [-ReplicationOwner <String>] [-IncludeInstances] [-OverallHealth <String>]
 [-VMId <String>] [-VMName <String>] [<CommonParameters>]
```

### Summary
```
Get-vCAVReplications [-Summary] [-ReplicationId <String>] [-SourceSiteType <String>]
 [-DestinationSiteType <String>] [-SourceSite <String>] [-DestinationSite <String>] [-DestinationOrg <String>]
 [-DestinationOrgVdcId <String>] [-DestinationOrgVdcName <String>] [-SourceOrg <String>]
 [-SourceOrgVdcId <String>] [-SourceOrgVdcName <String>] [-ReplicationOwner <String>] [-IncludeInstances]
 [-OverallHealth <String>] [<CommonParameters>]
```

## DESCRIPTION
Query and return a collection of configured VM or vApp-level Replications from the currently connected vCloud Availability service.

By default the cmdlet will return the vApp Replications for the currently connected vCloud Availability Service.

## EXAMPLES

### EXAMPLE 1
```
Get-vCAVReplications -VM -ReplicationId "C4-979cf8cc-fcda-4772-907b-6aa1ba929243"
```

Returns the vCloud Availability VM replications with the Replication Id of C4-979cf8cc-fcda-4772-907b-6aa1ba929243

### EXAMPLE 2
```
Get-vCAVReplications -vApp -ReplicationId "C4VAPP-b1d604d4-e2fb-411a-9c6e-47cb81f8741c"
```

Returns the vCloud Availability vApp replications with the Replication Id of C4VAPP-b1d604d4-e2fb-411a-9c6e-47cb81f8741c

### EXAMPLE 3
```
Get-vCAVReplications -VM
```

Returns all vApp Replications from the local vCloud Availability Service

### EXAMPLE 4
```
Get-vCAVReplications -vApp
```

Returns all vApp Replications from the local vCloud Availability Service

### EXAMPLE 5
```
Get-vCAVReplications -vApp -SourceSite "Pigeon-Nuggets-Site-A" -DestinationSite "Pigeon-Nuggets-Site-B"
```

Returns all vApp Replications between source site "Pigeon-Nuggets-Site-A"  and destination site "Pigeon-Nuggets-Site-B".
Please note this requires the local session to be extended to the remote site to succeed.

### EXAMPLE 6
```
Get-vCAVReplications -VM -VMName "VM%"
```

Returns all VM Replications with the VM name starts with VM

### EXAMPLE 7
```
Get-vCAVReplication -Summary
```

Returns a summary of vCAV Replications (Dashboard View).

## PARAMETERS

### -VM
Switch to query Replications by VM

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
Switch to query Replications by vApp

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

### -Summary
{{ Fill Summary Description }}

```yaml
Type: SwitchParameter
Parameter Sets: Summary
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReplicationId
The vCloud Availability C4 vApp/VM replication IDs
If present, the returned Replications with the matching Id's will be returned.
Comma-separated C4 vApp replication IDs are expected.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -SourceSiteType
The source site type.
The allowed allows are vcloud or vcenter.
Default: vcloud

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Vcloud
Accept pipeline input: False
Accept wildcard characters: False
```

### -DestinationSiteType
The destination site type.
The allowed allows are vcloud or vcenter.

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

### -SourceSite
The Name of the Source vCloud Availability Site Name to filter Replications

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

### -DestinationSite
The Name of the Destination vCloud Availability Site Name to filter Replications

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
The Name of the Destination vCloud Director Organisation to filter Replications

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

### -DestinationOrgVdcId
The Id of the destination vCloud Director Org VDC to filter Replications

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

### -DestinationOrgVdcName
The Name of the destination vCloud Director Org VDC to filter Replications

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
The Name of the Source vCloud Director Organisation to filter Replications

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

### -SourceOrgVdcId
The Id of the source vCloud Director Org VDC to filter Replications

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

### -SourceOrgVdcName
The Name of the source vCloud Director Org VDC to filter Replications

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

### -ReplicationOwner
The User Id of the Replication Owner in \<user\>@\<org\> format.
If present, returned replications will be filtered by replication owner.
Filtering option available only to vCloud Availability administrators.

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

### -IncludeInstances
{{ Fill IncludeInstances Description }}

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

### -OverallHealth
{{ Fill OverallHealth Description }}

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

### -vAppId
The Source vApp Id

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

### -vAppName
The vCloud Director vApp Name

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

### -VMId
The Source VM Id

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

### -VMName
The vCloud Director VM Name

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
AUTHOR: PsychoBelka (Original Adrian Begg)
LASTEDIT: 2024-09-16
VERSION: 2.1

## RELATED LINKS
