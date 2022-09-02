#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516212 "HR Applicant Referees"
{

    fields
    {
        field(1;"Job Application No";Code[20])
        {
            TableRelation = "HR Job Applications"."Application No";
        }
        field(2;Names;Text[200])
        {
        }
        field(3;Designation;Text[100])
        {
        }
        field(4;Institution;Text[100])
        {
        }
        field(5;Address;Text[200])
        {
        }
        field(6;"Telephone No";Text[100])
        {
        }
        field(7;"E-Mail";Text[100])
        {
        }
        field(8;"Employee No";Code[30])
        {
        }
    }

    keys
    {
        key(Key1;"Job Application No",Names)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

