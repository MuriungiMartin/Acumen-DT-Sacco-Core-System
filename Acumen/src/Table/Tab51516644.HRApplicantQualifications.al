#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516644 "HR Applicant Qualifications"
{
    Caption = 'HR Applicant Qualifications';
    DataCaptionFields = "Employee No.";
    // DrillDownPageID = UnknownPage53960;
    // LookupPageID = UnknownPage53960;

    fields
    {
        field(1; "Application No"; Code[10])
        {
            Caption = 'Application No';
            TableRelation = "HR Job Applications"."Application No";
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
        }
        field(3; "Qualification Description"; Code[80])
        {
            Caption = 'Qualification Description';
            NotBlank = true;

            trigger OnValidate()
            begin
                /*
                Qualifications.RESET;
                Qualifications.SETRANGE(Qualifications.Code,"Qualification Description");
                IF Qualifications.FIND('-') THEN
                "Qualification Code":=Qualifications.Description;
                */

            end;
        }
        field(4; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(5; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Internal,External,Previous Position';
            OptionMembers = " ",Internal,External,"Previous Position";
        }
        field(7; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(8; "Institution/Company"; Text[30])
        {
            Caption = 'Institution/Company';
        }
        field(9; Cost; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost';
        }
        field(10; "Course Grade"; Text[30])
        {
            Caption = 'Course Grade';
        }
        field(11; "Employee Status"; Option)
        {
            Caption = 'Employee Status';
            Editable = false;
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
        }
        field(13; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(14; "Qualification Type"; Code[20])
        {
            NotBlank = false;
            TableRelation = "HR Lookup Values".Code where(Type = filter("Qualification Type"));
        }
        field(15; "Qualification Code"; Text[200])
        {
            NotBlank = true;
            TableRelation = "HR Job Qualifications".Code where("Qualification Type" = field("Qualification Type"));

            trigger OnValidate()
            begin
                if HRQualifications.Get("Qualification Type", "Qualification Code") then
                    "Qualification Description" := HRQualifications.Description;
            end;
        }
        field(16; "Score ID"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Application No", "Qualification Type", "Qualification Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HRQualifications: Record "HR Job Qualifications";
        Applicant: Record "HR Job Applications";
        Position: Code[20];
        JobReq: Record "HR Job Responsiblities";
}

