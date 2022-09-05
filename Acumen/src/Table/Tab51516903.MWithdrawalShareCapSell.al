#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516903 "M_Withdrawal Share Cap Sell"
{

    fields
    {
        field(1; "Document No"; Code[20])
        {
        }
        field(2; "Selling Member No"; Code[20])
        {
        }
        field(3; "Selling Member Name"; Code[100])
        {
        }
        field(4; "Buyer Member No"; Code[30])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Buyer Member No") then begin
                    "Buyer Name" := ObjCust.Name;
                end;
            end;
        }
        field(5; "Buyer Name"; Code[100])
        {
        }
        field(6; Amount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Document No", "Selling Member No", "Selling Member Name", "Buyer Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjCust: Record Customer;
}

