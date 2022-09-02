#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516921 "Collateral Depr Register"
{
    DrillDownPageID = "Collateral Depr. Schedule";
    LookupPageID = "Collateral Depr. Schedule";

    fields
    {
        field(1;"Document No";Code[20])
        {
        }
        field(2;"Transaction Date";Date)
        {
        }
        field(3;"Transaction Description";Text[50])
        {
        }
        field(4;"Collateral Value";Decimal)
        {
        }
        field(5;"Depreciation Amount";Decimal)
        {
        }
        field(6;"Collateral NBV";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Document No","Transaction Date","Transaction Description")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

