table 50100 "PTE My Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; MyField; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; Obsolete; Integer)
        {
            DataClassification = ToBeClassified;
            ObsoleteState = Pending;
            ObsoleteReason = 'This field is no longer needed';
        }
        field(3; Normal; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
    }

    keys
    {
        key(Key1; MyField)
        {
            Clustered = true;
        }
    }
}