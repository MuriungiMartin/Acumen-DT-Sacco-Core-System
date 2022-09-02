#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50015 "Member Images 2"
{

    fields
    {
        field(10;No;Code[20])
        {
        }
        field(11;Images;Blob)
        {
            SubType = Bitmap;
        }
        field(12;Sig;Blob)
        {
            SubType = Bitmap;
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

