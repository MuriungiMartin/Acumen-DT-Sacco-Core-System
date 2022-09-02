#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516342 "prEmployer Deductions."
{

    fields
    {
        field(1;"Employee Code";Code[20])
        {
        }
        field(2;"Transaction Code";Code[20])
        {
        }
        field(3;Amount;Decimal)
        {
        }
        field(4;"Period Month";Integer)
        {
        }
        field(5;"Period Year";Integer)
        {
        }
        field(6;"Payroll Period";Date)
        {
            TableRelation = Table39003990.Field4;
        }
        field(7;"Payroll Code";Code[20])
        {
            TableRelation = Table39004012;
        }
    }

    keys
    {
        key(Key1;"Employee Code","Transaction Code","Period Month","Period Year","Payroll Period")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }
}

