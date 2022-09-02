#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516325 "Payroll Salary Arrears."
{

    fields
    {
        field(10;"Employee Code";Code[20])
        {
            TableRelation = "HR Job Occupations";
        }
        field(11;"Transaction Code";Code[20])
        {
        }
        field(12;"Start Date";Date)
        {
            Description = 'From when';
        }
        field(13;"End Date";Date)
        {
            Description = 'Upto when';
        }
        field(14;"Salary Arrears";Decimal)
        {
        }
        field(15;"Salary Arrears(LCY)";Decimal)
        {
        }
        field(16;"PAYE Arrears";Decimal)
        {
        }
        field(17;"PAYE Arrears(LCY)";Decimal)
        {
        }
        field(18;"Period Month";Integer)
        {
        }
        field(19;"Period Year";Integer)
        {
        }
        field(20;"Current Basic";Decimal)
        {
        }
        field(21;"Current Basic(LCY)";Decimal)
        {
        }
        field(22;"Payroll Period";Date)
        {
            TableRelation = "HR Job Qualifications".Field10;
        }
        field(23;Number;Integer)
        {
            AutoIncrement = true;
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1;"Employee Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

