#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516411 "Sacco General Set-Up"
{
    ApplicationArea = Basic;
    PageType = Card;
    SourceTable = "Sacco General Set-Up";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General Setup';
                field("Min. Member Age"; "Min. Member Age")
                {
                    ApplicationArea = Basic;
                }
                field("Retirement Age"; "Retirement Age")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Contribution"; "Min. Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Retained Shares"; "Retained Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Share Capital Amount';
                }
                field("Share Capital Deduction"; "Share Capital Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Min Deposit Cont.(% of Basic)"; "Min Deposit Cont.(% of Basic)")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Take home"; "Minimum Take home")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum take home FOSA"; "Minimum take home FOSA")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Non Contribution Periods"; "Max. Non Contribution Periods")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Loan Application Period"; "Min. Loan Application Period")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Statement Period"; "Bank Statement Period")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal Statement Period';
                }
                field("Deposits Multiplier"; "Deposits Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Deposit Multiplier <200K"; "Deposit Multiplier <200K")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum No of Guarantees"; "Maximum No of Guarantees")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Guarantors"; "Min. Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Guarantors"; "Max. Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Capital Reserve"; "Capital Reserve")
                {
                    ApplicationArea = Basic;
                }
                field("Member Can Guarantee Own Loan"; "Member Can Guarantee Own Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Dividend (%)"; "Dividend (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Interest on Deposits (%)"; "Interest on Deposits (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Dividend Proc. Period"; "Min. Dividend Proc. Period")
                {
                    ApplicationArea = Basic;
                }
                field("Div Capitalization Min_Indiv"; "Div Capitalization Min_Indiv")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividend Capitalization Minimum Deposit_Individula';
                    ToolTip = 'Less this Deposits the System will capitalize part of your dividend based on the Dividend Capitalization %';
                }
                field("Div Capitalization Min_Corp"; "Div Capitalization Min_Corp")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividend Capitalization Minimum Deposit_Corporate Account';
                    ToolTip = 'Less this Deposits the System will capitalize part of your dividend based on the Dividend Capitalization %';
                }
                field("Div Capitalization %"; "Div Capitalization %")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividend Capitalization %';
                }
                field("Days for Checkoff"; "Days for Checkoff")
                {
                    ApplicationArea = Basic;
                }
                field("Boosting Shares Maturity (M)"; "Boosting Shares Maturity (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Contactual Shares (%)"; "Contactual Shares (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Use Bands"; "Use Bands")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Contactual Shares"; "Max. Contactual Shares")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax (%)"; "Withholding Tax (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Welfare Contribution"; "Welfare Contribution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Insurance Contribution';
                }
                field("ATM Expiry Duration"; "ATM Expiry Duration")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Share Contributions"; "Monthly Share Contributions")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Co-op Bank Amount"; "ATM Card Co-op Bank Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Risk Fund Amount"; "Risk Fund Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Deceased Cust Dep Multiplier"; "Deceased Cust Dep Multiplier")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposit Refund Multiplier-Death';
                }
                field("Begin Of Month"; "Begin Of Month")
                {
                    ApplicationArea = Basic;
                }
                field("End Of Month"; "End Of Month")
                {
                    ApplicationArea = Basic;
                }
                field("E-Loan Qualification (%)"; "E-Loan Qualification (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Charge FOSA Registration Fee"; "Charge FOSA Registration Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Charge BOSA Registration Fee"; "Charge BOSA Registration Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Defaulter LN"; "Defaulter LN")
                {
                    ApplicationArea = Basic;
                }
                field("Last Transaction Duration"; "Last Transaction Duration")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code No"; "Branch Code No")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Contribution"; "Insurance Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Allowable Cheque Discounting %"; "Allowable Cheque Discounting %")
                {
                    ApplicationArea = Basic;
                }
                field("Sto max tolerance Days"; "Sto max tolerance Days")
                {
                    ApplicationArea = Basic;
                    Caption = 'Standing Order Maximum Tolerance Days';
                    ToolTip = 'Specify the Maximum No of  Days the Standing order should keep trying if the Member account has inserficient amount';
                }
                field("Dont Allow Sto Partial Ded."; "Dont Allow Sto Partial Ded.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dont Allow Sto Partial Deduction';
                }
                field("Standing Order Bank"; "Standing Order Bank")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specify the Cash book account to be credit when a member places an External standing order';
                }
            }
            group("Fees & Commissions")
            {
                Caption = 'Fees & Commissions';
                field("Withdrawal Fee"; "Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Registration Fee Amount"; "FOSA Registration Fee Amount")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Registration Fee Amount"; "BOSA Registration Fee Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Rejoining Fee"; "Rejoining Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Boosting Shares %"; "Boosting Shares %")
                {
                    ApplicationArea = Basic;
                }
                field("Dividend Processing Fee"; "Dividend Processing Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Trasfer Fee-EFT"; "Loan Trasfer Fee-EFT")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Trasfer Fee-Cheque"; "Loan Trasfer Fee-Cheque")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Trasfer Fee-Cheque';
                }
                field("Loan Trasfer Fee-FOSA"; "Loan Trasfer Fee-FOSA")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Trasfer Fee-RTGS"; "Loan Trasfer Fee-RTGS")
                {
                    ApplicationArea = Basic;
                }
                field("Top up Commission"; "Top up Commission")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee New"; "ATM Card Fee New")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee-New Coop"; "ATM Card Fee-New Coop")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee-New Sacco"; "ATM Card Fee-New Sacco")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Renewal Fee Bank"; "ATM Card Renewal Fee Bank")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Renewal Fee Sacco"; "ATM Card Renewal Fee Sacco")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee-Renewal"; "ATM Card Fee-Renewal")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee Co-op Bank"; "ATM Card Fee Co-op Bank")
                {
                    ApplicationArea = Basic;
                }
                field("Excise Duty(%)"; "Excise Duty(%)")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Fee Amount"; "SMS Fee Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Risk Beneficiary (%)"; "Risk Beneficiary (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Cash Clearing Fee(%)"; "Loan Cash Clearing Fee(%)")
                {
                    ApplicationArea = Basic;
                }
                field("Mpesa Withdrawal Fee"; "Mpesa Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Discounting Fee %"; "Cheque Discounting Fee %")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Discounting Comission"; "Cheque Discounting Comission")
                {
                    ApplicationArea = Basic;
                }
                field("Funeral Expense Amount"; "Funeral Expense Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Share Capital Transfer Fee"; "Share Capital Transfer Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Partial Deposit Refund Fee"; "Partial Deposit Refund Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Monthly Contribution"; "Penalty Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Penalty on Failed Monthly Contribution';
                    ToolTip = 'Specify the Penalty Amount to Charge a Member who has not meet the minimum Monthly contribution';
                }
            }
            group("Fees & Commissions Accounts")
            {
                Caption = 'Fees & Commissions Accounts';
                field("Withdrawal Fee Account"; "Withdrawal Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Registration Fee Account"; "FOSA Registration Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Registration Fee Account"; "BOSA Registration Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Rejoining Fees Account"; "Rejoining Fees Account")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Trasfer Fee A/C-EFT"; "Loan Trasfer Fee A/C-EFT")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Trasfer Fee Account-EFT';
                }
                field("Loan Trasfer Fee A/C-Cheque"; "Loan Trasfer Fee A/C-Cheque")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Trasfer Fee Account-Cheque';
                }
                field("Loan Trasfer Fee A/C-FOSA"; "Loan Trasfer Fee A/C-FOSA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Trasfer Fee Account-FOSA';
                }
                field("Loan Trasfer Fee A/C-RTGS"; "Loan Trasfer Fee A/C-RTGS")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee-Account"; "ATM Card Fee-Account")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA MPESA COmm A/C"; "FOSA MPESA COmm A/C")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Retension Account"; "Insurance Retension Account")
                {
                    ApplicationArea = Basic;
                }
                field("WithHolding Tax Account"; "WithHolding Tax Account")
                {
                    ApplicationArea = Basic;
                }
                field("Shares Retension Account"; "Shares Retension Account")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Transfer Fees Account"; "Loan Transfer Fees Account")
                {
                    ApplicationArea = Basic;
                }
                field("Boosting Fees Account"; "Boosting Fees Account")
                {
                    ApplicationArea = Basic;
                }
                field("Bridging Commision Account"; "Bridging Commision Account")
                {
                    ApplicationArea = Basic;
                }
                field("Funeral Expenses Account"; "Funeral Expenses Account")
                {
                    ApplicationArea = Basic;
                }
                field("Dividend Payable Account"; "Dividend Payable Account")
                {
                    ApplicationArea = Basic;
                }
                field("Dividend Process Fee Account"; "Dividend Process Fee Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividend Processing Fee Account';
                }
                field("Excise Duty Account"; "Excise Duty Account")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Fee Account"; "SMS Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff Interest Account"; "Checkoff Interest Account")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Cash Clearing Account"; "Loan Cash Clearing Account")
                {
                    ApplicationArea = Basic;
                }
                field("Risk Fund Control Account"; "Risk Fund Control Account")
                {
                    ApplicationArea = Basic;
                }
                field("S_Mobile Settlement Account"; "S_Mobile Settlement Account")
                {
                    ApplicationArea = Basic;
                }
                field("S_Mobile Income Account"; "S_Mobile Income Account")
                {
                    ApplicationArea = Basic;
                }
                field("S_Mobile Income Bulk"; "S_Mobile Income Bulk")
                {
                    ApplicationArea = Basic;
                }
                field("Paybill Tarrifs"; "Paybill Tarrifs")
                {
                    ApplicationArea = Basic;
                }
                field("Mpesa Withdrawal Fee Account"; "Mpesa Withdrawal Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Comission Received Mpesa"; "Comission Received Mpesa")
                {
                    ApplicationArea = Basic;
                }
                field("Mpesa Cash Withdrawal fee ac"; "Mpesa Cash Withdrawal fee ac")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Discounting Fee Account"; "Cheque Discounting Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Deposit Refund On DeathAccount"; "Deposit Refund On DeathAccount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Attachment Comm. Account"; "Loan Attachment Comm. Account")
                {
                    ApplicationArea = Basic;
                }
                field("Share Capital Transfer Fee Acc"; "Share Capital Transfer Fee Acc")
                {
                    ApplicationArea = Basic;
                }
                field("Partial Deposit Refund Fee A/C"; "Partial Deposit Refund Fee A/C")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Monthly Contr. Account"; "Penalty Monthly Contr. Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Penalty On Failed Monthly Contr. Account';
                }
            }
            group("SMS Notifications")
            {
                field("Send Membership App SMS"; "Send Membership App SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Membership Application SMS';
                }
                field("Send Membership Reg SMS"; "Send Membership Reg SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Membership Registration SMS';
                }
                field("Send Loan App SMS"; "Send Loan App SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Loan Application SMS';
                }
                field("Send Loan Disbursement SMS"; "Send Loan Disbursement SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Loan Disbursement SMS';
                }
                field("Send Guarantorship SMS"; "Send Guarantorship SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Guarantorship SMS';
                }
                field("Send Membership Withdrawal SMS"; "Send Membership Withdrawal SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Membership Withdrawal SMS';
                }
                field("Send ATM Withdrawal SMS"; "Send ATM Withdrawal SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send ATM Withdrawal SMS';
                }
                field("Send Cash Withdrawal SMS"; "Send Cash Withdrawal SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Cash Withdrawal SMS';
                }
            }
            group("Email Notifications")
            {
                field("Send Membership App Email"; "Send Membership App Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Membership Reg Email"; "Send Membership Reg Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Loan App Email"; "Send Loan App Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Loan Disbursement Email"; "Send Loan Disbursement Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Guarantorship Email"; "Send Guarantorship Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Membship Withdrawal Email"; "Send Membship Withdrawal Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send ATM Withdrawal Email"; "Send ATM Withdrawal Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Cash Withdrawal Email"; "Send Cash Withdrawal Email")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Default Posting Groups")
            {
                field("Default Customer Posting Group"; "Default Customer Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Default Micro Credit Posting G"; "Default Micro Credit Posting G")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Shares Bands")
            {
                Caption = 'Shares Bands';
            }
        }
        area(processing)
        {
            action("Reset Data Sheet")
            {
                ApplicationArea = Basic;
                Caption = 'Reset Data Sheet';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Cust.Reset;
                    Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                    if Cust.Find('-') then
                        Cust.ModifyAll(Cust.Advice, false);


                    Loans.Reset;
                    Loans.SetRange(Loans.Source, Loans.Source::" ");
                    if Loans.Find('-') then
                        Loans.ModifyAll(Loans.Advice, false);


                    Message('Reset Completed successfully.');
                end;
            }
        }
    }

    var
        Cust: Record Customer;
        Loans: Record "Loans Register";
}

