---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Deploy-vCAVReplicator

## SYNOPSIS
This cmdlet deploys a vCloud Availability Replicator to the currently connected vCenter Server and registers it with the provided vCloud Availabity Replication Manager.

## SYNTAX

```
Deploy-vCAVReplicator [-vSphereLookupService] <String> [-vSphereAPICredentials] <PSCredential>
 [-ReplicationManager] <String> [-ManagerPassword] <SecureString> [[-PKCS12CertificateFile] <String>]
 [[-CertificateFileSecret] <SecureString>] [-OVAImage] <String> [-Cluster] <String> [-VMFolder] <String>
 [-VMName] <String> [[-StorageType] <String>] [-Datastore] <String> [-RootPassword] <SecureString>
 [-vNIC0_PortGroup] <String> [-vNIC0_IP] <String> [-vNIC0_Netmask] <String> [-DefaultGatewayIP] <String>
 [-HostName] <String> [[-SSHEnabled] <Boolean>] [-NTPServers] <String> [-DNSServers] <String>
 [-DNSSearchPath] <String> [[-HostEntries] <String>] [[-vNIC0_StaticRoutes] <String>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet deploys a vCloud Availability Replicator to the currently connected vCenter Server and registers it with the provided vCloud Availabity Replication Manager.
The steps taken are as follows:
- The basic appliance is deployed and configured using the New-vCAVAppliance cmdlet
- The vSphere Lookup Service is registered with the appliance
- If provided, the self-certificate is replaced on the appliance with the one provided
- The Replicator is registered with the local vCloud Availability Replicator

Note: Only IPv4 addressing is available using this command at this time.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -vSphereLookupService
The URI of the vSphere Lookup Service for the vCloud Resource vCenter hosting the VMs the Replicator will replicate

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

### -ReplicationManager
The IP or FQDN of the vCAV Replication Manager to pair the replicator to

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

### -ManagerPassword
Root Password for the vCAV Replication Manager

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

### -PKCS12CertificateFile
Path to the PKCS12 certificate store which contains the certificate to install of the Replicator.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
Position: 6
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
Position: 7
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
Position: 8
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
Position: 9
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
Position: 10
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
Position: 11
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
Position: 12
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
Position: 13
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
Position: 14
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
Position: 15
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
Position: 16
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
Position: 17
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
Position: 18
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
Position: 19
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
Position: 20
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
Position: 21
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
Position: 22
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
Position: 23
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
Position: 24
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
VERSION: 1.0

## RELATED LINKS
