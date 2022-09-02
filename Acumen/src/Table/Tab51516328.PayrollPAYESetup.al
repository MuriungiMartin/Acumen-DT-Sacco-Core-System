#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516328 "Payroll PAYE Setup."
{

    fields
    {
        field(10;"Tier Code";Code[10])
        {
        }
        field(12;"PAYE Tier";Decimal)
        {
        }
        field(13;Rate;Decimal)
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

