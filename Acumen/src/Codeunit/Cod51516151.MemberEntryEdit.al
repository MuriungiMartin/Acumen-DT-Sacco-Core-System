#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516151 "Member. Entry-Edit"
{
    Permissions = TableData "Cust. Ledger Entry" = imd,
                  TableData "Detailed Cust. Ledg. Entry" = m;
    TableNo = "Cust. Ledger Entry";

    trigger OnRun()
    begin
        CustLedgEntry := Rec;
        CustLedgEntry.LockTable;
        CustLedgEntry.Find;
        CustLedgEntry."On Hold" := "On Hold";
        if CustLedgEntry.Open then begin
            CustLedgEntry."Due Date" := "Due Date";
            // DtldCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.");
            // DtldCustLedgEntry.SETRANGE("Cust. Ledger Entry No.",CustLedgEntry."Entry No.");
            // DtldCustLedgEntry.MODIFYALL("Initial Entry Due Date","Due Date");
            CustLedgEntry."Pmt. Discount Date" := "Pmt. Discount Date";
            CustLedgEntry."Applies-to ID" := "Applies-to ID";
            CustLedgEntry.Validate("Remaining Pmt. Disc. Possible", "Remaining Pmt. Disc. Possible");
            CustLedgEntry."Pmt. Disc. Tolerance Date" := "Pmt. Disc. Tolerance Date";
            CustLedgEntry.Validate("Max. Payment Tolerance", "Max. Payment Tolerance");
            CustLedgEntry.Validate("Accepted Payment Tolerance", "Accepted Payment Tolerance");
            CustLedgEntry.Validate("Accepted Pmt. Disc. Tolerance", "Accepted Pmt. Disc. Tolerance");
            CustLedgEntry.Validate("Amount to Apply", "Amount to Apply");
            CustLedgEntry.Validate("Applying Entry", "Applying Entry");
        end;
        CustLedgEntry.Modify;
        Rec := CustLedgEntry;
    end;

    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
}

