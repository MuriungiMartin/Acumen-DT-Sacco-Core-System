#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516003 "POST ATM Transactions"
{
    Permissions = TableData "ATM Transactions" = rimd;
    TableNo = "ATM Transactions";

    trigger OnRun()
    begin
        //MESSAGE('%1',PostTrans());
        //MESSAGE(FORMAT(PostTrans()));
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        ATMTrans: Record "ATM Transactions";
        LineNo: Integer;
        Acct: Record Vendor;
        ATMCharges: Decimal;
        BankCharges: Decimal;
        ExciseGLAcc: Code[20];
        ExciseFee: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        ATM_CHARGES: Record "ATM Charges";
        DocNo: Code[20];
        BankAccount: Code[20];
        GLAccount: Code[20];
        Reversals2: Record "ATM Transactions";
        iEntryNo: Integer;
        SMSMessage: Record "SMS Messages";
        Vend1: Record Vendor;
        VendL: Record "Vendor Ledger Entry";
        Pos: Record "POS Commissions";
        AccountCharges: Decimal;
        SFactory: Codeunit "SURESTEP Factory.";
        GenSetUp: Record "Sacco General Set-Up";
        ATMMessages: Text;
        BATCH_TEMPLATE: Code[100];
        BATCH_NAME: Code[100];
        DOCUMENT_NO: Code[100];


    procedure PostTrans(): Boolean
    var
        processed: Boolean;
        time_processed: Time;
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'ATMTRANS';

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;
        //end of deletion

        GenBatches.Reset;
        GenBatches.SetRange(GenBatches."Journal Template Name", BATCH_TEMPLATE);
        GenBatches.SetRange(GenBatches.Name, BATCH_NAME);
        if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name" := BATCH_TEMPLATE;
            GenBatches.Name := BATCH_NAME;
            GenBatches.Description := 'ATM Transactions';
            GenBatches.Validate(GenBatches."Journal Template Name");
            GenBatches.Validate(GenBatches.Name);
            GenBatches.Insert;
        end;

        ATMTrans.LockTable;
        ATMTrans.Reset;
        ATMTrans.SetRange(ATMTrans.Posted, false);
        if ATMTrans.Find('-') then begin
            repeat
                DOCUMENT_NO := ATMTrans."Reference No";
                BankAccount := 'BANK0002';
                GLAccount := '30313';
                ExciseGLAcc := '20042';

                ATMCharges := 0;
                BankCharges := 0;
                ExciseFee := 0;

                ATM_CHARGES.Reset;
                ATM_CHARGES.SetRange(ATM_CHARGES."Transaction Type", ATMTrans."Transaction Type Charges");
                if (ATM_CHARGES.Find('-')) then begin
                    ATMCharges := ATM_CHARGES."Total Amount";
                    BankCharges := ATMCharges - ATM_CHARGES."Sacco Amount";

                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"Cash Withdrawal - Coop ATM") then begin
                        ExciseFee := ATMCharges * 0.2;
                    end;
                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"Cash Withdrawal - VISA ATM") then begin
                        ExciseFee := ATMCharges * 0.2;
                    end;
                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"POS - Balance Enquiry") then begin
                        ExciseFee := ATMCharges * 0.2;
                    end;
                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"POS - Cash Withdrawal") then begin
                        ExciseFee := ATMCharges * 0.2;
                    end;
                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"POS - Mini Statement") then begin
                        ExciseFee := ATMCharges * 0.2;
                    end;

                end;

                //**************************IF REVERSAL, THEN REVERSE THE SIGN*******************************
                if ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::Reversal then begin
                    Reversals2.Reset;
                    Reversals2.SetRange(Reversals2."Trace ID", ATMTrans."Reversal Trace ID");
                    Reversals2.SetRange(Reversals2."Account No", ATMTrans."Account No");
                    Reversals2.SetRange(Reversals2.Reversed, false);

                    if (Reversals2.Find('-')) then begin
                        ATM_CHARGES.Reset;
                        ATM_CHARGES.SetRange(ATM_CHARGES."Transaction Type", Reversals2."Transaction Type Charges");

                        if (ATM_CHARGES.Find('-')) then begin
                            ATMCharges := ATM_CHARGES."Total Amount";
                            BankCharges := ATMCharges - ATM_CHARGES."Sacco Amount";
                            ATMCharges := ATMCharges * (-1);
                            BankCharges := BankCharges * (-1);
                            if (Reversals2."Transaction Type Charges" = Reversals2."transaction type charges"::"Cash Withdrawal - Coop ATM") then
                                ExciseFee := -(((ATM_CHARGES."Total Amount") - (ATM_CHARGES."Total Amount" - ATM_CHARGES."Sacco Amount")) * 0.2);
                            if (Reversals2."Transaction Type Charges" = Reversals2."transaction type charges"::"Cash Withdrawal - VISA ATM") then
                                ExciseFee := -(((ATM_CHARGES."Total Amount") - (ATM_CHARGES."Total Amount" - ATM_CHARGES."Sacco Amount")) * 0.2);
                        end;
                    end;
                end;


                if (ATMTrans."Transaction Type Charges" >= ATMTrans."transaction type charges"::"POS - School Payment") then begin
                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"POS - Cash Withdrawal") then
                        if (ATMTrans."POS Vendor" = ATMTrans."pos vendor"::"Coop Branch POS") then ATMCharges := 100;//refer to e-mail from coop bank

                    BankCharges := ATMCharges - ATM_CHARGES."Sacco Amount";
                end;

                if ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"POS - Cash Withdrawal" then begin
                    Pos.Reset;
                    Pos.SetFilter(Pos."Lower Limit", '<=%1', ATMTrans.Amount);
                    Pos.SetFilter(Pos."Upper Limit", '>=%1', ATMTrans.Amount);
                    if Pos.FindFirst then begin
                        ATMCharges := Pos."Charge Amount";
                        BankCharges := Pos."Bank charge";
                    end;
                end;
                /*
                VarNameDataTypeSubtypeLength
                NoTemplateNameText
                NoBatchNameText
                NoDocumentNoCode30
                NoLineNoInteger
                NoTransactionTypeOption
                NoAccountTypeOption
                NoAccountNoCode50
                NoTransactionDateDate
                NoTransactionAmountDecimal
                NoDimensionActivityCode40
                NoExternalDocumentNoCode50
                NoTransactionDescriptionText
                NoLoanNumberCode50
                No  TraceID   Code    100
                */
                Acct.Reset;
                Acct.SetRange("No.", ATMTrans."Account No");
                if Acct.Find('-') then begin
                    //IF Acct.GET(ATMTrans."Account No") THEN BEGIN

                    //-----------------------1. Debit FOSA A/C(Amount Transacted)---------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineAtm(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ATMTrans."Account No", ATMTrans."Posting Date", ATMTrans.Amount, 'FOSA', '',
                    Format(ATMTrans."Transaction Type Charges"), '', ATMTrans."Trace ID");

                    //-----------------------2. Credit Bank(Amount Transacted)--------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"Bank Account", BankAccount, ATMTrans."Posting Date", ATMTrans.Amount * -1, 'FOSA', ATMTrans."Account No", Acct.Name, '');

                    //-----------------------3. Debit FOSA (Transaction Charge)--------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ATMTrans."Account No", ATMTrans."Posting Date", ATMCharges, 'FOSA', '', ATMTrans.Description + ' Charges', '');

                    //-----------------------4. Debit FOSA (20% Excise Duty)------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ATMTrans."Account No", ATMTrans."Posting Date", (ATMCharges) * 0.2, 'FOSA', '', ATMTrans.Description + ' Excise Duty Charges', '');

                    //-----------------------5. Credit Excise G/L(20% Excise Duty)------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", ExciseGLAcc, ATMTrans."Posting Date", ((ATMCharges) * -1) * 0.2, 'FOSA', ATMTrans."Account No", Acct.Name + '-Excise', '');

                    //-----------------------6. Credit Bank(Bank Charges)------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"Bank Account", BankAccount, ATMTrans."Posting Date", BankCharges * -1, 'FOSA', ATMTrans."Account No", ATMTrans.Description + ' Charges', '');

                    //-----------------------7. Credit Settlement G/L(Sacco Charges)------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", GLAccount, ATMTrans."Posting Date", (ATMCharges - BankCharges) * -1, 'FOSA', ATMTrans."Account No", Acct.Name, '');

                    //-----------------------8. Charge  &Earn SMS Fee (From Sacco General Setup)------------------------------------------------------------------------------------
                    GenSetUp.Get();
                    if (GenSetUp."SMS Fee Account" <> '') and (GenSetUp."SMS Fee Amount" > 0) then begin
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, ATMTrans."Account No", ATMTrans."Posting Date", GenSetUp."SMS Fee Amount", 'FOSA', '', ATMTrans.Description + ' SMS Charge', '');

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", GenSetUp."SMS Fee Account", ATMTrans."Posting Date", GenSetUp."SMS Fee Amount" * -1, 'FOSA', ATMTrans."Account No", ATMTrans.Description + ' SMS Charge', '');
                    end;

                    //Reverse Excise Duty
                    if ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::Reversal then begin
                        //CO-OP TRANS
                        VendL.Reset();
                        VendL.SetRange(VendL."Vendor No.", ATMTrans."Account No");
                        VendL.SetRange(VendL."Document No.", ATMTrans."Reference No");
                        VendL.CalcFields(VendL.Amount);
                        VendL.SetRange(VendL.Amount, ATMCharges * 0.2);

                        if VendL.Find('+') then begin
                            //--------------------------------------Credit FOSA A/C(Excise Duty)------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ATMTrans."Account No", ATMTrans."Posting Date", ATMCharges * 0.2 * -1, 'FOSA', '', ATMTrans.Description + ' Reverse ExciseDuty', '');

                            //--------------------------------------Debit Excise G/L(Excise Duty)------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"G/L Account", ExciseGLAcc, ATMTrans."Posting Date", ATMCharges * 0.2, 'FOSA', '', ATMTrans.Description + ' Reverse ExciseDuty On ATM Trans', '');
                        end;
                        //VISA TRANS
                        VendL.Reset();
                        VendL.SetRange(VendL."Vendor No.", ATMTrans."Account No");
                        VendL.SetRange(VendL."Document No.", ATMTrans."Reference No");
                        VendL.CalcFields(VendL.Amount);
                        VendL.SetRange(VendL.Amount, ATMCharges * 0.2);
                        if VendL.Find('+') then begin
                            //--------------------------------------Credit FOSA A/C(Excise Duty)------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ATMTrans."Account No", ATMTrans."Posting Date", ATMCharges * 0.2 * -1, 'FOSA', '', ATMTrans.Description + ' Reverse ExciseDuty', '');

                            //--------------------------------------Debit Excise G/L(Excise Duty)------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"G/L Account", ExciseGLAcc, ATMTrans."Posting Date", ATMCharges * 0.2, 'FOSA', '', ATMTrans.Description + ' Reverse ExciseDuty On ATM Trans', '');
                        end;
                    end;

                    ATMTrans.Posted := true;
                    ATMTrans.Modify;
                    processed := true;
                    time_processed := Dt2Time(CurrentDatetime);
                    GenSetUp.Get();
                    //-----------------------------Send SMS---------------------------------------------------------------
                    if GenSetUp."Send Membership Reg SMS" = true then begin
                        if ATMTrans.Amount > 0 then begin
                            if ATMTrans."Transaction Type" = 'AW' then
                                ATMMessages := 'You have withdrawn KSHs.' + Format(ATMTrans.Amount) + ' from ATM Location ' + ATMTrans."Withdrawal Location" + ' on ' + Format(Today) + ' ' + Format(ATMTrans."Transaction Time");
                            if ATMTrans."Transaction Type" = 'VP' then
                                ATMMessages := 'You have done a Purchase of KSHs.' + Format(ATMTrans.Amount) + ' from ' + ATMTrans."Withdrawal Location" + ' on ' + Format(Today) + ' ' + Format(ATMTrans."Transaction Time");
                        end;
                        if ATMTrans.Amount < 0 then
                            ATMMessages := 'Your withdrawal of KSHs.' + Format(ATMTrans.Amount) + ' from ATM Location ' + ATMTrans."Withdrawal Location" + ' has been reversed on ' + Format(Today) + ' ' + Format(ATMTrans."Transaction Time");
                        SFactory.FnSendSMS('ATM TRANS', ATMMessages, ATMTrans."Account No", Acct."Phone No.");
                    end;
                end else begin
                    Error('%1', 'Account No. %1 not found.', ATMTrans."Account No");
                end;

            until ATMTrans.Next = 0;

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            if GenJournalLine.Find('-') then begin
                repeat
                    GLPosting.Run(GenJournalLine);
                until GenJournalLine.Next = 0;
            end;


            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            GenJournalLine.DeleteAll;
        end;
        processed := true;
        exit(processed);

    end;


    procedure fnTotalUnposted() unposted: Integer
    begin
        ATMTrans.LockTable;
        ATMTrans.Reset;
        ATMTrans.SetFilter(ATMTrans.Posted, '%1', false);
        if ATMTrans.Find('-') then begin
            unposted := ATMTrans.Count;
        end;
        exit(unposted);
    end;
}

