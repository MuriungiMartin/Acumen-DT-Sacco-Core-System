#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516502 "Inward file Buffer"
{

    fields
    {
        field(1;"Account No";Code[20])
        {
        }
        field(2;"Serial No";Code[20])
        {
        }
        field(3;"Sort Code";Code[20])
        {
        }
        field(4;Amount;Decimal)
        {
        }
        field(5;"Voucher Type";Code[20])
        {
        }
        field(6;"Posting Date";Date)
        {
        }
        field(7;"Processing Date";Date)
        {
        }
        field(8;Indicator;Code[20])
        {
        }
        field(9;"Unpaid Reason";Code[10])
        {
        }
        field(10;"Unpaid Code";Code[20])
        {
        }
        field(11;"Presenting Bank";Code[20])
        {
        }
        field(12;"Currency Code";Code[20])
        {
        }
        field(13;Session;Code[20])
        {
        }
        field(14;"Bank No";Code[20])
        {
        }
        field(15;"Branch No";Code[20])
        {
        }
        field(16;"Sacco AccountNo";Code[20])
        {
        }
        field(22;CurrentUserID;Code[100])
        {
        }
        field(23;Primary;Integer)
        {
        }
        field(24;"Transaction Code";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Sort Code","Serial No","Account No")
        {
            Clustered = true;
        }
        key(Key2;"Account No")
        {
        }
    }

    fieldgroups
    {
    }
}

