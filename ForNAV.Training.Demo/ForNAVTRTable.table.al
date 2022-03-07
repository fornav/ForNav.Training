table 70630 "ForNAV TR Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; CustomerNo; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(3; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; CustomerNo)
        {
            Clustered = true;
        }
    }
}