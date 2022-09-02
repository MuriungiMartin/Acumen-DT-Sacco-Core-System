tableextension 50020 "Purchaselineext" extends "Purchase Line"
{
    fields
    {
        // Add changes to table fields here

        field(50000; Committed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Expense Code"; Code[10])
        {
            // DataClassification = ToBeClassified;
            // TableRelation = Table55906;

            trigger OnValidate()
            begin
                //TestStatusOpen;
                TestField(Type, Type::"G/L Account");
            end;
        }
        field(50005; "RFQ No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'ADDED THIS FIELD';
        }
        field(50006; "RFQ Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'ADDED THIS FIELD';
            // TableRelation = Table56018.Field4;
        }
        field(50010; "Project Code"; Code[10])
        {
            CalcFormula = lookup("Purchase Header"."Project Code" where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(51000; "RFQ Remarks"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51002; "Requisition No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(55540; "Procurement Type Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Table55511;
        }
        field(55606; "Manual Requisition No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Quote),
                                                           Status = const(Released));

            trigger OnValidate()
            begin
                "Manually Added" := true;
            end;
        }
        field(55607; "Manually Added"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(59001; Remarks; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Added#KVB';
        }
        field(51516010; "Qty in store"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if Items.Get("No.") then
                    Items.CalcFields(Items.Inventory);
                "Qty in store" := Items.Inventory;
            end;
        }
    }

    var
        Items: Record Item;
}