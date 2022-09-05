#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516133 "Payment Voucher"
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

    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Payments Header";

    layout
    {
        area(content)
        {
            group(Control1000000033)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Date; Date)
                {
                    ApplicationArea = Basic;
                    Editable = DateEditable;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = GlobalDimension1CodeEditable;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = ShortcutDimension2CodeEditable;
                    Visible = true;
                }
                field("Budget Center Name"; "Budget Center Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Dim3; Dim3)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Dim4; Dim4)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Pay Mode"; "Pay Mode")
                {
                    ApplicationArea = Basic;
                    Editable = PaymentModeEditable;
                }
                field("Cheque Type"; "Cheque Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque Type';
                    Editable = "Cheque TypeEditable";
                }
                field("Invoice Number"; "Invoice Number")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Paying Type"; "Paying Type")
                {
                    ApplicationArea = Basic;
                }
                field("Expense Type"; "Expense Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = CurrencyCodeEditable;
                    Visible = false;
                }
                field("Invoice Currency Code"; "Invoice Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Paying Bank Account"; "Paying Bank Account")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        // TESTFIELD("Responsibility Center");
                    end;
                }
                field("Paying Vendor Account"; "Paying Vendor Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Payee; Payee)
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment to';
                    Editable = PayeeEditable;
                }
                field("On Behalf Of"; "On Behalf Of")
                {
                    ApplicationArea = Basic;
                    Editable = OnBehalfEditable;
                }
                field("Payment Narration"; "Payment Narration")
                {
                    ApplicationArea = Basic;
                    Editable = "Payment NarrationEditable";
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
                field("Total Payment Amount"; "Total Payment Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total VAT Amount"; "Total VAT Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Witholding Tax Amount"; "Total Witholding Tax Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Retention Amount"; "Total Retention Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("""Total Payment Amount"" -( ""Total Witholding Tax Amount""+""Total VAT Amount""+""Total Retention Amount"")"; "Total Payment Amount" - ("Total Witholding Tax Amount" + "Total VAT Amount" + "Total Retention Amount"))
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Net Amount';
                }
                field("Total Payment Amount LCY"; "Total Payment Amount LCY")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Net Amount LCY';
                    Editable = false;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque/EFT No.';

                    trigger OnValidate()
                    begin
                        /*//check if the cheque has been inserted
                        TESTFIELD("Paying Bank Account");
                        PVHead.RESET;
                        PVHead.SETRANGE(PVHead."Paying Bank Account","Paying Bank Account");
                        PVHead.SETRANGE(PVHead."Pay Mode",PVHead."Pay Mode"::Cheque);
                        IF PVHead.FINDFIRST THEN
                          BEGIN
                            REPEAT
                              IF PVHead."Cheque No."="Cheque No." THEN
                                BEGIN
                                  IF PVHead."No."<>"No." THEN
                                    BEGIN
                                     ERROR('The Cheque Number has already been utilised');
                                    END;
                                END;
                            UNTIL PVHead.NEXT=0;
                          END;
                        
                        {IF "Pay Mode"="Pay Mode"::Cheque THEN BEGIN
                         IF STRLEN("Cheque No.") <> 6 THEN
                          ERROR('Document No. cannot contain More than 6 Characters.');
                        END;
                        }*/

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."External Document No.", "Cheque No.");
                        GLEntry.SetRange(GLEntry.Reversed, false);
                        if GLEntry.FindSet then begin
                            Error('The Cheque Number has already been utilised');
                        end;

                    end;
                }
                field("Payment Release Date"; "Payment Release Date")
                {
                    ApplicationArea = Basic;
                }
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
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Payment and Print';
                    Enabled = EnableCreateMember;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        //Post PV Entries
                        CurrPage.SaveRecord;
                        CheckPVRequiredItems;
                        //post pv
                        // DELETE ANY LINE ITEM THAT MAY BE PRESENT

                        /*BCSetup.GET;
                        IF NOT BCSetup.Mandatory THEN
                           EXIT;
                        
                            IF NOT AllFieldsEntered THEN
                             ERROR('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');
                          //First Check whether other lines are already committed.
                          Commitments.RESET;
                          Commitments.SETRANGE(Commitments."Document Type",Commitments."Document Type"::"Payment Voucher");
                          Commitments.SETRANGE(Commitments."Document No.","No.");
                          IF Commitments.FIND('-') THEN BEGIN
                            IF CONFIRM('Lines in this Document appear to be committed do you want to re-commit?',FALSE)=FALSE THEN BEGIN EXIT END;
                          Commitments.RESET;
                          Commitments.SETRANGE(Commitments."Document Type",Commitments."Document Type"::"Payment Voucher");
                          Commitments.SETRANGE(Commitments."Document No.","No.");
                          Commitments.DELETEALL;
                         END;
                        
                           CheckBudgetAvail.CheckPayments(Rec);*/

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

                            //TESTFIELD(Posted,TRUE);
                            PHeader2.Reset;
                            PHeader2.SetRange(PHeader2."No.", "No.");
                            if PHeader2.FindFirst then
                                Report.Run(51516125, true, true, PHeader2);

                            Post := false;
                            Post := JournlPosted.PostedSuccessfully();
                            //IF Post THEN  BEGIN
                            Posted := true;
                            Status := Payments.Status::Posted;
                            "Posted By" := UserId;
                            "Date Posted" := Today;
                            "Time Posted" := Time;
                            Modify;

                            // Modify PV LINES
                            PayLine.Reset;
                            PayLine.SetRange(PayLine.No, Payments."No.");
                            if PayLine.Find('-') then begin
                                PayLine.Posted := true;
                                PayLine."Date Posted" := Today;
                                PayLine.Status := PayLine.Status::Posted;
                                PayLine."Posted By" := UserId;
                                PayLine."Time Posted" := Time;
                                PayLine.Modify;
                            end;

                            // end of modifying PV lines

                            //Post Reversal Entries for Commitments
                            // Doc_Type:=Doc_Type::"Payment Voucher";
                            //CheckBudgetAvail.ReverseEntries(Doc_Type,"No.");
                            // END;
                        end;

                        Commit;

                        //end of post pv
                        //{
                        //Print Here
                        // RESET;
                        // SETFILTER("No.","No.");
                        // REPORT.RUN(51516125,TRUE,TRUE,Rec);
                        // RESET;
                        //End Print Here
                        //}

                    end;
                }
                separator(Action1102755026)
                {
                }
                action("4")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin

                        if "Paying Type" = "paying type"::" " then
                            Error('Kindly specify the paying type')

                        else
                            if ("Paying Vendor Account" <> '') and ("Paying Bank Account" <> '') then
                                Error('You cannot have both paying bank and paying vendor, choose one')

                            else
                                if ("Paying Type" = "paying type"::Vendor) and ("Paying Vendor Account" = '') then
                                    Error('Kindly spceify the paying vendor account')

                                else
                                    if ("Paying Type" = "paying type"::Bank) and ("Paying Bank Account" = '') then
                                        Error('Kindly spceify the paying bank account');


                        if not LinesExists then
                            Error('There are no Lines created for this Document');
                        //Ensure No Items That should be committed that are not
                        if LinesCommitmentStatus then
                            Error('There are some lines that have not been committed');
                        /*
                        PayLine.RESET;
                        PayLine.SETRANGE(PayLine.Type,"RFQ No.");
                        PayLine.SETRANGE(PayLine."Vendor No.",'MEMBER');
                        IF PayLine.FIND('-') THEN BEGIN
                        IF PayLine."Transaction Type"=PayLine."Transaction Type"::"0" THEN
                        ERROR('Transaction Type cannot be blank in payment lines');
                        END;
                        */
                        //TESTFIELD("Total Net Amount");
                        //Release the PV for Approval
                        if "Pay Mode" = "pay mode"::Cheque then
                            TestField("Cheque No.");
                        TestField(Payee);
                        TestField("Total Payment Amount");
                        TestField("Payment Narration");
                        ///ApprovalMgt.OnSendPaymentDocForApproval(Rec) ;
                        //ApprovalMgt.OnSendVendorForApproval(Rec) ;


                        Doc_Type := Doc_type::"Payment Voucher";
                        Table_id := Database::"Payments Header";
                        //IF Approvalmgt.SendApproval(Table_id,"No.",Doc_Type,Status)THEN;

                        // TESTFIELD("Cheque No.");
                        // TESTFIELD(Payee);
                        TestField("Total Payment Amount");
                        // IF ApprovalsMgmt.CheckPaymentApprovalsWorkflowEnabled(Rec) THEN
                        //  ApprovalsMgmt.IsPaymentApprovalsWorkflowEnabled(Rec);
                        Status := Status::Approved;

                        Modify;

                    end;
                }
                action("Cancel Approval REquest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        // Status:=Status::Pending;
                        //
                        //
                        if ApprovalsMgmt.CheckPaymentApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnCancelPaymentApprovalRequest(Rec);

                        Status := Status::Pending;
                        Modify;
                    end;
                }
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::"Payment Voucher";
                        ApprovalEntries.Setfilters(51516112, DocumentType, "No.");
                        ApprovalEntries.Run;
                    end;
                }
                separator(Action1102755009)
                {
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Caption = 'Print/Preview';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //TESTFIELD(Posted,TRUE);
                        PHeader2.Reset;
                        PHeader2.SetRange(PHeader2."No.", "No.");
                        if PHeader2.FindFirst then
                            Report.Run(51516125, true, true, PHeader2);
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
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        Text000: label 'Are you sure you want to cancel this Document?';
                        Text001: label 'You have selected not to Cancel the Document';
                    begin


                    end;
                }
                separator(Action1102755030)
                {
                }
                action("Check Budgetary Availability")
                {
                    ApplicationArea = Basic;
                    Image = Balance;
                    Promoted = true;

                    trigger OnAction()
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

                        //CheckBudgetAvail.CheckPayments(Rec);
                    end;
                }
                action("Cancel Budget Commitment")
                {
                    ApplicationArea = Basic;
                    Image = CancelAllLines;
                    Promoted = true;

                    trigger OnAction()
                    begin

                        TestField(Status, Status::Pending);
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
                action(PrintCheque)
                {
                    ApplicationArea = Basic;
                    Caption = 'Print Cheque';
                    Image = PrintCheck;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //TESTFIELD(Status,Status::Approved);
                        /*IF (Status=Status::Pending) OR  (Status=Status::"Pending Approval") THEN
                           ERROR('You cannot Print until the document is Approved'); */

                        PHeader2.Reset;
                        PHeader2.SetRange(PHeader2."No.", "No.");
                        if PHeader2.FindFirst then
                            Report.Run(51516030, true, true, PHeader2);

                        /*RESET;
                        SETRANGE("No.","No.");
                        IF "No." = '' THEN
                          REPORT.RUNMODAL(51516000,TRUE,TRUE,Rec)
                        ELSE
                          REPORT.RUNMODAL(51516344,TRUE,TRUE,Rec);
                        RESET;
                        */

                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        Approv: Codeunit "Approvals Mgmt.";
    begin
        UpdateControls();
        UpdateControls();
        EnableCreateMember := false;
        OpenApprovalEntriesExist := Approv.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := Approv.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (Rec.Status = Status::Approved) then
            EnableCreateMember := true;
    end;

    trigger OnInit()
    begin

        PVLinesEditable := true;
        DateEditable := true;
        PayeeEditable := true;
        "Payment NarrationEditable" := true;
        GlobalDimension1CodeEditable := true;
        CurrencyCodeEditable := true;
        "Invoice Currency CodeEditable" := true;
        "Cheque TypeEditable" := true;
        PaymentReleasDateEditable := true;
        "Cheque No.Editable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        "Payment Type" := "payment type"::Normal;
        "Responsibility Center" := UserMgt.GetPurchasesFilter;
        "Pay Mode" := "pay mode"::Cheque;
        "Paying Type" := "paying type"::Bank;
        "Cheque Type" := "cheque type"::"Manual Check";
        Date := Today;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        "Responsibility Center" := UserMgt.GetSalesFilter();
        //Add dimensions if set by default here
        // "Global Dimension 1 Code":=UserMgt.GetSetDimensions(USERID,1);
        "Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(UserId, 2);
        "Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(UserId, 3);
        Validate("Shortcut Dimension 3 Code");
        "Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(UserId, 4);
        Validate("Shortcut Dimension 4 Code");
        //"Responsibility Center":='FINANCE';
        "Shortcut Dimension 2 Code" := "Global Dimension 1 Code";
    end;

    trigger OnOpenPage()
    begin

        if UserMgt.GetPurchasesFilter() <> '' then begin
            FilterGroup(2);
            SetRange("Responsibility Center", UserMgt.GetPurchasesFilter());
            FilterGroup(0);
        end;
    end;

    var
        PayLine: Record "Payment Line";
        PVUsers: Record "CshMgt PV Steps Users";
        strFilter: Text[250];
        IntC: Integer;
        IntCount: Integer;
        Payments: Record "Payments Header";
        RecPayTypes: Record "Receipts and Payment Types";
        TarriffCodes: Record "Tariff Codes";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Cashier Link";
        LineNo: Integer;
        Temp: Record "Funds User Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        PCheck: Codeunit "Budgetary Control";
        Post: Boolean;
        strText: Text[100];
        PVHead: Record "Payments Header";
        BankAcc: Record "Bank Account";
        CheckBudgetAvail: Codeunit "Budgetary Control";
        Commitments: Record Committment;
        UserMgt: Codeunit "User Setup Management BR";
        JournlPosted: Codeunit "Journal Post Successful";
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication;
        DocPrint: Codeunit "Document-Print";
        CheckLedger: Record "Check Ledger Entry";
        Text001: label 'This Document no %1 has printed Cheque No %2 which will have to be voided first before reposting.';
        CheckManagement: Codeunit CheckManagement;
        Text000: label 'Do you want to Void Check No %1';
        Text002: label 'You have selected post and generate a computer cheque ensure that your cheque printer is ready do you want to continue?';
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        OnBehalfEditable: Boolean;
        [InDataSet]
        "Cheque No.Editable": Boolean;
        [InDataSet]
        PaymentReleasDateEditable: Boolean;
        [InDataSet]
        "Cheque TypeEditable": Boolean;
        [InDataSet]
        "Invoice Currency CodeEditable": Boolean;
        [InDataSet]
        CurrencyCodeEditable: Boolean;
        [InDataSet]
        GlobalDimension1CodeEditable: Boolean;
        [InDataSet]
        "Payment NarrationEditable": Boolean;
        [InDataSet]
        PayeeEditable: Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        PVLinesEditable: Boolean;
        [InDataSet]
        ShortcutDimension2CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension3CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension4CodeEditable: Boolean;
        PaymentModeEditable: Boolean;
        BCSetup: Record "Budgetary Control Setup";
        Text003: label 'Are you sure you want to print a cheque for this Payment.';
        GeneralSet: Record "Sacco General Set-Up";
        PHeader2: Record "Payments Header";
        Table_id: Integer;
        GLEntry: Record "Bank Account Ledger Entry";
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        EnableCreateMember: Boolean;


    procedure PostPaymentVoucher()
    begin

        //Post PV Entries
        CurrPage.SaveRecord;
        CheckPVRequiredItems;
        //post pv
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
            //IF Post THEN  BEGIN
            Posted := true;
            Status := Payments.Status::Posted;
            "Posted By" := UserId;
            "Date Posted" := Today;
            "Time Posted" := Time;
            Modify;

            //Post Reversal Entries for Commitments
            // Doc_Type:=Doc_Type::"Payment Voucher";
            //CheckBudgetAvail.ReverseEntries(Doc_Type,"No.");
            // END;
        end;

        Commit;
        //end of post pv
        //{
        //Print Here
        Reset;
        SetFilter("No.", "No.");
        Report.Run(51516004, true, true, Rec);
        Reset;
        //End Print Here
        //}
    end;


    procedure PostHeader(var Payment: Record "Payments Header")
    begin


        if (Payments."Pay Mode" = Payments."pay mode"::Cheque) and ("Cheque Type" = "cheque type"::" ") then
            Error('Cheque type has to be specified');

        if Payments."Pay Mode" = Payments."pay mode"::Cheque then begin
            if (Payments."Cheque No." = '') and ("Cheque Type" = "cheque type"::"Manual Check") then begin
                Error('Please ensure that the cheque number is inserted');
            end;
        end;

        if Payments."Pay Mode" = Payments."pay mode"::EFT then begin
            if Payments."Cheque No." = '' then begin
                Error('Please ensure that the EFT number is inserted');
            end;
        end;

        if Payments."Pay Mode" = Payments."pay mode"::"Letter of Credit" then begin
            if Payments."Cheque No." = '' then begin
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
            GenJnlLine."Document Type" := GenJnlLine."document type"::" ";
        GenJnlLine."Document No." := Payments."No.";
        GenJnlLine."External Document No." := Payments."Cheque No.";

        if "Paying Type" = "paying type"::Bank then begin
            GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
            GenJnlLine."Account No." := Payments."Paying Bank Account";
        end else
            if "Paying Type" = "paying type"::Vendor then begin
                GenJnlLine."Account Type" := GenJnlLine."account type"::Vendor;
                GenJnlLine."Account No." := Payments."Paying Vendor Account";
            end;
        GenJnlLine.Validate(GenJnlLine."Account No.");

        GenJnlLine."Currency Code" := Payments."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        //CurrFactor
        GenJnlLine."Currency Factor" := Payments."Currency Factor";
        GenJnlLine.Validate("Currency Factor");

        Payments.CalcFields(Payments."Total Net Amount", Payments."Total VAT Amount");
        GenJnlLine.Amount := -(Payments."Total Net Amount" + Payments."Total VAT Amount");
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';

        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        //GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
        //GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");

        GenJnlLine.Description := CopyStr('Pay To:' + Payments.Payee, 1, 50);
        GenJnlLine.Validate(GenJnlLine.Description);

        if "Pay Mode" <> "pay mode"::Cheque then begin
            GenJnlLine."Bank Payment Type" := GenJnlLine."bank payment type"::" "
        end else begin
            if "Cheque Type" = "cheque type"::"Computer Check" then
                GenJnlLine."Bank Payment Type" := GenJnlLine."bank payment type"::"Computer Check"
            else
                GenJnlLine."Bank Payment Type" := GenJnlLine."bank payment type"::" "

        end;
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;

        //SIMIYU
        /*
        GeneralSet.GET();
        IF Payment."Expense Type"=Payment."Expense Type"::Member THEN BEGIN
        LineNo:=LineNo+1000;
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name":=JTemplate;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name":=JBatch;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No.":=LineNo;
        GenJnlLine."Source Code":='PAYMENTJNL';
        GenJnlLine."Posting Date":=Payment."Payment Release Date";
        IF CustomerPayLinesExist THEN
         GenJnlLine."Document Type":=GenJnlLine."Document Type"::" "
        ELSE
          GenJnlLine."Document Type":=GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No.":=Payments."No.";
        GenJnlLine."External Document No.":=Payments."Cheque No.";
        
        IF "Paying Type"="Paying Type"::Bank THEN BEGIN
        GenJnlLine."Account Type":=GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No.":=Payments."Paying Bank Account";
        END ELSE IF "Paying Type"="Paying Type"::Vendor THEN BEGIN
        GenJnlLine."Account Type":=GenJnlLine."Account Type"::Vendor;
        GenJnlLine."Account No.":=Payments."Paying Vendor Account";
        END;
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
        
        GenJnlLine."Currency Code":=Payments."Currency Code";
        GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
          //CurrFactor
          GenJnlLine."Currency Factor":=Payments."Currency Factor";
          GenJnlLine.VALIDATE("Currency Factor");
        
        Payments.CALCFIELDS(Payments."Total Net Amount",Payments."Total VAT Amount","Refund Charge");
        GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
        
        IF "Pay Mode"= "Pay Mode"::Cheque THEN
            GenJnlLine."Account No.":=GeneralSet."Loan Trasfer Fee A/C-Cheque" ;
        IF "Pay Mode"= "Pay Mode"::FOSA THEN
            GenJnlLine."Account No.":=GeneralSet."Loan Trasfer Fee A/C-FOSA";
        IF "Pay Mode"= "Pay Mode"::EFT THEN
            GenJnlLine."Account No.":=GeneralSet."Loan Trasfer Fee A/C-EFT";
        
        GenJnlLine.Amount:=-(Payments."Refund Charge");
        GenJnlLine.VALIDATE(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No.":='';
        
        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code":=PayLine."Global Dimension 1 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code":=PayLine."Shortcut Dimension 2 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        //GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
        //GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
        
        GenJnlLine.Description:=COPYSTR('Pay To:' + Payments.Payee,1,50);
        GenJnlLine.VALIDATE(GenJnlLine.Description);
        
        IF "Pay Mode"<>"Pay Mode"::Cheque THEN  BEGIN
        GenJnlLine."Bank Payment Type":=GenJnlLine."Bank Payment Type"::" "
        END ELSE BEGIN
        IF "Cheque Type"="Cheque Type"::"Computer Check" THEN
         GenJnlLine."Bank Payment Type":=GenJnlLine."Bank Payment Type"::"Computer Check"
        ELSE
           GenJnlLine."Bank Payment Type":=GenJnlLine."Bank Payment Type"::" "
        
        END;
        END;
        IF GenJnlLine.Amount<>0 THEN
        GenJnlLine.INSERT;
        */




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
        Appl."Process Name" := "Current Status";
        // Appl."Process Machine":=ENVIRON('COMPUTERNAME');
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


    procedure CheckPVRequiredItems()
    begin

        if Posted then begin
            Error('The Document has already been posted');
        end;
        TestField("Payment Narration");
        //TESTFIELD(Status,Status::Approved);
        if "Paying Type" = "paying type"::Bank then
            TestField("Paying Bank Account")
        else
            if "Paying Type" = "paying type"::Vendor then
                TestField("Paying Vendor Account");

        TestField("Pay Mode");
        TestField("Payment Release Date");
        //Confirm whether Bank Has the Cash
        if "Pay Mode" = "pay mode"::Cash then
            // CheckBudgetAvail.CheckFundsAvailability(Rec);

            //Confirm Payment Release Date is today);
            if "Pay Mode" = "pay mode"::Cash then
                TestField("Payment Release Date", WorkDate);

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

        if ("Pay Mode" = "pay mode"::Cheque) and ("Cheque Type" = "cheque type"::"Computer Check") then begin
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


    procedure PostPV(var Payment: Record "Payments Header")
    begin


        PayLine.Reset;
        PayLine.SetRange(PayLine.No, Payments."No.");
        if PayLine.Find('-') then begin

            repeat
                strText := GetAppliedEntries(PayLine."Line No.");
                Payment.TestField(Payment.Payee);
                PayLine.TestField(PayLine.Amount);
                PayLine.TestField(PayLine."Global Dimension 1 Code");


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

                //Bett
                if PayLine."Account Type" = PayLine."account type"::Member then begin
                    GenJnlLine."Document Type" := GenJnlLine."document type"::" ";
                    GenJnlLine."Transaction Type" := PayLine."Transaction Type";
                    GenJnlLine."Loan No" := PayLine."Loan No.";
                end else
                    GenJnlLine."Document Type" := GenJnlLine."document type"::Payment;

                if PayLine."Account Type" = PayLine."account type"::Customer then
                    GenJnlLine."Document Type" := GenJnlLine."document type"::" "
                else
                    GenJnlLine."Document Type" := GenJnlLine."document type"::" ";
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."External Document No." := Payments."Cheque No.";
                GenJnlLine.Description := CopyStr(PayLine."Transaction Name" + ':' + Payment.Payee, 1, 50);
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine."Currency Factor" := Payments."Currency Factor";
                GenJnlLine.Validate("Currency Factor");
                if PayLine."VAT Code" = '' then begin
                    GenJnlLine.Amount := PayLine."Net Amount" + PayLine."VAT Amount";
                end
                else begin
                    GenJnlLine.Amount := PayLine."Net Amount" + PayLine."VAT Amount";
                end;
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."VAT Prod. Posting Group" := PayLine."VAT Prod. Posting Group";
                GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                //GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
                //GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."applies-to doc. type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Applies-to Doc. No.";
                GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Applies-to ID";

                if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;








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
                    GenJnlLine."Document Type" := GenJnlLine."document type"::" ";
                    GenJnlLine."Document No." := PayLine.No;
                    GenJnlLine."External Document No." := Payments."Cheque No.";
                    GenJnlLine."Account Type" := TarriffCodes."Account Type";
                    GenJnlLine."Account No." := TarriffCodes."Account No.";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine."Currency Code" := Payments."Currency Code";
                    GenJnlLine.Validate(GenJnlLine."Currency Code");
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
                    GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    //GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
                    //GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");
                    if GenJnlLine.Amount <> 0 then
                        GenJnlLine.Insert;
                end;

                //POST retention to Respective retention GL Account
                TarriffCodes.Reset;
                TarriffCodes.SetRange(TarriffCodes.Code, PayLine."Retention Code");
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
                    GenJnlLine."Document Type" := GenJnlLine."document type"::" ";
                    GenJnlLine."Document No." := PayLine.No;
                    GenJnlLine."External Document No." := Payments."Cheque No.";
                    GenJnlLine."Account Type" := TarriffCodes."Account Type";
                    GenJnlLine."Account No." := TarriffCodes."Account No.";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine."Currency Code" := Payments."Currency Code";
                    GenJnlLine.Validate(GenJnlLine."Currency Code");
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
                    GenJnlLine.Amount := -PayLine."Retention  Amount";
                    GenJnlLine.Validate(GenJnlLine.Amount);
                    //GenJnlLine."Bal. Account Type":=PayLine."Account Type";
                    //GenJnlLine."Bal. Account No.":=PayLine."Account No.";
                    //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                    GenJnlLine.Description := CopyStr('Retention:' + Format(PayLine."Account Name") + '::' + strText, 1, 50);
                    GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    //GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
                    //GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");
                    if GenJnlLine.Amount <> 0 then
                        GenJnlLine.Insert;
                end;

                //Retention balancing account
                LineNo := LineNo + 1000;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Payment."Payment Release Date";
                GenJnlLine."Document Type" := GenJnlLine."document type"::" ";
                GenJnlLine."Document No." := PayLine.No;
                GenJnlLine."External Document No." := Payments."Cheque No.";
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.Validate(GenJnlLine."Currency Code");
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
                GenJnlLine.Amount := PayLine."Retention  Amount";
                GenJnlLine.Validate(GenJnlLine.Amount);
                //GenJnlLine."Bal. Account Type":=PayLine."Account Type";
                // GenJnlLine."Bal. Account No.":=PayLine."Account No.";
                // GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine.Description := CopyStr('Retention:' + Format(PayLine."Account Name") + '::' + strText, 1, 50);
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                //GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
                //GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;
                //END POSTING RETENTION

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
                GenJnlLine."Document Type" := GenJnlLine."document type"::" ";
                GenJnlLine."Document No." := PayLine.No;
                GenJnlLine."External Document No." := Payments."Cheque No.";
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.Validate(GenJnlLine."Currency Code");
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
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                //GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
                //GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."applies-to doc. type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Apply to";
                GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Apply to ID";
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;


            //IF PVHead."Pay Mode"=PVHead."Pay Mode"::Cheque THEN BEGIN

            //SIMIYU
            /*
         IF PayLine."Account Type"=PayLine."Account Type"::Member THEN BEGIN
         IF PayLine."Refund Charge">0 THEN BEGIN
           LineNo:=LineNo+1000;
         GenJnlLine."Document Type":=GenJnlLine."Document Type"::" ";
         GenJnlLine."Transaction Type":=PayLine."Transaction Type";
         GenJnlLine."Loan No":=PayLine."Loan No.";
         END ELSE
           GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;

         IF PayLine."Account Type"=PayLine."Account Type"::Customer THEN
         GenJnlLine."Document Type":=GenJnlLine."Document Type"::" "
         ELSE
         GenJnlLine."Document Type":=GenJnlLine."Document Type"::" ";
         GenJnlLine."Account Type":=PayLine."Account Type";
         GenJnlLine."Account No.":=PayLine."Account No.";
         GenJnlLine.VALIDATE(GenJnlLine."Account No.");
         GenJnlLine."External Document No.":=Payments."Cheque No.";
         GenJnlLine.Description:=COPYSTR(PayLine."Transaction Name" + ':' + Payment.Payee,1,50);
         GenJnlLine."Currency Code":=Payments."Currency Code";
         GenJnlLine.VALIDATE("Currency Code");
         GenJnlLine."Currency Factor":=Payments."Currency Factor";
         GenJnlLine.VALIDATE("Currency Factor");
         IF PayLine."VAT Code"='' THEN
           BEGIN
             GenJnlLine.Amount:=PayLine."Refund Charge" ;
           END
         ELSE
           BEGIN
             GenJnlLine.Amount:=PayLine."Refund Charge";
           END;
         GenJnlLine.VALIDATE(GenJnlLine.Amount);
         GenJnlLine."VAT Prod. Posting Group":=PayLine."VAT Prod. Posting Group";
         GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
         //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
         GenJnlLine."Shortcut Dimension 1 Code":=PayLine."Global Dimension 1 Code";
         GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
         GenJnlLine."Shortcut Dimension 2 Code":=PayLine."Shortcut Dimension 2 Code";
         GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
         //GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
         //GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");
         GenJnlLine."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Invoice;
         GenJnlLine."Applies-to Doc. No.":=PayLine."Applies-to Doc. No.";
         GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
         GenJnlLine."Applies-to ID":=PayLine."Applies-to ID";

         IF GenJnlLine.Amount<>0 THEN GenJnlLine.INSERT;
         END;
        */

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
            if ("Pay Mode" = "pay mode"::Cheque) and ("Cheque Type" = "cheque type"::"Computer Check") then begin
                DocPrint.PrintCheck(GenJnlLine);
                Codeunit.Run(Codeunit::"Adjust Gen. Journal Balance", GenJnlLine);
                //Confirm Cheque printed //Not necessary.
            end;







            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnlLine);
            Post := false;
            Post := JournlPosted.PostedSuccessfully();
            if Post then begin
                if PayLine.FindFirst then begin
                    repeat
                    //PayLine."Date Posted":=TODAY;
                    //PayLine."Time Posted":=TIME;
                    //PayLine."Posted By":=USERID;
                    //PayLine.Status:=PayLine.Status::Posted;
                    //PayLine.MODIFY;
                    until PayLine.Next = 0;
                end;
            end;

        end;

    end;


    procedure UpdateControls()
    begin

        if Status <> Status::Approved then begin
            PaymentReleasDateEditable := false;
            //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
            //CurrForm."Pay Mode".EDITABLE:=FALSE;
            //CurrForm."Currency Code".EDITABLE:=TRUE;
            "Cheque No.Editable" := false;
            "Cheque TypeEditable" := false;
            "Invoice Currency CodeEditable" := true;
            OnBehalfEditable := true;
            PaymentModeEditable := true;
            GlobalDimension1CodeEditable := true;
        end else begin
            PaymentReleasDateEditable := true;
            //CurrForm."Paying Bank Account".EDITABLE:=TRUE;
            //CurrForm."Pay Mode".EDITABLE:=TRUE;
            if "Pay Mode" = "pay mode"::Cheque then
                "Cheque TypeEditable" := true;
            //CurrForm."Currency Code".EDITABLE:=FALSE;
            if "Cheque Type" <> "cheque type"::"Computer Check" then
                "Cheque No.Editable" := true;
            "Invoice Currency CodeEditable" := false;
        end;

        if Status = Status::Pending then begin
            CurrencyCodeEditable := true;
            GlobalDimension1CodeEditable := true;
            "Payment NarrationEditable" := true;
            ShortcutDimension2CodeEditable := true;
            PayeeEditable := true;
            OnBehalfEditable := true;
            PaymentModeEditable := true;
            ShortcutDimension3CodeEditable := true;
            ShortcutDimension4CodeEditable := true;
            "Cheque TypeEditable" := true;
            DateEditable := true;
            PVLinesEditable := true;

        end else begin
            CurrencyCodeEditable := false;
            GlobalDimension1CodeEditable := false;
            "Payment NarrationEditable" := false;
            ShortcutDimension2CodeEditable := false;
            PayeeEditable := false;
            OnBehalfEditable := false;
            PaymentModeEditable := true;
            ShortcutDimension3CodeEditable := false;
            ShortcutDimension4CodeEditable := false;
            DateEditable := false;
            PVLinesEditable := false;
            "Cheque TypeEditable" := true;
        end
    end;


    procedure LinesExists(): Boolean
    var
        PayLines: Record "Payment Line";
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
        PayLines: Record "Payment Line";
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
        PayLine: Record "Payment Line";
    begin

        PayLine.Reset;
        PayLine.SetRange(PayLine.No, "No.");
        PayLine.SetRange(PayLine."Account Type", PayLine."account type"::Customer);
        exit(PayLine.FindFirst);
    end;
}

