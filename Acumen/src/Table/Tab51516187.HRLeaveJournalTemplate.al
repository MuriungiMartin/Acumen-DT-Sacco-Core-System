#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516187 "HR Leave Journal Template"
{

    fields
    {
        field(1;Name;Code[20])
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
        field(10;"Source Code";Code[20])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";

            trigger OnValidate()
            begin
                InsuranceJnlLine.SetRange("Journal Template Name",Name);
                InsuranceJnlLine.ModifyAll("Source Code","Source Code");
                Modify;
            end;
        }
        field(11;"Reason Code";Code[20])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(13;"Test Report Name";Text[80])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where ("Object Type"=const(Report),
                                                                           "Object ID"=field("Test Report ID")));
            Caption = 'Test Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14;"Form Name";Text[80])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where ("Object Type"=const(Page),
                                                                           "Object ID"=field("Form ID")));
            Caption = 'Form Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15;"Posting Report Name";Text[80])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where ("Object Type"=const(Report),
                                                                           "Object ID"=field("Posting Report ID")));
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
                if ("No. Series" <> '') and ("No. Series" = "Posting No. Series") then
                  "Posting No. Series" := '';
            end;
        }
        field(17;"Posting No. Series";Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                if ("Posting No. Series" = "No. Series") and ("Posting No. Series" <> '') then
                  FieldError("Posting No. Series",StrSubstNo(Text000,"Posting No. Series"));
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
        InsuranceJnlLine.SetRange("Journal Template Name",Name);
        InsuranceJnlLine.DeleteAll(true);
        InsuranceJnlBatch.SetRange("Journal Template Name",Name);
        InsuranceJnlBatch.DeleteAll;
    end;

    trigger OnInsert()
    begin
        Validate("Form ID");
    end;

    var
        Text000: label 'must not be %1';
        InsuranceJnlLine: Record "HR Journal Line";
        InsuranceJnlBatch: Record "HR Leave Journal Batch";
        SourceCodeSetup: Record "Source Code Setup";
}

