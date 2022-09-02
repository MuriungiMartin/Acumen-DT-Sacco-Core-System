#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516104 "HR Leave Jnl.-Post Line"
{
    Permissions = TableData "Ins. Coverage Ledger Entry"=rimd,
                  TableData "Insurance Register"=rimd;
    TableNo = "HR Journal Line";

    trigger OnRun()
    begin
        GLSetup.Get;
        TempJnlLineDim2.Reset;
        TempJnlLineDim2.DeleteAll;
        if "Shortcut Dimension 1 Code" <> '' then begin
          TempJnlLineDim2."Table ID" := Database::"Insurance Journal Line";
          TempJnlLineDim2."Journal Template Name" := "Journal Template Name";
          TempJnlLineDim2."Journal Batch Name" := "Journal Batch Name";
          TempJnlLineDim2."Journal Line No." := "Line No.";
          TempJnlLineDim2."Dimension Code" := GLSetup."Global Dimension 1 Code";
          TempJnlLineDim2."Dimension Value Code" := "Shortcut Dimension 1 Code";
          TempJnlLineDim2.Insert;
        end;
        if "Shortcut Dimension 2 Code" <> '' then begin
          TempJnlLineDim2."Table ID" := Database::"HR Journal Line";
          TempJnlLineDim2."Journal Template Name" := "Journal Template Name";
          TempJnlLineDim2."Journal Batch Name" := "Journal Batch Name";
          TempJnlLineDim2."Journal Line No." := "Line No.";
          TempJnlLineDim2."Dimension Code" := GLSetup."Global Dimension 2 Code";
          TempJnlLineDim2."Dimension Value Code" := "Shortcut Dimension 2 Code";
          TempJnlLineDim2.Insert;
        end;
        RunWithCheck(Rec,TempJnlLineDim2);
    end;

    var
        GLSetup: Record "General Ledger Setup";
        FA: Record "HR Employees";
        Insurance: Record "HR Leave Application";
        InsuranceJnlLine: Record "HR Journal Line";
        InsCoverageLedgEntry: Record "HR Leave Ledger Entries";
        InsCoverageLedgEntry2: Record "HR Leave Ledger Entries";
        InsuranceReg: Record "HR Leave Register";
        InsuranceJnlCheckLine: Codeunit "HR Leave Jnl.-Check Line";
        MakeInsCoverageLedgEntry: Codeunit "HR Make Leave Ledg. Entry";
        DimMgt: Codeunit DimensionManagement;
        NextEntryNo: Integer;
        TempJnlLineDim: Record "Journal Line Dimension";
        TempJnlLineDim2: Record "Journal Line Dimension";


    procedure RunWithCheck(var InsuranceJnlLine2: Record "HR Journal Line";TempJnlLineDim2: Record "Journal Line Dimension")
    begin
        InsuranceJnlLine.Copy(InsuranceJnlLine2);
        TempJnlLineDim.Reset;
        TempJnlLineDim.DeleteAll;
        //DimMgt.CopyJnlLineDimToJnlLineDim(TempJnlLineDim2,TempJnlLineDim);
        Code(true);
        InsuranceJnlLine2 := InsuranceJnlLine;
    end;


    procedure RunWithOutCheck(var InsuranceJnlLine2: Record "HR Journal Line";TempJnlLineDim: Record "Journal Line Dimension")
    begin
        InsuranceJnlLine.Copy(InsuranceJnlLine2);

        TempJnlLineDim.Reset;
        TempJnlLineDim.DeleteAll;
        //DimMgt.CopyJnlLineDimToJnlLineDim(TempJnlLineDim2,TempJnlLineDim);

        Code(false);
        InsuranceJnlLine2 := InsuranceJnlLine;
    end;

    local procedure "Code"(CheckLine: Boolean)
    begin
        with InsuranceJnlLine do begin
          if "Document No." = '' then
            exit;
          if CheckLine then
        //    InsuranceJnlCheckLine.RunCheck(InsuranceJnlLine,TempJnlLineDim);
          Insurance.Reset;
          //Insurance.SETRANGE("Leave Application No.",
         // Insurance.GET("Document No.");
          FA.Get("Staff No.");
          MakeInsCoverageLedgEntry.CopyFromJnlLine(InsCoverageLedgEntry,InsuranceJnlLine);
          //MakeInsCoverageLedgEntry.CopyFromInsuranceCard(InsCoverageLedgEntry,Insurance);
        end;
        if NextEntryNo = 0 then begin
          InsCoverageLedgEntry.LockTable;
          if InsCoverageLedgEntry2.Find('+') then
            NextEntryNo := InsCoverageLedgEntry2."Entry No.";
          InsuranceReg.LockTable;
          if InsuranceReg.Find('+') then
            InsuranceReg."No." := InsuranceReg."No." + 1
          else
            InsuranceReg."No." := 1;
          InsuranceReg.Init;
          InsuranceReg."From Entry No." := NextEntryNo + 1;
          InsuranceReg."Creation Date" := Today;
          InsuranceReg."Source Code" := InsuranceJnlLine."Source Code";
          InsuranceReg."Journal Batch Name" := InsuranceJnlLine."Journal Batch Name";
          InsuranceReg."User ID" := UserId;
        end;
        NextEntryNo := NextEntryNo + 1;
        InsCoverageLedgEntry."Entry No." := NextEntryNo;
        InsCoverageLedgEntry.Insert;
        /*
        DimMgt.MoveJnlLineDimToLedgEntryDim(
          TempJnlLineDim,DATABASE::"Ins. Coverage Ledger Entry",
          InsCoverageLedgEntry."Entry No.");
        */
        if InsuranceReg."To Entry No." = 0 then begin
          InsuranceReg."To Entry No." := NextEntryNo;
          InsuranceReg.Insert;
        end else begin
          InsuranceReg."To Entry No." := NextEntryNo;
          InsuranceReg.Modify;
        end;

    end;
}

