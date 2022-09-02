#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516349 "Hexa Binary"
{

    fields
    {
        field(1;Hexadecimal;Code[1])
        {
            Editable = true;
        }
        field(2;Binary;Code[4])
        {
            Editable = true;
        }
    }

    keys
    {
        key(Key1;Hexadecimal)
        {
            Clustered = true;
        }
        key(Key2;Binary)
        {
        }
    }

    fieldgroups
    {
    }
}

