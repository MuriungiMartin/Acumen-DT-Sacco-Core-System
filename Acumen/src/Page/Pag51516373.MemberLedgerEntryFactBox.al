#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516373 "Cust. Ledger Entry FactBox"
{
    Caption = 'Cust. Ledger Entry Details';
    PageType = CardPart;
    SourceTable = "Cust. Ledger Entry";

    layout
    {
        area(content)
        {
            field(DocumentHeading; DocumentHeading)
            {
                ApplicationArea = Basic;
                Caption = 'Document';
                DrillDown = true;

                trigger OnDrillDown()
                var
                    SalesInvoiceHdr: Record "Sales Invoice Header";
                    SalesCrMemoHdr: Record "Sales Cr.Memo Header";
                    GLEntry: Record "G/L Entry";
                    PostedSalesInvoiceCard: Page "Posted Sales Invoice";
                    PostedSalesCrMemoCard: Page "Posted Sales Credit Memo";
                    GeneralLedgEntriesList: Page "General Ledger Entries";
                    CheckGLEntry: Boolean;
                begin
                    CheckGLEntry := true;

                    if "Document Type" = "document type"::Invoice then begin
                        SalesInvoiceHdr.SetRange("No.", "Document No.");
                        if SalesInvoiceHdr.FindFirst then begin
                            PostedSalesInvoiceCard.SetTableview(SalesInvoiceHdr);
                            PostedSalesInvoiceCard.Run;
                            CheckGLEntry := false;
                        end
                    end;

                    if "Document Type" = "document type"::"Credit Memo" then begin
                        SalesCrMemoHdr.SetRange("No.", "Document No.");
                        if SalesCrMemoHdr.FindFirst then begin
                            PostedSalesCrMemoCard.SetTableview(SalesCrMemoHdr);
                            PostedSalesCrMemoCard.Run;
                            CheckGLEntry := false;
                        end
                    end;

                    if CheckGLEntry then begin
                        GLEntry.SetCurrentkey("Document No.", "Posting Date");
                        GLEntry.SetRange("Document No.", "Document No.");
                        GLEntry.SetRange("Posting Date", "Posting Date");
                        GeneralLedgEntriesList.SetTableview(GLEntry);
                        GeneralLedgEntriesList.Run
                    end;
                end;
            }
            field("Due Date"; "Due Date")
            {
                ApplicationArea = Basic;
            }
            field("Pmt. Discount Date"; "Pmt. Discount Date")
            {
                ApplicationArea = Basic;
            }
            field(NoOfReminderFinEntries; NoOfReminderFinEntries)
            {
                ApplicationArea = Basic;
                Caption = 'Reminder/Fin. Charge Entries';
                DrillDown = true;

                trigger OnDrillDown()
                var
                    ReminderFinEntry: Record "Reminder/Fin. Charge Entry";
                    ReminderFinEntriesList: Page "Reminder/Fin. Charge Entries";
                begin
                    ReminderFinEntry.SetRange("Customer Entry No.", "Entry No.");
                    ReminderFinEntriesList.SetTableview(ReminderFinEntry);
                    ReminderFinEntriesList.Run;
                end;
            }
            field(NoOfAppliedEntries; NoOfAppliedEntries)
            {
                ApplicationArea = Basic;
                Caption = 'Applied Entries';
                DrillDown = true;

                trigger OnDrillDown()
                var
                    AppliedCustomerEntriesList: Page "Applied Customer Entries";
                begin
                    AppliedCustomerEntriesList.SetTempCustLedgEntry("Entry No.");
                    AppliedCustomerEntriesList.Run;
                end;
            }
            field(NoOfDetailedCustomerEntries; NoOfDetailedCustomerEntries)
            {
                ApplicationArea = Basic;
                Caption = 'Detailed Ledger Entries';
                DrillDown = true;

                trigger OnDrillDown()
                var
                    DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                begin
                    DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", "Entry No.");
                    DetailedCustLedgEntry.SetRange("Customer No.", "Customer No.");
                    Page.Run(Page::"Detailed Cust. Ledg. Entries", DetailedCustLedgEntry);
                end;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        DocumentHeading := GetDocumentHeading(Rec);
        CalcNoOfRecords;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        NoOfReminderFinEntries := 0;
        NoOfAppliedEntries := 0;
        DocumentHeading := '';

        exit(Find(Which));
    end;

    trigger OnOpenPage()
    begin
        DocumentHeading := GetDocumentHeading(Rec);
        CalcNoOfRecords;
    end;

    var
        NoOfReminderFinEntries: Integer;
        NoOfAppliedEntries: Integer;
        NoOfDetailedCustomerEntries: Integer;
        DocumentHeading: Text[250];
        Text000: label 'Document';


    procedure CalcNoOfRecords()
    var
        ReminderFinChargeEntry: Record "Reminder/Fin. Charge Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        ReminderFinChargeEntry.Reset;
        ReminderFinChargeEntry.SetRange("Customer Entry No.", "Entry No.");
        NoOfReminderFinEntries := ReminderFinChargeEntry.Count;

        NoOfAppliedEntries := 0;
        if "Entry No." <> 0 then
            NoOfAppliedEntries := GetNoOfAppliedEntries(Rec);

        DetailedCustLedgEntry.Reset;
        DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", "Entry No.");
        DetailedCustLedgEntry.SetRange("Customer No.", "Customer No.");
        NoOfDetailedCustomerEntries := DetailedCustLedgEntry.Count;
    end;


    procedure GetNoOfAppliedEntries(CustLedgerEntry: Record "Cust. Ledger Entry"): Integer
    begin
        GetAppliedEntries(CustLedgerEntry);
        exit(CustLedgerEntry.Count);
    end;


    procedure GetAppliedEntries(var CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        DtldCustLedgEntry1: Record "Detailed Cust. Ledg. Entry";
        DtldCustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
        CreateCustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CreateCustLedgEntry := CustLedgerEntry;

        DtldCustLedgEntry1.SetCurrentkey("Cust. Ledger Entry No.");
        DtldCustLedgEntry1.SetRange("Cust. Ledger Entry No.", CreateCustLedgEntry."Entry No.");
        DtldCustLedgEntry1.SetRange(Unapplied, false);
        if DtldCustLedgEntry1.FindSet then
            repeat
                if DtldCustLedgEntry1."Cust. Ledger Entry No." =
                   DtldCustLedgEntry1."Applied Cust. Ledger Entry No."
                then begin
                    DtldCustLedgEntry2.Init;
                    DtldCustLedgEntry2.SetCurrentkey("Applied Cust. Ledger Entry No.", "Entry Type");
                    DtldCustLedgEntry2.SetRange(
                      "Applied Cust. Ledger Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    DtldCustLedgEntry2.SetRange("Entry Type", DtldCustLedgEntry2."entry type"::Application);
                    DtldCustLedgEntry2.SetRange(Unapplied, false);
                    if DtldCustLedgEntry2.Find('-') then
                        repeat
                            if DtldCustLedgEntry2."Cust. Ledger Entry No." <>
                               DtldCustLedgEntry2."Applied Cust. Ledger Entry No."
                            then begin
                                CustLedgerEntry.SetCurrentkey("Entry No.");
                                CustLedgerEntry.SetRange("Entry No.", DtldCustLedgEntry2."Cust. Ledger Entry No.");
                                if CustLedgerEntry.FindFirst then
                                    CustLedgerEntry.Mark(true);
                            end;
                        until DtldCustLedgEntry2.Next = 0;
                end else begin
                    CustLedgerEntry.SetCurrentkey("Entry No.");
                    CustLedgerEntry.SetRange("Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    if CustLedgerEntry.FindFirst then
                        CustLedgerEntry.Mark(true);
                end;
            until DtldCustLedgEntry1.Next = 0;

        CustLedgerEntry.SetCurrentkey("Entry No.");
        CustLedgerEntry.SetRange("Entry No.");

        if CreateCustLedgEntry."Closed by Entry No." <> 0 then begin
            CustLedgerEntry."Entry No." := CreateCustLedgEntry."Closed by Entry No.";
            CustLedgerEntry.Mark(true);
        end;

        CustLedgerEntry.SetCurrentkey("Closed by Entry No.");
        CustLedgerEntry.SetRange("Closed by Entry No.", CreateCustLedgEntry."Entry No.");
        if CustLedgerEntry.FindSet then
            repeat
                CustLedgerEntry.Mark(true);
            until CustLedgerEntry.Next = 0;

        CustLedgerEntry.SetCurrentkey("Entry No.");
        CustLedgerEntry.SetRange("Closed by Entry No.");

        CustLedgerEntry.MarkedOnly(true);
    end;


    procedure GetDocumentHeading(CustLedgerEntry: Record "Cust. Ledger Entry"): Text[50]
    var
        Heading: Text[50];
    begin
        if CustLedgerEntry."Document Type" = 0 then
            Heading := Text000
        else
            Heading := Format(CustLedgerEntry."Document Type");
        Heading := Heading + ' ' + CustLedgerEntry."Document No.";
        exit(Heading);
    end;
}

