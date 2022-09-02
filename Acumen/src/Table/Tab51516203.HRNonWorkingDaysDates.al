#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516203 "HR Non Working Days & Dates"
{

    fields
    {
        field(1;"Non Working Days";Code[10])
        {
        }
        field(2;"Non Working Dates";Date)
        {
        }
        field(3;"Code";Integer)
        {
            AutoIncrement = true;
        }
        field(4;Reason;Text[30])
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

