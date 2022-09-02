#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516468 "Supervisor Approvals Levels"
{
    PageType = Card;
    SourceTable = "Supervisors Approval Levels";

    layout
    {
        area(content)
        {
            repeater(Control4)
            {
                field("Supervisor ID";"Supervisor ID")
                {
                    ApplicationArea = Basic;
                    Caption = 'User ID';
                }
                field("Supervisor Name";"Supervisor Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Approval Amount";"Maximum Approval Amount")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

