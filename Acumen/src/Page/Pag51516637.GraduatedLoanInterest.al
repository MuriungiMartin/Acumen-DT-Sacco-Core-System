#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516637 "Graduated Loan Interest"
{
    PageType = List;
    SourceTable = "Graduated Loan Int.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Code";"Loan Code")
                {
                    ApplicationArea = Basic;
                }
                field("Period From";"Period From")
                {
                    ApplicationArea = Basic;
                }
                field("Period To";"Period To")
                {
                    ApplicationArea = Basic;
                }
                field("Min Amount";"Min Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Max Amount";"Max Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Rate";"Interest Rate")
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

