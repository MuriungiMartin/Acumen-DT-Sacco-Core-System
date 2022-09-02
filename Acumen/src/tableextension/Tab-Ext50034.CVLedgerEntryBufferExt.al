tableextension 50034 "CVLedgerEntryBufferExt" extends "CV Ledger Entry Buffer"
{
    fields
    {
        // Add changes to table fields here

    }

    var
        myInt: Integer;

    procedure CopyFromMemberLedgEntry(MemberLedgEntry: Record "Cust. Ledger Entry")
    begin
        TransferFields(MemberLedgEntry);
        Amount := MemberLedgEntry.Amount;
        "Amount (LCY)" := MemberLedgEntry."Amount (LCY)";
        "Remaining Amount" := MemberLedgEntry."Remaining Amount";
        "Remaining Amt. (LCY)" := MemberLedgEntry."Remaining Amt. (LCY)";
        "Original Amount" := MemberLedgEntry."Original Amount";
        "Original Amt. (LCY)" := MemberLedgEntry."Original Amt. (LCY)";
    end;
}