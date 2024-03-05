table 50150 "ForNAV Local File"
{
    DataClassification = SystemMetadata;
    Caption = 'ForNAV Local File';
    TableType = Temporary;

    fields
    {
        field(1; Alias; Text[250])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Alias';
        }
        field(2; Filename; Text[2048])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Filename';
        }
        field(3; "Data"; Blob)
        {
            Compressed = true;
            DataClassification = SystemMetadata;
        }
    }
    keys { key(Key1; Alias, Filename) { } }

    procedure GetPath(): Text
    begin
        exit(Alias + ':\' + Filename);
    end;
}