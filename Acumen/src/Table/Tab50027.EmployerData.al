#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50027 "Employer Data"
{

    fields
    {
        field(1;MemberNo;Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Employer Code";Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;MemberNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

