// pageextension 50100 "PTE Posted Sales Shipments" extends "Posted Sales Shipments"
// {
//     actions
//     {
//         addlast(Processing)
//         {
//             action(PTESendEmail)
//             {
//                 Caption = 'Email from Scenario';
//                 ToolTip = 'Run email scenario for testing';
//                 Image = SendEmailPDF;
//                 ApplicationArea = All;
//                 trigger OnAction()
//                 var
//                     EmailScenarioFunctions: Codeunit "PTE Email Scenario Functions";
//                 begin
//                     EmailScenarioFunctions.EmailFromScenario(Rec, Enum::"Email Scenario"::"PTE Sales Shipment", false);
//                 end;
//             }
//         }
//         addlast(Category_Category7)
//         {
//             actionref(PTESendEmailPromoted; PTESendEmail)
//             {
//             }
//         }
//     }

// }