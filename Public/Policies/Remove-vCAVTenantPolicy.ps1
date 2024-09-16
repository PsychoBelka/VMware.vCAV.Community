function Remove-vCAVTenantPolicy(){
    <#
    .SYNOPSIS
    Removes a new vCloud Availability Tenant Policy from the connected vCloud Availability service.

    .DESCRIPTION
    Removes a new vCloud Availability Tenant Policy from the connected vCloud Availability service.

    The policy must not be assigned to any Organisations for the cmdlet to succeed.

    .PARAMETER Name
    The Tenant Policy Display Name

    .PARAMETER Id
    The Tenant Policy

    .PARAMETER Force
    If $true will forcibly remove the policy. Any vCloud Organisations assigned to this policy will be assigned the default policy after removal.

    .EXAMPLE
    Remove-vCAVTenantPolicy -Name "Test"
    Removes the vCloud Availability Tenant Policy with the Name "Test" from the currently connected vCloud Availability installation.

    .EXAMPLE
    Remove-vCAVTenantPolicy -Id "823f8baa-4543-44ae-9b15-5bb9e531cf412"
    Removes the vCloud Availability Tenant Policy with the Id "823f8baa-4543-44ae-9b15-5bb9e531cf412" from the currently connected vCloud Availability installation.

    .EXAMPLE
    Remove-vCAVTenantPolicy -Id "823f8baa-4543-44ae-9b15-5bb9e531cf412" -Force $true
    Removes the vCloud Availability Tenant Policy with the Id "823f8baa-4543-44ae-9b15-5bb9e531cf412" from the currently connected vCloud Availability installation.
    If there are currently any Organisations assigned to this policy they will be reassigned to the "default" policy for the installation.

    .NOTES
    AUTHOR: PsychoBelka (Original Adrian Begg)
	LASTEDIT: 2024-09-16
	VERSION: 2.0
    #>
    [CmdletBinding(DefaultParameterSetName="Default")]
    Param(
        [Parameter(Mandatory=$True, ParameterSetName = "ByName")]
            [ValidateNotNullorEmpty()] [String] $Name,
        [Parameter(Mandatory=$True, ParameterSetName = "ById", ValueFromPipeline=$True)]
            [ValidateNotNullorEmpty()] [String] $Id,
        [Parameter(Mandatory=$False)]
            [bool]$Force = $false
    )
    # First test if the policy exists and that the provided input was not the default
    if(($Name -eq "default") -or ($Id -eq "default")){
        throw "The default policy can not be removed. Please use Set-vCAVTenantPolicy to adjust the policy or assign Organisations to another policy using the Set-vCAVTenantOrgPolicy cmdlet."
    }
    if($PSCmdlet.ParameterSetName -eq "ByName"){
        $objPolicy = Get-vCAVTenantPolicy -Name $Name
    }
    if($PSCmdlet.ParameterSetName -eq "ById"){
        $objPolicy = Get-vCAVTenantPolicy -Id $Id
    }
    if($null -eq $objPolicy){
        throw "A Policy with the provided Name or Id is not currently configured. Please check the values provided and try again."
    }
    # Next check if the policy is currently assigned to any Organisations
    if($objPolicy.orgs -ne 0){
        if($Force){
            ## Assign each Org to the default Org Policy
            foreach($objOrg in $objPolicy.Organisations){
                Set-vCAVTenantOrgPolicy -OrgName $objorg.org -PolicyId "default" > $null
            }
        } else {
            throw "There are currently $($objPolicy.orgs) vCloud Organisations assigned to the vCloud Availability Tenant policy (Id:$($objPolicy.id) Name:$($objPolicy.displayName)). Please assign the vCloud Organisations to another policy before continuing using the Set-vCAVTenantOrgPolicy cmdlet."
        }
    }
    # If all tests have passed perform the DELETE against the policy
    $URI = $global:DefaultvCAVServer.ServiceURI + "policies/" + $objPolicy.Id
    $RequestResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Delete ).JSONData
    $RequestResponse
}