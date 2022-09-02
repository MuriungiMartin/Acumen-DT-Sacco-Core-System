#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516493 "SMS Setup"
{

    fields
    {
        field(1;"Code";Code[10])
        {
            NotBlank = true;
        }
        field(2;"Receiving Port";Decimal)
        {
        }
        field(3;"Sending Port";Decimal)
        {
        }
        field(4;"Help Message";Text[30])
        {
        }
        field(5;"Polling Interval";Text[30])
        {
        }
        field(6;"PostFix Message";Text[50])
        {
        }
        field(7;"Last Message No";BigInteger)
        {
        }
        field(8;"Service Center No";Text[30])
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

