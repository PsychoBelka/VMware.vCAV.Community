---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# New-vCAVSupportBundle

## SYNOPSIS
Generate a new support bundle.
This operation requires administrative permissions and may take a while.

## SYNTAX

```
New-vCAVSupportBundle [[-Download] <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Generate a new support bundle.
This operation requires administrative permissions and may take a while.

## EXAMPLES

### EXAMPLE 1
```
New-vCAVSupportBundle
```

Generates a new vCloud Availability support bundle and returns the details of the support bundle object generated.

### EXAMPLE 2
```
New-vCAVSupportBundle -Download $true
```

Generates a new vCloud Availability support bundle and returns the details of the support bundle object generated and downloads the buddle to the current working directory.

## PARAMETERS

### -Download
If the parameter is set to $true after the support bundle has been generated it will be download to the current working directory

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
LASTEDIT: 2019-02-22
VERSION: 2.0

## RELATED LINKS
