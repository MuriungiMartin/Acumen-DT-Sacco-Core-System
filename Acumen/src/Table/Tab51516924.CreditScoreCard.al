#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516924 "Credit Score Card"
{

    fields
    {
        field(1;"Variable Code";Option)
        {
            OptionCaption = 'Balance of Current Account,Duration of Credit,Payment of Previous Credits,Purpose of Credit';
            OptionMembers = "Balance of Current Account","Duration of Credit","Payment of Previous Credits","Purpose of Credit";

            trigger OnValidate()
            begin
                ObjScoreCardHeader.Reset;
                ObjScoreCardHeader.SetRange(ObjScoreCardHeader."Member No","Member No");
                if ObjScoreCardHeader.Find('-') then
                  "Member No":=ObjScoreCardHeader."Member No";
            end;
        }
        field(2;Value;Text[200])
        {
            TableRelation = "Credit Score Matrix"."Value/Range" where (Variable=field("Variable Code"));

            trigger OnValidate()
            begin
                ObjScoreMatrix.Reset;
                ObjScoreMatrix.SetRange(ObjScoreMatrix.Variable,"Variable Code");
                ObjScoreMatrix.SetRange(ObjScoreMatrix."Value/Range",Value);
                if ObjScoreMatrix.Find('-') then
                  Score:=ObjScoreMatrix."Rounded scoring";
            end;
        }
        field(3;Score;Decimal)
        {
        }
        field(4;"Member No";Code[50])
        {
            TableRelation = "Score Card Header"."Member No";
        }
        field(5;"Entry No.";Integer)
        {
            AutoIncrement = false;
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjScoreMatrix: Record "Credit Score Matrix";
        ObjScoreCardHeader: Record "Score Card Header";
}

