#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516059 "Destination Rate Entry"
{
    DrillDownPageID = UnknownPage56073;
    LookupPageID = UnknownPage56073;

    fields
    {
        field(1;"Advance Code";Code[20])
        {
            NotBlank = true;
            TableRelation = "Receipts and Payment Types".Code where (Type=const(Imprest));
        }
        field(2;"Destination Code";Code[10])
        {
            NotBlank = true;
            TableRelation = "Travel Destination"."Destination Code";

            trigger OnValidate()
            begin
                "objTravel Destination".Reset;
                "objTravel Destination".SetRange("objTravel Destination"."Destination Code","Destination Code");
                if "objTravel Destination".Find('-') then begin
                 "Destination Name":="objTravel Destination"."Destination Name";
                 "Destination Type":="objTravel Destination"."Destination Type";
                end;
            end;
        }
        field(3;Currency;Code[10])
        {
            NotBlank = false;
            TableRelation = Currency;
        }
        field(4;"Destination Type";Option)
        {
            Editable = false;
            OptionMembers = "local",Foreign;
        }
        field(5;"Daily Rate (Amount)";Decimal)
        {
        }
        field(6;"Employee Job Group";Code[10])
        {
            Editable = true;
            NotBlank = true;
            TableRelation = "HR Lookup Values".Code where (Type=const(Grade));
        }
        field(7;"Destination Name";Text[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Destination Code","Employee Job Group",Currency,"Advance Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        "objTravel Destination": Record "Travel Destination";
}

