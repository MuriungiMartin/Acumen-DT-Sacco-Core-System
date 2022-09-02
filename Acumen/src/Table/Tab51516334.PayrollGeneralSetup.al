#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516334 "Payroll General Setup."
{

    fields
    {
        field(10;"Primary Key";Code[10])
        {
        }
        field(11;"Tax Relief";Decimal)
        {
            Description = '[Relief]';
        }
        field(12;"Insurance Relief";Decimal)
        {
            Description = '[Relief]';
        }
        field(13;"Max Relief";Decimal)
        {
            Description = '[Relief]';
        }
        field(14;"Mortgage Relief";Decimal)
        {
            Description = '[Relief]';
        }
        field(15;"Max Pension Contribution";Decimal)
        {
            Description = '[Pension]';
        }
        field(16;"Tax On Excess Pension";Decimal)
        {
            Description = '[Pension]';
        }
        field(17;"Loan Market Rate";Decimal)
        {
            Description = '[Loans]';
        }
        field(18;"Loan Corporate Rate";Decimal)
        {
            Description = '[Loans]';
        }
        field(19;"Taxable Pay (Normal)";Decimal)
        {
            Description = '[Housing]';
        }
        field(20;"Taxable Pay (Agricultural)";Decimal)
        {
            Description = '[Housing]';
        }
        field(21;"NHIF Based on";Option)
        {
            Description = '[NHIF] - Gross,Basic,Taxable Pay';
            OptionMembers = Gross,Basic,"Taxable Pay";
        }
        field(22;"NSSF Employee";Decimal)
        {
            Description = '[NSSF]';
        }
        field(23;"NSSF Employer Factor";Decimal)
        {
            Description = '[NSSF]';
        }
        field(24;"OOI Deduction";Decimal)
        {
            Description = '[OOI]';
        }
        field(25;"OOI December";Decimal)
        {
            Description = '[OOI]';
        }
        field(26;"Security Day (U)";Decimal)
        {
            Description = '[Servant]';
        }
        field(27;"Security Night (U)";Decimal)
        {
            Description = '[Servant]';
        }
        field(28;"Ayah (U)";Decimal)
        {
            Description = '[Servant]';
        }
        field(29;"Gardener (U)";Decimal)
        {
            Description = '[Servant]';
        }
        field(30;"Security Day (R)";Decimal)
        {
            Description = '[Servant]';
        }
        field(31;"Security Night (R)";Decimal)
        {
            Description = '[Servant]';
        }
        field(32;"Ayah (R)";Decimal)
        {
            Description = '[Servant]';
        }
        field(33;"Gardener (R)";Decimal)
        {
            Description = '[Servant]';
        }
        field(34;"Benefit Threshold";Decimal)
        {
            Description = '[Servant]';
        }
        field(35;"NSSF Based on";Option)
        {
            Description = '[NSSF] - Gross,Basic,Taxable Pay';
            OptionMembers = Gross,Basic,"Taxable Pay";
        }
        field(36;"Rounding Precision";Decimal)
        {
        }
        field(37;"Earnings No";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(38;"Deductions No";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(39;"Currency Exchange Date";Date)
        {
        }
        field(40;BasedOnTimesheet;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

