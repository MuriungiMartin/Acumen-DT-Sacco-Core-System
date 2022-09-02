#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516354 "Pictures"
{

    fields
    {
        field(1;No;Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Picture;Blob)
        {
            Compressed = false;
            DataClassification = ToBeClassified;
        }
        field(3;Signature;Blob)
        {
            Compressed = false;
            DataClassification = ToBeClassified;
            Enabled = true;
        }
    }

    keys
    {
        key(Key1;No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

