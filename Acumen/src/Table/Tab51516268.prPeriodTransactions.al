#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516268 "prPeriod Transactions"
{
    // DrillDownPageID = UnknownPage51516339;
    // LookupPageID = UnknownPage51516339;

    fields
    {
        field(1;"Employee Code";Code[50])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(2;"Transaction Code";Text[30])
        {
            TableRelation = "prTransaction Codes"."Transaction Code";
        }
        field(3;"Group Text";Text[30])
        {
            Description = 'e.g Statutory, Deductions, Tax Calculation etc';
        }
        field(4;"Transaction Name";Text[200])
        {
        }
        field(5;Amount;Decimal)
        {
        }
        field(6;Balance;Decimal)
        {
        }
        field(7;"Original Amount";Decimal)
        {
        }
        field(8;"Group Order";Integer)
        {
        }
        field(9;"Sub Group Order";Integer)
        {
        }
        field(10;"Period Month";Integer)
        {
        }
        field(11;"Period Year";Integer)
        {
        }
        field(12;"Period Filter";Date)
        {
            FieldClass = FlowFilter;
        }
        field(13;"Payroll Period";Date)
        {
        }
        field(14;Membership;Code[50])
        {
        }
        field(15;"Reference No";Text[20])
        {
        }
        field(16;"Department Code";Code[20])
        {
        }
        field(17;Lumpsumitems;Boolean)
        {
        }
        field(18;TravelAllowance;Code[20])
        {
        }
        field(19;"GL Account";Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(20;"Company Deduction";Boolean)
        {
            Description = 'Dennis- Added to filter out the company deductions esp: the Pensions';
        }
        field(21;"Emp Amount";Decimal)
        {
            Description = 'Dennis- Added to take care of the balances that need a combiantion btwn employee and employer';
        }
        field(22;"Emp Balance";Decimal)
        {
            Description = 'Dennis- Added to take care of the balances that need a combiantion btwn employee and employer';
        }
        field(23;"Journal Account Code";Code[20])
        {
        }
        field(24;"Journal Account Type";Option)
        {
            OptionMembers = " ","G/L Account",Customer,Vendor;
        }
        field(25;"Post As";Option)
        {
            OptionMembers = " ",Debit,Credit;
        }
        field(26;"Loan Number";Code[10])
        {
        }
        field(27;"coop parameters";Option)
        {
            Description = 'to be able to report the different coop contributions -Dennis';
            OptionMembers = "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF,Overtime;
        }
        field(28;"Payroll Code";Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(29;"Payment Mode";Option)
        {
            Description = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = " ","Bank Transfer",Cheque,Cash,SACCO;
        }
        field(30;"Location/Division";Code[20])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(4));
        }
        field(31;Department;Code[20])
        {
            //TableRelation = Table50082.Field1;
        }
        field(32;"Cost Centre";Code[20])
        {
            TableRelation = "Dimension Value".Code where ("Dimension Code"=const('COSTCENTRE'));
        }
        field(33;"Salary Grade";Code[20])
        {
            TableRelation = "HR Salary Grades"."Salary Grade";
        }
        field(34;"Salary Notch";Code[20])
        {
            TableRelation = "HR Salary Notch"."Salary Notch" where ("Salary Grade"=field("Salary Grade"));
        }
        field(35;"Payslip Order";Integer)
        {
        }
        field(36;"No. Of Units";Decimal)
        {
        }
        field(37;"Employee Classification";Code[20])
        {
        }
        field(38;State;Code[20])
        {
            TableRelation = "Post Code";
        }
        field(39;"New Departmental Code";Code[20])
        {
        }
        field(40;grants;Code[20])
        {
            //TableRelation = Jobs."No.";
        }
        field(53900;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));
        }
        field(53901;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(51516000;"Total Statutories";Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where ("Employee Code"=field("Employee Code"),
                                                                    "Group Text"=const('STATUTORIES'),
                                                                    "Period Month"=field("Period Month"),
                                                                    "Period Year"=field("Period Year")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Employee Code","Transaction Code","Period Month","Period Year",Membership,"Reference No")
        {
            Clustered = true;
            SumIndexFields = Amount,"No. Of Units";
        }
        key(Key2;"Employee Code","Period Month","Period Year","Group Order","Sub Group Order","Payslip Order",Membership,"Reference No")
        {
            SumIndexFields = Amount,"No. Of Units";
        }
        key(Key3;"Group Order","Transaction Code","Period Month","Period Year",Membership,"Reference No","Department Code")
        {
            SumIndexFields = Amount,"No. Of Units";
        }
        key(Key4;Membership)
        {
        }
        key(Key5;"Transaction Code","Payroll Period",Membership,"Reference No")
        {
            SumIndexFields = Amount,"No. Of Units";
        }
        key(Key6;"Payroll Period","Group Order","Sub Group Order")
        {
            SumIndexFields = Amount,"No. Of Units";
        }
        key(Key7;"Employee Code","Department Code")
        {
            SumIndexFields = Amount,"No. Of Units";
        }
        key(Key8;"Transaction Code","Employee Code","Payroll Period","Location/Division",Department)
        {
            SumIndexFields = Amount,"No. Of Units";
        }
        key(Key9;"Payslip Order")
        {
        }
        key(Key10;"Transaction Code","Employee Code","Payroll Period","Reference No")
        {
        }
        key(Key11;Department)
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }
}

