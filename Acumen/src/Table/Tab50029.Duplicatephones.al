#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50029 "Duplicate phones"
{

    fields
    {
        field(1;"Vendor No";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Phone Number";Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Vendor No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

