---
layout: default
parent: Optimization engine
title: Reference
nav_order: 80
description: 'Reference to the optimization engine tables, runbooks, schedules and variables.'
permalink: /optimization-engine/reference
---

<span class="fs-9 d-block mb-4">Reference</span>
Reference to the optimization engine tables, runbooks, schedules and variables.
{: .fs-6 .fw-300 }

<details open markdown="1">
   <summary class="fs-2 text-uppercase">On this page</summary>

- [🧿 Runbooks](#-runbooks)
- [⏰ Schedules](#-schedules)
- [🦹 Variables](#-variables)
- [🚥 Log Analytics tables](#-log-analytics-tables)
- [🚥 SQL Database tables](#-sql-database-tables)

</details>

---

## 🧿 Runbooks

| Runbook                                     | Description                      | Upstream dependencies            | Downstream dependencies          |
| ------------------------------------------- | -------------------------------- | -------------------------------- | -------------------------------- |
| `CleanUp-OlderRecommendationsFromSqlServer`       | Deletes older recommendations from the SQL Database (defaults to 365 days) | `AzureOptimization_RecommendationsMaxAgeInDays` variable and `AzureOptimization_CleanUpRecommendationsWeekly` schedule | |
| `Export-AADObjectsToBlobStorage`       | Exports Entra ID objects as CSV to Blob Storage | `AzureOptimization_ExportAADObjectsDaily` schedule and `Global Reader` role in Entra ID tenant | `Identities and Roles` workbook and `Recommend-AADExpiringCredentialsToBlobStorage` runbook |
| `Export-AdvisorRecommendationsToBlobStorage`       | Exports all Advisor recommendations as CSV to Blob Storage | `AzureOptimization_ExportAdvisorWeekly` schedule and `Reader` role in subscription(s) | `Recommend-AdvisorAsIsToBlobStorage` and `Recommend-AdvisorCostAugmentedToBlobStorage` runbooks |
| `Export-ARGAppGatewayPropertiesToBlobStorage`       | Exports Application Gateway properties as CSV to Blob Storage | `AzureOptimization_ExportARGDaily` schedule and `Reader` role in subscription(s) | `Recommend-UnusedAppGWsToBlobStorage` runbook and `Resources Inventory` workbook |
| `Export-ARGAppServicePlanPropertiesToBlobStorage`       | Exports App Service Plan properties as CSV to Blob Storage | `AzureOptimization_ExportARGDaily` schedule and `Reader` role in subscription(s) | `Recommend-AppServiceOptimizationsToBlobStorage` runbook and `Resources Inventory` workbook |
| `Export-ARGAvailabilitySetPropertiesToBlobStorage`       | Exports Availability Set properties as CSV to Blob Storage | `AzureOptimization_ExportARGDaily` schedule and `Reader` role in subscription(s) | `Recommend-VMsHighAvailabilityToBlobStorage` runbook |
| `Export-ARGLoadBalancerPropertiesToBlobStorage`       | Exports Load Balancer properties as CSV to Blob Storage | `AzureOptimization_ExportARGDaily` schedule and `Reader` role in subscription(s) | `Recommend-UnusedLoadBalancersToBlobStorage` runbook and `Resources Inventory` workbook |
| `Export-ARGManagedDisksPropertiesToBlobStorage`       | Exports Managed Disk properties as CSV to Blob Storage | `AzureOptimization_ExportARGDaily` schedule and `Reader` role in subscription(s) | `Recommend-DiskOptimizationsToBlobStorage`, `Recommend-UnattachedDisksToBlobStorage`,  `Recommend-VMOptimizationsToBlobStorage` runbooks and `Resources Inventory` workbook |
| `Export-ARGNICPropertiesToBlobStorage`       | Exports Network Interface properties as CSV to Blob Storage | `AzureOptimization_ExportARGDaily` schedule and `Reader` role in subscription(s) | `Recommend-VNetOptimizationsToBlobStorage` runbook and `Resources Inventory` workbook |
| `Export-ARGNSGPropertiesToBlobStorage`       | Exports Network Security Group properties as CSV to Blob Storage | `AzureOptimization_ExportARGDaily` schedule and `Reader` role in subscription(s) | `Recommend-VNetOptimizationsToBlobStorage` runbook and `Resources Inventory` workbook |
| `Export-ARGPublicIpPropertiesToBlobStorage`       | Exports Public IP Address properties as CSV to Blob Storage | `AzureOptimization_ExportARGDaily` schedule and `Reader` role in subscription(s) | `Recommend-VNetOptimizationsToBlobStorage` runbook and `Resources Inventory` workbook |
| `Export-ARGResourceContainersPropertiesToBlobStorage`       | Exports Subscription and Resource Group properties as CSV to Blob Storage | `AzureOptimization_ExportARGDaily` schedule and `Reader` role in subscription(s) | All runbooks and workbooks, with the exception of the `Export-AADObjectsToBlobStorage` runbook and `Identities and Roles` workbook |
| `Export-ARGSqlDatabasePropertiesToBlobStorage`       | Exports Azure SQL Database properties as CSV to Blob Storage | `AzureOptimization_ExportARGDaily` schedule and `Reader` role in subscription(s) | `Recommend-SqlDbOptimizationsToBlobStorage` runbook and `Resources Inventory` workbook |
| `Export-ARGUnmanagedDisksPropertiesToBlobStorage`       | Exports Unmanaged Disk properties as CSV to Blob Storage | `AzureOptimization_ExportARGDaily` schedule and `Reader` role in subscription(s) | `Recommend-VMsHighAvailabilityToBlobStorage` runbook and `Resources Inventory` workbook |
| `Export-ARGVirtualMachinesPropertiesToBlobStorage`       | Exports Virtual Machine properties as CSV to Blob Storage | `AzureOptimization_ExportARGDaily` schedule and `Reader` role in subscription(s) | `Recommend-AdvisorCostAugmentedToBlobStorage`, `Recommend-VMOptimizationsToBlobStorage`, `Recommend-VMsHighAvailabilityToBlobStorage` runbooks and `Resources Inventory` workbook |
| `Export-ARGVMSSPropertiesToBlobStorage`       | Exports Virtual Machine Scale Set properties as CSV to Blob Storage | `AzureOptimization_ExportARGDaily` schedule and `Reader` role in subscription(s) | `Recommend-VMsHighAvailabilityToBlobStorage`, `Recommend-VMSSOptimizationsToBlobStorage` runbooks and `Resources Inventory` workbook |
| `Export-ARGVNetPropertiesToBlobStorage`       | Exports Virtual Network properties as CSV to Blob Storage | `AzureOptimization_ExportARGDaily` schedule and `Reader` role in subscription(s) | `Recommend-VNetOptimizationsToBlobStorage` runbook and `Resources Inventory` workbook |
| `Export-AzMonitorMetricsToBlobStorage`       | Exports (for several resource types) Azure Monitor metrics as CSV to Blob Storage | `AzureOptimization_ExportMonitorAppServiceCpuAvgHourly`, `AzureOptimization_ExportMonitorAppServiceCpuMaxHourly`, `AzureOptimization_ExportMonitorAppServiceMemoryAvgHourly`, `AzureOptimization_ExportMonitorAppServiceMemoryMaxHourly`, `AzureOptimization_ExportMonitorDiskIOPSHourly`, `AzureOptimization_ExportMonitorDiskMBPsHourly`, `AzureOptimization_ExportMonitorSqlDbDtuAvgHourly`, `AzureOptimization_ExportMonitorSqlDbDtuMaxHourly`, `AzureOptimization_ExportMonitorVmssCpuAvgHourly`, `AzureOptimization_ExportMonitorVmssCpuMaxHourly`, `AzureOptimization_ExportMonitorVmssMemoryMinHourly` schedules and `Reader` role in subscription(s) | `Recommend-AppServiceOptimizationsToBlobStorage`, `Recommend-DiskOptimizationsToBlobStorage`, `Recommend-SqlDbOptimizationsToBlobStorage`, `Recommend-VMSSOptimizationsToBlobStorage` runbooks |
| `Export-ConsumptionToBlobStorage`       | Exports Azure billing event details as CSV to Blob Storage | `AzureOptimization_ConsumptionOffsetDays` variable, `AzureOptimization_ExportConsumptionDaily` schedule, and `Reader` role either in subscription(s) or in EA/MCA billing account/profile | All cost recommendation runbooks and all billing events-related workbooks |
| `Export-PolicyComplianceToBlobStorage`       | Exports Azure Policy compliance state details as CSV to Blob Storage | `AzureOptimization_ExportPolicyStateDaily` schedule and `Reader` role in subscription(s) | `Policy Compliance` workbook |
| `Export-PriceSheetToBlobStorage`       | Exports Azure EA/MCA pricesheet details as CSV to Blob Storage | `AzureOptimization_PriceSheetMeterCategories`, `AzureOptimization_PriceSheetMeterRegions`, `AzureOptimization_BillingAccountID`, `AzureOptimization_BillingProfileID` (MCA only) variables, `AzureOptimization_ExportPricesWeekly` schedule, and `Reader` role in EA/MCA billing account/profile (incompatible with non-EA/MCA-based deployments) | `Benefits Simulation`, `Benefits Usage`, `Reservations Potential`, `Reservations Usage`, and `Savings Plans Usage` workbooks |
| `Export-RBACAssignmentsToBlobStorage`       | Exports Azure RBAC and Entra ID role assignments as CSV to Blob Storage | `AzureOptimization_ExportRBACDaily` schedule, `Reader` role in subscription(s), and `Global Reader` role in Entra ID tenant | `Identities and Roles` and `Resources Inventory` workbooks and `Recommend-ARMOptimizationsToBlobStorage` runbook |
| `Export-ReservationsPriceToBlobStorage`       | Exports Azure Reservations pricing details (from the Azure Retail Prices API) as CSV to Blob Storage | `AzureOptimization_RetailPricesCurrencyCode` variable and `AzureOptimization_ExportPricesWeekly` schedule | `Benefits Simulation`, `Benefits Usage`, `Reservations Potential` and `Reservations Usage` workbooks |
| `Export-ReservationsUsageToBlobStorage`       | Exports Azure Reservations usage details as CSV to Blob Storage | `AzureOptimization_BillingAccountID` and `AzureOptimization_BillingProfileID` (MCA only) variables, `AzureOptimization_ExportReservationsDaily` schedule, and `Reader` role in EA/MCA billing account/profile (incompatible with non-EA/MCA-based deployments) | `Reservations Usage` workbook |
| `Export-SavingsPlansUsageToBlobStorage`       | Exports Azure Savings Plans usage details as CSV to Blob Storage | `AzureOptimization_BillingAccountID` and `AzureOptimization_BillingProfileID` (MCA only) variables, `AzureOptimization_ExportSavingsPlansDaily` schedule, and `Reader` role in EA/MCA billing account/profile (incompatible with non-EA/MCA-based deployments) | `Savings Plans Usage` workbook |
| `Ingest-OptimizationCSVExportsToLogAnalytics`       | Collects CSV exports from Blob Storage and ingests them into the respective Log Analytics table according to the defined mappings in the `LogAnalyticsIngestControl` table in the `azureoptimization` SQL Database | Almost all `AzureOptimization_Ingest*` schedules (one per Log Analytics table type, defined in the `StorageSinkContainer` schedule parameter) and `azureoptimization` SQL Database | All `Recommend-*` runbooks and all workbooks |

All runbooks depend on one or more of the following variables, which do not have a default value and are specific to each deployment (see [Variables](#-variables) for more details):

- `AzureOptimization_LogAnalyticsWorkspaceId`
- `AzureOptimization_LogAnalyticsWorkspaceKey`
- `AzureOptimization_LogAnalyticsWorkspaceName`
- `AzureOptimization_LogAnalyticsWorkspaceRG`
- `AzureOptimization_LogAnalyticsWorkspaceSubId`
- `AzureOptimization_LogAnalyticsWorkspaceTenantId`
- `AzureOptimization_SQLServerHostname`
- `AzureOptimization_StorageSink`

<br>

## ⏰ Schedules

| Schedule                                    | Frequency                        | Linked runbooks                  | Notes                            |
| ------------------------------------------- | -------------------------------- | -------------------------------- | -------------------------------- |
| `AzureOptimization_CleanUpRecommendationsWeekly`      | Weekly                    | `CleanUp-OlderRecommendationsFromSqlServer` | Can be rescheduled and run anytime |

<br>

## 🧿 Variables

| Variable                                    | Description                      | Used in runbooks                 | Notes                            |
| ------------------------------------------- | -------------------------------- | -------------------------------- | -------------------------------- |
| `AzureOptimization_AADObjectsContainer`     | Name of the Storage container where Entra ID objects are exported to                    | `Export-AADObjectsToBlobStorage` | Changing its value requires you to update the respective row in the `LogAnalyticsIngestControl` SQL table |

<br>

## 🧿 Log Analytics tables

All Log Analytics tables depend on the successful execution of the `Ingest-OptimizationCSVExportsToLogAnalytics`

| Table                                       | Data stored         | Origin storage container  | Origin runbooks    | Used in runbooks   | Used in workbooks  |
| ------------------------------------------- | ------------------- | ------------------------- | ------------------ | ------------------ | ------------------ |
| `AzureOptimizationAADObjectsV1_CL`          | Entra ID objects (users, groups, service principals, applications)   | `aadobjectsexports` | `Export-AADObjectsToBlobStorage` |  | Identities and Roles |

<br>

## 🧿 SQL Database tables

| Table                                       | Data stored         | Origin storage container  | Origin runbooks    | Used in runbooks   | Used in Power BI   |
| ------------------------------------------- | ------------------- | ------------------------- | ------------------ | ------------------ | ------------------ |
| `Filters`                   | User-created recommendation suppressions       |  |  |  | yes |
