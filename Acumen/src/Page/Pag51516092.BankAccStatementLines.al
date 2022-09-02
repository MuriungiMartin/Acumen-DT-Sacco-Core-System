#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516092 "Bank Acc. Statement Lines"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Bank Acc. Statement Linevb";
    SourceTableView = where("Statement Type"=const("Bank Reconciliation"));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field("Document No.";"Document No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field("Statement Amount";"Statement Amount")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field("Applied Amount";"Applied Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Reconciled;Reconciled)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Difference;Difference)
                {
                    ApplicationArea = Basic;
                }
                field("Applied Entries";"Applied Entries")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Reconciling Date";"Reconciling Date")
                {
                    ApplicationArea = Basic;
                }
                field("Related-Party Name";"Related-Party Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Additional Transaction Info";"Additional Transaction Info")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Check No.";"Check No.")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Value Date";"Value Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Type;Type)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        SetUserInteractions;
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ShowStatementLineDetails)
            {
                ApplicationArea = Basic;
                Caption = 'Details';
                RunObject = Page "Bank Statement Line Details";
                RunPageLink = "Data Exch. No."=field("Posting Exch. Entry No."),
                              "Line No."=field("Posting Exch. Line No.");
                Visible = false;
            }
            action(ApplyEntries)
            {
                ApplicationArea = Basic;
                Caption = '&Apply Entries...';
                Enabled = ApplyEntriesAllowed;
                Image = ApplyEntries;
                Visible = false;

                trigger OnAction()
                begin
                    ApplyEntries;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if "Statement Line No." <> 0 then
          CalcBalance("Statement Line No.");
        SetUserInteractions;
    end;

    trigger OnAfterGetRecord()
    begin
        SetUserInteractions;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        SetUserInteractions;
    end;

    trigger OnInit()
    begin
        BalanceEnable := true;
        TotalBalanceEnable := true;
        TotalDiffEnable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if BelowxRec then
          CalcBalance(xRec."Statement Line No.")
        else
          CalcBalance(xRec."Statement Line No." - 1);
    end;

    var
        BankAccRecon: Record "Bank Acc. Reconciliation";
        StyleTxt: Text;
        TotalDiff: Decimal;
        Balance: Decimal;
        TotalBalance: Decimal;
        [InDataSet]
        TotalDiffEnable: Boolean;
        [InDataSet]
        TotalBalanceEnable: Boolean;
        [InDataSet]
        BalanceEnable: Boolean;
        ApplyEntriesAllowed: Boolean;

    local procedure CalcBalance(BankAccReconLineNo: Integer)
    var
        TempBankAccReconLine: Record "Bank Acc. Reconciliation Line";
    begin
        /*
        IF BankAccRecon.GET("Statement Type","Bank Account No.","Statement No.") THEN;
        
        TempBankAccReconLine.COPY(Rec);
        
        TotalDiff := -Difference;
        IF TempBankAccReconLine.CALCSUMS(Difference) THEN BEGIN
          TotalDiff := TotalDiff + TempBankAccReconLine.Difference;
          TotalDiffEnable := TRUE;
        END ELSE
          TotalDiffEnable := FALSE;
        
        TotalBalance := BankAccRecon."Balance Last Statement" - "Statement Amount";
        IF TempBankAccReconLine.CALCSUMS("Statement Amount") THEN BEGIN
          TotalBalance := TotalBalance + TempBankAccReconLine."Statement Amount";
          TotalBalanceEnable := TRUE;
        END ELSE
          TotalBalanceEnable := FALSE;
        
        Balance := BankAccRecon."Balance Last Statement" - "Statement Amount";
        TempBankAccReconLine.SETRANGE("Statement Line No.",0,BankAccReconLineNo);
        IF TempBankAccReconLine.CALCSUMS("Statement Amount") THEN BEGIN
          Balance := Balance + TempBankAccReconLine."Statement Amount";
          BalanceEnable := TRUE;
        END ELSE
          BalanceEnable := FALSE;
        */

    end;

    local procedure ApplyEntries()
    var
        BankAccReconApplyEntries: Codeunit "Bank Acc. Recon. Apply Entries";
    begin
        /*
        "Ready for Application" := TRUE;
        CurrPage.SAVERECORD;
        COMMIT;
        BankAccReconApplyEntries.ApplyEntries(Rec);
        */

    end;


    procedure GetSelectedRecords(var TempBankAccReconciliationLine: Record "Bank Acc. Statement Linevb" temporary)
    var
        BankAccReconciliationLine: Record "Bank Acc. Statement Linevb";
    begin
        CurrPage.SetSelectionFilter(BankAccReconciliationLine);
        if BankAccReconciliationLine.FindSet then
          repeat
            TempBankAccReconciliationLine := BankAccReconciliationLine;
            TempBankAccReconciliationLine.Insert;
          until BankAccReconciliationLine.Next = 0;
    end;

    local procedure SetUserInteractions()
    begin
        StyleTxt := GetStyle;
        ApplyEntriesAllowed := Type = Type::"Check Ledger Entry";
    end;


    procedure ToggleMatchedFilter(SetFilterOn: Boolean)
    begin
        if SetFilterOn then
          SetFilter(Difference,'<>%1',0)
        else
          Reset;
        CurrPage.Update;
    end;
}

