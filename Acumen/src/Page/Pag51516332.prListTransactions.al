#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516332 "prList Transactions"
{
    PageType = List;
    SourceTable = "prEmployee Transactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Code";"Employee Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Code";"Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Name";"Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Balance;Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Original Amount";"Original Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Period Month";"Period Month")
                {
                    ApplicationArea = Basic;
                }
                field("Period Year";"Period Year")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Period";"Payroll Period")
                {
                    ApplicationArea = Basic;
                }
                field("#of Repayments";"#of Repayments")
                {
                    ApplicationArea = Basic;
                }
                field(Membership;Membership)
                {
                    ApplicationArea = Basic;
                }
                field("Reference No";"Reference No")
                {
                    ApplicationArea = Basic;
                }
                field(integera;integera)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Amount";"Employer Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Balance";"Employer Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Stop for Next Period";"Stop for Next Period")
                {
                    ApplicationArea = Basic;
                }
                field("Amortized Loan Total Repay Amt";"Amortized Loan Total Repay Amt")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date";"Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date";"End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Number";"Loan Number")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Code";"Payroll Code")
                {
                    ApplicationArea = Basic;
                }
                field("No of Units";"No of Units")
                {
                    ApplicationArea = Basic;
                }
                field(Suspended;Suspended)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Account No";"Loan Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Emp Count";"Emp Count")
                {
                    ApplicationArea = Basic;
                }
                field("PV Filter";"PV Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Emp Status";"Emp Status")
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

