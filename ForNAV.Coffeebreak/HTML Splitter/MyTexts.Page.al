page 50100 "PTE My Texts"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "PTE My Text";
    Caption = 'My Texts';
    CardPageId = "PTE My Text";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(EditText)
    //         {
    //             ApplicationArea = All;
    //             Caption = 'Edit Text';
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             Image = Text;

    //             trigger OnAction();
    //             begin

    //             end;
    //         }
    //     }
    // }
}