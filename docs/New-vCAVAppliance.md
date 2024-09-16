---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# New-vCAVAppliance

## SYNOPSIS
This cmdlet deploys a vCloud Availability componet to the currently connected vCenter Server and configures the basic networking.

## SYNTAX

### NorthSouthNic
```
New-vCAVAppliance -Component <String> [-OVAImage <String>] [-Cluster <String>] [-VMFolder <String>]
 [-VMName <String>] [-StorageType <String>] -Datastore <String> [-RootPassword <SecureString>]
 [-vNIC0_PortGroup <String>] [-vNIC0_IP <String>] [-vNIC0_Netmask <String>] [-DefaultGatewayIP <String>]
 [-HostName <String>] [-NTPServers <String>] [-DNSServers <String>] [-DNSSearchPath <String>]
 [-SSHEnabled <Boolean>] [-HostEntries <String>] [-vNIC0_StaticRoutes <String>] [-SecondaryNIC]
 -vNIC1_PortGroup <String> -vNIC1_IP <String> -vNIC1_Netmask <String> -vNIC0_BuildGateway <String>
 [-vNIC1_StaticRoutes <String>] [<CommonParameters>]
```

### Default
```
New-vCAVAppliance -Component <String> [-OVAImage <String>] [-Cluster <String>] [-VMFolder <String>]
 [-VMName <String>] [-StorageType <String>] -Datastore <String> [-RootPassword <SecureString>]
 [-vNIC0_PortGroup <String>] [-vNIC0_IP <String>] [-vNIC0_Netmask <String>] [-DefaultGatewayIP <String>]
 [-HostName <String>] [-NTPServers <String>] [-DNSServers <String>] [-DNSSearchPath <String>]
 [-SSHEnabled <Boolean>] [-HostEntries <String>] [-vNIC0_StaticRoutes <String>] [<CommonParameters>]
```

## DESCRIPTION
The cmdlet deploys the vCloud Availability OVA and configures the basic settings for the appliance (regardless of the deployment type).
The steps taken are as follows:
- Set the parameters for the OVA
- Validate the provided vSphere objects
- Deploy the appliance and Power On
- Optionally add an additional northbound adapter (for Tunnel DMZ if required)
- Set the root password (after first boot) and hostname of the appliance
- Configure any static routing or host file entires

Note: Only IPv4 addressing is available using this command at this time.
The vNIC0 IP address must be routable from the machine executing this cmdlet.

## EXAMPLES

### EXAMPLE 1
```
New-vCAVAppliance @ApplianceConfig
```

Deploys a new appliance to the connected vCenter Server by splatting the configuration in the hashtable ApplianceConfig.
Deploys the appliance and configures the base networking.

## PARAMETERS

### -Component
The vCloud Availability component type to deploy.
Valid: "cloud","replicator","tunnel"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
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

Required: False
Position: Named
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

Required: False
Position: Named
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

Required: False
Position: Named
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

Required: False
Position: Named
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
Position: Named
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
Position: Named
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

Required: False
Position: Named
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

Required: False
Position: Named
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

Required: False
Position: Named
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

Required: False
Position: Named
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

Required: False
Position: Named
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

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NTPServers
A comma-seperated list of NTP Servers to configure for the appliance

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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

Required: False
Position: Named
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

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SSHEnabled
Specifies if the SSH daemon should be enabled.
This can be set via the API after deployment also.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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
Position: Named
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
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecondaryNIC
If this parameter is set two vNICs are added to the machine with the default gateway set on vNIC Index 1 (North)

```yaml
Type: SwitchParameter
Parameter Sets: NorthSouthNic
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -vNIC1_PortGroup
The vSphere dvPort Group for vNIC with Index 1 (Public Interface)

```yaml
Type: String
Parameter Sets: NorthSouthNic
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vNIC1_IP
The IPv4 address for the vNIC with Index 1 (Public Interface)

```yaml
Type: String
Parameter Sets: NorthSouthNic
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vNIC1_Netmask
The IPv4 subnet mask for the vNIC with Index 1 (Public Interface) eg.
255.255.255.0 (for 24-bit)

```yaml
Type: String
Parameter Sets: NorthSouthNic
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vNIC0_BuildGateway
IPv4 Routable Gateway for build.
This is the gateway/router for vNIC0 when the -SecondaryNIC switch is set.
It is set so that during build a routable gateway is set to continue to communicate with the machine for configuration.
This address is discarded after first boot.

```yaml
Type: String
Parameter Sets: NorthSouthNic
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vNIC1_StaticRoutes
{{ Fill vNIC1_StaticRoutes Description }}

```yaml
Type: String
Parameter Sets: NorthSouthNic
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
AUTHOR: PsychoBelka (Original Adrian Begg)
LASTEDIT: 2024-09-16
VERSION: 1.0

## RELATED LINKS
