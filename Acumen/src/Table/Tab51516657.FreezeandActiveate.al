#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516657 "Freeze and Activeate"
{

    fields
    {
        field(1;No;Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Name;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Date;Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4;Time;Time)
        {
            DataClassification = ToBeClassified;
        }
        field(5;user;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Member No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7;Reason;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Entry No.";Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

