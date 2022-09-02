#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516533 "E-Loan Salary Buffer"
{

    fields
    {
        field(1;"Account No";Code[20])
        {
        }
        field(2;"Account Name";Code[50])
        {
        }
        field(3;"Salary Processing Date";Date)
        {
        }
        field(4;Amount;Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Salary Processing Date","Account No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

