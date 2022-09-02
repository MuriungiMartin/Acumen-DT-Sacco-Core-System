#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516280 "HR Manager Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "HR Cue";

    layout
    {
        area(content)
        {
            cuegroup(Leave)
            {
                Caption = 'Leave';
                field("Leaves To be Approved";"Leaves To be Approved")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Leaves';
                    DrillDownPageID = "HR Leave Ledger Entries";
                }

                actions
                {
                    action("Leave Application Card")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Leave Application Card';
                        RunObject = Page "HR Leave Application Card";
                    }
                    action("Employee Card")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Employee Card';
                        RunObject = Page "HR Employee Card";
                        RunPageMode = Create;
                    }
                }
            }
            cuegroup(Employees)
            {
                Caption = 'Employees';
                field("Employee Requisitions";"Employee Requisitions")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "HR Employee Requisitions List";
                }
                field("Employee -Active";"Employee -Active")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee -Active';
                    DrillDownPageID = "HR Employee-List PR";
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

        SetFilter("Due Date Filter",'<=%1',WorkDate);
        SetFilter("Overdue Date Filter",'<%1',WorkDate);
    end;
}

