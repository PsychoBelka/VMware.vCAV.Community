---
external help file:
Module Name: VMware.vCAV.Community
online version:
schema: 2.0.0
---

# Get-vCAVProviderVDCFilters

## SYNOPSIS
Returns a collection of filtered Provider VDCs for the currently connected vCloud Availability Service.

## SYNTAX

```
Get-vCAVProviderVDCFilters
```

## DESCRIPTION
Returns a collection of filtered Provider VDCs for the currently connected vCloud Availability Service.

If no filters are applied the service can access all Provider VDCs which are returned by Get-vCAVProviderVDCs.

## EXAMPLES

### EXAMPLE 1
```
Get-vCAVProviderVDCFilters
```

Returns a collection of the accessible Provider VDCs if a filter is applied.
If nothing is returned all Provider VDCs are accessible.

## PARAMETERS

## INPUTS

## OUTPUTS

## NOTES
AUTHOR: PsychoBelka (Original Adrian Begg)
LASTEDIT: 2024-09-16
VERSION: 1.0

## RELATED LINKS
