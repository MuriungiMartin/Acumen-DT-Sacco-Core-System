#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516185 "HR Job Qualifications"
{
    Caption = 'HR Qualifications';
    DataCaptionFields = "Code",Description;
    DrillDownPageID = "HR Job Qualifications";
    LookupPageID = "HR Job Qualifications";

    fields
    {
        field(1;"Qualification Type";Code[50])
        {
            TableRelation = "HR Lookup Values".Code where (Type=const("Qualification Type"));
        }
        field(2;"Code";Code[10])
        {
            Caption = 'Code';
        }
        field(6;Description;Text[100])
        {
            Caption = 'Description';
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1;"Qualification Type","Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

