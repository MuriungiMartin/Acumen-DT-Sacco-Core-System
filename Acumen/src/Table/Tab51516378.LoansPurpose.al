#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516378 "Loans Purpose"
{
    DrillDownPageID = "Loans Purpose";
    LookupPageID = "Loans Purpose";

    fields
    {
        field(1;"Code";Code[20])
        {
        }
        field(2;Description;Text[100])
        {
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Code",Description)
        {
        }
    }
}

