#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516116 "Cshmgt Cashier Transfer"
{
    // DrillDownPageID = cashier;
    // LookupPageID = UnknownPage56063;

    fields
    {
        field(1; "Line No."; Integer)
        {
        }
        field(2; "Transfer Code"; Code[20])
        {
        }
        field(3; "Transfer Date"; Date)
        {
        }
        field(4; "Transfer Time"; Time)
        {
        }
        field(5; "Account No."; Code[20])
        {
        }
        field(6; "Interim Account"; Code[20])
        {
        }
        field(7; Amount; Decimal)
        {
        }
        field(8; "Transfer UserID"; Code[20])
        {
        }
        field(9; "Transfer Machine"; Text[30])
        {
        }
        field(10; "Amount Receipted"; Decimal)
        {
            FieldClass = FlowField;
        }
        field(11; "To Account No."; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(12; Rejected; Boolean)
        {
        }
        field(13; "Rejected Date"; Date)
        {
        }
        field(14; "Rejected Time"; Time)
        {
        }
        field(15; "Rejected Machine"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

