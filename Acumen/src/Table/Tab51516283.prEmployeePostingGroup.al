#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516283 "prEmployee Posting Group"
{
    DataCaptionFields = "Code",Description;
    DrillDownPageID = UnknownPage51516329;
    LookupPageID = UnknownPage51516329;

    fields
    {
        field(1;"Code";Code[50])
        {
            NotBlank = true;
        }
        field(2;Description;Text[50])
        {
        }
        field(3;"Salary Account";Code[100])
        {
            TableRelation = "G/L Account";
        }
        field(4;"Income Tax Account";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(5;"NSSF Employer Account";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(6;"NSSF Employee Account";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(7;"Net Salary Payable";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(8;"Operating Overtime";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(9;"Tax Relief";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(10;"Employee Provident Fund Acc.";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(11;"Pay Period Filter";Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "G/L Account";
        }
        field(12;"Pension Employer Acc";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(13;"Pension Employee Acc";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(14;"Earnings and deductions";Code[50])
        {
        }
        field(15;"Staff Benevolent";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(16;SalaryExpenseAC;Code[100])
        {
            TableRelation = "G/L Account";
        }
        field(17;DirectorsFeeGL;Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(18;StaffGratuity;Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(19;"NHIF Employee Account";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(20;"Payroll Code";Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(21;"Pension Payable Acc";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(22;"NSSF Payable Acc";Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(23;"NHIF Payable Acc";Code[50])
        {
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
        key(Key2;"Earnings and deductions")
        {
        }
    }

    fieldgroups
    {
    }
}

