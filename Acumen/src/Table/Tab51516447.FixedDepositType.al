#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516447 "Fixed Deposit Type"
{
    DrillDownPageID = "Fixed deposit Types list";
    LookupPageID = "Fixed deposit Types list";

    fields
    {
        field(1;"Code";Code[30])
        {
            NotBlank = true;
        }
        field(2;Duration;DateFormula)
        {
        }
        field(3;Description;Text[50])
        {
        }
        field(4;"No. of Months";Integer)
        {
        }
        field(5;"Maximum Amount";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Code","Maximum Amount")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

