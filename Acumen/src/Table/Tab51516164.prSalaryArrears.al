#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516164 "prSalary Arrears"
{

    fields
    {
        field(1;"Employee Code";Code[10])
        {
            TableRelation = Table55582;
        }
        field(2;"Transaction Code";Code[10])
        {
        }
        field(3;"Start Date";Date)
        {
            Description = 'From when do we back date';
        }
        field(4;"End Date";Date)
        {
            Description = 'Upto when do we back date';
        }
        field(5;"Salary Arrears";Decimal)
        {
        }
        field(6;"PAYE Arrears";Decimal)
        {
        }
        field(7;"Period Month";Integer)
        {
        }
        field(8;"Period Year";Integer)
        {
        }
        field(9;"Current Basic";Decimal)
        {
        }
        field(10;"Payroll Period";Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(11;Number;Integer)
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

