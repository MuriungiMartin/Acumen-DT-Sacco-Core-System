#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516338 "PR NHIF"
{

    fields
    {
        field(1;"Tier Code";Code[10])
        {
            SQLDataType = Integer;
        }
        field(2;"NHIF Tier";Decimal)
        {
        }
        field(3;Amount;Decimal)
        {
        }
        field(4;"Lower Limit";Decimal)
        {
        }
        field(5;"Upper Limit";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Tier Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

