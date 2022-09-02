#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50011 "M-PESA Chargesx"
{

    fields
    {
        field(1;"Min Amount";Decimal)
        {
        }
        field(2;"Max Amount";Decimal)
        {
        }
        field(3;"Transfer to Other M-PESA User";Decimal)
        {
        }
        field(4;"Transfer to Unregistered User";Decimal)
        {
        }
        field(5;"Withdrawal From M-PESA Agent";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Min Amount")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

