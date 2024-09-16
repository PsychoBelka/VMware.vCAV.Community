function Test-VCAVServiceEnvironment(){
	<#
	.SYNOPSIS
	Performs some basic checks to tests if there is a current connection to a vCloud Availability service and the version.

	.DESCRIPTION
	Performs some basic checks to tests if there is a current connection to a vCloud Availability service and the version.

	.PARAMETER Version
	The version (e.g. 1.5)

	.EXAMPLE
	Test-VCAVServiceEnvironment
	Returns true if the $global:DefaultvCAVServer.IsConnected is set to true

	.EXAMPLE
	Test-VCAVServiceEnvironment -Version 1.5
	Returns true if the $global:DefaultvCAVServer.Version is set to true and the version is 1.5 or higher.

	.EXAMPLE
	Test-VCAVServiceEnvironment -ServiceType "Manager"
	Returns true if the $global:DefaultvCAVServer.ServiceType is Manager

	.NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 3.0
	#>
	Param(
		[Parameter(Mandatory=$False)]
			[ValidateNotNullorEmpty()] [double] $Version,
        [Parameter(Mandatory=$False)]
            [ValidateSet("Cloud","Manager","Replicator","Tunnel")] [String] $ServiceType
	)
	if($PSBoundParameters.ContainsKey("ServiceType")){
		# TO DO: Add check to allow sets (eg. String array) for different service types
		if($global:DefaultvCAVServer.ServiceType -ne $ServiceType){
			throw "The executing cmdlet can not be executed against the vCloud Availability service of type $($global:DefaultvCAVServer.ServiceType)"
		}
    }
	if($PSBoundParameters.ContainsKey("Version")){
		if($global:DefaultvCAVServer.buildVersion -lt $Version){
			throw "The executing cmdlet requires the vCloud Availability environment to be greater then $Version. The version of the connected server is $($global:DefaultvCAVServer.buildVersion)"
			$false
			Break
		}
	}	
	if(!$global:DefaultvCAVServer.IsConnected){
		throw "You are not currently connected to any servers. Please connect first using a Connect-vCAVService cmdlet."
		$false
        Break
	} else {
        $true
    }
}