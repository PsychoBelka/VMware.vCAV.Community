---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Get-vCAVWorkloads

## SYNOPSIS
Returns an inventory of Cloud or On-Premises workloads available in the connected vCloud Availability installation.

## SYNTAX

### vCloud-vApp (Default)
```
Get-vCAVWorkloads [-vCloud] [-vApp] [-SiteName <String>] [-Id <String>] [<CommonParameters>]
```

### vCloud-VM
```
Get-vCAVWorkloads [-vCloud] [-VM] [-SiteName <String>] [-Id <String>] [<CommonParameters>]
```

### vCenter
```
Get-vCAVWorkloads [-vCenter] -SiteName <String> [-Id <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns an inventory of Cloud or On-Premises workloads available in the connected vCloud Availability installation.

Default for vCloud is to return the vApp worklods.
This behaviour can be controlled by using the -VM/-vApp switches

## EXAMPLES

### EXAMPLE 1
```
Get-vCAVWorkloads
```

Returns the vCloud vApp based workloads in the local site.

### EXAMPLE 2
```
Get-vCAVWorkloads -vCloud -VM
```

Returns the vCloud VM based workloads in the local site.

### EXAMPLE 3
```
Get-vCAVWorkloads -vCloud -SiteName "Site-B"
```

Returns the vCloud vApp based workloads in the vCloud Availability site "Site-B".

### EXAMPLE 4
```
Get-vCAVWorkloads -vCenter -SiteName "PigeonNuggets_OnPrem"
```

Returns the vCenter based workloads for all registered vCenters in the customer site "PigeonNuggets_OnPrem"

## PARAMETERS

### -vCloud
Specifies that vCloud based workloads should be returned

```yaml
Type: SwitchParameter
Parameter Sets: vCloud-vApp, vCloud-VM
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -VM
Switch to return VM workloads

```yaml
Type: SwitchParameter
Parameter Sets: vCloud-VM
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -vApp
Switch to return vApp workloads

```yaml
Type: SwitchParameter
Parameter Sets: vCloud-vApp
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -vCenter
Specifies that On-Premises based workloads should be returned

```yaml
Type: SwitchParameter
Parameter Sets: vCenter
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteName
The On-Premises or Cloud Site Name

```yaml
Type: String
Parameter Sets: vCloud-vApp, vCloud-VM
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: vCenter
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
An optional Id of the Workload to filter on

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
AUTHOR: PsychoBelka (Original Adrian Begg)
LASTEDIT: 2024-09-16
VERSION: 1.0

## RELATED LINKS
