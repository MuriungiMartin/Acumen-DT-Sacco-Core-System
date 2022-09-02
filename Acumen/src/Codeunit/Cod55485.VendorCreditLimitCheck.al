#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 55485 "Vendor Credit Limit Check"
{

    trigger OnRun()
    begin
    end;

    var
        DateFilterCalc: Codeunit "DateFilter-Calc";
        VendDateFilter: array [4] of Text[30];
        VendDateName: array [4] of Text[30];
        TotalAmountLCY: Decimal;
        CurrentDate: Date;
        VendPurchLCY: array [4] of Decimal;
        VendInvDiscAmountLCY: array [4] of Decimal;
        VendPaymentDiscLCY: array [4] of Decimal;
        VendPaymentDiscTolLCY: array [4] of Decimal;
        VendPaymentTolLCY: array [4] of Decimal;
        VendReminderChargeAmtLCY: array [4] of Decimal;
        VendFinChargeAmtLCY: array [4] of Decimal;
        VendCrMemoAmountsLCY: array [4] of Decimal;
        VendPaymentsLCY: array [4] of Decimal;
        VendRefundsLCY: array [4] of Decimal;
        VendOtherAmountsLCY: array [4] of Decimal;
        i: Integer;
        InvAmountsLCY: array [4] of Decimal;


    procedure CheckVendorCreditLimit(var Rec: Record Vendor)
    begin
        with Rec do
          begin
            SetRange("No.");

            if CurrentDate <> WorkDate then begin
              CurrentDate := WorkDate;
              DateFilterCalc.CreateAccountingPeriodFilter(VendDateFilter[1],VendDateName[1],CurrentDate,0);
              DateFilterCalc.CreateFiscalYearFilter(VendDateFilter[2],VendDateName[2],CurrentDate,0);
              DateFilterCalc.CreateFiscalYearFilter(VendDateFilter[3],VendDateName[3],CurrentDate,-1);
            end;

            SetRange("Date Filter",0D,CurrentDate);
            CalcFields(
              Balance,"Balance (LCY)","Balance Due","Balance Due (LCY)",
              "Outstanding Orders (LCY)","Amt. Rcd. Not Invoiced (LCY)",
              "Reminder Amounts (LCY)");

            TotalAmountLCY := "Balance (LCY)" + "Outstanding Orders (LCY)" + "Amt. Rcd. Not Invoiced (LCY)" + "Outstanding Invoices (LCY)";

            for i := 1 to 4 do begin
              SetFilter("Date Filter",VendDateFilter[i]);
              CalcFields(
                "Purchases (LCY)","Inv. Discounts (LCY)","Inv. Amounts (LCY)","Pmt. Discounts (LCY)",
                "Pmt. Disc. Tolerance (LCY)","Pmt. Tolerance (LCY)",
                "Fin. Charge Memo Amounts (LCY)","Cr. Memo Amounts (LCY)","Payments (LCY)",
                "Reminder Amounts (LCY)","Refunds (LCY)","Other Amounts (LCY)");
              VendPurchLCY[i] := "Purchases (LCY)";
              VendInvDiscAmountLCY[i] := "Inv. Discounts (LCY)";
              InvAmountsLCY[i] := "Inv. Amounts (LCY)";
              VendPaymentDiscLCY[i] := "Pmt. Discounts (LCY)";
              VendPaymentDiscTolLCY[i] := "Pmt. Disc. Tolerance (LCY)";
              VendPaymentTolLCY[i] := "Pmt. Tolerance (LCY)";
              VendReminderChargeAmtLCY[i] := "Reminder Amounts (LCY)";
              VendFinChargeAmtLCY[i] := "Fin. Charge Memo Amounts (LCY)";
              VendCrMemoAmountsLCY[i] := "Cr. Memo Amounts (LCY)";
              VendPaymentsLCY[i] := "Payments (LCY)";
              VendRefundsLCY[i] := "Refunds (LCY)";
              VendOtherAmountsLCY[i] := "Other Amounts (LCY)";
            end;
            SetRange("Date Filter",0D,CurrentDate);

            Commit;
           //Message if Total Exceeds the Credit Limit
           if (Rec."Vendor Credit Limit(LCY)") <=0 then
              exit;
            if (Rec."Vendor Credit Limit(LCY)") < (TotalAmountLCY) then
              begin
                    if Page.RunModal(56082,Rec)=Action::No then
                  begin
                    Error('User Action Cancelled');
                  end;
              end;
          end;
    end;
}

