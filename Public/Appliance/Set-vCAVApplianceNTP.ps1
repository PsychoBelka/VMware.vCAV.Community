function Set-vCAVApplianceNTP(){
    <#
    .SYNOPSIS
    This cmdlet sets the NTP Servers for the vCloud Availability appliance.

    .DESCRIPTION
    This cmdlet sets the NTP Servers for the vCloud Availability appliance.

    .PARAMETER NTPServers
    An array of NTP Servers (IP or DNS)

    .EXAMPLE
    Set-vCAVApplianceNTP -NTPServers ("192.168.88.10","192.168.88.11")
    Sets the NTP Servers for the connected installation to "192.168.88.10" and "192.168.88.11"

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-09-10
	VERSION: 1.0
    #>
    Param(
		[Parameter(Mandatory=$True, ValueFromPipeline=$True)]
            [ValidateNotNullorEmpty()] [string[]] $NTPServers
    )
    if($DefaultvCAVServer.buildVersion -lt "3.5"){
        throw "This cmdlet is only supported on vCloud Availability 3.5+. The current connected version is $($DefaultvCAVServer.buildVersion)"
    } else {
        $URI = $global:DefaultvCAVServer.ServiceURI + "os/ntp"
        # Create the object for the Post and make the API call
        $objNTPSettings = New-Object System.Management.Automation.PSObject
        $objNTPSettings | Add-Member Note* ntpServers $NTPServers
        $RequestResponse = Invoke-vCAVAPIRequest -URI $URI -Data (ConvertTo-JSON $objNTPSettings) -Method Post -APIVersion $DefaultvCAVServer.DefaultAPIVersion
        $RequestResponse.JSONData
    }
}