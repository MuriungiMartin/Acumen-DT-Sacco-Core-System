#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516336 "prUnused Relief"
{

    fields
    {
        field(1;"Employee Code";Code[20])
        {
        }
        field(2;"Unused Relief";Decimal)
        {
        }
        field(3;"Period Month";Integer)
        {
        }
        field(4;"Period Year";Integer)
        {
        }
    }

    keys
    {
        key(Key1;"Employee Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

