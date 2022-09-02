#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 53908 "HR Leave Jnl.-Post Linee"
{
    Permissions = TableData "Ins. Coverage Ledger Entry"=rimd,
                  TableData "Insurance Register"=rimd;
    TableNo = "Loan Product Cycles";

    trigger OnRun()
    begin
        GLSetup.Get;
        TempJnlLineDim2.Reset;
        TempJnlLineDim2.DeleteAll;
        if "Shortcut Dimension 1 Code" <> '' then begin
          TempJnlLineDim2."Application Code" := Database::"Insurance Journal Line";
          TempJnlLineDim2.Status := "Product Code";
          TempJnlLineDim2."No series" := Cycle;
          TempJnlLineDim2.Picture := "Max. Installments";
          TempJnlLineDim2."Supervisor Email" := GLSetup."Global Dimension 1 Code";
          TempJnlLineDim2."Job Tittle" := "Shortcut Dimension 1 Code";
          TempJnlLineDim2.Insert;
        end;
        if "Shortcut Dimension 2 Code" <> '' then begin
          TempJnlLineDim2."Application Code" := Database::"Loan Product Cycles";
          TempJnlLineDim2.Status := "Product Code";
          TempJnlLineDim2."No series" := Cycle;
          TempJnlLineDim2.Picture := "Max. Installments";
          TempJnlLineDim2."Supervisor Email" := GLSetup."Global Dimension 2 Code";
          TempJnlLineDim2."Job Tittle" := "Shortcut Dimension 2 Code";
          TempJnlLineDim2.Insert;
        end;
        RunWithCheck(Rec,TempJnlLineDim2);
    end;

    var
        GLSetup: Record "General Ledger Setup";
        FA: Record "Salary Processing Header";
        Insurance: Record "prEmployee P9 Info";
        InsuranceJnlLine: Record "Loan Product Cycles";
        InsCoverageLedgEntry: Record "Loan Product Charges";
        InsCoverageLedgEntry2: Record "Loan Product Charges";
        InsuranceReg: Record "Payroll Employee Transact New";
        InsuranceJnlCheckLine: Codeunit "HR Leave Jnl.-Check Linee";
        MakeInsCoverageLedgEntry: Codeunit "HR Make Leave Ledg. Entryy";
        DimMgt: Codeunit DimensionManagement;
        NextEntryNo: Integer;
        TempJnlLineDim: Record "HR Leave Planner Header";
        TempJnlLineDim2: Record "HR Leave Planner Header";


    procedure RunWithCheck(var InsuranceJnlLine2: Record "Loan Product Cycles";TempJnlLineDim2: Record "HR Leave Planner Header")
    begin
        InsuranceJnlLine.Copy(InsuranceJnlLine2);
        TempJnlLineDim.Reset;
        TempJnlLineDim.DeleteAll;
        //DimMgt.CopyJnlLineDimToJnlLineDim(TempJnlLineDim2,TempJnlLineDim);
        Code(true);
        InsuranceJnlLine2 := InsuranceJnlLine;
    end;


    procedure RunWithOutCheck(var InsuranceJnlLine2: Record "Loan Product Cycles";TempJnlLineDim: Record "HR Leave Planner Header")
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
            NextEntryNo := InsCoverageLedgEntry2."Product Code";
          InsuranceReg.LockTable;
          if InsuranceReg.Find('+') then
            InsuranceReg."No." := InsuranceReg."No." + 1
          else
            InsuranceReg."No." := 1;
          InsuranceReg.Init;
          InsuranceReg."From Entry No." := NextEntryNo + 1;
          InsuranceReg."Creation Date" := Today;
          InsuranceReg."Source Code" := InsuranceJnlLine."Source Code";
          InsuranceReg."Journal Batch Name" := InsuranceJnlLine.Cycle;
          InsuranceReg."User ID" := UserId;
        end;
        NextEntryNo := NextEntryNo + 1;
        InsCoverageLedgEntry."Product Code" := NextEntryNo;
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

