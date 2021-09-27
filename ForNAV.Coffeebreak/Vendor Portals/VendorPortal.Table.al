table 63000 "PTE Vendor Portal"
{
    DataClassification = ToBeClassified;
    Caption = 'Vendor Portal';

    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(2; "Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "URL"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Vendor No.", Name)
        {
            Clustered = true;
        }
    }
}