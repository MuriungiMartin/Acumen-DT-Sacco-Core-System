#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516409 "Value Posting"
{

    fields
    {
        field(1;UserID;Code[60])
        {
            TableRelation = User;
        }
        field(2;"Value Posting";Integer)
        {
        }
    }

    keys
    {
        key(Key1;UserID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

