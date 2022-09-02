#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516322 "Payroll Calender."
{

    fields
    {
        field(10;"Date Opened";Date)
        {
        }
        field(11;"Date Closed";Date)
        {
        }
        field(12;"Period Name";Text[50])
        {
        }
        field(13;"Period Month";Integer)
        {
        }
        field(14;"Period Year";Integer)
        {
        }
        field(15;"Payroll Code";Code[50])
        {
        }
        field(16;"Tax Paid";Decimal)
        {
        }
        field(17;"Tax Paid(LCY)";Decimal)
        {
        }
        field(18;"Basic Pay Paid";Decimal)
        {
        }
        field(19;"Basic Pay Paid(LCY)";Decimal)
        {
        }
        field(20;Closed;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Date Opened","Period Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

