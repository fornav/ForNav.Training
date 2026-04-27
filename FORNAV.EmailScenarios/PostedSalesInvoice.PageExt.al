// Copyright (c) 2017-2026 FORNAV ApS - All Rights Reserved
// The intellectual work and technical concepts contained in this file are proprietary to FORNAV.
// Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from FORNAV ApS.
// This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
namespace FORNAV.Training.EmailScenarios;
using Microsoft.Sales.History;
using Microsoft.Foundation.Reporting;
pageextension 50100 "Posted Sales Invoice" extends "Posted Sales Invoice"
{
    actions
    {
        addlast(Processing)
        {
            action(EmailScenario)
            {
                Caption = 'Email from Scenario';
                ToolTip = 'Run email scenario for testing';
                Image = SendEmailPDF;
                ApplicationArea = All;
                trigger OnAction()
                var
                    EmailScenarioFunctions: Codeunit "Email Scenario Functions";
                begin
                    EmailScenarioFunctions.EmailFromScenario(Rec, false);
                end;
            }
            action(ReportSelectionUsage)
            {
                Caption = 'Email from Report Selections';
                ToolTip = 'Run email scenario from report selections for testing';
                Image = SendEmailPDF;
                ApplicationArea = All;
                trigger OnAction()
                var
                    ReportSelections: Record "Report Selections";
                begin
                    ReportSelections.SendEmailToCust(Enum::"Report Selection Usage"::"PTE Test".AsInteger(), Rec, Rec."No.", 'Test Document', true, Rec."Sell-to Customer No.");
                end;
            }
        }
        addlast(Category_Category6)
        {

            actionref(EmailScenario_Promoted; EmailScenario)
            {
            }
            actionref(ReportSelectionUsage_Promoted; ReportSelectionUsage)
            {
            }
        }
    }
}