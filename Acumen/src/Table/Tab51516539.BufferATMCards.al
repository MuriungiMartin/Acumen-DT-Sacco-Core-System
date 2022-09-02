#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516539 "Buffer ATM Cards"
{

    fields
    {
        field(10;Number;Code[30])
        {
        }
        field(11;"ATM No";Code[30])
        {
        }
        field(12;"Phone No";Code[30])
        {
        }
    }

    keys
    {
        key(Key1;Number)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

