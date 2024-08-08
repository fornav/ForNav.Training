codeunit 50100 "PTE Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        // BreakStuff();
    end;

    trigger OnInstallAppPerDatabase()
    begin
        // EnsureBrokenReportRDLCLayout(Report::"PTE Report");
        // EnsureBrokenReportWordLayout(Report::"PTE Report");
        // EnsureMismatchedReportLayout(Report::"PTE Report", Report::"ForNAV Vendor - List");
    end;

    procedure BreakStuff()
    var
    begin
        EnsureReportLanguage();
        EnsureCustomLayout(Report::"PTE Report");
        EnsureReportDefault();
        EnsureOrphanedReportSelections();
        EnsureBrokenReportRDLCLayout(Report::"PTE Report");
        EnsureBrokenReportWordLayout(Report::"PTE Report");
        EnsureMismatchedReportLayout(Report::"PTE Report", Report::"ForNAV Vendor - List");
    end;

    local procedure EnsureReportLanguage()
    var
        AllObj: Record AllObj;
        Language: Record Language;
        LanguageSetup: Record "ForNAV Language Setup";
    begin
        LanguageSetup.DeleteAll();
        Language.FindFirst();

        LanguageSetup.Init();
        LanguageSetup."Report ID" := Report::"PTE Report";
        LanguageSetup.Validate("Language Code", Language.Code);
        LanguageSetup."Translate To" := 'ForNAV Health Check Test';
        LanguageSetup."Is Object Translation" := true;
        if LanguageSetup.Insert() then;

        LanguageSetup.Init();
        LanguageSetup."Report ID" := 0;
        LanguageSetup."Table No." := Database::"PTE My Obsolete Table";
        LanguageSetup.Validate("Language Code", Language.Code);
        LanguageSetup."Is Object Translation" := true;
        if LanguageSetup.Insert() then;

        LanguageSetup.Init();
        LanguageSetup."Report ID" := 0;
        LanguageSetup."Table No." := Database::"PTE My Obsolete Table";
        LanguageSetup."Field No." := 3;
        LanguageSetup.Validate("Language Code", Language.Code);
        LanguageSetup."Is Object Translation" := true;
        if LanguageSetup.Insert() then;

        LanguageSetup.Init();
        LanguageSetup."Report ID" := 0;
        LanguageSetup."Table No." := Database::"PTE My Obsolete Table";
        LanguageSetup."Field No." := 2;
        LanguageSetup.Validate("Language Code", Language.Code);
        LanguageSetup."Is Object Translation" := true;
        if LanguageSetup.Insert() then;
    end;

    procedure EnsureCustomLayout(ReportId: Integer)
    var
        AllObj: Record AllObj;
        TenantReportLayout: Record "Tenant Report Layout";
        is: InStream;
        os: OutStream;
        TestLbl: Label 'Test Orphan %1', Comment = '%1 = report id', Locked = true;
    begin
        TenantReportLayout.Init();
        TenantReportLayout."Report ID" := ReportId;
        TenantReportLayout.Name := StrSubstNo(TestLbl, TenantReportLayout."Report ID");
        TenantReportLayout."Company Name" := '';
        TenantReportLayout."Layout Format" := TenantReportLayout."Layout Format"::Word;
        TenantReportLayout.Description := 'EnsureCustomLayout';
        if Report.WordLayout(ReportId, is) then
            TenantReportLayout.Layout.ImportStream(is, TenantReportLayout.Description);
        if TenantReportLayout.Insert(true) then;
    end;

    procedure EnsureReportDefault()
    var
        AllObj: Record AllObj;
        ReportDefaults: Record "ForNAV Report Defaults";
    begin
        ReportDefaults.Init();
        ReportDefaults."Report ID" := Report::"PTE Report";
        ReportDefaults."Force Language" := true;
        if ReportDefaults.Insert() then;
    end;

    procedure EnsureOrphanedReportSelections()
    var
        AllObj: Record AllObj;
        ReportSelections: Record "Report Selections";
        ReportSelectionWarehouse: Record "Report Selection Warehouse";
    begin
        ReportSelections.Init();
        ReportSelections."Report ID" := Report::"PTE Report";
        ReportSelections.Usage := ReportSelections.Usage::"S.Order";
        ReportSelections.Sequence := '99';
        if ReportSelections.Insert() then;
        ReportSelections.Init();

        ReportSelections."Report ID" := Report::"PTE Report";
        ReportSelections.Usage := ReportSelections.Usage::"P.Order";
        ReportSelections.Sequence := '99';
        if ReportSelections.Insert() then;

        ReportSelectionWarehouse.Init();
        ReportSelectionWarehouse."Report ID" := Report::"PTE Report";
        ReportSelectionWarehouse.Usage := ReportSelectionWarehouse.Usage::Shipment;
        ReportSelectionWarehouse.Sequence := '99';
        if ReportSelectionWarehouse.Insert() then;
    end;

    procedure EnsureBrokenReportRDLCLayout(ReportId: Integer)
    var
        TenantReportLayout: Record "Tenant Report Layout";
        TempBlob: Codeunit "Temp Blob";
        is: InStream;
        os: OutStream;
        TestLbl: Label 'Test RDLC %1', Comment = '%1 = report id', Locked = true;
    begin
        TenantReportLayout.Init();
        TenantReportLayout."Report ID" := ReportId;
        TenantReportLayout.Name := StrSubstNo(TestLbl, ReportId);
        TenantReportLayout."Company Name" := '';
        TenantReportLayout."Layout Format" := TenantReportLayout."Layout Format"::RDLC;
        TenantReportLayout.Description := 'EnsureBrokenReportLayout';
        TempBlob.CreateOutStream(os, TextEncoding::UTF8);
        os.WriteText(CreateEmptyRDLCFile());
        TempBlob.CreateInStream(is, TextEncoding::UTF8);
        TenantReportLayout.Layout.ImportStream(is, TenantReportLayout.Description);
        if TenantReportLayout.Insert(true) then;
    end;

    procedure EnsureBrokenReportWordLayout(ReportId: Integer)
    var
        TenantReportLayout: Record "Tenant Report Layout";
        TempBlob: Codeunit "Temp Blob";
        is: InStream;
        os: OutStream;
        Rdlc: Text;
        TestLbl: Label 'Test Word %1', Comment = '%1 = report id', Locked = true;
    begin
        TenantReportLayout.Init();
        TenantReportLayout."Report ID" := ReportId;
        TenantReportLayout.Name := StrSubstNo(TestLbl, ReportId);
        TenantReportLayout."Company Name" := '';
        TenantReportLayout."Layout Format" := TenantReportLayout."Layout Format"::Word;
        TenantReportLayout.Description := 'EnsureBrokenReportLayout';
        TempBlob.CreateOutStream(os);
        Report.SaveAs(Report::"Customer - List", '', ReportFormat::Word, os);
        TempBlob.CreateInStream(is);
        TenantReportLayout.Layout.ImportStream(is, TenantReportLayout.Description);
        if TenantReportLayout.Insert(true) then;
    end;

    procedure EnsureMismatchedReportLayout(ToReportId: Integer; FromReportId: Integer)
    var
        TenantReportLayout: Record "Tenant Report Layout";
        is: InStream;
        TestLbl: Label 'Test Dataitem %1', Comment = '%1 = report id', Locked = true;
    begin
        TenantReportLayout.SetRange("Report ID", ToReportId);
        TenantReportLayout.SetRange(Name, StrSubstNo(TestLbl, ToReportId));
        TenantReportLayout.DeleteAll();
        TenantReportLayout.Init();
        TenantReportLayout."Report ID" := ToReportId;
        TenantReportLayout.Name := StrSubstNo(TestLbl, ToReportId);
        TenantReportLayout."Company Name" := '';
        TenantReportLayout."Layout Format" := TenantReportLayout."Layout Format"::Word;
        TenantReportLayout.Description := 'EnsureMismatchedReportLayout';
        Report.WordLayout(FromReportId, is);
        TenantReportLayout.Layout.ImportStream(is, TenantReportLayout.Description);
        if TenantReportLayout.Insert(true) then;
    end;

    local procedure CreateEmptyRDLCFile(): Text
    var
        Base64Convert: Codeunit "Base64 Convert";
    begin
        exit(Base64Convert.FromBase64('PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48UmVwb3J0IHhtbG5zPSJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3NxbHNlcnZlci9yZXBvcnRpbmcvMjAxNi8wMS9yZXBvcnRkZWZpbml0aW9uIiB4bWxuczpyZD0iaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS9TUUxTZXJ2ZXIvcmVwb3J0aW5nL3JlcG9ydGRlc2lnbmVyIj48L1JlcG9ydD4='));
    end;
}