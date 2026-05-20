codeunit 50100 "PTE Email Scenario Functions"
{
    procedure EmailFromScenario(RecVar: Variant; EmailScenario: Enum "Email Scenario"; HideMailDialog: Boolean)
    var
        TempEmailItem: Record "Email Item" temporary;
        TextBuilderInterface: Codeunit "FORNAV Text Builder Interface";
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        is: InStream;
        os: OutStream;
    begin
        RecRef.GetTable(RecVar);
        RecRef.SetRecFilter();
        TextBuilderInterface.GenerateEmail(TempEmailItem, EmailScenario, RecRef.Number, RecRef.Field(RecRef.SystemIdNo).Value);
        TempBlob.CreateOutStream(os);
        Report.SaveAs(Report::"ForNAV Sales Shipment", '', ReportFormat::Pdf, os, RecRef);
        TempBlob.CreateInStream(is);
        TempEmailItem.AddAttachment(is, 'AttachmentName.pdf');
        TempEmailItem.Send(HideMailDialog, EmailScenario);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"FORNAV Email Scenario Mapping", OnBeforeGetSourceTableNo, '', false, false)]
    local procedure OnBeforeGetSourceTableNo(Source: Enum "Email Scenario"; var TableNo: Integer; var Handled: Boolean)
    begin
        case Source of
            Source::"PTE Sales Shipment":
                TableNo := Database::"Sales Shipment Header";
            else
                exit;
        end;
        Handled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"FORNAV Email Scenario Mapping", OnBeforeCheckIsCustomer, '', false, false)]
    local procedure OnBeforeCheckIsCustomer(EmailScenario: Enum "Email Scenario"; var IsCustomer: Boolean; var Handled: Boolean)
    begin
        case EmailScenario of
            EmailScenario::"PTE Sales Shipment":
                IsCustomer := true;
            else
                exit;
        end;
        Handled := true;
    end;

}