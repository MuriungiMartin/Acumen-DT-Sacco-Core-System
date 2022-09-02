#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516925 "Score Card Header"
{

    fields
    {
        field(1;"Member No";Code[50])
        {
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            begin

                objScoreCardHeader.Reset;
                objScoreCardHeader.SetRange(objScoreCardHeader."Member No","Member No");
                if objScoreCardHeader.Find('-') then begin
                  objScoreCardHeader.DeleteAll;
                  end;

                objScoreCardHeader.Reset;
                if objScoreCardHeader.FindLast then begin
                No:=objScoreCardHeader."Entry No.";
                end;

                objScoreCardHeader.Init;
                objScoreCardHeader."Variable Code":= objScoreCardHeader."variable code"::"Duration of Credit";
                objScoreCardHeader."Member No":="Member No";
                objScoreCardHeader."Entry No.":=No+1;
                objScoreCardHeader.Insert;

                objScoreCardHeader.Init;
                objScoreCardHeader."Variable Code":=objScoreCardHeader."variable code"::"Payment of Previous Credits";
                objScoreCardHeader."Member No":="Member No";
                objScoreCardHeader."Entry No.":=No+2;
                objScoreCardHeader.Insert;
                objScoreCardHeader.Init;
                objScoreCardHeader."Variable Code":=objScoreCardHeader."variable code"::"Purpose of Credit";
                objScoreCardHeader."Member No":="Member No";
                objScoreCardHeader."Entry No.":=No+3;
                objScoreCardHeader.Insert;
                objScoreCardHeader.Init;
                objScoreCardHeader."Variable Code":=objScoreCardHeader."variable code"::"Balance of Current Account";
                objScoreCardHeader."Member No":="Member No";
                objScoreCardHeader."Entry No.":=No+4;
                objScoreCardHeader.Insert;
                //END
            end;
        }
        field(2;"Registration Date";Date)
        {
        }
        field(3;"Date Approved";Date)
        {
        }
        field(4;"Captured By";Code[150])
        {
        }
        field(5;"Last Modified By";Code[150])
        {
        }
        field(6;"Last Modified Date";Date)
        {
        }
        field(7;"Total Score";Decimal)
        {
            CalcFormula = sum("Credit Score Card".Score where ("Member No"=field("Member No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Captured By":=UserId;
        "Registration Date":=Today;
    end;

    var
        objScoreCardHeader: Record "Credit Score Card";
        ObjHeaderScore: Record "Score Card Header";
        No: Integer;
}

