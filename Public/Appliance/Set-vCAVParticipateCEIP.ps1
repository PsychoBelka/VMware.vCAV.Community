function Set-vCAVParticipateCEIP(){
    <#
    .SYNOPSIS
    Sets the option for participation in the Customer Experience Improvement Program (CEIP) for the connected installation.

    .DESCRIPTION
    Sets the option for participation in the Customer Experience Improvement Program (CEIP) for the connected installation.

    .PARAMETER Disable
    Switch to disable (not participate).

    .PARAMETER Enable
    Sets to enabled and send telemetry data to VMWare.

    .EXAMPLE
    Set-vCAVParticipateCEIP -Disable
    Disables sending telemetry data to VMWare

    .EXAMPLE
    Set-vCAVParticipateCEIP -Enable
    Enables sending telemetry data to VMWare

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 1.0
    #>
    Param(
        [Parameter(Mandatory=$False, ParameterSetName="Disable")]
            [switch]$Disable,
        [Parameter(Mandatory=$False, ParameterSetName="Enable")]
            [switch]$Enable
    )
    # Construct the request payload object
    $objCIEP = New-Object System.Management.Automation.PSObject
    # Now determine what to set the payload object to
    if($PSCmdlet.ParameterSetName -eq "Disable"){
        $objCIEP | Add-Member Note* enabled $false
    } elseif($PSCmdlet.ParameterSetName -eq "Enable"){
        $objCIEP | Add-Member Note* enabled $true
    }
    # The CEIP endpoint for telemetry data transfer - this is always PRODUCTION because we are not sending to VMWare's test environment
    $objCIEP | Add-Member Note* environment "PRODUCTION"
    # Send the request to the API
    $CIEPURI = $global:DefaultvCAVServer.ServiceURI + "config/telemetry"
    (Invoke-vCAVAPIRequest -URI $CIEPURI -Method Post -Data (ConvertTo-JSON $objCIEP)).JSONData
}