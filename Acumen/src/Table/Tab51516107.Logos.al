#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516107 "Logos"
{

    fields
    {
        field(1;"Code";Code[50])
        {
            TableRelation = "Dimension Value".Code where ("Dimension Code"=filter('FUND'));
        }
        field(29;Picture;Blob)
        {
            SubType = Bitmap;
        }
        field(30;Default;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

