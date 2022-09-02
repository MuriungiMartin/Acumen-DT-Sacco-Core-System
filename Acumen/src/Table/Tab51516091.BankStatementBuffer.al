#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516091 "Bank Statement Buffer"
{

    fields
    {
        field(10;LineNo;Integer)
        {
        }
        field(11;"Ref No";Code[50])
        {
        }
        field(12;Description;Text[250])
        {
        }
        field(13;Bank;Code[20])
        {
        }
        field(14;Amount;Decimal)
        {
        }
        field(15;Date;Date)
        {
        }
    }

    keys
    {
        key(Key1;"Ref No",LineNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

