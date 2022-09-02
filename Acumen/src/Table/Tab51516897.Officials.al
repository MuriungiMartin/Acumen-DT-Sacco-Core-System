#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516897 "Officials"
{

    fields
    {
        field(1;No;Code[20])
        {
        }
        field(2;Name;Code[50])
        {
        }
        field(3;"ID No";Code[50])
        {
        }
        field(4;"Phone No";Code[50])
        {
        }
    }

    keys
    {
        key(Key1;No,Name,"Phone No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

