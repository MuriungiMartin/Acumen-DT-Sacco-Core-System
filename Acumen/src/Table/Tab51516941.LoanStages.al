#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516941 "Loan Stages"
{
    DrillDownPageID = "Loan Stages";
    LookupPageID = "Loan Stages";

    fields
    {
        field(1;"Loan Stage";Code[20])
        {
        }
        field(2;"Loan Stage Description";Text[50])
        {
        }
    }

    keys
    {
        key(Key1;"Loan Stage")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

