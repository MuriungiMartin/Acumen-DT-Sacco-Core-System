#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516109 "Quotation Specification Lines"
{

    fields
    {
        field(1;"Document No.";Code[20])
        {
            TableRelation = "Purchase Header"."No." where ("Document Type"=const(Quote));
        }
        field(2;"Line No.";Integer)
        {
        }
        field(3;"Code";Code[20])
        {

            trigger OnValidate()
            begin
                QuoteSpec.Get(Code);
                "Max Score":=QuoteSpec."Value/Weight";
                Description:=QuoteSpec.Description;
            end;
        }
        field(4;Description;Text[60])
        {
        }
        field(5;Score;Decimal)
        {

            trigger OnValidate()
            begin
                if Score>"Max Score" then
                Error('The score can not be graeter than the max score specified');
            end;
        }
        field(6;"Request No.";Code[20])
        {
            TableRelation = "Purchase Quote Header"."No." where (Status=const(Released));
        }
        field(7;"Request Line No.";Integer)
        {
        }
        field(8;Type;Text[30])
        {
        }
        field(9;"Type No.";Code[20])
        {
        }
        field(10;"Type Name";Text[100])
        {
        }
        field(11;"Max Score";Decimal)
        {
        }
        field(12;"Total Score";Decimal)
        {
            FieldClass = FlowField;
        }
        field(13;"Temp Total Score";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Document No.","Line No.","Code","Request No.","Request Line No.",Score)
        {
            Clustered = true;
        }
        key(Key2;Score)
        {
        }
        key(Key3;"Request No.","Code",Type,"Type No.",Score)
        {
        }
        key(Key4;"Document No.","Request No.")
        {
            SumIndexFields = Score;
        }
        key(Key5;"Temp Total Score")
        {
        }
    }

    fieldgroups
    {
    }

    var
        QuoteSpec: Record "Quote Specifications";
}

