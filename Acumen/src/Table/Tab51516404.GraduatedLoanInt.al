#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516404 "Graduated Loan Int."
{

    fields
    {
        field(1;"Loan Code";Code[20])
        {
            TableRelation = "Loan Products Setup".Code;
        }
        field(2;"Period From";Integer)
        {
        }
        field(3;"Period To";Integer)
        {
        }
        field(4;"Min Amount";Decimal)
        {
        }
        field(5;"Max Amount";Decimal)
        {
        }
        field(6;"Interest Rate";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Loan Code","Interest Rate","Period To")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

