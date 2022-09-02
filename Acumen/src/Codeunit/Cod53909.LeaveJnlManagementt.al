#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 53909 "LeaveJnlManagementt"
{
    Permissions = TableData "Insurance Journal Template"=imd,
                  TableData "Insurance Journal Batch"=imd;

    trigger OnRun()
    begin
    end;

    var
        Text000: label 'Leave';
        Text001: label 'Leave Journal';
        Text002: label 'DEFAULT';
        Text003: label 'Default Journal';
        OldInsuranceNo: Code[20];
        OldFANo: Code[20];
        OpenFromBatch: Boolean;


    procedure TemplateSelection(FormID: Integer;var InsuranceJnlLine: Record UnknownRecord55618;var JnlSelected: Boolean)
    var
        InsuranceJnlTempl: Record UnknownRecord55576;
    begin
        JnlSelected := true;

        InsuranceJnlTempl.Reset;
        InsuranceJnlTempl.SetRange("Form ID",FormID);

        case InsuranceJnlTempl.Count of

           0:

          begin
              InsuranceJnlTempl.Reset;
              InsuranceJnlTempl.SetRange(InsuranceJnlTempl.Name,Text000);
              if InsuranceJnlTempl.Find('-') then
               InsuranceJnlTempl.DeleteAll;

              InsuranceJnlTempl.Init;
              InsuranceJnlTempl.Name := Text000;
              InsuranceJnlTempl.Description := Text001;
              InsuranceJnlTempl.Validate("Form ID");
              InsuranceJnlTempl.Insert;
              Commit;
            end;

          1:
            InsuranceJnlTempl.Find('-');
          else
            JnlSelected := Page.RunModal(0,InsuranceJnlTempl) = Action::LookupOK;
        end;
        if JnlSelected then begin
          InsuranceJnlLine.FilterGroup := 2;
          InsuranceJnlLine.SetRange("Journal Template Name",InsuranceJnlTempl.Name);
          InsuranceJnlLine.FilterGroup := 0;
          if OpenFromBatch then begin
            InsuranceJnlLine."Journal Template Name" := '';
            Page.Run(InsuranceJnlTempl."Form ID",InsuranceJnlLine);
          end;
        end;
    end;


    procedure TemplateSelectionFromBatch(var InsuranceJnlBatch: Record UnknownRecord55577)
    var
        InsuranceJnlLine: Record UnknownRecord55618;
        InsuranceJnlTempl: Record UnknownRecord55576;
        JnlSelected: Boolean;
    begin
        OpenFromBatch := true;
        InsuranceJnlTempl.Get(InsuranceJnlBatch."Journal Template Name");
        InsuranceJnlTempl.TestField("Form ID");
        InsuranceJnlBatch.TestField(Name);

        InsuranceJnlLine.FilterGroup := 2;
        InsuranceJnlLine.SetRange("Journal Template Name",InsuranceJnlTempl.Name);
        InsuranceJnlLine.FilterGroup := 0;

        InsuranceJnlLine."Journal Template Name" := '';
        InsuranceJnlLine."Journal Batch Name" := InsuranceJnlBatch.Name;
        Page.Run(InsuranceJnlTempl."Form ID",InsuranceJnlLine);
    end;


    procedure OpenJournal(var CurrentJnlBatchName: Code[10];var InsuranceJnlLine: Record UnknownRecord55618)
    begin
        CheckTemplateName(InsuranceJnlLine.GetRangemax("Journal Template Name"),CurrentJnlBatchName);
        InsuranceJnlLine.FilterGroup := 2;
        InsuranceJnlLine.SetRange("Journal Batch Name",CurrentJnlBatchName);
        InsuranceJnlLine.FilterGroup := 0;
    end;


    procedure OpenJnlBatch(var InsuranceJnlBatch: Record UnknownRecord55577)
    var
        InsuranceJnlTemplate: Record UnknownRecord55576;
        InsuranceJnlLine: Record UnknownRecord55618;
        JnlSelected: Boolean;
    begin
        if InsuranceJnlBatch.GetFilter("Journal Template Name") <> '' then
          exit;
        InsuranceJnlBatch.FilterGroup(2);
        if InsuranceJnlBatch.GetFilter("Journal Template Name") <> '' then begin
          InsuranceJnlBatch.FilterGroup(0);
          exit;
        end;
        InsuranceJnlBatch.FilterGroup(0);

        if not InsuranceJnlBatch.Find('-') then begin
          if not InsuranceJnlTemplate.Find('-') then
            TemplateSelection(0,InsuranceJnlLine,JnlSelected);
          if InsuranceJnlTemplate.Find('-') then
            CheckTemplateName(InsuranceJnlTemplate.Name,InsuranceJnlBatch.Name);
        end;
        InsuranceJnlBatch.Find('-');
        JnlSelected := true;
        if InsuranceJnlBatch.GetFilter("Journal Template Name") <> '' then
           InsuranceJnlTemplate.SetRange(Name,InsuranceJnlBatch.GetFilter("Journal Template Name"));
        case InsuranceJnlTemplate.Count of
          1:
            InsuranceJnlTemplate.Find('-');
          else
            JnlSelected := Page.RunModal(0,InsuranceJnlTemplate) = Action::LookupOK;
        end;
        if not JnlSelected then
          Error('');

        InsuranceJnlBatch.FilterGroup(2);
        InsuranceJnlBatch.SetRange("Journal Template Name",InsuranceJnlTemplate.Name);
        InsuranceJnlBatch.FilterGroup(0);
    end;


    procedure CheckName(CurrentJnlBatchName: Code[10];var InsuranceJnlLine: Record UnknownRecord55618)
    var
        InsuranceJnlBatch: Record UnknownRecord55577;
    begin
        InsuranceJnlBatch.Get(InsuranceJnlLine.GetRangemax("Journal Template Name"),CurrentJnlBatchName);
    end;


    procedure SetName(CurrentJnlBatchName: Code[10];var InsuranceJnlLine: Record UnknownRecord55618)
    begin
        InsuranceJnlLine.FilterGroup := 2;
        InsuranceJnlLine.SetRange("Journal Batch Name",CurrentJnlBatchName);
        InsuranceJnlLine.FilterGroup := 0;
        if InsuranceJnlLine.Find('-') then;
    end;


    procedure LookupName(var CurrentJnlBatchName: Code[10];var InsuranceJnlLine: Record UnknownRecord55618): Boolean
    var
        InsuranceJnlBatch: Record UnknownRecord55577;
    begin
        Commit;

        InsuranceJnlBatch."Journal Template Name" := InsuranceJnlLine.GetRangemax("Journal Template Name");
        InsuranceJnlBatch.Name := InsuranceJnlLine.GetRangemax("Journal Batch Name");
        InsuranceJnlBatch.FilterGroup(2);
        InsuranceJnlBatch.SetRange("Journal Template Name",InsuranceJnlBatch."Journal Template Name");
        InsuranceJnlBatch.FilterGroup(0);
        if Page.RunModal(0,InsuranceJnlBatch) = Action::LookupOK then begin
          CurrentJnlBatchName := InsuranceJnlBatch.Name;
          SetName(CurrentJnlBatchName,InsuranceJnlLine);
        end;
    end;


    procedure CheckTemplateName(CurrentJnlTemplateName: Code[10];var CurrentJnlBatchName: Code[10])
    var
        InsuranceJnlBatch: Record UnknownRecord55577;
    begin
        if not InsuranceJnlBatch.Get(CurrentJnlTemplateName,CurrentJnlBatchName) then begin
          InsuranceJnlBatch.SetRange("Journal Template Name",CurrentJnlTemplateName);
          if not InsuranceJnlBatch.Find('-') then begin
            InsuranceJnlBatch.Init;
            InsuranceJnlBatch."Journal Template Name" := CurrentJnlTemplateName;
            InsuranceJnlBatch.SetupNewBatch;
            InsuranceJnlBatch.Name := Text002;
            InsuranceJnlBatch.Description := Text003;
            InsuranceJnlBatch.Insert(true);
            Commit;
          end;
          CurrentJnlBatchName := InsuranceJnlBatch.Name;
        end;
    end;


    procedure GetDescriptions(InsuranceJnlLine: Record UnknownRecord55618;var InsuranceDescription: Text[30];var FADescription: Text[30])
    var
        Insurance: Record UnknownRecord55571;
        FA: Record UnknownRecord55543;
    begin
        if InsuranceJnlLine."Document No." <> OldInsuranceNo then begin
          InsuranceDescription := '';
          if InsuranceJnlLine."Document No." <> '' then
            if Insurance.Get(InsuranceJnlLine."Document No.") then
              InsuranceDescription := Insurance.Description;
          OldInsuranceNo := InsuranceJnlLine."Document No.";
        end;
        if InsuranceJnlLine."Staff No." <> OldFANo then begin
          FADescription := '';
          if InsuranceJnlLine."Staff No." <> '' then
            if FA.Get(InsuranceJnlLine."Staff No.") then
              FADescription := FA."First Name";
          OldFANo := FA."No.";
        end;
    end;
}

