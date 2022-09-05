#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516155 "Staff Leave Claims List"
{
    ApplicationArea = Basic;
    CardPageID = "Staff Leave Claims";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Staff Claims Header";
    SourceTableView = where(Status = filter(<> Cancelled),
                            Posted = const(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
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
                field("Function Name"; "Function Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = ShortcutDimension2CodeEditable;
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
                    Editable = false;
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
                    Editable = "Paying Bank AccountEditable";
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
                field("Pay Mode"; "Pay Mode")
                {
                    ApplicationArea = Basic;
                    Editable = "Pay ModeEditable";
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque/EFT No.';
                    Editable = "Cheque No.Editable";
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
                action("Post Payment and Print")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Payment and Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CheckImprestRequiredItems;
                        PostImprest;

                        Reset;
                        SetFilter("No.", "No.");
                        Report.Run(55882, true, true, Rec);
                        Reset;
                    end;
                }
                separator(Action1102755021)
                {
                }
                action("Post Payment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Payment';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CheckImprestRequiredItems;
                        PostImprest;
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
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::"Staff Claim";
                        ApprovalEntries.Setfilters(Database::"Staff Claims Header", DocumentType, "No.");
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
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit WorkflowIntegration;
                    begin

                        if not LinesExists then
                            Error('There are no Lines created for this Document');

                        if not AllFieldsEntered then
                            Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                        //Ensure No Items That should be committed that are not
                        if LinesCommitmentStatus then
                            Error('There are some lines that have not been committed');

                        //Release the Imprest for Approval
                        // IF ApprovalMgt.SendClaimApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit WorkflowIntegration;
                    begin
                        //IF ApprovalMgt.CancelClaimApprovalRequest(Rec,TRUE,TRUE) THEN;
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

                        // CheckBudgetAvail.CheckStaffClaim(Rec);
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
                        if Status <> Status::Approved then
                            Error('You can only print after the document is Approved');
                        Reset;
                        SetFilter("No.", "No.");
                        Report.Run(51516332, true, true, Rec);
                        Reset;
                    end;
                }
                separator(Action1102756006)
                {
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
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //OnAfterGetCurrRecord;
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
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        //check if the documenent has been added while another one is still pending
        TravReqHeader.Reset;
        //TravAccHeader.SETRANGE(SaleHeader."Document Type",SaleHeader."Document Type"::"Cash Sale");
        TravReqHeader.SetRange(TravReqHeader.Cashier, UserId);
        TravReqHeader.SetRange(TravReqHeader.Status, Status::Pending);

        if TravReqHeader.Count > 0 then begin
            Error('There are still some pending document(s) on your account. Please list & select the pending document to use.  ');
        end;
        //*********************************END ****************************************//


        "Payment Type" := "payment type"::Imprest;
        "Account Type" := "account type"::Customer;
    end;

    trigger OnOpenPage()
    begin

        if UserMgt.GetPurchasesFilter() <> '' then begin
            FilterGroup(2);
            SetRange("Responsibility Center", UserMgt.GetPurchasesFilter());
            FilterGroup(0);
        end;


        /*
        IF UserMgt.GetSetDimensions(USERID,2) <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Shortcut Dimension 2 Code",UserMgt.GetSetDimensions(USERID,2));
          FILTERGROUP(0);
        END;
        */
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender;
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
                GenJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");

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

        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Line", GenJnlLine);

        Post := false;
        Post := JournlPosted.PostedSuccessfully();
        if Post then begin
            Posted := true;
            "Date Posted" := Today;
            "Time Posted" := Time;
            "Posted By" := UserId;
            Status := Status::Posted;
            Modify;
        end;
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
            Error('Ensure the Imprest Template is set up in Cash Office Setup');
        end;

        if JBatch = '' then begin
            Error('Ensure the Imprest Batch is set up in the Cash Office Setup')
        end;

        if not LinesExists then
            Error('There are no Lines created for this Document');

    end;


    procedure UpdateControls()
    begin
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
}

