#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516847 "Funeral Expenses."
{
    SourceTable = "Funeral Expense Payment";

    layout
    {
        area(content)
        {
            group(General)
            {
            }
            field("No."; "No.")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Member No."; "Member No.")
            {
                ApplicationArea = Basic;
            }
            field("Member Name"; "Member Name")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Member ID No"; "Member ID No")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Member Status"; "Member Status")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Death Date"; "Death Date")
            {
                ApplicationArea = Basic;
            }
            field("Date Reported"; "Date Reported")
            {
                ApplicationArea = Basic;
            }
            field("Reported By"; "Reported By")
            {
                ApplicationArea = Basic;
            }
            field("Reporter ID No."; "Reporter ID No.")
            {
                ApplicationArea = Basic;
            }
            field("Reporter Mobile No"; "Reporter Mobile No")
            {
                ApplicationArea = Basic;
            }
            field("Reporter Address"; "Reporter Address")
            {
                ApplicationArea = Basic;
            }
            field("Relationship With Deceased"; "Relationship With Deceased")
            {
                ApplicationArea = Basic;
            }
            field("Received Burial Permit"; "Received Burial Permit")
            {
                ApplicationArea = Basic;
            }
            field("Mode Of Disbursement"; "Mode Of Disbursement")
            {
                ApplicationArea = Basic;
            }
            field("Paying Bank"; "Paying Bank")
            {
                ApplicationArea = Basic;
            }
            field("Received Letter From Chief"; "Received Letter From Chief")
            {
                ApplicationArea = Basic;
            }
            field(Posted; Posted)
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Date Posted"; "Date Posted")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Time Posted"; "Time Posted")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Posted By"; "Posted By")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field(Status; Status)
            {
                ApplicationArea = Basic;
                Editable = false;
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(ActionGroup1000000026)
            {
                action("Post Disbursement")
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = true;

                    trigger OnAction()
                    begin
                        /*CheckRequiredFields();
                        TESTFIELD(Status,Status::"2");
                        IF CONFIRM('Post Loan Disbursement Document No:'+FORMAT("PI Code")) THEN
                        //Check user exists and has posting rights
                        IF LoanUserSetup.GET(USERID) THEN BEGIN
                          LoanUserSetup.TESTFIELD(LoanUserSetup."Disbursement Journal Template");
                          LoanUserSetup.TESTFIELD(LoanUserSetup."Disbursement Journal Batch");
                          LoanManager.PostTrans("PI Code",LoanUserSetup."Disbursement Journal Template",LoanUserSetup."Disbursement Journal Batch");
                        END ELSE BEGIN
                          ERROR(Txt000,USERID);
                        END;
                        */

                    end;
                }
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = "Report";
                    ShortCutKey = 'Ctrl+F7';
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalMgt: Codeunit WorkflowIntegration;
                    begin
                        /*CheckRequiredFields();
                        TESTFIELD(Status,Status::"0");
                         IF ApprovalsMgmt.CheckLoanDisbursementApprovalsWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnSendLoanDisbursementForApproval(Rec); */

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit WorkflowIntegration;
                    begin
                    end;
                }
            }
        }
    }

    var
        LoanUserSetup: Record "Salary Step/Notch Transactions";
        LoanManager: Codeunit "POST ATM Transactions";
        Txt000: label 'User ID:%1 has not been setup for posting, Contact System Administrator';
        ApprovalsMgmt: Codeunit WorkflowIntegration;

    local procedure CheckRequiredFields()
    begin
        /*TESTFIELD("PI Code");
        TESTFIELD("PI Name");
        TESTFIELD("Colabotative Institution");
        TESTFIELD("PI Address");
        TESTFIELD("Amount to Disburse");
        TESTFIELD("Requested Amount");
        TESTFIELD("PI Telephone");
        TESTFIELD("Posting Date");
        TESTFIELD("Loan Disbursment Date");
        TESTFIELD("Repayment Start Date");
        TESTFIELD("Paying Bank");
        TESTFIELD("Paying Bank Name");
        TESTFIELD(Description);
        IF "Amount to Disburse">"Balance Outstanding" THEN
          ERROR('The Amount to Disburse:'+FORMAT("Amount to Disburse")+' cannot be more than the Loan Outstanding Balance:'+FORMAT("Balance Outstanding"));
          */

    end;
}

