#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516006 "Investment Management"
{

    trigger OnRun()
    begin
    end;

    var
        InvestorAmounts: Record "Transaction Types";
        InvestorAccount: Record "FOSA Account NOK Details";
        InvestorPostingGroup: Record "Standing Order Register";
        GenJnlLine: Record "Gen. Journal Line";

    local procedure InvestorInterestBatchJob("Investor No": Code[20]; "Journal Template": Code[20]; "Journal Batch": Code[20]; PostingGroup: Code[20])
    var
        InvestorAccount: Record "FOSA Account NOK Details";
        InvestorAmounts: Record "Transaction Types";
        InvestorPostingGroup: Record "Standing Order Register";
        LineNo: Integer;
        PaymentHeader: record "Payment Header.";
    begin
        if InvestorPostingGroup.Get(PostingGroup) then begin
            //Credit Investor,Debit Interest Expense
            LineNo := 1000;
            GenJnlLine.Init;
            GenJnlLine."Journal Template Name" := "Journal Template";
            GenJnlLine.Validate(GenJnlLine."Journal Template Name");
            GenJnlLine."Journal Batch Name" := "Journal Batch";
            GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
            GenJnlLine."Line No." := LineNo;
            //GenJnlLine."Source Code" := SourceCode;
            GenJnlLine."Posting Date" := today;
        end;
        //  PaymentHeader."Posting Date";
        // if CustomerLinesExist(PaymentHeader) then
        //     GenJnlLine."Document Type" := GenJnlLine."document type"::" "
        // else
        GenJnlLine."Document Type" := GenJnlLine."document type"::Payment;
        GenJnlLine."Document No." := PaymentHeader."No.";
        GenJnlLine."External Document No." := PaymentHeader."Cheque No";
        GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
        GenJnlLine."Account No." := PaymentHeader."Bank Account";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
        GenJnlLine.Validate("Currency Factor");
        GenJnlLine.Amount := -(PaymentHeader."Net Amount");  //Credit Amount
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := CopyStr(PaymentHeader."Payment Description", 1, 50);
        GenJnlLine.Validate(GenJnlLine.Description);
    end;
}

