#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50021 "Loans Missing Product"
{

    fields
    {
        field(1;"Client Code";Code[30])
        {
        }
        field(2;"Requested Amount";Decimal)
        {
        }
        field(3;"Loan Product";Code[30])
        {
        }
    }

    keys
    {
        key(Key1;"Client Code","Loan Product")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

