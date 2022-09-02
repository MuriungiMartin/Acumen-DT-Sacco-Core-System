#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516242 "HR Interview Specific Evaluatn"
{

    fields
    {
        field(10;"Evaluation Code";Code[30])
        {
            TableRelation = "HR Interview Evaluation Areas"."Evaluation Code";

            trigger OnValidate()
            begin
                HRINTVIEW.Reset;
                //HRINTVIEW.SETRANGE(HRINTVIEW."Evaluation Code","Evaluation Code");
                if HRINTVIEW.Find('-') then
                  begin
                //    "Evaluation Description":=  HRINTVIEW."Evaluation Description"     ;
                    HrRating.FindLast ;
                //    "Total Target":= HrRating.Score
                  end;

                 // HrRating.RESET ;
                  //IF HrRating.FIND('+')     THEN
                 // HRAppraisalEvaluations."Total Target":=HrRatings.Score;
            end;
        }
        field(15;"Interview No.";Code[30])
        {
        }
        field(20;"Evaluation Description";Text[250])
        {
        }
        field(30;"Interview Rating";Code[20])
        {
        }
        field(40;"Stage 1 Score";Decimal)
        {
            TableRelation = "HR Interview Evalution Rating".Score;
        }
        field(50;"Stage 2 Score";Decimal)
        {
            TableRelation = "HR Interview Evalution Rating".Score;
        }
        field(55;"Stage 3 Score";Decimal)
        {
            TableRelation = "HR Interview Evalution Rating".Score;
        }
        field(60;"Total Target";Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Evaluation Code","Interview No.")
        {
            Clustered = true;
            SumIndexFields = "Stage 1 Score","Stage 2 Score","Stage 3 Score";
        }
    }

    fieldgroups
    {
    }

    var
        HRINTVIEW: Record "HR Interview Evaluation Areas";
        HrRating: Record "HR Interview Evalution Rating";
        HrEval: Record "HR Interview Specific Evaluatn";
}

