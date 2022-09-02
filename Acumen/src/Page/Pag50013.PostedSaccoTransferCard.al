#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50013 "Posted Sacco Transfer Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Sacco Transfers";

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
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = TransactionDateEditable;
                }
                field("Approved By"; "Approved By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Transaction Description"; "Transaction Description")
                {
                    ApplicationArea = Basic;
                    Editable = RemarkEditable;
                }
                field("Source Account Type"; "Source Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = SourceAccountTypeEditable;
                }
                field("Savings Account Type"; "Savings Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account No"; "Source Account No")
                {
                    ApplicationArea = Basic;
                    Editable = SourceAccountNoEditbale;
                }
                field("Source Account Name"; "Source Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Source Transaction Type"; "Source Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = SourceAccountTypeEditable;

                    trigger OnValidate()
                    begin
                        DepositDebitTypeVisible := false;
                        if "Source Transaction Type" = "source transaction type"::"Deposit Contribution" then begin
                            DepositDebitTypeVisible := true;
                        end;
                    end;
                }
                group(DepositDebitType)
                {
                    Caption = 'Deposit Debit Type';
                    Editable = false;
                    Visible = DepositDebitTypeVisible;
                    field("Deposit Debit Options"; "Deposit Debit Options")
                    {
                        ApplicationArea = Basic;
                        Editable = VarDepositDebitTypeEditable;
                    }
                }
                field("Source Loan No"; "Source Loan No")
                {
                    ApplicationArea = Basic;
                    Editable = SourceLoanNoEditable;
                }
                field("Schedule Total"; "Schedule Total")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Approved; Approved)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1102760014; "Sacco Transfer Schedule")
            {
                SubPageLink = "No." = field(No);
            }
        }
        area(factboxes)
        {
            part(Control2; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("Source Account No");
            }
            part(Control1; "Member Statistics FactBox")
            {
                Caption = 'BOSA Statistics FactBox';
                SubPageLink = "No." = field("Source Account No");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Posting)
            {
                Caption = 'Posting';
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This Batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if FnLimitNumberOfTransactions() then
                            Error(Txt0001);
                        if ApprovalsMgmt.CheckSaccoTransferApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendSaccoTransferForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckSaccoTransferApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnCancelSaccoTransferApprovalRequest(Rec);
                    end;
                }
                action(Approvals)
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
                        DocumentType := Documenttype::SaccoTransfers;
                        ApprovalEntries.Setfilters(Database::"Sacco Transfers", DocumentType, No);
                        ApprovalEntries.Run;
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post';
                    Enabled = EnablePost;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin


                        //IF FundsUSer.GET(USERID) THEN BEGIN
                        Jtemplate := 'GENERAL';//FundsUSer."Payment Journal Template";
                        Jbatch := 'FTRANS';//FundsUSer."Payment Journal Batch";
                        //END;
                        if Posted = true then
                            Error('This Shedule is already posted');
                        TestField("Transaction Description");

                        if Confirm('Are you sure you want to transfer schedule?', false) = true then begin

                            //IF Approved=FALSE THEN
                            //ERROR('This schedule is not approved');


                            // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", Jtemplate);
                            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", Jbatch);
                            GenJournalLine.DeleteAll;




                            //POSTING MAIN TRANSACTION

                            //window.OPEN('Posting:,#1######################');


                            //Partial Refund Fee=======================================================================================
                            if "Deposit Debit Options" = "deposit debit options"::"Partial Refund" then begin
                                ObjGensetup.Get();
                                BATCH_TEMPLATE := Jtemplate;
                                BATCH_NAME := Jbatch;
                                DOCUMENT_NO := No;

                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                GenJournalLine.DeleteAll;

                                VarExciseDuty := (ObjGensetup."Excise Duty(%)" / 100) * ObjGensetup."Partial Deposit Refund Fee";
                                VarExciseDutyAccount := ObjGensetup."Excise Duty Account";

                                //------------------------------------1. DEBIT MEMBER DEPOSITS A/C---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                GenJournalLine."account type"::Member, "Source Account No", Today, ObjGensetup."Partial Deposit Refund Fee", 'BOSA', '',
                                "Transaction Description" + ' ' + "Source Account No", '');
                                //--------------------------------(Debit Member Deposit Account)---------------------------------------------

                                //------------------------------------1.1. CREDIT FEE  GL A/C---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::"G/L Account", ObjGensetup."Partial Deposit Refund Fee A/C", Today, ObjGensetup."Partial Deposit Refund Fee" * -1, 'BOSA', '',
                                "Transaction Description" + ' ' + "Source Account No", '');
                                //----------------------------------(Credit Fee GL Account)------------------------------------------------

                                //------------------------------------2. DEBIT MEMBER DEPOSITS A/C EXCISE ON FEE---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                GenJournalLine."account type"::Member, "Source Account No", Today, VarExciseDuty, 'BOSA', '',
                                "Transaction Description" + ' ' + "Source Account No", '');
                                //--------------------------------(Debit Member Deposit Account Excise Duty)---------------------------------------------

                                //------------------------------------2.1. CREDIT EXCISE  GL A/C---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::"G/L Account", VarExciseDutyAccount, Today, VarExciseDuty * -1, 'BOSA', '',
                                "Transaction Description" + ' ' + "Source Account No", '');
                                //----------------------------------(Credit Excise GL Account)------------------------------------------------
                            end;



                            // UPDATE Source Account
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := Jbatch;
                            GenJournalLine."Document No." := No;
                            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000;
                            if "Source Account Type" = "source account type"::Customer then begin
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                GenJournalLine."Transaction Type" := "Source Transaction Type";
                                GenJournalLine."Account No." := "Source Account No";
                                GenJournalLine."Loan No" := "Source Loan No";
                            end else
                                if "Source Account Type" = "source account type"::MEMBER then begin
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                    GenJournalLine."Transaction Type" := "Source Transaction Type";
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := BTRANS."Global Dimension 2 Code";
                                    GenJournalLine."Account No." := "Source Account No";
                                    GenJournalLine."Loan No" := "Source Loan No";
                                end else

                                    if "Source Account Type" = "source account type"::FOSA then begin
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'fOSA';
                                        GenJournalLine."Shortcut Dimension 2 Code" := BTRANS."Global Dimension 2 Code";
                                        GenJournalLine."Account No." := "Source Account No";
                                    end else
                                        if "Source Account Type" = "source account type"::"G/L ACCOUNT" then begin
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                            GenJournalLine."Transaction Type" := "Source Transaction Type";
                                            GenJournalLine."Shortcut Dimension 2 Code" := '01';
                                            GenJournalLine."Account No." := "Source Account No";
                                        end else
                                            if "Source Account Type" = "source account type"::Bank then begin
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                                GenJournalLine."Shortcut Dimension 2 Code" := BTRANS."Global Dimension 2 Code";
                                                GenJournalLine."Account No." := "Source Account No";
                                            end;
                            GenJournalLine."Posting Date" := "Transaction Date";
                            GenJournalLine.Description := "Transaction Description";
                            CalcFields("Schedule Total");
                            GenJournalLine.Amount := "Schedule Total";
                            //GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine.Insert;



                            BSched.Reset;
                            BSched.SetRange(BSched."No.", No);
                            if BSched.Find('-') then begin
                                repeat
                                    BSched.TestField(BSched."Transaction Description");
                                    GenJournalLine.Init;

                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Document No." := No;
                                    GenJournalLine."Line No." := GenJournalLine."Line No." + 10000;

                                    if BSched."Destination Account Type" = BSched."destination account type"::MEMBER then begin
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                        GenJournalLine."Transaction Type" := BSched."Destination Type";
                                        GenJournalLine."Account No." := BSched."Destination Account No.";
                                        GenJournalLine."Shortcut Dimension 2 Code" := BSched."Global Dimension 2 Code";
                                    end else

                                        if BSched."Destination Account Type" = BSched."destination account type"::FOSA then begin
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                            GenJournalLine."Transaction Type" := BSched."Destination Type";
                                            GenJournalLine."Account No." := BSched."Destination Account No.";
                                            GenJournalLine."Shortcut Dimension 2 Code" := BSched."Global Dimension 2 Code";
                                        end else
                                            if BSched."Destination Account Type" = BSched."destination account type"::"G/L ACCOUNT" then begin
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                                GenJournalLine."Account No." := BSched."Destination Account No.";
                                                GenJournalLine."Shortcut Dimension 2 Code" := '01';

                                            end else
                                                if BSched."Destination Account Type" = BSched."destination account type"::BANK then begin
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                                                    GenJournalLine."Account No." := BSched."Destination Account No.";
                                                    GenJournalLine."Shortcut Dimension 2 Code" := BSched."Global Dimension 2 Code";
                                                end;
                                    GenJournalLine."Loan No" := BSched."Destination Loan";
                                    GenJournalLine.Validate(GenJournalLine."Loan No");
                                    //GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := "Transaction Date";
                                    GenJournalLine.Description := "Transaction Description";
                                    GenJournalLine.Amount := -BSched.Amount;
                                    //GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                    GenJournalLine.Insert;
                                until BSched.Next = 0;
                            end;

                            /*//CU posting
                            GenJournalLine.RESET;
                            GenJournalLine.SETRANGE("Journal Template Name",Jtemplate);
                            GenJournalLine.SETRANGE("Journal Batch Name",Jbatch);
                            IF GenJournalLine.FIND('-') THEN
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJournalLine);
                            */



                            //CU posting
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            if GenJournalLine.Find('-') then
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

                            //Post
                            Posted := true;
                            Modify;
                        end;

                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        BTRANS.Reset;
                        BTRANS.SetRange(BTRANS.No, No);
                        if BTRANS.Find('-') then begin
                            Report.Run(51516902, true, true, BTRANS);
                        end;
                    end;
                }
            }
            action("Members Statistics")
            {
                ApplicationArea = Basic;
                Caption = 'Member Details';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Members Statistics";
                RunPageLink = "No." = field("Source Account No");
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        AddRecordRestriction();

        EnablePost := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalFOrRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowExist := true;
        if Rec.Status = Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalFOrRecord := false;
            EnabledApprovalWorkflowExist := false;
        end;
        if Rec.Status = Status::Approved then
            EnablePost := true;

        DepositDebitTypeVisible := false;
        if "Source Transaction Type" = "source transaction type"::"Deposit Contribution" then begin
            DepositDebitTypeVisible := true;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        AddRecordRestriction();

        DepositDebitTypeVisible := false;
        if "Source Transaction Type" = "source transaction type"::"Deposit Contribution" then begin
            DepositDebitTypeVisible := true;
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Error('Not Allowed!');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Source Account Type" := "source account type"::FOSA;
    end;

    trigger OnOpenPage()
    begin
        "Source Account Type" := "source account type"::FOSA;
        AddRecordRestriction();

        DepositDebitTypeVisible := false;
        if "Source Transaction Type" = "source transaction type"::"Deposit Contribution" then begin
            DepositDebitTypeVisible := true;
        end;
    end;

    var
        users: Record User;
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        BSched: Record "Sacco Transfers Schedule";
        BTRANS: Record "Sacco Transfers";
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        FundsUSer: Record "Funds User Setup";
        Jtemplate: Code[10];
        Jbatch: Code[10];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers;
        SourceAccountNoEditbale: Boolean;
        SourceAccountNameEditable: Boolean;
        SourceAccountTypeEditable: Boolean;
        SourceTransactionType: Boolean;
        SourceLoanNoEditable: Boolean;
        RemarkEditable: Boolean;
        TransactionDateEditable: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ObjSaccoTransfers: Record "Sacco Transfers";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowExist: Boolean;
        CanCancelApprovalFOrRecord: Boolean;
        EnablePost: Boolean;
        Txt0001: label 'You cannot transfer another amount before three months elapse. ';
        DepositDebitTypeVisible: Boolean;
        ObjGensetup: Record "Sacco General Set-Up";
        BATCH_TEMPLATE: Code[50];
        BATCH_NAME: Code[50];
        DOCUMENT_NO: Code[50];
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory.";
        VarExciseDuty: Decimal;
        VarExciseDutyAccount: Code[30];
        VarDepositDebitTypeEditable: Boolean;

    local procedure AddRecordRestriction()
    begin
        if Status = Status::Open then begin
            SourceAccountNoEditbale := true;
            SourceAccountNameEditable := true;
            SourceAccountTypeEditable := true;
            SourceLoanNoEditable := true;
            SourceTransactionType := true;
            TransactionDateEditable := true;
            VarDepositDebitTypeEditable := true;
            RemarkEditable := true
        end else
            if Status = Status::"Pending Approval" then begin
                SourceAccountNoEditbale := false;
                SourceAccountNameEditable := false;
                SourceAccountTypeEditable := false;
                SourceLoanNoEditable := false;
                SourceTransactionType := false;
                TransactionDateEditable := false;
                VarDepositDebitTypeEditable := false;
                RemarkEditable := false
            end else
                if Status = Status::Approved then begin
                    SourceAccountNoEditbale := false;
                    SourceAccountNameEditable := false;
                    SourceAccountTypeEditable := false;
                    SourceLoanNoEditable := false;
                    SourceTransactionType := false;
                    TransactionDateEditable := false;
                    VarDepositDebitTypeEditable := false;
                    RemarkEditable := false;
                end;
    end;

    local procedure FnLimitNumberOfTransactions(): Boolean
    begin
        ObjSaccoTransfers.Reset;
        ObjSaccoTransfers.SetRange("Savings Account Type", 'NIS');
        ObjSaccoTransfers.SetRange("Source Account No", Rec."Source Account No");
        ObjSaccoTransfers.SetRange(Posted, true);
        ObjSaccoTransfers.SetCurrentkey(No);
        if ObjSaccoTransfers.FindLast then begin
            if (Rec."Transaction Date" - ObjSaccoTransfers."Transaction Date") > 30 then
                exit(true);
        end;
        exit(false);
    end;
}

