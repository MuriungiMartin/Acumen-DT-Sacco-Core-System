#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516641 "Accrued Interest Lines"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Monthly Interest Acrual";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product";"Loan Product")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No";"Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount";"Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance";"Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Rate";"Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Accrued";"Interest Accrued")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
    }
}

