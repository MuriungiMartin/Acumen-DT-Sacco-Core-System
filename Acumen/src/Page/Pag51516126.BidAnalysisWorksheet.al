#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516126 "Bid Analysis Worksheet"
{
    DeleteAllowed = false;
    PageType = Worksheet;
    SourceTable = "Bid Analysis";

    layout
    {
        area(content)
        {
            group(Control1102755012)
            {
                field(SalesCodeFilterCtrl;SalesCodeFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Vendor Code Filter';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        VendList: Page "Vendor List";
                    begin
                         begin
                           VendList.LookupMode := true;
                           if VendList.RunModal = Action::LookupOK then
                             Text := VendList.GetSelectionFilter
                           else
                            exit(false);
                        end;

                        exit(true);
                    end;

                    trigger OnValidate()
                    begin
                        SalesCodeFilterOnAfterValidate;
                    end;
                }
                field(ItemNoFilter;ItemNoFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Item No.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemList: Page "Item List";
                    begin
                        ItemList.LookupMode := true;
                        if ItemList.RunModal = Action::LookupOK then
                          Text := ItemList.GetSelectionFilter
                         else
                          exit(false);

                        exit(true);
                    end;

                    trigger OnValidate()
                    begin
                        ItemNoFilterOnAfterValidate;
                    end;
                }
                field(Total;Total)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            repeater(Group)
            {
                Editable = false;
                field("RFQ No.";"RFQ No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("RFQ Line No.";"RFQ Line No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Quote No.";"Quote No.")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor No.";"Vendor No.")
                {
                    ApplicationArea = Basic;
                }
                field(VendorName;VendorName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Vendor Name';
                }
                field("Item No.";"Item No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Quantity;Quantity)
                {
                    ApplicationArea = Basic;
                }
                field("Unit Of Measure";"Unit Of Measure")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Line Amount";"Line Amount")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Get Vendor Quotations")
            {
                ApplicationArea = Basic;
                Caption = 'Get Vendor Quotations';
                Image = GetSourceDoc;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    GetVendorQuotes;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Vendor.Get("Vendor No.");
        VendorName:=Vendor.Name;
        CalcTotals;
    end;

    var
        PurchHeader: Record "Purchase Header";
        PurchLines: Record "Purchase Line";
        ItemNoFilter: Text[250];
        RFQNoFilter: Text[250];
        InsertCount: Integer;
        SalesCodeFilter: Text[250];
        VendorName: Text;
        Vendor: Record Vendor;
        Total: Decimal;


    procedure SetRecFilters()
    begin
        if SalesCodeFilter <> '' then
          SetFilter("Vendor No.",SalesCodeFilter)
        else
          SetRange("Vendor No.");

        if ItemNoFilter <> '' then begin
          SetFilter("Item No.",ItemNoFilter);
        end else
          SetRange("Item No.");

        CalcTotals;

        CurrPage.Update(false);
    end;

    local procedure ItemNoFilterOnAfterValidate()
    begin
        CurrPage.SaveRecord;
        SetRecFilters;
    end;


    procedure GetVendorQuotes()
    begin
        //insert the quotes from vendors
        if RFQNoFilter = '' then Error('Specify the RFQ No.');

        PurchHeader.SetRange(PurchHeader."No.",RFQNoFilter);
        PurchHeader.FindSet;
        repeat
          PurchLines.Reset;
          PurchLines.SetRange("Document No.",PurchHeader."No.");
          if PurchLines.FindSet then
          repeat
            Init;
            "RFQ No.":=PurchHeader."No.";
            "RFQ Line No.":=PurchLines."Line No.";
            "Quote No.":=PurchLines."Document No.";
            "Vendor No.":=PurchLines."Buy-from Vendor No.";
            "Item No.":=PurchLines."No.";
            Description:=PurchLines.Description;
            Quantity:=PurchLines.Quantity;
            "Unit Of Measure":=PurchLines."Unit of Measure";
            Amount:=PurchLines."Direct Unit Cost";
            "Line Amount":=Quantity*Amount;
            Insert(true);
            InsertCount:=+1;
           until PurchLines.Next=0;
        until PurchHeader.Next=0;
        Message('%1 records have been inserted to the bid analysis');
    end;

    local procedure SalesCodeFilterOnAfterValidate()
    begin
        CurrPage.SaveRecord;
        SetRecFilters;
    end;


    procedure CalcTotals()
    var
        BidAnalysisRec: Record "Bid Analysis";
    begin
        BidAnalysisRec.SetRange("RFQ No.","RFQ No.");
        if SalesCodeFilter <>'' then
        BidAnalysisRec.SetRange("Vendor No.",SalesCodeFilter);
        if ItemNoFilter <> '' then
        BidAnalysisRec.SetRange("Item No.",ItemNoFilter);
        BidAnalysisRec.FindSet;
        BidAnalysisRec.CalcSums("Line Amount");
        Total:=BidAnalysisRec."Line Amount";
    end;
}

