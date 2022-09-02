#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 59005 "Process Bank Acc. Rec Liness"
{
    Permissions = TableData "Data Exch."=rimd;
    TableNo = "Bank Acc. Reconciliation Lines";

    trigger OnRun()
    var
        DataExch: Record "Data Exch.";
        ProcessDataExch: Codeunit "Process Data Exch.";
        RecRef: RecordRef;
    begin
        DataExch.Get("Posting Exch. Entry No.");
        RecRef.GetTable(Rec);
        ProcessDataExch.ProcessAllLinesColumnMapping(DataExch,RecRef);
    end;

    var
        ProgressWindowMsg: label 'Please wait while the operation is being completed.';


    procedure ImportBankStatement(BankAccRecon: Record "Bank Acc. ReconciliationAUT";DataExch: Record "Data Exch."): Boolean
    var
        BankAcc: Record "Bank Account";
        DataExchDef: Record "Data Exch. Def";
        DataExchMapping: Record "Data Exch. Mapping";
        DataExchLineDef: Record "Data Exch. Line Def";
        BankAccReconLine: Record "Bank Acc. Reconciliation Lines";
        ProgressWindow: Dialog;
    begin
        BankAcc.Get(BankAccRecon."Bank Account No.");
        BankAcc.GetDataExchDef(DataExchDef);

        if not DataExch.ImportToDataExch(DataExchDef)then
          exit(false);

        ProgressWindow.Open(ProgressWindowMsg);

        CreateBankAccRecLineTemplate(BankAccReconLine,BankAccRecon,DataExch);
        DataExchLineDef.SetRange("Data Exch. Def Code",DataExchDef.Code);
        DataExchLineDef.FindFirst;

        DataExchMapping.Get(DataExchDef.Code,DataExchLineDef.Code,Database::"Bank Acc. Reconciliation Lines");

        if DataExchMapping."Pre-Mapping Codeunit" <> 0 then
          Codeunit.Run(DataExchMapping."Pre-Mapping Codeunit",BankAccReconLine);

        DataExchMapping.TestField("Mapping Codeunit");
        Codeunit.Run(DataExchMapping."Mapping Codeunit",BankAccReconLine);

        if DataExchMapping."Post-Mapping Codeunit" <> 0 then
          Codeunit.Run(DataExchMapping."Post-Mapping Codeunit",BankAccReconLine);

        ProgressWindow.Close;
        exit(true);
    end;

    local procedure CreateBankAccRecLineTemplate(var BankAccReconLine: Record "Bank Acc. Reconciliation Lines";BankAccRecon: Record "Bank Acc. ReconciliationAUT";DataExch: Record "Data Exch.")
    begin
        BankAccReconLine.Init;
        BankAccReconLine."Statement Type" := BankAccRecon."Statement Type";
        BankAccReconLine."Statement No." := BankAccRecon."Statement No.";
        BankAccReconLine."Bank Account No." := BankAccRecon."Bank Account No.";
        BankAccReconLine."Posting Exch. Entry No." := DataExch."Entry No.";
    end;
}

