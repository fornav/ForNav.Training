namespace FORNAV.Training.EmailScenarios;
using System.EMail;
using Microsoft.Foundation.Reporting;
using Microsoft.Sales.Setup;
codeunit 50101 "Report Selection Events"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Email Scenario Mapping", OnAfterFromReportSelectionUsage, '', false, false)]
    local procedure OnAfterFromReportSelectionUsage(ReportSelectionUsage: Enum "Report Selection Usage"; var EmailScenario: Enum "Email Scenario")
    begin
        case ReportSelectionUsage of
            Enum::"Report Selection Usage"::"PTE Test":
                EmailScenario := Enum::"Email Scenario"::"PTE Test";
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Sales", OnSetUsageFilterOnAfterSetFiltersByReportUsage, '', false, false)]
    local procedure OnSetUsageFilterOnAfterSetFiltersByReportUsage(var Rec: Record "Report Selections"; ReportUsage2: Option)
    begin
        case ReportUsage2 of
            Enum::"Report Selection Usage Sales"::"PTE Test".AsInteger():
                Rec.SetRange(Usage, Enum::"Report Selection Usage"::"PTE Test");
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Sales", OnInitUsageFilterOnElseCase, '', false, false)]
    local procedure OnInitUsageFilterOnElseCase(var ReportUsage2: Enum "Report Selection Usage Sales"; ReportUsage: Enum "Report Selection Usage")
    begin
        case ReportUsage of
            Enum::"Report Selection Usage"::"PTE Test":
                ReportUsage2 := Enum::"Report Selection Usage Sales"::"PTE Test";
        end;
    end;
}