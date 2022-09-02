#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516479 "Bank Stmt Import Buffer"
{

    fields
    {
        field(10;LineNo;Integer)
        {
        }
        field(11;Date;Date)
        {
        }
        field(12;Description;Text[250])
        {
        }
        field(13;"Debit Amount";Decimal)
        {
        }
        field(14;"Credit Amount";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;LineNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

