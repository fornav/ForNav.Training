#Readme

## Email Methods on Posted Sales Invoice

### Email from Scenario
Triggered via the **Email from Scenario** action on the Posted Sales Invoice page.  
Calls `EmailScenarioFunctions.EmailFromScenario`, which generates an email using the `PTE Test` email scenario, attaches the invoice as a PDF (rendered by the ForNAV VAT Sales Invoice report), and sends it directly through the BC email framework.  
The mail dialog is shown to the user before sending.

### Email from Report Selections
Triggered via the **Email from Report Selections** action on the Posted Sales Invoice page.  
Calls `ReportSelections.SendEmailToCust` using the `PTE Test` report selection usage.  
This follows the standard Business Central report selections flow: the report and email template configured under the matching report selection entry are used to compose and send the email to the sell-to customer.

---

## Required Code per Scenario

### Scenario 1: Email from Scenario

The following code pieces are required for the **Email from Scenario** flow:

| File | Purpose |
|------|---------|
| `EmailScenario.EnumExt.al` | Extends the `Email Scenario` enum with the `PTE Test` value, making the scenario available in BC's email framework. |
| `EmailScenarioFunctions.Codeunit.al` | Contains the `EmailFromScenario` procedure that generates the email body (via ForNAV Text Builder), renders the report as a PDF attachment, and sends the email using the `PTE Test` scenario. Also subscribes to `OnBeforeGetSourceTableNo` on `ForNAV Email Scenario Mapping` to map the `PTE Test` scenario to `Sales Invoice Header`, so ForNAV knows which table to use when building the email body. |

**Setup required in BC:**  
Configure an email template for the `PTE Test` scenario under *Email > Email Scenarios*.

---

### Scenario 2: Email from Report Selections

The following code pieces are required for the **Email from Report Selections** flow:

| File | Purpose |
|------|---------|
| `ReportSelectionUsage.enumExt.al` | Extends the `Report Selection Usage` enum with the `PTE Test` value, so a report selection entry can be created for this usage. |
| `ReportSelUsageSales.enumExt.al` | Extends the `Report Selection Usage Sales` enum with the `PTE Test` value, making it selectable in the **Report Selection - Sales** page. |
| `ReportSelectionEvents.Codeunit.al` | Contains three event subscribers: (1) `OnAfterFromReportSelectionUsage` maps the `PTE Test` report selection usage to the `PTE Test` email scenario so the correct email template is used; (2) `OnSetUsageFilterOnAfterSetFiltersByReportUsage` filters the Report Selections page to show the correct records when the sales usage is set to `PTE Test`; (3) `OnInitUsageFilterOnElseCase` initialises the sales usage filter from the base usage when the Report Selection - Sales page opens. |

**Setup required in BC:**  
Add a report selection entry for the `PTE Test` usage under *Report Selection - Sales*, pointing to the report that should be used (e.g. the ForNAV VAT Sales Invoice report).
