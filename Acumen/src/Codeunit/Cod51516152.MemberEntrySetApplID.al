#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516152 "Member Entry-Set Appl.ID"
{
    Permissions = TableData "Cust. Ledger Entry" = imd;

    trigger OnRun()
    begin
    end;

    var
        CustEntryApplID: Code[20];


    procedure SetApplId(var CustLedgEntry: Record "Cust. Ledger Entry"; ApplyingCustLedgEntry: Record "Cust. Ledger Entry"; AppliedAmount: Decimal; PmtDiscAmount: Decimal; AppliesToID: Code[20])
    begin
        CustLedgEntry.LockTable;
        if CustLedgEntry.Find('-') then begin
            // Make Applies-to ID
            if CustLedgEntry."Applies-to ID" <> '' then
                CustEntryApplID := ''
            else begin
                CustEntryApplID := AppliesToID;
                if CustEntryApplID = '' then begin
                    CustEntryApplID := UserId;
                    if CustEntryApplID = '' then
                        CustEntryApplID := '***';
                end;
            end;

            // Set Applies-to ID
            repeat
                CustLedgEntry.TestField(Open, true);
                CustLedgEntry."Applies-to ID" := CustEntryApplID;
                if CustLedgEntry."Applies-to ID" = '' then begin
                    CustLedgEntry."Accepted Pmt. Disc. Tolerance" := false;
                    CustLedgEntry."Accepted Payment Tolerance" := 0;
                end;
                // Set Amount to Apply
                if ((CustLedgEntry."Amount to Apply" <> 0) and (CustEntryApplID = '')) or
                  (CustEntryApplID = '')
                then
                    CustLedgEntry."Amount to Apply" := 0
                else
                    if CustLedgEntry."Amount to Apply" = 0 then begin
                        CustLedgEntry.CalcFields("Remaining Amount");
                        CustLedgEntry."Amount to Apply" := CustLedgEntry."Remaining Amount"
                    end;

                if CustLedgEntry."Entry No." = ApplyingCustLedgEntry."Entry No." then
                    CustLedgEntry."Applying Entry" := ApplyingCustLedgEntry."Applying Entry";
                CustLedgEntry.Modify;
            until CustLedgEntry.Next = 0;
        end;
    end;
}

