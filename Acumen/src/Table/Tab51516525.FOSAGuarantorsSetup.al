#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516525 "FOSA Guarantors Setup"
{

    fields
    {
        field(1;"Minimum Amount";Decimal)
        {
        }
        field(2;"Maximum Amount";Decimal)
        {
        }
        field(3;"No of Guarantors";Integer)
        {
        }
    }

    keys
    {
        key(Key1;"Minimum Amount")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

