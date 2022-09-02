#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516244 "Employee Common Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Employee Cue";

    layout
    {
        area(content)
        {
            cuegroup("Document Approvals")
            {
                Caption = 'Document Approvals';
                field("Leaves Pending Approvals";"Leaves Pending Approvals")
                {
                    ApplicationArea = Basic;
                    Caption = 'Leaves Pending Approvals';
                }

                actions
                {
                    action("Create Reminders...")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Create Reminders...';
                        Image = CreateReminders;
                        RunObject = Report "Create Reminders";
                    }
                    action("Create Finance Charge Memos...")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Create Finance Charge Memos...';
                        Image = CreateFinanceChargememo;
                        RunObject = Report "Create Finance Charge Memos";
                    }
                }
            }
            cuegroup("Incoming Documents")
            {
                Caption = 'Incoming Documents';
                field("New Incoming Documents";"New Incoming Documents")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Incoming Documents";"Approved Incoming Documents")
                {
                    ApplicationArea = Basic;
                }

                actions
                {
                    action(IncomingDocuments)
                    {
                        ApplicationArea = Basic;
                        Caption = 'View Incoming Documents';
                        RunObject = Page "Incoming Documents";
                        RunPageMode = View;
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Reset;
        if not Get then begin
          Init;
          Insert;
        end;
    end;
}

