#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516483 "POS Commissions"
{

    fields
    {
        field(1;"Code";Code[20])
        {
            NotBlank = true;
        }
        field(2;"Lower Limit";Decimal)
        {
        }
        field(3;"Upper Limit";Decimal)
        {
        }
        field(4;"Charge Amount";Decimal)
        {
        }
        field(5;"Sacco charge";Decimal)
        {
        }
        field(6;"Bank charge";Decimal)
        {
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

