#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516079 "Credit Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control1000000018; "Member List")
            {
            }
            group(Control1000000015)
            {
            }
            part(Control1000000001; "Copy Profile")
            {
            }
            systempart(Control1000000000; MyNotes)
            {
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Member Balances")
            {
                ApplicationArea = Basic;
                Caption = 'Member Balances';
                Image = "Report";
                // RunObject = Report "Member Accounts  balances";
            }
            action("Member Statement")
            {
                ApplicationArea = Basic;
                Caption = 'Member Statement';
                Image = "Report";
                RunObject = Report "Member Account Statement-New";
            }
            action("Member Guarantors")
            {
                ApplicationArea = Basic;
                Caption = 'Member Guarantors';
                Image = "Report";
                RunObject = Report "Members Guarantors";
            }
            action("Credit Loans Register-CFC")
            {
                ApplicationArea = Basic;
                Caption = 'Credit Loans Register-CFC';
                Image = Register;
                RunObject = Report "Loans Register  CIC";
            }
            action("Credit Loans Register-Board")
            {
                ApplicationArea = Basic;
                Caption = 'Credit Loans Register-Board';
                Image = Register;
                RunObject = Report "Update E-Loan Qualification";
            }
            action("Members Loan Register")
            {
                ApplicationArea = Basic;
                Caption = 'Members Loan Register';
                Image = "Report";
                RunObject = Report "Loans Register";
            }
            action("Loans Guaranteed")
            {
                ApplicationArea = Basic;
                Caption = 'Loans Guaranteed';
                Image = "Report";
                RunObject = Report "Member Loans Guaranteed";
            }
            action("Loans Repayment Schedule")
            {
                ApplicationArea = Basic;
                Caption = 'Loans Repayment Schedule';
                Image = "Report";
                RunObject = Report "Loans Repayment Schedule";
            }
            action("Loans Batch Schedule")
            {
                ApplicationArea = Basic;
                Caption = 'Loans Batch Schedule';
                Image = "Report";
                RunObject = Report "Loans Batch Schedule";
            }
            action("Loans Appraisal")
            {
                ApplicationArea = Basic;
                Caption = 'Loans Appraisal';
                Image = "Report";
                RunObject = Report "Loan Appraisal Draft";
            }
            action("Loan Balances")
            {
                ApplicationArea = Basic;
                Caption = 'Loan Balances';
                Image = "Report";
                RunObject = Report "Loan Balances FOSA";
            }
            action("Loans Defaulter Aging")
            {
                ApplicationArea = Basic;
                Caption = 'Loans Defaulter Aging';
                Image = "Report";
                RunObject = Report "Loans Defaulter Aging";
            }
            separator(Action1000000009)
            {
                Caption = 'Dividends';
            }
            action("Prorated Dividends Processing")
            {
                ApplicationArea = Basic;
                Caption = 'Prorated Dividends Processing';
                Image = "Report";
                RunObject = Report "Dividend Processing-Prorated";
            }
            action("Flat Rate Dividends Processing")
            {
                ApplicationArea = Basic;
                Caption = 'Flat Rate Dividends Processing';
                Image = "Report";
                RunObject = Report "Dividend Processing-Flat Rate";
            }
            action("Dividends Register")
            {
                ApplicationArea = Basic;
                Caption = 'Dividends Register';
                Image = "Report";
                RunObject = Report "Dividend Register";
            }
            action("Dividends Progression")
            {
                ApplicationArea = Basic;
                Caption = 'Dividends Progression';
                Image = "Report";
                RunObject = Report "Dividends Progressionslip";
            }
            separator(Action1000000019)
            {
            }
            action("Checkoff Main")
            {
                ApplicationArea = Basic;
                Caption = 'Checkoff Main';
                RunObject = Report "Data Sheet Main";
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
                RunPageView = where("Balance (LCY)" = filter(<> 0));
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
                RunPageView = where("Balance (LCY)" = filter(<> 0));
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
            group(Members)
            {
                Caption = 'Members';
                Image = Journals;
                action("Member List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member List';
                    RunObject = Page "Member List";
                }
                action("Member List Editable")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member List Editable';
                    RunObject = Page "Member List-Editable";
                }
            }
            group(Loans)
            {
                Caption = 'Loans';
                Image = Journals;
                action("Open Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Open Loans';
                    RunObject = Page "Loans Applied  List";
                    RunPageView = where("Approval Status" = const(Open));
                }
                action("Pending Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Pending Loans';
                    RunObject = Page "Loans Applied  List";
                    RunPageView = where("Approval Status" = const(Pending));
                }
                action("Approved Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Loans';
                    Image = Journals;
                    RunObject = Page "Loans Applied  List";
                    RunPageView = where("Approval Status" = const(Approved));
                }
                action("Issued Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Issued Loans';
                    Image = Journals;
                    RunObject = Page "Loans Posted List";
                }
                action("Rejected Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Rejected Loans';
                    RunObject = Page "Loans Applied  List";
                    RunPageView = where("Approval Status" = const(Rejected));
                }
            }
            group("Credit Processing")
            {
                Caption = 'Credit Processing';
                Image = FixedAssets;
                action("All Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'All Loans';
                    RunObject = Page "Loans Applied  List";
                }
                action("Loans Disbursement Batch")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Disbursement Batch';
                    RunObject = Page "Loans Disbursment Batch List";
                }
            }
            group("Processed Credits")
            {
                Caption = 'Processed Credits';
                action("Posted Credit List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Credit List';
                    RunObject = Page "Loans Posted List";
                }
                action("Posted Loan Batch")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Loan Batch';
                    RunObject = Page "Posted Loan Batch - List";
                }
            }
            group("Checkoff Processing-Distributed")
            {
                Caption = 'Checkoff Processing-Distributed';
                action("Check-Off Distributed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Check-Off Distributed';
                    RunObject = Page "Checkoff Processing-D List";
                }
                action("Posted Checkoff")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Checkoff';
                    RunObject = Page "Posted Bosa Rcpt List-Checkof";
                }
                action("Employer Checkoff Remitance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Checkoff Remitance';
                    RunObject = Page "Bosa Rcpt List-Checkof";
                }
                action("Posted Employer Checkoff")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Employer Checkoff';
                    RunObject = Page "Posted Bosa Rcpt List-Checkof";
                }
                action("Paybill Processing")
                {
                    ApplicationArea = Basic;
                    Caption = 'Paybill Processing';
                    RunObject = Page "Paybill Processing List";
                }
                action("Posted Paybill Processing")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Paybill Processing';
                    RunObject = Page "Posted Paybill Processing Lis";
                }
                action("Interest Due Periods")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest Due Periods';
                    RunObject = Page "Interest Due Periods";
                }
                action("Checkoff Advice Datasheet")
                {
                    ApplicationArea = Basic;
                    Caption = 'Checkoff Advice Datasheet';
                    RunObject = Page "Data Sheet Main";
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                Image = Administration;
                action("Loans Products Setup")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Products Setup';
                    Image = AccountingPeriods;
                    RunObject = Page "Loan Products Setup List";
                }
                action(Action41)
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest Due Periods';
                    RunObject = Page "Interest Due Periods";
                }
                action("Deposits Tier Setup")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposits Tier Setup';
                    RunObject = Page "Deposits tier Setups";
                }
            }
            group("Cash Management")
            {
                Caption = 'Cash Management';
                action(Action1400017)
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page "Bank Account List";
                }
                action(Deposit)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposit';
                    Image = DepositSlip;
                    //  RunObject = Page UnknownPage36646;
                }
                action("Bank Rec.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Rec.';
                    RunObject = Page "Bank Acc. Reconciliation List";
                }
            }
            group("Document Approvals")
            {
                Caption = 'Document Approvals';
                action("Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approval Request';
                    Image = Approvals;
                    RunObject = Page "Requests to Approve";
                }
            }
        }
        area(creation)
        {
            action("Sales &Credit Memo")
            {
                ApplicationArea = Basic;
                Caption = 'Sales &Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Credit Memo";
                RunPageMode = Create;
            }
            action("P&urchase Credit Memo")
            {
                ApplicationArea = Basic;
                Caption = 'P&urchase Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Credit Memo";
                RunPageMode = Create;
            }
            action("Bank Account Reconciliation")
            {
                ApplicationArea = Basic;
                Caption = 'Bank Account Reconciliation';
                Image = BankAccountRec;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Bank Acc. Reconciliation List";
                RunPageMode = Create;
            }
        }
        area(processing)
        {
            action("Sacco General Setup")
            {
                ApplicationArea = Basic;
                Caption = 'Sacco General Setup';
                Image = Setup;
                //   RunObject = Page UnknownPage51516271;
            }
            action("Sacco No Series")
            {
                ApplicationArea = Basic;
                Caption = 'Sacco No Series';
                Image = Setup;
                RunObject = Page "HR Employee Course of Study";
            }
            action("Import Members")
            {
                ApplicationArea = Basic;
                Caption = 'Import Members';
                Image = Import;
                RunObject = XMLport "Import Checkoff Lines(Block)";
            }
            action("Import FOSA Accounts")
            {
                ApplicationArea = Basic;
                Caption = 'Import FOSA Accounts';
                Image = Import;
                RunObject = XMLport "Import Fosa Accounts";
            }
            action("Import Checkoff Distributed")
            {
                ApplicationArea = Basic;
                Caption = 'Import Checkoff Distributed';
                Ellipsis = true;
                Image = Import;
                RunObject = XMLport "Import Checkoff Distributed";
            }
            action("Import Checkoff Block")
            {
                ApplicationArea = Basic;
                Caption = 'Import Checkoff Block';
                Ellipsis = true;
                Image = Import;
                RunObject = XMLport "Import Checkoff Block";
            }
            action("Import Salaries")
            {
                ApplicationArea = Basic;
                Caption = 'Import Salaries';
                Ellipsis = true;
                Image = Import;
                RunObject = XMLport "Import Salaries";
            }
        }
    }
}

