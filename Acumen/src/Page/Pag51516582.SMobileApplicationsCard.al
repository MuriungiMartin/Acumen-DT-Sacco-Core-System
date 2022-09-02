#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516582 "S-Mobile Applications Card"
{
    PageType = Card;
    SourceTable = "CloudPESA Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Telephone;Telephone)
                {
                    ApplicationArea = Basic;
                }
                field("ID No";"ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Other Details")
            {
                Caption = 'Other Details';
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Applied";"Date Applied")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Applied";"Time Applied")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By";"Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send for approval")
            {
                ApplicationArea = Basic;
                Caption = 'Send for approval';
                Image = Approve;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Status <> Status::Application then
                      Error('Application is already sent for approval');

                    TestField(Telephone);
                    TestField ("Account No");

                    //Status := Status::" Pending Approval";
                    Modify;
                    Message('Application has been sent to approval');
                end;
            }
        }
    }
}

