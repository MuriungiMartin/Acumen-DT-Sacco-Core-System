#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516535 "S-Mobile Tarrifs"
{

    fields
    {
        field(1;"Code";Code[30])
        {
        }
        field(2;Minimum;Decimal)
        {
        }
        field(3;Maximum;Decimal)
        {
        }
        field(4;"Charge Amount";Decimal)
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
    }
}

