# VMware.vCAV.Community
Forked from https://github.com/AdrianBegg/VMware.vCAV.Community
PowerShell modules to expose functions to manage VMWare vCloud Availability via PowerShell Desktop 5.0+ or PowerShell Core 6+. This module is designed for PowerShell administrators to be able to automate life cycling activities for vCloud Availability and perform operational tasks. It can also be used by Service Provider customers to assist in automating tasks.

**Please Note**: This is a community supported module. It is not provided by, affiliated with or supported by VMWare.

## Project Owner
PsychoBelka (@PsychoBelka)

## Installation/Quick Start
Install VMware.vCAV.Community module from Github:
```
Manually download .zip package
Unpack to desired location:
* C:\Users\<UserName>\Documents\WindowsPowerShell\Modules - For user only (PowerShell Desktop)
* C:\Users\<UserName>\Documents\PowerShell\Modules - For user only (PowerShell Core)
* C:\Program Files\PowerShell\<VersionNumber>\Modules - For all users (PowerShell Core) - not recommended
* C:\Program Files\WindowsPowerShell\Modules - For all users (Both PowerShell Desktop and Core)
Import-Module VMware.vCAV.Community
```
Connect to the vCloud Availability Service using a supported authentication method
```
Connect-vCAVService -Server "vcav.pigeonnnuggets.com" -AuthProvider vCDLogin
```
After that your pretty much ready to roll.

## Documentation
All of the cmdlets in the module should have well described PowerShell help available. For a list of cmdlets available use the `Get-Command *vCAV*` command after the module has been imported or installed. For detailed help including examples please use `Get-help <cmdlet> -Detailed` (e.g. `Get-help Get-vCAVReplications -Detailed`).

## Use Cases (Provider)
* Automate build up vCAV deployments from code
* Automate upgrade activities for vCAV
* Light/zero touch deployment of additional Replicators to installation
* Integration with System Monitoring and Reporting systems
* Optimize Storage Placement

## Use Cases (Customer)
* Monitoring and Reporting of Protection of workloads
* Automating Protection of new vCloud or local workloads
* Integration with orchestration tools to build runbooks for failover or testing

## Tested Versions
* PowerShell Desktop: 5.1.19041.3031
* PowerShell Core: 7.4.3
* PowerCLI: 13.2.1.22851661
* vCloud Availability:  4.4.1, 4.5.0

## Current Development backlog:
### General
* Code quality, lots of copy and paste between functions, the module has been written as functions have been required to fulfil immediate needs as they arise; needs a good clean review of everything, lots of opportunities for re-use and simplification
* User Functions (Replication Management) are very under developed and limited at present. Much more work is required on these cmdlets particularly for on-premises Replication Management.
### Invoke-vCAVAPIRequest
* Proxy handling at the moment is horrible due to incompatibility of [System.Net.WebProxy]::GetDefaultProxy() in PowerShell Core which is my main development platform
### Install-vCAVCertificate
* Not using the standard Invoke-vCAVAPIRequest at the moment, should use common API handler

