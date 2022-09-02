#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50020 "Missing Accounts Buffer"
{

    fields
    {
        field(1;"Member No";Code[20])
        {
        }
        field(2;"Member Name";Code[80])
        {
        }
        field(3;"Entry No";Integer)
        {
        }
    }

    keys
    {
        key(Key1;"Member No","Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

