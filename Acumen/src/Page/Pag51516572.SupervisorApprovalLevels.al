#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516572 "Supervisor Approval Levels"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Supervisors Approval Levels";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Supervisor ID";"Supervisor ID")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Approval Amount";"Maximum Approval Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("E-mail Address";"E-mail Address")
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

