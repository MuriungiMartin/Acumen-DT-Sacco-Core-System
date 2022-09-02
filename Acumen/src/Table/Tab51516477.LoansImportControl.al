#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516477 "Loans Import Control"
{

    fields
    {
        field(1;"FOSA Account No";Code[30])
        {
        }
        field(2;"FOSA No Images";Code[100])
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

