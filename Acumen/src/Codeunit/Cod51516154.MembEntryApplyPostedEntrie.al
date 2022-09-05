#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516154 "MembEntry-Apply Posted Entrie"
{
    Permissions = TableData "Cust. Ledger Entry" = rimd;
    TableNo = "Cust. Ledger Entry";

    trigger OnRun()
    var
        EntriesToApply: Record "Cust. Ledger Entry";
        ApplicationDate: Date;
        UpdateAnalysisView: Codeunit "Update Analysis View";
    begin
        with Rec do begin
            //IF NOT PaymentToleracenMgt.PmtTolMember(Rec) THEN
            //EXIT;
            Get("Entry No.");

            ApplicationDate := 0D;
            EntriesToApply.SetCurrentkey("Customer No.", "Applies-to ID");
            EntriesToApply.SetRange("Customer No.", "Customer No.");
            EntriesToApply.SetRange("Applies-to ID", "Applies-to ID");
            EntriesToApply.Find('-');
            repeat
                if EntriesToApply."Posting Date" > ApplicationDate then
                    ApplicationDate := EntriesToApply."Posting Date";
            until EntriesToApply.Next = 0;
            ///PostApplication.SetValues("Document No.",ApplicationDate);
            ///PostApplication.LOOKUPMODE(TRUE);
            /*
            IF ACTION::LookupOK = PostApplication.RUNMODAL THEN BEGIN
              GenJnlLine.INIT;
              PostApplication.GetValues(GenJnlLine."Document No.",GenJnlLine."Posting Date");
              IF GenJnlLine."Posting Date" < ApplicationDate THEN
                ERROR(
                  Text003,
                  GenJnlLine.FIELDCAPTION("Posting Date"),FIELDCAPTION("Posting Date"),TABLECAPTION);
            END ELSE
              EXIT;
               */
            Window.Open(Text001);

            SourceCodeSetup.Get;

            GenJnlLine."Document Date" := GenJnlLine."Posting Date";
            GenJnlLine."Account Type" := GenJnlLine."account type"::Customer;
            GenJnlLine."Account No." := "Customer No.";
            CalcFields("Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)");
            GenJnlLine.Correction :=
              ("Debit Amount" < 0) or ("Credit Amount" < 0) or
              ("Debit Amount (LCY)" < 0) or ("Credit Amount (LCY)" < 0);
            GenJnlLine."Document Type" := "Document Type";
            GenJnlLine.Description := Description;
            GenJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
            GenJnlLine."Posting Group" := "Customer Posting Group";
            GenJnlLine."Source Type" := GenJnlLine."source type"::Customer;
            GenJnlLine."Source No." := "Customer No.";
            GenJnlLine."Source Code" := SourceCodeSetup."Sales Entry Application";
            GenJnlLine."System-Created Entry" := true;

            EntryNoBeforeApplication := FindLastApplDtldCustLedgEntry;

            GenJnlPostLine.CustPostApplyCustLedgEntry(GenJnlLine, Rec);

            EntryNoAfterApplication := FindLastApplDtldCustLedgEntry;
            if EntryNoAfterApplication = EntryNoBeforeApplication then
                Error(Text004);

            Commit;
            Window.Close;
            UpdateAnalysisView.UpdateAll(0, true);
            Message(Text002);
        end;

    end;

    var
        Text001: label 'Posting application...';
        Text002: label 'The application was successfully posted.';
        Text003: label 'The %1 entered must not be before the %2 on the %3.';
        Text004: label 'The application was successfully posted though no entries have been applied.';
        SourceCodeSetup: Record "Source Code Setup";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlCheckLine: Codeunit "Gen. Jnl.-Check Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PaymentToleracenMgt: Codeunit "Payment Tolerance Management";
        Window: Dialog;
        EntryNoBeforeApplication: Integer;
        EntryNoAfterApplication: Integer;
        Text005: label 'Before you can unapply this entry, you must first unapply all application entries that were posted after this entry.';
        Text006: label '%1 No. %2 does not have an application entry.';
        Text007: label 'Do you want to unapply the entries?';
        Text008: label 'Unapplying and posting...';
        Text009: label 'The entries were successfully unapplied.';
        Text010: label 'There is nothing to unapply. ';
        Text011: label 'To unapply these entries, the program will post correcting entries.\';
        Text012: label 'Before you can unapply this entry, you must first unapply all application entries in %1 No. %2 that were posted after this entry.';
        Text013: label '%1 is not within your range of allowed posting dates in %2 No. %3.';
        Text014: label '%1 is not within your range of allowed posting dates.';
        Text015: label 'The latest %3 must be an application in %1 No. %2.';
        Text016: label 'You cannot unapply the entry with the posting date %1, because the exchange rate for the additional reporting currency has been changed. ';
        MaxPostingDate: Date;
        Text017: label 'You cannot unapply %1 No. %2 because the entry has been involved in a reversal.';
        Text018: label 'One or more of the entries that you selected is closed. You cannot apply closed entries.';

    local procedure FindLastApplDtldCustLedgEntry(): Integer
    var
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        DtldCustLedgEntry.LockTable;
        if DtldCustLedgEntry.Find('+') then
            exit(DtldCustLedgEntry."Entry No.")
        else
            exit(0);
    end;

    local procedure FindLastApplEntry(CustLedgEntryNo: Integer): Integer
    var
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        ApplicationEntryNo: Integer;
    begin
        DtldCustLedgEntry.SetCurrentkey("Cust. Ledger Entry No.", "Entry Type");
        DtldCustLedgEntry.SetRange("Cust. Ledger Entry No.", CustLedgEntryNo);
        DtldCustLedgEntry.SetRange("Entry Type", DtldCustLedgEntry."entry type"::Application);
        ApplicationEntryNo := 0;
        if DtldCustLedgEntry.Find('-') then
            repeat
                if (DtldCustLedgEntry."Entry No." > ApplicationEntryNo) and not DtldCustLedgEntry.Unapplied then
                    ApplicationEntryNo := DtldCustLedgEntry."Entry No.";
            until DtldCustLedgEntry.Next = 0;
        exit(ApplicationEntryNo);
    end;

    local procedure FindLastTransactionNo(CustLedgEntryNo: Integer): Integer
    var
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        LastTransactionNo: Integer;
    begin
        DtldCustLedgEntry.SetCurrentkey("Cust. Ledger Entry No.", "Entry Type");
        DtldCustLedgEntry.SetRange("Cust. Ledger Entry No.", CustLedgEntryNo);
        LastTransactionNo := 0;
        if DtldCustLedgEntry.Find('-') then
            repeat
                if (DtldCustLedgEntry."Transaction No." > LastTransactionNo) and not DtldCustLedgEntry.Unapplied then
                    LastTransactionNo := DtldCustLedgEntry."Transaction No.";
            until DtldCustLedgEntry.Next = 0;
        exit(LastTransactionNo);
    end;


    procedure UnApplyDtldCustLedgEntry(DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    var
        ApplicationEntryNo: Integer;
    begin
        DtldCustLedgEntry.TestField("Entry Type", DtldCustLedgEntry."entry type"::Application);
        DtldCustLedgEntry.TestField(Unapplied, false);
        ApplicationEntryNo := FindLastApplEntry(DtldCustLedgEntry."Cust. Ledger Entry No.");

        if DtldCustLedgEntry."Entry No." <> ApplicationEntryNo then
            Error(Text005);
        CheckReversal(DtldCustLedgEntry."Cust. Ledger Entry No.");
        UnApplyCustomer(DtldCustLedgEntry);
    end;


    procedure UnApplyCustLedgEntry(CustLedgEntryNo: Integer)
    var
        CustLedgentry: Record "Cust. Ledger Entry";
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        ApplicationEntryNo: Integer;
    begin
        CheckReversal(CustLedgEntryNo);
        ApplicationEntryNo := FindLastApplEntry(CustLedgEntryNo);
        if ApplicationEntryNo = 0 then
            Error(Text006, CustLedgentry.TableCaption, CustLedgEntryNo);
        DtldCustLedgEntry.Get(ApplicationEntryNo);
        UnApplyCustomer(DtldCustLedgEntry);
    end;

    local procedure UnApplyCustomer(DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    var
        UnapplyCustEntries: Page "Unapply Customer Entries";
    begin
        with DtldCustLedgEntry do begin
            TestField("Entry Type", "entry type"::Application);
            TestField(Unapplied, false);
            UnapplyCustEntries.SetDtldCustLedgEntry("Entry No.");
            UnapplyCustEntries.LookupMode(true);
            UnapplyCustEntries.RunModal;
        end;
    end;


    procedure PostUnApplyCustomer(var DtldCustLedgEntryBuf: Record "Detailed Cust. Ledg. Entry"; DtldCustLedgEntry2: Record "Detailed Cust. Ledg. Entry"; var DocNo: Code[20]; var PostingDate: Date)
    var
        GLEntry: Record "G/L Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        SourceCodeSetup: Record "Source Code Setup";
        GenJnlLine: Record "Gen. Journal Line";
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        DateComprReg: Record "Date Compr. Register";
        Window: Dialog;
        ApplicationEntryNo: Integer;
        LastTransactionNo: Integer;
        AddCurrChecked: Boolean;
    begin
        if not DtldCustLedgEntryBuf.Find('-') then
            Error(Text010);
        if not Confirm(Text011 + Text007, false) then
            exit;
        MaxPostingDate := 0D;
        GLEntry.LockTable;
        DtldCustLedgEntry.LockTable;
        CustLedgEntry.LockTable;
        CustLedgEntry.Get(DtldCustLedgEntry2."Cust. Ledger Entry No.");
        CheckPostingDate(PostingDate, '', 0);
        if PostingDate < DtldCustLedgEntry2."Posting Date" then
            Error(Text003,
              DtldCustLedgEntry2.FieldCaption("Posting Date"),
              DtldCustLedgEntry2.FieldCaption("Posting Date"),
              DtldCustLedgEntry2.TableCaption);
        DtldCustLedgEntry.SetCurrentkey("Transaction No.", "Customer No.", "Entry Type");
        DtldCustLedgEntry.SetRange("Transaction No.", DtldCustLedgEntry2."Transaction No.");
        DtldCustLedgEntry.SetRange("Customer No.", DtldCustLedgEntry2."Customer No.");
        if DtldCustLedgEntry.Find('-') then
            repeat
                if (DtldCustLedgEntry."Entry Type" <> DtldCustLedgEntry."entry type"::"Initial Entry") and
                   not DtldCustLedgEntry.Unapplied
                then begin
                    if not AddCurrChecked then begin
                        CheckAdditionalCurrency(PostingDate, DtldCustLedgEntry."Posting Date");
                        AddCurrChecked := true;
                    end;
                    CheckReversal(DtldCustLedgEntry."Cust. Ledger Entry No.");
                    if DtldCustLedgEntry."Entry Type" = DtldCustLedgEntry."entry type"::Application then begin
                        LastTransactionNo :=
                          FindLastApplTransactionEntry(DtldCustLedgEntry."Cust. Ledger Entry No.");
                        if (LastTransactionNo <> 0) and (LastTransactionNo <> DtldCustLedgEntry."Transaction No.") then
                            Error(Text012, CustLedgEntry.TableCaption, DtldCustLedgEntry."Cust. Ledger Entry No.");
                    end;
                    LastTransactionNo := FindLastTransactionNo(DtldCustLedgEntry."Cust. Ledger Entry No.");
                    if (LastTransactionNo <> 0) and (LastTransactionNo <> DtldCustLedgEntry."Transaction No.") then
                        Error(
                          Text015,
                          CustLedgEntry.TableCaption,
                          DtldCustLedgEntry."Cust. Ledger Entry No.",
                          CustLedgEntry.FieldCaption("Transaction No."));
                end;
            until DtldCustLedgEntry.Next = 0;

        DateComprReg.CheckMaxDateCompressed(MaxPostingDate, 0);

        with DtldCustLedgEntry2 do begin
            SourceCodeSetup.Get;
            CustLedgEntry.Get("Cust. Ledger Entry No.");
            GenJnlLine."Document No." := DocNo;
            GenJnlLine."Posting Date" := PostingDate;
            GenJnlLine."Account Type" := GenJnlLine."account type"::Customer;
            GenJnlLine."Account No." := "Customer No.";
            GenJnlLine.Correction := true;
            GenJnlLine."Document Type" := GenJnlLine."document type"::" ";
            GenJnlLine.Description := CustLedgEntry.Description;
            GenJnlLine."Shortcut Dimension 1 Code" := CustLedgEntry."Global Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := CustLedgEntry."Global Dimension 2 Code";
            GenJnlLine."Posting Group" := CustLedgEntry."Customer Posting Group";
            GenJnlLine."Source Type" := GenJnlLine."source type"::Customer;
            GenJnlLine."Source No." := "Customer No.";
            GenJnlLine."Source Code" := SourceCodeSetup."Unapplied Sales Entry Appln.";
            GenJnlLine."Source Currency Code" := DtldCustLedgEntry2."Currency Code";
            GenJnlLine."System-Created Entry" := true;
            Window.Open(Text008);
            //    GenJnlPostLine.VendPostApplyVendLedgEntry(GenJnlLine, DtldCustLedgEntry2);
            DtldCustLedgEntryBuf.DeleteAll;
            DocNo := '';
            PostingDate := 0D;
            Commit;
            Window.Close;
            Message(Text009);
        end;
    end;

    local procedure CheckPostingDate(PostingDate: Date; Caption: Text[50]; EntryNo: Integer)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        if GenJnlCheckLine.DateNotAllowed(PostingDate) then begin
            if Caption <> '' then
                Error(Text013, CustLedgEntry.FieldCaption("Posting Date"), Caption, EntryNo)
            else
                Error(Text014, CustLedgEntry.FieldCaption("Posting Date"));
        end;
        if PostingDate > MaxPostingDate then
            MaxPostingDate := PostingDate;
    end;

    local procedure CheckAdditionalCurrency(OldPostingDate: Date; NewPostingDate: Date)
    var
        GLSetup: Record "General Ledger Setup";
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        if OldPostingDate = NewPostingDate then
            exit;
        GLSetup.Get;
        if GLSetup."Additional Reporting Currency" <> '' then
            if CurrExchRate.ExchangeRate(OldPostingDate, GLSetup."Additional Reporting Currency") <>
               CurrExchRate.ExchangeRate(NewPostingDate, GLSetup."Additional Reporting Currency")
            then
                Error(Text016, NewPostingDate);
    end;


    procedure CheckReversal(CustLedgEntryNo: Integer)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.Get(CustLedgEntryNo);
        if CustLedgEntry.Reversed then
            Error(Text017, CustLedgEntry.TableCaption, CustLedgEntryNo);
    end;


    procedure ApplyCustEntryformEntry(var ApplyingCustLedgEntry: Record "Cust. Ledger Entry")
    var
        ApplyCustEntries: Page "Apply Member Entries";
        CustledgEntry: Record "Cust. Ledger Entry";
        CustEntryApplID: Code[20];
        OK: Boolean;
    begin
        if not ApplyingCustLedgEntry.Open then
            Error(Text018)
        else begin
            CustEntryApplID := UserId;
            if CustEntryApplID = '' then
                CustEntryApplID := '***';

            ApplyingCustLedgEntry."Applying Entry" := true;
            ApplyingCustLedgEntry."Applies-to ID" := CustEntryApplID;
            ApplyingCustLedgEntry."Amount to Apply" := ApplyingCustLedgEntry."Remaining Amount";
            //CODEUNIT.RUN(CODEUNIT::Codeunit,ApplyingCustLedgEntry);
            Commit;
            /*
              CustledgEntry.SETCURRENTKEY("Customer No.",Open,Positive);
              CustledgEntry.SETRANGE("Customer No.",ApplyingCustLedgEntry."Customer No.");
              CustledgEntry.SETRANGE(Open,TRUE);
              IF CustledgEntry.FINDSET THEN BEGIN
                ApplyCustEntries.SetCustLedgEntry(ApplyingCustLedgEntry);
                ApplyCustEntries.SETRECORD(CustledgEntry);
                ApplyCustEntries.SETTABLEVIEW(CustledgEntry);
                OK := ApplyCustEntries.RUNMODAL = ACTION::LookupOK;
                CLEAR(ApplyCustEntries);
                IF NOT OK THEN
                  EXIT;
              END;
            */
        end;

    end;


    procedure FindLastApplTransactionEntry(CustLedgEntryNo: Integer): Integer
    var
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        LastTransactionNo: Integer;
    begin
        DtldCustLedgEntry.SetCurrentkey("Cust. Ledger Entry No.", "Entry Type");
        DtldCustLedgEntry.SetRange("Cust. Ledger Entry No.", CustLedgEntryNo);
        DtldCustLedgEntry.SetRange("Entry Type", DtldCustLedgEntry."entry type"::Application);
        LastTransactionNo := 0;
        if DtldCustLedgEntry.Find('-') then
            repeat
                if (DtldCustLedgEntry."Transaction No." > LastTransactionNo) and not DtldCustLedgEntry.Unapplied then
                    LastTransactionNo := DtldCustLedgEntry."Transaction No.";
            until DtldCustLedgEntry.Next = 0;
        exit(LastTransactionNo);
    end;
}

