#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516213 "Loan Sub-Sector"
{

    fields
    {
        field(1;"Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Description;Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3;No;Code[10])
        {
            DataClassification = ToBeClassified;
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

