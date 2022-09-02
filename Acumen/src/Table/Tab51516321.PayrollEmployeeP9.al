#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516321 "Payroll Employee P9."
{

    fields
    {
        field(10;"Employee Code";Code[20])
        {
            TableRelation = "HR Job Occupations";
        }
        field(11;"Basic Pay";Decimal)
        {
        }
        field(12;Allowances;Decimal)
        {
        }
        field(13;Benefits;Decimal)
        {
        }
        field(14;"Value Of Quarters";Decimal)
        {
        }
        field(15;"Defined Contribution";Decimal)
        {
        }
        field(16;"Owner Occupier Interest";Decimal)
        {
        }
        field(17;"Gross Pay";Decimal)
        {
        }
        field(18;"Taxable Pay";Decimal)
        {
        }
        field(19;"Tax Charged";Decimal)
        {
        }
        field(20;"Insurance Relief";Decimal)
        {
        }
        field(21;"Tax Relief";Decimal)
        {
        }
        field(22;PAYE;Decimal)
        {
        }
        field(23;NSSF;Decimal)
        {
        }
        field(24;NHIF;Decimal)
        {
        }
        field(25;Deductions;Decimal)
        {
        }
        field(26;"Net Pay";Decimal)
        {
        }
        field(27;"Period Month";Integer)
        {
        }
        field(28;"Period Year";Integer)
        {
        }
        field(29;"Payroll Period";Date)
        {
            TableRelation = "HR Job Qualifications".Field10;
        }
        field(30;"Period Filter";Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "HR Job Qualifications".Field10;
        }
        field(31;Pension;Decimal)
        {
        }
        field(32;HELB;Decimal)
        {
        }
        field(33;"Payroll Code";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Employee Code","Payroll Period")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

