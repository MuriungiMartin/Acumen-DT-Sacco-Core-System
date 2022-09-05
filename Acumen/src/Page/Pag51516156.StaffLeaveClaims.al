#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516156 "Staff Leave Claims"
{
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Staff Claims Header";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Date)
                {
                    ApplicationArea = Basic;
                    Editable = DateEditable;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Function Name"; "Function Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Center Name"; "Budget Center Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff No/Name';
                }
                field(Payee; Payee)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = "Currency CodeEditable";
                }
                field("Paying Bank Account"; "Paying Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Purpose; Purpose)
                {
                    ApplicationArea = Basic;
                    Caption = 'Claim Description';
                }
                field(Cashier; Cashier)
                {
                    ApplicationArea = Basic;
                    Caption = 'Requestor ID';
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Net Amount"; "Total Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Net Amount LCY"; "Total Net Amount LCY")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Release Date"; "Payment Release Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                    Editable = "Payment Release DateEditable";
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Pay Mode"; "Pay Mode")
                {
                    ApplicationArea = Basic;
                    Editable = "Pay ModeEditable";
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque/EFT No.';
                    Editable = "Cheque No.Editable";
                }
            }
            part(PVLines; "Staff Leave Claim Lines")
            {
                SubPageLink = No = field("No.");
            }
            systempart(Control1000000004; MyNotes)
            {
            }
            systempart(Control1000000003; Links)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Post Payment and Print")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Payment and Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = true;

                    trigger OnAction()
                    begin
                        "Payment Release Date" := Today;
                        if Status <> Status::Approved then begin
                            Error('The Staff Claim Must be Fully Approved');
                        end;

                        CheckImprestRequiredItems;
                        PostImprest;

                        Reset;
                        SetFilter("No.", "No.");
                        Report.Run(55882, true, true, Rec);
                        Reset;
                    end;
                }
                action("Post Payment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Payment';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = true;

                    trigger OnAction()
                    begin
                        if Usersetup.Get(UserId) then begin
                            "Payment Release Date" := Today;
                            if Usersetup."Post Staff Grants" = false then
                                Error('You dont have permissions to Post Claim! ')
                        end;
                        if Status <> Status::Approved then begin
                            Error('The Staff Claim Must be Fully Approved');
                        end;
                        CheckImprestRequiredItems;
                        PostImprest;
                    end;
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit WorkflowIntegration;
                    begin
                        //IF NOT RecordLinkCheck(Rec) THEN
                        //ERROR('You have no documents attached hence cant proceed');
                        TestField(Status, Status::Pending);
                        if not LinesExists then
                            Error('There are no Lines created for this Document');

                        if not AllFieldsEntered then
                            Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                        //Ensure No Items That should be committed that are not
                        if LinesCommitmentStatus then
                            Error('There are some lines that have not been committed');

                        //Release the Imprest for Approval
                        if ApprovalMgt.CheckStaffClaimsApprovalsWorkflowEnabled(Rec) then;
                        ApprovalMgt.OnSendStaffClaimsForApproval(Rec);
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit WorkflowIntegration;
                    begin
                        TestField(Status, Status::"Pending Approval");
                        if ApprovalMgt.CheckStaffClaimsApprovalsWorkflowEnabled(Rec) then;
                        ApprovalMgt.OnCancelStaffClaimsApprovalRequest(Rec);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::StaffClaims;
                        ApprovalEntries.Setfilters(51516010, DocumentType, "No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Check Budgetary Availability")
                {
                    ApplicationArea = Basic;
                    Caption = 'Check Budgetary Availability';
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        BCSetup: Record "Budgetary Control Setup";
                    begin

                        BCSetup.Get;
                        if not BCSetup.Mandatory then
                            exit;

                        if not LinesExists then
                            Error('There are no Lines created for this Document');

                        if not AllFieldsEntered then
                            Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                        //First Check whether other lines are already committed.
                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."document type"::StaffClaim);
                        Commitments.SetRange(Commitments."Document No.", "No.");
                        if Commitments.Find('-') then begin
                            if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then begin exit end;
                            Commitments.Reset;
                            Commitments.SetRange(Commitments."Document Type", Commitments."document type"::StaffClaim);
                            Commitments.SetRange(Commitments."Document No.", "No.");
                            Commitments.DeleteAll;
                        end;

                        //CheckBudgetAvail.CheckStaffClaim(Rec);
                    end;
                }
                action("Cancel Budget Commitment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Budget Commitment';
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Do you Wish to Cancel the Commitment entries for this document', false) = false then begin exit end;

                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."document type"::StaffClaim);
                        Commitments.SetRange(Commitments."Document No.", "No.");
                        Commitments.DeleteAll;

                        PayLine.Reset;
                        PayLine.SetRange(PayLine.No, "No.");
                        if PayLine.Find('-') then begin
                            repeat
                                PayLine.Committed := false;
                                PayLine.Modify;
                            until PayLine.Next = 0;
                        end;
                    end;
                }
                action("Print/Preview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Print/Preview';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Status <> Status::Approved then
                            //ERROR('You can only print after the document is Approved');
                        Reset;
                        SetFilter("No.", "No.");
                        Report.Run(51516332, true, true, Rec);
                        Reset;
                    end;
                }
                action("ReOpen Document")
                {
                    ApplicationArea = Basic;
                    Caption = 'ReOpen Document';
                    Image = ReOpen;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if not Confirm('Are you sure you want to ReOpen the Document?', false) then exit;
                        Status := Status::Pending;
                    end;
                }
                action("Cancel Document")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text000: label 'Are you sure you want to Cancel this Document?';
                        Text001: label 'You have selected not to Cancel this Document';
                    begin


                        //TESTFIELD(Status,Status::Approved);
                        if (Status = Status::Approved) or (Status = Status::Pending) then begin
                            if Confirm(Text000, true) then begin
                                //Post Committment Reversals
                                Doc_Type := Doc_type::Imprest;
                                BudgetControl.ReverseEntries(Doc_Type, "No.");
                                Status := Status::Cancelled;
                                Modify;
                            end else
                                Error(Text001);

                        end;
                    end;
                }
                action("Upload Document")
                {
                    ApplicationArea = Basic;
                    Caption = 'Upload Document';
                    Image = Upload;

                    trigger OnAction()
                    var
                        vartest: Variant;
                        Links: Record "Record Link";
                    begin
                        if Upload('Upload file', 'C:\', 'Text file(*.txt)|*.txt|PDF file(*.pdf)|*.pdf|ALL file(*)|*', 'Doc.txt', vartest) then begin
                            /*  Links.INIT;
                              Links."Link ID":=0;
                            //"No."  Links."Record ID":=;
                              Links.URL1:='\\128.0.1.74:\tsl\'+USERID;
                              Links.INSERT(TRUE);
                            */
                            Rec.AddLink('\\128.0.1.74:\' + UserId);
                            Message('File Uploaded Successfully')
                        end
                        else
                            Message('File Uploaded Successfully');

                    end;
                }
                action(Download)
                {
                    ApplicationArea = Basic;
                    Caption = 'Download';

                    trigger OnAction()
                    var
                        vartest: Variant;
                    begin
                        Download('Upload file', 'C:\', 'Text file(*.txt)|*.txt|PDF file(*.pdf)|*.pdf|ALL file(*)|*', 'Doc.txt', vartest)
                    end;
                }
                action("Create Payment Voucher")
                {
                    ApplicationArea = Basic;
                    Image = CreateForm;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        PVHeadEr: Record "Payment Header.";
                        STClaimLines: Record "Staff Claim Lines";
                        PaymentLines: Record "Payment Line.";
                        EntryNo: Integer;
                        ApprovalEntry: Record "Approval Entry";
                        AppEntry: Record "Approval Entry";
                    begin
                        CheckImprestRequiredItems;
                        PVHeadEr.Reset;
                        PVHeadEr.SetRange(PVHeadEr."No.", "No.");
                        PVHeadEr.SetFilter(PVHeadEr.Status, '<>%1', PVHeadEr.Status::Cancelled);
                        if PVHeadEr.Find('-') = true then
                            Error('Payment Voucher has already been created for Staff Claim, the payment voucher no is %1', PVHeadEr."No.");

                        TestField(Status, Status::Approved);
                        TestField("Pay Mode");
                        CheckIfIsAboveCashLimit;
                        TestField("Paying Bank Account");

                        if not Confirm('Are you sure you want to create a Payment Voucher for %1', false, "No.") then
                            Error('Creation of Payment Voucher Stopped') else begin

                            PVHeadEr.Init;
                            PVHeadEr.Date := Date;
                            PVHeadEr.Payee := Payee;
                            PVHeadEr."On Behalf Of" := "On Behalf Of";
                            PVHeadEr.Cashier := Cashier;
                            PVHeadEr.Status := Status;
                            if "Pay Mode" = "pay mode"::Cash then
                                PVHeadEr."Payment Type" := PVHeadEr."payment type"::"Petty Cash"
                            else
                                if "Pay Mode" = "pay mode"::Cheque then
                                    PVHeadEr."Payment Type" := PVHeadEr."payment type"::Normal;
                            PVHeadEr."Payment Mode" := "Pay Mode";
                            PVHeadEr."Bank Account" := "Paying Bank Account";
                            PVHeadEr.Validate("Bank Account");
                            PVHeadEr."Cheque No" := "Cheque No.";
                            PVHeadEr."Global Dimension 1 Code" := "Global Dimension 1 Code";
                            PVHeadEr.Validate("Global Dimension 1 Code");
                            PVHeadEr."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
                            PVHeadEr.Validate("Global Dimension 2 Code");
                            PVHeadEr."Responsibility Center" := "Responsibility Center";
                            PVHeadEr."Payment Release Date" := "Payment Release Date";
                            PVHeadEr."Shortcut Dimension 3 Code" := "Shortcut Dimension 3 Code";
                            PVHeadEr.Validate("Shortcut Dimension 3 Code");
                            PVHeadEr."Shortcut Dimension 4 Code" := "Shortcut Dimension 4 Code";
                            PVHeadEr.Validate("Shortcut Dimension 4 Code");
                            PVHeadEr."Payment Description" := CopyStr(Purpose, 1, 50);
                            PVHeadEr."No." := "No.";
                            PVHeadEr.Insert(true);

                            STClaimLines.Reset;
                            STClaimLines.SetRange(STClaimLines.No, "No.");
                            if STClaimLines.Find('-') then begin


                                /*
                                PaymentLines.RESET;
                                IF PaymentLines.FIND('+') THEN BEGIN
                                EntryNo:=PaymentLines."Line No.";
                                END;
                                */


                                EntryNo := 1;

                                repeat

                                    PaymentLines.Init;
                                    PaymentLines."Line No." := 0;
                                    //MESSAGE('%1',EntryNo);
                                    PaymentLines.No := PVHeadEr."No.";
                                    PaymentLines."Account Type" := STClaimLines."account type"::Customer;
                                    PaymentLines."Account No." := STClaimLines."Account No:";
                                    PaymentLines."Account Name" := STClaimLines."Account Name";//Payee;
                                    PaymentLines.Type := STClaimLines."Advance Type";
                                    PaymentLines.Amount := STClaimLines.Amount;
                                    PaymentLines.Validate(Amount);
                                    PaymentLines."Net Amount" := STClaimLines.Amount;
                                    PaymentLines."Global Dimension 1 Code" := STClaimLines."Global Dimension 1 Code";
                                    PaymentLines.Validate("Global Dimension 1 Code");
                                    PaymentLines."Shortcut Dimension 2 Code" := STClaimLines."Shortcut Dimension 2 Code";
                                    PaymentLines.Validate("Shortcut Dimension 2 Code");
                                    PaymentLines."Shortcut Dimension 3 Code" := STClaimLines."Shortcut Dimension 3 Code";
                                    PaymentLines.Validate("Shortcut Dimension 3 Code");
                                    PaymentLines."Shortcut Dimension 4 Code" := STClaimLines."Shortcut Dimension 4 Code";
                                    PaymentLines.Validate("Shortcut Dimension 4 Code");
                                    PaymentLines.Insert(true);

                                until STClaimLines.Next = 0;
                            end;
                            /*
                            ApprovalEntry.RESET;
                            ApprovalEntry.SETRANGE(ApprovalEntry."Document No.","No.");
                            IF ApprovalEntry.FIND('-') THEN BEGIN
                            REPEAT
                            AppEntry.INIT;
                            AppEntry."Table ID":=55904;
                            AppEntry."Document Type":=AppEntry."Document Type"::"Payment Voucher";
                            AppEntry."Document No.":=PVHeadEr."No.";
                            AppEntry."Sequence No.":=ApprovalEntry."Sequence No.";
                            AppEntry."Approval Code":=ApprovalEntry."Approval Code";
                            AppEntry."Sender ID":=ApprovalEntry."Sender ID";
                            AppEntry."Salespers./Purch. Code":=ApprovalEntry."Salespers./Purch. Code";
                            AppEntry."Approver ID":=ApprovalEntry."Approver ID";
                            AppEntry.Status:=ApprovalEntry.Status;
                            AppEntry."Date-Time Sent for Approval":=ApprovalEntry."Date-Time Sent for Approval";
                            AppEntry."Last Date-Time Modified":=ApprovalEntry."Last Date-Time Modified";
                            AppEntry."Last Modified By ID":=ApprovalEntry."Last Modified By ID";
                            AppEntry."Due Date":=ApprovalEntry."Due Date";
                            AppEntry.Amount:=ApprovalEntry.Amount;
                            AppEntry."Amount (LCY)":=ApprovalEntry."Amount (LCY)";
                            AppEntry."Currency Code":=ApprovalEntry."Currency Code";
                            AppEntry."Approval Type":=ApprovalEntry."Approval Type";
                            AppEntry."Limit Type":=ApprovalEntry."Limit Type";
                            AppEntry."Available Credit Limit (LCY)":=ApprovalEntry."Available Credit Limit (LCY)";
                            AppEntry.Comment:=ApprovalEntry.Comment;
                            AppEntry.INSERT;
                            UNTIL ApprovalEntry.NEXT=0
                            END;
                            */
                        end;

                        Posted := true;
                        "Date Posted" := Today;
                        "Time Posted" := Time;
                        "Posted By" := UserId;
                        Modify;


                        if "Pay Mode" = "pay mode"::Cash then
                            Page.Run(55902, PVHeadEr)
                        else
                            Page.Run(55905, PVHeadEr);

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //OnAfterGetCurrRecord;
        CurrPageUpdate;
    end;

    trigger OnInit()
    begin
        "Currency CodeEditable" := true;
        DateEditable := true;
        ShortcutDimension2CodeEditable := true;
        GlobalDimension1CodeEditable := true;
        "Cheque No.Editable" := true;
        "Pay ModeEditable" := true;
        "Paying Bank AccountEditable" := true;
        "Payment Release DateEditable" := true;
        "Payment Release Date" := Today;
        Date := Today;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        //check if the documenent has been added while another one is still pending
        TravReqHeader.Reset;
        //TravAccHeader.SETRANGE(SaleHeader."Document Type",SaleHeader."Document Type"::"Cash Sale");
        TravReqHeader.SetRange(TravReqHeader.Cashier, UserId);
        TravReqHeader.SetRange(TravReqHeader.Status, Status::Pending);
        /*
            IF TravReqHeader.COUNT>0 THEN
              BEGIN
               ERROR('There are still some pending document(s) on your account. Please list & select the pending document to use.  ');
              END;
              */
        //*********************************END ****************************************//


        "Payment Type" := "payment type"::Imprest;
        "Account Type" := "account type"::Customer;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Responsibility Center" := UserMgt.GetPurchasesFilter();
        //Add dimensions if set by default here
        "Global Dimension 1 Code" := UserMgt.GetSetDimensions(UserId, 1);
        Validate("Global Dimension 1 Code");
        "Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(UserId, 2);
        Validate("Shortcut Dimension 2 Code");
        "Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(UserId, 3);
        Validate("Shortcut Dimension 3 Code");
        "Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(UserId, 4);
        Validate("Shortcut Dimension 4 Code");
        UpdateControls;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        if UserMgt.GetPurchasesFilter() <> '' then begin
            FilterGroup(2);
            SetRange("Responsibility Center", UserMgt.GetPurchasesFilter());
            FilterGroup(0);
        end;
        UpdateControls;
    end;

    var
        PayLine: Record "Staff Claim Lines";
        PVUsers: Record "CshMgt PV Steps Users";
        strFilter: Text[250];
        IntC: Integer;
        IntCount: Integer;
        Payments: Record "Payment Header.";
        RecPayTypes: Record "Receipts and Payment Types";
        TarriffCodes: Record "Tariff Codes";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Funds User Setup";
        LineNo: Integer;
        Temp: Record "Funds User Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        strText: Text[100];
        PVHead: Record "Payment Header.";
        BankAcc: Record "Bank Account";
        CheckBudgetAvail: Codeunit "Budgetary Control";
        Commitments: Record Committment;
        UserMgt: Codeunit "User Setup Management BR";
        JournlPosted: Codeunit "Journal Post Successful";
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash;
        BudgetControl: Codeunit "Budgetary Control";
        TravReqHeader: Record "Staff Claims Header";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        [InDataSet]
        "Payment Release DateEditable": Boolean;
        [InDataSet]
        "Paying Bank AccountEditable": Boolean;
        [InDataSet]
        "Pay ModeEditable": Boolean;
        [InDataSet]
        "Cheque No.Editable": Boolean;
        [InDataSet]
        GlobalDimension1CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension2CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension3CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension4CodeEditable: Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        "Currency CodeEditable": Boolean;
        StatusEditable: Boolean;
        Usersetup: Record "User Setup";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Staff Claims ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,"Jobs Mgmt","Emp Req","Training Mgmt",Reinbursement,"Leave Plan","Emp Trans","Ass Trans","FD Processing","Guar Substitution";


    procedure LinesCommitmentStatus() Exists: Boolean
    var
        BCsetup: Record "Budgetary Control Setup";
    begin
        if BCsetup.Get() then begin
            if not BCsetup.Mandatory then begin
                Exists := false;
                exit;
            end;
        end else begin
            Exists := false;
            exit;
        end;
        Exists := false;
        PayLine.Reset;
        PayLine.SetRange(PayLine.No, "No.");
        PayLine.SetRange(PayLine.Committed, false);
        PayLine.SetRange(PayLine."Budgetary Control A/C", true);
        if PayLine.Find('-') then
            Exists := true;
    end;


    procedure PostImprest()
    begin

        if Temp.Get(UserId) then begin
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            GenJnlLine.DeleteAll;
        end;

        //CREDIT BANK
        LineNo := LineNo + 1000;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := "Payment Release Date";
        GenJnlLine."Document No." := "No.";
        GenJnlLine."External Document No." := "Cheque No.";
        GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
        GenJnlLine."Account No." := "Paying Bank Account";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine.Description := Purpose;
        CalcFields("Total Net Amount");
        GenJnlLine."Credit Amount" := "Total Net Amount";
        GenJnlLine.Validate(GenJnlLine."Credit Amount");
        //Added for Currency Codes
        GenJnlLine."Currency Code" := "Currency Code";
        GenJnlLine.Validate("Currency Code");
        GenJnlLine."Currency Factor" := "Currency Factor";
        GenJnlLine.Validate("Currency Factor");
        GenJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");

        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;



        //DEBIT RESPECTIVE G/L ACCOUNT(S)
        PayLine.Reset;
        PayLine.SetRange(PayLine.No, "No.");
        if PayLine.Find('-') then begin
            repeat
                LineNo := LineNo + 1000;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Posting Date" := "Payment Release Date";
                //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Invoice;
                GenJnlLine."Document No." := "No.";
                GenJnlLine."External Document No." := "Cheque No.";
                GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
                GenJnlLine."Account No." := PayLine."Account No:";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine.Description := Purpose;
                GenJnlLine."Debit Amount" := PayLine.Amount;
                GenJnlLine.Validate(GenJnlLine."Debit Amount");
                //Added for Currency Codes
                GenJnlLine."Currency Code" := "Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine."Currency Factor" := "Currency Factor";
                GenJnlLine.Validate("Currency Factor");
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");

                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;

            until PayLine.Next = 0
        end;


        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        //Adjust Gen Jnl Exchange Rate Rounding Balances
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust Gen Jnl Exchange Rate Rounding Balances

        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnlLine);

        //Post:= FALSE;
        //Post:=JournlPosted.PostedSuccessfully();
        //IF Post THEN BEGIN
        Posted := true;
        "Date Posted" := Today;
        "Time Posted" := Time;
        "Posted By" := UserId;
        Status := Status::Posted;
        Modify;
        //END;
    end;


    procedure CheckImprestRequiredItems()
    begin

        TestField("Payment Release Date");
        TestField("Paying Bank Account");
        TestField("Account No.");
        TestField("Account Type", "account type"::Customer);

        if Posted then begin
            Error('The Document has already been posted');
        end;

        TestField(Status, Status::Approved);

        /*Check if the user has selected all the relevant fields*/

        Temp.Get(UserId);
        JTemplate := Temp."Claim Template";
        JBatch := Temp."Claim  Batch";

        if JTemplate = '' then begin
            Error('Ensure the Staff Claims Template is set up in Cash Office Setup');
        end;

        if JBatch = '' then begin
            Error('Ensure the Staff Claims Batch is set up in the Cash Office Setup')
        end;

        if not LinesExists then
            Error('There are no Lines created for this Document');

    end;


    procedure UpdateControls()
    begin
        if Status <> Status::Approved then begin
            "Payment Release DateEditable" := false;
            "Paying Bank AccountEditable" := false;
            "Pay ModeEditable" := false;
            //CurrForm."Currency Code".EDITABLE:=FALSE;
            "Cheque No.Editable" := false;
            //CurrPage.UpdateControls();
        end else begin
            "Payment Release DateEditable" := true;
            "Paying Bank AccountEditable" := true;
            "Pay ModeEditable" := true;
            "Cheque No.Editable" := true;
            //CurrForm."Currency Code".EDITABLE:=TRUE;
            //CurrPage.UpdateControls();
        end;

        if Status = Status::Pending then begin
            GlobalDimension1CodeEditable := true;
            ShortcutDimension2CodeEditable := true;
            //CurrForm.Payee.EDITABLE:=TRUE;
            ShortcutDimension3CodeEditable := true;
            ShortcutDimension4CodeEditable := true;
            DateEditable := true;
            //CurrForm."Account No.".EDITABLE:=TRUE;
            "Currency CodeEditable" := true;
            //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
            //CurrPage.UpdateControls();
        end else begin
            GlobalDimension1CodeEditable := false;
            ShortcutDimension2CodeEditable := false;
            //CurrForm.Payee.EDITABLE:=FALSE;
            ShortcutDimension3CodeEditable := false;
            ShortcutDimension4CodeEditable := false;
            DateEditable := false;
            //CurrForm."Account No.".EDITABLE:=FALSE;
            "Currency CodeEditable" := false;
            //CurrForm."Paying Bank Account".EDITABLE:=TRUE;
            //CurrPage.UpdateControls();
        end
    end;


    procedure LinesExists(): Boolean
    var
        PayLines: Record "Staff Claim Lines";
    begin
        HasLines := false;
        PayLines.Reset;
        PayLines.SetRange(PayLines.No, "No.");
        if PayLines.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;


    procedure AllFieldsEntered(): Boolean
    var
        PayLines: Record "Staff Claim Lines";
    begin
        AllKeyFieldsEntered := true;
        PayLines.Reset;
        PayLines.SetRange(PayLines.No, "No.");
        if PayLines.Find('-') then begin
            repeat
                if (PayLines."Account No:" = '') or (PayLines.Amount <= 0) then
                    AllKeyFieldsEntered := false;
            until PayLines.Next = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControls();
    end;


    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        CurrPage.Update;
    end;


    procedure CheckIfIsAboveCashLimit()
    var
        CashOfficeSetup: Record "Cash Office Setup";
    begin
        //if above cash limit then pay mode must be cheque
        if "Pay Mode" <> "pay mode"::Cash then exit;
        CalcFields("Total Net Amount");
        CashOfficeSetup.Get;
        if "Total Net Amount" >= CashOfficeSetup."Minimum Cheque Creation Amount" then
            Error('The specified amount %1 should be created as a cheque.', "Total Net Amount");
    end;


    procedure RecordLinkCheck(StaffClaimsHeader: Record "Staff Claims Header") RecordLnkExist: Boolean
    var
        objRecordLnk: Record "Record Link";
        TableCaption: RecordID;
        objRecord_Link: RecordRef;
    begin
        objRecord_Link.GetTable(StaffClaimsHeader);
        TableCaption := objRecord_Link.RecordId;
        objRecordLnk.Reset;
        objRecordLnk.SetRange(objRecordLnk."Record ID", TableCaption);
        if objRecordLnk.Find('-') then exit(true) else exit(false);
    end;
}

