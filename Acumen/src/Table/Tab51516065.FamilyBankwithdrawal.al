#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516065 "Family Bank withdrawal"
{

    fields
    {
        field(1;Id;Integer)
        {
        }
        field(2;"Message Type";Text[100])
        {
        }
        field(3;Mobile;Code[30])
        {
        }
        field(4;Amount;Decimal)
        {
        }
        field(5;Reference;Code[50])
        {
        }
        field(6;"Request Date";Date)
        {
        }
        field(7;"Response Code";Code[50])
        {
        }
        field(8;Status;Code[50])
        {
        }
    }

    keys
    {
        key(Key1;Id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

