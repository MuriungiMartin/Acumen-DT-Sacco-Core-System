tableextension 50029 "InventorySetupExt" extends "Inventory Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50003; "Item Jnl Template"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Template";
        }
        field(50004; "Item Jnl Batch"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name;
        }
        field(50005; "Default Location Stock Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Internal Return Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    var
        myInt: Integer;
}