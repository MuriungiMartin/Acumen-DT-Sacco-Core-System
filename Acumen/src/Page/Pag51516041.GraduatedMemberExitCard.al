#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516041 "Graduated Member Exit Card"
{
    PageType = Card;
    SourceTable = "MWithdrawal Graduated Charges";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Minimum Amount";"Minimum Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Amount";"Maximum Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Use Percentage";"Use Percentage")
                {
                    ApplicationArea = Basic;
                }
                field("Percentage of Amount";"Percentage of Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Account";"Charge Account")
                {
                    ApplicationArea = Basic;
                }
                field("Notice Status";"Notice Status")
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

