---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Install-vCAVCertificate

## SYNOPSIS
Replaces the certificate that is currently installed on the appliance with a custom certificate.

## SYNTAX

```
Install-vCAVCertificate [-Certificate] <String> [-CertificateFileSecret] <SecureString> [[-Force] <Boolean>]
 [<CommonParameters>]
```

## DESCRIPTION
Replaces the certificate that is currently installed on the appliance with a custom certificate.
The old certificate will be backed up and stored on the appliance.
This will restart the service.

## EXAMPLES

### EXAMPLE 1
```
Install-vCAVCertificate -Certificate "D:\Tools\Scripts\vSphere\vCAV\vcav-site-a-pigeonnuggets-com.pfx" -Password ("Password!" | ConvertTo-SecureString)
```

Installs the certificate in PKCS#12 file D:\Tools\Scripts\vSphere\vCAV\vcav-site-a-pigeonnuggets-com.pfx with keystore and private key password of Password!
to the connected vCloud Availability service.

### EXAMPLE 2
```
Install-vCAVCertificate -Certificate "D:\Tools\Scripts\vSphere\vCAV\vcav-site-a-pigeonnuggets-com.pfx" -Password ("Password!" | ConvertTo-SecureString) -Force $true
```

Installs the certificate in PKCS#12 file D:\Tools\Scripts\vSphere\vCAV\vcav-site-a-pigeonnuggets-com.pfx with keystore and private key password of Password!
to the connected vCloud Availability service without prompting for confirmation.

## PARAMETERS

### -Certificate
Full file path to PKCS#12 file which contains one private key and its corresponding certificate.

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

### -CertificateFileSecret
A secure string with the keystore password.
The keystore password and the password for the private key must be the same.

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

### -Force
If set as True, the user will not be warned and the cmdlet will execute without prompting for confirmation

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
LASTEDIT: 2019-09-16
VERSION: 2.0

## RELATED LINKS
