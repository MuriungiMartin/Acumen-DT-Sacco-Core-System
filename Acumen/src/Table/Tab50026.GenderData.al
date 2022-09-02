#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50026 "Gender Data"
{

    fields
    {
        field(1;MNO;Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Gender;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
    }

    keys
    {
        key(Key1;MNO)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

