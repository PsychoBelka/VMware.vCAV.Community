---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Get-vCAVDatastores

## SYNOPSIS
Returns a collection of datastores availabile to the registered vCloud for the currently connected vCloud Availability service.

## SYNTAX

### Default (Default)
```
Get-vCAVDatastores [<CommonParameters>]
```

### ByName
```
Get-vCAVDatastores [-Name <String>] [<CommonParameters>]
```

### ById
```
Get-vCAVDatastores [-Id <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns a collection of datastores availabile to the registered vCloud for the currently connected vCloud Availability service.

## EXAMPLES

### EXAMPLE 1
```
Get-vCAVDatastores
```

Returns all the datastores on the currently connected site.

### EXAMPLE 2
```
Get-vCAVDatastores -Id 51471a0e-2f83-4d3b-bc9b-b86a06598da3
```

Returns the datastore with the Id 51471a0e-2f83-4d3b-bc9b-b86a06598da3 on the currently connected site.

### EXAMPLE 3
```
Get-vCAVDatastores -Name vCloud-NFS-1
```

Returns the datastore with the Name vCloud-NFS-1 on the currently connected site.

## PARAMETERS

### -Name
A filter for the Name of the Datastore

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
A filter for the Id of the Datastore

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
AUTHOR: PsychoBelka (Original Adrian Begg)
LASTEDIT: 2024-09-16
VERSION: 1.0

## RELATED LINKS
