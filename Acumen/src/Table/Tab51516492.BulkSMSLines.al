#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516492 "Bulk SMS Lines"
{

    fields
    {
        field(1;No;Code[20])
        {
            NotBlank = true;
            TableRelation = "Bulk SMS Header".No;
        }
        field(2;"Code";Code[20])
        {
            NotBlank = true;
        }
        field(3;Description;Text[100])
        {
        }
    }

    keys
    {
        key(Key1;No,"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

