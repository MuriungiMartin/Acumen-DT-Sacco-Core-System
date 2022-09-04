#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516224 "HR Calendar List"
{
    //LookupPageID = UnknownPage55640;

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Day; Text[40])
        {
            Editable = false;
        }
        field(3; Date; Date)
        {
            Editable = false;
        }
        field(4; "Non Working"; Boolean)
        {
            Editable = false;
        }
        field(5; Reason; Text[40])
        {
        }
    }

    keys
    {
        key(Key1; "Code", Date, Day)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

