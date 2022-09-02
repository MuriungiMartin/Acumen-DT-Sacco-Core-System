#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516368 "Member Departments"
{
    DrillDownPageID = "Member Departments List";
    LookupPageID = "Member Departments List";

    fields
    {
        field(1;"No.";Code[10])
        {
            NotBlank = true;
        }
        field(2;Department;Text[70])
        {
        }
    }

    keys
    {
        key(Key1;"No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

