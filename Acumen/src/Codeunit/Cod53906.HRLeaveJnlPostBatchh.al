#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 53906 "HR Leave Jnl.-Post Batchh"
{
    Permissions = TableData UnknownTableData56104=imd;
    TableNo = "Loan Product Cycles";

    trigger OnRun()
    begin
        InsuranceJnlLine.Copy(Rec);
        Code;
        Rec := InsuranceJnlLine;
    end;

    var
        Text000: label 'cannot exceed %1 characters';
        Text001: label 'Journal Batch Name    #1##########\\';
        Text002: label 'Checking lines        #2######\';
        Text003: label 'Posting lines         #3###### @4@@@@@@@@@@@@@';
        Text004: label 'A maximum of %1 posting number series can be used in each journal.';
        InsuranceJnlLine: Record "Loan Product Cycles";
        InsuranceJnlTempl: Record "prPayroll Periods.";
        InsuranceJnlBatch: Record "Inspection Header";
        InsuranceReg: Record "Payroll Employee Transact New";
        InsCoverageLedgEntry: Record "Loan Product Charges";
        InsuranceJnlLine2: Record "Loan Product Cycles";
        InsuranceJnlLine3: Record "Loan Product Cycles";
        NoSeries: Record "No. Series" temporary;
        FAJnlSetup: Record "PR PAYE";
        InsuranceJnlPostLine: Codeunit "HR Leave Jnl.-Post Linee";
        InsuranceJnlCheckLine: Codeunit "HR Leave Jnl.-Check Linee";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt2: array [10] of Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        Window: Dialog;
        LineCount: Integer;
        StartLineNo: Integer;
        NoOfRecords: Integer;
        InsuranceRegNo: Integer;
        LastDocNo: Code[20];
        LastDocNo2: Code[20];
        LastPostedDocNo: Code[20];
        NoOfPostingNoSeries: Integer;
        PostingNoSeriesNo: Integer;


    procedure "Code"()
    var
        UpdateAnalysisView: Codeunit "Update Analysis View";
        JnlLineDim: Record "HR Leave Planner Header";
        TempJnlLineDim: Record "HR Leave Planner Header" temporary;
    begin
        with InsuranceJnlLine do begin
          SetRange("Product Code","Product Code");
          SetRange(Cycle,Cycle);
          if RECORDLEVELLOCKING then
            LockTable;

          InsuranceJnlTempl.Get("Product Code");
          InsuranceJnlBatch.Get("Product Code",Cycle);
          if StrLen(IncStr(InsuranceJnlBatch."Purchase Order No.")) > MaxStrLen(InsuranceJnlBatch."Purchase Order No.") then
            InsuranceJnlBatch.FieldError(
              "Purchase Order No.",
              StrSubstNo(
                Text000,
                MaxStrLen(InsuranceJnlBatch."Purchase Order No.")));

          if not Find('=><') then begin
            Commit;
            "Max. Installments" := 0;
            exit;
          end;

          Window.Open(
            Text001 +
            Text002 +
            Text003);
          Window.Update(1,Cycle);

          // Check lines
          LineCount := 0;
          StartLineNo := "Max. Installments";
          repeat
            LineCount := LineCount + 1;
            Window.Update(2,LineCount);

            JnlLineDim.SetRange("Application Code",Database::"Loan Product Cycles");
            JnlLineDim.SetRange(Status,"Product Code");
            JnlLineDim.SetRange("No series",Cycle);
            JnlLineDim.SetRange(Picture,"Max. Installments");
            JnlLineDim.SetRange(Names,0);
            TempJnlLineDim.DeleteAll;
            //DimMgt.CopyJnlLineDimToJnlLineDim(JnlLineDim,TempJnlLineDim);
            InsuranceJnlCheckLine.RunCheck(InsuranceJnlLine,TempJnlLineDim);

            if Next = 0 then
              Find('-');
          until "Max. Installments" = StartLineNo;
          NoOfRecords := LineCount;

          //LedgEntryDim.LOCKTABLE;
          InsCoverageLedgEntry.LockTable;
          if RECORDLEVELLOCKING then
            if InsCoverageLedgEntry.Find('+') then;
          InsuranceReg.LockTable;
          if InsuranceReg.Find('+') then
            InsuranceRegNo := InsuranceReg."No." + 1
          else
            InsuranceRegNo := 1;

          // Post lines
          LineCount := 0;
          LastDocNo := '';
          LastDocNo2 := '';
          LastPostedDocNo := '';
          Find('-');
          repeat
            LineCount := LineCount + 1;
            Window.Update(3,LineCount);
            Window.Update(4,ROUND(LineCount / NoOfRecords * 10000,1));
            if not ("Max. Amount" = '') and
               (InsuranceJnlBatch."Date Received" <> '') and
               ("Document No." <> LastDocNo2)
            then
              //TESTFIELD("Document No.",NoSeriesMgt.GetNextNo(InsuranceJnlBatch."No. Series","Posting Date",FALSE));

        //    LastDocNo2 := "Document No.";
             LastDocNo2:=NoSeriesMgt.GetNextNo(InsuranceJnlBatch."Date Received","Posting Date",false);
            if "Posting No. Series" = '' then
              "Posting No. Series" := InsuranceJnlBatch."Date Received"
            else
              if not ("Max. Amount" = '') then
                if "Document No." = LastDocNo then
                  "Document No." := LastPostedDocNo
                else begin
                  if not NoSeries.Get("Posting No. Series") then begin
                    NoOfPostingNoSeries := NoOfPostingNoSeries + 1;
                    if NoOfPostingNoSeries > ArrayLen(NoSeriesMgt2) then
                      Error(
                        Text004,
                        ArrayLen(NoSeriesMgt2));
                    NoSeries.Code := "Posting No. Series";
                    NoSeries.Description := Format(NoOfPostingNoSeries);
                    NoSeries.Insert;
                  end;
                  LastDocNo := "Document No.";
                  Evaluate(PostingNoSeriesNo,NoSeries.Description);
                  "Document No." := NoSeriesMgt2[PostingNoSeriesNo].GetNextNo("Posting No. Series","Posting Date",false);
                  LastPostedDocNo := "Document No.";
                end;

            JnlLineDim.SetRange("Application Code",Database::"Loan Product Cycles");
            JnlLineDim.SetRange(Status,"Product Code");
            JnlLineDim.SetRange("No series",Cycle);
            JnlLineDim.SetRange(Picture,"Max. Installments");
            JnlLineDim.SetRange(Names,0);
            TempJnlLineDim.DeleteAll;
            //DimMgt.CopyJnlLineDimToJnlLineDim(JnlLineDim,TempJnlLineDim);
            InsuranceJnlPostLine.RunWithOutCheck(InsuranceJnlLine,TempJnlLineDim);
           until Next = 0;

          if InsuranceReg.Find('+') then;
          if InsuranceReg."No." <> InsuranceRegNo then
            InsuranceRegNo := 0;

          Init;
          "Max. Installments" := InsuranceRegNo;

          // Update/delete lines
          if InsuranceRegNo <> 0 then begin
            if not RECORDLEVELLOCKING then begin
              JnlLineDim.LockTable(true,true);
              LockTable(true,true);
            end;
            InsuranceJnlLine2.CopyFilters(InsuranceJnlLine);
            InsuranceJnlLine2.SetFilter("Max. Amount",'<>%1','');
            if InsuranceJnlLine2.Find('+') then; // Remember the last line

            JnlLineDim.SetRange("Application Code",Database::"Loan Product Cycles");
            JnlLineDim.Copyfilter(Status,"Product Code");
            JnlLineDim.Copyfilter("No series",Cycle);
            JnlLineDim.SetRange(Names,0);

            InsuranceJnlLine3.Copy(InsuranceJnlLine);
            if InsuranceJnlLine3.Find('-') then
              repeat
                //JnlLineDim.SETRANGE("Journal Line No.",InsuranceJnlLine3."Line No.");
                //JnlLineDim.DELETEALL;
                InsuranceJnlLine3.Delete;
              until InsuranceJnlLine3.Next = 0;
            InsuranceJnlLine3.Reset;
            InsuranceJnlLine3.SetRange("Product Code","Product Code");
            InsuranceJnlLine3.SetRange(Cycle,Cycle);
            if not InsuranceJnlLine3.Find('+') then
              if IncStr(Cycle) <> '' then begin
                InsuranceJnlBatch.Get("Product Code",Cycle);
                InsuranceJnlBatch.Delete;
                //FAJnlSetup.IncInsuranceJnlBatchName(InsuranceJnlBatch);
                InsuranceJnlBatch."Purchase Order No." := IncStr(Cycle);
                if InsuranceJnlBatch.Insert then;
                Cycle := InsuranceJnlBatch."Purchase Order No.";
              end;

            InsuranceJnlLine3.SetRange(Cycle,Cycle);
            if (InsuranceJnlBatch."Date Received" = '') and not InsuranceJnlLine3.Find('+') then begin
              InsuranceJnlLine3.Init;
              InsuranceJnlLine3."Product Code" := "Product Code";
              InsuranceJnlLine3.Cycle := Cycle;
              InsuranceJnlLine3."Max. Installments" := 10000;
              InsuranceJnlLine3.Insert;
              InsuranceJnlLine3.SetUpNewLine(InsuranceJnlLine2);
              InsuranceJnlLine3.Modify;
            end;
          end;
          if InsuranceJnlBatch."Date Received" <> '' then
            NoSeriesMgt.SaveNoSeries;
          if NoSeries.Find('-') then
            repeat
              Evaluate(PostingNoSeriesNo,NoSeries.Description);
              NoSeriesMgt2[PostingNoSeriesNo].SaveNoSeries;
            until NoSeries.Next = 0;

          Commit;
          Clear(InsuranceJnlCheckLine);
          Clear(InsuranceJnlPostLine);
        end;
        UpdateAnalysisView.UpdateAll(0,true);
        Commit;
    end;
}

