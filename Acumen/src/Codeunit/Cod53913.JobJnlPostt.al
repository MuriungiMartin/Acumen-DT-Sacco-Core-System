#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 53913 "Job-Jnl.-Postt"
{
    TableNo = UnknownTable53917;

    trigger OnRun()
    begin
        JobJnlLine.Copy(Rec);
        Code;
        Rec.Copy(JobJnlLine);
    end;

    var
        Text000: label 'cannot be filtered when posting recurring journals.';
        Text001: label 'Do you want to post the journal lines?';
        Text002: label 'There is nothing to post.';
        Text003: label 'The journal lines were successfully posted.';
        Text004: label 'The journal lines were successfully posted. ';
        Text005: label 'You are now in the %1 journal.';
        JobJnlTemplate: Record UnknownRecord53916;
        JobJnlLine: Record UnknownRecord53917;
        JobJnlPostbatch: Codeunit UnknownCodeunit53911;
        TempJnlBatchName: Code[10];

    local procedure "Code"()
    begin
        with JobJnlLine do begin
          JobJnlTemplate.Get("Journal Template Name");
          JobJnlTemplate.TestField("Force Posting Report",false);
          if JobJnlTemplate.Recurring and (GetFilter("Posting Date") <> '') then
            FieldError("Posting Date",Text000);

          if not Confirm(Text001) then
            exit;

          TempJnlBatchName := "Journal Batch Name";

          JobJnlPostbatch.Run(JobJnlLine);

          if "Line No." = 0 then
            Message(Text002)
          else
            if TempJnlBatchName = "Journal Batch Name" then
              Message(Text003)
            else
              Message(
                Text004 +
                Text005,
                "Journal Batch Name");

          if not Find('=><') or (TempJnlBatchName <> "Journal Batch Name") then begin
            Reset;
            FilterGroup(2);
            SetRange("Journal Template Name","Journal Template Name");
            SetRange("Journal Batch Name","Journal Batch Name");
            FilterGroup(0);
            "Line No." := 1;
          end;
        end;
    end;
}

