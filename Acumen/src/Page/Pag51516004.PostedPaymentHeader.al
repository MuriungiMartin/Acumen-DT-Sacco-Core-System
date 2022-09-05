#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516004 "Posted Payment Header"
{
    // //Use if Cheque is to be Validated
    // Payments.RESET;
    // Payments.SETRANGE(Payments."No.","No.");
    // IF Payments.FINDFIRST THEN
    //   BEGIN
    //     IF Payments."Pay Mode"=Payments."Pay Mode"::Cheque THEN
    //       BEGIN
    //          IF STRLEN(Payments."Cheque No.")<>6 THEN
    //           BEGIN
    //             ERROR ('Invalid Cheque Number Inserted');
    //           END;
    //       END;
    //   END;
    // **************************************************************************************
    // //Use if Paying Bank Account should not be overdrawn
    // 
    // //get the source account balance from the database table
    // BankAcc.RESET;
    // BankAcc.SETRANGE(BankAcc."No.",Payment."Paying Bank Account");
    // BankAcc.SETRANGE(BankAcc."Bank Type",BankAcc."Bank Type"::Cash);
    // IF BankAcc.FINDFIRST THEN
    //   BEGIN
    //     Payments.TESTFIELD(Payments.Date,TODAY);
    //     BankAcc.CALCFIELDS(BankAcc."Balance (LCY)");
    //     "Current Source A/C Bal.":=BankAcc."Balance (LCY)";
    //     IF ("Current Source A/C Bal."-Payment."Total Net Amount")<0 THEN
    //       BEGIN
    //         ERROR('The transaction will result in a negative balance in the BANK ACCOUNT.');
    //       END;
    //   END;

    Caption = 'Payment Vouchers';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Payment Header.";
    SourceTableView = where("Payment Type" = filter(<> "Petty Cash"), Posted = const(true));

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
                label(Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    Editable = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = ShortcutDimension2CodeEditable;
                }
                label(Control16)
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                    Editable = ShortcutDimension3CodeEditable;
                    Visible = false;
                }
                label(Control1102755029)
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {
                    ApplicationArea = Basic;
                    Editable = ShortcutDimension4CodeEditable;
                    Visible = false;
                }
                label(Control1102755030)
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    Editable = false;
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
                }
                field("Bank Account"; "Bank Account")
                {
                    ApplicationArea = Basic;
                    Editable = bankeditabl;
                }
                label(Control1000000002)
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account Name"; "Bank Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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

                    trigger OnValidate()
                    begin
                        if "Cheque Type" = "cheque type"::"Computer Cheque" then
                            "Cheque No.Editable" := false
                        else
                            "Cheque No.Editable" := true;
                    end;
                }
                label(Control1102755018)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Cashier; Cashier)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Net Amount"; "Net Amount")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("VAT Amount"; "VAT Amount")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                label(Control1102755002)
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                label(Control1102756002)
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                label("Total Net Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Net Amount';
                    Editable = false;
                    Importance = Promoted;
                }
                field("VAT Amount(LCY)"; "VAT Amount(LCY)")
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
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
            }
            part(PVLines; "Posted Payment Line")
            {
                SubPageLink = No = field("No.");
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
                        CurrPage.SaveRecord;
                        CheckPVRequiredItems(Rec);
                        PostPaymentVoucher(Rec);

                        //Print Here
                        //RESET;
                        //SETFILTER("No.","No.");
                        //REPORT.RUN(51516334,TRUE,TRUE,Rec);
                        //RESET;
                        //End Print Here
                    end;
                }
                separator(Action1102755026)
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
                        ApprovalMgt: Codeunit "Export F/O Consolidation";
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
                    RunObject = Report "prPayrollJournalTransfer..";
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
                        ApprovalMgt: Codeunit "Export F/O Consolidation";
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

                    trigger OnAction()
                    begin
                        if Confirm('Do you Wish to Cancel the Commitment entries for this document', false) = false then begin exit end;

                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."document type"::"Payment Voucher");
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
                        Report.Run(51516334, true, true, Rec);
                        Reset;

                        CurrPage.Update;
                        CurrPage.SaveRecord;
                    end;
                }
                action("Vendor Payment Advise")
                {
                    ApplicationArea = Basic;
                    Caption = 'Vendor Payment Advise';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        if Status = Status::"Pending Approval" then
                            Error('You cannot Print until the document is released for approval');
                        Reset;
                        SetFilter("No.", "No.");
                        Report.Run(50289, true, true, Rec);
                        Reset;
                    end;
                }
                action("Cheque Confirmation")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque Confirmation';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";

                    trigger OnAction()
                    var
                        FilterbyPayline: Record "Payment Line.";
                    begin
                        if Status = Status::"Pending Approval" then
                            Error('You cannot Print until the document is released for approval');
                        /*
                        FilterbyPayline.RESET;
                        FilterbyPayline.SETFILTER(FilterbyPayline.No,"No.");
                        */
                        Reset;
                        SetFilter("No.", "No.");
                        Report.Run(51516368, true, true, Rec);
                        Reset;

                    end;
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

                    trigger OnAction()
                    var
                        Text000: label 'Are you sure you want to cancel this Document?';
                        Text001: label 'You have selected not to Cancel the Document';
                        GLEntry: Record "G/L Entry";
                    begin
                        /*
                        TESTFIELD(Status,Status::Approved);
                        IF CONFIRM(Text000,TRUE) THEN  BEGIN
                        //Post Reversal Entries for Commitments
                        Doc_Type:=Doc_Type::"Payment Voucher";
                        CheckBudgetAvail.ReverseEntries(Doc_Type,"No.");
                        Status:=Status::Cancelled;
                        MODIFY;
                        END ELSE
                          ERROR(Text001);
                        */
                        if not Confirm(Text000, true) then exit;
                        //check if reversals exist
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."Document No.", "No.");
                        GLEntry.SetRange(GLEntry.Reversed, true);
                        if not GLEntry.FindSet then
                            Error('Reverse The document entries first')
                        else begin
                            //Post Committment Reversals
                            Doc_Type := Doc_type::"Payment Voucher";
                            CheckBudgetAvail.ReverseEntries(Doc_Type, "No.");
                            Status := Status::Cancelled;
                            Modify;
                        end

                    end;
                }
            }
            group("Copy Documents")
            {
                Caption = 'Copy Documents';
                action("Copy Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy Loan';
                    Image = GetLines;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /*prAssignEmp.RESET;
                        prAssignEmp.SETRANGE(prAssignEmp.Status,prAssignEmp.Status::"3");
                        IF prAssignEmp.FINDSET THEN
                        IF PAGE.RUNMODAL(51516266,prAssignEmp)=ACTION::LookupOK THEN
                        InsertPvLine(prAssignEmp);
                         */

                    end;
                }
                action("Copy Invoice")
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy Invoice';
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
        "Payment Type" := "payment type"::Normal;
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
        RecPayTypes: Record "Receipts and Payment Types";
        TarriffCodes: Record "Tariff Codes";
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
        UserMgt: Codeunit "User Setup Management BR";
        JournlPosted: Codeunit "Journal Post Successful";
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
            PayLine.SetRange(PayLine.No, Payments."No.");
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
        GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");

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
        Appl: Record "CshMgt Application";
    begin

        InvText := '';
        Appl.Reset;
        Appl.SetRange(Appl."Document Type", Appl."document type"::PV);
        Appl.SetRange(Appl."Document No.", "No.");
        Appl.SetRange(Appl."Line No.", LineNo);
        if Appl.FindFirst then begin
            repeat
                InvText := CopyStr(InvText + ',' + Appl."Appl. Doc. No", 1, 50);
            until Appl.Next = 0;
        end;
    end;


    procedure InsertApproval()
    var
        Appl: Record "CshMgt Approvals";
        LineNo: Integer;
    begin
        LineNo := 0;
        Appl.Reset;
        if Appl.FindLast then begin
            LineNo := Appl."Line No.";
        end;

        LineNo := LineNo + 1;

        Appl.Reset;
        Appl.Init;
        Appl."Line No." := LineNo;
        Appl."Document Type" := Appl."document type"::PV;
        Appl."Document No." := "No.";
        Appl."Document Date" := Date;
        Appl."Process Date" := Today;
        Appl."Process Time" := Time;
        Appl."Process User ID" := UserId;
        // Appl."Process Name":="Current Status";
        //Appl."Process Machine":=ENVIRON('COMPUTERNAME');
        Appl.Insert;
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
        PayLine.SetRange(PayLine.No, "No.");
        PayLine.SetRange(PayLine.Committed, false);
        PayLine.SetRange(PayLine."Budgetary Control A/C", true);
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
        IF "Pay Mode"="Pay Mode"::Cash THEN
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
        PayLine.SetRange(PayLine.No, Payments."No.");
        if PayLine.Find('-') then begin

            repeat
                strText := GetAppliedEntries(PayLine."Line No.");
                Payment.TestField(Payment.Payee);
                PayLine.TestField(PayLine.Amount);
                // PayLine.TESTFIELD(PayLine."Global Dimension 1 Code");

                //BANK
                if PayLine."Pay Mode" = PayLine."pay mode"::Cash then begin
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
                GenJnlLine."Document No." := PayLine.No;
                if PayLine."Account Type" = PayLine."account type"::Customer then
                    GenJnlLine."Document Type" := GenJnlLine."document type"::" "
                else
                    GenJnlLine."Document Type" := GenJnlLine."document type"::Payment;
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."External Document No." := Payments."Cheque No";
                GenJnlLine.Description := CopyStr(PayLine."Transaction Name" + ':' + Payment.Payee, 1, 50);
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine."Currency Factor" := Payments."Currency Factor";
                GenJnlLine.Validate("Currency Factor");
                if PayLine."VAT Code" = '' then begin
                    GenJnlLine.Amount := PayLine."Net Amount";
                end
                else begin
                    GenJnlLine.Amount := PayLine."Net Amount";
                end;
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."VAT Prod. Posting Group" := PayLine."VAT Prod. Posting Group";
                GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."applies-to doc. type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Applies-to Doc. No.";
                GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Applies-to ID";

                if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;

                //Post VAT to GL[VAT GL]
                TarriffCodes.Reset;
                TarriffCodes.SetRange(TarriffCodes.Code, PayLine."VAT Code");
                if TarriffCodes.Find('-') then begin
                    TarriffCodes.TestField(TarriffCodes."Account No.");
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
                    GenJnlLine."Document No." := PayLine.No;
                    GenJnlLine."External Document No." := Payments."Cheque No";
                    GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
                    GenJnlLine."Account No." := TarriffCodes."Account No.";
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
                    GenJnlLine.Amount := -PayLine."VAT Amount";
                    GenJnlLine.Validate(GenJnlLine.Amount);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                    GenJnlLine."Bal. Account No." := '';
                    GenJnlLine.Description := CopyStr('VAT:' + Format(PayLine."Account Type") + '::' + Format(PayLine."Account Name"), 1, 50);
                    GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                    GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                    GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");

                    if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                end;

                //POST W/TAX to Respective W/TAX GL Account
                TarriffCodes.Reset;
                TarriffCodes.SetRange(TarriffCodes.Code, PayLine."Withholding Tax Code");
                if TarriffCodes.Find('-') then begin
                    TarriffCodes.TestField(TarriffCodes."Account No.");
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
                    GenJnlLine."Document No." := PayLine.No;
                    GenJnlLine."External Document No." := Payments."Cheque No";
                    GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
                    GenJnlLine."Account No." := TarriffCodes."Account No.";
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
                    GenJnlLine.Amount := -PayLine."Withholding Tax Amount";
                    GenJnlLine.Validate(GenJnlLine.Amount);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                    GenJnlLine."Bal. Account No." := '';
                    GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                    GenJnlLine.Description := CopyStr('W/Tax:' + Format(PayLine."Account Name") + '::' + strText, 1, 50);
                    GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                    GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");

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
                GenJnlLine."Document No." := PayLine.No;
                GenJnlLine."External Document No." := Payments."Cheque No";
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
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
                    GenJnlLine.Amount := PayLine."VAT Amount";
                end;
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Description := CopyStr('VAT:' + Format(PayLine."Account Type") + '::' + Format(PayLine."Account Name"), 1, 50);
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."applies-to doc. type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Apply to";
                GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Apply to ID";
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
                GenJnlLine."Document No." := PayLine.No;
                GenJnlLine."External Document No." := Payments."Cheque No";
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
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
                GenJnlLine.Amount := PayLine."Withholding Tax Amount";
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Description := CopyStr('W/Tax:' + strText, 1, 50);
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."applies-to doc. type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Apply to";
                GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Apply to ID";
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
                        PayLine."Date Posted" := Today;
                        PayLine."Time Posted" := Time;
                        PayLine."Posted By" := UserId;
                        PayLine.Status := PayLine.Status::Posted;
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
            //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
            //CurrForm."Pay Mode".EDITABLE:=FALSE;
            //CurrForm."Currency Code".EDITABLE:=TRUE;
            "Cheque No.Editable" := false;
            "Cheque TypeEditable" := false;
            "Invoice Currency CodeEditable" := true;
        end else begin
            "Payment Release DateEditable" := true;
            //CurrForm."Paying Bank Account".EDITABLE:=TRUE;
            //CurrForm."Pay Mode".EDITABLE:=TRUE;
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
        PayLines.SetRange(PayLines.No, "No.");
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
        PayLines.SetRange(PayLines.No, "No.");
        if PayLines.Find('-') then begin
            repeat
                if (PayLines."Account No." = '') or (PayLines.Amount <= 0) then
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
        PayLine.SetRange(PayLine.No, "No.");
        PayLine.SetRange(PayLine."Account Type", PayLine."account type"::Customer);
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


    // procedure InsertPvLine(prAssignEmpLoan: Record UnknownRecord51516303)
    // var
    //     PvLine: Record "Payment Line.";
    // begin
    //     /*PvLine.INIT;
    //       PvLine."Line No.":=0;
    //       PvLine.No:="No.";
    //       PvLine."Account Type":=PvLine."Account Type"::Customer;
    //       PvLine."Account No.":=prAssignEmpLoan."Employee Code";
    //       PvLine."Account Name":=prAssignEmpLoan."Transaction Name"+'Loan for employee'+prAssignEmpLoan."Employee Code";
    //       PvLine.Remarks:=prAssignEmpLoan."Transaction Name"+'Loan for employee'+prAssignEmpLoan."Employee Code";
    //       PvLine.VALIDATE(Amount,prAssignEmpLoan.Balance);
    //       PvLine."Loan No":=prAssignEmpLoan."Entry No";
    //     PvLine.INSERT;
    //      */

    // end;
}

