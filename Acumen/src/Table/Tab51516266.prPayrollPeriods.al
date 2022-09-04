#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516266 "prPayroll Periods"
{

    fields
    {
        field(1;"Period Month";Integer)
        {
        }
        field(2;"Period Year";Integer)
        {
        }
        field(3;"Period Name";Text[30])
        {
            Description = 'e.g November 2009';
        }
        field(4;"Date Opened";Date)
        {
            NotBlank = true;
        }
        field(5;"Date Closed";Date)
        {
        }
        field(6;Closed;Boolean)
        {
            Description = 'A period is either closed or open';
        }
        field(7;"Payroll Code";Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(8;"Tax Paid";Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where ("Payroll Period"=field("Date Opened"),
                                                                    "Group Order"=const(7),
                                                                    "Sub Group Order"=const(3)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Date Opened")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

