pageextension 50200 "ApplyVendlegerPgExt" extends "Apply Vendor Entries"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        PVLine: Record "Payment Line";


    procedure SetPVLine(NewPVLine: Record "Payment Line"; var NewVendLedgEntry: Record "Vendor Ledger Entry"; ApplnTypeSelect: Integer)
    var
        PaymentHeader: Record "Payments Header";
    begin

        PVLine := NewPVLine;
        Rec.CopyFilters(NewVendLedgEntry);

        ApplyingAmount := PVLine.Amount;

        PaymentHeader.Reset;
        PaymentHeader.SetRange(PaymentHeader."No.", NewPVLine.No);

        if PaymentHeader.Find('-') then begin
            ApplnDate := PaymentHeader.Date;
            ApplnCurrencyCode := PaymentHeader."Currency Code";
            CalcType := Calctype::PV;
        end;

        case ApplnTypeSelect of
            NewPVLine.FieldNo("Applies-to Doc. No."):
                ApplnType := Applntype::"Applies-to Doc. No.";
            NewPVLine.FieldNo("Applies-to ID"):
                ApplnType := Applntype::"Applies-to ID";
        end;

        SetApplyingVendLedgEntry;
    end;
}