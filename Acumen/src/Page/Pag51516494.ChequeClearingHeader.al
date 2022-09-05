#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516494 "Cheque Clearing Header"
{
    PageType = Card;
    SourceTable = "Cheque Clearing Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By"; "Entered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Entered"; "Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Date Of Clearing"; "Expected Date Of Clearing")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count"; "Total Count")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cleared  By"; "Cleared  By")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount"; "Scheduled Amount")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Control1000000002)
            {
                part(ApplyBankLedgerEntries; "Cheque Clearing Lines")
                {
                    Caption = 'Banked Cheques';
                    SubPageLink = "Header No" = field(No);
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ReverseTransaction)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bounce Cheque';
                Ellipsis = true;
                Image = ReverseRegister;
                Promoted = true;
                PromotedCategory = Process;
                Scope = Repeater;
                ToolTip = 'Reverse an erroneous vendor ledger entry.';

                trigger OnAction()
                var
                    ReversalEntry: Record "Reversal Entry";
                    ObjClearingLine: Record "Cheque Clearing Lines";
                    GenJournalLine: Record "Gen. Journal Line";
                    SFactory: Codeunit "SURESTEP Factory.";
                    ObjChequeType: Record "Cheque Types";
                    VarBouncedChqFee: Decimal;
                    VarBouncedChequeAcc: Code[20];
                    ObjGensetup: Record "Sacco General Set-Up";
                begin
                end;
            }
            action("Process Clearing")
            {
                ApplicationArea = Basic;
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    TestField(Posted, false);
                    ObjClearingLine.Reset;
                    ObjClearingLine.SetRange(ObjClearingLine."Header No", No);
                    ObjClearingLine.SetRange(ObjClearingLine."Cheque Clearing Status", ObjClearingLine."cheque clearing status"::Bounced);
                    if ObjClearingLine.FindSet then begin
                        repeat

                            ObjClearingLine.CalcFields(ObjClearingLine."Ledger Entry No", ObjClearingLine."Ledger Transaction No.");
                            // CLEAR(ReversalEntry);
                            if ObjClearingLine."Cheque Bounced" then
                                //ReversalEntry.AlreadyReversedEntry(TABLECAPTION,ObjClearingLine."Ledger Entry No");
                                ObjClearingLine.TestField(ObjClearingLine."Ledger Transaction No.");
                            //ReversalEntry.ReverseTransactionBouncedCheque(ObjClearingLine."Ledger Transaction No.");



                            //Post Bounced Cheque fee
                            BATCH_TEMPLATE := 'PURCHASES';
                            BATCH_NAME := 'FTRANS';
                            DOCUMENT_NO := ObjClearingLine."Cheque No";
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            GenJournalLine.DeleteAll;
                            ObjGensetup.Get();

                            //Get Cheque Charges
                            ObjChequeType.Reset;
                            ObjChequeType.SetRange(ObjChequeType.Code, ObjClearingLine."Cheque Type");
                            if ObjChequeType.FindSet then begin
                                VarBouncedChqFee := ObjChequeType."Bounced Charges";
                                VarBouncedChequeAcc := ObjChequeType."Bounced Charges GL Account";
                            end;

                            //------------------------------------1. DEBIT MEMBER A/C---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjClearingLine."Account No", Today, VarBouncedChqFee, 'FOSA', ObjClearingLine."Cheque No",
                            'Bounced Cheque Fee-Chq. ' + ObjClearingLine."Cheque No", '');
                            //--------------------------------(Debit Member Account)---------------------------------------------

                            //------------------------------------2. CREDIT INCOME G/L A/C---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"G/L Account", VarBouncedChequeAcc, Today, VarBouncedChqFee * -1, 'FOSA', ObjClearingLine."Cheque No",
                            'Bounced Cheque Fee-Chq. ' + ObjClearingLine."Cheque No", '');
                            //----------------------------------(Credit Income G/L Account)------------------------------------------------

                            //------------------------------------1. DEBIT MEMBER A/C EXCISE DUTY---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjClearingLine."Account No", Today, (VarBouncedChqFee * 0.1), 'FOSA', ObjClearingLine."Cheque No",
                            'Excise on Bounced Cheq-Chq. ' + ObjClearingLine."Cheque No", '');
                            //--------------------------------(Debit Member Account)---------------------------------------------

                            //------------------------------------2. CREDIT EXCISE DUTY G/L A/C---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"G/L Account", ObjGensetup."Excise Duty Account", Today, (VarBouncedChqFee * 0.1) * -1, 'FOSA', ObjClearingLine."Cheque No",
                            'Excise on Bounced Cheq-Chq. ' + ObjClearingLine."Cheque No", '');
                            //----------------------------------(Credit Excise Duty G/L Account)------------------------------------------------

                            //CU posting
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            if GenJournalLine.Find('-') then
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                        until ObjClearingLine.Next = 0;
                    end;

                    ObjClearingLine.Reset;
                    ObjClearingLine.SetRange(ObjClearingLine."Header No", No);
                    ObjClearingLine.SetRange(ObjClearingLine."Cheque Clearing Status", ObjClearingLine."cheque clearing status"::Cleared);
                    if ObjClearingLine.FindSet then begin
                        repeat
                            ObjCashierTransactions.Reset;
                            ObjCashierTransactions.SetRange(No, ObjClearingLine."Transaction No");
                            if ObjCashierTransactions.Find('-') then begin
                                ObjCashierTransactions."Cheque Processed" := true;
                                ObjCashierTransactions."Date Cleared" := Today;
                                ObjCashierTransactions."Cleared By" := UserId;
                                ObjCashierTransactions.Modify;
                            end;
                        until ObjClearingLine.Next = 0;
                        Message('Process Completed Successfully');
                    end;
                    Posted := true;
                    Modify;
                end;
            }
            action("Mark as Posted")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Posted := true;
                    Modify;
                end;
            }
        }
    }

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "Checkoff Lines-Distributed";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Checkoff Header-Distributed";
        Cust: Record Customer;
        salarybuffer: Record "Salary Processing Lines";
        SalHeader: Record "Salary Processing Headerr";
        Sto: Record "Standing Orders";
        BATCH_TEMPLATE: Code[20];
        BATCH_NAME: Code[20];
        DOCUMENT_NO: Code[20];
        ObjCashierTransactions: Record Transactions;
        ObjClearingLine: Record "Cheque Clearing Lines";
        GenJournalLine: Record "Gen. Journal Line";
        ObjGensetup: Record "Sacco General Set-Up";
        ObjChequeType: Record "Cheque Types";
        VarBouncedChqFee: Decimal;
        VarBouncedChequeAcc: Code[100];
        SFactory: Codeunit "SURESTEP Factory.";
}

