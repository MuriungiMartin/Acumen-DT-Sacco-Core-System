#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516197 "HR Employee Qualifications"
{
    Caption = 'Employee Qualification';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = "Qualified Employees";
    LookupPageID = "Employee Qualifications";

    fields
    {
        field(1;"Employee No.";Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = "HR Employees"."No.";
        }
        field(2;"Line No.";Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(4;"From Date";Date)
        {
            Caption = 'From Date';
        }
        field(5;"To Date";Date)
        {
            Caption = 'To Date';
        }
        field(6;Type;Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Internal,External,Previous Position';
            OptionMembers = " ",Internal,External,"Previous Position";
        }
        field(7;Description;Text[100])
        {
            Caption = 'Description';
        }
        field(8;"Institution/Company";Text[30])
        {
            Caption = 'Institution/Company';
        }
        field(9;Cost;Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost';
        }
        field(10;"Course Grade";Text[30])
        {
            Caption = 'Course Grade';
        }
        field(11;"Employee Status";Option)
        {
            Caption = 'Employee Status';
            Editable = false;
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
        }
        field(12;Comment;Boolean)
        {
            CalcFormula = exist("Human Resource Comment Line" where ("Table Name"=const("Employee Qualification"),
                                                                     "No."=field("Employee No."),
                                                                     "Table Line No."=field("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13;"Expiration Date";Date)
        {
            Caption = 'Expiration Date';
        }
        field(14;"Qualification Type";Code[20])
        {
            NotBlank = false;
            TableRelation = "HR Lookup Values".Code where (Type=filter("Qualification Type"));
        }
        field(15;"Qualification Code";Code[30])
        {
            Editable = true;
            NotBlank = true;
            TableRelation = "HR Job Qualifications".Code where ("Qualification Type"=field("Qualification Type"));

            trigger OnValidate()
            begin
                /*.SETFILTER(Requirments."Qualification Type","Qualification Type");
                Requirments.SETFILTER(Requirments.Code,"Qualification Code");
                IF Requirments.FIND('-') THEN
                 Qualification := Requirments.Description; */
                
                
                if HRQualifications.Get("Qualification Type","Qualification Code") then
                "Qualification Description":=HRQualifications.Description;

            end;
        }
        field(16;"Qualification Description";Text[100])
        {
        }
        field(50000;"Course of Study";Text[70])
        {
        }
    }

    keys
    {
        key(Key1;"Employee No.","Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Comment then
          Error(Text000);
    end;

    trigger OnInsert()
    begin
        Employee.Get("Employee No.");
        "Employee Status" := Employee.Status;
    end;

    var
        Text000: label 'You cannot delete employee qualification information if there are comments associated with it.';
        HRLookupValues: Record "HR Lookup Values";
        Employee: Record "HR Employees";
        HRQualifications: Record "HR Job Qualifications";
}

