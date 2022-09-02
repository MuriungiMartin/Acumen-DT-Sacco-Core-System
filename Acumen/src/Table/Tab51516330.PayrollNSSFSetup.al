#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516330 "Payroll NSSF Setup."
{

    fields
    {
        field(10;"Tier Code";Code[10])
        {
        }
        field(11;Earnings;Decimal)
        {
        }
        field(12;"Pensionable Earnings";Decimal)
        {
        }
        field(13;"Tier 1 earnings";Decimal)
        {
        }
        field(14;"Tier 1 Employee Deduction";Decimal)
        {
        }
        field(15;"Tier 1 Employer Contribution";Decimal)
        {
        }
        field(16;"Tier 2 earnings";Decimal)
        {
        }
        field(17;"Tier 2 Employee Deduction";Decimal)
        {
        }
        field(18;"Tier 2 Employer Contribution";Decimal)
        {
        }
        field(19;"Lower Limit";Decimal)
        {
        }
        field(20;"Upper Limit";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Tier Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

