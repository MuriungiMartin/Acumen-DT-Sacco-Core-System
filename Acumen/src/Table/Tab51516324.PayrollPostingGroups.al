#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516324 "Payroll Posting Groups."
{

    fields
    {
        field(10;"Posting Code";Code[10])
        {
        }
        field(11;Description;Text[50])
        {
        }
        field(12;"Salary Account";Code[100])
        {
            TableRelation = "G/L Account";
        }
        field(13;"Income Tax Account";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(14;"SSF Employer Account";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(15;"SSF Employee Account";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(16;"Net Salary Payable";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(17;"Operating Overtime";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(18;"Tax Relief";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(19;"Employee Provident Fund Acc.";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(20;"Pay Period Filter";Date)
        {
            FieldClass = FlowFilter;
        }
        field(21;"Pension Employer Acc";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(22;"Pension Employee Acc";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(23;"Earnings and deductions";Code[50])
        {
        }
        field(24;"Staff Benevolent";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(25;SalaryExpenseAC;Code[100])
        {
            TableRelation = "G/L Account";
        }
        field(26;"Directors Fee GL";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(27;"Staff Gratuity";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(28;"NHIF Employee Account";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(29;"Payroll Code";Code[20])
        {
        }
        field(30;"Upload to Payroll";Boolean)
        {
        }
        field(31;"PAYE Benefit A/C";Code[20])
        {
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1;"Posting Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

