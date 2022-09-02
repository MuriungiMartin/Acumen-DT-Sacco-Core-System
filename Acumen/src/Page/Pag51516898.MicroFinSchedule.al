#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516898 "Micro_Fin_Schedule"
{
    CardPageID = Micro_Fin_Transactions;
    DeleteAllowed = true;
    PageType = ListPart;
    SourceTable = Micro_Fin_Schedule;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account Number";"Account Number")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount Received";"Amount Received")
                {
                    ApplicationArea = Basic;
                }
                field("Registration Fee";"Registration Fee")
                {
                    ApplicationArea = Basic;
                    Caption = 'Entrance Fee';
                }
                field("Deposits Contribution";"Deposits Contribution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposits';
                }
                field("Share Capital";"Share Capital")
                {
                    ApplicationArea = Basic;
                    Caption = 'Shares';
                }
                field("Loans No.";"Loans No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan No.';
                }
                field("Group Code";"Group Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Interest Amount";"Interest Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Principle Amount";"Principle Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Principle Amount";"Expected Principle Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Interest";"Expected Interest")
                {
                    ApplicationArea = Basic;
                }
                field(Savings;Savings)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cumulative Savings';
                }
                field(OutBal;OutBal)
                {
                    ApplicationArea = Basic;
                    Caption = 'OutBal';
                }
                field("Outstanding Balance";"Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Excess Amount";"Excess Amount")
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

