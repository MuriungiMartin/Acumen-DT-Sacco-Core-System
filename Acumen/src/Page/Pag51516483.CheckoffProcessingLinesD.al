#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516483 "Checkoff Processing Lines-D"
{
    PageType = ListPart;
    SourceTable = "Checkoff Lines-Distributed";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receipt Header No";"Receipt Header No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No.";"Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type";"Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No.";"Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field("Principal Amount";"Principal Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Amount";"Interest Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Deposit Amount";"Deposit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Shares Amount";"Shares Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Fosa Amount";"Fosa Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Type";"Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Entry No";"Entry No")
                {
                    ApplicationArea = Basic;
                }
                field("Trans Type";"Trans Type")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Account type";"Account type")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Account";"FOSA Account")
                {
                    ApplicationArea = Basic;
                }
                field("Special Code";"Special Code")
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

