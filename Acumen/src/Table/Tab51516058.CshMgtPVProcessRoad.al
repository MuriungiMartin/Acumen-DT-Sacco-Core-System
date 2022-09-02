#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516058 "CshMgt PV Process Road"
{

    fields
    {
        field(1;"From Status Code";Code[20])
        {
            TableRelation = "CshMgt PV Steps".Code;

            trigger OnValidate()
            begin
                PVSteps.Reset;
                PVSteps.Get("From Status Code");
                "From Status Description":=PVSteps."Account Name";
            end;
        }
        field(2;"From Status Description";Text[30])
        {
        }
        field(3;"To Status Code";Code[20])
        {
            TableRelation = "CshMgt PV Steps".Code;

            trigger OnValidate()
            begin
                PVSteps.Reset;
                PVSteps.Get("To Status Code");
                "To Status Description":=PVSteps."Account Name";
            end;
        }
        field(4;"To Status Description";Text[30])
        {
        }
        field(5;Start;Boolean)
        {
        }
        field(6;"End";Boolean)
        {
        }
        field(7;"Allow Check Preview";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"From Status Code","To Status Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PVSteps: Record "Cheque Clearing Lines";
}

