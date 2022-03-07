tableextension 70630 "ForNAV TR Customer" extends Customer
{
    fields
    {
        field(70630; "ForNAV TR My Field"; Text[100])
        {
            Caption = 'My Field';
            DataClassification = CustomerContent;
        }
    }
}