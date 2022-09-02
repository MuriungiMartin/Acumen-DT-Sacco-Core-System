#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516885 "Loan Offset Detail List-P"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Loan Offset Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No.";"Loan No.")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Loan Top Up";"Loan Top Up")
                {
                    ApplicationArea = Basic;
                }
                field("Client Code";"Client Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Loan Type";"Loan Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Principle Top Up";"Principle Top Up")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Age";"Loan Age")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Remaining Installments";"Remaining Installments")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Interest Top Up";"Interest Top Up")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Repayment";"Monthly Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Interest Paid";"Interest Paid")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Balance";"Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Interest Rate";"Interest Rate")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Commision;Commision)
                {
                    ApplicationArea = Basic;
                    Caption = 'Levy';
                    Editable = false;
                }
                field("Interest Due at Clearance";"Interest Due at Clearance")
                {
                    ApplicationArea = Basic;
                    Caption = ' Interest Due';
                    Visible = false;
                }
                field("Total Top Up";"Total Top Up")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Recovery(P+I+Leavy)';
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Partial Bridged";"Partial Bridged")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Staff No";"Staff No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

