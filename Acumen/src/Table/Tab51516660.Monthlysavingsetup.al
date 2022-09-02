#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516660 "Monthly  saving setup"
{

    fields
    {
        field(1;"code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Name;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Min saving";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Max saving";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5;Period;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Monthly Saving Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

