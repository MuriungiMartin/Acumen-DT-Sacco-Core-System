#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516347 "ISO-Defined Data Elements"
{

    fields
    {
        field(1;"Data Element";Integer)
        {
            AutoIncrement = true;
            Editable = true;
        }
        field(2;Type;Text[50])
        {
            Editable = true;
        }
        field(3;Usage;Text[250])
        {
            Editable = true;
        }
        field(4;Length;Integer)
        {
            Editable = true;
        }
        field(5;"Variable Field";Integer)
        {
            Editable = true;
        }
        field(6;"Variable Field Length";Integer)
        {
            Editable = true;
        }
    }

    keys
    {
        key(Key1;"Data Element")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

