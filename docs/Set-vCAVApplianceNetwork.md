---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Set-vCAVApplianceNetwork

## SYNOPSIS
This cmdlet sets the network properties for the currently connected vCloud Availability appliance.

## SYNTAX

```
Set-vCAVApplianceNetwork [-DNS] [-PrimaryDNS <String>] [-SecondaryDNS <String>] [-DNSSearchDomains <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION
This cmdlet sets the network properties for the currently connected vCloud Availability appliance.

Further development is required to expand the usage of this cmdlet.
(e.g.
To change the Network Adapater configurations)

## EXAMPLES

### EXAMPLE 1
```
Set-vCAVApplianceNetwork -DNS -PrimaryDNS "192.168.88.10" -SecondaryDNS "192.168.88.11" -DNSSearchDomains ("LABVCAV1","pigeonnuggets.com")
```

Sets the primary DNS server to 192.168.88.10 with a secondary DNS server of 192.168.88.11 and the search domains to "pigeonnuggets.com" and the local hostname "LABVCAV1"

### EXAMPLE 2
```
Set-vCAVApplianceNetwork -DNS -PrimaryDNS "192.168.88.20"
```

Sets the primary DNS server to 192.168.88.20 and leaves all other settings as they are currently configured.

## PARAMETERS

### -DNS
Switch to change DNS (Domain Name Server) settings

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrimaryDNS
The IPv4 address of the Primary DNS Server

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

### -SecondaryDNS
The IPv4 address of the Secondary DNS Server

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

### -DNSSearchDomains
An array of the DNS Search Domains

```yaml
Type: String[]
Parameter Sets: (All)
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
