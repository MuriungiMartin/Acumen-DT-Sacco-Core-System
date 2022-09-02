#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516532 "Cheque Register List"
{
    PageType = List;
    SourceTable = "Cheques Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque No.";"Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account No.";"Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Approval Date";"Approval Date")
                {
                    ApplicationArea = Basic;
                }
                field("Application No.";"Application No.")
                {
                    ApplicationArea = Basic;
                }
                field("Cancelled/Stopped By";"Cancelled/Stopped By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Cancel Cheque")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to cancel cheque ?',false)=true then begin
                    if Status<>Status::Pending then
                    Error('Status must be pending');
                    Status:=Status::Cancelled;
                    "Approval Date":=Today;
                    "Cancelled/Stopped By":=UserId;
                    Modify;
                    end;
                end;
            }
            action("Stop Cheque")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to stop cheque ?',false)=true then begin
                    if Status<>Status::Pending then
                    Error('Status must be pending');
                    Status:=Status::stopped;
                    "Approval Date":=Today;
                    "Cancelled/Stopped By":=UserId;
                    Modify;
                    end;
                end;
            }
            action("Cancel Cheque Book")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                         //reset;
                end;
            }
        }
    }
}

