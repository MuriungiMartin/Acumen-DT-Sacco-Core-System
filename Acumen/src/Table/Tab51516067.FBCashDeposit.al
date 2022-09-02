#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516067 "FB Cash Deposit"
{

    fields
    {
        field(1;"Transaction No";Code[50])
        {
        }
        field(2;Status;Code[10])
        {
        }
        field(3;Reference;Code[50])
        {
        }
        field(4;"Account No";Code[50])
        {
        }
        field(5;Amount;Decimal)
        {
        }
        field(6;"Date Received";Date)
        {
        }
        field(7;"Inst Account";Code[100])
        {
        }
        field(8;Msisdn;Code[20])
        {
        }
        field(9;Narration;Text[100])
        {
        }
        field(10;"Inst Name";Text[100])
        {
        }
        field(11;"Flex Trans Serial No";Code[50])
        {
        }
        field(12;"Fetch Date";Date)
        {
        }
        field(13;Channel;Code[10])
        {
        }
        field(14;Posted;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Transaction No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

