#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516163 "prPension Details"
{

    fields
    {
        field(1; "Employee Code"; Code[10])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(2; "Pension Number"; Code[50])
        {
            NotBlank = true;
        }
        field(3; Company; Text[100])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; "Deduct premium"; Boolean)
        {
        }
        field(6; balance; Decimal)
        {
        }
        field(7; lumpsumitems; Boolean)
        {
            Description = 'lump sum the values';
        }
        field(8; "Is Insurance policy"; Boolean)
        {
            Description = 'True if its an insurance policy';
        }
        field(9; "Transaction Code"; Code[10])
        {
            //  TableRelation = "Payroll Bank Branches.".Field1;
        }
        field(10; "Inception Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Pension Number", Company)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

