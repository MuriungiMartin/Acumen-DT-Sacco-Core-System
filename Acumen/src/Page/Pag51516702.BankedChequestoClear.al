#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516702 "Banked Cheques to Clear"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Transactions;
    SourceTableView = where(Type = const('Cheque Deposit'),
                            Posted = const(true),
                            "Banking Posted" = const(true),
                            "Cheque Processed" = const(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Select To Clear"; "Select To Clear")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Description"; "Transaction Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction';
                    Editable = false;
                }
                field("Cheque No"; "Cheque No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Date"; "Cheque Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Maturity Date"; "Expected Maturity Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Discounted Cheque"; "Outstanding Discounted Cheque")
                {
                    ApplicationArea = Basic;
                }
                field("BIH No"; "BIH No")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Banking)
            {
                Caption = 'Banking';
                action("Banking Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Banking Schedule';
                    Promoted = true;
                    Visible = true;
                }
                separator(Action1102760029)
                {
                }
                action("Process clearing")
                {
                    ApplicationArea = Basic;
                    Caption = 'Process clearing';
                    Image = PutawayLines;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Only cheques that have reached maturity will be cleared. Are you sure you want to clear the selected cheques?', false) = true then begin
                            Transactions.Reset;
                            Transactions.SetRange(Type, 'Cheque Deposit');
                            Transactions.SetRange(Transactions."Select To Clear", true);
                            Transactions.SetRange("Banking Posted", true);
                            Transactions.SetRange("Cheque Processed", false);
                            Transactions.SetRange("Expected Maturity Date", 0D, Today);
                            if Transactions.Find('-') then begin
                                repeat
                                    if Transactions."Cheque Date" >= 20181023D then begin
                                        Transactions.CalcFields("Outstanding Discounted Cheque");
                                        BATCH_TEMPLATE := 'GENERAL';
                                        BATCH_NAME := 'FTRANS';
                                        DOCUMENT_NO := Transactions.No;
                                        GenJournalLine.Reset;
                                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                        GenJournalLine.DeleteAll;
                                        ObjGensetup.Get();
                                        CheqClearingFee := GetCharges(Transactions."Transaction Type", Transactions.Amount);

                                        //------------------------------------1. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                        GenJournalLine."account type"::Vendor, Transactions."Account No", Today, CheqClearingFee, 'FOSA', Transactions."Cheque No",
                                        'cheque Clearing Fee ' + Transactions."Cheque No", '');
                                        //--------------------------------(Debit Member Account)---------------------------------------------
                                        //------------------------------------1. DEBIT MEMBER A/C EXCISE DUTY---------------------------------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                        GenJournalLine."account type"::Vendor, Transactions."Account No", Today, (CheqClearingFee * 0.2), 'FOSA', Transactions."Cheque No",
                                        'Excise on cleared Cheq ' + Transactions."Cheque No", '');
                                        //--------------------------------(Debit Member Account)---------------------------------------------

                                        //------------------------------------2. CREDIT INCOME G/L A/C---------------------------------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                        GenJournalLine."account type"::"G/L Account", '10105', Today, CheqClearingFee * -1, 'FOSA', Transactions."Cheque No",
                                        'cheque Clearing Fee ' + Transactions."Cheque No", '');
                                        //----------------------------------(Credit Income G/L Account)------------------------------------------------


                                        //------------------------------------2. CREDIT EXCISE DUTY G/L A/C---------------------------------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                        GenJournalLine."account type"::"G/L Account", ObjGensetup."Excise Duty Account", Today, (CheqClearingFee * 0.2) * -1, 'FOSA', Transactions."Cheque No",
                                        'Excise on Cleared Chq. ' + Transactions."Cheque No", '');
                                        //----------------------------------(Credit Excise Duty G/L Account)------------------------------------------------

                                        //CU posting
                                        GenJournalLine.Reset;
                                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                        if GenJournalLine.Find('-') then
                                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                                    end;

                                    ObjDiscountingLedger.Init;
                                    ObjDiscountingLedger.No := Transactions.No;
                                    ObjDiscountingLedger."External Transaction No" := Transactions.No;
                                    ObjDiscountingLedger."Cheque No" := Transactions."Cheque No";
                                    ObjDiscountingLedger.Amount := Amount - "Outstanding Discounted Cheque";
                                    ObjDiscountingLedger.Debit := Amount - "Outstanding Discounted Cheque";
                                    ObjDiscountingLedger."Posting Date" := Today;
                                    ObjDiscountingLedger."Transaction Type" := ObjDiscountingLedger."transaction type"::Clearing;
                                    ObjDiscountingLedger."Fosa Account" := Transactions."Account No";
                                    ObjDiscountingLedger."User ID" := UserId;
                                    ObjDiscountingLedger.Insert;

                                    Transactions."Cheque Processed" := true;
                                    Transactions."Date Cleared" := Today;
                                    Transactions."Cleared By" := UserId;
                                    Transactions.Modify;
                                until Transactions.Next = 0;

                                Message('The selected cheque deposits cleared successfully.');

                            end;
                        end;
                    end;
                }
            }
        }
        area(processing)
        {
            action(Mail)
            {
                ApplicationArea = Basic;
                Caption = 'Mail';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    GenSetup.Get(0);

                    /*SMTPMAIL.NewMessage(GenSetup."Sender Address",GenSetup."Email Subject"+''+'');
                    SMTPMAIL.SetWorkMode();
                    SMTPMAIL.ClearAttachments();
                    SMTPMAIL.ClearAllRecipients();
                    SMTPMAIL.SetDebugMode();
                    SMTPMAIL.SetFromAdress('info@stima-sacco.com');
                    SMTPMAIL.SetHost(GenSetup."Outgoing Mail Server");
                    SMTPMAIL.SetUserID(GenSetup."Sender User ID");
                    SMTPMAIL.AddLine(Text1);
                    SMTPMAIL.SetToAdress('razaaki@gmail.com');
                    SMTPMAIL.Send;
                    MESSAGE('the mail server %1',GenSetup."Outgoing Mail Server");   */
                    //MESSAGE('the e-mail %1',text2);

                end;
            }
            action("Banked Cheques")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "Banking report Chq";
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Filter based on branch
        /*IF UsersID.GET(USERID) THEN BEGIN
        IF UsersID.Branch <> '' THEN
        SETRANGE("Transacting Branch",UsersID.Branch);
        END;  */
        //Filter based on branch

    end;

    var
        Transactions: Record Transactions;
        SupervisorApprovals: Record "Supervisors Approval Levels";
        UsersID: Record User;
        GenSetup: Record "Sacco General Set-Up";
        Text1: label 'We are sending this mail to test the mail server';
        text2: label 'kisemy@yahoo.com';
        BATCH_TEMPLATE: Code[20];
        BATCH_NAME: Code[20];
        DOCUMENT_NO: Code[20];
        ObjGensetup: Record "Sacco General Set-Up";
        SFactory: Codeunit "SURESTEP Factory.";
        CheqClearingFee: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        ObjDiscountingLedger: Record "Discounting Ledger Entry";

    local procedure GetCharges(Trans: Code[100]; Amount: Decimal): Decimal
    begin
        exit(SFactory.FnGetCashierTransactionBudding(Trans, Amount));
    end;
}

