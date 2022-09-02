#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516326 "Payroll Employee Deductions."
{

    fields
    {
        field(10;"Employee Code";Code[10])
        {
        }
        field(11;"Transaction Code";Code[10])
        {
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

