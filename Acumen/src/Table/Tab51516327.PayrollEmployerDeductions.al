#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516327 "Payroll Employer Deductions."
{

    fields
    {
        field(10;"Employee Code";Code[20])
        {
        }
        field(11;"Transaction Code";Code[20])
        {
        }
        field(12;Amount;Decimal)
        {
        }
        field(13;"Period Month";Integer)
        {
        }
        field(14;"Period Year";Integer)
        {
        }
        field(15;"Payroll Period";Date)
        {
            TableRelation = "HR Job Qualifications".Field10;
        }
        field(16;"Payroll Code";Code[20])
        {
        }
        field(17;"Amount(LCY)";Decimal)
        {
        }
        field(18;Group;Integer)
        {
        }
        field(19;SubGroup;Integer)
        {
        }
        field(20;"Transaction Type";Code[20])
        {
        }
        field(21;Description;Text[50])
        {
        }
        field(22;Balance;Decimal)
        {
        }
        field(23;"Balance(LCY)";Decimal)
        {
        }
        field(24;"Membership No";Code[20])
        {
        }
        field(25;"Reference No";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Employee Code","Transaction Code","Period Month","Period Year")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

