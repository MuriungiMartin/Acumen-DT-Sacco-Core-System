#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516274 "Job-Journal Template"
{
    Caption = 'Job Journal Template';

    fields
    {
        field(1;Name;Code[10])
        {
            Caption = 'Name';
            NotBlank = true;
        }
        field(2;Description;Text[80])
        {
            Caption = 'Description';
        }
        field(5;"Test Report ID";Integer)
        {
            Caption = 'Test Report ID';
            TableRelation = Object.ID where (Type=const(Report));
        }
        field(6;"Form ID";Integer)
        {
            Caption = 'Form ID';
            TableRelation = Object.ID where (Type=const(Page));

            trigger OnValidate()
            begin
                if "Form ID" = 0 then
                  Validate(Recurring);
            end;
        }
        field(7;"Posting Report ID";Integer)
        {
            Caption = 'Posting Report ID';
            TableRelation = Object.ID where (Type=const(Report));
        }
        field(8;"Force Posting Report";Boolean)
        {
            Caption = 'Force Posting Report';
        }
        field(10;"Source Code";Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";

            trigger OnValidate()
            begin
                JobJnlLine.SetRange("Journal Template Name",Name);
                JobJnlLine.ModifyAll("Source Code","Source Code");
                Modify;
            end;
        }
        field(11;"Reason Code";Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(12;Recurring;Boolean)
        {
            Caption = 'Recurring';

            trigger OnValidate()
            begin
                if Recurring then
                  "Form ID" := Page::"Recurring Job Jnl."
                else
                  "Form ID" := Page::"Job Journal";
                "Test Report ID" := Report::"Job Journal - Test";
                "Posting Report ID" := Report::"Job Register";
                SourceCodeSetup.Get;
                "Source Code" := SourceCodeSetup."Job Journal";
                if Recurring then
                  TestField("No. Series",'');
            end;
        }
        field(13;"Test Report Name";Text[80])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where ("Object Type"=const(Report),"Object ID"=field("Test Report ID")));
            Caption = 'Test Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14;"Form Name";Text[80])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where ("Object Type"=const(Page),"Object ID"=field("Form ID")));
            Caption = 'Form Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15;"Posting Report Name";Text[80])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where ("Object Type"=const(Report),"Object ID"=field("Posting Report ID")));
            Caption = 'Posting Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16;"No. Series";Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                if "No. Series" <> '' then begin
                  if Recurring then
                    Error(
                      Text000,
                      FieldCaption("Posting No. Series"));
                  if "No. Series" = "Posting No. Series" then
                    "Posting No. Series" := '';
                end;
            end;
        }
        field(17;"Posting No. Series";Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                if ("Posting No. Series" = "No. Series") and ("Posting No. Series" <> '') then
                  FieldError("Posting No. Series",StrSubstNo(Text001,"Posting No. Series"));
            end;
        }
    }

    keys
    {
        key(Key1;Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        JobJnlLine.SetRange("Journal Template Name",Name);
        JobJnlLine.DeleteAll(true);
        JobJnlBatch.SetRange("Journal Template Name",Name);
        JobJnlBatch.DeleteAll;
    end;

    trigger OnRename()
    begin
        ReservEngineMgt.RenamePointer(Database::"Job Journal Line",
          0,xRec.Name,'',0,0,
          0,Name,'',0,0);
    end;

    var
        Text000: label 'Only the %1 field can be filled in on recurring journals.';
        Text001: label 'must not be %1';
        JobJnlBatch: Record UnknownRecord53922;
        JobJnlLine: Record UnknownRecord53917;
        SourceCodeSetup: Record "Source Code Setup";
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
}

