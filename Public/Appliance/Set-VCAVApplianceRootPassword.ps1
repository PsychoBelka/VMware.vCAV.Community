function Set-VCAVApplianceRootPassword(){
    <#
    .SYNOPSIS
    This cmdlet sets the Appliance Root Password for the currently connected vCloud Availability appliance.

    .DESCRIPTION
    This cmdlet sets the Appliance Root Password for the the currently connected vCloud Availability appliance.

    .PARAMETER OldPassword
    The current root password for the appliance.

    .PARAMETER NewPassword
    The new root password for the appliance.

    .EXAMPLE
    Set-VCAVApplianceRootPassword -OldPassword "Password!234" -NewPassword "Password!345"
    Resets the root password of the connected vCloud Availability appliance from "Password!234" to "Password!345"

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 3.0
    #>
    Param(
		[Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [String] $OldPassword,
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [String] $NewPassword
    )
    # Check if the password is expired first, bypass the check-root-password if expired
    $CheckPassExpiredURI = $global:DefaultvCAVServer.ServiceURI + "appliance/root-password-expired"
    $expired = Invoke-vCAVAPIRequest -URI $CheckPassExpiredURI -Method Get
    if($expired.JSONData.rootPasswordExpired -eq $false){
        # First check if the old password provided is correct
        $CheckPassURI = $global:DefaultvCAVServer.ServiceURI + "config/check-root-password"
        $objOldPassword = New-Object System.Management.Automation.PSObject
        $objOldPassword | Add-Member Note* password $OldPassword
        $oldPasswordCheck = Invoke-vCAVAPIRequest -URI $CheckPassURI -Data (ConvertTo-JSON $objOldPassword) -Method Post
    } elseif($expired.JSONData.rootPasswordExpired -eq $true) {
        $oldPasswordCheck = New-Object System.Management.Automation.PSObject
        $oldPasswordCheck | Add-Member Note* valid $True
    }

    # If the password is valid make the call to set the new root password.
    if($oldPasswordCheck.valid -eq $true){
        $URI = $global:DefaultvCAVServer.ServiceURI + "config/root-password"
        $objRootPassword = New-Object System.Management.Automation.PSObject
        $objRootPassword | Add-Member Note* rootPassword $NewPassword
        $Request = Invoke-vCAVAPIRequest -URI $URI -Data (ConvertTo-JSON $objRootPassword) -Method Post  -Headers @{'Config-Secret' = $OldPassword}
        $Request.JSONData
    } else {
        throw "The provided current root password is incorrect. Please check the password and try again."
    }
}