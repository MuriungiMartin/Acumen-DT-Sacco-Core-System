tableextension 50002 "VendorledgerExt" extends "Vendor Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Applies ID"; Code[20])
        {
        }
        field(50001; DocNo; Code[20])
        {
        }
        field(51516061; "Reversal Date"; Date)
        {
        }
        field(51516062; "Transaction Date"; Date)
        {
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }
    }

    var
        myInt: Integer;
}