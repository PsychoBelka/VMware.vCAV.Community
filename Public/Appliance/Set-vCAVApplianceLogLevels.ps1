function Set-vCAVApplianceLogLevels(){
    <#
    .SYNOPSIS
    Updates the log level setting for a specific logback logger at runtime on the currently connected vCloud Availability Service.

    .DESCRIPTION
    Updates the log level setting for a specific logback logger at runtime on the currently connected vCloud Availability Service without requiring a service restart.
    Please Note: Changes to the log levels are not persisted across service restarts or server reboots.

    .PARAMETER Logger
    The Logger Name

    .PARAMETER LogLevel
    The new log level for the given logger
    Valid values are : ALL,TRACE,DEBUG,INFO,WARN,ERROR,OFF

    .EXAMPLE
    Set-vCAVApplianceLogLevels -Logger "com.vmware.rest.client.AbstractRestClient" -LogLevel "TRACE"
    Sets the vCloud Availability REST API Client log level to TRACE.

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-07-18
	VERSION: 2.0
    #>
    Param(
		[Parameter(Mandatory=$True, ValueFromPipeline=$False)]
            [ValidateNotNullorEmpty()] [String] $Logger,
        [Parameter(Mandatory=$True, ValueFromPipeline=$False)]
            [ValidateSet("ALL","TRACE","DEBUG","INFO","WARN","ERROR","OFF")] [String] $LogLevel
    )
    # Create an object with the provided settings
    $objLoggerSetting = New-Object System.Management.Automation.PSObject
    $objLoggerSetting | Add-Member Note* logger $Logger
    $objLoggerSetting | Add-Member Note* level $LogLevel
    # Perform a PUT against the API
    $URI = $global:DefaultvCAVServer.ServiceURI + "diagnostics/loglevels"
    $RequestResponse = (Invoke-vCAVAPIRequest -URI $URI -Data (ConvertTo-JSON $objLoggerSetting) -Method Put -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
    $RequestResponse
}
