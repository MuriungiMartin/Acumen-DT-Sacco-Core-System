#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516101 "HR Leave Jnl.-Post"
{
    TableNo = "HR Journal Line";

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
        HRLeaveJournalTemplate: Record "HR Leave Journal Template";
        HRJournalLine: Record "HR Journal Line";
        HRLeaveJnlPostBatch: Codeunit "HR Leave Jnl.-Post Batch";
        TempJnlBatchName: Code[10];

    local procedure "Code"()
    begin
        with HRJournalLine do begin
          HRLeaveJournalTemplate.Get("Journal Template Name");
          HRLeaveJournalTemplate.TestField("Force Posting Report",false);

          if not Confirm(Text000,false) then
            exit;

          TempJnlBatchName := "Journal Batch Name";

          HRLeaveJnlPostBatch.Run(HRJournalLine);

          if "Line No." = 0 then
            Message(Text001)
          else
            if TempJnlBatchName = "Journal Batch Name" then
              Message(Text002)
            else
              Message(
                Text003,
                "Journal Batch Name");

          if not Find('=><') or (TempJnlBatchName <> "Journal Batch Name") then begin
            Reset;
            FilterGroup := 2;
            SetRange("Journal Template Name","Journal Template Name");
            SetRange("Journal Batch Name","Journal Batch Name");
            FilterGroup := 0;
            "Line No." := 1;
          end;
        end;
    end;
}

