#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516080 "Accounting Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                part(Control99; "Finance Performance")
                {
                    Visible = false;
                }
                part(Control1902304208; "Account Manager Activities")
                {
                }
                part(Control1907692008; "My Customers")
                {
                }
            }
            group(Control1900724708)
            {
                part(Control103; "Trailing Sales Orders Chart")
                {
                    Visible = false;
                }
                part(Control106; "My Job Queue")
                {
                    Visible = false;
                }
                part(Control100; "Cash Flow Forecast Chart")
                {
                }
                part(Control1902476008; "My Vendors")
                {
                }
                part(Control108; "Report Inbox Part")
                {
                }
                part(Control1903012608; "Copy Profile")
                {
                }
                systempart(Control1901377608; MyNotes)
                {
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("POST MONTHLY INTEREST")
            {
                ApplicationArea = Basic;
                Caption = 'POST MONTHLY INTEREST';
                RunObject = Report "loan aging default new";
            }
            action("&G/L Trial Balance")
            {
                ApplicationArea = Basic;
                Caption = '&G/L Trial Balance';
                Image = "Report";
                //Report10022;
            }
            action("Chart of Accounts")
            {
                ApplicationArea = Basic;
                Caption = 'Chart of Accounts';
                Image = "Report";
                //Report10002;
            }
            action("&Bank Detail Trial Balance")
            {
                ApplicationArea = Basic;
                Caption = '&Bank Detail Trial Balance';
                Image = "Report";
                RunObject = Report "Bank Acc. - Detail Trial Bal.";
            }
            action("Account Schedule Layout")
            {
                ApplicationArea = Basic;
                Caption = 'Account Schedule Layout';
                Image = "Report";
                //Report10000;
            }
            action("&Account Schedule")
            {
                ApplicationArea = Basic;
                Caption = '&Account Schedule';
                Image = "Report";
                RunObject = Report "Account Schedule";
            }
            action("Account Balances by GIFI Code")
            {
                ApplicationArea = Basic;
                Caption = 'Account Balances by GIFI Code';
                Image = "Report";
                //Report10004;
            }
            action(Budget)
            {
                ApplicationArea = Basic;
                Caption = 'Budget';
                Image = "Report";
                //Report10001;
            }
            action("Trial Bala&nce/Budget")
            {
                ApplicationArea = Basic;
                Caption = 'Trial Bala&nce/Budget';
                Image = "Report";
                RunObject = Report "Trial Balance/Budget";
            }
            action("Trial Bala&nce, Spread Periods")
            {
                ApplicationArea = Basic;
                Caption = 'Trial Bala&nce, Spread Periods';
                Image = "Report";
                //Report10026;
            }
            action("Trial Balance, per Global Dim.")
            {
                ApplicationArea = Basic;
                Caption = 'Trial Balance, per Global Dim.';
                Image = "Report";
                //Report10023;
            }
            action("Trial Balance, Spread G. Dim.")
            {
                ApplicationArea = Basic;
                Caption = 'Trial Balance, Spread G. Dim.';
                Image = "Report";
                //Report10025;
            }
            action("Trial Balance Detail/Summary")
            {
                ApplicationArea = Basic;
                Caption = 'Trial Balance Detail/Summary';
                Image = "Report";
                //Report10021;
            }
            action("&Fiscal Year Balance")
            {
                ApplicationArea = Basic;
                Caption = '&Fiscal Year Balance';
                Image = "Report";
                RunObject = Report "Fiscal Year Balance";
            }
            action("Balance Comp. - Prev. Y&ear")
            {
                ApplicationArea = Basic;
                Caption = 'Balance Comp. - Prev. Y&ear';
                Image = "Report";
                RunObject = Report "Balance Comp. - Prev. Year";
            }
            action("&Closing Trial Balance")
            {
                ApplicationArea = Basic;
                Caption = '&Closing Trial Balance';
                Image = "Report";
                //Report10003;
            }
            action("Consol. Trial Balance")
            {
                ApplicationArea = Basic;
                Caption = 'Consol. Trial Balance';
                Image = "Report";
                //Report10007;
            }
            separator(Action49)
            {
            }
            action("Cash Flow Date List")
            {
                ApplicationArea = Basic;
                Caption = 'Cash Flow Date List';
                Image = "Report";
                RunObject = Report "Cash Flow Date List";
            }
            separator(Action115)
            {
            }
            action("Aged Accounts &Receivable")
            {
                ApplicationArea = Basic;
                Caption = 'Aged Accounts &Receivable';
                Image = "Report";
                //Report10040;
            }
            action("Aged Accounts Pa&yable")
            {
                ApplicationArea = Basic;
                Caption = 'Aged Accounts Pa&yable';
                Image = "Report";
                //Report10085;
            }
            action("Projected Cash Receipts")
            {
                ApplicationArea = Basic;
                Caption = 'Projected Cash Receipts';
                Image = "Report";
                //Report10057;
            }
            action("Cash Requirem. by Due Date")
            {
                ApplicationArea = Basic;
                Caption = 'Cash Requirem. by Due Date';
                Image = "Report";
                //Report10088;
            }
            action("Projected Cash Payments")
            {
                ApplicationArea = Basic;
                Caption = 'Projected Cash Payments';
                Image = PaymentForecast;
                //Report10098;
            }
            action("Reconcile Cust. and Vend. Accs")
            {
                ApplicationArea = Basic;
                Caption = 'Reconcile Cust. and Vend. Accs';
                Image = "Report";
                RunObject = Report "Reconcile Cust. and Vend. Accs";
            }
            action("Daily Invoicing Report")
            {
                ApplicationArea = Basic;
                Caption = 'Daily Invoicing Report';
                Image = "Report";
                //Report10050;
            }
            action("Bank Account - Reconcile")
            {
                ApplicationArea = Basic;
                Caption = 'Bank Account - Reconcile';
                Image = "Report";
                //Report10409;
            }
            separator(Action53)
            {
            }
            separator(Action1480110)
            {
                Caption = 'Sales Tax';
                IsHeader = true;
            }
            action("Sales Tax Details")
            {
                ApplicationArea = Basic;
                Caption = 'Sales Tax Details';
                Image = "Report";
                //Report10323;
            }
            action("Sales Tax Groups")
            {
                ApplicationArea = Basic;
                Caption = 'Sales Tax Groups';
                Image = "Report";
                //Report10324;
            }
            action("Sales Tax Jurisdictions")
            {
                ApplicationArea = Basic;
                Caption = 'Sales Tax Jurisdictions';
                Image = "Report";
                //Report10325;
            }
            action("Sales Tax Areas")
            {
                ApplicationArea = Basic;
                Caption = 'Sales Tax Areas';
                Image = "Report";
                //Report10321;
            }
            action("Sales Tax Detail by Area")
            {
                ApplicationArea = Basic;
                Caption = 'Sales Tax Detail by Area';
                Image = "Report";
                //Report10322;
            }
            action("Sales Taxes Collected")
            {
                ApplicationArea = Basic;
                Caption = 'Sales Taxes Collected';
                Image = "Report";
                RunObject = Report "Sales Taxes Collected";
            }
            action("Tax Statement")
            {
                ApplicationArea = Basic;
                Caption = 'Tax Statement';
                Image = "Report";
                RunObject = Report "VAT Statement";
            }
            action("VAT - VIES Declaration Tax Aut&h")
            {
                ApplicationArea = Basic;
                Caption = 'VAT - VIES Declaration Tax Aut&h';
                Image = "Report";
                RunObject = Report "VAT- VIES Declaration Tax Auth";
            }
            action("VAT - VIES Declaration Dis&k")
            {
                ApplicationArea = Basic;
                Caption = 'VAT - VIES Declaration Dis&k';
                Image = "Report";
                RunObject = Report "VAT- VIES Declaration Disk";
            }
            action("EC Sales &List")
            {
                ApplicationArea = Basic;
                Caption = 'EC Sales &List';
                Image = "Report";
                RunObject = Report "EC Sales List";
            }
            separator(Action60)
            {
            }
            action("&Intrastat - Checklist")
            {
                ApplicationArea = Basic;
                Caption = '&Intrastat - Checklist';
                Image = "Report";
                RunObject = Report "Intrastat - Checklist";
            }
            action("Intrastat - For&m")
            {
                ApplicationArea = Basic;
                Caption = 'Intrastat - For&m';
                Image = "Report";
                RunObject = Report "Intrastat - Form";
            }
            separator(Action4)
            {
            }
            action("Cost Accounting P/L Statement")
            {
                ApplicationArea = Basic;
                Caption = 'Cost Accounting P/L Statement';
                Image = "Report";
                RunObject = Report "Cost Acctg. Statement";
            }
            action("CA P/L Statement per Period")
            {
                ApplicationArea = Basic;
                Caption = 'CA P/L Statement per Period';
                Image = "Report";
                RunObject = Report "Cost Acctg. Stmt. per Period";
            }
            action("CA P/L Statement with Budget")
            {
                ApplicationArea = Basic;
                Caption = 'CA P/L Statement with Budget';
                Image = "Report";
                RunObject = Report "Cost Acctg. Statement/Budget";
            }
            action("Cost Accounting Analysis")
            {
                ApplicationArea = Basic;
                Caption = 'Cost Accounting Analysis';
                Image = "Report";
                RunObject = Report "Cost Acctg. Analysis";
            }
            separator(Action1400022)
            {
            }
            action("Outstanding Purch. Order Aging")
            {
                ApplicationArea = Basic;
                Caption = 'Outstanding Purch. Order Aging';
                Image = "Report";
                //Report10095;
            }
            action("Inventory Valuation")
            {
                ApplicationArea = Basic;
                Caption = 'Inventory Valuation';
                Image = "Report";
                //Report10139;
            }
            action("Item Turnover")
            {
                ApplicationArea = Basic;
                Caption = 'Item Turnover';
                Image = "Report";
                //Report10146;
            }
        }
        area(embedding)
        {
            action(Action2)
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
            group(Journals)
            {
                Caption = 'Journals';
                Image = Journals;
                action("Purchase Journals")
                {
                    ApplicationArea = Basic;
                    Caption = 'Purchase Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type" = const(Purchases), Recurring = const(false));
                }
                action("Sales Journals")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sales Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type" = const(Sales), Recurring = const(false));
                }
                action("Cash Receipt Journals")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type" = const("Cash Receipts"), Recurring = const(false));
                }
                action("Payment Journals")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type" = const(Payments), Recurring = const(false));
                }
                action("IC General Journals")
                {
                    ApplicationArea = Basic;
                    Caption = 'IC General Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type" = const(Intercompany), Recurring = const(false));
                }
                action("General Journals")
                {
                    ApplicationArea = Basic;
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type" = const(General), Recurring = const(false));
                }
                action("Intrastat Journals")
                {
                    ApplicationArea = Basic;
                    Caption = 'Intrastat Journals';
                    Image = "Report";
                    RunObject = Page "Intrastat Jnl. Batches";
                }
            }
            group("Fixed Assets")
            {
                Caption = 'Fixed Assets';
                Image = FixedAssets;
                action(Action17)
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Asset List";
                }
                action(Insurance)
                {
                    ApplicationArea = Basic;
                    Caption = 'Insurance';
                    RunObject = Page "Insurance List";
                }
                action("Fixed Assets G/L Journals")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Assets G/L Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type" = const(Assets), Recurring = const(false));
                }
                action("Fixed Assets Journals")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Assets Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = where(Recurring = const(false));
                }
                action("Fixed Assets Reclass. Journals")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Assets Reclass. Journals';
                    RunObject = Page "FA Reclass. Journal Batches";
                }
                action("Insurance Journals")
                {
                    ApplicationArea = Basic;
                    Caption = 'Insurance Journals';
                    RunObject = Page "Insurance Journal Batches";
                }
                action("<Action3>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recurring General Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type" = const(General), Recurring = const(true));
                }
                action("Recurring Fixed Asset Journals")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recurring Fixed Asset Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = where(Recurring = const(true));
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                action("Purchase Invoice")
                {
                    ApplicationArea = Basic;
                    Caption = 'Purchase Invoice';
                    RunObject = Page "Purchase Invoices";
                }
            }
            group("Payments & Loan Disbursement")
            {
                Caption = 'Payments & Loan Disbursement';
                action("New Payment Vouchers")
                {
                    ApplicationArea = Basic;
                    Caption = 'New Payment Vouchers';
                    RunObject = Page "Payment List.";
                    RunPageView = where(Status = const(New));
                }
                action("Pending Payment  Vouchers List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Pending Payment  Vouchers List';
                    RunObject = Page "Payment List.";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("Approved Payment Vouchers")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Payment Vouchers';
                    RunObject = Page "Payment List.";
                    RunPageView = where(Status = const(Approved));
                }
                action("New Petty Cash Vouchers List")
                {
                    ApplicationArea = Basic;
                    Caption = 'New Petty Cash Vouchers List';
                    RunObject = Page "Guarantorship Sub List";
                    //   RunPageView = where(Status=const(New));
                }
                action("Pending Petty Cash Vouchers List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Pending Petty Cash Vouchers List';
                    RunObject = Page "Guarantorship Sub List";
                    //  RunPageView = where(Status=const("Pending Approval"));
                }
                action("Approved Petty Cash Vouchers List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Petty Cash Vouchers List';
                    RunObject = Page "Guarantorship Sub List";
                    RunPageView = where(Status = const(Approved));
                }
                action("Loan Disbursement Batch")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Disbursement Batch';
                    RunObject = Page "HR Setup Card";
                }
                action("BOSA Transfer")
                {
                    ApplicationArea = Basic;
                    Caption = 'BOSA Transfer';
                    RunObject = Page "Apply Member Entries";
                }
                action(checkoff)
                {
                    ApplicationArea = Basic;
                    Caption = 'checkoff';
                    RunObject = Page "Member List";
                }
                action(members)
                {
                    ApplicationArea = Basic;
                    Caption = 'members';
                    RunObject = Page "HR Disciplinary Cases";
                }
                action("Loans Register")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Register';
                    RunObject = Page "Employee Common Activities";
                }
                action("Loan List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan List';
                    RunObject = Page "Employee Common Activities";
                }
            }
            group("Receipts & Bank Transfer")
            {
                Caption = 'Receipts & Bank Transfer';
                Image = Journals;
                action("Receipts List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Receipts List';
                    RunObject = Page "Receipt Header List";
                }
                action("Bank Transfer List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Transfer List';
                    RunObject = Page "Funds Transfer List";
                }
            }
            group(setups)
            {
                Caption = 'setups';
                action("Payment Types")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment Types';
                    RunObject = Page "Payment Types List";
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Payment Vouchers List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Payment Vouchers List';
                    RunObject = Page "Posted Payment Vouchers List";
                }
                action("Posted Petty Cash Vouchers")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Petty Cash Vouchers';
                    RunObject = Page "Processed Guarantor Sub List";
                }
                action("Posted Receipt List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Receipt List';
                    RunObject = Page "Posted Receipt Header List";
                }
                action(" Posted IBT  List")
                {
                    ApplicationArea = Basic;
                    Caption = ' Posted IBT  List';
                    RunObject = Page "Posred Funds Transfer List";
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                }
                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                }
                action("Issued Reminders")
                {
                    ApplicationArea = Basic;
                    Caption = 'Issued Reminders';
                    Image = OrderReminder;
                    RunObject = Page "Issued Reminder List";
                }
                action("Issued Fin. Charge Memos")
                {
                    ApplicationArea = Basic;
                    Caption = 'Issued Fin. Charge Memos';
                    Image = PostedMemo;
                    RunObject = Page "Issued Fin. Charge Memo List";
                }
                action("G/L Registers")
                {
                    ApplicationArea = Basic;
                    Caption = 'G/L Registers';
                    Image = GLRegisters;
                    RunObject = Page "G/L Registers";
                }
                action("Cost Accounting Registers")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cost Accounting Registers';
                    RunObject = Page "Cost Registers";
                }
                action("Cost Accounting Budget Registers")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cost Accounting Budget Registers';
                    RunObject = Page "Cost Budget Registers";
                }
                action("Posted Deposits")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Deposits';
                    Image = PostedDeposit;
                    //nPage10147;
                }
                action("Posted Bank Recs.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Bank Recs.';
                    //nPage10129;
                }
                action("Bank Statements")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Statements';
                    RunObject = Page "Bank Account Statement List";
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                Image = Administration;
                action(Currencies)
                {
                    ApplicationArea = Basic;
                    Caption = 'Currencies';
                    Image = Currency;
                    RunObject = Page Currencies;
                }
                action("Accounting Periods")
                {
                    ApplicationArea = Basic;
                    Caption = 'Accounting Periods';
                    Image = AccountingPeriods;
                    RunObject = Page "Accounting Periods";
                }
                action("Number Series")
                {
                    ApplicationArea = Basic;
                    Caption = 'Number Series';
                    RunObject = Page "No. Series";
                }
                action("Analysis Views")
                {
                    ApplicationArea = Basic;
                    Caption = 'Analysis Views';
                    RunObject = Page "Analysis View List";
                }
                action("Account Schedules")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Schedules';
                    RunObject = Page "Account Schedule Names";
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page Dimensions;
                }
                action("Bank Account Posting Groups")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Account Posting Groups';
                    RunObject = Page "Bank Account Posting Groups";
                }
                action("IRS 1099 Form-Box")
                {
                    ApplicationArea = Basic;
                    Caption = 'IRS 1099 Form-Box';
                    Image = "1099Form";
                    //nPage10015;
                }
                action("GIFI Codes")
                {
                    ApplicationArea = Basic;
                    Caption = 'GIFI Codes';
                    //nPage10017;
                }
                action("Tax Areas")
                {
                    ApplicationArea = Basic;
                    Caption = 'Tax Areas';
                    RunObject = Page "Tax Area List";
                }
                action("Tax Jurisdictions")
                {
                    ApplicationArea = Basic;
                    Caption = 'Tax Jurisdictions';
                    RunObject = Page "Tax Jurisdictions";
                }
                action("Tax Groups")
                {
                    ApplicationArea = Basic;
                    Caption = 'Tax Groups';
                    RunObject = Page "Tax Groups";
                }
                action("Tax Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Tax Details';
                    RunObject = Page "Tax Details";
                }
                action("Tax  Business Posting Groups")
                {
                    ApplicationArea = Basic;
                    Caption = 'Tax  Business Posting Groups';
                    RunObject = Page "VAT Business Posting Groups";
                }
                action("Tax Product Posting Groups")
                {
                    ApplicationArea = Basic;
                    Caption = 'Tax Product Posting Groups';
                    RunObject = Page "VAT Product Posting Groups";
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
                    //nPage36646;
                }
                action("Bank Rec.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Rec.';
                    RunObject = Page "Bank Acc. Reconciliation List";
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
            action("Import Salaries")
            {
                ApplicationArea = Basic;
                Caption = 'Import Salaries';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = XMLport "Import Salaries";
            }
            action("Salaries Buffer")
            {
                ApplicationArea = Basic;
                Caption = 'Salaries Buffer';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Pension Processing List";
            }
            separator(Action64)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("Cas&h Receipt Journal")
            {
                ApplicationArea = Basic;
                Caption = 'Cas&h Receipt Journal';
                Image = CashReceiptJournal;
                RunObject = Page "Cash Receipt Journal";
            }
            action("Pa&yment Journal")
            {
                ApplicationArea = Basic;
                Caption = 'Pa&yment Journal';
                Image = PaymentJournal;
                RunObject = Page "Payment Journal";
            }
            action("Purchase Journal")
            {
                ApplicationArea = Basic;
                Caption = 'Purchase Journal';
                Image = Journals;
                RunObject = Page "Purchase Journal";
            }
            action(Action1480100)
            {
                ApplicationArea = Basic;
                Caption = 'Deposit';
                Image = DepositSlip;
                //nPage10140;
            }
            separator(Action67)
            {
            }
            action("Analysis &Views")
            {
                ApplicationArea = Basic;
                Caption = 'Analysis &Views';
                Image = AnalysisView;
                RunObject = Page "Analysis View List";
            }
            action("Analysis by &Dimensions")
            {
                ApplicationArea = Basic;
                Caption = 'Analysis by &Dimensions';
                Image = AnalysisViewDimension;
                RunObject = Page "Analysis by Dimensions";
            }
            action("Calculate Deprec&iation")
            {
                ApplicationArea = Basic;
                Caption = 'Calculate Deprec&iation';
                Ellipsis = true;
                Image = CalculateDepreciation;
                RunObject = Report "Calculate Depreciation";
            }
            action("Import Co&nsolidation from Database")
            {
                ApplicationArea = Basic;
                Caption = 'Import Co&nsolidation from Database';
                Ellipsis = true;
                Image = ImportDatabase;
                RunObject = Report "Import Consolidation from DB";
            }
            action("Bank Account R&econciliation")
            {
                ApplicationArea = Basic;
                Caption = 'Bank Account R&econciliation';
                Image = BankAccountRec;
                RunObject = Page "Bank Acc. Reconciliation List";
            }
            action("Adjust E&xchange Rates")
            {
                ApplicationArea = Basic;
                Caption = 'Adjust E&xchange Rates';
                Ellipsis = true;
                Image = AdjustExchangeRates;
                RunObject = Report "Adjust Exchange Rates";
            }
            action("P&ost Inventory Cost to G/L")
            {
                ApplicationArea = Basic;
                Caption = 'P&ost Inventory Cost to G/L';
                Image = PostInventoryToGL;
                RunObject = Report "Post Inventory Cost to G/L";
            }
            separator(Action97)
            {
            }
            action("C&reate Reminders")
            {
                ApplicationArea = Basic;
                Caption = 'C&reate Reminders';
                Ellipsis = true;
                Image = CreateReminders;
                RunObject = Report "Create Reminders";
            }
            action("Create Finance Charge &Memos")
            {
                ApplicationArea = Basic;
                Caption = 'Create Finance Charge &Memos';
                Ellipsis = true;
                Image = CreateFinanceChargememo;
                RunObject = Report "Create Finance Charge Memos";
            }
            separator(Action73)
            {
            }
            action("Intrastat &Journal")
            {
                ApplicationArea = Basic;
                Caption = 'Intrastat &Journal';
                Image = Journal;
                RunObject = Page "Intrastat Jnl. Batches";
            }
            action("Calc. and Pos&t Tax Settlement")
            {
                ApplicationArea = Basic;
                Caption = 'Calc. and Pos&t Tax Settlement';
                Image = SettleOpenTransactions;
                RunObject = Report "Calc. and Post VAT Settlement";
            }
            separator(Action80)
            {
                Caption = 'Administration';
                IsHeader = true;
            }
            action("General &Ledger Setup")
            {
                ApplicationArea = Basic;
                Caption = 'General &Ledger Setup';
                Image = Setup;
                RunObject = Page "General Ledger Setup";
            }
            action("&Sales && Receivables Setup")
            {
                ApplicationArea = Basic;
                Caption = '&Sales && Receivables Setup';
                Image = Setup;
                RunObject = Page "Sales & Receivables Setup";
            }
            action("&Purchases && Payables Setup")
            {
                ApplicationArea = Basic;
                Caption = '&Purchases && Payables Setup';
                Image = Setup;
                RunObject = Page "Purchases & Payables Setup";
            }
            action("&Fixed Asset Setup")
            {
                ApplicationArea = Basic;
                Caption = '&Fixed Asset Setup';
                Image = Setup;
                RunObject = Page "Fixed Asset Setup";
            }
            action("Cash Flow Setup")
            {
                ApplicationArea = Basic;
                Caption = 'Cash Flow Setup';
                Image = CashFlowSetup;
                RunObject = Page "Cash Flow Setup";
            }
            action("Cost Accounting Setup")
            {
                ApplicationArea = Basic;
                Caption = 'Cost Accounting Setup';
                Image = CostAccountingSetup;
                RunObject = Page "Cost Accounting Setup";
            }
            separator(Action89)
            {
                Caption = 'History';
                IsHeader = true;
            }
            action("Navi&gate")
            {
                ApplicationArea = Basic;
                Caption = 'Navi&gate';
                Image = Navigate;
                RunObject = Page Navigate;
            }
            action("Export GIFI Info. to Excel")
            {
                ApplicationArea = Basic;
                Caption = 'Export GIFI Info. to Excel';
                Image = ExportToExcel;
                //Report10005;
            }
        }
    }
}

