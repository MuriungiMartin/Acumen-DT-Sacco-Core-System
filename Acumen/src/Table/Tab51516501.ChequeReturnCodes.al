#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516501 "Cheque Return Codes"
{

    fields
    {
        field(1;"Return Code";Code[2])
        {
        }
        field(2;"Code Interpretation";Text[100])
        {
        }
        field(3;Charges;Decimal)
        {
        }
        field(4;"Bounced Charges GL Account";Code[20])
        {
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1;"Return Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Return Code","Code Interpretation")
        {
        }
    }
}

