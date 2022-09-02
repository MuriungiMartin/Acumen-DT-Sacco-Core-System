#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516949 "Arch Dioces"
{

    fields
    {
        field(1;"Code";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Number';
        }
        field(2;Name;Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Name';
        }
        field(3;"Arch Dioces";Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Arch Dioces';
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

