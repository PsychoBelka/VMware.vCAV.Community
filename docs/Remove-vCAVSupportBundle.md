---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Remove-vCAVSupportBundle

## SYNOPSIS
Deletes a support bundle from the currently connected vCloud Availability service.

## SYNTAX

```
Remove-vCAVSupportBundle [-BundleId] <String> [<CommonParameters>]
```

## DESCRIPTION
Deletes a support bundle from the currently connected vCloud Availability service.

## EXAMPLES

### EXAMPLE 1
```
Remove-vCAVSupportBundle -BundleId -BundleId "1676f615-aa4b-4c16-ae59-ab8c8ec7f28b"
```

Deletes the support bundle with the Id "1676f615-aa4b-4c16-ae59-ab8c8ec7f28b" from the currently connected vCloud Availability Service if it exists

## PARAMETERS

### -BundleId
The Support Bundle ID to delete

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
AUTHOR: Adrian Begg
LASTEDIT: 2019-03-15
VERSION: 1.0

## RELATED LINKS
