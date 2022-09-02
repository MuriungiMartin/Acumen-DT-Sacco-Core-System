#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516552 "Term Deposits Rate FactBox"
{
    Caption = 'Term Deposits Rate FactBox';
    Editable = false;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "FD Interest Calculation Crite";

    layout
    {
        area(content)
        {
            field("Code";Code)
            {
                ApplicationArea = Basic;
            }
            field("Interest Rate";"Interest Rate")
            {
                ApplicationArea = Basic;
            }
            field(Duration;Duration)
            {
                ApplicationArea = Basic;
            }
            field("On Call Interest Rate";"On Call Interest Rate")
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        // Default the Aging Period to 30D
        Evaluate(AgingPeriod,'<30D>');
        // Initialize Record Variables
        LatestCustLedgerEntry.Reset;
        LatestCustLedgerEntry.SetCurrentkey("Document Type","Customer No.","Posting Date");
        LatestCustLedgerEntry.SetRange("Document Type",LatestCustLedgerEntry."document type"::Payment);
        for I := 1 to ArrayLen(CustLedgerEntry) do begin
          CustLedgerEntry[I].Reset;
          CustLedgerEntry[I].SetCurrentkey("Customer No.",Open,Positive,"Due Date");
          CustLedgerEntry[I].SetRange(Open,true);
        end;
    end;

    var
        LatestCustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry: array [4] of Record "Cust. Ledger Entry";
        AgingTitle: array [4] of Text[30];
        AgingPeriod: DateFormula;
        I: Integer;
        PeriodStart: Date;
        PeriodEnd: Date;
        Text002: label 'Not Yet Due';
        Text003: label 'Over %1 Days';
        Text004: label '%1-%2 Days';
        MinBalance: Decimal;
}

