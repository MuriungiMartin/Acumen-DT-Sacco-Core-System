#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50030 "Member Colleges"
{

    fields
    {
        field(1;mno;Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"code";Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;mno)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

