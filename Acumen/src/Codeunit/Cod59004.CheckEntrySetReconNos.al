#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 59004 "Check Entry Set Recon.-Nos"
{
    Permissions = TableData "Bank Account Ledger Entry"=rm,
                  TableData "Check Ledger Entry"=rm;

    trigger OnRun()
    begin
    end;

    var
        Text000: label 'cannot be %1';
        BankAccLedgEntry: Record "Bank Account Ledger Entry";


    procedure ToggleReconNo(var CheckLedgEntry: Record "Check Ledger Entry";var BankAccReconLine: Record "Bank Acc. Reconciliation Lines";ChangeAmount: Boolean)
    begin
        BankAccLedgEntry.LockTable;
        CheckLedgEntry.LockTable;
        BankAccReconLine.LockTable;
        BankAccReconLine.Find;
        if CheckLedgEntry."Statement No." = '' then begin
          SetReconNo(CheckLedgEntry,BankAccReconLine);
          BankAccReconLine."Applied Amount" := BankAccReconLine."Applied Amount" - CheckLedgEntry.Amount;
          BankAccReconLine."Applied Entries" := BankAccReconLine."Applied Entries" + 1;
        end else begin
          RemoveReconNo(CheckLedgEntry,BankAccReconLine,true);
          BankAccReconLine."Applied Amount" := BankAccReconLine."Applied Amount" + CheckLedgEntry.Amount;
          BankAccReconLine."Applied Entries" := BankAccReconLine."Applied Entries" - 1;
        end;
        if BankAccReconLine."Applied Entries" = 1 then
          BankAccReconLine."Check No." := CheckLedgEntry."Check No."
        else
          BankAccReconLine."Check No." := '';
        if ChangeAmount then
          BankAccReconLine.Validate("Statement Amount",BankAccReconLine."Applied Amount")
        else
          BankAccReconLine.Validate("Statement Amount");
        BankAccReconLine.Modify;
    end;


    procedure SetReconNo(var CheckLedgEntry: Record "Check Ledger Entry";var BankAccReconLine: Record "Bank Acc. Reconciliation Lines")
    begin
        CheckLedgEntry.TestField(Open,true);
        if (CheckLedgEntry."Statement Status" <> CheckLedgEntry."statement status"::Open) and
           (CheckLedgEntry."Statement Status" <>
            CheckLedgEntry."statement status"::"Check Entry Applied")
        then
          CheckLedgEntry.FieldError(
            "Statement Status",StrSubstNo(Text000,CheckLedgEntry."Statement Status"));
        CheckLedgEntry.TestField("Statement No.",'');
        CheckLedgEntry.TestField("Statement Line No.",0);
        if not (CheckLedgEntry."Entry Status" in
                [CheckLedgEntry."entry status"::Posted,CheckLedgEntry."entry status"::"Financially Voided"])
        then
          CheckLedgEntry.FieldError(
            "Entry Status",StrSubstNo(Text000,CheckLedgEntry."Entry Status"));
        CheckLedgEntry.TestField("Bank Account No.",BankAccReconLine."Bank Account No.");
        CheckLedgEntry."Statement Status" := CheckLedgEntry."statement status"::"Check Entry Applied";
        CheckLedgEntry."Statement No." := BankAccReconLine."Statement No.";
        CheckLedgEntry."Statement Line No." := BankAccReconLine."Statement Line No.";
        CheckLedgEntry.Modify;

        BankAccLedgEntry.Get(CheckLedgEntry."Bank Account Ledger Entry No.");
        BankAccLedgEntry.TestField(Open,true);
        if (BankAccLedgEntry."Statement Status" <> BankAccLedgEntry."statement status"::Open) and
           (BankAccLedgEntry."Statement Status" <>
            BankAccLedgEntry."statement status"::"Check Entry Applied")
        then
          BankAccLedgEntry.FieldError(
            "Statement Status",StrSubstNo(Text000,BankAccLedgEntry."Statement Status"));
        BankAccLedgEntry.TestField("Statement No.",'');
        BankAccLedgEntry.TestField("Statement Line No.",0);
        BankAccLedgEntry."Statement Status" :=
          BankAccLedgEntry."statement status"::"Check Entry Applied";
        BankAccLedgEntry."Statement No." := '';
        BankAccLedgEntry."Statement Line No." := 0;
        BankAccLedgEntry.Modify;
    end;


    procedure RemoveReconNo(var CheckLedgEntry: Record "Check Ledger Entry";var BankAccReconLine: Record "Bank Acc. Reconciliation Lines";Test: Boolean)
    var
        CheckLedgEntry2: Record "Check Ledger Entry";
    begin
        CheckLedgEntry.TestField(Open,true);
        if Test then begin
          CheckLedgEntry.TestField(
            "Statement Status",CheckLedgEntry."statement status"::"Check Entry Applied");
          CheckLedgEntry.TestField("Statement No.",BankAccReconLine."Statement No.");
          CheckLedgEntry.TestField("Statement Line No.",BankAccReconLine."Statement Line No.");
        end;
        CheckLedgEntry.TestField("Bank Account No.",BankAccReconLine."Bank Account No.");
        CheckLedgEntry."Statement Status" := CheckLedgEntry."statement status"::Open;
        CheckLedgEntry."Statement No." := '';
        CheckLedgEntry."Statement Line No." := 0;
        CheckLedgEntry.Modify;

        CheckLedgEntry2.Reset;
        CheckLedgEntry2.SetCurrentkey("Bank Account Ledger Entry No.");
        CheckLedgEntry2.SetRange(
          "Bank Account Ledger Entry No.",CheckLedgEntry."Bank Account Ledger Entry No.");
        CheckLedgEntry2.SetRange(
          "Statement Status",CheckLedgEntry."statement status"::"Check Entry Applied");
        if not CheckLedgEntry2.FindFirst then begin
          BankAccLedgEntry.Get(CheckLedgEntry."Bank Account Ledger Entry No.");
          BankAccLedgEntry.TestField(Open,true);
          if Test then begin
            BankAccLedgEntry.TestField(
              "Statement Status",BankAccLedgEntry."statement status"::"Check Entry Applied");
            BankAccLedgEntry.TestField("Statement No.",'');
            BankAccLedgEntry.TestField("Statement Line No.",0);
          end;
          BankAccLedgEntry."Statement Status" := BankAccLedgEntry."statement status"::Open;
          BankAccLedgEntry."Statement No." := '';
          BankAccLedgEntry."Statement Line No." := 0;
          BankAccLedgEntry.Modify;
        end;
    end;
}

