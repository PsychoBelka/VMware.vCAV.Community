function Disconnect-vCAVService(){
    <#
    .SYNOPSIS
    This cmdlet logs off the currently connected vCloud Availability service.

    .DESCRIPTION
    This cmdlet logs off the currently connected vCloud Availability service.

    .EXAMPLE
    Disconnect-vCAVService
    Disconnects the currently configured session in the $global:DefaultvCAVServer global variable.

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 2.0
    #>
    if(!$global:DefaultvCAVServer.IsConnected){
        Write-Warning "You are currently not connected to the vCAV Service. Nothing will be performed."
    } else {
        # Make the call to the API to logoff and remove the session variable from PowerShell
        [string] $SessionsAPIURI = $global:DefaultvCAVServer.ServiceURI + "sessions"
        try {
            $JSONAuthDisconnect = Invoke-vCAVAPIRequest -URI $SessionsAPIURI -Method Delete 
        }
        catch {
            # Don't care if it fails need to fill it with fire anyway and remove the variable
            Write-Warning -Message "Unable to remove the current vCAV session token from the remote server (possibly due to expired token). You will be disconnected anyway."
        }
        Set-Variable -Name "DefaultvCAVServer" -Value $null -Scope Global
    }
}