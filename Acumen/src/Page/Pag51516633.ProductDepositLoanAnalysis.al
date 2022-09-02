#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516633 "Product Deposit>Loan Analysis"
{
    PageType = List;
    SourceTable = "Product Deposit>Loan Analysis";

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
                field("Deposit Multiplier";"Deposit Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Deposit";"Minimum Deposit")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Share Capital";"Minimum Share Capital")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum No of Membership Month";"Minimum No of Membership Month")
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

