#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516097 "Tariff Details"
{

    fields
    {
        field(1;"Code";Code[20])
        {
            Editable = true;
        }
        field(2;"Lower Limit";Decimal)
        {
            Editable = true;
        }
        field(3;"Upper Limit";Decimal)
        {
            Editable = true;
        }
        field(4;"Charge Amount";Decimal)
        {
            Editable = true;
        }
    }

    keys
    {
        key(Key1;"Code","Lower Limit")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

