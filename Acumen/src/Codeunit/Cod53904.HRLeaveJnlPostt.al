#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 53904 "HR Leave Jnl.-Postt"
{
    TableNo = "Loan Product Cycles";

    trigger OnRun()
    begin
        HRJournalLine.Copy(Rec);
        Code;
        Rec.Copy(HRJournalLine);
    end;

    var
        Text000: label 'Do you want to post the journal lines?';
        Text001: label 'There is nothing to post.';
        Text002: label 'The journal lines were successfully posted.';
        Text003: label 'The journal lines were successfully posted. You are now in the %1 journal.';
        HRLeaveJournalTemplate: Record "prPayroll Periods.";
        HRJournalLine: Record "Loan Product Cycles";
        HRLeaveJnlPostBatch: Codeunit "HR Leave Jnl.-Post Batchh";
        TempJnlBatchName: Code[10];

    local procedure "Code"()
    begin
        with HRJournalLine do begin
          HRLeaveJournalTemplate.Get("Product Code");
          HRLeaveJournalTemplate.TestField("Tax Paid");

          if not Confirm(Text000,false) then
            exit;

          TempJnlBatchName := 'Cycle';

          HRLeaveJnlPostBatch.Run(HRJournalLine);

          if "Max. Installments" = 0 then
            Message(Text001)
          else
            if TempJnlBatchName = 'Cycle' then
              Message(Text002)
            else
              Message(
                Text003,
                Cycle);

          if not Find('=><') or (TempJnlBatchName <> 'Cycle') then begin
            Reset;
            FilterGroup := 2;
            SetRange("Product Code","Product Code");
            SetRange(Cycle,Cycle);
            FilterGroup := 0;
            "Max. Installments" := 1;
          end;
        end;
    end;
}

