#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516279 "HR Employee Course of Study"
{

    fields
    {
        field(1;"Code";Code[50])
        {
            Description = 'Code';
        }
        field(2;Description;Text[75])
        {
            Description = 'Description';
        }
        field(3;"Years of Study";Decimal)
        {
            DecimalPlaces = 0:0;
            Description = 'Years of Study';
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

