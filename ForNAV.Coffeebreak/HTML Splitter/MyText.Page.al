page 50101 "PTE My Text"
{
    PageType = Card;
    SourceTable = "PTE My Text";
    Caption = 'My Text';

    layout
    {
        area(Content)
        {
            group(Metadata)
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
            group(Editor)
            {
                ShowCaption = false;

                field("Entity Text Editor"; TextContent)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ExtendedDatatype = RichContent;
                    Caption = 'Text';
                    Style = Attention;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        TextContent := Rec.GetText();
    end;


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (CloseAction in [Action::LookupOK, Action::OK]) then begin
            Rec.SaveText(TextContent);
            exit(true);
        end;
    end;

    var
        TextContent: Text;
}