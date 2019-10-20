function Set-vCAVTenantOrgPolicy(){
    <#
    .SYNOPSIS
    Assigns a vCloud Availability tenant policy to a vCloud Organisation

    .DESCRIPTION
    Assigns a vCloud Availability tenant policy to a vCloud Organisation

    .PARAMETER OrgName
    The vCloud Director Organisation Name

    .PARAMETER PolicyId
    The Policy Id of a vCloud Availability tenant policy

    .EXAMPLE
    Set-vCAVTenantOrgPolicy -OrgName "TestOrg" -PolicyId (Get-vCAVTenantPolicy -Name "TestPolicy").id
    Will assign the vCloud Availability tenent policy with the name "TestPolicy" to the vCloud Organisation "TestOrg"

    .NOTES
    AUTHOR: Adrian Begg
	LASTEDIT: 2019-03-15
	VERSION: 2.0
    #>
    [CmdletBinding(DefaultParameterSetName="ById")]
    Param(
        [Parameter(Mandatory=$True)]
            [ValidateNotNullorEmpty()] [String] $OrgName,
        [Parameter(Mandatory=$True, ParameterSetName = "ById")]
            [ValidateNotNullorEmpty()] [String] $PolicyId,
        [Parameter(Mandatory=$True, ParameterSetName = "ByName")]
            [ValidateNotNullorEmpty()] [String] $PolicyName
    )
    # First test if the policy exists
    if($PSCmdlet.ParameterSetName -eq "ByName"){
        $objPolicy = Get-vCAVTenantPolicy -Name $PolicyName
    }
    if($PSCmdlet.ParameterSetName -eq "ById"){
        $objPolicy = Get-vCAVTenantPolicy -Id $PolicyId
    }
    if($null -eq $objPolicy){
        throw "A Policy with the provided Name or Id is not currently configured. Please check the values provided and try again."
    }
    # Create the URI to the policy and perform a Patch
    $URI = $global:DefaultvCAVServer.ServiceURI + "policies/$(($objPolicy).id)/orgs/$OrgName"
    $RequestResponse = (Invoke-vCAVAPIRequest -URI $URI -Method Patch -APIVersion $DefaultvCAVServer.DefaultAPIVersion).JSONData
    $RequestResponse
}