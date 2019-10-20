---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Set-vCAVApplianceSSHAccess

## SYNOPSIS
This cmdlet sets enables or disables the SSH Daemon (sshd.service) on the vCloud Availability appliance.

## SYNTAX

```
Set-vCAVApplianceSSHAccess [-SSHDEnabled] <Boolean> [<CommonParameters>]
```

## DESCRIPTION
This cmdlet sets enables or disables the SSH Daemon (sshd.service) on the vCloud Availability appliance.

## EXAMPLES

### EXAMPLE 1
```
Set-vCAVApplianceSSHAccess -SSHDEnabled $true
```

Enables the SSH daemon on the connected vCloud Availability service.

## PARAMETERS

### -SSHDEnabled
If $True access to the SSH service is allowed, if $False access is disallowed

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: False
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
AUTHOR: Adrian Begg
LASTEDIT: 2019-09-10
VERSION: 1.0

## RELATED LINKS
