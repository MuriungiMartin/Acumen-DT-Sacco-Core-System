#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516408 "Office/Group"
{

    fields
    {
        field(1;"Office/Unit ID";Code[10])
        {
        }
        field(2;Description;Text[30])
        {
        }
        field(3;Blocked;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Office/Unit ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

