#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516251 "HR Notice Board Info Setup"
{

    fields
    {
        field(1;"Notice Code";Code[30])
        {
        }
        field(2;"Notice Type";Text[50])
        {
        }
        field(3;"Group Email";Text[80])
        {
        }
        field(4;"Group Name";Text[80])
        {
        }
        field(5;"Entry No";Integer)
        {
            AutoFormatType = 1000;
            AutoIncrement = true;
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Entry No","Notice Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

