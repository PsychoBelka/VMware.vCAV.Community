# Basic script to build the module and install it in Dev
[string] $BasePath = "D:\Private\VSCode\repos\VMware.vCAV.Community"

# Get a collection of files to add to the manifest
Set-Location $BasePath
$colPrivFunctionFiles = (Get-ChildItem .\Private\ -Recurse)
$colPublicFunctionFiles = (Get-ChildItem .\Public\ -Recurse)
$NestedModules = ($colPrivFunctionFiles | Resolve-Path -Relative | ?{$_.EndsWith(".ps1")}) + ($colPublicFunctionFiles | Resolve-Path -Relative | ?{$_.EndsWith(".ps1")})

# Now get a list of Public Functions to expose to end users
$colPublicFunctions = ($colPublicFunctionFiles | Where-Object {$_.Extension -eq ".ps1"}).BaseName

$manifest = @{
    Path              = "$BasePath\VMware.vCAV.Community.psd1"
    ModuleVersion     = '4.5.0.0'
    Author            = 'PsychoBelka'
    Copyright         = '2024 PsychoBelka (Original module 2019 Adrian Begg). All rights reserved.'
    Description       = 'PowerShell modules to expose REST API functions for VMWare vCloud Availabiliy as PowerShell cmdlets.'
    ProjectUri        = 'https://github.com/PsychoBelka/VMware.vCAV.Community'
    LicenseUri        = 'https://raw.githubusercontent.com/PsychoBelka/VMware.vCAV.Community/master/LICENSE'
    CompatiblePSEditions = "Desktop","Core"
    PowerShellVersion = '5.0'
    NestedModules = @($NestedModules.TrimStart(".\"))
    FunctionsToExport= @(($colPublicFunctions))
    RequiredModules = @("VMware.VimAutomation.Core")
}
New-ModuleManifest @manifest

