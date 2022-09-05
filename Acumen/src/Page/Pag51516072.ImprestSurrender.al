#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516072 "Imprest Surrender"
{
    Caption = 'Travel Imprest Surrender';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Cancellation,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Imprest Surrender Header";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Surrender Date"; "Surrender Date")
                {
                    ApplicationArea = Basic;
                    Editable = "Surrender DateEditable";
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = "Account No.Editable";

                    trigger OnValidate()
                    begin
                        AccountName := GetCustName("Account No.");
                    end;
                }
                field(AccountName; AccountName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Name';
                    Editable = false;
                }
                field("Imprest Issue Doc. No"; "Imprest Issue Doc. No")
                {
                    ApplicationArea = Basic;
                    Editable = "Imprest Issue Doc. NoEditable";
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Imprest Issue Date"; "Imprest Issue Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        DimName1 := GetDimensionName("Global Dimension 1 Code", 1);
                    end;
                }
                field(DimName1; DimName1)
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        DimName2 := GetDimensionName("Shortcut Dimension 2 Code", 2);
                    end;
                }
                field(DimName2; DimName2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    Editable = false;
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
                    Caption = 'Description';
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
                    Caption = 'Description';
                    Editable = false;
                    Visible = false;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Date Posted"; "Date Posted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Cashier; Cashier)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = "Responsibility CenterEditable";
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            label(Control1102755001)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19053222;
                Style = Standard;
                StyleExpr = true;
            }
            part(ImprestLines; "Imprest Surrender Details")
            {
                Editable = ImprestLinesEditable;
                SubPageLink = "Surrender Doc No." = field(No);
            }
            systempart(Control2; Links)
            {
                Visible = true;
            }
            systempart(Control1; Notes)
            {
                Visible = true;
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
                action(Approvals)
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
                        DocumentType := Documenttype::ImprestSurrender;
                        ApprovalEntries.Setfilters(Database::"Imprest Surrender Header", DocumentType, No);
                        ApprovalEntries.Run;
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
                        Text001: label 'This Batch is already pending approval';
                        ApprovalsMgmt: Codeunit WorkflowIntegration;
                    begin

                        if ApprovalsMgmt.CheckImprestSurrenderApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendImprestSurrenderForApproval(Rec);
                    end;
                }
                action("Canel Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit WorkflowIntegration;
                    begin
                        //IF ApprovalMgt.CancelBatchAppr(Rec,TRUE,TRUE) THEN;
                    end;
                }
                separator(Action1000000000)
                {
                }
                action("Cancel Document")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Document';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //Post Committment Reversals
                        TestField(Status, Status::"9");
                        if Confirm(Text002, true) then begin
                            Doc_Type := Doc_type::Imprest;
                            BudgetControl.ReverseEntries(Doc_Type, "Imprest Issue Doc. No");
                            Status := Status::"5";
                            Modify;
                        end;
                    end;
                }
            }
            action(Post)
            {
                ApplicationArea = Basic;
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                var
                    Txt0001: label 'Actual Spent and the Cash Receipt Amount should be equal to the amount Issued';
                begin



                    //TESTFIELD(Status,Status::Approved);

                    if Posted then
                        Error('The transaction has already been posted.');

                    //HOW ABOUT WHERE ONE RETURNS ALL THE AMOUNT??
                    //THERE SHOULD BE NO GENJNL ENTRIES BUT REVERSE THE COMMITTMENTS
                    CalcFields("Actual Spent");
                    if "Actual Spent" = 0 then
                        if Confirm(Text000, true) then
                            UpdateforNoActualSpent
                        else
                            Error(Text001);

                    // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                    //IF GenledSetup.GET THEN BEGIN
                    GenledSetup.Reset;
                    GenledSetup.SetRange(GenledSetup.UserID, UserId);
                    if GenledSetup.FindSet then begin
                        GenJnlLine.Reset;
                        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", GenledSetup."Imprest Template");
                        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", GenledSetup."Imprest  Batch");
                        GenJnlLine.DeleteAll;
                    end;
                    //END;

                    /*IF DefaultBatch.GET(GenledSetup."Imprest Template",GenledSetup."Imprest  Batch") THEN BEGIN
                         DefaultBatch.DELETE;
                    END;
                    
                    DefaultBatch.RESET;
                    DefaultBatch."Journal Template Name":=GenledSetup."Imprest Template";
                    DefaultBatch.Name:=GenledSetup."Imprest  Batch";
                    DefaultBatch.INSERT;*/
                    LineNo := 0;

                    ImprestDetails.Reset;
                    ImprestDetails.SetRange(ImprestDetails."Surrender Doc No.", No);
                    if ImprestDetails.Find('-') then begin
                        repeat
                            //Post Surrender Journal
                            //Compare the amount issued =amount on cash reciecied.
                            //Created new field for zero spent
                            //
                            //GenledSetup.GET();
                            //ImprestDetails.TESTFIELD("Actual Spent");
                            //ImprestDetails.TESTFIELD("Actual Spent");
                            if (ImprestDetails."Cash Receipt Amount" + ImprestDetails."Actual Spent") <> ImprestDetails.Amount then
                                Error(Txt0001);

                            TestField("Global Dimension 1 Code");

                            LineNo := LineNo + 1000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := GenledSetup."Imprest Template";
                            GenJnlLine."Journal Batch Name" := GenledSetup."Imprest  Batch";
                            GenJnlLine."Line No." := LineNo;
                            GenJnlLine."Source Code" := 'PAYMENTJNL';
                            GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
                            GenJnlLine."Account No." := ImprestDetails."Account No:";
                            GenJnlLine.Validate(GenJnlLine."Account No.");
                            //Set these fields to blanks
                            GenJnlLine."Posting Date" := "Surrender Date";
                            GenJnlLine."Gen. Posting Type" := GenJnlLine."gen. posting type"::" ";
                            GenJnlLine.Validate("Gen. Posting Type");
                            GenJnlLine."Gen. Bus. Posting Group" := '';
                            GenJnlLine.Validate("Gen. Bus. Posting Group");
                            GenJnlLine."Gen. Prod. Posting Group" := '';
                            GenJnlLine.Validate("Gen. Prod. Posting Group");
                            GenJnlLine."VAT Bus. Posting Group" := '';
                            GenJnlLine.Validate("VAT Bus. Posting Group");
                            GenJnlLine."VAT Prod. Posting Group" := '';
                            GenJnlLine.Validate("VAT Prod. Posting Group");
                            GenJnlLine."Document No." := No;
                            GenJnlLine.Amount := ImprestDetails."Actual Spent";
                            GenJnlLine.Validate(GenJnlLine.Amount);
                            GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::Customer;
                            GenJnlLine."Bal. Account No." := ImprestDetails."Imprest Holder";
                            GenJnlLine.Description := 'Imprest Surrendered by staff';
                            GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                            GenJnlLine."Currency Code" := "Currency Code";
                            GenJnlLine.Validate("Currency Code");
                            //Take care of Currency Factor
                            GenJnlLine."Currency Factor" := "Currency Factor";
                            GenJnlLine.Validate("Currency Factor");

                            GenJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                            GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                            GenJnlLine.ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                            GenJnlLine.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");

                            //Application of Surrender entries
                            if GenJnlLine."Bal. Account Type" = GenJnlLine."bal. account type"::Customer then begin
                                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."applies-to doc. type"::Invoice;
                                GenJnlLine."Applies-to Doc. No." := "Imprest Issue Doc. No";
                                GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                                GenJnlLine."Applies-to ID" := "Apply to ID";
                            end;

                            if GenJnlLine.Amount <> 0 then
                                GenJnlLine.Insert;

                            //Post Cash Surrender
                            if ImprestDetails."Cash Surrender Amt" > 0 then begin
                                if ImprestDetails."Bank/Petty Cash" = '' then
                                    Error('Select a Bank Code where the Cash Surrender will be posted');
                                LineNo := LineNo + 1000;
                                GenJnlLine.Init;
                                GenJnlLine."Journal Template Name" := GenledSetup."Imprest Template";
                                GenJnlLine."Journal Batch Name" := GenledSetup."Imprest  Batch";
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Account Type" := GenJnlLine."account type"::Customer;
                                GenJnlLine."Account No." := ImprestDetails."Imprest Holder";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                //Set these fields to blanks
                                GenJnlLine."Gen. Posting Type" := GenJnlLine."gen. posting type"::" ";
                                GenJnlLine.Validate("Gen. Posting Type");
                                GenJnlLine."Gen. Bus. Posting Group" := '';
                                GenJnlLine.Validate("Gen. Bus. Posting Group");
                                GenJnlLine."Gen. Prod. Posting Group" := '';
                                GenJnlLine.Validate("Gen. Prod. Posting Group");
                                GenJnlLine."VAT Bus. Posting Group" := '';
                                GenJnlLine.Validate("VAT Bus. Posting Group");
                                GenJnlLine."VAT Prod. Posting Group" := '';
                                GenJnlLine.Validate("VAT Prod. Posting Group");
                                GenJnlLine."Posting Date" := "Surrender Date";
                                GenJnlLine."Document No." := No;
                                GenJnlLine.Amount := -ImprestDetails."Cash Surrender Amt";
                                GenJnlLine.Validate(GenJnlLine.Amount);
                                GenJnlLine."Currency Code" := "Currency Code";
                                GenJnlLine.Validate("Currency Code");
                                //Take care of Currency Factor
                                GenJnlLine."Currency Factor" := "Currency Factor";
                                GenJnlLine.Validate("Currency Factor");

                                GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"Bank Account";
                                GenJnlLine."Bal. Account No." := ImprestDetails."Bank/Petty Cash";
                                GenJnlLine.Description := 'Imprest Surrender by staff';
                                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                                GenJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine.ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                                GenJnlLine.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
                                GenJnlLine."Applies-to ID" := ImprestDetails."Imprest Holder";
                                if GenJnlLine.Amount <> 0 then
                                    GenJnlLine.Insert;

                            end;

                        //End Post Surrender Journal

                        until ImprestDetails.Next = 0;
                        //Post Entries
                        GenJnlLine.Reset;
                        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", GenledSetup."Imprest Template");
                        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", GenledSetup."Imprest  Batch");
                        //Adjust Gen Jnl Exchange Rate Rounding Balances
                        AdjustGenJnl.Run(GenJnlLine);
                        //End Adjust Gen Jnl Exchange Rate Rounding Balances

                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Line", GenJnlLine);
                    end;


                    Post := false;
                    Post := JournlPosted.PostedSuccessfully();
                    //IF Post THEN BEGIN


                    Posted := true;
                    "Date Posted" := Today;
                    "Time Posted" := Time;
                    "Posted By" := UserId;
                    Status := Status::"4";
                    Modify;
                    //END;
                    Message('Transaction Posted Succesfully');

                    //Tag the Source Imprest Requisition as Surrendered
                    ImprestReq.Reset;
                    ImprestReq.SetRange(ImprestReq."No.", "Imprest Issue Doc. No");
                    if ImprestReq.Find('-') then begin
                        ImprestReq."Surrender Status" := ImprestReq."surrender status"::Full;
                        ImprestReq.Modify;
                    end;


                    Posted := true;
                    Status := Status::"4";
                    "Date Posted" := Today;
                    "Time Posted" := Time;
                    "Posted By" := UserId;
                    Modify;


                    //End Tag
                    //Post Committment Reversals
                    Doc_Type := Doc_type::Imprest;
                    BudgetControl.ReverseEntries(Doc_Type, "Imprest Issue Doc. No");
                    //END;

                end;
            }
            action(Print)
            {
                ApplicationArea = Basic;
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Reset;
                    SetFilter(No, No);
                    Report.Run(51516336, true, true, Rec);
                    Reset;
                end;
            }
            action("Get Imprest Document")
            {
                ApplicationArea = Basic;
                Caption = 'Get Imprest Document';
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if "Imprest Issue Doc. No" = '' then
                        Error('Please Select the Imprest Issue Document Number');

                    PaymentLine.Reset;
                    PaymentLine.SetRange(PaymentLine.No, "Imprest Issue Doc. No");
                    Page.RunModal(51516792, PaymentLine);
                end;
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
        ImprestLinesEditable := true;
        "Responsibility CenterEditable" := true;
        "Imprest Issue Doc. NoEditable" := true;
        "Account No.Editable" := true;
        "Surrender DateEditable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        //check if the documenent has been added while another one is still pending
        TravAccHeader.Reset;
        TravAccHeader.SetRange(TravAccHeader.Cashier, UserId);
        TravAccHeader.SetRange(TravAccHeader.Status, Status::Open);

        //IF TravAccHeader.COUNT>0 THEN
        //  BEGIN
        // ERROR('There are still some pending document(s) on your account. Please list & select the pending document to use.  ');
        // END;
        //*********************************END ****************************************//

        "User ID" := UserId;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Responsibility Center" := UserMgt.GetPurchasesFilter();
        //OnAfterGetCurrRecord;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        //SETFILTER(Status,'<>Cancelled');

        if UserMgt.GetPurchasesFilter() <> '' then begin
            FilterGroup(2);
            SetRange("Responsibility Center", UserMgt.GetPurchasesFilter());
            FilterGroup(0);
        end;
        AccountName := GetCustName("Account No.");
    end;

    var
        RecPayTypes: Record "Receipts and Payment Types";
        TarriffCodes: Record "Tariff Codes";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Cash Office User Template";
        LineNo: Integer;
        NextEntryNo: Integer;
        CommitNo: Integer;
        ImprestDetails: Record "Imprest Surrender Details";
        EntryNo: Integer;
        GLAccount: Record "G/L Account";
        IsImprest: Boolean;
        ImprestRequestDet: Record "Payments-Users";
        GenledSetup: Record "Funds User Setup";
        ImprestAmt: Decimal;
        DimName1: Text[60];
        DimName2: Text[60];
        CashPaymentLine: Record "Cash Payment Line";
        PaymentLine: Record "Imprest Lines";
        CurrSurrDocNo: Code[20];
        JournalPostSuccessful: Codeunit "Journal Post Successful";
        Commitments: Record Committment;
        BCSetup: Record "Budgetary Control Setup";
        BudgetControl: Codeunit "Budgetary Control";
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        ImprestReq: Record "Imprest Header";
        UserMgt: Codeunit "User Setup Management BR";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        AccountName: Text[100];
        Text000: label 'You have not specified the Actual Amount Spent. This document will only reverse the committment and you will have to receipt the total amount returned.';
        Text001: label 'Document Not Posted';
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        Text002: label 'Are you sure you want to Cancel this Document?';
        [InDataSet]
        "Surrender DateEditable": Boolean;
        [InDataSet]
        "Account No.Editable": Boolean;
        [InDataSet]
        "Imprest Issue Doc. NoEditable": Boolean;
        [InDataSet]
        "Responsibility CenterEditable": Boolean;
        [InDataSet]
        ImprestLinesEditable: Boolean;
        Text19053222: label 'Enter Advance Accounting Details below';
        TravAccHeader: Record "Imprest Surrender Header";
        StatusEditable: Boolean;
        Post: Boolean;
        JournlPosted: Codeunit "Journal Post Successful";


    procedure GetDimensionName(var "Code": Code[20]; DimNo: Integer) Name: Text[60]
    var
        GLSetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";
    begin
        /*Get the global dimension 1 and 2 from the database*/
        Name := '';

        GLSetup.Reset;
        GLSetup.Get();

        DimVal.Reset;
        DimVal.SetRange(DimVal.Code, Code);

        if DimNo = 1 then begin
            DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 1 Code");
        end
        else
            if DimNo = 2 then begin
                DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 2 Code");
            end;
        if DimVal.Find('-') then begin
            Name := DimVal.Name;
        end;

    end;


    procedure UpdateControl()
    begin
        if Status <> Status::Open then begin
            "Surrender DateEditable" := false;
            "Account No.Editable" := false;
            "Imprest Issue Doc. NoEditable" := false;
            "Responsibility CenterEditable" := false;
            ImprestLinesEditable := false;
        end else begin
            "Surrender DateEditable" := true;
            "Account No.Editable" := true;
            "Imprest Issue Doc. NoEditable" := true;
            "Responsibility CenterEditable" := true;
            ImprestLinesEditable := true;

        end;
    end;


    procedure GetCustName(No: Code[20]) Name: Text[100]
    var
        Cust: Record Customer;
    begin
        Name := '';
        if Cust.Get(No) then
            Name := Cust.Name;
        exit(Name);
    end;


    procedure UpdateforNoActualSpent()
    begin
        Posted := true;
        Status := Status::"4";
        "Date Posted" := Today;
        "Time Posted" := Time;
        "Posted By" := UserId;
        Modify;
        //Tag the Source Imprest Requisition as Surrendered
        ImprestReq.Reset;
        ImprestReq.SetRange(ImprestReq."No.", "Imprest Issue Doc. No");
        if ImprestReq.Find('-') then begin
            ImprestReq."Surrender Status" := ImprestReq."surrender status"::Full;
            ImprestReq.Modify;
        end;
        //End Tag
        //Post Committment Reversals
        Doc_Type := Doc_type::Imprest;
        BudgetControl.ReverseEntries(Doc_Type, "Imprest Issue Doc. No");
    end;


    procedure CompareAllAmounts()
    begin
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        //Update Controls as necessary
        //SETFILTER(Status,'<>Cancelled');
        UpdateControl;
        DimName1 := GetDimensionName("Global Dimension 1 Code", 1);
        DimName2 := GetDimensionName("Shortcut Dimension 2 Code", 2);
        AccountName := GetCustName("Account No.");
    end;


    procedure UpdateControls()
    begin
        if Status = Status::Open then
            StatusEditable := true
        else
            StatusEditable := false;
    end;


    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        CurrPage.Update;
    end;
}

