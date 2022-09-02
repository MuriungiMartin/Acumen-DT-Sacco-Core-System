#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516419 "Data Periods"
{

    fields
    {
        field(1;"Period Code";Code[10])
        {
        }
        field(2;"Begin Date";Date)
        {
        }
        field(3;"End Date";Date)
        {
        }
        field(4;Month;Code[20])
        {
        }
        field(5;"Payroll Month";Code[10])
        {
        }
    }

    keys
    {
        key(Key1;"Period Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

