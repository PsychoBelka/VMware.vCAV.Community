---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Set-vCAVSitevCloud

## SYNOPSIS
This cmdlet sets the vCloud Director configuration for the local site of the currently connected vCloud Availability service.

## SYNTAX

```
Set-vCAVSitevCloud [-vCloudAPIURI] <String> [-vcdCredentials] <PSCredential> [<CommonParameters>]
```

## DESCRIPTION
This cmdlet sets the vCloud Director configuration for the local site of the currently connected vCloud Availability service.

## EXAMPLES

### EXAMPLE 1
```
Set-vCAVSitevCloud -vCloudAPIURI "https://vcd.pigeonnuggets.com/api" -vcdCredentials (New-Object System.Management.Automation.PSCredential("administrator@system",(ConvertTo-SecureString "Password!" -AsPlainText -Force)))
```

Sets the vCloud configuration for all vCloud operations in the local site to https://vcd.pigeonnuggets.com/api using the bultin-in administrator account for vCloud and a Password of "Password!123"

## PARAMETERS

### -vCloudAPIURI
The URI for the vCloud API Service

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

### -vcdCredentials
A PSCredential object with a user account with System Administrator access to the System Org in the vCloud Organisation.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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
LASTEDIT: 2019-09-10
VERSION: 3.0

## RELATED LINKS
