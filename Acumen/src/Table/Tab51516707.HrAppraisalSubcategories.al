#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516707 "Hr Appraisal Subcategories"
{
    DrillDownPageID = "SMS Charges";
    LookupPageID = "SMS Charges";

    fields
    {
        field(1;"Code";Code[70])
        {
        }
        field(2;Description;Text[150])
        {
        }
        field(3;"Line No";Integer)
        {
            AutoIncrement = true;
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
    }
}

