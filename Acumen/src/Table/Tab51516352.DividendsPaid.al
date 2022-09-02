#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516352 "Dividends Paid"
{

    fields
    {
        field(1;"Member No";Code[50])
        {
        }
        field(2;"Dividend year";Code[50])
        {
        }
        field(3;Amount;Decimal)
        {
        }
        field(4;"Member Name";Code[250])
        {
        }
        field(5;Message;Text[250])
        {
        }
        field(6;"Message Sent";Boolean)
        {
        }
        field(7;"Account No.";Code[70])
        {
        }
    }

    keys
    {
        key(Key1;"Member No","Dividend year")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

