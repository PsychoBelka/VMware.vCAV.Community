---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Register-vCAVReplicator

## SYNOPSIS
Registers a H4 Replicator with the currently connected vCloud Availability H4 Manager Service.

## SYNTAX

```
Register-vCAVReplicator [-SiteName] <String> [[-Description] <String>] [-ReplicatorAPIURI] <String>
 [-ReplicatorPassword] <SecureString> [-vSphereAPICredentials] <PSCredential> [<CommonParameters>]
```

## DESCRIPTION
Registers a H4 Replicator with the currently connected vCloud Availability H4 Manager Service.

## EXAMPLES

### EXAMPLE 1
```
Register-vCAVReplicator -SiteName "Brisbane" -SiteDescription "Test Site" -ReplicatorAPIURI "https://vcav-replicator.pigeonnuggets.com:8043/" -ReplicatorPassword (ConvertTo-SecureString -String "Password!123" -AsPlainText -Force) -vSphereCredentials (Get-Credentials)
```

Registers the H4 Replciator with the API URI https://vcav-replicator.pigeonnuggets.com:8043/ and a root password of Password!123 with the connected H4 Manager on Site "Brisbane".
The replicator will using the SSO User provided at the command prompt during execution.

## PARAMETERS

### -SiteName
The Site Name to register the Replicator against.

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

### -Description
A description for the site.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReplicatorAPIURI
The API URI for the Replicator to be registered

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReplicatorPassword
The root password of the Replicator appliance to be registered

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vSphereAPICredentials
{{ Fill vSphereAPICredentials Description }}

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
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
VERSION: 2.1

## RELATED LINKS
