#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516059 "Payment Request Header"
{
    // //Use if Cheque is to be Validated
    // Payments.RESET;
    // Payments.SETRANGE(Payments."No.","No.");
    // IF Payments.FINDFIRST THEN
    //   BEGIN
    //     IF Payments."Payment Mode"=Payments."Payment Mode"::Cheque THEN
    //       BEGIN
    //          IF STRLEN(Payments."Cheque No")<>6 THEN
    //           BEGIN
    //             ERROR ('Invalid Cheque Number Inserted');
    //           END;
    //       END;
    //   END;
    // **************************************************************************************
    // //Use if Bank Account should not be overdrawn
    // 
    // //get the source account balance from the database table
    // BankAcc.RESET;
    // BankAcc.SETRANGE(BankAcc."No.",Payment."Bank Account");
    // BankAcc.SETRANGE(BankAcc."Bank Type",BankAcc."Bank Type"::Cash);
    // IF BankAcc.FINDFIRST THEN
    //   BEGIN
    //     Payments.TESTFIELD(Payments.Date,TODAY);
    //     BankAcc.CALCFIELDS(BankAcc."Balance (LCY)");
    //     "Current Source A/C Bal.":=BankAcc."Balance (LCY)";
    //     IF ("Current Source A/C Bal."-Payment."Net Amount")<0 THEN
    //       BEGIN
    //         ERROR('The transaction will result in a negative balance in the BANK ACCOUNT.');
    //       END;
    //   END;

    Caption = 'Payment Request';
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Payment Header.";
    SourceTableView = where("Payment Type" = const(Express));

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Date; Date)
                {
                    ApplicationArea = Basic;
                    Editable = DateEditable;
                    Importance = Promoted;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = GlobalDimension1CodeEditable;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = ShortcutDimension2CodeEditable;
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                    Editable = ShortcutDimension3CodeEditable;
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {
                    ApplicationArea = Basic;
                    Editable = ShortcutDimension4CodeEditable;
                    Visible = false;
                }
                field("Payment Mode"; "Payment Mode")
                {
                    ApplicationArea = Basic;
                    Editable = PaymodeEditable;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = "Currency CodeEditable";
                    Visible = false;
                }
                field("Bank Account"; "Bank Account")
                {
                    ApplicationArea = Basic;
                    Editable = bankeditabl;
                    Visible = false;
                }
                field("Bank Account Name"; "Bank Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Payee; Payee)
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment to';
                    Editable = PayeeEditable;
                    Importance = Promoted;
                }
                field("On Behalf Of"; "On Behalf Of")
                {
                    ApplicationArea = Basic;
                    Editable = OnBehalfEditable;
                    Visible = false;
                }
                field("Payment Description"; "Payment Description")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Cheque Type"; "Cheque Type")
                {
                    ApplicationArea = Basic;
                    Editable = "Cheque TypeEditable";
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if "Cheque Type" = "cheque type"::"Computer Cheque" then
                            "Cheque No.Editable" := false
                        else
                            "Cheque No.Editable" := true;
                    end;
                }
                field("Currency Factor"; "Currency Factor")
                {
                    ApplicationArea = Basic;
                    Editable = "Invoice Currency CodeEditable";
                    Visible = false;
                }
                field(Cashier; Cashier)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("VAT Amount"; "VAT Amount")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("WithHolding Tax Amount"; "WithHolding Tax Amount")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Amount(LCY)"; "Amount(LCY)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Net Amount LCY';
                    Editable = false;
                }
                field("Cheque No"; "Cheque No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque/EFT No.';
                    Editable = "Cheque No.Editable";
                    Visible = false;

                    trigger OnValidate()
                    begin
                        //check if the cheque has been inserted
                        TestField("Bank Account");
                        PVHead.Reset;
                        PVHead.SetRange(PVHead."Bank Account", "Bank Account");
                        PVHead.SetRange(PVHead."Payment Mode", PVHead."payment mode"::Cheque);
                        if PVHead.FindFirst then begin
                            repeat
                                if PVHead."Cheque No" = "Cheque No" then begin
                                    if PVHead."No." <> "No." then begin
                                        Error('The Cheque Number has already been utilised');
                                    end;
                                end;
                            until PVHead.Next = 0;
                        end;
                    end;
                }
                field("Payment Release Date"; "Payment Release Date")
                {
                    ApplicationArea = Basic;
                    Editable = "Payment Release DateEditable";
                    Visible = false;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
            }
            part(PVLines; "Payment Request Lines")
            {
                SubPageLink = "Received From" = field("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("Copy Invoice")
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy Invoice';
                }
                separator(Action21)
                {
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Approvalentries: Page "Approval Entries";
                    begin
                        if "Payment Type" = "payment type"::Normal then
                            DocumentType := Documenttype::"Payment Voucher"
                        else
                            DocumentType := Documenttype::"Express Pv";
                        //Approvalentries.Setfilters(DATABASE::"Payments Header",DocumentType,"No.");
                        //Approvalentries.RUN;
                    end;
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit WorkflowIntegration;
                    begin
                        if not LinesExists then
                            Error('There are no Lines created for this Document');
                        //Ensure No Items That should be committed that are not
                        if LinesCommitmentStatus then
                            Error('There are some lines that have not been committed');

                        //Release the PV for Approval
                        //IF ApprovalMgt.SendPVApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit WorkflowIntegration;
                    begin
                        //IF ApprovalMgt.CancelPVApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                separator(Action9)
                {
                }
                action("Create PV")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create PV';
                    Image = CreateDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        RecLines: Record "Payment Line.";
                        PaymentsHeader: Record "Payment Header.";
                        PaymentsLine: Record "Payment Line.";
                    begin
                        TestField("Payment Mode");
                        PaymentsHeader.Init;
                        PaymentsHeader.TransferFields(Rec);
                        PaymentsHeader."No." := '';
                        if "Payment Mode" = "payment mode"::Cash then
                            PaymentsHeader."Payment Type" := PaymentsHeader."payment type"::"Petty Cash"
                        else
                            PaymentsHeader."Payment Type" := PaymentsHeader."payment type"::Normal;
                        PaymentsHeader."No." := "No.";
                        PaymentsHeader.Insert(true);

                        PaymentsHeader."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        PaymentsHeader."Global Dimension 2 Code" := "Global Dimension 2 Code";
                        PaymentsHeader.Modify;


                        RecLines.SetRange(RecLines."Received From", "No.");
                        if RecLines.FindSet then
                            repeat
                                PaymentsLine.Init;
                                PaymentsLine.TransferFields(RecLines);
                                PaymentsLine."Received From" := PaymentsHeader."No.";
                                PaymentsLine.Insert;
                            until RecLines.Next = 0;

                        Status := Status::Posted;
                        Posted := true;
                        "Date Posted" := Today;
                        "Time Posted" := Time;
                        Modify;

                        if "Payment Mode" = "payment mode"::Cash then
                            Page.Run(55902, PaymentsHeader)
                        else
                            Page.Run(55905, PaymentsHeader);
                    end;
                }
                action("Cancel Payment Document")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Payment Document';
                    Image = CancelAttachment;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        PaymentHeader: Record "Payment Header.";
                    begin
                        TestField(Status, Status::Approved);
                        PaymentHeader.Reset;
                        PaymentHeader.SetRange(PaymentHeader."No.", "No.");
                        PaymentHeader.SetRange(Status, Status::Approved);
                        /*IF PaymentHeader.FINDFIRST THEN BEGIN
                          IF CONFIRM('Are you sure you want to cancel document %1, and reopen the payment request %2 ?',FALSE,PaymentHeader."No.","No.") THEN
                          BEGIN
                            PaymentHeader.Status:=PaymentHeader.Status::Cancelled;
                            PaymentHeader.MODIFY;
                            Posted:=FALSE;
                            MODIFY;
                          END
                        END
                        ELSE
                        ERROR('No Payment Document exists for this Payment Request');
                        */

                    end;
                }
            }
            group("&Functions")
            {
                Caption = '&Functions';
                Visible = false;
                action("Post Payment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Payment';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //Post PV Entries
                        /*
                        CurrPage.SAVERECORD;
                        CheckPVRequiredItems(Rec);
                        PostPaymentVoucher(Rec);
                        */
                        //Print Here
                        //RESET;
                        //SETFILTER("No.","No.");
                        //REPORT.RUN(55884,TRUE,TRUE,Rec);
                        //RESET;
                        //End Print Here

                    end;
                }
                separator(Action1102755026)
                {
                }
                action(Action1102755034)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        Approvalentries: Page "Approval Entries";
                    begin
                        /*
                        IF "Payment Type"="Payment Type"::Normal THEN
                          DocumentType:=DocumentType::"Payment Voucher"
                        ELSE
                        */
                        DocumentType := Documenttype::Requisition;
                        //Approvalentries.Setfilters(DATABASE::"Payments Header",DocumentType,"No.");
                        //Approvalentries.RUN;

                    end;
                }
                action(Action1102755007)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit WorkflowIntegration;
                    begin
                        if not LinesExists then
                            Error('There are no Lines created for this Document');
                        //Ensure No Items That should be committed that are not
                        if LinesCommitmentStatus then
                            Error('There are some lines that have not been committed');

                        //Release the PV for Approval
                        //IF ApprovalMgt.SendPVApprovalRequest(Rec) THEN;
                    end;
                }
                action("Print preview")
                {
                    ApplicationArea = Basic;
                    RunObject = Report UnknownReport55884;
                    Visible = false;
                }
                action(Action1102755028)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit WorkflowIntegration;
                    begin
                        //IF ApprovalMgt.CancelPVApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                separator(Action1102755009)
                {
                }
                action("Check Budgetary Availability")
                {
                    ApplicationArea = Basic;
                    Caption = 'Check Budgetary Availability';
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        BCSetup: Record "Budgetary Control Setup";
                    begin
                        BCSetup.Get;
                        if not BCSetup.Mandatory then
                            exit;

                        if not AllFieldsEntered then
                            Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');
                        //First Check whether other lines are already committed.
                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."document type"::"Payment Voucher");
                        Commitments.SetRange(Commitments."Document No.", "No.");
                        if Commitments.Find('-') then begin
                            if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then begin exit end;
                            Commitments.Reset;
                            Commitments.SetRange(Commitments."Document Type", Commitments."document type"::"Payment Voucher");
                            Commitments.SetRange(Commitments."Document No.", "No.");
                            Commitments.DeleteAll;
                        end;

                        CheckBudgetAvail.CheckPayments(Rec);
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
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Confirm('Do you Wish to Cancel the Commitment entries for this document', false) = false then begin exit end;

                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."document type"::"Payment Voucher");
                        Commitments.SetRange(Commitments."Document No.", "No.");
                        Commitments.DeleteAll;

                        PayLine.Reset;
                        PayLine.SetRange(PayLine."Received From", "No.");
                        if PayLine.Find('-') then begin
                            repeat
                                PayLine."Cashier Bank Account" := false;
                                PayLine.Modify;
                            until PayLine.Next = 0;
                        end;
                    end;
                }
                separator(Action1102755033)
                {
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Caption = 'Print/Preview';
                    Image = ConfirmAndPrint;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Status <> Status::Approved then
                            Error('You can only print a Payment Voucher after it is fully Approved');



                        //IF Status=Status::Pending THEN
                        //ERROR('You cannot Print until the document is released for approval');
                        Reset;
                        SetFilter("No.", "No.");
                        Report.Run(55903, true, true, Rec);
                        Reset;

                        CurrPage.Update;
                        CurrPage.SaveRecord;
                    end;
                }
                action("Bank Letter")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Letter';
                    Visible = false;

                    trigger OnAction()
                    var
                        FilterbyPayline: Record "Payment Line.";
                    begin
                        if Status = Status::"Pending Approval" then
                            Error('You cannot Print until the document is released for approval');
                        FilterbyPayline.Reset;
                        FilterbyPayline.SetFilter(FilterbyPayline."Received From", "No.");
                        Report.Run(56007, true, true, FilterbyPayline);
                        Reset;
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page UnknownPage51516697;
                    Visible = false;
                }
                separator(Action1102756005)
                {
                }
                action("Cancel Document")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        Text000: label 'Are you sure you want to cancel this Document?';
                        Text001: label 'You have selected not to Cancel the Document';
                    begin
                        if Status = Status::Posted then Error('Please reverse this document first');//TESTFIELD(Status,Status::Approved);
                        if Confirm(Text000, true) then begin
                            //Post Reversal Entries for Commitments
                            Doc_Type := Doc_type::"Payment Voucher";
                            CheckBudgetAvail.ReverseEntries(Doc_Type, "No.");
                            //Status:=Status::Cancelled;
                            Modify;
                        end else
                            Error(Text001);
                    end;
                }
            }
            group("Copy Documents")
            {
                Caption = 'Copy Documents';
                Visible = false;
                action("Copy Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy Loan';
                    Image = GetLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                }
                action(Action1102755012)
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy Invoice';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //createpv;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //Currpageupdate;
        CurrPageUpdate;
    end;

    trigger OnInit()
    begin
        PVLinesEditable := true;
        DateEditable := true;
        PayeeEditable := true;
        ShortcutDimension2CodeEditable := true;
        "Payment NarrationEditable" := true;
        GlobalDimension1CodeEditable := true;
        "Currency CodeEditable" := true;
        "Invoice Currency CodeEditable" := true;
        "Cheque TypeEditable" := true;
        "Payment Release DateEditable" := true;
        "Cheque No.Editable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Payment Type" := "payment type"::Express;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Responsibility Center" := UserMgt.GetPurchasesFilter();
        //Add dimensions if set by default here
        "Global Dimension 1 Code" := UserMgt.GetSetDimensions(UserId, 1);
        Validate("Global Dimension 1 Code");
        "Global Dimension 2 Code" := UserMgt.GetSetDimensions(UserId, 2);
        Validate("Global Dimension 2 Code");
        "Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(UserId, 3);
        Validate("Shortcut Dimension 3 Code");
        "Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(UserId, 4);
        Validate("Shortcut Dimension 4 Code");

        //OnAfterGetCurrRecord;
        UpdateControls;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        /*
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center" ,UserMgt.GetPurchasesFilter());
          FILTERGROUP(0);
        END;
        */

        //UpdatePageControls;

    end;

    var
        PayLine: Record "Payment Line.";
        PVUsers: Record "CshMgt PV Steps Users";
        strFilter: Text[250];
        IntC: Integer;
        IntCount: Integer;
        Payments: Record "Payment Header.";
        RecPayTypes: Record "Funds Transaction Types";
        TarriffCodes: Record "Funds Tax Codes";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Cash Office User Template";
        LineNo: Integer;
        Temp: Record "Cash Office User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        strText: Text[100];
        PVHead: Record "Payment Header.";
        BankAcc: Record "Bank Account";
        CheckBudgetAvail: Codeunit "Budgetary Control";
        Commitments: Record Committment;
        UserMgt: Codeunit "User Setup Management BRr";
        JournlPosted: Codeunit UnknownCodeunit55486;
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,Load,Discharge,"Express Pv";
        DocPrint: Codeunit "Document-Print";
        CheckLedger: Record "Check Ledger Entry";
        Text001: label 'This Document no %1 has printed Cheque No %2 which will have to be voided first before reposting.';
        CheckManagement: Codeunit CheckManagement;
        Text000: label 'Do you want to Void Check No %1';
        Text002: label 'You have selected post and generate a computer cheque ensure that your cheque printer is ready do you want to continue?';
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        [InDataSet]
        "Cheque No.Editable": Boolean;
        [InDataSet]
        "Payment Release DateEditable": Boolean;
        [InDataSet]
        "Cheque TypeEditable": Boolean;
        [InDataSet]
        "Invoice Currency CodeEditable": Boolean;
        [InDataSet]
        "Currency CodeEditable": Boolean;
        [InDataSet]
        GlobalDimension1CodeEditable: Boolean;
        [InDataSet]
        "Payment NarrationEditable": Boolean;
        [InDataSet]
        ShortcutDimension2CodeEditable: Boolean;
        [InDataSet]
        PayeeEditable: Boolean;
        [InDataSet]
        ShortcutDimension3CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension4CodeEditable: Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        PVLinesEditable: Boolean;
        StatusEditable: Boolean;
        PaymodeEditable: Boolean;
        BankEditabl: Boolean;
        OnBehalfEditable: Boolean;
        RespEditabl: Boolean;
        PaymentsHeader: Record "Payment Header.";
        PaymentsLine: Record "Payment Line.";


    procedure PostPaymentVoucher(Rec: Record "Payment Header.")
    begin

        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        if GenJnlLine.Find('+') then begin
            LineNo := GenJnlLine."Line No." + 1000;
        end
        else begin
            LineNo := 1000;
        end;
        GenJnlLine.DeleteAll;
        GenJnlLine.Reset;

        Payments.Reset;
        Payments.SetRange(Payments."No.", "No.");
        if Payments.Find('-') then begin
            PayLine.Reset;
            PayLine.SetRange(PayLine."Received From", Payments."No.");
            if PayLine.Find('-') then begin
                repeat
                    PostHeader(Payments);
                until PayLine.Next = 0;
            end;

            Post := false;
            Post := JournlPosted.PostedSuccessfully();
            if Post then begin
                Posted := true;
                Status := Payments.Status::Posted;
                "Posted By" := UserId;
                "Date Posted" := Today;
                "Time Posted" := Time;
                Modify;

                //Post Reversal Entries for Commitments
                Doc_Type := Doc_type::"Payment Voucher";
                CheckBudgetAvail.ReverseEntries(Doc_Type, "No.");
            end;
        end;
    end;


    procedure PostHeader(var Payment: Record "Payment Header.")
    begin

        if (Payments."Payment Mode" = Payments."payment mode"::Cheque) and ("Cheque Type" = "cheque type"::" ") then
            Error('Cheque type has to be specified');

        if Payments."Payment Mode" = Payments."payment mode"::Cheque then begin
            if (Payments."Cheque No" = '') and ("Cheque Type" = "cheque type"::"Manual Cheque") then begin
                Error('Please ensure that the cheque number is inserted');
            end;
        end;

        if Payments."Payment Mode" = Payments."payment mode"::EFT then begin
            if Payments."Cheque No" = '' then begin
                Error('Please ensure that the EFT number is inserted');
            end;
        end;

        if Payments."Payment Mode" = Payments."payment mode"::"Letter of Credit" then begin
            if Payments."Cheque No" = '' then begin
                Error('Please ensure that the Letter of Credit ref no. is entered.');
            end;
        end;
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);

        if GenJnlLine.Find('+') then begin
            LineNo := GenJnlLine."Line No." + 1000;
        end
        else begin
            LineNo := 1000;
        end;


        LineNo := LineNo + 1000;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Payment."Payment Release Date";
        if CustomerPayLinesExist then
            GenJnlLine."Document Type" := GenJnlLine."document type"::" "
        else
            GenJnlLine."Document Type" := GenJnlLine."document type"::Payment;
        GenJnlLine."Document No." := Payments."No.";
        GenJnlLine."External Document No." := Payments."Cheque No";

        GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
        GenJnlLine."Account No." := Payments."Bank Account";
        GenJnlLine.Validate(GenJnlLine."Account No.");

        GenJnlLine."Currency Code" := Payments."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        //CurrFactor
        GenJnlLine."Currency Factor" := Payments."Currency Factor";
        GenJnlLine.Validate("Currency Factor");

        Payments.CalcFields(Payments."Net Amount", Payments."VAT Amount");
        GenJnlLine.Amount := -(Payments."Net Amount");
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';

        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := PayLine."PV Type";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Apply to";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, PayLine."Apply to ID");
        GenJnlLine.ValidateShortcutDimCode(4, PayLine."No of Units");

        GenJnlLine.Description := CopyStr("Payment Description", 1, 50);//COPYSTR('Pay To:' + Payments.Payee,1,50);
        GenJnlLine.Validate(GenJnlLine.Description);

        if "Payment Mode" <> "payment mode"::Cheque then begin
            GenJnlLine."Bank Payment Type" := GenJnlLine."bank payment type"::" "
        end else begin
            if "Cheque Type" = "cheque type"::"Computer Cheque" then
                GenJnlLine."Bank Payment Type" := GenJnlLine."bank payment type"::"Computer Check"
            else
                GenJnlLine."Bank Payment Type" := GenJnlLine."bank payment type"::" "

        end;
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;

        //Post Other Payment Journal Entries
        PostPV(Payments);
    end;


    procedure GetAppliedEntries(var LineNo: Integer) InvText: Text[100]
    var
        Appl: Record "Funds Transaction Types";
    begin
        /*
        InvText:='';
        Appl.RESET;
        Appl.SETRANGE(Appl."Document Type",Appl."Document Type"::PV);
        Appl.SETRANGE(Appl."Document No.","No.");
        Appl.SETRANGE(Appl."Line No.",LineNo);
        IF Appl.FINDFIRST THEN
          BEGIN
            REPEAT
              InvText:=COPYSTR(InvText + ',' + Appl."Appl. Doc. No",1,50);
            UNTIL Appl.NEXT=0;
          END;
        */

    end;


    procedure InsertApproval()
    var
        LineNo: Integer;
    begin
        /*LineNo:=0;
        Appl.RESET;
        IF Appl.FINDLAST THEN
          BEGIN
            LineNo:=Appl."Line No.";
          END;
        
        LineNo:=LineNo +1;
        
        Appl.RESET;
        Appl.INIT;
          Appl."Line No.":=LineNo;
          Appl."Document Type":=Appl."Document Type"::PV;
          Appl."Document No.":="No.";
          Appl."Document Date":=Date;
          Appl."Process Date":=TODAY;
          Appl."Process Time":=TIME;
          Appl."Process User ID":=USERID;
          Appl."Process Name":="Current Status";
          //Appl."Process Machine":=ENVIRON('COMPUTERNAME');
        Appl.INSERT;
        */

    end;


    procedure LinesCommitmentStatus() Exists: Boolean
    var
        BCSetup: Record "Budgetary Control Setup";
    begin
        if BCSetup.Get() then begin
            if not BCSetup.Mandatory then begin
                Exists := false;
                exit;
            end;
        end else begin
            Exists := false;
            exit;
        end;
        Exists := false;
        PayLine.Reset;
        PayLine.SetRange(PayLine."Received From", "No.");
        PayLine.SetRange(PayLine."Cashier Bank Account", false);
        //PayLine.SETRANGE(PayLine."Budgetary Control A/C",TRUE);
        if PayLine.Find('-') then
            Exists := true;
    end;


    procedure CheckPVRequiredItems(Rec: Record "Payment Header.")
    begin
        if Posted then begin
            Error('The Document has already been posted');
        end;

        TestField(Status, Status::Approved);
        TestField("Bank Account");
        TestField("Payment Mode");
        TestField("Payment Release Date");
        //Confirm whether Bank Has the Cash
        if "Payment Mode" = "payment mode"::Cash then
            CheckBudgetAvail.CheckFundsAvailability(Rec);
        /*
         //Confirm Payment Release Date is today);
        IF "Payment Mode"="Payment Mode"::Cash THEN
          TESTFIELD("Payment Release Date",WORKDATE);
        */
        /*Check if the user has selected all the relevant fields*/
        Temp.Get(UserId);

        JTemplate := Temp."Payment Journal Template";
        JBatch := Temp."Payment Journal Batch";

        if JTemplate = '' then begin
            Error('Ensure the PV Template is set up in Cash Office Setup');
        end;
        if JBatch = '' then begin
            Error('Ensure the PV Batch is set up in the Cash Office Setup')
        end;

        if ("Payment Mode" = "payment mode"::Cheque) and ("Cheque Type" = "cheque type"::"Computer Cheque") then begin
            if not Confirm(Text002, false) then
                Error('You have selected to Abort PV Posting');
        end;
        //Check whether there is any printed cheques and lines not posted
        CheckLedger.Reset;
        CheckLedger.SetRange(CheckLedger."Document No.", "No.");
        CheckLedger.SetRange(CheckLedger."Entry Status", CheckLedger."entry status"::Printed);
        if CheckLedger.Find('-') then begin
            //Ask whether to void the printed cheque
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            GenJnlLine.FindFirst;
            if Confirm(Text000, false, CheckLedger."Check No.") then
                CheckManagement.VoidCheck(GenJnlLine)
            else
                Error(Text001, "No.", CheckLedger."Check No.");
        end;

    end;


    procedure PostPV(var Payment: Record "Payment Header.")
    begin

        PayLine.Reset;
        PayLine.SetRange(PayLine."Received From", Payments."No.");
        if PayLine.Find('-') then begin

            repeat
                strText := GetAppliedEntries(PayLine."On Behalf Of");
                Payment.TestField(Payment.Payee);
                PayLine.TestField(PayLine.Remarks);
                // PayLine.TESTFIELD(PayLine."Global Dimension 1 Code");

                //BANK
                if PayLine."Budget Center Name" = PayLine."budget center name"::"1" then begin
                    CashierLinks.Reset;
                    CashierLinks.SetRange(CashierLinks.UserID, UserId);
                end;

                //CHEQUE
                LineNo := LineNo + 1000;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Payment."Payment Release Date";
                GenJnlLine."Document No." := PayLine."Received From";
                if PayLine.Posted = PayLine.Posted::"1" then
                    GenJnlLine."Document Type" := GenJnlLine."document type"::" "
                else
                    GenJnlLine."Document Type" := GenJnlLine."document type"::Payment;
                GenJnlLine."Account Type" := PayLine.Posted;
                GenJnlLine."Account No." := PayLine."Date Posted";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."External Document No." := Payments."Cheque No";
                GenJnlLine.Description := CopyStr(PayLine."Posted By" + ':' + Payment.Payee, 1, 50);
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine."Currency Factor" := Payments."Currency Factor";
                GenJnlLine.Validate("Currency Factor");
                if PayLine."VAT Code" = '' then begin
                    GenJnlLine.Amount := PayLine."PO/INV No";
                end
                else begin
                    GenJnlLine.Amount := PayLine."PO/INV No";
                end;
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."VAT Prod. Posting Group" := PayLine."Bank Type";
                GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."PV Type";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Apply to";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PayLine."Apply to ID");
                GenJnlLine.ValidateShortcutDimCode(4, PayLine."No of Units");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."applies-to doc. type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Total Expenditure";
                GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Total Commitments";

                if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;

                //Post VAT to GL[VAT GL]
                TarriffCodes.Reset;
                TarriffCodes.SetRange(TarriffCodes."Tax Code", PayLine."VAT Code");
                if TarriffCodes.Find('-') then begin
                    TarriffCodes.TestField(TarriffCodes."Account No");
                    LineNo := LineNo + 1000;
                    GenJnlLine.Init;
                    GenJnlLine."Journal Template Name" := JTemplate;
                    GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                    GenJnlLine."Journal Batch Name" := JBatch;
                    GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Posting Date" := Payment."Payment Release Date";
                    GenJnlLine."Document Type" := GenJnlLine."document type"::Payment;
                    GenJnlLine."Document No." := PayLine."Received From";
                    GenJnlLine."External Document No." := Payments."Cheque No";
                    GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
                    GenJnlLine."Account No." := TarriffCodes."Account No";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine."Currency Code" := Payments."Currency Code";
                    GenJnlLine.Validate(GenJnlLine."Currency Code");
                    //CurrFactor
                    GenJnlLine."Currency Factor" := Payments."Currency Factor";
                    GenJnlLine.Validate("Currency Factor");

                    GenJnlLine."Gen. Posting Type" := GenJnlLine."gen. posting type"::" ";
                    GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
                    GenJnlLine."Gen. Bus. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                    GenJnlLine."Gen. Prod. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                    GenJnlLine."VAT Bus. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                    GenJnlLine."VAT Prod. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                    GenJnlLine.Amount := -PayLine."Withholding Tax Code";
                    GenJnlLine.Validate(GenJnlLine.Amount);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                    GenJnlLine."Bal. Account No." := '';
                    GenJnlLine.Description := CopyStr('VAT:' + Format(PayLine.Posted) + '::' + Format(PayLine."Time Posted"), 1, 50);
                    GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                    GenJnlLine."Shortcut Dimension 1 Code" := PayLine."PV Type";
                    GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Apply to";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine.ValidateShortcutDimCode(3, PayLine."Apply to ID");
                    GenJnlLine.ValidateShortcutDimCode(4, PayLine."No of Units");

                    if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                end;

                //POST W/TAX to Respective W/TAX GL Account
                TarriffCodes.Reset;
                TarriffCodes.SetRange(TarriffCodes."Tax Code", PayLine."Withholding Tax Amount");
                if TarriffCodes.Find('-') then begin
                    TarriffCodes.TestField(TarriffCodes."Account No");
                    LineNo := LineNo + 1000;
                    GenJnlLine.Init;
                    GenJnlLine."Journal Template Name" := JTemplate;
                    GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                    GenJnlLine."Journal Batch Name" := JBatch;
                    GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Posting Date" := Payment."Payment Release Date";
                    GenJnlLine."Document Type" := GenJnlLine."document type"::Payment;
                    GenJnlLine."Document No." := PayLine."Received From";
                    GenJnlLine."External Document No." := Payments."Cheque No";
                    GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
                    GenJnlLine."Account No." := TarriffCodes."Account No";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine."Currency Code" := Payments."Currency Code";
                    GenJnlLine.Validate(GenJnlLine."Currency Code");
                    //CurrFactor
                    GenJnlLine."Currency Factor" := Payments."Currency Factor";
                    GenJnlLine.Validate("Currency Factor");

                    GenJnlLine."Gen. Posting Type" := GenJnlLine."gen. posting type"::" ";
                    GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
                    GenJnlLine."Gen. Bus. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                    GenJnlLine."Gen. Prod. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                    GenJnlLine."VAT Bus. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                    GenJnlLine."VAT Prod. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                    GenJnlLine.Amount := -PayLine."Net Amount";
                    GenJnlLine.Validate(GenJnlLine.Amount);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                    GenJnlLine."Bal. Account No." := '';
                    GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                    GenJnlLine.Description := CopyStr('W/Tax:' + Format(PayLine."Time Posted") + '::' + strText, 1, 50);
                    GenJnlLine."Shortcut Dimension 1 Code" := PayLine."PV Type";
                    GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Apply to";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine.ValidateShortcutDimCode(3, PayLine."Apply to ID");
                    GenJnlLine.ValidateShortcutDimCode(4, PayLine."No of Units");

                    if GenJnlLine.Amount <> 0 then
                        GenJnlLine.Insert;
                end;

                //Post VAT Balancing Entry Goes to Vendor
                LineNo := LineNo + 1000;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Payment."Payment Release Date";
                GenJnlLine."Document Type" := GenJnlLine."document type"::Payment;
                GenJnlLine."Document No." := PayLine."Received From";
                GenJnlLine."External Document No." := Payments."Cheque No";
                GenJnlLine."Account Type" := PayLine.Posted;
                GenJnlLine."Account No." := PayLine."Date Posted";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.Validate(GenJnlLine."Currency Code");
                //CurrFactor
                GenJnlLine."Currency Factor" := Payments."Currency Factor";
                GenJnlLine.Validate("Currency Factor");

                if PayLine."VAT Code" = '' then begin
                    GenJnlLine.Amount := 0;
                end
                else begin
                    GenJnlLine.Amount := PayLine."Withholding Tax Code";
                end;
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Description := CopyStr('VAT:' + Format(PayLine.Posted) + '::' + Format(PayLine."Time Posted"), 1, 50);
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."PV Type";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Apply to";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PayLine."Apply to ID");
                GenJnlLine.ValidateShortcutDimCode(4, PayLine."No of Units");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."applies-to doc. type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Total Expenditure";
                GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Total Commitments";
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;

                //Post W/TAX Balancing Entry Goes to Vendor
                LineNo := LineNo + 1000;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Payment."Payment Release Date";
                GenJnlLine."Document Type" := GenJnlLine."document type"::Payment;
                GenJnlLine."Document No." := PayLine."Received From";
                GenJnlLine."External Document No." := Payments."Cheque No";
                GenJnlLine."Account Type" := PayLine.Posted;
                GenJnlLine."Account No." := PayLine."Date Posted";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.Validate(GenJnlLine."Currency Code");
                //CurrFactor
                GenJnlLine."Currency Factor" := Payments."Currency Factor";
                GenJnlLine.Validate("Currency Factor");

                GenJnlLine."Gen. Posting Type" := GenJnlLine."gen. posting type"::" ";
                GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
                GenJnlLine."Gen. Bus. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                GenJnlLine."Gen. Prod. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                GenJnlLine."VAT Bus. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                GenJnlLine."VAT Prod. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                GenJnlLine.Amount := PayLine."Net Amount";
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Description := CopyStr('W/Tax:' + strText, 1, 50);
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."PV Type";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Apply to";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PayLine."Apply to ID");
                GenJnlLine.ValidateShortcutDimCode(4, PayLine."No of Units");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."applies-to doc. type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Total Expenditure";
                GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Total Commitments";
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;


            until PayLine.Next = 0;

            Commit;
            //Post the Journal Lines
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            //Adjust Gen Jnl Exchange Rate Rounding Balances
            AdjustGenJnl.Run(GenJnlLine);
            //End Adjust Gen Jnl Exchange Rate Rounding Balances


            //Before posting if paymode is cheque print the cheque
            if ("Payment Mode" = "payment mode"::Cheque) and ("Cheque Type" = "cheque type"::"Computer Cheque") then begin
                DocPrint.PrintCheck(GenJnlLine);
                Codeunit.Run(Codeunit::"Adjust Gen. Journal Balance", GenJnlLine);
                //Confirm Cheque printed //Not necessary.
            end;

            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Line", GenJnlLine);
            Post := false;
            Post := JournlPosted.PostedSuccessfully();
            if Post then begin
                if PayLine.FindFirst then begin
                    repeat
                        PayLine."Imprest Request No" := Today;
                        PayLine."Batched Imprest Tot" := Time;
                        PayLine."Shortcut Dimension 2 Code" := UserId;
                        PayLine."Petty Cash" := PayLine."petty cash"::"4";
                        PayLine.Modify;
                    until PayLine.Next = 0;
                end;
            end;

        end;
    end;


    procedure UpdatePageControls()
    begin
        if Status <> Status::Approved then begin
            "Payment Release DateEditable" := false;
            //CurrForm."Bank Account".EDITABLE:=FALSE;
            //CurrForm."Payment Mode".EDITABLE:=FALSE;
            //CurrForm."Currency Code".EDITABLE:=TRUE;
            "Cheque No.Editable" := false;
            "Cheque TypeEditable" := false;
            "Invoice Currency CodeEditable" := true;
        end else begin
            "Payment Release DateEditable" := true;
            //CurrForm."Bank Account".EDITABLE:=TRUE;
            //CurrForm."Payment Mode".EDITABLE:=TRUE;
            if "Payment Mode" = "payment mode"::Cheque then
                "Cheque TypeEditable" := true;
            //CurrForm."Currency Code".EDITABLE:=FALSE;
            if "Cheque Type" <> "cheque type"::"Computer Cheque" then
                "Cheque No.Editable" := true;
            "Invoice Currency CodeEditable" := false;
            PaymodeEditable := true;
            BankEditabl := true;
            OnBehalfEditable := true;
            RespEditabl := true;

        end;
        if Status = Status::"Pending Approval" then begin
            "Currency CodeEditable" := true;
            GlobalDimension1CodeEditable := true;
            "Payment NarrationEditable" := true;
            ShortcutDimension2CodeEditable := true;
            PayeeEditable := true;
            ShortcutDimension3CodeEditable := true;
            ShortcutDimension4CodeEditable := true;
            DateEditable := true;
            PaymodeEditable := true;
            BankEditabl := true;
            OnBehalfEditable := true;
            RespEditabl := true;

            PVLinesEditable := true;
        end else begin
            "Currency CodeEditable" := false;
            GlobalDimension1CodeEditable := false;
            "Payment NarrationEditable" := false;
            ShortcutDimension2CodeEditable := false;
            PayeeEditable := true;
            ShortcutDimension3CodeEditable := false;
            ShortcutDimension4CodeEditable := false;
            DateEditable := false;
            PVLinesEditable := false;
        end;

        if Status = Status::Posted then begin
            PaymodeEditable := false;
            BankEditabl := false;
            OnBehalfEditable := false;
            RespEditabl := false;
            PVLinesEditable := false;
        end;
    end;


    procedure LinesExists(): Boolean
    var
        PayLines: Record "Payment Line.";
    begin
        HasLines := false;
        PayLines.Reset;
        PayLines.SetRange(PayLines."Received From", "No.");
        if PayLines.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;


    procedure AllFieldsEntered(): Boolean
    var
        PayLines: Record "Payment Line.";
    begin
        AllKeyFieldsEntered := true;
        PayLines.Reset;
        PayLines.SetRange(PayLines."Received From", "No.");
        if PayLines.Find('-') then begin
            repeat
                if (PayLines."Date Posted" = '') or (PayLines.Remarks <= 0) then
                    AllKeyFieldsEntered := false;
            until PayLines.Next = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;


    procedure CustomerPayLinesExist(): Boolean
    var
        PayLine: Record "Payment Line.";
    begin
        PayLine.Reset;
        PayLine.SetRange(PayLine."Received From", "No.");
        PayLine.SetRange(PayLine.Posted, PayLine.Posted::"1");
        exit(PayLine.FindFirst);
    end;

    local procedure CurrpageupdateOld()
    begin
        xRec := Rec;
        UpdatePageControls();
        CurrPage.Update;
        //Set the filters here
        SetRange(Posted, false);
        SetRange("Payment Type", "payment type"::Normal);
        SetFilter(Status, '<>Cancelled');
    end;


    procedure UpdateControls()
    begin
        if Status = Status::"Pending Approval" then
            StatusEditable := true
        else
            StatusEditable := false;
    end;


    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        UpdatePageControls();
        CurrPage.Update;
    end;


    procedure InsertPvLine()
    var
        PvLine: Record "Payment Line.";
    begin
        /*PayLine.RESET;
        PayLine.SETRANGE(PayLine."Loan No",prAssignEmpLoan."Entry No");
        IF PayLine.FINDFIRST THEN
        ERROR('Another %1 Payment Voucher number %2 already exist for this loan',PayLine.Status,PayLine.No);
        //exit();
        
        PvLine.INIT;
          PvLine."Line No.":=0;
          PvLine.Type:='LOAN';
          PvLine.No:="No.";
          PvLine.Date:=TODAY;
          PvLine."Account Type":=PvLine."Account Type"::Customer;
          PvLine."Account No.":=prAssignEmpLoan."Employee Code";
          PvLine."Account Name":=prAssignEmpLoan."Transaction Name"+'Loan for employee'+prAssignEmpLoan."Employee Code";
          PvLine.Remarks:=prAssignEmpLoan."Transaction Name"+'Loan for employee'+prAssignEmpLoan."Employee Code";
          PvLine."Transaction Name":=prAssignEmpLoan."Transaction Name"+'Loan for employee'+prAssignEmpLoan."Employee Code";
          PvLine.VALIDATE(Amount,prAssignEmpLoan.Balance);
          PvLine."Loan No":=prAssignEmpLoan."Entry No";
        PvLine.INSERT;
        */

    end;


    procedure CreatePV()
    var
        PVhdr: Record "Payment Header.";
        PVLines: Record "Payment Line.";
        PayTypes: Record "Funds Transaction Types";
        Vendor: Record Vendor;
        VendLedger: Record "Vendor Ledger Entry";
        PVHeader: Record "Payment Header.";
    begin
        /*
        //confirm if invoice has been fully paid
        VendLedger.RESET;
        VendLedger.SETRANGE(VendLedger."Vendor No.","Pay-to Vendor No.");
        VendLedger.SETRANGE(VendLedger."Document Type",VendLedger."Document Type"::Invoice);
        VendLedger.SETRANGE(VendLedger."Document No.","No.");
        VendLedger.FINDFIRST;
        VendLedger.CALCFIELDS("Remaining Amount");
        IF VendLedger."Remaining Amount">=0 THEN BEGIN
         MESSAGE('The invoice has been fully applied, Payment Voucher not created');
         EXIT;
        END;
        
        //check if a pending pv for invoice exists
          PVHeader.RESET;
          PVHeader.SETFILTER(PVHeader.Status,'<>%1',PVHeader.Status::Cancelled);
          PVHeader.SETRANGE(PVHeader.Posted,FALSE);
          PVHeader.SETRANGE(PVHeader."Invoice No","No.");
          IF PVHeader.FINDFIRST THEN BEGIN
            MESSAGE('A Payment voucher for this invoice already exists');
            EXIT;
          END;
        
        PVhdr.INIT;
        PVhdr."No.":='';
        PVhdr.Date:=TODAY;
        PVhdr."Currency Code":="Currency Code";
        PVhdr.Payee:="Pay-to Name";
        PVhdr."On Behalf Of":="Pay-to Name";
        PVhdr.Cashier:=USERID;
        PVhdr."Payment Type":=PVhdr."Payment Type"::Express;
        PVhdr."Global Dimension 1 Code":="Shortcut Dimension 1 Code";
        PVhdr.VALIDATE("Global Dimension 1 Code");
        PVhdr."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
        PVhdr.VALIDATE("Shortcut Dimension 2 Code");
        PVhdr."Responsibility Center":="Responsibility Center";
        PVhdr."Payment Description":="Posting Description";
        PVhdr."Dimension Set ID":="Dimension Set ID";
        PVhdr."Invoice No":="No.";//"Pre-Assigned No.";
        PVhdr.INSERT(TRUE);
        
        PVLines.INIT;
        PVLines."Line No.":=0;
        PVLines.No:=PVhdr."No.";
          PayTypes.RESET;
          PayTypes.SETRANGE(PayTypes."Account Type",PayTypes."Account Type"::Vendor);
          Vendor.GET("Buy-from Vendor No.");
          PayTypes.SETRANGE(PayTypes."Default Grouping",Vendor."Vendor Posting Group");
          PayTypes.FINDFIRST;
        PVLines.Type:=PayTypes.Code;
        PVLines.Date:=TODAY;
        PVLines."Account Type":=PVLines."Account Type"::Vendor;
        PVLines."Account No.":="Pay-to Vendor No.";
        PVLines."Account Name":="Pay-to Name";
        CALCFIELDS("Amount Including VAT");
        PVLines.Amount:=VendLedger."Remaining Amount"*-1;
        PVLines.VALIDATE(Amount);
        PVLines.Remarks:="Posting Description";
        PVLines."Applies-to Doc. Type":=PVLines."Applies-to Doc. Type"::Invoice;
        PVLines.VALIDATE("Applies-to Doc. No.","No.");
        //PVLines."Applies-to ID":=PVhdr."No.";
        //PVLines.VALIDATE("Apply to ID","No.");
        PVLines.VALIDATE("Global Dimension 1 Code","Shortcut Dimension 1 Code");
        PVLines.VALIDATE("Shortcut Dimension 2 Code","Shortcut Dimension 2 Code");
        PVLines."Dimension Set ID":="Dimension Set ID";
        PVLines.INSERT;
        
        PAGE.RUN(PAGE::"Payment Header",PVhdr);
        */

    end;
}

