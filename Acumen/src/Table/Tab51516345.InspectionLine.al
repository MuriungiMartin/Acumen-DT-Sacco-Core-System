#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516345 "Inspection Line"
{

    fields
    {
        field(1; "Document No."; Code[10])
        {
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = false;
        }
        field(3; "Delivery Note"; Code[10])
        {
        }
        field(4; Description; Text[50])
        {
        }
        field(5; "Receipt Voucher No."; Code[10])
        {
        }
        field(6; "Quantity Ordered"; Integer)
        {
        }
        field(7; "Quantity Accepted"; Integer)
        {

            trigger OnValidate()
            begin
                "Quantity Rejected" := "Quantity Ordered" - "Quantity Accepted";
            end;
        }
        field(8; "Quantity Rejected"; Integer)
        {

            trigger OnValidate()
            begin
                "Quantity Accepted" := "Quantity Ordered" - "Quantity Rejected";
            end;
        }
        field(9; "Reason for Rejection"; Text[250])
        {
        }
        field(10; "Rejection No."; Code[10])
        {
        }
        field(11; "Purchase Order No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.", "Purchase Order No.", "Receipt Voucher No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

