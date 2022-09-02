#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516528 "Cheque Book Register"
{
    DrillDownPageID = "Cheque Book Register SetUp";
    LookupPageID = "Cheque Book Register SetUp";

    fields
    {
        field(1;"Cheque No.";Code[30])
        {
        }
        field(2;Issued;Boolean)
        {
        }
        field(3;Cancelled;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Cheque No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

