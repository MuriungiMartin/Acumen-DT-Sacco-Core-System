#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516255 "Hr Appraisal Company Targets"
{

    fields
    {
        field(1;"Code";Code[10])
        {
        }
        field(2;Description;Text[30])
        {
        }
        field(3;"Maximum Score";Decimal)
        {

            trigger OnValidate()
            begin
                /*
                HRAppraisalRating.RESET;
                HRAppraisalRating.SETRANGE(HRAppraisalRating.Score,Score);
                IF HRAppraisalRating.FIND('-') THEN
                  BEGIN
                    ERROR('You cannot have two appraisal ratings with the same score');
                  END;
                */

            end;
        }
        field(4;Recommendations;Text[200])
        {
        }
        field(5;"Description 2";Text[250])
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

