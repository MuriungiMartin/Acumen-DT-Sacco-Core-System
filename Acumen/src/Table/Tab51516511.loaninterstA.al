#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516511 "loan interstA"
{

    fields
    {
        field(2;"LoanNo.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;lineno;Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"LoanNo.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

