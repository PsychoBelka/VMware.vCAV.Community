function Set-vCAVApplianceHostname(){
    <#
    .SYNOPSIS
    This cmdlet sets the appliance machine hostname for the currently connected vCloud Availability appliance.

    .DESCRIPTION
    This cmdlet sets the appliance machine hostname for the currently connected vCloud Availability appliance.

    .PARAMETER Hostname
    The hostname for the appliance.

    .EXAMPLE
    Set-vCAVApplianceHostname -Hostname "Replication-A"
    Sets the hostname of the connected to "Replication-A"

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 3.0
    #>
    Param(
		[Parameter(Mandatory=$True, ValueFromPipeline=$True)]
            [ValidateNotNullorEmpty()] [String] $Hostname
    )
    $URI = $global:DefaultvCAVServer.ServiceURI + "config/network/hostname"
    $objHostname = New-Object System.Management.Automation.PSObject
    $objHostname | Add-Member Note* hostname $Hostname
    $RequestResponse = (Invoke-vCAVAPIRequest -URI $URI -Data (ConvertTo-JSON $objHostname) -Method Post).JSONData
    $RequestResponse
}