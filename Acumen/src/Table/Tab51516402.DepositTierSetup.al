#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516402 "Deposit Tier Setup"
{

    fields
    {
        field(1;"Code";Code[20])
        {
        }
        field(2;Description;Text[50])
        {
        }
        field(3;"Minimum Amount";Decimal)
        {
        }
        field(4;"Maximum Amount";Decimal)
        {
        }
        field(5;"Minimum Dep Contributions";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Code","Minimum Amount","Maximum Amount","Minimum Dep Contributions")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

