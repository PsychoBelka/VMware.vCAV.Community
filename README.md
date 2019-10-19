# VMware.vCAV.Community
PowerShell modules to expose functions to manage VMWare vCloud Availability via PowerShell or PowerShell Core 6+. This module is designed for PowerShell administrators to be able to automate life cycling activities for vCloud Availability and perform operational tasks. It can also be used by Service Provider customers to assist in automating tasks.

**Please Note**: This is a community supported module. It is not provided by, affiliated with or supported by VMWare. I am developing functionality as the need arises so there is a lot more work to do and contributions are welcome.

## Project Owner
Adrian Begg (@AdrianBegg)

## Documentation
All of the cmdlets in the module should have well described PowerShell help available. For a list of cmdlets available use the `Get-Command *vCAV*` command after the module has been imported or installed. For detailed help including examples please use `Get-help <cmdlet> -Detailed` (e.g. `Get-help Get-vCAVReplications -Detailed`). Please find several examples under the examples folder. If you have any questions about usage please don't hesitate to contact me on Twitter.

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
* PowerCLI:
* vCloud Availability: 3.0.1, 3.0.2, 3.0.3, 3.5 (Beta)
