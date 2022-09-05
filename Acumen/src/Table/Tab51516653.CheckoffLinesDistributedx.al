#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516653 "Checkoff Lines-Distributedx"
{

    fields
    {
        field(1; "Checkoff No"; Code[40])
        {
        }
        field(2; "Total Amount"; Decimal)
        {
        }
        field(3; "No Repayment"; Boolean)
        {
        }
        field(4; "Staff Not Found"; Boolean)
        {
        }
        field(5; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(6; "Car Loan"; Decimal)
        {
        }
        field(7; Development; Decimal)
        {
        }
        field(8; Sambamba; Decimal)
        {
        }
        field(9; Emergency; Decimal)
        {
        }
        field(10; "School Fees"; Decimal)
        {
        }
        field(11; Benevolent; Decimal)
        {
        }
        field(12; "Deposit Contribution"; Decimal)
        {
        }
        field(13; Defaulter; Decimal)
        {
        }
        field(14; "Account Not Found"; Boolean)
        {
        }
        field(15; "Okoa Jahazi"; Decimal)
        {
        }
        field(16; "Account Name"; Code[30])
        {
        }
        field(17; "Account No."; Code[10])
        {
        }
        field(18; "Vuka Special"; Decimal)
        {
        }
        field(19; "40 Years"; Decimal)
        {
        }
        field(20; "Staff/Payroll No"; Code[20])
        {
        }
        field(21; "Employee Name"; Code[20])
        {
        }
        field(22; TOTAL_DISTRIBUTED; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Checkoff No", "Staff/Payroll No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
}

