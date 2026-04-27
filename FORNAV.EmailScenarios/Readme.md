#Readme

## Use custom email scenarios with the FORNAV Email Templates 
The FORNAV Email Templates use the standard email scenarios to determine which email to send in which situation.
The email scenarios are extendible, which means that you can add your own, just like you can extend the report selection usage enum to define selections for custom reports.
There are two possible scenarios. You can simply call the FORNAV Email Template code directly for a fast and simple email implementation, or you can implement the standard Report Selections code. Both work once you have set up the necessary Enums.

---

### Scenario 1: Email from FORNAV Email Template code

Use the **Email from Scenario** action on the Posted Sales Invoice page to send an email via the FORNAV email scenario framework.  
The action calls `EmailScenarioFunctions.EmailFromScenario`, which generates the email body using the `PTE Test` email scenario, renders the ForNAV VAT Sales Invoice report as a PDF and attaches it, then sends the email through the BC email framework.  
The user sees the mail dialog before the email is sent.

Add these files to implement the **Email from Scenario** flow:

| File | Purpose |
|------|---------|
| `EmailScenario.EnumExt.al` | Extend the `Email Scenario` enum with the `PTE Test` value to make the scenario available in BC's email framework. |
| `EmailScenarioFunctions.Codeunit.al` | Implement the `EmailFromScenario` procedure: generate the email body via ForNAV Text Builder, render the report as a PDF attachment, and send the email using the `PTE Test` scenario. Subscribe to `OnBeforeGetSourceTableNo` on `ForNAV Email Scenario Mapping` to tell ForNAV that `PTE Test` maps to `Sales Invoice Header`. |

**Setup required in BC:**  
Create an email template for the `PTE Test` scenario.

---

### Scenario 2: Email from Report Selections

Use the **Email from Report Selections** action on the Posted Sales Invoice page to send an email via the standard BC report selections flow.  
The action calls `ReportSelections.SendEmailToCust` with the `PTE Test` report selection usage, which picks up the report and email template configured for that usage and sends the email to the sell-to customer.

Add these files to implement the **Email from Report Selections** flow:

| File | Purpose |
|------|---------|
| `ReportSelectionUsage.enumExt.al` | Extend the `Report Selection Usage` enum with the `PTE Test` value to allow creating a report selection entry for this usage. |
| `ReportSelUsageSales.enumExt.al` | Extend the `Report Selection Usage Sales` enum with the `PTE Test` value to make it selectable on the **Report Selection - Sales** page. |
| `ReportSelectionEvents.Codeunit.al` | Subscribe to three events: (1) `OnAfterFromReportSelectionUsage` — map the `PTE Test` report selection usage to the `PTE Test` email scenario so BC uses the correct email template; (2) `OnSetUsageFilterOnAfterSetFiltersByReportUsage` — filter the Report Selections page to the correct records when the user selects the `PTE Test` sales usage; (3) `OnInitUsageFilterOnElseCase` — initialise the sales usage filter from the base usage when the Report Selection - Sales page opens. |

**Setup required in BC:**  
Create an email template for the `PTE Test` scenario.
Add a report selection entry for the `PTE Test` usage under *Report Selection - Sales* and point it to the report to use (e.g. the ForNAV VAT Sales Invoice report).
