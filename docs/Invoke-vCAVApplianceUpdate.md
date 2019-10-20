---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Invoke-vCAVApplianceUpdate

## SYNOPSIS
Update the connected vCloud Availability service with any updates available in the currently configured Update Repository.

## SYNTAX

### Update (Default)
```
Invoke-vCAVApplianceUpdate [-AcceptEULA <Boolean>] [<CommonParameters>]
```

### Check
```
Invoke-vCAVApplianceUpdate [-CheckOnly] [<CommonParameters>]
```

## DESCRIPTION
Update the connected vCloud Availability service with any updates available in the currently configured Update Repository.

## EXAMPLES

### EXAMPLE 1
```
Invoke-vCAVApplianceUpdate -CheckOnly
```

Only checks if an update is available and returns the version if one is available.
Does not install the update.

### EXAMPLE 2
```
Invoke-vCAVApplianceUpdate
```

Installs any available updates from the Update Repo.

### EXAMPLE 3
```
Invoke-vCAVApplianceUpdate -AcceptEULA $true
```

Installs any available updates from the Update Repo accepting the EULA and not prompting during installation.

## PARAMETERS

### -CheckOnly
If switch is provided will only check if an update is available

```yaml
Type: SwitchParameter
Parameter Sets: Check
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AcceptEULA
If True will install the update without displaying/prompting for acceptance of the End User Licence Agreeement

```yaml
Type: Boolean
Parameter Sets: Update
Aliases:

Required: False
Position: Named
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
LASTEDIT: 2019-04-23
VERSION: 1.0

## RELATED LINKS
