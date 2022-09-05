#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516595 "Marketing Officer Role Centre"
{
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1000000012)
            {
                part("Member Processor"; "Membership Processor")
                {
                }
                group(Control1000000008)
                {
                }
                systempart(Control1000000007; Outlook)
                {
                }
            }
            group(Control1000000006)
            {
            }
            group(Control1000000005)
            {
                systempart(Control1000000004; MyNotes)
                {
                }
                group(Control1000000003)
                {
                }
                chartpart("S-MEMBER"; "S-MEMBER")
                {
                }
                group(Control1000000002)
                {
                }
                chartpart(BLN; BLN)
                {
                }
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
            separator(Action1000000048)
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
            separator(Action1000000043)
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
                    Caption = 'Self Employed Applicants';
                    RunObject = Page "Membership App Unemployed";
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
    }
}

