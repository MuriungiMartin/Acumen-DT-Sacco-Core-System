#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516425 "Loan Collateral Setup"
{
    PageType = List;
    SourceTable = "Loan Collateral Set-up";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field("Security Description";"Security Description")
                {
                    ApplicationArea = Basic;
                }
                field(Category;Category)
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Multiplier";"Collateral Multiplier")
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

