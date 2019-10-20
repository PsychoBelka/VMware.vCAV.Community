function Set-vCAVApplianceUpdateRepository(){
    <#
    .SYNOPSIS
    This cmdlet sets the update repository configuration of the connected vCloud Availability service.

    .DESCRIPTION
    This cmdlet sets the update repository configuration of the connected vCloud Availability service.

    .EXAMPLE
    Set-vCAVApplianceUpdateRepository -Default
    Resets/sets the Repository Url for the connected vCloud Availability service back to the default value.

    .EXAMPLE
    Set-vCAVApplianceUpdateRepository -CDRom
    Sets the Repository Url for the connected vCloud Availability service to the local CD ROM of the virtual appliance.

    .EXAMPLE
    Set-vCAVApplianceUpdateRepository -Custom -RepositoryUrl "https://localupdate.pigeonnuggets.com/vcav/" -Username "root" -Password "Example!"
    Sets the Repository Url for the connected vCloud Availability service to a local web server https://localupdate.pigeonnuggets.com/vcav/ which contains the update ISO and connects using Basic authentication and the username root and the password Example!

    .EXAMPLE
    Set-vCAVApplianceUpdateRepository -Custom -RepositoryUrl "https://localupdate.pigeonnuggets.com/vcav/"
    Sets the Repository Url for the connected vCloud Availability service to a local web server https://localupdate.pigeonnuggets.com/vcav/ which contains the update ISO. The connection is made without authentication.

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-07-19
	VERSION: 1.0
    #>
    Param(
        [Parameter(Mandatory=$True, ParameterSetName="Default")]
            [switch]$Default,
        [Parameter(Mandatory=$True, ParameterSetName="CDRom")]
            [switch]$CDRom,
        [Parameter(Mandatory=$True, ParameterSetName="Custom")]
            [switch]$Custom,
        [Parameter(Mandatory=$True, ParameterSetName="Custom")]
            [ValidateScript({[system.uri]::IsWellFormedUriString($_,[System.UriKind]::Absolute)})] [string]$RepositoryUrl,
        [Parameter(Mandatory=$False, ParameterSetName="Custom")]
            [string]$Username,
        [Parameter(Mandatory=$False, ParameterSetName="Custom")]
            [SecureString]$Password
    )
    # Set the API endpoint
    $UpdateConfigURI = $global:DefaultvCAVServer.ServiceURI + "update/repository-url"
    # Create the base object for the JSON payload
    $objUpdateRepo = New-Object System.Management.Automation.PSObject

    # Create the JSON Payload for the custom repo
    if($PSCmdlet.ParameterSetName -eq "Custom"){
        if($PSBoundParameters.ContainsKey("Password")){
            $UnsecurePassword = (New-Object PSCredential "Username",$Password).GetNetworkCredential().Password
            $objUpdateRepo | Add-Member Note* password $UnsecurePassword
        }
        $objUpdateRepo | Add-Member Note* repositoryUrl $RepositoryUrl
        if($PSBoundParameters.ContainsKey("Username")){
            $objUpdateRepo | Add-Member Note* username $Username
        } else {
            $objUpdateRepo | Add-Member Note* username $null
        }
    }
    # Create the JSON Payload for the CDROM repo
    if($PSCmdlet.ParameterSetName -eq "CDROM"){
        $objUpdateRepo | Add-Member Note* repositoryUrl "cdrom://"
        $objUpdateRepo | Add-Member Note* username $null
    }
    # Create the JSON Payload for the Default repo
    if($PSCmdlet.ParameterSetName -eq "Default"){
        $objUpdateRepo | Add-Member Note* repositoryUrl ""
        $objUpdateRepo | Add-Member Note* username $null
    }
    $ConfigresponseTask = (Invoke-vCAVAPIRequest -URI $UpdateConfigURI -Data (ConvertTo-JSON $objUpdateRepo) -Method Post -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
    if((Watch-TaskCompleted -Task $ConfigresponseTask -Timeout ((Get-PowerCLIConfiguration -Scope Session).WebOperationTimeoutSeconds))){
        Get-vCAVApplianceUpdateRepository
    }
}