#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516030 "COOPATMAPI"
{
    Permissions = TableData "ATM Transactions" = rimd;
    TableNo = "ATM Transactions";

    trigger OnRun()
    begin
        //MESSAGE('%1',InsertFBAtmCharges('0200','001401012073','254713213296','00250604',3000,'0000324411515','15010115','ELDORET UGANDA RD 2 Eldoret',TODAY,'00',FALSE,TODAY));
        //MESSAGE(FORMAT(PostTrans()));
        //MESSAGE(FORMAT(getCustomerStatus('001401000002')));
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
        Vendor: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
        miniBalance: Decimal;
        acctFrozen: Code[10];
        ProdID: Code[10];
        DormantAccount: Code[10];
        accountBal: Decimal;
        closureDate: Date;
        ProductAppSignatories: Record "FOSA Account App Signatories";
        "Count": Integer;
        atmNos: Record "ATM Card Nos Buffer";


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
        //ATMTrans.SETRANGE(ATMTrans."Reference No",referenceNo);
        ATMTrans.SetRange(ATMTrans.Posted, false);
        if ATMTrans.Find('-') then begin
            repeat
                DOCUMENT_NO := ATMTrans."Reference No";//.messageID;
                                                       // BankAccount:='BANK00033';
                                                       // GLAccount:=  '200302';
                                                       // ExciseGLAcc:='200702';

                //MESSAGE(ATMTrans."Transaction Type Charges");
                ATM_CHARGES.Reset;
                ATM_CHARGES.SetRange(ATM_CHARGES."Transaction Type", ATMTrans."Transaction Type Charges");
                if ATM_CHARGES.Find('-') then begin
                    BankAccount := ATM_CHARGES."Atm Bank Settlement A/C";
                    GLAccount := ATM_CHARGES."Atm Income A/c";
                    ExciseGLAcc := ATM_CHARGES.ExciseDutyAccount;
                end;

                //MESSAGE(GLAccount);
                ATMCharges := 0;
                BankCharges := 0;
                ExciseFee := 0;

                ATM_CHARGES.Reset;
                ATM_CHARGES.SetRange(ATM_CHARGES."Transaction Type", ATMTrans."Transaction Type Charges");
                if (ATM_CHARGES.Find('-')) then begin
                    ATMCharges := ATM_CHARGES."Total Amount";
                    BankCharges := ATMCharges - ATM_CHARGES."Sacco Amount";

                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"Cash Withdrawal - VISA ATM") then begin
                        ExciseFee := ATMCharges * (GenSetUp."Excise Duty(%)" / 100);
                    end;
                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::Reversal) then begin
                        ExciseFee := ATMCharges * (GenSetUp."Excise Duty(%)" / 100);
                    end;
                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"POS - Mini Statement") then begin
                        ExciseFee := ATMCharges * (GenSetUp."Excise Duty(%)" / 100);
                    end;
                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"POS - Balance Enquiry") then begin
                        ExciseFee := ATMCharges * (GenSetUp."Excise Duty(%)" / 100);
                    end;
                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"MINIMUM BALANCE") then begin
                        ExciseFee := ATMCharges * (GenSetUp."Excise Duty(%)" / 100);
                    end;

                end;

                //**************************IF REVERSAL, THEN REVERSE THE SIGN*******************************
                if ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::Reversal then begin
                    Reversals2.Reset;
                    Reversals2.SetRange(Reversals2."Trace ID", ATMTrans."Reversal Trace ID");
                    Reversals2.SetRange(Reversals2."Account No", ATMTrans."Account No");//.AccountDebitAccount);
                    Reversals2.SetRange(Reversals2.Reversed, false);

                    if (Reversals2.Find('-')) then begin
                        ATM_CHARGES.Reset;
                        ATM_CHARGES.SetRange(ATM_CHARGES."Transaction Type", Reversals2."Transaction Type Charges");

                        if (ATM_CHARGES.Find('-')) then begin

                            ATMCharges := ATM_CHARGES."Total Amount";
                            BankCharges := ATMCharges - ATM_CHARGES."Sacco Amount";
                            ATMCharges := ATMCharges * (-1);
                            BankCharges := BankCharges * (-1);

                            if (Reversals2."Transaction Type Charges" = Reversals2."transaction type charges"::"Cash Withdrawal - VISA ATM") then
                                ExciseFee := -(((ATM_CHARGES."Total Amount") - (ATM_CHARGES."Total Amount" - ATM_CHARGES."Sacco Amount")) * 0.2);

                            if (Reversals2."Transaction Type Charges" = Reversals2."transaction type charges"::Reversal) then
                                ExciseFee := -(((ATM_CHARGES."Total Amount") - (ATM_CHARGES."Total Amount" - ATM_CHARGES."Sacco Amount")) * 0.2);

                        end;

                        ATMTrans.Amount := ATMTrans.Amount * -1;
                    end;
                end;


                if (ATMTrans."Transaction Type Charges" >= ATMTrans."transaction type charges"::"POS - Purchase With Cash Back") then begin
                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"POS - Balance Enquiry") then begin
                        if (ATMTrans."POS Vendor" = ATMTrans."pos vendor"::"Coop Branch POS") then ATMCharges := 100;//refer to e-mail from coop bank
                    end;
                    BankCharges := ATMCharges - ATM_CHARGES."Sacco Amount";
                end;

                if ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"POS - Balance Enquiry" then begin
                    Pos.Reset;
                    Pos.SetFilter(Pos."Lower Limit", '<=%1', ATMTrans.Amount);
                    Pos.SetFilter(Pos."Upper Limit", '>=%1', ATMTrans.Amount);
                    if Pos.FindFirst then begin
                        ATMCharges := Pos."Charge Amount";
                        BankCharges := Pos."Bank charge";
                    end;
                end;


                if Acct.Get(ATMTrans."Account No") then begin

                    //-----------------------1. Debit FOSA A/C(Amount Transacted)---------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineAtm(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ATMTrans."Account No", ATMTrans."Transaction Date", ATMTrans.Amount, 'FOSA', '',
                    Format(ATMTrans."Transaction Type Charges") + ' ' + ATMTrans."Withdrawal Location",
                    '', ATMTrans."Trace ID");

                    //-----------------------2. Credit Bank(Amount Transacted)--------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineAtm(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"Bank Account", BankAccount, ATMTrans."Posting Date", ATMTrans.Amount * -1, 'FOSA', ATMTrans."Account No",
                    ATMTrans.Description, Acct.Name, ATMTrans."Trace ID");

                    //-----------------------3. Debit FOSA (Transaction Charge)--------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineAtm(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ATMTrans."Account No", ATMTrans."Posting Date", ATMCharges, 'FOSA', '',
                    Format(ATMTrans."Transaction Type Charges") + ' Charges', '', ATMTrans."Trace ID");

                    //-----------------------4. Debit FOSA (10% Excise Duty sacco)------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineAtm(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ATMTrans."Account No", ATMTrans."Posting Date", (ATMCharges) * 0.2, 'FOSA', '',
                    Format(ATMTrans."Transaction Type Charges") + ' Excise Duty Charges', '', ATMTrans."Trace ID");

                    //-----------------------5. Credit Excise G/L(10% Excise Duty)------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineAtm(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", ExciseGLAcc, ATMTrans."Posting Date", ((ATMCharges - BankCharges) * -1) * 0.2, 'FOSA',
                    ATMTrans."Account No", Acct.Name + '-Excise', '', ATMTrans."Trace ID");
                    //-----------------------5. Credit Excise G/L(10% Excise Duty)------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineAtm(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"Bank Account", BankAccount, ATMTrans."Posting Date", ((BankCharges) * -1) * 0.2, 'FOSA',
                    ATMTrans."Account No", Acct.Name + '-Excise', '', ATMTrans."Trace ID");

                    //-----------------------6. Credit Bank(Bank Charges)------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineAtm(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"Bank Account", BankAccount, ATMTrans."Posting Date", BankCharges * -1, 'FOSA',
                    ATMTrans."Account No", Format(ATMTrans."Transaction Type Charges") + ' Charges', '', ATMTrans."Trace ID");

                    //-----------------------7. Credit Settlement G/L(Sacco Charges)------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineAtm(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", GLAccount, ATMTrans."Posting Date", (ATMCharges - BankCharges) * -1, 'FOSA',
                    ATMTrans."Account No", Acct.Name, '', ATMTrans."Trace ID");

                    //-----------------------8. Charge  &Earn SMS Fee (From Sacco General Setup)------------------------------------------------------------------------------------
                    GenSetUp.Get();
                    if ((GenSetUp."SMS Fee Account" <> '') and (GenSetUp."SMS Fee Amount" > 0)) then begin
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineAtm(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, ATMTrans."Account No", ATMTrans."Posting Date", GenSetUp."SMS Fee Amount", 'FOSA',
                        '', Format(ATMTrans."Transaction Type Charges") + ' SMS Charge', '', ATMTrans."Trace ID");

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineAtm(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", GenSetUp."SMS Fee Account", ATMTrans."Posting Date", GenSetUp."SMS Fee Amount" * -1, 'FOSA',
                        ATMTrans."Account No", Format(ATMTrans."Transaction Type Charges") + ' SMS Charge', '', ATMTrans."Trace ID");
                    end;

                    //Reverse Excise Duty
                    if ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"Utility Payment" then begin
                        //CO-OP TRANS
                        VendL.Reset();
                        VendL.SetRange(VendL."Vendor No.", ATMTrans."Account No");
                        VendL.SetRange(VendL."Document No.", ATMTrans."Reference No");
                        VendL.CalcFields(VendL.Amount);
                        VendL.SetRange(VendL.Amount, 0.9);

                        if VendL.Find('+') then begin
                            //--------------------------------------Credit FOSA A/C(Excise Duty)------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineAtm(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ATMTrans."Account No", ATMTrans."Posting Date", 0.8 * -1, 'FOSA',
                            '', Format(ATMTrans."Transaction Type Charges") + ' Reverse ExciseDuty', '', ATMTrans."Trace ID");

                            //--------------------------------------Debit Excise G/L(Excise Duty)------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineAtm(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"G/L Account", ExciseGLAcc, ATMTrans."Posting Date", 0.8, 'FOSA',
                            '', Format(ATMTrans."Transaction Type Charges") + ' Reverse ExciseDuty On ATM Trans', '', ATMTrans."Trace ID");
                        end;
                        //VISA TRANS
                        VendL.Reset();
                        VendL.SetRange(VendL."Vendor No.", ATMTrans."Account No");
                        VendL.SetRange(VendL."Document No.", ATMTrans."Reference No");
                        VendL.CalcFields(VendL.Amount);
                        VendL.SetRange(VendL.Amount, 4);
                        if VendL.Find('+') then begin
                            //--------------------------------------Credit FOSA A/C(Excise Duty)------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineAtm(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ATMTrans."Account No", ATMTrans."Posting Date", 4 * -1, 'FOSA',
                            '', Format(ATMTrans."Transaction Type Charges") + ' Reverse ExciseDuty', '', ATMTrans."Trace ID");

                            //--------------------------------------Debit Excise G/L(Excise Duty)------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineAtm(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"G/L Account", ExciseGLAcc, ATMTrans."Posting Date", 4, 'FOSA',
                            '', Format(ATMTrans."Transaction Type Charges") + ' Reverse ExciseDuty On ATM Trans', '', ATMTrans."Trace ID");


                        end;

                        ATMTrans.Reversed := true;
                        ATMTrans."Reversed Posted" := true;
                    end;



                    ATMTrans.Posted := true;
                    ATMTrans.Modify;
                    processed := true;
                    time_processed := Dt2Time(CurrentDatetime);

                    //-----------------------------Send SMS---------------------------------------------------------------
                    GenSetUp.Get();
                    if GenSetUp."Send Membership Reg SMS" = true then begin
                        Count := 0;
                        ProductAppSignatories.Reset;
                        ProductAppSignatories.SetRange(ProductAppSignatories."Account No", ATMTrans."Account No");
                        if ProductAppSignatories.Find('-') then begin
                            //            REPEAT
                            //              IF ATMTrans.Amount>0 THEN ATMMessages:='You have withdrawn KSHs.'+FORMAT(ATMTrans.Amount)+' from ATM Location '+ATMTrans."Withdrawal Location"+' on '+FORMAT(TODAY) + ' ' +FORMAT(ATMTrans."Transaction Time");
                            //              IF ATMTrans.Amount<0 THEN ATMMessages:='Your withdrawal of KSHs.'+FORMAT(ATMTrans.Amount)+' from ATM Location '+ATMTrans."Withdrawal Location"+' has been reversed on '+FORMAT(TODAY) + ' ' +FORMAT(ATMTrans."Transaction Time");
                            //              SFactory.FnSendSMS('ATM TRANS',ATMMessages,ATMTrans."Account No",ATMTrans."Mobile Phone No");
                            //            UNTIL ProductAppSignatories.NEXT=0;
                        end;

                        if ATMTrans.Amount > 0 then ATMMessages := 'You have withdrawn KSHs.' + Format(ATMTrans.Amount) + ' from ATM Location ' + ATMTrans."Withdrawal Location" + ' on ' + Format(Today) + ' ' + Format(ATMTrans."Transaction Time");
                        if ATMTrans.Amount < 0 then ATMMessages := 'Your withdrawal of KSHs.' + Format(ATMTrans.Amount) + ' from ATM Location ' + ATMTrans."Withdrawal Location" + ' has been reversed on ' + Format(Today) + ' ' + Format(ATMTrans."Transaction Time");

                        //          SFactory.FnSendSMS('ATM TRANS',ATMMessages,ATMTrans."Account No",Acct."Mobile Phone No");
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


    procedure InsertAtmTrans("Trace ID": Code[100]; "Account No": Code[100]; Description: Text[1024]; Amount: Decimal; "Transaction Type": Code[100]; TerminalID: Code[150]; ReversalTraceID: Code[50]; "ATM Location": Code[250]; iTransType: Integer; CardAcceptorterminalID: Code[250]; "ATM Card No": Code[250]; processCode: Code[250]; isCoopBank: Code[250]; posVendor: Integer; refNum: Code[100]) result: Boolean
    begin

        ATMTrans.Reset;
        if ATMTrans.Find('+') then begin
            iEntryNo := ATMTrans."Entry No";
            iEntryNo := iEntryNo + 1;
        end else begin
            iEntryNo := 1;
        end;

        ATMTrans.Reset;
        ATMTrans.Init;
        ATMTrans."Account No" := "Account No";
        ATMTrans.Amount := Amount * -1;
        ATMTrans."Trace ID" := "Trace ID";
        ATMTrans."Card Acceptor Terminal ID" := CardAcceptorterminalID;
        ATMTrans.Description := Description;
        ATMTrans."Posting Date" := Today;
        ATMTrans."Transaction Type" := "Transaction Type";
        ATMTrans."Reference No" := refNum;
        if (isCoopBank = '0') then begin
            ATMTrans."Is Coop Bank" := false;
        end else begin
            ATMTrans."Is Coop Bank" := true;
        end;
        ATMTrans."Posting S" := Format(Today);
        ATMTrans.Reversed := false;
        ATMTrans."Reversed Posted" := false;
        ATMTrans."Transaction Type Charges" := iTransType;
        ATMTrans."Transaction Date" := Today;
        ATMTrans."Transaction Description" := Description;
        ATMTrans."Withdrawal Location" := "ATM Location";
        ATMTrans."POS Vendor" := posVendor;
        ATMTrans."Process Code" := processCode;
        ATMTrans."Transaction Time" := Time;
        ATMTrans."Reversal Trace ID" := ReversalTraceID;
        ATMTrans."Entry No" := iEntryNo;
        ATMTrans.Posted := false;
        ATMTrans."Trans Time" := Format(Time);
        ATMTrans.Source := ATMTrans.Source::"ATM Bridge";
        ATMTrans.Insert;
        /*
        ATMTrans.RESET;
        ATMTrans.SETRANGE(ATMTrans."Reference No",refNum);
        IF ATMTrans.FIND('-') THEN BEGIN
         // result:=PostTrans(ATMTrans."Reference No");

        END
        ELSE BEGIN
        result:=FALSE;
        END;
        */

    end;


    procedure fnATMCHARGES(atmName: Integer) result: Decimal
    begin
        ATM_CHARGES.Reset;
        ATM_CHARGES.SetRange(ATM_CHARGES."Transaction Type", atmName);
        if (ATM_CHARGES.Find('-')) then begin
            ATMCharges := ATM_CHARGES."Total Amount";
            BankCharges := ATMCharges - ATM_CHARGES."Sacco Amount";
            ExciseFee := ATM_CHARGES."Total Amount" * 20 / 100;
            result := ATMCharges + ExciseFee;
        end;
    end;


    procedure getAccountBalance(Acc: Code[30]) Bal: Decimal
    var
        DateClosed: Code[50];
    begin

        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", Acc);
        if Vendor.Find('-') then begin
            AccountTypes.Reset;
            AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
            if AccountTypes.Find('-') then begin
                miniBalance := AccountTypes."Minimum Balance";
            end;
            Vendor.CalcFields(Vendor."Balance (LCY)");
            Vendor.CalcFields(Vendor."ATM Transactions");
            Vendor.CalcFields(Vendor."Uncleared Cheques");
            Vendor.CalcFields(Vendor."EFT Transactions");
            accountBal := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions" + miniBalance);
            Bal := accountBal;
        end;
    end;


    procedure getTransactionsLimit(AccountNo: Code[50]; Amount: Decimal) Limit: Decimal
    var
        DailyLimit: Decimal;
        DefaultLimit: Decimal;
    begin
        DefaultLimit := 50000;
        ATMTrans.Reset;
        ATMTrans.SetRange(ATMTrans."Account No", AccountNo);
        ATMTrans.SetRange(ATMTrans."Posting Date", Today);
        if ATMTrans.Find('-') then begin
            repeat
                DailyLimit := DailyLimit + ATMTrans.Amount;
            until ATMTrans.Next = 0;
        end;
        Limit := DefaultLimit - DailyLimit;

        if Limit >= Amount then begin
            Limit := Amount;
        end else begin
            Limit := 0;
        end;
    end;


    procedure getCustomerAcc(acc: Code[50]) accountNo: Code[50]
    begin
        atmNos.Reset;
        atmNos.SetRange("ATM Card No", acc);
        if atmNos.Find('-') then begin
            accountNo := atmNos."Account No";
        end;
    end;


    procedure getCustomerName(acc: Code[50]) CustomerNames: Code[100]
    begin
        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", acc);
        if Vendor.Find('-') then begin
            CustomerNames := Vendor.Name;
        end;
    end;


    procedure TraceIDExists(traceIDX: Code[100]; customerNo: Code[100]; amount: Decimal) result: Boolean
    begin
        ATMTrans.Reset;
        ATMTrans.SetFilter(ATMTrans."Trace ID", '<=%1', traceIDX);
        ATMTrans.SetFilter(ATMTrans."Account No", '>=%1', customerNo);
        ATMTrans.SetFilter(ATMTrans.Amount, '>=%1', amount);
        result := false;
        if ATMTrans.Find('-') then begin
            result := true;
        end;
    end;


    procedure ReversalTraceIDExists(reversalTraceIDX: Code[100]; customerNo: Code[100]; amount: Decimal) result: Boolean
    begin
        ATMTrans.Reset;
        ATMTrans.SetFilter(ATMTrans."Reversal Trace ID", '<=%1', reversalTraceIDX);
        ATMTrans.SetFilter(ATMTrans."Account No", '>=%1', customerNo);
        ATMTrans.SetFilter(ATMTrans.Amount, '>=%1', amount);
        result := false;
        if ATMTrans.Find('-') then begin
            result := true;
        end;
    end;


    procedure getPOScommissions(amount: Decimal) result: Decimal
    var
        posCommission: Record "POS Commissions";
    begin
        posCommission.Reset;
        posCommission.SetFilter(posCommission."Upper Limit", '>=%1', amount);
        posCommission.SetFilter(posCommission."Lower Limit", '>=%1', amount);
        if posCommission.Find('-') then begin
            result := posCommission."Charge Amount";
        end;
    end;


    procedure ReversedAtmTrans("Trace ID": Code[100]; "Account No": Code[100]; Description: Text[1024]; Amount: Decimal; "Transaction Type": Code[100]; TerminalID: Code[150]; TerminalLocation: Code[50]; "ATM Location": Code[250]; iTransType: Integer; CardAcceptorterminalID: Code[250]; "ATM Card No": Code[250]; processCode: Code[250]; isCoopBank: Code[250]; posVendor: Integer; refNum: Code[100]; ReversalTraceID: Code[250]) result: Boolean
    begin

        ATMTrans.Reset;
        if ATMTrans.Find('+') then begin
            iEntryNo := ATMTrans."Entry No";
            iEntryNo := iEntryNo + 1;
        end else begin
            iEntryNo := 1;
        end;
        ATMTrans.Reset;
        ATMTrans.Init;
        ATMTrans."Account No" := "Account No";
        ATMTrans.Amount := Amount * -1;
        ATMTrans."Trace ID" := "Trace ID";
        ATMTrans."Card Acceptor Terminal ID" := CardAcceptorterminalID;
        ATMTrans.Description := Description;
        ATMTrans."Posting Date" := Today;
        ATMTrans."Transaction Type" := "Transaction Type";
        ATMTrans."Reference No" := refNum;
        if (isCoopBank = '0') then begin
            ATMTrans."Is Coop Bank" := false;
        end else begin
            ATMTrans."Is Coop Bank" := true;
        end;

        ATMTrans."Posting S" := Format(Today);
        ATMTrans.Reversed := true;
        ATMTrans."Reversed Posted" := false;
        ATMTrans."Transaction Type Charges" := iTransType;
        ATMTrans."Transaction Date" := Today;
        ATMTrans."Transaction Description" := Description;
        ATMTrans."Withdrawal Location" := "ATM Location";
        ATMTrans."POS Vendor" := posVendor;
        ATMTrans."Reversal Trace ID" := ReversalTraceID;
        ATMTrans."Process Code" := processCode;
        ATMTrans."Transaction Time" := Time;
        ATMTrans."Entry No" := iEntryNo;
        ATMTrans.Posted := false;
        ATMTrans."Trans Time" := Format(Time);
        ATMTrans.Source := ATMTrans.Source::"ATM Bridge";
        ATMTrans.Insert;
        /*
        ATMTrans.RESET;
        ATMTrans.SETRANGE(ATMTrans."Reference No",refNum);
        IF ATMTrans.FIND('-') THEN BEGIN
          result:=PostTrans(ATMTrans."Reference No");

        END
        ELSE BEGIN
        result:=FALSE;
        END;
        */

    end;


    procedure getCustomerStatus(customerNo: Code[100]) result: Integer
    begin
        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", customerNo);
        if Vendor.Find('-') then begin
            result := Vendor.Blocked;
        end;
    end;
}

