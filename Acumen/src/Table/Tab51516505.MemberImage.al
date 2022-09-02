#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516505 "Member Image"
{

    fields
    {
        field(1;"Member No";Code[20])
        {
        }
        field(2;Picture;Blob)
        {
        }
        field(3;Signature;Blob)
        {
        }
    }

    keys
    {
        key(Key1;"Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

