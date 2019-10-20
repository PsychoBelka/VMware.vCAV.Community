function Get-vCAVTenantPolicy(){
    <#
    .SYNOPSIS
    Returns the vCloud avilability Tenant Policies that are currently configured for the connected vCloud Availability service.

    .DESCRIPTION
    Returns the vCloud avilability Tenant Policies that are currently configured for the connected vCloud Availability service.

    .PARAMETER Name
    The name of the Tenant Policy

    .PARAMETER Id
    The ID of the Tenant Policy

    .EXAMPLE
    Get-vCAVTenantPolicy
    Returns all vCloud Availability tenant policies configured on the currently connected service.

    .EXAMPLE
    Get-vCAVTenantPolicy -Name "default"
    Returns the vCloud Availability tenant policy with the Id "default" if it exists

    .EXAMPLE
    Get-vCAVTenantPolicy -Id "1"
    Returns the vCloud Availability tenant policy with the Id 1 if it exists

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-03-15
	VERSION: 2.0
    #>
    [CmdletBinding(DefaultParameterSetName="Default")]
    Param(
        [Parameter(Mandatory=$False, ParameterSetName = "ByName")]
            [ValidateNotNullorEmpty()] [String] $Name,
        [Parameter(Mandatory=$False, ParameterSetName = "ById")]
            [ValidateNotNullorEmpty()] [String] $Id
    )
    $URI = $global:DefaultvCAVServer.ServiceURI + "policies"
    $RequestResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
    # Next we need to filter the responses
    if($PSCmdlet.ParameterSetName -eq "ByName"){
        $colvCAVTenantPolicies = $RequestResponse | Where-Object {$_.displayName -eq $Name}
    } elseif($PSCmdlet.ParameterSetName -eq "ById"){
        $colvCAVTenantPolicies =$RequestResponse | Where-Object {$_.id -eq $Id}
    } else {
        $colvCAVTenantPolicies = $RequestResponse
    }
    # For each policy we need to get the Org Policy status for each of the policies
    foreach($objPolicy in $colvCAVTenantPolicies){
        $StatusURI = $global:DefaultvCAVServer.ServiceURI + "policies/$($objPolicy.id)/status"
        $OrgRequestResponse = (Invoke-vCAVAPIRequest -URI $StatusURI -Method Get -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
        $objPolicy | Add-Member Organisations $OrgRequestResponse
    }
    $colvCAVTenantPolicies
}