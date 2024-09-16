function Set-vCAVAdminAPIAccess{
    <#<#
    .SYNOPSIS
    Used to set the vCloud Availability setting to allow or restrict admin sessions for enhanced security on the connected vCloud Availability installation.

    When Admin API Access is disabled, the “Do not allow admin sessions from the Internet” option is enabled, other cloud sites won’t be able to run pair or repair operations to this site.

    .DESCRIPTION
    Used to set the vCloud Availability setting to allow or restrict admin sessions for enhanced security on the connected vCloud Availability installation.

    When Admin API Access is disabled, the “Do not allow admin sessions from the Internet” option is enabled, other cloud sites won’t be able to run pair or repair operations to this site.

    This setting restricts external access (connections via the Tunnel appliance) from authenticating with local accounts or @systems accounts.

    .PARAMETER Disable
    If switch is provided Internet-based access to the Administrator APIs will be Disabled

    .PARAMETER Enable
    If switch is provided Internet-based access to the Administrator APIs will be Enabled.

    .PARAMETER RemoteIPRange
    Comma seperated list of IPv4 and IPv6 CIDR ranges that are permitted to use the Administrator APIs over the Internet. (White-list) in the format eg. "0.0.0.0/0,::0/0"
    Default: "0.0.0.0/0,::0/0" (All addresses)

    .EXAMPLE
    Set-vCAVAdminAPIAccess -Disable
    Disables remote access to the Administrator API's for the connected vCloud Availability service

    .EXAMPLE
    Set-vCAVAdminAPIAccess -Enable
    Enables remote access to the Administrator API's for the connected vCloud Availability service to all remote addresses

    .EXAMPLE
    Set-vCAVAdminAPIAccess -Enable -RemoteIPRange "202.124.23.1/32,202.124.24.10/32"
    Enables remote access to the Administrator API's for the connected vCloud Availability service to the public IPv4 addresses 202.124.23.1 and 202.124.24.10

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 1.0
    #>
    [CmdletBinding(DefaultParameterSetName="Default")]
    Param(
        [Parameter(Mandatory=$False, ParameterSetName="Disable")]
            [switch]$Disable,
        [Parameter(Mandatory=$False, ParameterSetName="Enable")]
            [switch]$Enable,
        [Parameter(Mandatory=$False, ParameterSetName="Enable")]
            [ValidateNotNullorEmpty()] [String] $RemoteIPRange = "0.0.0.0/0,::0/0"
    )
    # Construct the request payload object
    $objAdminAccess = New-Object System.Management.Automation.PSObject
    # Now determine what to set the payload object to
    if($PSCmdlet.ParameterSetName -eq "Disable"){
        $objAdminAccess | Add-Member Note* adminAllowFrom ""
    } elseif($PSCmdlet.ParameterSetName -eq "Enable"){
        # TO DO : Validate the input for the IPv4/IPv6 addresses
        $objAdminAccess | Add-Member Note* adminAllowFrom $RemoteIPRange
    }
    # Send the request to the API
    $AdministrativeAllowURI = $global:DefaultvCAVServer.ServiceURI + "config/admin-allow-from"
    $AdministrativeAllowInfo =  (Invoke-vCAVAPIRequest -URI $AdministrativeAllowURI -Method Post -Data (ConvertTo-JSON $objAdminAccess)).JSONData
    # Check that that update has been made and return the result
    $AdministrativeAllowInfo =  (Invoke-vCAVAPIRequest -URI $AdministrativeAllowURI -Method Get).JSONData
    $AdministrativeAllowInfo.adminAllowFrom
}