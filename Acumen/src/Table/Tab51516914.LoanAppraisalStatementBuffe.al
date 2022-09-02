#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516914 "Loan Appraisal Statement Buffe"
{

    fields
    {
        field(1;"Loan No";Code[20])
        {
        }
        field(2;"Transaction Date";Date)
        {
        }
        field(3;"Transaction Description";Text[50])
        {
        }
        field(4;"Amount Out";Decimal)
        {
        }
        field(5;"Amount In";Decimal)
        {
        }
        field(6;Amount;Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Loan No","Transaction Date","Transaction Description",Amount)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

