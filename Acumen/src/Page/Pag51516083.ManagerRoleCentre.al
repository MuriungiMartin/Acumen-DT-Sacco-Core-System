#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516083 "Manager Role Centre"
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
            action("Customer Care logs")
            {
                ApplicationArea = Basic;
                Caption = 'Customer Care logs';
                Image = "Report";
                RunObject = Report "Treasury Transfer.";
            }
            action("Member Statement")
            {
                ApplicationArea = Basic;
                Caption = 'Member Statement';
                Image = "Report";
                RunObject = Report "Member Account Statement-New";
            }
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
                action("Membership Withdrawal List")
                {
                    ApplicationArea = Basic;
                    RunObject = Page "Membership Exit List";
                }
                action("Posted Member Withdrawal List")
                {
                    ApplicationArea = Basic;
                    RunObject = Page "Posted Member Withdrawal List";
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
                action("Approved Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Loans';
                    RunObject = Page "Loans Application List(Approv)";
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
                action("Cheque Book Application List")
                {
                    ApplicationArea = Basic;
                    RunObject = Page "Cheque Book Application List";
                }
                action("Funds Transfer List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Funds Transfer List';
                    RunObject = Page "Funds Transfer List";
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
                action("Medical Claims")
                {
                    ApplicationArea = Basic;
                    Caption = 'Medical Claims';
                    RunObject = Page "HR Medical Claims List";
                }
                action("Store Requisitions")
                {
                    ApplicationArea = Basic;
                    Caption = 'Store Requisitions';
                    RunObject = Page "Open Store Requisitions List";
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
                action("Posted Cashier Transactions")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Cashier Transactions';
                    RunObject = Page "Posted Cashier Transactions";
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
                    // RunObject = Page UnknownPage50006;
                }
                action("Standing Orders - List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Standing Orders - List';
                    RunObject = Page "Standing Orders - List";
                }
                action("Standing Orders - List Approved")
                {
                    ApplicationArea = Basic;
                    Caption = 'Standing Orders - List Approved';
                    RunObject = Page "Standing Orders - List Approve";
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
            group("Customer Care")
            {
                Caption = 'Customer Care';
                action("Customer Care List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Customer Care List';
                    RunObject = Page "Customer Care List";
                }
                action("Customer Care Log List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Customer Care Log List';
                    RunObject = Page "Customer Care Log List";
                }
            }
        }
        area(processing)
        {
            action("Cashier Trans Authorisations")
            {
                ApplicationArea = Basic;
                Caption = 'Cashier Trans Authorisations';
                RunObject = Page "Cashier Trans Authorisations";
            }
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

