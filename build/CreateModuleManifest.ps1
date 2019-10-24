# Basic script to build the module and install it in Dev
#[string] $BasePath = "D:\Github-AdrianBegg\VMware.vCAV.Community"
[string] $BasePath = "C:\Tools\AdrianBegg-Github\VMware.vCAV.Community"
#[string] $LocalModulePath = "C:\Tools\PowerShellCore\Modules"

# Get a collection of files to add to the manifest
Set-Location $BasePath
$colPrivFunctionFiles = (Get-ChildItem .\Private\ -Recurse)
$colPublicFunctionFiles = (Get-ChildItem .\Public\ -Recurse)
$NestedModules = ($colPrivFunctionFiles | Resolve-Path -Relative | ?{$_.EndsWith(".ps1")}) + ($colPublicFunctionFiles | Resolve-Path -Relative | ?{$_.EndsWith(".ps1")})

# Now get a list of Public Functions to expose to end users
$colPublicFunctions = ($colPublicFunctionFiles | Where-Object {$_.Extension -eq ".ps1"}).BaseName

$manifest = @{
    Path              = "$BasePath\VMware.vCAV.Community.psd1"
    ModuleVersion     = '3.5.0.1'
    Author            = 'Adrian Begg'
    Copyright         = '2019 Adrian Begg. All rights reserved.'
    Description       = 'PowerShell modules to expose REST API functions for VMWare vCloud Availabiliy as PowerShell cmdlets.'
    ProjectUri        = 'https://github.com/AdrianBegg/VMware.vCAV.Community'
    LicenseUri        = 'https://raw.githubusercontent.com/AdrianBegg/VMware.vCAV.Community/master/LICENSE'
    CompatiblePSEditions = "Desktop","Core"
    PowerShellVersion = '6.2'
    NestedModules = @($NestedModules.TrimStart(".\"))
    FunctionsToExport= @(($colPublicFunctions))
    RequiredModules = @("VMware.VimAutomation.Core")
}
New-ModuleManifest @manifest

