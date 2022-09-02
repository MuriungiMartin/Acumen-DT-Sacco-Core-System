#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516544 "Agent Tariff Details"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {

            trigger OnValidate()
            begin
                /* IF "Entry No" = 0 THEN BEGIN
                   TariffDetails.RESET;
                   IF TariffDetails.FIND('+') THEN BEGIN
                   iEntryNo:=TariffDetails."Entry No";
                   iEntryNo:=iEntryNo+1;
                   END
                   ELSE BEGIN
                   iEntryNo:=1;
                   END;
                   END;
                 "Entry No":=iEntryNo;*/

            end;
        }
        field(2; "Code"; Code[20])
        {
            TableRelation = "Agency Tariff Header";
        }
        field(3; Charge; Decimal)
        {
        }
        field(4; "Lower Limit"; Decimal)
        {
        }
        field(5; "Upper Limit"; Decimal)
        {
        }
        field(6; "Agent Comm"; Decimal)
        {
        }
        field(7; "Sacco Comm"; Decimal)
        {
        }
        field(8; "Vendor Comm"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }

    var
        TariffDetails: Record "Agent Withdrawal Limits";
        iEntryNo: Integer;
}

