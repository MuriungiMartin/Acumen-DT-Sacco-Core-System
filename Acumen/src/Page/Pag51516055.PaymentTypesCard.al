#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516055 "Payment Types Card"
{
    PageType = Card;
    SourceTable = "Funds Transaction Types";
    SourceTableView = where("Transaction Type"=const(Payment));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Transaction Code";"Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description";"Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Default Grouping";"Default Grouping")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax Chargeable";"Withholding Tax Chargeable")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax Code";"Withholding Tax Code")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Chargeable";"VAT Chargeable")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Code";"VAT Code")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Other Setup")
            {
                field("Meeting Transaction";"Meeting Transaction")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Type";"Meeting Type")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
            "Transaction Type":="transaction type"::Payment;
    end;
}

