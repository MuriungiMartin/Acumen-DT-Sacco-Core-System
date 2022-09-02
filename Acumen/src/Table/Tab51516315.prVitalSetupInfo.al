#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516315 "prVital Setup Info."
{

    fields
    {
        field(1;"Setup Code";Code[10])
        {
            Description = '[Relief]';
        }
        field(2;"Tax Relief";Decimal)
        {
            Description = '[Relief]';
        }
        field(3;"Insurance Relief";Decimal)
        {
            Description = '[Relief]';
        }
        field(4;"Max Relief";Decimal)
        {
            Description = '[Relief]';
        }
        field(5;"Mortgage Relief";Decimal)
        {
            Description = '[Relief]';
        }
        field(6;"Max Pension Contribution";Decimal)
        {
            Description = '[Pension]';
        }
        field(7;"Tax On Excess Pension";Decimal)
        {
            Description = '[Pension]';
        }
        field(8;"Loan Market Rate";Decimal)
        {
            Description = '[Loans]';
        }
        field(9;"Loan Corporate Rate";Decimal)
        {
            Description = '[Loans]';
        }
        field(10;"Taxable Pay (Normal)";Decimal)
        {
            Description = '[Housing]';
        }
        field(11;"Taxable Pay (Agricultural)";Decimal)
        {
            Description = '[Housing]';
        }
        field(12;"NHIF Based on";Option)
        {
            Description = '[NHIF] - Gross,Basic,Taxable Pay';
            OptionMembers = Gross,Basic,"Taxable Pay";
        }
        field(13;"NSSF Employee";Decimal)
        {
            Description = '[NSSF]';
        }
        field(14;"NSSF Employer Factor";Decimal)
        {
            Description = '[NSSF]';
        }
        field(15;"OOI Deduction";Decimal)
        {
            Description = '[OOI]';
        }
        field(16;"OOI December";Decimal)
        {
            Description = '[OOI]';
        }
        field(17;"Security Day (U)";Decimal)
        {
            Description = '[Servant]';
        }
        field(18;"Security Night (U)";Decimal)
        {
            Description = '[Servant]';
        }
        field(19;"Ayah (U)";Decimal)
        {
            Description = '[Servant]';
        }
        field(20;"Gardener (U)";Decimal)
        {
            Description = '[Servant]';
        }
        field(21;"Security Day (R)";Decimal)
        {
            Description = '[Servant]';
        }
        field(22;"Security Night (R)";Decimal)
        {
            Description = '[Servant]';
        }
        field(23;"Ayah (R)";Decimal)
        {
            Description = '[Servant]';
        }
        field(24;"Gardener (R)";Decimal)
        {
            Description = '[Servant]';
        }
        field(25;"Benefit Threshold";Decimal)
        {
            Description = '[Servant]';
        }
        field(26;"NSSF Based on";Option)
        {
            Description = '[NSSF] - Gross,Basic,Taxable Pay';
            OptionMembers = Gross,Basic,"Taxable Pay";
        }
    }

    keys
    {
        key(Key1;"Setup Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

