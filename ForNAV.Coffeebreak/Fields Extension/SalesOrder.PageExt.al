pageextension 50100 "PTE Sales Order" extends "Sales Order"
{
    layout
    {
        addlast(content)
        {
            group(PTECoffeeBreakFields)
            {
                Caption = 'Coffee Break fields';
                field("Coffee Break Name"; Rec."CoffeeBreakName")
                {
                    ApplicationArea = Basic;
                    Caption = 'Coffee Break - Name';
                    ToolTip = 'The Name field for the ForNAV Coffee Break mini-extension.';
                }
                field("Coffee Break Address"; Rec."CoffeeBreakAddress")
                {
                    ApplicationArea = Basic;
                    Caption = 'Coffee Break - Address';
                    ToolTip = 'The Address field for the ForNAV Coffee Break mini-extension.';
                }
                field("Coffee Break Post Code"; Rec."CoffeeBreakPostCode")
                {
                    ApplicationArea = Basic;
                    Caption = 'Coffee Break - Post Code';
                    ToolTip = 'The Post Code field for the ForNAV Coffee Break mini-extension.';
                }
                field("Coffee Break City"; Rec."CoffeeBreakCity")
                {
                    ApplicationArea = Basic;
                    Caption = 'Coffee Break - City';
                    ToolTip = 'The City field for the ForNAV Coffee Break mini-extension.';
                }
                field("Coffee Break Location Code"; Rec."CoffeeBreakLocationCode")
                {
                    ApplicationArea = Basic;
                    Caption = 'Coffee Break - Location Code';
                    ToolTip = 'The Location Code field for the ForNAV Coffee Break mini-extension.';
                }
            }
        }
    }

}