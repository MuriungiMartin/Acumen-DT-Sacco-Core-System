#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516245 "HR Job Training Needs"
{

    fields
    {
        field(1;"CODE";Code[50])
        {
            Description = 'Primary Key';

            trigger OnValidate()
            begin
                HrJobs.Reset;
                if HrJobs.Get(CODE) then begin
                Description:=HrJobs.Description;
                 end;
            end;
        }
        field(2;"Job ID";Code[50])
        {
            TableRelation = "HR Jobs"."Job ID";
        }
        field(3;Description;Text[250])
        {
        }
        field(4;"Training Group";Code[50])
        {
            TableRelation = "HR Training Applications"."Training Group No.";
        }
        field(5;"No of Participants";Code[10])
        {
            TableRelation = "HR Training Applications"."No. of Participant";
        }
    }

    keys
    {
        key(Key1;"CODE","Job ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HrJobs: Record "HR Training Needs";
}

