#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516935 "Member Net Risk Rating Scale"
{

    fields
    {
        field(1;"Minimum Risk Rate";Decimal)
        {
        }
        field(2;"Maximum Risk Rate";Decimal)
        {
        }
        field(3;"Risk Scale";Option)
        {
            OptionCaption = 'Low Risk,Medium Risk,High Risk';
            OptionMembers = "Low Risk","Medium Risk","High Risk";
        }
        field(4;Description;Text[30])
        {
        }
    }

    keys
    {
        key(Key1;"Minimum Risk Rate")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

