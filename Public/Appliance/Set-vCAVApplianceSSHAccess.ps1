function Set-vCAVApplianceSSHAccess(){
    <#
    .SYNOPSIS
    This cmdlet sets enables or disables the SSH Daemon (sshd.service) on the vCloud Availability appliance.

    .DESCRIPTION
    This cmdlet sets enables or disables the SSH Daemon (sshd.service) on the vCloud Availability appliance.

    .PARAMETER SSHDEnabled
    If $True access to the SSH service is allowed, if $False access is disallowed

    .EXAMPLE
    Set-vCAVApplianceSSHAccess -SSHDEnabled $true
    Enables the SSH daemon on the connected vCloud Availability service.

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-09-10
	VERSION: 1.0
    #>
    Param(
		[Parameter(Mandatory=$True, ValueFromPipeline=$True)]
            [ValidateNotNullorEmpty()] [bool] $SSHDEnabled
    )
    if($DefaultvCAVServer.buildVersion -lt "3.5"){
        throw "This cmdlet is only supported on vCloud Availability 3.5+. The current connected version is $($DefaultvCAVServer.buildVersion)"
    } else {
        $URI = $global:DefaultvCAVServer.ServiceURI + "os/sshd"
        # First check if the service is currently enabled
        if($SSHDEnabled -eq ((Get-vCAVApplianceConfiguraion).SSHDaemonEnabled)){
            Write-Warning -Message "The SSH daemon on the connected installation is currently set to $SSHDEnabled. No change has been made."
        } else {
            # Create the object for the Post and make the API call
            $objSSHDSettings = New-Object System.Management.Automation.PSObject
            $objSSHDSettings | Add-Member Note* enable $SSHDEnabled
            $RequestResponse = Invoke-vCAVAPIRequest -URI $URI -Data (ConvertTo-JSON $objSSHDSettings) -Method Post -APIVersion $DefaultvCAVServer.DefaultAPIVersion
            $RequestResponse.JSONData
        }
    }
}