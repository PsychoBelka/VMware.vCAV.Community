---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Set-vCAVApplianceUpdateRepository

## SYNOPSIS
This cmdlet sets the update repository configuration of the connected vCloud Availability service.

## SYNTAX

### Default
```
Set-vCAVApplianceUpdateRepository [-Default] [<CommonParameters>]
```

### CDRom
```
Set-vCAVApplianceUpdateRepository [-CDRom] [<CommonParameters>]
```

### Custom
```
Set-vCAVApplianceUpdateRepository [-Custom] -RepositoryUrl <String> [-Username <String>]
 [-Password <SecureString>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet sets the update repository configuration of the connected vCloud Availability service.

## EXAMPLES

### EXAMPLE 1
```
Set-vCAVApplianceUpdateRepository -Default
```

Resets/sets the Repository Url for the connected vCloud Availability service back to the default value.

### EXAMPLE 2
```
Set-vCAVApplianceUpdateRepository -CDRom
```

Sets the Repository Url for the connected vCloud Availability service to the local CD ROM of the virtual appliance.

### EXAMPLE 3
```
Set-vCAVApplianceUpdateRepository -Custom -RepositoryUrl "https://localupdate.pigeonnuggets.com/vcav/" -Username "root" -Password "Example!"
```

Sets the Repository Url for the connected vCloud Availability service to a local web server https://localupdate.pigeonnuggets.com/vcav/ which contains the update ISO and connects using Basic authentication and the username root and the password Example!

### EXAMPLE 4
```
Set-vCAVApplianceUpdateRepository -Custom -RepositoryUrl "https://localupdate.pigeonnuggets.com/vcav/"
```

Sets the Repository Url for the connected vCloud Availability service to a local web server https://localupdate.pigeonnuggets.com/vcav/ which contains the update ISO.
The connection is made without authentication.

## PARAMETERS

### -Default
{{ Fill Default Description }}

```yaml
Type: SwitchParameter
Parameter Sets: Default
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CDRom
{{ Fill CDRom Description }}

```yaml
Type: SwitchParameter
Parameter Sets: CDRom
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Custom
{{ Fill Custom Description }}

```yaml
Type: SwitchParameter
Parameter Sets: Custom
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -RepositoryUrl
{{ Fill RepositoryUrl Description }}

```yaml
Type: String
Parameter Sets: Custom
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Username
{{ Fill Username Description }}

```yaml
Type: String
Parameter Sets: Custom
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
{{ Fill Password Description }}

```yaml
Type: SecureString
Parameter Sets: Custom
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
AUTHOR: Adrian Begg
LASTEDIT: 2019-07-19
VERSION: 1.0

## RELATED LINKS
