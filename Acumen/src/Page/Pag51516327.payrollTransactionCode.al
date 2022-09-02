#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516327 "payroll Transaction Code."
{
    PageType = Card;
    SourceTable = "Payroll Transaction Code.";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Transaction Code";"Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Name";"Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                label(Control1102756006)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text19065628;
                }
                group("Select one")
                {
                    Caption = 'Select one';
                    field("Transaction Type";"Transaction Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Transaction Specification";"Transaction Specification")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(Control1102756039)
                {
                    Caption = 'Select one';
                    field(Frequency;Frequency)
                    {
                        ApplicationArea = Basic;
                        ValuesAllowed = Fixed,Varied;
                    }
                }
                label(Control1102756010)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text19046900;
                }
                group(Control1102756044)
                {
                    Caption = 'Select one';
                    field("Balance Type";"Balance Type")
                    {
                        ApplicationArea = Basic;
                        ValuesAllowed = None,Increasing,Reducing;
                    }
                }
                field("Transaction Type1";"Transaction Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Preference';
                    ValuesAllowed = Income;
                }
                group(Control1102756049)
                {
                    Caption = 'Select one';
                }
                field("Amount Preference";"Amount Preference")
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
                    Caption = 'Is Formula';
                }
                field(Formulae;Formulae)
                {
                    ApplicationArea = Basic;
                    Caption = 'Formula';
                }
                field("Formula for Management Prov";"Formula for Management Prov")
                {
                    ApplicationArea = Basic;
                }
                label(Control1102756053)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text19025872;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Include Employer Deduction";"Include Employer Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Formulae for Employer";"Formulae for Employer")
                {
                    ApplicationArea = Basic;
                    Caption = 'Formula for Employer';
                }
                label(Control1102756054)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text19080001;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("G/L Account";"G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field(SubLedger;SubLedger)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting to Subledger';
                }
                field("Customer Posting Group";"Customer Posting Group")
                {
                    ApplicationArea = Basic;
                }
                group(Control1102756055)
                {
                    Caption = 'Select one';
                    field("Special Transaction";"Special Transaction")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(Control1102756068)
                {
                    Caption = 'Select one';
                    field("Special Transactions1";"Special Transaction")
                    {
                        ApplicationArea = Basic;
                        ValuesAllowed = "Life Insurance";
                    }
                    field("Deduct Premium";"Deduct Premium")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(Control1102756074)
                {
                    Caption = 'Select one';
                    field("Special Transactions2";"Special Transaction")
                    {
                        ApplicationArea = Basic;
                        ValuesAllowed = "Staff Loan";
                    }
                    group(Control1102756085)
                    {
                        Caption = 'Select one';
                        field("Repayment Method";"Repayment Method")
                        {
                            ApplicationArea = Basic;
                            ValuesAllowed = Reducing,"Straight line";
                        }
                    }
                    field("Fringe Benefit";"Fringe Benefit")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Employer Deduction";"Employer Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Rate";"Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field(Taxable;Taxable)
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Method1";"Repayment Method")
                {
                    ApplicationArea = Basic;
                    ValuesAllowed = Amortized;
                }
                group("Coop Reporting")
                {
                    Caption = 'Coop Reporting';
                    field("Co-Op Parameters";"Co-Op Parameters")
                    {
                        ApplicationArea = Basic;
                    }
                }
                label(Control1102756083)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text19015031;
                }
                field("IsCo-Op/LnRep";"IsCo-Op/LnRep")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //CurrPage.EDITABLE:=FALSE;
    end;

    var
        Text19065628: label 'Transaction Type';
        Text19046900: label 'Balance Type';
        Text19025872: label 'E.g ([005]+[020]*[24])/2268';
        Text19080001: label 'E.g ([005]+[020]*[24])/2268';
        Text19015031: label '%';
}

