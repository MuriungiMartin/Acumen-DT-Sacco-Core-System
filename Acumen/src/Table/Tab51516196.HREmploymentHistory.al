#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516196 "HR Employment History"
{

    fields
    {
        field(1;"Employee No.";Code[20])
        {
            NotBlank = false;
            TableRelation = "HR Employees"."No.";
        }
        field(2;From;Date)
        {
            NotBlank = false;
        }
        field(3;"To Date";Date)
        {
            NotBlank = false;
        }
        field(4;"Company Name";Text[150])
        {
            NotBlank = false;
        }
        field(5;"Postal Address";Text[40])
        {
        }
        field(6;"Address 2";Text[40])
        {
        }
        field(7;"Job Title";Text[150])
        {
        }
        field(8;"Key Experience";Text[150])
        {
        }
        field(9;"Salary On Leaving";Decimal)
        {
        }
        field(10;"Reason For Leaving";Text[150])
        {
        }
        field(16;Comment;Text[200])
        {
            Editable = true;
            FieldClass = Normal;
        }
    }

    keys
    {
        key(Key1;"Employee No.","Company Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "HR Employees";
        OK: Boolean;
}

