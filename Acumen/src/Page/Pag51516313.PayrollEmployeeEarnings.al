#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516313 "Payroll Employee Earnings."
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Payroll Employee Transactions.";
    SourceTableView = where("Transaction Type"=const(Income));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code";"Transaction Code")
                {
                    ApplicationArea = Basic;
                    TableRelation = "Payroll Transaction Code."."Transaction Code" where ("Transaction Type"=const(Income));
                }
                field("Transaction Name";"Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Amount(LCY)";"Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(Balance;Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Balance(LCY)";"Balance(LCY)")
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
            }
        }
    }

    actions
    {
    }
}

