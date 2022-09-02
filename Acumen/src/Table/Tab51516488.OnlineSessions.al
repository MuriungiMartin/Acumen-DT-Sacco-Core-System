#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516488 "Online Sessions"
{

    fields
    {
        field(1;"User Name";Code[50])
        {
            Editable = false;
            TableRelation = "Online Users"."User Name";
        }
        field(2;"Session ID";Text[100])
        {
            Editable = false;
        }
        field(3;"Login Time";DateTime)
        {
            Editable = false;
        }
        field(4;"Logout Time";DateTime)
        {
            Editable = false;
        }
        field(5;"Login Duration";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Session ID","User Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

