#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516503 "Refference Number"
{

    fields
    {
        field(1;CurrUserID;Code[50])
        {
        }
        field(2;"Reference No";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;CurrUserID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

