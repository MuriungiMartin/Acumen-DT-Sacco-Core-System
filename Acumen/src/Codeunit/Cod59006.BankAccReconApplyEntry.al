#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 59006 "Bank Acc. Recon. Apply Entry"
{
    TableNo = "Bank Acc. Reconciliation Lines";

    trigger OnRun()
    begin
    end;

    var
        BankAccReconLine2: Record "Bank Acc. Reconciliation Lines";
        CheckLedgEntry: Record "Check Ledger Entry";
        ApplyCheckLedgEntry: Page UnknownPage59005;
        OK: Boolean;


    procedure ApplyEntries(var BankAccReconLine: Record "Bank Acc. Reconciliation Lines")
    begin
        BankAccReconLine2 := BankAccReconLine;
        BankAccReconLine2.TestField("Ready for Application",true);
        with BankAccReconLine2 do
          case Type of
            Type::"Check Ledger Entry":
              begin
                CheckLedgEntry.Reset;
                CheckLedgEntry.SetCurrentkey("Bank Account No.",Open);
                CheckLedgEntry.SetRange("Bank Account No.","Bank Account No.");
                CheckLedgEntry.SetRange(Open,true);
                CheckLedgEntry.SetFilter(
                  "Entry Status",'%1|%2',CheckLedgEntry."entry status"::Posted,
                  CheckLedgEntry."entry status"::"Financially Voided");
                CheckLedgEntry.SetFilter(
                  "Statement Status",'%1|%2',CheckLedgEntry."statement status"::Open,
                  CheckLedgEntry."statement status"::"Check Entry Applied");
                CheckLedgEntry.SetFilter("Statement No.",'''''|%1',"Statement No.");
                CheckLedgEntry.SetFilter("Statement Line No.",'0|%1',"Statement Line No.");
                ApplyCheckLedgEntry.SetStmtLine(BankAccReconLine);
                ApplyCheckLedgEntry.SetRecord(CheckLedgEntry);
                ApplyCheckLedgEntry.SetTableview(CheckLedgEntry);
                ApplyCheckLedgEntry.LookupMode(true);
                OK := ApplyCheckLedgEntry.RunModal = Action::LookupOK;
                Clear(ApplyCheckLedgEntry);
              end;
          end;
    end;
}

