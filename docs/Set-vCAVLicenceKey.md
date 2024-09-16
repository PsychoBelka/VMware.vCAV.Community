---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Set-vCAVLicenceKey

## SYNOPSIS
This cmdlet installs a new licence key to the currently connected vCloud Availability service.

## SYNTAX

```
Set-vCAVLicenceKey [-Key] <String> [<CommonParameters>]
```

## DESCRIPTION
This cmdlet installs a new licence key to the currently connected vCloud Availability service.

## EXAMPLES

### EXAMPLE 1
```
Set-vCAVLicenceKey -Key "AAAA-BBBB-CCCCC-EEEEE-FFFFF-11111"
```

Sets the vCloud Availability licence key to "AAAA-BBBB-CCCCC-EEEEE-FFFFF-11111"

## PARAMETERS

### -Key
A valid vCloud Availability licence key.

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
AUTHOR: PsychoBelka (Original Adrian Begg)
LASTEDIT: 2024-09-16
VERSION: 3.0

## RELATED LINKS
