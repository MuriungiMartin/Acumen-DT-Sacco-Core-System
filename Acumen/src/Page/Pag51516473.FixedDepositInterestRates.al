#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516473 "Fixed Deposit Interest Rates"
{
    PageType = ListPart;
    SourceTable = "FD Interest Calculation Crite";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Minimum Amount";"Minimum Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Amount";"Maximum Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Duration;Duration)
                {
                    ApplicationArea = Basic;
                }
                field("Interest Rate";"Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("On Call Interest Rate";"On Call Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("No of Months";"No of Months")
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

