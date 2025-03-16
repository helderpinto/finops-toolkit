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
