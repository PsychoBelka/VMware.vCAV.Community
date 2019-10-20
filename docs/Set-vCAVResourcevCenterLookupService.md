---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Set-vCAVResourcevCenterLookupService

## SYNOPSIS
This cmdlet sets the vCenter Lookup Service to use for the currently connected vCloud Availability service.

## SYNTAX

```
Set-vCAVResourcevCenterLookupService [-LookupServiceURI] <String> [<CommonParameters>]
```

## DESCRIPTION
This cmdlet sets the vCenter Lookup Service to use for the currently connected vCloud Availability service.

## EXAMPLES

### EXAMPLE 1
```
Set-vCAVResourcevCenterLookupService -LookupServiceURI "https://labvc1.pigeonnuggets.com/lookupservice/sdk"
```

Sets the Resource vCenter Lookup Service for the currently connected vCloud Availability service to "https://labvc1.pigeonnuggets.com/lookupservice/sdk"

## PARAMETERS

### -LookupServiceURI
The URI for the vCenter Lookup Service API Service for the PSC for the Resource vCenter.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
AUTHOR: Adrian Begg
LASTEDIT: 2019-02-13
VERSION: 3.0

## RELATED LINKS
