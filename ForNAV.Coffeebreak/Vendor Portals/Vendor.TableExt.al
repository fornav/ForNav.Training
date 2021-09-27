tableextension 63000 "PTE Vendor" extends Vendor
{
    fields
    {
        field(63000; "PTE Number Of Portals"; Integer)
        {
            Caption = 'Number of Portals';
            FieldClass = FlowField;
            CalcFormula = count("PTE Vendor Portal" where("Vendor No." = field("No.")));
        }
    }
}