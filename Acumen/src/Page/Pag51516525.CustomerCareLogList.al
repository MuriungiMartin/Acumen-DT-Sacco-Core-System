#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516525 "Customer Care Log List"
{
    ApplicationArea = Basic;
    CardPageID = "Customer Care Log";
    Editable = false;
    PageType = List;
    SourceTable = "Customer Care Logs";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No;No)
                {
                    ApplicationArea = Basic;
                }
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll No";"Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Balance";"Loan Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Current Deposits";"Current Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Holiday Savings";"Holiday Savings")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("ID No";"ID No")
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

