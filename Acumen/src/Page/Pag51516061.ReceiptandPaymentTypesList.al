#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516061 "Receipt and Payment Types List"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Receipts and Payment Types";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control1102758000)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field("VAT Chargeable";"VAT Chargeable")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax Chargeable";"Withholding Tax Chargeable")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Code";"VAT Code")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax Code";"Withholding Tax Code")
                {
                    ApplicationArea = Basic;
                }
                field("Default Grouping";"Default Grouping")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account";"G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("Pending Voucher";"Pending Voucher")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account";"Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Transation Remarks";"Transation Remarks")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}

