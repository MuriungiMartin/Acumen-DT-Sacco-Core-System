#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516236 "HR Appraisal Evaluation Descri"
{

    fields
    {
        field(1;"Evaluation Area";Code[80])
        {
            TableRelation = "HR Appraisal Eval Areas"."Assign To";
        }
        field(2;"Line No";Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(3;"Evaluation Description";Text[250])
        {
        }
    }

    keys
    {
        key(Key1;"Evaluation Area","Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

