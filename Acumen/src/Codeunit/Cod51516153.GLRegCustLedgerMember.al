#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516153 "G/L Reg.-Cust.Ledger-Member"
{
    TableNo = "G/L Register";

    trigger OnRun()
    begin
        CustLedgEntry.SetRange("Entry No.", "From Entry No.", "To Entry No.");
        Page.Run(Page::"HR Leave journal Template", CustLedgEntry);
    end;

    var
        CustLedgEntry: Record "Cust. Ledger Entry";
}

