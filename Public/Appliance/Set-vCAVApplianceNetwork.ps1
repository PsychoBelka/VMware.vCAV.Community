function Set-vCAVApplianceNetwork(){
    <#
    .SYNOPSIS
    This cmdlet sets the network properties for the currently connected vCloud Availability appliance.

    .DESCRIPTION
    This cmdlet sets the network properties for the currently connected vCloud Availability appliance.

    Further development is required to expand the usage of this cmdlet. (e.g. To change the Network Adapater configurations)

    .PARAMETER DNS
    Switch to change DNS (Domain Name Server) settings

    .PARAMETER PrimaryDNS
    The IPv4 address of the Primary DNS Server

    .PARAMETER SecondaryDNS
    The IPv4 address of the Secondary DNS Server

    .PARAMETER DNSSearchDomains
    An array of the DNS Search Domains

    .EXAMPLE
    Set-vCAVApplianceNetwork -DNS -PrimaryDNS "192.168.88.10" -SecondaryDNS "192.168.88.11" -DNSSearchDomains ("LABVCAV1","pigeonnuggets.com")
    Sets the primary DNS server to 192.168.88.10 with a secondary DNS server of 192.168.88.11 and the search domains to "pigeonnuggets.com" and the local hostname "LABVCAV1"

    .EXAMPLE
    Set-vCAVApplianceNetwork -DNS -PrimaryDNS "192.168.88.20"
    Sets the primary DNS server to 192.168.88.20 and leaves all other settings as they are currently configured.

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-09-10
	VERSION: 1.0
    #>
    Param(
        [Parameter(Mandatory=$False, ParameterSetName="DNS")]
            [switch]$DNS,
        [Parameter(Mandatory=$False, ParameterSetName="DNS")]
            [ValidateScript({$_ -match [IPAddress]$_ })] [string] $PrimaryDNS,
        [Parameter(Mandatory=$False, ParameterSetName="DNS")]
            [ValidateScript({$_ -match [IPAddress]$_ })] [string] $SecondaryDNS,
        [Parameter(Mandatory=$False, ParameterSetName="DNS")]
            [ValidateNotNullorEmpty()] [string[]] $DNSSearchDomains
    )
    # Get the current network configuration
    $CurrentNetworkConfig = Get-vCAVApplianceNetwork
    if($PSBoundParameters.ContainsKey("DNS")){
        # Set the API endpoints
        $DNSConfigURI = $global:DefaultvCAVServer.ServiceURI + "config/network/dns"
        $DNSSettings = New-Object System.Management.Automation.PSObject
        # Create an object for the payload and then check what parameters have been provided and set them
        if($PSBoundParameters.ContainsKey("PrimaryDNS")){
            $DNSSettings | Add-Member Note* dns1 $PrimaryDNS
        } else {
            if($CurrentNetworkConfig.dnsServers.Count -gt 0){
                $DNSSettings | Add-Member Note* dns1 $CurrentNetworkConfig.dnsServers[0]
            } else {
                # Set an empty value if no DNS servers are set and the parameter has not been provided
                $DNSSettings | Add-Member Note* dns1 ""
            }
        }
        if($PSBoundParameters.ContainsKey("SecondaryDNS")){
            $DNSSettings | Add-Member Note* dns2 $PrimaryDNS
        } else {
            if($CurrentNetworkConfig.dnsServers.Count -gt 1){
                $DNSSettings | Add-Member Note* dns2 $CurrentNetworkConfig.dnsServers[1]
            } else {
                # Set an empty value if no DNS servers are set and the parameter has not been provided
                $DNSSettings | Add-Member Note* dns2 ""
            }
        }
        # Set the DNS Search Domains if provided
        if($PSBoundParameters.ContainsKey("DNSSearchDomains")){
            $DNSSettings | Add-Member Note* dnsSearchDomains $DNSSearchDomains
        } else {
            $DNSSettings | Add-Member Note* dnsSearchDomains $CurrentNetworkConfig.dnsSearchDomains
        }
        # Now make the POST to the API endpoint to set the DNS settings and return the new network settings
        $RequestResponse = (Invoke-vCAVAPIRequest -URI $DNSConfigURI -Data (ConvertTo-JSON $DNSSettings) -Method Post -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
        $RequestResponse
    }
}