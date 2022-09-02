#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516057 "Funds Tax Card"
{
    PageType = Card;
    SourceTable = "Funds Tax Codes";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Tax Code";"Tax Code")
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
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Percentage;Percentage)
                {
                    ApplicationArea = Basic;
                }
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field("Liability Account";"Liability Account")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Tax";"Meeting Tax")
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

