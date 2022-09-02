#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50024 "Bosa Account Dummy"
{

    fields
    {
        field(10;number;Code[50])
        {
        }
        field(11;"Bosa Number";Code[50])
        {
        }
    }

    keys
    {
        key(Key1;number)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

