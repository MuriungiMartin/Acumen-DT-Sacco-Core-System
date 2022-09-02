#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516384 "Loan Product Cycles"
{

    fields
    {
        field(1;"Product Code";Code[20])
        {
            NotBlank = true;
            TableRelation = "HR 360 Appraisal Eval Areas"."Line No.";
        }
        field(2;Cycle;Integer)
        {
            NotBlank = true;
        }
        field(3;"Max. Installments";Integer)
        {
        }
        field(4;"Max. Amount";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Product Code",Cycle)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

