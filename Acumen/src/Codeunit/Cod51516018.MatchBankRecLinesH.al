#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516018 "Match Bank Rec. Lines H"
{

    trigger OnRun()
    begin
    end;

    var
        MatchSummaryMsg: label '%1 reconciliation lines out of %2 are matched.\\';
        MissingMatchMsg: label 'Text shorter than %1 characters cannot be matched.';
        ProgressBarMsg: label 'Please wait while the operation is being completed.';
        Relation: Option "One-to-One","One-to-Many";
        MatchLengthTreshold: Integer;
        NormalizingFactor: Integer;


    procedure MatchManually(var SelectedBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";var SelectedBankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        BankAccEntrySetReconNo: Codeunit "Bank Acc. Set Recon.-No. H";
    begin
        if SelectedBankAccReconciliationLine.FindFirst then begin
          BankAccReconciliationLine.Get(
            SelectedBankAccReconciliationLine."Statement Type",
            SelectedBankAccReconciliationLine."Bank Account No.",
            SelectedBankAccReconciliationLine."Statement No.",
            SelectedBankAccReconciliationLine."Statement Line No.");
          if BankAccReconciliationLine.Type <> BankAccReconciliationLine.Type::"Bank Account Ledger Entry" then
            exit;

          if SelectedBankAccountLedgerEntry.FindSet then begin
            repeat
              BankAccountLedgerEntry.Get(SelectedBankAccountLedgerEntry."Entry No.");
              BankAccEntrySetReconNo.RemoveApplication(BankAccountLedgerEntry);
              BankAccEntrySetReconNo.ApplyEntries(BankAccReconciliationLine,BankAccountLedgerEntry,Relation::"One-to-Many");
            until SelectedBankAccountLedgerEntry.Next = 0;
          end;
        end;
    end;


    procedure RemoveMatch(var SelectedBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";var SelectedBankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        BankAccEntrySetReconNo: Codeunit "Bank Acc. Entry Set Recon.-No.";
    begin
        if SelectedBankAccReconciliationLine.FindSet then
          repeat
            BankAccReconciliationLine.Get(
              SelectedBankAccReconciliationLine."Statement Type",
              SelectedBankAccReconciliationLine."Bank Account No.",
              SelectedBankAccReconciliationLine."Statement No.",
              SelectedBankAccReconciliationLine."Statement Line No.");
            BankAccountLedgerEntry.SetRange("Bank Account No.",BankAccReconciliationLine."Bank Account No.");
            BankAccountLedgerEntry.SetRange("Statement No.",BankAccReconciliationLine."Statement No.");
            BankAccountLedgerEntry.SetRange("Statement Line No.",BankAccReconciliationLine."Statement Line No.");
            BankAccountLedgerEntry.SetRange(Open,true);
            BankAccountLedgerEntry.SetRange("Statement Status",BankAccountLedgerEntry."statement status"::"Bank Acc. Entry Applied");
            if BankAccountLedgerEntry.FindSet then
              repeat
                BankAccEntrySetReconNo.RemoveApplication(BankAccountLedgerEntry);
              until BankAccountLedgerEntry.Next = 0;
          until SelectedBankAccReconciliationLine.Next = 0;

        if SelectedBankAccountLedgerEntry.FindSet then
          repeat
            BankAccountLedgerEntry.Get(SelectedBankAccountLedgerEntry."Entry No.");
            BankAccEntrySetReconNo.RemoveApplication(BankAccountLedgerEntry);
          until SelectedBankAccountLedgerEntry.Next = 0;
    end;


    procedure MatchSingle(BankAccReconciliation: Record "Bank Acc. Reconciliation";DateRange: Integer)
    var
        TempBankStatementMatchingBuffer: Record "Bank Statement Matching Buffer" temporary;
        BankRecMatchCandidates: Query "Bank Rec. Match Candidates";
        Window: Dialog;
        Score: Integer;
    begin
        TempBankStatementMatchingBuffer.DeleteAll;

        Window.Open(ProgressBarMsg);
        SetMatchLengthTreshold(4);
        SetNormalizingFactor(10);
        BankRecMatchCandidates.SetRange(Rec_Line_Bank_Account_No,BankAccReconciliation."Bank Account No.");
        BankRecMatchCandidates.SetRange(Rec_Line_Statement_No,BankAccReconciliation."Statement No.");
        if BankRecMatchCandidates.Open then
          while BankRecMatchCandidates.Read do begin
            Score := 0;

            if BankRecMatchCandidates.Rec_Line_Difference = BankRecMatchCandidates.Remaining_Amount then
              Score += 13;

            Score += GetDescriptionMatchScore(BankRecMatchCandidates.Rec_Line_Description,BankRecMatchCandidates.Description,
                BankRecMatchCandidates.Document_No,BankRecMatchCandidates.External_Document_No);

            Score += GetDescriptionMatchScore(BankRecMatchCandidates.Rec_Line_RltdPty_Name,BankRecMatchCandidates.Description,
                BankRecMatchCandidates.Document_No,BankRecMatchCandidates.External_Document_No);

            Score += GetDescriptionMatchScore(BankRecMatchCandidates.Rec_Line_Transaction_Info,BankRecMatchCandidates.Description,
                BankRecMatchCandidates.Document_No,BankRecMatchCandidates.External_Document_No);

            if BankRecMatchCandidates.Rec_Line_Transaction_Date <> 0D then
              case true of
                BankRecMatchCandidates.Rec_Line_Transaction_Date = BankRecMatchCandidates.Posting_Date:
                  Score += 1;
                Abs(BankRecMatchCandidates.Rec_Line_Transaction_Date - BankRecMatchCandidates.Posting_Date) > DateRange:
                  Score := 0;
              end;

            if Score > 2 then
              TempBankStatementMatchingBuffer.AddMatchCandidate(BankRecMatchCandidates.Rec_Line_Statement_Line_No,
                BankRecMatchCandidates.Entry_No,Score,0,'');
          end;

        //SaveOneToOneMatching(TempBankStatementMatchingBuffer,BankAccReconciliation."Bank Account No.",
          //BankAccReconciliation."Statement No.");

        Window.Close;
        ShowMatchSummary(BankAccReconciliation);
    end;

    local procedure ShowMatchSummary(BankAccReconciliation: Record "Bank Acc. Reconciliation")
    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        FinalText: Text;
        AdditionalText: Text;
        TotalCount: Integer;
        MatchedCount: Integer;
    begin
        BankAccReconciliationLine.SetRange("Bank Account No.",BankAccReconciliation."Bank Account No.");
        BankAccReconciliationLine.SetRange("Statement Type",BankAccReconciliation."Statement Type");
        BankAccReconciliationLine.SetRange("Statement No.",BankAccReconciliation."Statement No.");
        BankAccReconciliationLine.SetRange(Type,BankAccReconciliationLine.Type::"Bank Account Ledger Entry");
        TotalCount := BankAccReconciliationLine.Count;

        BankAccReconciliationLine.SetFilter("Applied Entries",'<>%1',0);
        MatchedCount := BankAccReconciliationLine.Count;

        if MatchedCount < TotalCount then
          AdditionalText := StrSubstNo(MissingMatchMsg,Format(GetMatchLengthTreshold));
        FinalText := StrSubstNo(MatchSummaryMsg,MatchedCount,TotalCount) + AdditionalText;
        Message(FinalText);
    end;

    local procedure GetDescriptionMatchScore(BankRecDescription: Text;BankEntryDescription: Text;DocumentNo: Code[20];ExternalDocumentNo: Code[35]): Integer
    var
        RecordMatchMgt: Codeunit "Record Match Mgt.";
        Nearness: Integer;
        Score: Integer;
        MatchLengthTreshold: Integer;
        NormalizingFactor: Integer;
    begin
        BankRecDescription := RecordMatchMgt.Trim(BankRecDescription);
        BankEntryDescription := RecordMatchMgt.Trim(BankEntryDescription);

        MatchLengthTreshold := GetMatchLengthTreshold;
        NormalizingFactor := GetNormalizingFactor;
        Score := 0;

        Nearness := RecordMatchMgt.CalculateStringNearness(BankRecDescription,DocumentNo,
            MatchLengthTreshold,NormalizingFactor);
        if Nearness = NormalizingFactor then
          Score += 11;

        Nearness := RecordMatchMgt.CalculateStringNearness(BankRecDescription,ExternalDocumentNo,
            MatchLengthTreshold,NormalizingFactor);
        if Nearness = NormalizingFactor then
          Score += Nearness;

        //Nearness := RecordMatchMgt.CalculateStringNearness(BankRecDescription,BankEntryDescription,     **changes to exclude description from fashion choice lane
        //    MatchLengthTreshold,NormalizingFactor);
        //IF Nearness >= 0.8 * NormalizingFactor THEN
        //  Score += Nearness;

        exit(Score);
    end;


    procedure SetMatchLengthTreshold(NewMatchLengthThreshold: Integer)
    begin
        MatchLengthTreshold := NewMatchLengthThreshold;
    end;


    procedure SetNormalizingFactor(NewNormalizingFactor: Integer)
    begin
        NormalizingFactor := NewNormalizingFactor;
    end;


    procedure GetMatchLengthTreshold(): Integer
    begin
        exit(MatchLengthTreshold);
    end;


    procedure GetNormalizingFactor(): Integer
    begin
        exit(NormalizingFactor);
    end;


    procedure MatchManually2(var SelectedBankAccReconciliationLine: Record UnknownRecord51516012;var SelectedBankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    var
        BankAccReconciliationLine: Record UnknownRecord51516012;
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        BankAccEntrySetReconNo: Codeunit "Bank Acc. Entry Set Recon.-No.";
        BankAccReconciliationLine2: Record "Bank Acc. Reconciliation Line";
    begin
        if SelectedBankAccReconciliationLine.FindFirst then begin
          BankAccReconciliationLine.Get(
            SelectedBankAccReconciliationLine."Statement Type",
            SelectedBankAccReconciliationLine."Bank Account No.",
            SelectedBankAccReconciliationLine."Statement No.",
            SelectedBankAccReconciliationLine."Statement Line No.");
          if BankAccReconciliationLine.Type <> BankAccReconciliationLine.Type::"0" then
            exit;

          if SelectedBankAccountLedgerEntry.FindSet then begin
            repeat
              BankAccountLedgerEntry.Get(SelectedBankAccountLedgerEntry."Entry No.");
              BankAccEntrySetReconNo.RemoveApplication2(BankAccountLedgerEntry);
              //**changes added to include the matched statement line to the reconciliation line
              BankAccReconciliationLine2.Reset;
              BankAccReconciliationLine2.SetRange("Bank Ledger Entry Line No",BankAccountLedgerEntry."Entry No.");
              BankAccReconciliationLine2.FindSet;
              BankAccEntrySetReconNo.ApplyEntries2(BankAccReconciliationLine2,BankAccountLedgerEntry,Relation::"One-to-Many",SelectedBankAccReconciliationLine);
            until SelectedBankAccountLedgerEntry.Next = 0;
          end;
        end;
    end;


    procedure RemoveMatch2(var SelectedBankAccReconciliationLine: Record UnknownRecord51516012;var SelectedBankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    var
        BankAccReconciliationLine: Record UnknownRecord51516012;
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        BankAccEntrySetReconNo: Codeunit "Bank Acc. Entry Set Recon.-No.";
        BankAccReconciliationLine2: Record "Bank Acc. Reconciliation Line";
    begin
        if SelectedBankAccReconciliationLine.FindSet then
          repeat
            BankAccReconciliationLine.Get(
              SelectedBankAccReconciliationLine."Statement Type",
              SelectedBankAccReconciliationLine."Bank Account No.",
              SelectedBankAccReconciliationLine."Statement No.",
              SelectedBankAccReconciliationLine."Statement Line No.");
            BankAccountLedgerEntry.SetRange("Bank Account No.",BankAccReconciliationLine."Bank Account No.");
            BankAccountLedgerEntry.SetRange("Statement No.",BankAccReconciliationLine."Statement No.");
            BankAccountLedgerEntry.SetRange("Statement Line No.",BankAccReconciliationLine."Statement Line No.");
            BankAccountLedgerEntry.SetRange(Open,true);
            BankAccountLedgerEntry.SetRange("Statement Status",BankAccountLedgerEntry."statement status"::"Bank Acc. Entry Applied");
            if BankAccountLedgerEntry.FindSet then
              repeat
                BankAccEntrySetReconNo.RemoveApplication2(BankAccountLedgerEntry);
              until BankAccountLedgerEntry.Next = 0;
          until SelectedBankAccReconciliationLine.Next = 0;

        if SelectedBankAccountLedgerEntry.FindSet then
          repeat
            BankAccountLedgerEntry.Get(SelectedBankAccountLedgerEntry."Entry No.");
            BankAccEntrySetReconNo.RemoveApplication2(BankAccountLedgerEntry);
          until SelectedBankAccountLedgerEntry.Next = 0;
    end;


    procedure MatchSingle2(BankAccReconciliation: Record "Bank Acc. Reconciliation";DateRange: Integer)
    var
        TempBankStatementMatchingBuffer: Record "Bank Statement Matching Buffer" temporary;
        BankRecMatchCandidates: Query "Bank Rec. Match Candidates";
        Window: Dialog;
        Score: Integer;
    begin
        TempBankStatementMatchingBuffer.DeleteAll;
        
        Window.Open(ProgressBarMsg);
        SetMatchLengthTreshold(4);
        SetNormalizingFactor(10);
        BankRecMatchCandidates.SetRange(Rec_Line_Bank_Account_No,BankAccReconciliation."Bank Account No.");
        BankRecMatchCandidates.SetRange(Rec_Line_Statement_No,BankAccReconciliation."Statement No.");
        if BankRecMatchCandidates.Open then
          while BankRecMatchCandidates.Read do begin
            Score := 0;
        
            if BankRecMatchCandidates.Rec_Line_Difference = BankRecMatchCandidates.Remaining_Amount then
              Score += 13;
        
            //change the matching to check with check no.
            if BankRecMatchCandidates.Rec_Line_Check_No = BankRecMatchCandidates.External_Document_No then
              Score += 12;
        
            Score += GetDescriptionMatchScore(BankRecMatchCandidates.Rec_Line_Description,BankRecMatchCandidates.Description,
                BankRecMatchCandidates.Document_No,BankRecMatchCandidates.External_Document_No);
        
            Score += GetDescriptionMatchScore(BankRecMatchCandidates.Rec_Line_RltdPty_Name,BankRecMatchCandidates.Description,
                BankRecMatchCandidates.Document_No,BankRecMatchCandidates.External_Document_No);
        
            Score += GetDescriptionMatchScore(BankRecMatchCandidates.Rec_Line_Transaction_Info,BankRecMatchCandidates.Description,
                BankRecMatchCandidates.Document_No,BankRecMatchCandidates.External_Document_No);
        
        /*
            IF BankRecMatchCandidates.Rec_Line_Transaction_Date <> 0D THEN
              CASE TRUE OF
                BankRecMatchCandidates.Rec_Line_Transaction_Date = BankRecMatchCandidates.Posting_Date:
                  Score += 1;
                ABS(BankRecMatchCandidates.Rec_Line_Transaction_Date - BankRecMatchCandidates.Posting_Date) > DateRange:
                  Score := 0;
              END;
        */
            if BankRecMatchCandidates.Rec_Line_Difference <> BankRecMatchCandidates.Remaining_Amount then    //changes if check no is same, but amount is diff.
                  Score := 0;
            if BankRecMatchCandidates.Rec_Line_Check_No <> BankRecMatchCandidates.External_Document_No then
                  Score := 0;
            if BankRecMatchCandidates.Rec_Line_Check_No = '' then
                  Score := 0;
            if BankRecMatchCandidates.Rec_Line_Check_No <> BankRecMatchCandidates.External_Document_No then
                  Score := 0;
        
            if Score > 2 then
              TempBankStatementMatchingBuffer.AddMatchCandidate(BankRecMatchCandidates.Rec_Line_Statement_Line_No,
                BankRecMatchCandidates.Entry_No,Score,0,'');
          end;
        
        //SaveOneToOneMatching(TempBankStatementMatchingBuffer,BankAccReconciliation."Bank Account No.",
         // BankAccReconciliation."Statement No.");
        
        Window.Close;
        ShowMatchSummary(BankAccReconciliation);

    end;

    local procedure SaveOneToOneMatching(var TempBankStatementMatchingBuffer: Record "Bank Statement Matching Buffer" temporary;BankAccountNo: Code[20];StatementNo: Code[20])
    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        BankAccEntrySetReconNo: Codeunit "Bank Acc. Entry Set Recon.-No.";
        BankAccStatementLine: Record UnknownRecord51516012;
    begin
        TempBankStatementMatchingBuffer.Reset;
        TempBankStatementMatchingBuffer.SetCurrentkey(Quality);
        TempBankStatementMatchingBuffer.Ascending(false);
        
        if TempBankStatementMatchingBuffer.FindSet then
          repeat
            BankAccountLedgerEntry.Get(TempBankStatementMatchingBuffer."Entry No.");
        
            BankAccReconciliationLine.Reset;      //**changes to add the statement line to the reconciliation
            BankAccReconciliationLine.SetRange("Bank Ledger Entry Line No",BankAccountLedgerEntry."Entry No.");
            if BankAccReconciliationLine.FindFirst then
             begin
                /*
                BankAccReconciliationLine.GET(
                  BankAccReconciliationLine."Statement Type"::"Bank Reconciliation",
                  BankAccountNo,StatementNo,
                  TempBankStatementMatchingBuffer."Line No.");
                */
                BankAccStatementLine.Get(
                  BankAccStatementLine."statement type"::"0",
                  BankAccountNo,StatementNo,
                  TempBankStatementMatchingBuffer."Line No.");
        
                BankAccEntrySetReconNo.ApplyEntries2(BankAccReconciliationLine,BankAccountLedgerEntry,Relation::"One-to-One",BankAccStatementLine);
             end;
          until TempBankStatementMatchingBuffer.Next = 0;

    end;
}

