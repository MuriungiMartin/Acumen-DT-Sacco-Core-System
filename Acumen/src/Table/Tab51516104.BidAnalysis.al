#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516104 "Bid Analysis"
{

    fields
    {
        field(1;"RFQ No.";Code[20])
        {
        }
        field(2;"RFQ Line No.";Integer)
        {
        }
        field(3;"Quote No.";Code[20])
        {
        }
        field(4;"Vendor No.";Code[20])
        {
        }
        field(5;"Item No.";Code[20])
        {
        }
        field(6;Description;Text[100])
        {
        }
        field(7;Quantity;Decimal)
        {
        }
        field(8;"Unit Of Measure";Code[20])
        {
        }
        field(9;Amount;Decimal)
        {
        }
        field(10;"Line Amount";Decimal)
        {
        }
        field(11;Total;Decimal)
        {
        }
        field(12;"Last Direct Cost";Decimal)
        {
            CalcFormula = lookup(Item."Last Direct Cost" where ("No."=field("Item No.")));
            FieldClass = FlowField;
        }
        field(13;Remarks;Text[50])
        {

            trigger OnValidate()
            begin
                PurchLine.Reset;
                PurchLine.SetRange(PurchLine."Document Type",PurchLine."document type"::Quote);
                PurchLine.SetRange(PurchLine."Document No.","Quote No.");
                PurchLine.SetRange(PurchLine."Line No.","RFQ Line No.");
                if PurchLine.FindSet then
                begin
                 PurchLine."RFQ Remarks" := Remarks;
                 PurchLine.Modify;
                end
            end;
        }
    }

    keys
    {
        key(Key1;"RFQ No.","RFQ Line No.","Quote No.","Vendor No.")
        {
            Clustered = true;
        }
        key(Key2;"Item No.")
        {
        }
        key(Key3;"Vendor No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PurchLine: Record "Purchase Line";
}

