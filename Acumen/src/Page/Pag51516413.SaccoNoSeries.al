#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516413 "Sacco No. Series"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    Editable = true;
    SourceTable = "Sacco No. Series";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Primary Key";"Primary Key")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("SMS Request Series";"SMS Request Series")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Credit)
            {
                Caption = 'Credit';
                field("Member Application Nos";"Member Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Micro Loans";"Micro Loans")
                {
                    ApplicationArea = Basic;
                }
                field("Members Nos";"Members Nos")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Member Sub Accounts")
            {
                Caption = 'Member Sub Accounts';
                field("BOSA Loans Nos";"BOSA Loans Nos")
                {
                    ApplicationArea = Basic;
                }
                field("E-Loan Nos";"E-Loan Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Loans Batch Nos";"Loans Batch Nos")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Receipts Nos";"BOSA Receipts Nos")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Transfer Nos";"BOSA Transfer Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Closure  Nos";"Closure  Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Check Off Advisor";"Check Off Advisor")
                {
                    ApplicationArea = Basic;
                }
                field("Bosa Transaction Nos";"Bosa Transaction Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Paybill Processing";"Paybill Processing")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff-Proc Distributed Nos";"Checkoff-Proc Distributed Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff Proc Block Nos";"Checkoff Proc Block Nos")
                {
                    ApplicationArea = Basic;
                }
                field(BosaNumber;BosaNumber)
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No Used';
                }
                field("Loan PayOff Nos";"Loan PayOff Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Microfinance Last No Used";"Microfinance Last No Used")
                {
                    ApplicationArea = Basic;
                }
                field("MicroFinance Account Prefix";"MicroFinance Account Prefix")
                {
                    ApplicationArea = Basic;
                }
                field("Micro Transactions";"Micro Transactions")
                {
                    ApplicationArea = Basic;
                }
                field("Micro Finance Transactions";"Micro Finance Transactions")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Register No";"Collateral Register No")
                {
                    ApplicationArea = Basic;
                }
                field("Cloudpesa Reg No.";"Cloudpesa Reg No.")
                {
                    ApplicationArea = Basic;
                }
                field("Safe Custody Package Nos";"Safe Custody Package Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Safe Custody Agent Nos";"Safe Custody Agent Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Safe Custody Item Nos";"Safe Custody Item Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Package Retrieval Nos";"Package Retrieval Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Member Cell Group Nos";"Member Cell Group Nos")
                {
                    ApplicationArea = Basic;
                }
                field("House Change Request No";"House Change Request No")
                {
                    ApplicationArea = Basic;
                }
                field("BD Training Nos";"BD Training Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Member Agent/NOK Change";"Member Agent/NOK Change")
                {
                    ApplicationArea = Basic;
                }
                field("House Group Application";"House Group Application")
                {
                    ApplicationArea = Basic;
                }
                field("House Group Nos";"House Group Nos")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Banking Services")
            {
                Caption = 'Banking Services';
                field("FOSA Loans Nos";"FOSA Loans Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Nos.";"Transaction Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Treasury Nos.";"Treasury Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Standing Orders Nos.";"Standing Orders Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Current Account";"FOSA Current Account")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Current Account";"BOSA Current Account")
                {
                    ApplicationArea = Basic;
                }
                field("Teller Transactions No";"Teller Transactions No")
                {
                    ApplicationArea = Basic;
                }
                field("Treasury Transactions No";"Treasury Transactions No")
                {
                    ApplicationArea = Basic;
                }
                field("Applicants Nos.";"Applicants Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("STO Register No";"STO Register No")
                {
                    ApplicationArea = Basic;
                }
                field("EFT Header Nos.";"EFT Header Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("EFT Details Nos.";"EFT Details Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Processing Nos";"Salary Processing Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Salaries Nos.";"Salaries Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Applications";"ATM Applications")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Clearing Nos";"Cheque Clearing Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Application Nos";"Cheque Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Receipts Nos";"Cheque Receipts Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Care Log Nos";"Customer Care Log Nos")
                {
                    ApplicationArea = Basic;
                }
                field("S_Mobile Registration Nos";"S_Mobile Registration Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Trunch Disbursment Nos";"Trunch Disbursment Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Change Request No";"Change Request No")
                {
                    ApplicationArea = Basic;
                }
                field("Agent Serial Nos";"Agent Serial Nos")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Batch Nos";"ATM Card Batch Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Demand Notice Nos";"Demand Notice Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Deposit Placement";"Fixed Deposit Placement")
                {
                    ApplicationArea = Basic;
                }
                field("Guarantor Substitution";"Guarantor Substitution")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Others)
            {
                Caption = 'Others';
                field("Requisition No";"Requisition No")
                {
                    ApplicationArea = Basic;
                }
                field("Internal Requisition No.";"Internal Requisition No.")
                {
                    ApplicationArea = Basic;
                }
                field("Internal Purchase No.";"Internal Purchase No.")
                {
                    ApplicationArea = Basic;
                }
                field("Quatation Request No";"Quatation Request No")
                {
                    ApplicationArea = Basic;
                }
                field("Stores Requisition No";"Stores Requisition No")
                {
                    ApplicationArea = Basic;
                }
                field("Requisition Default Vendor";"Requisition Default Vendor")
                {
                    ApplicationArea = Basic;
                }
                field("Use Procurement limits";"Use Procurement limits")
                {
                    ApplicationArea = Basic;
                }
                field("Request for Quotation Nos";"Request for Quotation Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Investors Nos";"Investors Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Property Nos";"Property Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Investment Project Nos";"Investment Project Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax %";"Withholding Tax %")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax Account";"Withholding Tax Account")
                {
                    ApplicationArea = Basic;
                }
                field("VAT %";"VAT %")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Account";"VAT Account")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Investor)
            {
                Caption = 'Investor';
                field("Investor Application Nos";"Investor Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Investor Nos";"Investor Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Paybill No.";"Paybill No.")
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

