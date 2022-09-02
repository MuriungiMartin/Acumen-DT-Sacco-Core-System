#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516553 "SurePESA Setup"
{

    fields
    {
        field(1;"Max Daily limit";Decimal)
        {
        }
        field(2;"Max Trans Limit";Decimal)
        {
        }
        field(3;Entry;Integer)
        {
            AutoIncrement = true;
        }
        field(4;"Max daily Airtime";Decimal)
        {
        }
        field(5;"Max airtime";Decimal)
        {
        }
        field(6;"Min Airtime";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;Entry)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

