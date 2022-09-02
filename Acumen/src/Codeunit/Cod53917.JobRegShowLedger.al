#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 53917 "Job-Reg.-Show Ledger"
{
    TableNo = UnknownTable53923;

    trigger OnRun()
    begin
        JobLedgEntry.SetRange("Entry No.","From Entry No.","To Entry No.");
        Page.Run(Page::Page54242,JobLedgEntry);
    end;

    var
        JobLedgEntry: Record UnknownRecord53914;
}

