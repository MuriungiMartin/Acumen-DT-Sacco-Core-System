#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516158 "Gen. Jnl.-Post Sacco"
{
    TableNo = "Gen. Journal Line";

    trigger OnRun()
    begin
        GenJnlLine.Copy(Rec);
        Code;
        Rec.Copy(GenJnlLine);
    end;

    var
        Text000: label 'cannot be filtered when posting recurring journals';
        Text001: label 'Do you want to post the journal lines?';
        Text002: label 'There is nothing to post.';
        Text003: label 'The journal lines were successfully posted.';
        Text004: label 'The journal lines were successfully posted. You are now in the %1 journal.';
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        TempJnlBatchName: Code[10];

    local procedure "Code"()
    begin
        with GenJnlLine do begin
         // GenJnlTemplate.GET("Journal Template Name");
          GenJnlTemplate.TestField("Force Posting Report",false);
          if GenJnlTemplate.Recurring and (GetFilter("Posting Date") <> '') then
            FieldError("Posting Date",Text000);
        
          //IF NOT CONFIRM(Text001,FALSE) THEN
            //EXIT;
        
          TempJnlBatchName := "Journal Batch Name";
        
          GenJnlPostBatch.Run(GenJnlLine);
        
          if "Line No." = 0 then
            Message(Text002)
          else
          /*
            IF TempJnlBatchName = "Journal Batch Name" THEN
              MESSAGE(Text003)
            ELSE
              MESSAGE(
                Text004,
                "Journal Batch Name");
          */
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

