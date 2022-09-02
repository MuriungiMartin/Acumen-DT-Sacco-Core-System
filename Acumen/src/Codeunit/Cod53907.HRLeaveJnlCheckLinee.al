#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 53907 "HR Leave Jnl.-Check Linee"
{
    TableNo = "Loan Product Cycles";

    trigger OnRun()
    var
        TempJnlLineDim: Record "HR Leave Planner Header" temporary;
    begin
        GLSetup.Get;

        if "Shortcut Dimension 1 Code" <> '' then begin
          TempJnlLineDim."Application Code" := Database::"Loan Product Cycles";
          TempJnlLineDim.Status := "Product Code";
          TempJnlLineDim."No series" := Cycle;
          TempJnlLineDim.Picture := "Max. Installments";
          TempJnlLineDim."Supervisor Email" := GLSetup."Global Dimension 1 Code";
          TempJnlLineDim."Job Tittle" := "Shortcut Dimension 1 Code";
          TempJnlLineDim.Insert;
        end;
        if "Shortcut Dimension 2 Code" <> '' then begin
          TempJnlLineDim."Application Code" := Database::"Loan Product Cycles";
          TempJnlLineDim.Status := "Product Code";
          TempJnlLineDim."No series" := Cycle;
          TempJnlLineDim.Picture := "Max. Installments";
          TempJnlLineDim."Supervisor Email" := GLSetup."Global Dimension 2 Code";
          TempJnlLineDim."Job Tittle" := "Shortcut Dimension 2 Code";
          TempJnlLineDim.Insert;
        end;

        RunCheck(Rec,TempJnlLineDim);
    end;

    var
        Text000: label 'The combination of dimensions used in %1 %2, %3, %4 is blocked. %5';
        Text001: label 'A dimension used in %1 %2, %3, %4 has caused an error. %5';
        GLSetup: Record "General Ledger Setup";
        FASetup: Record "PR PAYE";
        DimMgt: Codeunit DimensionManagement;
        CallNo: Integer;
        Text002: label 'The Posting Date Must be within the open leave periods';
        Text003: label 'The Posting Date Must be within the allowed Setup date';
        LeaveEntries: Record "Loan Product Charges";
        Text004: label 'The Allocation of Leave days has been done for the period';


    procedure ValidatePostingDate(var InsuranceJnlLine: Record "Loan Product Cycles")
    begin
        with InsuranceJnlLine do begin
           if "Leave Entry Type"="leave entry type"::"1" then begin
          TestField("Max. Amount");
         end;
          TestField("Document No.");
          TestField("Posting Date");
          TestField("Staff No.");
          if ("Posting Date"<"Leave Period Start Date") or
             ("Posting Date">"Leave Period End Date")  then
            // ERROR(FORMAT(Text002));
        
        FASetup.Get();
        if (FASetup."Leave Posting Period[FROM]"<>0D) and (FASetup."Leave Posting Period[TO]"<>0D) then begin
          if ("Posting Date"<FASetup."Leave Posting Period[FROM]") or
             ("Posting Date">FASetup."Leave Posting Period[TO]")  then
             Error(Format(Text003));
        end;
        /*
             LeaveEntries.RESET;
             LeaveEntries.SETRANGE(LeaveEntries."Leave Type","Leave Type Code");
            IF LeaveEntries.FIND('-') THEN BEGIN
         IF LeaveEntries."Leave Transaction Type"=LeaveEntries."Leave Transaction Type"::"Leave Allocation" THEN BEGIN
         IF (LeaveEntries."Posting Date"<"Leave Period Start Date") OR
             (LeaveEntries."Posting Date">"Leave Period End Date")  THEN
             ERROR(FORMAT(Text004));
                     END;
           END;
        */
        end;

    end;


    procedure RunCheck(var InsuranceJnlLine: Record "Loan Product Cycles";var JnlLineDim: Record "HR Leave Planner Header")
    var
        TableID: array [10] of Integer;
        No: array [10] of Code[20];
    begin
        with InsuranceJnlLine do begin
           if "Leave Entry Type"="leave entry type"::"1" then begin
          TestField("Leave Application No.");
         end;
          TestField("Document No.");
          TestField("Posting Date");
          TestField("Staff No.");
          CallNo := 1;
        
         /* IF NOT DimMgt.CheckJnlLineDimComb(JnlLineDim) THEN
            ERROR(
              Text000,
              TABLECAPTION,"Journal Template Name","Journal Batch Name","Line No.",
              DimMgt.GetDimCombErr);
          */
        //  TableID[1] := DATABASE::Table56175;
          TableID[1] := Database::"Loan Product Cycles";
          No[1] := "Leave Application No.";
         /* IF NOT DimMgt.CheckJnlLineDimValuePosting(JnlLineDim,TableID,No) THEN
            IF "Line No." <> 0 THEN
              ERROR(
                Text001,
                TABLECAPTION,"Journal Template Name","Journal Batch Name","Line No.",
                DimMgt.GetDimValuePostingErr)
            ELSE
              ERROR(DimMgt.GetDimValuePostingErr); */
        end;
        ValidatePostingDate(InsuranceJnlLine);

    end;

    local procedure JTCalculateCommonFilters()
    begin
    end;
}

