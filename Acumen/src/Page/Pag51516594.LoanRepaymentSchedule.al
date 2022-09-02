#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516594 "Loan Repayment Schedule"
{
    PageType = List;
    SourceTable = "Loan Repay Schedule-Calc";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Balance";"Loan Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Principal Repayment";"Principal Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Interest";"Monthly Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Insurance";"Monthly Insurance")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Repayment";"Monthly Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Date";"Repayment Date")
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

