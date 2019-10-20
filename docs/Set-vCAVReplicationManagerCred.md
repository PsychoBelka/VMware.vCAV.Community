---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Set-vCAVReplicationManagerCred

## SYNOPSIS
Configures the SSO Credentials used by the H4 Manager to perform replication operations against the registered vCloud Resource vCenter

## SYNTAX

```
Set-vCAVReplicationManagerCred [[-ManagerURL] <String>] [-SSOCredentials] <PSCredential> [<CommonParameters>]
```

## DESCRIPTION
Configures the SSO Credentials used by the H4 Manager to perform replication operations against the registered vCloud Resource vCenter

## EXAMPLES

### EXAMPLE 1
```
Set-vCAVReplicationManagerCred -SSOCredentials (New-Object System.Management.Automation.PSCredential("administrator@vsphere.local",(ConvertTo-SecureString "Password!123" -AsPlainText -Force)))
```

Sets the Resource vCenter Service Account for the H4 Manager to "administrator@vsphere.local"

## PARAMETERS

### -ManagerURL
The API URI for the H4 Manager Service

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SSOCredentials
A PSCredential object with a user account with administrator rights to the SSO domain set as the vSphere Lookup Service

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
LASTEDIT: 2019-07-31
VERSION: 2.0

## RELATED LINKS
