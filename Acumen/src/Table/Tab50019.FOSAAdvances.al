#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50019 "FOSA Advances"
{

    fields
    {
        field(1;"FOSA Account No";Code[20])
        {
        }
        field(2;"Member No";Code[20])
        {
        }
        field(3;Name;Code[80])
        {
        }
        field(4;"ID No";Code[30])
        {
        }
    }

    keys
    {
        key(Key1;"FOSA Account No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

