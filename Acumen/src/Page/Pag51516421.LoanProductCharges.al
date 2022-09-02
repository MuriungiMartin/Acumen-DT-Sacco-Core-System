#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516421 "Loan Product Charges"
{
    PageType = List;
    SourceTable = "Loan Product Charges";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Code";"Product Code")
                {
                    ApplicationArea = Basic;
                }
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Percentage;Percentage)
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account";"G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("Use Perc";"Use Perc")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Amount";"Minimum Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Deduction Type";"Deduction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Charge Type";"Loan Charge Type")
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

