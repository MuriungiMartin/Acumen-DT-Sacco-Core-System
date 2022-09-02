#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516317 "Payroll Deductions Card."
{
    PageType = Card;
    SourceTable = "Payroll Transaction Code.";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Transaction Code";"Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Name";"Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Balance Type";"Balance Type")
                {
                    ApplicationArea = Basic;
                }
                field(Frequency;Frequency)
                {
                    ApplicationArea = Basic;
                }
                field(Taxable;Taxable)
                {
                    ApplicationArea = Basic;
                }
                field("Is Cash";"Is Cash")
                {
                    ApplicationArea = Basic;
                }
                field("Is Formulae";"Is Formulae")
                {
                    ApplicationArea = Basic;
                }
                field(Formulae;Formulae)
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account";"G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account Name";"G/L Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(SubLedger;SubLedger)
                {
                    ApplicationArea = Basic;
                }
                field("Customer Posting Group";"Customer Posting Group")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Loan Details")
            {
                field("Deduct Premium";"Deduct Premium")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Rate";"Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Method";"Repayment Method")
                {
                    ApplicationArea = Basic;
                }
                field("IsCo-Op/LnRep";"IsCo-Op/LnRep")
                {
                    ApplicationArea = Basic;
                }
                field("Deduct Mortgage";"Deduct Mortgage")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Other Setup")
            {
                field("Special Transaction";"Special Transaction")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Preference";"Amount Preference")
                {
                    ApplicationArea = Basic;
                }
                field("Fringe Benefit";"Fringe Benefit")
                {
                    ApplicationArea = Basic;
                }
                field(IsHouseAllowance;IsHouseAllowance)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Deduction";"Employer Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Include Employer Deduction";"Include Employer Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Formulae for Employer";"Formulae for Employer")
                {
                    ApplicationArea = Basic;
                }
                field("Co-Op Parameters";"Co-Op Parameters")
                {
                    ApplicationArea = Basic;
                }
                field(Welfare;Welfare)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
           "Transaction Type":="transaction type"::Deduction;
    end;
}

