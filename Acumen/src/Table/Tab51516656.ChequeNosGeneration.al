#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516656 "Cheque Nos Generation"
{

    fields
    {
        field(1;"Cheque No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Issued;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(3;Cancelled;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Bank Code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
        }
    }

    keys
    {
        key(Key1;"Cheque No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

