---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Add-vCAVSite

## SYNOPSIS
Creates a new vCloud Availability Site in the connected installation.

## SYNTAX

```
Add-vCAVSite [-SiteName] <String> [[-SiteDescription] <String>] [[-SiteType] <String>] [[-APIURL] <String>]
 [[-RemoteRootPassword] <SecureString>] [<CommonParameters>]
```

## DESCRIPTION
Creates a new vCloud Availability Site in the connected installation.

## EXAMPLES

### EXAMPLE 1
```
Add-vCAVSite -SiteName "Berlin" -SiteDescription "Berlin Site"
```

Adds a local site to the installation named Berlin with the description "Berlin Site".

### EXAMPLE 2
```
Add-vCAVSite -SiteName "Brisbane" -SiteType "Remote" -APIURL "https://brisbane.example.com:8048" -RemoteRootPassword (ConvertTo-SecureString -String "Password!123" -AsPlainText -Force)
```

Adds a new remote site to the installation "Brisbane" using the API endpoint "https://brisbane.example.com:8048" and the Remote Root Password of Password!123

## PARAMETERS

### -SiteName
The Site Name

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

### -SiteDescription
The Site Description

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

### -SiteType
The Site Type (Local or Remote)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: Local
Accept pipeline input: False
Accept wildcard characters: False
```

### -APIURL
Parameter The API URL for the remote vCloud Availability installation

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoteRootPassword
The Root Password for the remote vCloud Availability installation

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
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
AUTHOR: PsychoBelka (Original Adrian Begg)
LASTEDIT: 2024-09-16
VERSION: 3.0

## RELATED LINKS
