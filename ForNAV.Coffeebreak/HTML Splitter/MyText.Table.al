table 50100 "PTE My Text"
{
    DataClassification = ToBeClassified;
    Caption = 'My Text';
    LookupPageId = "PTE My Texts";
    DrillDownPageId = "PTE My Text";

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Code';
        }
        field(2; "Type"; Code[20])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Type';
        }
        field(3; Text; Blob)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Code, Type)
        {
            Clustered = true;
        }
    }

    internal procedure GetText() Result: Text
    var
        is: InStream;
    begin
        CalcFields("Text");
        if not "Text".HasValue then
            exit;

        "Text".CreateInStream(is, TextEncoding::UTF8);
        is.ReadText(Result);
    end;

    internal procedure SaveText(RichText: Text)
    var
        os: OutStream;
    begin
        Rec.Text.CreateOutStream(os);
        os.WriteText(RichText);
        Rec.Modify();
    end;
}