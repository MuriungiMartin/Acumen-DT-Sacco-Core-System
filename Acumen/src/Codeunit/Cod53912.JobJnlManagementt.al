#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 53912 "Job-JnlManagementt"
{
    Permissions = TableData "Job Journal Template"=imd,
                  TableData "Job Journal Batch"=imd;

    trigger OnRun()
    begin
    end;

    var
        Text000: label 'JOB';
        Text001: label 'Job Journal';
        Text002: label 'RECURRING';
        Text003: label 'Recurring Job Journal';
        Text004: label 'DEFAULT';
        Text005: label 'Default Journal';
        LastJobJnlLine: Record UnknownRecord53917;
        OpenFromBatch: Boolean;


    procedure TemplateSelection(FormID: Integer;RecurringJnl: Boolean;var JobJnlLine: Record UnknownRecord53917;var JnlSelected: Boolean)
    var
        JobJnlTemplate: Record UnknownRecord53916;
    begin
        JnlSelected := true;

        JobJnlTemplate.Reset;
        JobJnlTemplate.SetRange("Form ID",FormID);
        JobJnlTemplate.SetRange(Recurring,RecurringJnl);

        case JobJnlTemplate.Count of
          0:
            begin
              JobJnlTemplate.Init;
              JobJnlTemplate.Recurring := RecurringJnl;
              if not RecurringJnl then begin
                JobJnlTemplate.Name := Text000;
                JobJnlTemplate.Description := Text001;
              end else begin
                JobJnlTemplate.Name := Text002;
                JobJnlTemplate.Description := Text003;
              end;
              JobJnlTemplate.Validate("Form ID");
              JobJnlTemplate.Insert;
              Commit;
            end;
          1:
            JobJnlTemplate.Find('-');
          else
            JnlSelected := Page.RunModal(0,JobJnlTemplate) = Action::LookupOK;
        end;
        if JnlSelected then begin
          JobJnlLine.FilterGroup := 2;
          JobJnlLine.SetRange("Journal Template Name",JobJnlTemplate.Name);
          JobJnlLine.FilterGroup := 0;
          if OpenFromBatch then begin
            JobJnlLine."Journal Template Name" := '';
            Page.Run(JobJnlTemplate."Form ID",JobJnlLine);
          end;
        end;
    end;


    procedure TemplateSelectionFromBatch(var JobJnlBatch: Record UnknownRecord53922)
    var
        JobJnlLine: Record UnknownRecord53917;
        JobJnlTemplate: Record UnknownRecord53916;
        JnlSelected: Boolean;
    begin
        OpenFromBatch := true;
        JobJnlTemplate.Get(JobJnlBatch."Journal Template Name");
        JobJnlTemplate.TestField("Form ID");
        JobJnlBatch.TestField(Name);

        JobJnlLine.FilterGroup := 2;
        JobJnlLine.SetRange("Journal Template Name",JobJnlTemplate.Name);
        JobJnlLine.FilterGroup := 0;

        JobJnlLine."Journal Template Name" := '';
        JobJnlLine."Journal Batch Name" := JobJnlBatch.Name;
        Page.Run(JobJnlTemplate."Form ID",JobJnlLine);
    end;


    procedure OpenJnl(var CurrentJnlBatchName: Code[10];var JobJnlLine: Record UnknownRecord53917)
    begin
        CheckTemplateName(JobJnlLine.GetRangemax("Journal Template Name"),CurrentJnlBatchName);
        JobJnlLine.FilterGroup := 2;
        JobJnlLine.SetRange("Journal Batch Name",CurrentJnlBatchName);
        JobJnlLine.FilterGroup := 0;
    end;


    procedure OpenJnlBatch(var JobJnlBatch: Record UnknownRecord53922)
    var
        JobJnlTemplate: Record UnknownRecord53916;
        JobJnlLine: Record UnknownRecord53917;
        JobJnlBatch2: Record UnknownRecord53922;
        JnlSelected: Boolean;
    begin
        if JobJnlBatch.GetFilter("Journal Template Name") <> '' then
          exit;
        JobJnlBatch.FilterGroup(2);
        if JobJnlBatch.GetFilter("Journal Template Name") <> '' then begin
          JobJnlBatch.FilterGroup(0);
          exit;
        end;
        JobJnlBatch.FilterGroup(0);

        if not JobJnlBatch.Find('-') then begin
          if not JobJnlTemplate.Find('-') then
            TemplateSelection(0,false,JobJnlLine,JnlSelected);
          if JobJnlTemplate.Find('-') then
            CheckTemplateName(JobJnlTemplate.Name,JobJnlBatch.Name);
          JobJnlTemplate.SetRange(Recurring,true);
          if not JobJnlTemplate.Find('-') then
            TemplateSelection(0,true,JobJnlLine,JnlSelected);
          if JobJnlTemplate.Find('-') then
            CheckTemplateName(JobJnlTemplate.Name,JobJnlBatch.Name);
          JobJnlTemplate.SetRange(Recurring);
        end;
        JobJnlBatch.Find('-');
        JnlSelected := true;
        JobJnlBatch.CalcFields(Recurring);
        JobJnlTemplate.SetRange(Recurring,JobJnlBatch.Recurring);
        if JobJnlBatch.GetFilter("Journal Template Name") <> '' then
           JobJnlTemplate.SetRange(Name,JobJnlBatch.GetFilter("Journal Template Name"));
        case JobJnlTemplate.Count of
          1:
            JobJnlTemplate.Find('-');
          else
            JnlSelected := Page.RunModal(0,JobJnlTemplate) = Action::LookupOK;
        end;
        if not JnlSelected then
          Error('');

        JobJnlBatch.FilterGroup(2);
        JobJnlBatch.SetRange("Journal Template Name",JobJnlTemplate.Name);
        JobJnlBatch.FilterGroup(0);
    end;


    procedure CheckTemplateName(CurrentJnlTemplateName: Code[10];var CurrentJnlBatchName: Code[10])
    var
        JobJnlBatch: Record UnknownRecord53922;
    begin
        JobJnlBatch.SetRange("Journal Template Name",CurrentJnlTemplateName);
        if not JobJnlBatch.Get(CurrentJnlTemplateName,CurrentJnlBatchName) then begin
          if not JobJnlBatch.Find('-') then begin
            JobJnlBatch.Init;
            JobJnlBatch."Journal Template Name" := CurrentJnlTemplateName;
            JobJnlBatch.SetupNewBatch;
            JobJnlBatch.Name := Text004;
            JobJnlBatch.Description := Text005;
            JobJnlBatch.Insert(true);
            Commit;
          end;
          CurrentJnlBatchName := JobJnlBatch.Name;
        end;
    end;


    procedure CheckName(CurrentJnlBatchName: Code[10];var JobJnlLine: Record UnknownRecord53917)
    var
        JobJnlBatch: Record UnknownRecord53922;
    begin
        JobJnlBatch.Get(JobJnlLine.GetRangemax("Journal Template Name"),CurrentJnlBatchName);
    end;


    procedure SetName(var CurrentJnlBatchName: Code[10];var JobJnlLine: Record UnknownRecord53917)
    begin
        JobJnlLine.FilterGroup := 2;
        JobJnlLine.SetRange("Journal Batch Name",CurrentJnlBatchName);
        JobJnlLine.FilterGroup := 0;
        if JobJnlLine.Find('-') then;
    end;


    procedure LookupName(var CurrentJnlBatchName: Code[10];var JobJnlLine: Record UnknownRecord53917): Boolean
    var
        JobJnlBatch: Record UnknownRecord53922;
    begin
        Commit;
        JobJnlBatch."Journal Template Name" := JobJnlLine.GetRangemax("Journal Template Name");
        JobJnlBatch.Name := JobJnlLine.GetRangemax("Journal Batch Name");
        JobJnlBatch.FilterGroup(2);
        JobJnlBatch.SetRange("Journal Template Name",JobJnlBatch."Journal Template Name");
        JobJnlBatch.FilterGroup(0);
        if Page.RunModal(0,JobJnlBatch) = Action::LookupOK then begin
          CurrentJnlBatchName := JobJnlBatch.Name;
          SetName(CurrentJnlBatchName,JobJnlLine);
        end;
    end;


    procedure GetNames(var JobJnlLine: Record UnknownRecord53917;var JobDescription: Text[50];var AccName: Text[50])
    var
        Job: Record UnknownRecord53913;
        Res: Record Resource;
        Item: Record Item;
        GLAcc: Record "G/L Account";
    begin
        if (JobJnlLine."Job No." = '') or
           (JobJnlLine."Job No." <> LastJobJnlLine."Job No.")
        then begin
          JobDescription := '';
          if Job.Get(JobJnlLine."Job No.") then
            JobDescription := Job.Description;
        end;

        if (JobJnlLine.Type <> LastJobJnlLine.Type) or
           (JobJnlLine."No." <> LastJobJnlLine."No.")
        then begin
          AccName := '';
          if JobJnlLine."No." <> '' then
            case JobJnlLine.Type of
              JobJnlLine.Type::"0":
                if Res.Get(JobJnlLine."No.") then
                  AccName := Res.Name;
              JobJnlLine.Type::"1":
                if Item.Get(JobJnlLine."No.") then
                  AccName := Item.Description;
              JobJnlLine.Type::"2":
                if GLAcc.Get(JobJnlLine."No.") then
                  AccName := GLAcc.Name;
            end;
        end;

        LastJobJnlLine := JobJnlLine;
    end;
}

