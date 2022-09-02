#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50003 "Fixed Deposit Control"
{

    fields
    {
        field(1;"Member No";Code[20])
        {
        }
        field(2;"FD Start Date";Date)
        {
        }
        field(3;"FD Amount";Decimal)
        {
        }
        field(4;"FD Duration";DateFormula)
        {
        }
        field(5;"FD Interest Rate";Decimal)
        {
        }
        field(6;"FD Maturity Date";Date)
        {
        }
        field(7;"FD Interest on Maturity";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Member No")
        {
            Clustered = true;
        }
        key(Key2;"FD Start Date")
        {
        }
        key(Key3;"FD Amount")
        {
        }
        key(Key4;"FD Interest Rate")
        {
        }
    }

    fieldgroups
    {
    }
}

