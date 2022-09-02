#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516237 "HR Appraissal Next KPI"
{

    fields
    {
        field(3;"Appraisal Period";Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Lookup Values".Code where (Type=filter("Appraisal Period"),
                                                           "Current Appraisal Period"=const(true));
        }
        field(7;"Agreement With Rating";Option)
        {
            OptionMembers = Entirely,Mostly,"To some extent","Not at all";
        }
        field(8;"Planned Targets/Objectives";Text[230])
        {
        }
        field(10;"Employee No";Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Employees";
        }
        field(11;"Msrment Criteria/Target Date";Text[30])
        {
        }
        field(12;"Target Points (Total=100)";Decimal)
        {
            DecimalPlaces = 0:0;
        }
        field(50004;Description;Text[250])
        {
        }
        field(50005;"Appraisal No";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Appraisal Period")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

