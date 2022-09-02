#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516328 "Payroll Period Transaction."
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "prPeriod Transactions.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code";"Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Code";"Employee Code")
                {
                    ApplicationArea = Basic;
                }
                field("Group Text";"Group Text")
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
                field("Group Order";"Group Order")
                {
                    ApplicationArea = Basic;
                }
                field("Sub Group Order";"Sub Group Order")
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
                field("Period Filter";"Period Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Period";"Payroll Period")
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
                field("Department Code";"Department Code")
                {
                    ApplicationArea = Basic;
                }
                field(Lumpsumitems;Lumpsumitems)
                {
                    ApplicationArea = Basic;
                }
                field(TravelAllowance;TravelAllowance)
                {
                    ApplicationArea = Basic;
                }
                field("GL Account";"GL Account")
                {
                    ApplicationArea = Basic;
                }
                field("Company Deduction";"Company Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Emp Amount";"Emp Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Emp Balance";"Emp Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Journal Account Code";"Journal Account Code")
                {
                    ApplicationArea = Basic;
                }
                field("Journal Account Type";"Journal Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Post As";"Post As")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Number";"Loan Number")
                {
                    ApplicationArea = Basic;
                }
                field("coop parameters";"coop parameters")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Code";"Payroll Code")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Mode";"Payment Mode")
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

