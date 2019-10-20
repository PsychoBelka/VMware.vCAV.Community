---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Deploy-vCAVManager

## SYNOPSIS
This cmdlet deploys a vCloud Availability Cloud Manager appliance to the currently connected vCenter Server.
This cmdlet creates the core components for a vCloud Availability Installation.

## SYNTAX

```
Deploy-vCAVManager [-vSphereLookupService] <String> [-vSphereAPICredentials] <PSCredential>
 [-vCloudURI] <String> [-vCloudAPICredentials] <PSCredential> [-LicenceKey] <String> [-SiteName] <String>
 [[-SiteDescription] <String>] [[-PVDCScope] <String[]>] [[-InternalAPIEndpoint] <String>]
 [[-PublicAPIEndpoint] <String>] [[-PKCS12CertificateFile] <String>] [[-CertificateFileSecret] <SecureString>]
 [-OVAImage] <String> [-Cluster] <String> [-VMFolder] <String> [-VMName] <String> [[-StorageType] <String>]
 [-Datastore] <String> [-RootPassword] <SecureString> [-vNIC0_PortGroup] <String> [-vNIC0_IP] <String>
 [-vNIC0_Netmask] <String> [-DefaultGatewayIP] <String> [-HostName] <String> [[-SSHEnabled] <Boolean>]
 [-NTPServers] <String> [-DNSServers] <String> [-DNSSearchPath] <String> [[-HostEntries] <String>]
 [[-vNIC0_StaticRoutes] <String>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet deploys a vCloud Availability Cloud Manager appliance to the currently connected vCenter Server.
This cmdlet creates the core components for a vCloud Availability Installation.
The steps taken are as follows:
- The basic appliance is deployed and configured using the New-vCAVAppliance cmdlet
- The product licence is installed
- The vSphere Lookup Service is registered with the appliance (C4 Manager and the H4 Replication Manager)
- If provided, the self-certificate is replaced on the appliance with the one provided (C4 Cloud Manager)
- A local vCloud Availability Cloud Site is created and the vSphere SSO Credentials for the Cloud Manager is set
- The Site is linked with vCloud Director
- Public API Address endpoints for the Local Site are configured

Note: Only IPv4 addressing is available using this command at this time.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -vSphereLookupService
The URI of the vSphere Lookup Service for the vCloud Resource vCenter hosting the VMs for the local site e.g.
https://mgtvc1.pigeonnuggets.com/lookupservice/sdk

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

### -vSphereAPICredentials
Credentials for the vCloud Resource vCenter.
This account should have vi-admin rights to the vCenter specified in the Lookup Service parameter.

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

### -vCloudURI
The URI of the vCloud Director API endpoint.
e.g.
https://vcd.pigeonnuggets.com/api

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

### -vCloudAPICredentials
Credentials for vCloud Director with System Administrator priviledges to use for vCloud Availability system tasks.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LicenceKey
The Product Key to install.
The product key must be valid for the installation to succeed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteName
The Site Name for the vCloud Availability site.
This must not include spaces.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteDescription
A description for the vCloud Availability Site.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PVDCScope
Optionally the names of the ProviderVDCs that should be enabled for this vCloud Site.
If not specified all PVDCs are enabled.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InternalAPIEndpoint
The private or management address that should be set for the vCloud Availability service.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PublicAPIEndpoint
The public address to be used when accessing the vCloud Availability service.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PKCS12CertificateFile
Path to the PKCS12 certificate store which contains the certificate to install of the C4 Cloud Service.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CertificateFileSecret
Password for the PKCS12CertificateFile if one is provided

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OVAImage
The fully qualified path to the vCloud Availability OVA

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Cluster
The vSphere HA/DRS Cluster the OVA should be deployed to

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VMFolder
The VM Folder (Virtual Machines and Templates folder) the object should be placed

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VMName
The VM Name in vSphere

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StorageType
A switch to specify if the value provided in -Datastore is a DatastoreCluster or Datastore.
Valid: "DatastoreCluster","Datastore"
Default: Datastore

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: Datastore
Accept pipeline input: False
Accept wildcard characters: False
```

### -Datastore
The Datastore or Datastore Cluster to place the VM on

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RootPassword
The Root Password to be set for the vCAV Appliance

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vNIC0_PortGroup
The vSphere dvPort Group for vNIC with Index 0 (Admin/Main Interface)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 20
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vNIC0_IP
The IPv4 address for the vNIC with Index 0 (Admin/Main Interface)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vNIC0_Netmask
The IPv4 subnet mask for the vNIC with Index 0 (Admin/Main Interface) eg.
255.255.255.0 (for 24-bit)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 22
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultGatewayIP
The default gateway IP address that should be set.
NOTE: If -SecondaryNIC is set this is set on the vNIC1 adapater otherwise is set on vNIC0

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 23
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HostName
The hostname for the appliance.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SSHEnabled
Specifies if the SSH daemon should be enabled.
This can be set via the API after deployment also.
Default: $True

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -NTPServers
A comma-seperated list of NTP Servers to configure for the appliance

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 26
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DNSServers
A comma-seperated list of DNS Servers to configure for the appliance

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 27
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DNSSearchPath
The DNS Search Path for the to configure for the appliance

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 28
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HostEntries
{{ Fill HostEntries Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vNIC0_StaticRoutes
{{ Fill vNIC0_StaticRoutes Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
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
LASTEDIT: 2019-09-17
VERSION: 1.0

## RELATED LINKS
