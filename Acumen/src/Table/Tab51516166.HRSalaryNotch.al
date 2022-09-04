#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516166 "HR Salary Notch"
{
    // DrillDownPageID = UnknownPage55533;
    // LookupPageID = UnknownPage55533;

    fields
    {
        field(1; "Salary Grade"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Salary Grades"."Salary Grade";
        }
        field(2; "Salary Notch"; Code[20])
        {
            NotBlank = true;
        }
        field(3; Description; Text[100])
        {
        }
        field(4; "Salary Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                "Annual Salary Amount" := "Salary Amount" * 12;
            end;
        }
        field(5; "Hourly Rate"; Decimal)
        {
        }
        field(6; "Annual Salary Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Annual Salary Amount" > 0 then
                    "Salary Amount" := "Annual Salary Amount" / 12;
            end;
        }
    }

    keys
    {
        key(Key1; "Salary Grade", "Salary Notch")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

