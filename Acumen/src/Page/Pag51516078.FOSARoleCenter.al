#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516078 "FOSA Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control1000000018;"HR Emp Transfer List")
            {
                Caption = 'FOSA Account Holders';
            }
            group(Control1000000015)
            {
            }
            part(Control1000000001;"Copy Profile")
            {
            }
            systempart(Control1000000000;MyNotes)
            {
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Process Cheque Clearing")
            {
                ApplicationArea = Basic;
                Caption = 'Process Cheque Clearing';
                Image = "Report";
                RunObject = Report "Employers List";
            }
            action("Process Standing Orders")
            {
                ApplicationArea = Basic;
                Caption = 'Process Standing Orders';
                Image = "Report";
                RunObject = Report UnknownReport51516272;
            }
            action("Generate FOSA Interest")
            {
                ApplicationArea = Basic;
                Caption = 'Generate FOSA Interest';
                Image = "Report";
                RunObject = Report UnknownReport51516273;
            }
            action("Transfer FOSA Interest")
            {
                ApplicationArea = Basic;
                Caption = 'Transfer FOSA Interest';
                Image = "Report";
                RunObject = Report UnknownReport51516274;
            }
            action("Calculate Fixed Int")
            {
                ApplicationArea = Basic;
                Caption = 'Calculate Fixed Int';
                Image = "Report";
                RunObject = Report UnknownReport51516275;
            }
            action("Accounts Status")
            {
                ApplicationArea = Basic;
                Caption = 'Accounts Status';
                Image = "Report";
                RunObject = Report UnknownReport51516276;
            }
            action("Accounts Balances")
            {
                ApplicationArea = Basic;
                Caption = 'Accounts Balances';
                Image = "Report";
                RunObject = Report UnknownReport51516277;
            }
            action("Generate Dormant Accounts")
            {
                ApplicationArea = Basic;
                Caption = 'Generate Dormant Accounts';
                Image = "Report";
                RunObject = Report UnknownReport51516278;
            }
            action("Loans Register")
            {
                ApplicationArea = Basic;
                Caption = 'Loans Register';
                Image = "Report";
                RunObject = Report UnknownReport51516227;
            }
            action("Cashier Report")
            {
                ApplicationArea = Basic;
                Caption = 'Cashier Report';
                Image = "Report";
                Promoted = true;
                RunObject = Report "Loan Appraisal Posted";
            }
        }
        area(embedding)
        {
            action("Chart of Accounts")
            {
                ApplicationArea = Basic;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
            }
            action(Vendors)
            {
                ApplicationArea = Basic;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
            }
            action(Balance)
            {
                ApplicationArea = Basic;
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Vendor List";
                RunPageView = where("Balance (LCY)"=filter(<>0));
            }
            action("Purchase Orders")
            {
                ApplicationArea = Basic;
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
            }
            action(Budgets)
            {
                ApplicationArea = Basic;
                Caption = 'Budgets';
                RunObject = Page "G/L Budget Names";
            }
            action("Bank Accounts")
            {
                ApplicationArea = Basic;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
            }
            action("Tax Statements")
            {
                ApplicationArea = Basic;
                Caption = 'Tax Statements';
                RunObject = Page "VAT Statement Names";
            }
            action(Items)
            {
                ApplicationArea = Basic;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
            }
            action(Customers)
            {
                ApplicationArea = Basic;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
            }
            action(Action13)
            {
                ApplicationArea = Basic;
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Customer List";
                RunPageView = where("Balance (LCY)"=filter(<>0));
            }
            action("Sales Orders")
            {
                ApplicationArea = Basic;
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
            }
            action(Reminders)
            {
                ApplicationArea = Basic;
                Caption = 'Reminders';
                Image = Reminder;
                RunObject = Page "Reminder List";
            }
            action("Finance Charge Memos")
            {
                ApplicationArea = Basic;
                Caption = 'Finance Charge Memos';
                Image = FinChargeMemo;
                RunObject = Page "Finance Charge Memo List";
            }
            action("Incoming Documents")
            {
                ApplicationArea = Basic;
                Caption = 'Incoming Documents';
                Image = Documents;
                RunObject = Page "Incoming Documents";
            }
        }
        area(sections)
        {
            group("Account Opening")
            {
                Caption = 'Account Opening';
                Image = Journals;
                action("Accounts Application List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Accounts Application List';
                    RunObject = Page "HR Medical Scheme Members Card";
                }
                action("Accounts Application History")
                {
                    ApplicationArea = Basic;
                    Caption = 'Accounts Application History';
                    RunObject = Page "HR Medical Scheme Members List";
                }
            }
            group("Accounts Holders")
            {
                Caption = 'Accounts Holders';
                Image = Journals;
                action("Member Accounts List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Accounts List';
                    RunObject = Page "HR Emp Transfer List";
                }
            }
            group(Banking)
            {
                Caption = 'Banking';
                Image = FixedAssets;
                action("Cashier Transactions")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cashier Transactions';
                    RunObject = Page "Hr ApprovedAsset Transfer List";
                }
                action("Cashier Transactions Authorisation")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cashier Transactions Authorisation';
                    RunObject = Page "Hr Asset Transfer List";
                }
                action("ATM Log Entries")
                {
                    ApplicationArea = Basic;
                    Caption = 'ATM Log Entries';
                    RunObject = Page "Pension Processing Header";
                }
                action("ATM Transactions")
                {
                    ApplicationArea = Basic;
                    Caption = 'ATM Transactions';
                    RunObject = Page "Cheque Transactions Card.";
                }
                action("EFT List")
                {
                    ApplicationArea = Basic;
                    Caption = 'EFT List';
                    RunObject = Page "Payroll Employee Card.";
                }
                action("Petty Cash")
                {
                    ApplicationArea = Basic;
                    Caption = 'Petty Cash';
                    RunObject = Page "Guarantorship Sub List";
                }
                action("Posted Petty Cash")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Petty Cash';
                    RunObject = Page "Processed Guarantor Sub List";
                }
                action("Funds Transfer")
                {
                    ApplicationArea = Basic;
                    Caption = 'Funds Transfer';
                    RunObject = Page "Funds Transfer List";
                }
                action("Receipts list-BOSA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Receipts list-BOSA';
                    RunObject = Page UnknownPage51516241;
                }
                action("Posted BOSA Receipts List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted BOSA Receipts List';
                    RunObject = Page "HR Appraisal Agreement HD";
                }
                action("ATM Cards Application")
                {
                    ApplicationArea = Basic;
                    Caption = 'ATM Cards Application';
                    RunObject = Page "Payroll General Setup.";
                }
                action("Bank Account List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Account List';
                    RunObject = Page "Bank Account List";
                }
                action("GENERAL RECEIPTS")
                {
                    ApplicationArea = Basic;
                    Caption = 'GENERAL RECEIPTS';
                    RunObject = Page "Receipt Header List";
                }
            }
            group("Treasury & Teller Mgt")
            {
                Caption = 'Treasury & Teller Mgt';
                action("Treasury List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Treasury List';
                    RunObject = Page "Membership App card 2";
                }
                action("Teller List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Teller List';
                    RunObject = Page "HR Medical Claims List-posted";
                }
                action("Teller & Treasury Transactions")
                {
                    ApplicationArea = Basic;
                    Caption = 'Teller & Treasury Transactions';
                    RunObject = Page "Hr Leave Planner Lines";
                }
            }
            group("Credit Processing")
            {
                Caption = 'Credit Processing';
                Image = FixedAssets;
                action("Fosa Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fosa Loans';
                    RunObject = Page "Payroll NHIF Setup.";
                }
                action("All Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'All Loans';
                    RunObject = Page "Employee Common Activities";
                }
                action("Loans Disbursement Batch")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Disbursement Batch';
                    RunObject = Page "HR Setup Card";
                }
                action("Posted Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Loans';
                    RunObject = Page "HR Job Applications Card";
                }
                action("Posted Batches")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Batches';
                    RunObject = Page UnknownPage51516257;
                }
            }
            group("Cheque Management")
            {
                Caption = 'Cheque Management';
                action("Banking Cheque Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Banking Cheque Schedule';
                    RunObject = Page "Payroll Earnings List.";
                }
                action("Bankers Cheque Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bankers Cheque Schedule';
                    RunObject = Page "HR Leave Family Groups List";
                }
                action("Bankers Cheque Register")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bankers Cheque Register';
                    RunObject = Page "Payroll Earnings Card.";
                }
            }
            group("Periodic Activities")
            {
                Caption = 'Periodic Activities';
                Image = Administration;
                action("Standing Orders  List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Standing Orders  List';
                    Image = Currency;
                    RunObject = Page "HR Leave Planner Card";
                }
                action("Standing Order Register")
                {
                    ApplicationArea = Basic;
                    Caption = 'Standing Order Register';
                    Image = AccountingPeriods;
                    RunObject = Page "Hr Leave Planner List";
                }
                action("Salaries Buffer")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaries Buffer';
                    RunObject = Page "Pension Processing List";
                }
                action("Deposits Tier Setup")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposits Tier Setup';
                    RunObject = Page "HR Employees Supervisee";
                }
            }
            group("FOSA Setups")
            {
                Caption = 'FOSA Setups';
                action("Account Types List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Types List';
                    Image = BankAccount;
                    RunObject = Page "Payroll Employee Assignments.";
                }
                action("FOSA Charges")
                {
                    ApplicationArea = Basic;
                    Caption = 'FOSA Charges';
                    Image = DepositSlip;
                    RunObject = Page "Cheque Transactions Card";
                }
                action("Transaction Type  List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction Type  List';
                    RunObject = Page "prPayroll Periods";
                }
                action("Supervisor Approvals Levels")
                {
                    ApplicationArea = Basic;
                    Caption = 'Supervisor Approvals Levels';
                    RunObject = Page UnknownPage51516329;
                }
                action("ATM Charges")
                {
                    ApplicationArea = Basic;
                    Caption = 'ATM Charges';
                    RunObject = Page UnknownPage51516330;
                }
                action("Status Change Permisions")
                {
                    ApplicationArea = Basic;
                    Caption = 'Status Change Permisions';
                    RunObject = Page "Fixed Deposit Acc. List";
                }
                action("Account Details-editable")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Details-editable';
                    RunObject = Page "Member Account Signatory Card";
                }
                action("User Branch Set Up")
                {
                    ApplicationArea = Basic;
                    Caption = 'User Branch Set Up';
                    RunObject = Page "Cheque Truncation Card";
                }
            }
        }
    }
}

