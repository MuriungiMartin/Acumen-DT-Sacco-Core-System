#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516914 "Crm Log List"
{
    ApplicationArea = Basic;
    // CardPageID = "Crm log card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "General Equiries.";
    SourceTableView = where(Send = const(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll No"; "Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Balance"; "Loan Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Current Deposits"; "Current Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Holiday Savings"; "Holiday Savings")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("ID No"; "ID No")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control2; "Member Statistics FactBox")
            {
                Caption = 'BOSA Statistics FactBox';
                SubPageLink = "No." = field("Member No");
            }
            part(Control1; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("Fosa account");
            }
        }
    }

    actions
    {
    }
}

