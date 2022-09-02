#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516374 "Apply Member Entries"
{
    PageType = Card;
    SourceTable = "Cust. Ledger Entry";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = Basic;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Remaining Amount"; "Remaining Amount")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        ApplyingCustLedgEntry: Record "Cust. Ledger Entry" temporary;
        AppliedCustLedgEntry: Record "Cust. Ledger Entry";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        SalesHeader: Record "Sales Header";
        ServHeader: Record "Service Header";
        Cust: Record Customer;
        CustLedgEntry: Record "Cust. Ledger Entry";
        GLSetup: Record "General Ledger Setup";
        TotalSalesLine: Record "Sales Line";
        TotalSalesLineLCY: Record "Sales Line";
        TotalServLine: Record "Service Line";
        TotalServLineLCY: Record "Service Line";
        Navigate: Page Navigate;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        SalesPost: Codeunit "Sales-Post";
        AppliedAmount: Decimal;
        ApplyingAmount: Decimal;
        PmtDiscAmount: Decimal;
        ApplnDate: Date;
        ApplnCurrencyCode: Code[10];
        ApplnRoundingPrecision: Decimal;
        ApplnRounding: Decimal;
        ApplnType: Option " ","Applies-to Doc. No.","Applies-to ID";
        AmountRoundingPrecision: Decimal;
        VATAmount: Decimal;
        VATAmountText: Text[30];
        StyleTxt: Text;
        ProfitLCY: Decimal;
        ProfitPct: Decimal;
        CalcType: Option Direct,GenJnlLine,SalesHeader,ServHeader,Receipt;
        CustEntryApplID: Code[50];
        ValidExchRate: Boolean;
        DifferentCurrenciesInAppln: Boolean;
        ShowAppliedEntries: Boolean;
        OK: Boolean;
        PostingDone: Boolean;
        [InDataSet]
        "Applies-to IDVisible": Boolean;


    procedure SetGenJnlLine(NewGenJnlLine: Record "Gen. Journal Line"; ApplnTypeSelect: Integer)
    begin
        /*GenJnlLine := NewGenJnlLine;
        
        IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer THEN
          ApplyingAmount := GenJnlLine.Amount;
        IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer THEN
          ApplyingAmount := -GenJnlLine.Amount;
        ApplnDate := GenJnlLine."Posting Date";
        ApplnCurrencyCode := GenJnlLine."Currency Code";
        CalcType := CalcType::GenJnlLine;
        
        CASE ApplnTypeSelect OF
          GenJnlLine.FIELDNO("Applies-to Doc. No."):
            ApplnType := ApplnType::"Applies-to Doc. No.";
          GenJnlLine.FIELDNO("Applies-to ID"):
            ApplnType := ApplnType::"Applies-to ID";
        END;
        
        SetApplyingCustLedgEntry;*/

    end;
}

