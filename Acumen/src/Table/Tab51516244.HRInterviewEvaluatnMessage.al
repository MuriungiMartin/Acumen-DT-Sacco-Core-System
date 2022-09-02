#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516244 "HR Interview Evaluatn Message"
{

    fields
    {
        field(10;"Code";Code[20])
        {
        }
        field(20;Stages;Option)
        {
            OptionMembers = " ","Recommend for Stage 2","Recommend for Stage 3","Recommend for Hire";
        }
        field(25;Subject;Text[250])
        {
        }
        field(30;Message;Text[250])
        {
        }
        field(40;Venue;Text[250])
        {
        }
        field(50;Date;DateTime)
        {
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

