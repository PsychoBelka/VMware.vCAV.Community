---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Invoke-vCAVReplicatorRepair

## SYNOPSIS
Invokes a Repair (Cookie Reset) against a H4 Replicator which is regsitered with the  currently connected vCloud Availability H4 Manager Service.

## SYNTAX

```
Invoke-vCAVReplicatorRepair [-Id] <String> [-ReplicatorPassword] <SecureString>
 [-vSphereAPICredentials] <PSCredential> [<CommonParameters>]
```

## DESCRIPTION
Invokes a Repair (Cookie Reset) against a H4 Replicator which is regsitered with the  currently connected vCloud Availability H4 Manager Service.

## EXAMPLES

### EXAMPLE 1
```
Invoke-vCAVReplicatorRepair -Id "0661dbf4-4105-4754-aae5-f7c7674c044f" -ReplicatorPassword (ConvertTo-SecureString -String "Password!123" -AsPlainText -Force) -vSphereCredentials (Get-Credentials)
```

Repairs a replicator with the Id "0661dbf4-4105-4754-aae5-f7c7674c044f" using the Password Password!123 and the vSphere Credentials provided at execution for the Resource vCenter Server.

## PARAMETERS

### -Id
The Replicator Id for the Replicator to be repaired

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

### -ReplicatorPassword
The root password of the Replicator appliance to be repaired

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vSphereAPICredentials
A vSphere SSO account with VI Administrator rights on the Resoruce vCenter.
These credentials will be used for performing the H4 primative calls to the hypervisors for Replication operations.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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
VERSION: 2.0

## RELATED LINKS
