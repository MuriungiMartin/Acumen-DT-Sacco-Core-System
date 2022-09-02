#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516661 "Account Bov"
{

    fields
    {
        field(1;IDno;Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Name;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Date of Birth";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Account No";Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;IDno)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

