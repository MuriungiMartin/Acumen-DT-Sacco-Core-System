#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516448 "FD Interest Calculation Crite"
{

    fields
    {
        field(1;"Code";Code[30])
        {
        }
        field(2;"Minimum Amount";Decimal)
        {
            NotBlank = true;
        }
        field(3;"Maximum Amount";Decimal)
        {
            NotBlank = true;
        }
        field(4;"Interest Rate";Decimal)
        {
        }
        field(5;Duration;DateFormula)
        {
        }
        field(6;"On Call Interest Rate";Decimal)
        {
        }
        field(7;"No of Months";Integer)
        {
        }
    }

    keys
    {
        key(Key1;"Code","Minimum Amount",Duration,"Interest Rate","No of Months")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

