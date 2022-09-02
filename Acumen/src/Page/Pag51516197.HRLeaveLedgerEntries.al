#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516197 "HR Leave Ledger Entries"
{
    Caption = 'Leave Ledger Entries';
    DataCaptionFields = "Leave Period";
    Editable = false;
    PageType = List;
    SourceTable = "HR Leave Ledger Entries";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Period";"Leave Period")
                {
                    ApplicationArea = Basic;
                }
                field("Staff No.";"Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field("Staff Name";"Staff Name")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Type";"Leave Type")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Entry Type";"Leave Entry Type")
                {
                    ApplicationArea = Basic;
                }
                field("No. of days";"No. of days")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Posting Description";"Leave Posting Description")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    RunObject = Page "Default Dimension Where-Used";
                    ShortCutKey = 'Shift+Ctrl+D';
                }
            }
        }
        area(processing)
        {
            action("&Navigate")
            {
                ApplicationArea = Basic;
                Caption = '&Navigate';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Navigate.SetDoc("Posting Date","Document No.");
                    Navigate.Run;
                end;
            }
        }
    }

    var
        Navigate: Page Navigate;
}

