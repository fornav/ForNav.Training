pageextension 63000 "PTE Vendor Card" extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {
            field("PTE Number Of Portals"; Rec."PTE Number Of Portals")
            {
                ApplicationArea = all;
            }
        }
        addafter(General)
        {
            part(PTEVendorPortals; "PTE Vendor Portals")
            {
                Caption = 'Vendor Portals';
                SubPageLink = "Vendor No." = field("No.");
                ApplicationArea = all;
            }
        }
    }
}