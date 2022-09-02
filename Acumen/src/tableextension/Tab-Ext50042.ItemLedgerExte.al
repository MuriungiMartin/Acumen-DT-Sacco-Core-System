tableextension 50042 "ItemLedgerExte" extends "Item Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(51516062; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }
        field(51516063; "Entry Type Two"; code[40])
        {
            DataClassification = ToBeClassified;
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }
    }

    var
        myInt: Integer;
}