#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516617 "Loan Recovery Details"
{
    PageType = ListPart;
    SourceTable = "Loan Member Loans";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Guarantor Number";"Guarantor Number")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field("Loan Type";"Loan Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan No.";"Loan No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amont Guaranteed";"Amont Guaranteed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Outstanding";"Loan Outstanding")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Loan Instalments";"Loan Instalments")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Repayment";"Monthly Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Outstanding Balance";"Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Interest";"Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Guarantor Deposits";"Guarantor Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Defaulter Loan";"Defaulter Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Trustee Loan';
                    Editable = false;
                }
                field("Amount from Deposits";"Amount from Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Trustee Loan";"Amount to Trustee Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

