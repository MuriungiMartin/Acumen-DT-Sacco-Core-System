#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516047 "Cashier Link"
{
    // DrillDownPageID = UnknownPage50121;
    // LookupPageID = UnknownPage50121;

    fields
    {
        field(1; UserID; Code[20])
        {
            NotBlank = true;
            TableRelation = "User Setup"."User ID";
        }
        field(2; "Bank Account No"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(3; "Branch Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BRANCHES'));
        }
    }

    keys
    {
        key(Key1; UserID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

