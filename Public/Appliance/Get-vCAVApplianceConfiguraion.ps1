function Get-vCAVApplianceConfiguraion(){
    <#
    .SYNOPSIS
    This cmdlet returns the current configuration of the connected vCloud Availability service.

    .DESCRIPTION
    This cmdlet returns the current configuration of the connected vCloud Availability service.

    .EXAMPLE
    Get-vCAVApplianceConfiguraion
    Returns the configuration of the connected vCloud Availability.

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 3.0
    #>
    # Check if the appliance is configured first
    $CheckConfiguredURI = $global:DefaultvCAVServer.ServiceURI + "config/is-configured"
    $configure = (Invoke-vCAVAPIRequest -URI $CheckConfiguredURI -Method Get).JSONData
    if($configure.isConfigured -eq $false){
        $false
    } else {
        $ApplianceConfigURI = $global:DefaultvCAVServer.ServiceURI + "config"
        $configuration = (Invoke-vCAVAPIRequest -URI $ApplianceConfigURI -Method Get).JSONData
        # Next try and get the licencing information for the appliance
        try{
            $LicenseConfigURI = $global:DefaultvCAVServer.ServiceURI + "license"
            $licenceInfo =  (Invoke-vCAVAPIRequest -URI $LicenseConfigURI -Method Get).JSONData
            $configuration | Add-Member LicenceKey $licenceInfo.key
            $configuration | Add-Member IsLicensed $licenceInfo.isLicensed
            $configuration | Add-Member LicenceExpiry $licenceInfo.expirationDate
        } catch {
            Write-Warning "An error occured retrieving the Licencing information for the current installation."
        }
        # Next retreive the privledged access settings
        if($DefaultvCAVServer.buildVersion -gt "3.0.1"){
            try{
                $AdministrativeAllowURI = $global:DefaultvCAVServer.ServiceURI + "config/admin-allow-from"
                $AdministrativeAllowInfo =  (Invoke-vCAVAPIRequest -URI $AdministrativeAllowURI -Method Get).JSONData
                $configuration | Add-Member RemotePriviledgedAccessFrom $AdministrativeAllowInfo.adminAllowFrom
            } catch {
                Write-Warning "Unable to retireve the RemotePriviledgedAccessFrom attribute for the current installation."
            }
        }
        # Retreive the NTP Server and if SSH Access is currently enabled if running vCAV 3.5+
        if($DefaultvCAVServer.buildVersion -gt "3.5"){
            try{
                $SSHDURI = $global:DefaultvCAVServer.ServiceURI + "os/sshd"
                $SSHDConfig =  (Invoke-vCAVAPIRequest -URI $SSHDURI -Method Get).JSONData
                $configuration | Add-Member SSHDaemonEnabled $SSHDConfig.enabled
                $configuration | Add-Member SSHDaemonStatus $SSHDConfig.status
            } catch {
                Write-Warning "Unable to retireve the SSH Access Configuration for the current installation."
            }
            try{
                $ntpConfigURI = $global:DefaultvCAVServer.ServiceURI + "os/ntp"
                $ntpConfig =  (Invoke-vCAVAPIRequest -URI $ntpConfigURI -Method Get).JSONData
                $configuration | Add-Member NTPServers $ntpConfig.ntpServers
            } catch {
                Write-Warning "Unable to retireve the SSH Access Configuration for the current installation."
            }
        }
        # Retreive the CEIP Status
        $CustomerImprovementURI = $global:DefaultvCAVServer.ServiceURI + "config/telemetry"
        try{
            $CustomerImprovement =  (Invoke-vCAVAPIRequest -URI $CustomerImprovementURI -Method Get).JSONData
            $configuration | Add-Member CEIPParticipationEnabled $CustomerImprovement.enabled
            $configuration | Add-Member EnvironmentTypeFlag $CustomerImprovement.environment
        } catch {
            Write-Warning "An error occured retireving the Telemetry configuration from the connected appliance."
        }
        $configuration
    }
}