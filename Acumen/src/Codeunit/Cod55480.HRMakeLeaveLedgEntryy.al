#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 55480 "HR Make Leave Ledg. Entryy"
{

    trigger OnRun()
    begin
    end;


    procedure CopyFromJnlLine(var InsCoverageLedgEntry: Record "Loan Product Charges";var InsuranceJnlLine: Record "Loan Product Cycles")
    begin
        with InsCoverageLedgEntry do begin
          "User ID" := UserId;
          Code := InsuranceJnlLine."Max. Amount";
          Amount := InsuranceJnlLine."Staff No.";
          Percentage := InsuranceJnlLine."Staff Name";
          "G/L Account" := InsuranceJnlLine."Posting Date";
          "Leave Recalled No.":=InsuranceJnlLine."Leave Recalled No.";
          "Use Perc" := InsuranceJnlLine."Leave Entry Type";
          "Leave Type":=InsuranceJnlLine."Leave Type";
          "Minimum Amount" := InsuranceJnlLine."Leave Approval Date";
          "Leave Type":=InsuranceJnlLine."Leave Type";
          if "Minimum Amount" = 0D then
          "Minimum Amount" := "G/L Account";
          "Deduction Type" :=  InsuranceJnlLine."Document No.";
          "External Document No." := InsuranceJnlLine."External Document No.";
          "No. of days" := InsuranceJnlLine."No. of Days";
          "Leave Posting Description" := InsuranceJnlLine.Description;
          "Global Dimension 1 Code" := InsuranceJnlLine."Shortcut Dimension 1 Code";
          "Global Dimension 2 Code" := InsuranceJnlLine."Shortcut Dimension 2 Code";
          "Source Code" := InsuranceJnlLine."Source Code";
          "Journal Batch Name" := InsuranceJnlLine.Cycle;
          "Reason Code" := InsuranceJnlLine."Reason Code";
          Description := SetDisposedFA(InsCoverageLedgEntry.Amount);
          "No. Series" := InsuranceJnlLine."Posting No. Series";
        end;
    end;


    procedure CopyFromInsuranceCard(var InsCoverageLedgEntry: Record "Loan Product Charges";var Insurance: Record "prEmployee P9 Info")
    begin
        /*WITH InsCoverageLedgEntry DO BEGIN
          "FA Class Code" := Insurance."FA Class Code";
          "FA Subclass Code" := Insurance."FA Subclass Code";
          "FA Location Code" := Insurance."FA Location Code";
          "Location Code" := Insurance."Location Code";
        END;*/

    end;


    procedure SetDisposedFA(FANo: Code[20]): Boolean
    var
        FASetup: Record "PR PAYE";
    begin
        /*FASetup.GET;
        FASetup.TESTFIELD("Insurance Depr. Book");
        IF FADeprBook.GET(FANo,FASetup."Insurance Depr. Book") THEN
          EXIT(FADeprBook."Disposal Date" > 0D)
        ELSE
          EXIT(FALSE);
         */

    end;


    procedure UpdateLeaveApp(LeaveCode: Code[20];Status: Option)
    var
        LeaveApplication: Record "prEmployee P9 Info";
    begin
    end;
}

