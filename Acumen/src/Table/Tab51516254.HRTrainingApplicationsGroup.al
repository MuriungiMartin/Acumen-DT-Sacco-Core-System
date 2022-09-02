#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516254 "HR Training Applications Group"
{

    fields
    {
        field(1;"Training No.";Code[30])
        {
        }
        field(2;"Training Group Name";Text[250])
        {
        }
    }

    keys
    {
        key(Key1;"Training No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

