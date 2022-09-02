#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516534 "Buffer 2016"
{

    fields
    {
        field(1;"Entry No";Integer)
        {
        }
        field(2;"Budget name";Code[10])
        {
        }
        field(3;Date;Date)
        {
        }
        field(4;"G/L Account";Code[20])
        {
        }
        field(5;Amount;Decimal)
        {
        }
        field(6;Description;Text[80])
        {
        }
    }

    keys
    {
        key(Key1;"Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

