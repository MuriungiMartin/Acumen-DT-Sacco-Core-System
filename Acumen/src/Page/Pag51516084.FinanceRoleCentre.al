#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516084 "Finance Role Centre"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control1000000041;"SO Processor Activities")
            {
                Caption = 'Finance Activities';
            }
            group(Control1000000015)
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
            action("Member Statement")
            {
                ApplicationArea = Basic;
                Caption = 'Member Statement';
                Image = "Report";
                RunObject = Report "Member Account Statement-New";
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
            action("Bank Account List")
            {
                ApplicationArea = Basic;
                Caption = 'Bank Account List';
                RunObject = Page "Bank Account List";
            }
            action("Bank Acc. Reconciliation List")
            {
                ApplicationArea = Basic;
                Caption = 'Bank Acc. Reconciliation List';
                RunObject = Page "Bank Acc. Reconciliation List";
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
                action("memeber list editable")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member List-Editable';
                    RunObject = Page "Member List-Editable";
                }
            }
            group("Members Regiatration")
            {
                Caption = 'Members Regiatration';
                Image = Journals;
                action(jjj)
                {
                    ApplicationArea = Basic;
                    Caption = 'Individual/Joint Application list';
                    RunObject = Page "Membership Application List";
                }
                action(eee)
                {
                    ApplicationArea = Basic;
                    Caption = 'Group/Corporate Applications List';
                    RunObject = Page "Group/Corporate Applic List";
                }
                action("51516554")
                {
                    ApplicationArea = Basic;
                    Caption = 'Church  Applications List';
                    RunObject = Page "Loans  List- pending approval";
                }
                action("Membership Application List")
                {
                    ApplicationArea = Basic;
                    RunObject = Page "Membership Application List";
                }
                action("Group/Corporate Applic List")
                {
                    ApplicationArea = Basic;
                    RunObject = Page "Group/Corporate Applic List";
                }
            }
            group("FOSA Membership")
            {
                Caption = 'FOSA Membership';
                Image = Journals;
                action("51516430")
                {
                    ApplicationArea = Basic;
                    Caption = 'FOSA Product Applications';
                    RunObject = Page "FOSA Accounts Applications";
                }
                action("51516435")
                {
                    ApplicationArea = Basic;
                    Caption = 'Savings product list';
                    RunObject = Page "FOSA Accounts Details Master";
                }
                action("Fixed Deposit Acc. List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Deposit Acc. List';
                    RunObject = Page "Fixed Deposit Acc. List";
                }
            }
            group("Teller/Tresury Management")
            {
                Caption = 'Teller/Tresury Management';
                Image = Journals;
                action(Treasury)
                {
                    ApplicationArea = Basic;
                    RunObject = Page "Treasury List";
                }
                action("Teller Till List")
                {
                    ApplicationArea = Basic;
                    RunObject = Page "Teller Till List";
                }
                action("Teller/Treasury Transactions")
                {
                    ApplicationArea = Basic;
                    RunObject = Page "Teller & Treasury Trans List";
                }
            }
            group(Loans)
            {
                Caption = 'Loans';
                Image = Journals;
                action("Loans Applications BOSA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Applications BOSA';
                    RunObject = Page "Loans Applied  List";
                }
                action("Loans Applications FOSA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Applications FOSA';
                    RunObject = Page "Loan Application FOSA(New)";
                }
                action("Loans Disbursment Batch List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Disbursment Batch List';
                    RunObject = Page "Loans Disbursment Batch List";
                }
                action("Loan Trunch Disburesment List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Trunch Disburesment List';
                    RunObject = Page "Loan Trunch Disburesment List";
                }
                action("Loans Reschedule  List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Reschedule  List';
                    RunObject = Page "Sacco Transfer Card(pend)";
                }
                action("Posted Loans BOSA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Loans BOSA';
                    RunObject = Page "Loans Posted List";
                }
                action("Posted Loans FOSA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Loans FOSA';
                    RunObject = Page "Loan Application FOSA(Posted)";
                }
                action("Posted Loan Batch - List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Loan Batch - List';
                    RunObject = Page "Posted Loan Batch - List";
                }
            }
            group(Procurement)
            {
                Caption = 'Procurement';
                action("Item List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Item List';
                    RunObject = Page "Item List";
                }
                action(Suppliers)
                {
                    ApplicationArea = Basic;
                    Caption = 'Suppliers';
                    RunObject = Page "Vendor List";
                }
                action("Purchase Order")
                {
                    ApplicationArea = Basic;
                    Caption = 'Purchase Order';
                    RunObject = Page "Purchase Order List";
                }
                action("Purchase Invoices")
                {
                    ApplicationArea = Basic;
                    Caption = 'Purchase Invoices';
                    RunObject = Page "Purchase Invoices";
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                }
                action("Stores Order List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Stores Order List';
                    RunObject = Page "Stores Order List";
                }
                action("Purchase Order Archives")
                {
                    ApplicationArea = Basic;
                    Caption = 'Purchase Order Archives';
                    RunObject = Page "Purchase Order Archives";
                }
                action("Requisitions to Dispatch")
                {
                    ApplicationArea = Basic;
                    Caption = 'Requisitions to Dispatch';
                    RunObject = Page "Store Requisitions List-App";
                }
            }
            group("Common Requisitions")
            {
                Caption = 'Common Requisitions';
                Image = FixedAssets;
                action("Leave Application")
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Application';
                    RunObject = Page "HR Leave Applications List";
                }
                action("Imprest Requisition")
                {
                    ApplicationArea = Basic;
                    Caption = 'Imprest Requisition';
                    RunObject = Page "Imprest List";
                }
                action("Store Requisitions")
                {
                    ApplicationArea = Basic;
                    Caption = 'Store Requisitions';
                    RunObject = Page "Open Store Requisitions List";
                }
            }
            group("Payment Processes")
            {
                Caption = 'Payment Processes';
                action("Payment Voucher Payment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment Voucher Payment';
                    RunObject = Page "Payment Voucher List";
                }
                action("Petty Cash Payments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Petty Cash Payments';
                    RunObject = Page "Cash Payment List";
                }
                action("Funds Transfer List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Funds Transfer List';
                    RunObject = Page "Funds Transfer List";
                }
                action("Cheque Book Application List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque Book Application List';
                    RunObject = Page "Cheque Book Application List";
                }
                action("Salary Processing List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary Processing List';
                    RunObject = Page "Salary Processing List";
                }
            }
            group("Cashier Transactions")
            {
                Caption = 'Cashier Transactions';
                action("Cashier Transactions - List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cashier Transactions - List';
                    RunObject = Page "Cashier Transactions - List";
                }
                action("Sacco Transfer")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sacco Transfer List';
                    RunObject = Page "Internal Transfer List";
                }
                action("EFT List")
                {
                    ApplicationArea = Basic;
                    Caption = 'EFT List';
                    RunObject = Page "Bank Transfer List";
                }
                action("Paybill Processing List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Paybill Processing List';
                    RunObject = Page "Paybill Processing List";
                }
                action("Inhouse Cheque Clearing List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Inhouse Cheque Clearing List';
                    RunObject = Page UnknownPage50006;
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
        area(processing)
        {
            action("General Journals")
            {
                ApplicationArea = Basic;
                Caption = 'General Journals';
                Image = Journal;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "General Journal";
            }
            action("Payment &Journal")
            {
                ApplicationArea = Basic;
                Caption = 'Payment &Journal';
                Image = PaymentJournal;
                RunObject = Page "Payment Journal";
            }
            action("P&urchase Journal")
            {
                ApplicationArea = Basic;
                Caption = 'P&urchase Journal';
                Image = Journals;
                RunObject = Page "Purchase Journal";
            }
            separator(Action22)
            {
                Caption = 'Administration';
                IsHeader = true;
            }
            action("Import Sacco Jnl")
            {
                ApplicationArea = Basic;
                Caption = 'Import Sacco Jnl';
                Image = Allocate;
                RunObject = XMLport "Import Sacco Jnl";
            }
            action("Purchases && Payables &Setup")
            {
                ApplicationArea = Basic;
                Caption = 'Purchases && Payables &Setup';
                Image = Setup;
                RunObject = Page "Purchases & Payables Setup";
            }
            separator(Action20)
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
        }
    }
}

