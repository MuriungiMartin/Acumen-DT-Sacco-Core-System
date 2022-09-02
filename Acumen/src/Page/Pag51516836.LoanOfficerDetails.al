#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516836 "Loan Officer Details"
{
    ApplicationArea = Basic;
    CardPageID = "Loan Officer Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Loan Officers Details";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No.";"Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Savings Target";"Savings Target")
                {
                    ApplicationArea = Basic;
                }
                field("Member Target";"Member Target")
                {
                    ApplicationArea = Basic;
                }
                field("Disbursement Target";"Disbursement Target")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Target";"Payment Target")
                {
                    ApplicationArea = Basic;
                }
                field("Exit Target";"Exit Target")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Loans";"No. of Loans")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field(Created;Created)
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
            separator(Action1000000012)
            {
            }
            action(Approval)
            {
                ApplicationArea = Basic;
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                      ///rereer
                end;
            }
            separator(Action1000000014)
            {
            }
        }
    }
}

