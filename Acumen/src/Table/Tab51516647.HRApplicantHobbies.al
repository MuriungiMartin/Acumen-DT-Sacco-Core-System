#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516647 "HR Applicant Hobbies"
{

    fields
    {
        field(1;"Job Application No";Code[20])
        {
            TableRelation = "HR Job Applications"."Application No";
        }
        field(2;Hobby;Text[200])
        {
        }
    }

    keys
    {
        key(Key1;"Job Application No",Hobby)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

