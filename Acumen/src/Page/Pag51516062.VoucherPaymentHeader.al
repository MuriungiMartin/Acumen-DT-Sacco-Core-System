#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516062 "Voucher Payment Header"
{
    Caption = 'Voucher Payment Header';
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Payment Header.";
    SourceTableView = where("Payment Type" = const(Normal));

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Date; Date)
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Description"; "Payment Description")
                {
                    ApplicationArea = Basic;
                }
                field("Created By:"; Cashier)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank Account"; "Bank Account")
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
                }
                field("On Behalf Of"; "On Behalf Of")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("VAT Amount"; "VAT Amount")
                {
                    ApplicationArea = Basic;
                }
                field("WithHolding Tax Amount"; "WithHolding Tax Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Amount(LCY)"; "Amount(LCY)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Net Amount LCY';
                    Editable = false;
                }
                field("Payment Release Date"; "Payment Release Date")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Mode"; "Payment Mode")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Pay Mode"; "Pay Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No"; "Cheque No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ext Doc No./ Cheque No.';
                }
            }
            part(PVLines; "Voucher Payment Lines")
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
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        //Post PV Entries

                        //TESTFIELD("Payment Release Date",WORKDATE);
                        CheckPVRequiredItems(Rec);
                        PostPaymentVoucher(Rec);
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
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::"Petty Cash";
                        //ApprovalEntries.Setfilters(DATABASE::"Payments Header",DocumentType,"No.");
                        //ApprovalEntries.RUN;
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
                        TestField("Global Dimension 1 Code");
                        TestField("Global Dimension 2 Code");
                        TestField(Payee);
                        TestField("Responsibility Center");

                        if not LinesExists then
                            Error('There are no Lines created for this Document');

                        if not AllFieldsEntered then
                            Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                        //Ensure No Items That should be committed that are not
                        if LinesCommitmentStatus then
                            Error('There are some lines that have not been committed');

                        //Release the PV for Approval
                        //IF ApprovalMgt.SendApprovalRequestFromRecord THEN;
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
                        if not (Status = Status::"Pending Approval") then begin
                            Error('Document must be Pending/Open');
                        end;

                        BCSetup.Get;
                        if not BCSetup.Mandatory then
                            exit;

                        if not AllFieldsEntered then
                            Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                        //First Check whether other lines are already committed.
                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."document type"::PettyCash);
                        Commitments.SetRange(Commitments."Document No.", "No.");
                        if Commitments.Find('-') then begin
                            if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then begin exit end;
                            Commitments.Reset;
                            Commitments.SetRange(Commitments."Document Type", Commitments."document type"::PettyCash);
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
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if not (Status = Status::"Pending Approval") then begin
                            Error('Document must be Pending/Open');
                        end;

                        if Confirm('Do you Wish to Cancel the Commitment entries for this document', false) = false then begin exit end;

                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."document type"::PettyCash);
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
                        //TESTFIELD(Status,Status::Approved);
                        /*IF (Status=Status::Pending) OR  (Status=Status::"Pending Approval") THEN
                           ERROR('You cannot Print until the document is Approved'); */

                        PHeader2.Reset;
                        PHeader2.SetRange(PHeader2."No.", "No.");
                        if PHeader2.FindFirst then
                            Report.Run(51516017, true, true, PHeader2);

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
                separator(Action1102756004)
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
                        Text000: label 'Are you sure you want to cancel this document?';
                        Text001: label 'You have Selected not to cancle this document';
                    begin
                        //TESTFIELD(Status,Status::Approved);
                        if Confirm(Text000, true) then begin
                            //Post Reversal Entries for Commitments
                            Doc_Type := Doc_type::PettyCash;
                            CheckBudgetAvail.ReverseEntries(Doc_Type, "No.");
                            Status := Status::Cancelled;
                            Modify;
                        end else
                            Error(Text001);
                    end;
                }
                action("Print Check")
                {
                    ApplicationArea = Basic;
                    Caption = 'Print Check';
                    Image = PrintCheck;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Status <> Status::Approved then
                            Error('You can only print a Check after it Fully Approved');

                        Payments.Reset;
                        Payments.SetRange(Payments."No.", "No.");
                        if Payments.Find('-') then
                            Report.Run(51516030, false, true, Payments)
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //OnCurrRecord;
        CurrPageUpdate;
    end;

    trigger OnInit()
    begin
        PVLinesEditable := true;
        DateEditable := true;
        PayeeEditable := true;
        "Payment NarrationEditable" := true;
        ShortcutDimension2CodeEditable := true;
        GlobalDimension1CodeEditable := true;
        "Currency CodeEditable" := true;
        "Payment Release DateEditable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        "Payment Type" := "payment type"::Normal;
        "Payment Mode" := "payment mode"::Cheque;
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

        UpdateControls;
        "Payment Type" := "payment type"::Normal;
        "Payment Mode" := "payment mode"::Cheque;
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

        UpdatePageControl;
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
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        [InDataSet]
        "Payment Release DateEditable": Boolean;
        [InDataSet]
        "Currency CodeEditable": Boolean;
        [InDataSet]
        GlobalDimension1CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension2CodeEditable: Boolean;
        [InDataSet]
        "Payment NarrationEditable": Boolean;
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
        GenLedgerSetup: Record "Cash Office Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PHeader2: Record "Payment Header.";


    procedure UpdatePageControl()
    var
        PvUser: Record "CshMgt PV Steps Users";
    begin
        if Status <> Status::Approved then begin
            "Payment Release DateEditable" := false;
            //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
            //CurrPage.UpdatePageControl();
        end else begin
            "Payment Release DateEditable" := true;
            //CurrForm."Paying Bank Account".EDITABLE:=TRUE;
            "Currency CodeEditable" := false;
            //CurrPage.UpdateControls();
        end;

        if Status = Status::"Pending Approval" then begin
            GlobalDimension1CodeEditable := true;
            ShortcutDimension2CodeEditable := true;
            "Payment NarrationEditable" := true;
            PayeeEditable := true;
            ShortcutDimension3CodeEditable := true;
            ShortcutDimension4CodeEditable := true;
            "Currency CodeEditable" := true;
            DateEditable := true;
            PVLinesEditable := true;


            //CurrPage.UpdateControls();
        end else begin
            GlobalDimension1CodeEditable := false;
            ShortcutDimension2CodeEditable := false;
            "Payment NarrationEditable" := false;
            PayeeEditable := true;
            ShortcutDimension3CodeEditable := false;
            ShortcutDimension4CodeEditable := false;
            DateEditable := false;
            "Currency CodeEditable" := false;
            PVLinesEditable := false;


            //CurrPage.UpdateControls();
        end
    end;


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
                Doc_Type := Doc_type::PettyCash;
                CheckBudgetAvail.ReverseEntries(Doc_Type, "No.");
            end;
        end;
    end;


    procedure PostHeader(var Payment: Record "Payment Header.")
    begin

        if Payments."Payment Mode" = Payments."payment mode"::Cheque then begin
            if Payments."Cheque No" = '' then begin
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
        GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");

        GenJnlLine.Description := CopyStr("Payment Description", 1, 50);//COPYSTR('Pay To:' + Payments.Payee,1,50);
        GenJnlLine.Validate(GenJnlLine.Description);
        GenJnlLine."Bank Payment Type" := GenJnlLine."bank payment type"::" ";

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


    procedure CheckPVRequiredItems(Rec: Record "Payment Header.")
    begin
        if Posted then begin
            Error('The Document has already been posted');
        end;

        //TESTFIELD(Status,Status::Approved);
        TestField("Bank Account");
        TestField("Payment Mode");
        TestField("Payment Release Date");

        //Confirm whether Bank Has the Cash
        if "Payment Mode" = "payment mode"::Cash then
            CheckBudgetAvail.CheckFundsAvailability(Rec);

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

    end;


    procedure PostPV(var Payment: Record "Payment Header.")
    var
        StaffClaim: Record "Staff Claims Header";
        AdvanceHeader: Record "Imprest Header";
        PayReqHeader: Record "Payment Header.";
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

                //Surestep
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
                GenJnlLine."External Document No." := Payments."Cheque No";
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
                    GenJnlLine."External Document No." := Payments."Cheque No";
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
                    GenJnlLine."External Document No." := Payments."Cheque No";
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
                GenJnlLine."External Document No." := Payments."Cheque No";
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
                GenJnlLine."External Document No." := Payments."Cheque No";
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
            if ("Pay Mode" = "pay mode"::Cheque) and ("Cheque Type" = "cheque type"::"Computer Cheque") then begin
                //DocPrint.PrintCheck(GenJnlLine);
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

    local procedure OnCurrRecord()
    begin
        xRec := Rec;
        UpdatePageControl();

        //Set the filters here
        SetRange(Posted, false);
        SetRange("Payment Type", "payment type"::"Petty Cash");
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
        UpdatePageControl;
        CurrPage.Update;
    end;
}

