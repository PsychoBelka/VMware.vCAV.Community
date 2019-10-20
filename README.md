# VMware.vCAV.Community
PowerShell modules to expose functions to manage VMWare vCloud Availability via PowerShell or PowerShell Core 6+. This module is designed for PowerShell administrators to be able to automate life cycling activities for vCloud Availability and perform operational tasks. It can also be used by Service Provider customers to assist in automating tasks.

**Please Note**: This is a community supported module. It is not provided by, affiliated with or supported by VMWare. I am developing functionality as the need arises so there is a lot more work to do and contributions are welcome.

## Project Owner
Adrian Begg (@AdrianBegg)

## Documentation
All of the cmdlets in the module should have well described PowerShell help available. For a list of cmdlets available use the `Get-Command *vCAV*` command after the module has been imported or installed. For detailed help including examples please use `Get-help <cmdlet> -Detailed` (e.g. `Get-help Get-vCAVReplications -Detailed`). If you have any questions about usage please don't hesitate to contact me on Twitter or the VCPP/vExpert/VMWare Code Slack.

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
* PowerShell Core: 6.2.0
* PowerCLI: 11.4.0.14413515
* vCloud Availability: 3.0.1, 3.0.2, 3.0.3, 3.5 (Beta)

## Known Issues
**Cmdlet**: Get-vCAVSupportBundle
**Version**: vCAV 3.5 BETA
**Issue**: When -Download $true is provided in vCAV 3.5 BETA an API Exception is thrown (API Version needs to be "3" does not support API version 4)
**Workaround**: Set API Version to 3 before running the cmdlet   ($DefaultvCAVServer.DefaultAPIVersion = 3)
**Fix**: Expect to be fixed in GA Release

## Current Development backlog:
### General
* Code quality, lots of copy and paste between functions, the module has been written as functions have been required to fulfil immediate needs as they arise; needs a good clean review of everything, lots of opportunities for re-use and simplification
* User Functions (Replication Management) are very under developed and limited at present. Much more work is required on these cmdlets particularly for on-premises Replication Management.
### Invoke-vCAVAPIRequest
* Proxy handling at the moment is horrible due to incompatibility of [System.Net.WebProxy]::GetDefaultProxy() in PowerShell Core which is my main development platform
### Install-vCAVCertificate
* Not using the standard Invoke-vCAVAPIRequest at the moment, should use common API handler

