table 50101 "PTE My Obsolete Table"
{
    DataClassification = ToBeClassified;
    ObsoleteState = Pending;
    ObsoleteReason = 'This table is no longer needed';

    fields
    {
        field(1; MyField; Integer)
        {
            DataClassification = ToBeClassified;

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