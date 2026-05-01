// Copyright (c) 2017-2026 FORNAV ApS - All Rights Reserved
// The intellectual work and technical concepts contained in this file are proprietary to FORNAV.
// Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from FORNAV ApS.
// This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
namespace FORNAV.Training.EmailScenarios;
using Microsoft.Sales.History;
using System.EMail;
using System.Utilities;
codeunit 50102 "Email Scenario Functions"
{
    /// <summary>
    /// Generates and sends an email for the given record using the configured email scenario.
    /// </summary>
    /// <param name="RecVar">The record to generate the email for.</param>
    /// <param name="HideMailDialog">If true, the email is sent without showing the mail dialog.</param>
    procedure EmailFromScenario(RecVar: Variant; HideMailDialog: Boolean)
    var
        TempEmailItem: Record "Email Item" temporary;
        TextBuilderInterface: Codeunit "FORNAV Text Builder Interface";
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        is: InStream;
        os: OutStream;
    begin
        RecRef.GetTable(RecVar);
        TextBuilderInterface.GenerateEmail(TempEmailItem, Enum::"Email Scenario"::"PTE Test", RecRef.Number, RecRef.Field(RecRef.SystemIdNo).Value);
        TempBlob.CreateOutStream(os);
        Report.SaveAs(Report::"FORNAV VAT Sales Invoice", '', ReportFormat::Pdf, os, RecRef);
        TempBlob.CreateInStream(is);
        TempEmailItem.AddAttachment(is, 'AttachmentName.pdf');
        TempEmailItem.Send(HideMailDialog, Enum::"Email Scenario"::"PTE Test");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"FORNAV Email Scenario Mapping", OnBeforeGetSourceTableNo, '', false, false)]
    local procedure OnBeforeGetSourceTableNo(Source: Enum "Email Scenario"; var TableNo: Integer; var Handled: Boolean)
    begin
        case Source of
            Source::"PTE Test":
                TableNo := Database::"Sales Invoice Header";
            else
                exit;
        end;

        Handled := true;
    end;
}