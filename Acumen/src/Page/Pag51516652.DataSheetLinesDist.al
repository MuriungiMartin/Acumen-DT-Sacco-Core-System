#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516652 "Data Sheet Lines-Dist"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Data Sheet Lines-Dist";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payroll No";"Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field("Principal Amount";"Principal Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest";"Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance";"Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Principal Balance";"Expected Principal Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Principal Balance(Post-ChkOff)';
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type";"Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Special Code";"Special Code")
                {
                    ApplicationArea = Basic;
                }
                field(Installments;Installments)
                {
                    ApplicationArea = Basic;
                }
                field("Deduction type";"Deduction type")
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

