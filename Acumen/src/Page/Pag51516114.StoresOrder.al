#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516114 "Stores Order"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type"=const(Order));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Visible = DocNoVisible;

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                          CurrPage.Update;
                    end;
                }
                field("Buy-from Vendor No.";"Buy-from Vendor No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate;
                    end;
                }
                field("Buy-from Contact No.";"Buy-from Contact No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Buy-from Vendor Name";"Buy-from Vendor Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Buy-from Address";"Buy-from Address")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Buy-from Address 2";"Buy-from Address 2")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Buy-from Post Code";"Buy-from Post Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Buy-from City";"Buy-from City")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Buy-from Contact";"Buy-from Contact")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("No. of Archived Versions";"No. of Archived Versions")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Order Date";"Order Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Document Date";"Document Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Quote No.";"Quote No.")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Vendor Order No.";"Vendor Order No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Vendor Shipment No.";"Vendor Shipment No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Vendor Invoice No.";"Vendor Invoice No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    ShowMandatory = VendorInvoiceNoMandatory;
                }
                field("Receiving No.";"Receiving No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Order Address Code";"Order Address Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Purchaser Code";"Purchaser Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;

                    trigger OnValidate()
                    begin
                        PurchaserCodeOnAfterValidate;
                    end;
                }
                field("Responsibility Center";"Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Assigned User ID";"Assigned User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Job Queue Status";"Job Queue Status")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Requisition No.";"Requisition No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
            }
            part(PurchLines;"Purchase Order Subform")
            {
                SubPageLink = "Document No."=field("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Pay-to Vendor No.";"Pay-to Vendor No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate;
                    end;
                }
                field("Pay-to Contact No.";"Pay-to Contact No.")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Pay-to Name";"Pay-to Name")
                {
                    ApplicationArea = Basic;
                }
                field("Pay-to Address";"Pay-to Address")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Pay-to Address 2";"Pay-to Address 2")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Pay-to Post Code";"Pay-to Post Code")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Pay-to City";"Pay-to City")
                {
                    ApplicationArea = Basic;
                }
                field("Pay-to Contact";"Pay-to Contact")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code";"Payment Terms Code")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Visible = false;
                }
                field("Due Date";"Due Date")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Visible = false;
                }
                field("Payment Discount %";"Payment Discount %")
                {
                    ApplicationArea = Basic;
                }
                field("Pmt. Discount Date";"Pmt. Discount Date")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Payment Method Code";"Payment Method Code")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                    Visible = false;
                }
                field("Payment Reference";"Payment Reference")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Creditor No.";"Creditor No.")
                {
                    ApplicationArea = Basic;
                }
                field("On Hold";"On Hold")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Prices Including VAT";"Prices Including VAT")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group";"VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name";"Ship-to Name")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Address";"Ship-to Address")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Ship-to Address 2";"Ship-to Address 2")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Ship-to Post Code";"Ship-to Post Code")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Ship-to City";"Ship-to City")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Contact";"Ship-to Contact")
                {
                    ApplicationArea = Basic;
                }
                field("Location Code";"Location Code")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Inbound Whse. Handling Time";"Inbound Whse. Handling Time")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Shipment Method Code";"Shipment Method Code")
                {
                    ApplicationArea = Basic;
                }
                field("Lead Time Calculation";"Lead Time Calculation")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Requested Receipt Date";"Requested Receipt Date")
                {
                    ApplicationArea = Basic;
                }
                field("Promised Receipt Date";"Promised Receipt Date")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Receipt Date";"Expected Receipt Date")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Code";"Ship-to Code")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code";"Currency Code")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        Clear(ChangeExchangeRate);
                        if "Posting Date" <> 0D then
                          ChangeExchangeRate.SetParameter("Currency Code","Currency Factor","Posting Date")
                        else
                          ChangeExchangeRate.SetParameter("Currency Code","Currency Factor",WorkDate);
                        if ChangeExchangeRate.RunModal = Action::OK then begin
                          Validate("Currency Factor",ChangeExchangeRate.GetParameter);
                          CurrPage.Update;
                        end;
                        Clear(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0,Rec);
                    end;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Specification";"Transaction Specification")
                {
                    ApplicationArea = Basic;
                }
                field("Transport Method";"Transport Method")
                {
                    ApplicationArea = Basic;
                }
                field("Entry Point";"Entry Point")
                {
                    ApplicationArea = Basic;
                }
                field("Area";Area)
                {
                    ApplicationArea = Basic;
                }
            }
            group(Prepayment)
            {
                Caption = 'Prepayment';
                field("Prepayment %";"Prepayment %")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        Prepayment37OnAfterValidate;
                    end;
                }
                field("Compress Prepayment";"Compress Prepayment")
                {
                    ApplicationArea = Basic;
                }
                field("Prepmt. Payment Terms Code";"Prepmt. Payment Terms Code")
                {
                    ApplicationArea = Basic;
                }
                field("Prepayment Due Date";"Prepayment Due Date")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Prepmt. Payment Discount %";"Prepmt. Payment Discount %")
                {
                    ApplicationArea = Basic;
                }
                field("Prepmt. Pmt. Discount Date";"Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor Cr. Memo No.";"Vendor Cr. Memo No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control8;"Approval FactBox")
            {
                SubPageLink = "Table ID"=const(38),
                              "Document Type"=field("Document Type"),
                              "Document No."=field("No.");
                Visible = false;
            }
            part(Control7;"Vendor Details FactBox")
            {
                SubPageLink = "No."=field("Buy-from Vendor No.");
                Visible = false;
            }
            part(Control6;"Vendor Statistics FactBox")
            {
                SubPageLink = "No."=field("Buy-from Vendor No.");
                Visible = true;
            }
            part(Control5;"Vendor Hist. Buy-from FactBox")
            {
                SubPageLink = "No."=field("Buy-from Vendor No.");
                Visible = true;
            }
            part(Control3;"Vendor Hist. Pay-to FactBox")
            {
                SubPageLink = "No."=field("Pay-to Vendor No.");
                Visible = false;
            }
            systempart(Control2;Links)
            {
                Visible = false;
            }
            systempart(Control1;Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension=R;
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDocDim;
                        CurrPage.SaveRecord;
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        CalcInvDiscForHeader;
                        Commit;
                        Page.RunModal(Page::"Purchase Order Statistics",Rec);
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No."=field("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.Setfilters(Database::"Purchase Header","Document Type","No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type"=field("Document Type"),
                                  "No."=field("No."),
                                  "Document Line No."=const(0);
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action(Receipts)
                {
                    ApplicationArea = Basic;
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No."=field("No.");
                    RunPageView = sorting("Order No.");
                }
                action(Invoices)
                {
                    ApplicationArea = Basic;
                    Caption = 'Invoices';
                    Image = Invoice;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Order No."=field("No.");
                    RunPageView = sorting("Order No.");
                }
                action("Prepa&yment Invoices")
                {
                    ApplicationArea = Basic;
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Prepayment Order No."=field("No.");
                    RunPageView = sorting("Prepayment Order No.");
                }
                action("Prepayment Credi&t Memos")
                {
                    ApplicationArea = Basic;
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Purchase Credit Memos";
                    RunPageLink = "Prepayment Order No."=field("No.");
                    RunPageView = sorting("Prepayment Order No.");
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                separator(Action143)
                {
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = Basic;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document"=const("Purchase Order"),
                                  "Source No."=field("No.");
                    RunPageView = sorting("Source Document","Source No.","Location Code");
                }
                action("Whse. Receipt Lines")
                {
                    ApplicationArea = Basic;
                    Caption = 'Whse. Receipt Lines';
                    Image = ReceiptLines;
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type"=const(39),
                                  "Source Subtype"=field("Document Type"),
                                  "Source No."=field("No.");
                    RunPageView = sorting("Source Type","Source Subtype","Source No.","Source Line No.");
                }
                separator(Action140)
                {
                }
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action("Get &Sales Order")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action(Action136)
                    {
                        AccessByPermission = TableData "Sales Shipment Header"=R;
                        ApplicationArea = Basic;
                        Caption = 'Get &Sales Order';
                        Image = "Order";

                        trigger OnAction()
                        var
                            PurchHeader: Record "Purchase Header";
                            DistIntegration: Codeunit "Dist. Integration";
                        begin
                            PurchHeader.Copy(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
                }
            }
        }
        area(processing)
        {
            group(ActionGroup134)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                separator(Action133)
                {
                }
                action(Release)
                {
                    ApplicationArea = Basic;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(Action130)
                {
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData "Vendor Invoice Disc."=R;
                    ApplicationArea = Basic;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action("Get St&d. Vend. Purchase Codes")
                {
                    ApplicationArea = Basic;
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    Image = VendorCode;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                action(CopyDocument)
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RunModal;
                        Clear(CopyPurchDoc);
                    end;
                }
                action("Move Negative Lines")
                {
                    ApplicationArea = Basic;
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;

                    trigger OnAction()
                    begin
                        Clear(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RunModal;
                        MoveNegPurchLines.ShowDocument;
                    end;
                }
                action("Check Budget Committment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Check Budget Committment';
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        
                        BCSetup.Get;
                        if not BCSetup.Mandatory then
                           exit;
                        
                        if not CheckforRequiredFields then
                           Error('There might be some lines missing the key fields: [TYPE, NO.,AMOUNT] Please recheck your document lines');
                        
                        if Status=Status::Released then
                          Error('This document has already been released. This functionality is available for open documents only');
                        if SomeLinesCommitted then begin
                           if not Confirm( 'Some or All the Lines Are already Committed do you want to continue',true, "Document Type") then
                                Error('Budget Availability Check and Commitment Aborted');
                          DeleteCommitment.Reset;
                          DeleteCommitment.SetRange(DeleteCommitment."Document Type",DeleteCommitment."document type"::LPO);
                          DeleteCommitment.SetRange(DeleteCommitment."Document No.","No.");
                          DeleteCommitment.DeleteAll;
                        end;
                           Commitment.CheckPurchase(Rec);
                        
                        Message('Commitments done Successfully for Doc. No %1',"No.");
                        
                        
                        /*BCSetup.GET;
                        IF NOT BCSetup.Mandatory THEN
                           EXIT;
                        
                        IF NOT CheckforRequiredFields THEN
                           ERROR('There might be some lines missing the key fields: [TYPE, NO.,AMOUNT] Please recheck your document lines');
                        
                        IF Status=Status::Released THEN
                          ERROR('This document has already been released. This functionality is available for open documents only');
                        IF SomeLinesCommitted THEN BEGIN
                          ERROR('All Lines Are already Committed');
                           IF NOT CONFIRM( 'Some or All the Lines Are already Committed do you want to continue',TRUE, "Document Type") THEN
                                ERROR('Budget Availability Check and Commitment Aborted');
                          DeleteCommitment.RESET;
                          DeleteCommitment.SETRANGE(DeleteCommitment."Document Type",DeleteCommitment."Document Type"::LPO);
                          DeleteCommitment.SETRANGE(DeleteCommitment."Document No.","No.");
                          DeleteCommitment.DELETEALL;
                        END;
                           Commitment.CheckPurchase(Rec);
                        
                        MESSAGE('Commitments done Successfully for Doc. No %1',"No.");*/

                    end;
                }
                action("Cancel Budget Committment")
                {
                    ApplicationArea = Basic;
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                           if not Confirm( 'Are you sure you want to Cancel All Commitments Done for this document',true, "Document Type") then
                                Error('Budget Availability Check and Commitment Aborted');

                          DeleteCommitment.Reset;
                          DeleteCommitment.SetRange(DeleteCommitment."Document Type",DeleteCommitment."document type"::LPO);
                          DeleteCommitment.SetRange(DeleteCommitment."Document No.","No.");
                          DeleteCommitment.DeleteAll;
                          //Tag all the Purchase Line entries as Uncommitted
                          PurchLine.Reset;
                          PurchLine.SetRange(PurchLine."Document Type","Document Type");
                          PurchLine.SetRange(PurchLine."Document No.","No.");
                          if PurchLine.Find('-') then begin
                             repeat
                                PurchLine.Committed:=false;
                                PurchLine.Modify;
                             until PurchLine.Next=0;
                          end;

                        Message('Commitments Cancelled Successfully for Doc. No %1',"No.");
                    end;
                }
                group(ActionGroup122)
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action(Action121)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                    }
                }
                group(ActionGroup120)
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action(l8)
                    {
                        AccessByPermission = TableData "Sales Shipment Header"=R;
                        ApplicationArea = Basic;
                        Caption = 'l8';
                        Image = "Order";

                        trigger OnAction()
                        var
                            DistIntegration: Codeunit "Dist. Integration";
                            PurchHeader: Record "Purchase Header";
                        begin
                            PurchHeader.Copy(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
                }
                action("Archive Document")
                {
                    ApplicationArea = Basic;
                    Caption = 'Archi&ve Document';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.Update(false);

                        Archived:=true;
                        Modify;
                    end;
                }
                action("Send IC Purchase Order")
                {
                    AccessByPermission = TableData "IC G/L Account"=R;
                    ApplicationArea = Basic;
                    Caption = 'Send IC Purchase Order';
                    Image = IntercompanyOrder;

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                        SalesHeader: Record "Sales Header";
                    begin
                        //IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                         // ICInOutboxMgt.SendPurchDoc(Rec,FALSE);
                    end;
                }
                separator(Action116)
                {
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                Image = Approval;
                group(ActionGroup114)
                {
                    Caption = 'Approval';
                    Image = Approval;
                    action("Send A&pproval Request")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Send A&pproval Request';
                        Image = SendApprovalRequest;

                        trigger OnAction()
                        begin
                            if not SomeLinesCommitted then
                              Error('All Lines must be Committed before you send for Approval');


                            //IF ApprovalMgt.SendPurchaseApprovalRequest(Rec) THEN;
                        end;
                    }
                    action("Cancel Approval Re&quest")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cancel Approval Re&quest';
                        Image = Cancel;

                        trigger OnAction()
                        begin
                            //IF ApprovalMgt.CancelPurchaseApprovalRequest(Rec,TRUE,TRUE) THEN;
                        end;
                    }
                }
            }
            group(ActionGroup111)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create &Whse. Receipt")
                {
                    AccessByPermission = TableData "Warehouse Receipt Header"=R;
                    ApplicationArea = Basic;
                    Caption = 'Create &Whse. Receipt';
                    Image = NewReceipt;

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    begin
                        GetSourceDocInbound.CreateFromPurchOrder(Rec);

                        if not Find('=><') then
                          Init;
                    end;
                }
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData "Posted Invt. Put-away Header"=R;
                    ApplicationArea = Basic;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CreateInvtPutAwayPick;

                        if not Find('=><') then
                          Init;
                    end;
                }
                separator(Action108)
                {
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        if Archived=false then
                        Error ('Kindly Archive document for refferal later. Thanks');

                        Post(Codeunit::"Purch.-Post (Yes/No)");
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        if Archived=false then
                        Error ('Kindly Archive document for refferal later. Thanks');

                        Post(Codeunit::"Purch.-Post + Print");
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = Basic;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("Post &Batch")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        Report.RunModal(Report::"Batch Post Purchase Orders",true,true,Rec);
                        CurrPage.Update(false);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = Basic;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        CancelBackgroundPosting;
                    end;
                }
                action(ArchiveUnusedDoc)
                {
                    ApplicationArea = Basic;
                    Visible = false;

                    trigger OnAction()
                    begin
                        UserSet.Reset;
                        UserSet.SetRange(UserSet."Archiving User",UserId);
                        if not UserSet.Find('-' ) then
                        begin
                        Error('Sorry you have no permission to Arhchive Unused Order,');
                        end;
                        "Archive Unused Doc":=true;
                        Modify;
                    end;
                }
                separator(Action100)
                {
                }
                group("Prepa&yment")
                {
                    Caption = 'Prepa&yment';
                    Image = Prepayment;
                    action("Prepayment Test &Report")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Prepayment Test &Report';
                        Ellipsis = true;
                        Image = PrepaymentSimulation;

                        trigger OnAction()
                        begin
                            ReportPrint.PrintPurchHeaderPrepmt(Rec);
                        end;
                    }
                    action(PostPrepaymentInvoice)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Post Prepayment &Invoice';
                        Ellipsis = true;
                        Image = PrepaymentPost;

                        trigger OnAction()
                        var
                            SalesHeader: Record "Sales Header";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            //IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                             // PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec,FALSE);
                        end;
                    }
                    action("Post and Print Prepmt. Invoic&e")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Post and Print Prepmt. Invoic&e';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;

                        trigger OnAction()
                        var
                            SalesHeader: Record "Sales Header";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            //IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                              //PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec,TRUE);
                        end;
                    }
                    action(PostPrepaymentCreditMemo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Post Prepayment &Credit Memo';
                        Ellipsis = true;
                        Image = PrepaymentPost;

                        trigger OnAction()
                        var
                            SalesHeader: Record "Sales Header";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            //IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                              //PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec,FALSE);
                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Post and Print Prepmt. Cr. Mem&o';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;

                        trigger OnAction()
                        var
                            SalesHeader: Record "Sales Header";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            //IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                             // PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec,TRUE);
                        end;
                    }
                }
            }
            group(Print)
            {
                Caption = 'Print';
                Image = Print;
                action("&Print")
                {
                    ApplicationArea = Basic;
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                        /*PHeader.RESET;
                        PHeader.SETRANGE(PHeader."No.","No.");
                        IF PHeader.FINDFIRST THEN BEGIN
                          REPORT.RUN(51516360,TRUE,TRUE,PHeader);
                        END;*/
                        
                        PHeader.Reset;
                        PHeader.SetRange(PHeader."No.","No.");
                        if PHeader.FindFirst then begin
                          Report.Run(51516121,true,true,PHeader);
                        end;

                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        SetExtDocNoMandatoryCondition;
        if "Currency Code"='KES'  then begin
        "Currency Code":='';
        Modify;
        end;
    end;

    trigger OnOpenPage()
    begin
        SetDocNoVisible;
        if "Currency Code"='KES'  then begin
        "Currency Code":='';
        Modify;
        end;
    end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        [InDataSet]
        JobQueueVisible: Boolean;
        DocNoVisible: Boolean;
        VendorInvoiceNoMandatory: Boolean;
        BCSetup: Record "Budgetary Control Setup";
        AllFieldsEntered: Boolean;
        DeleteCommitment: Record Committment;
        Commitment: Codeunit "Budgetary Control";
        PurchLine: Record "Purchase Line";
        UserSet: Record "User Setup";
        PHeader: Record "Purchase Header";

    local procedure Post(PostingCodeunitID: Integer)
    begin
        SendToPosting(PostingCodeunitID);
        if "Job Queue Status" = "job queue status"::"Scheduled for Posting" then
          CurrPage.Close;
        CurrPage.Update(false);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.Page.ApproveCalcInvDisc;
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        if GetFilter("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
          if "Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
            SetRange("Buy-from Vendor No.");
        CurrPage.Update;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.Page.UpdateForm(true);
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.Update;
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.Update;
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.Update;
    end;

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(Doctype::Order,"No.");
    end;

    local procedure SetExtDocNoMandatoryCondition()
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchasesPayablesSetup.Get;
        VendorInvoiceNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory"
    end;


    procedure CheckforRequiredFields(): Boolean
    var
        PurchLine: Record "Purchase Line";
    begin
           AllFieldsEntered:=true;
           PurchLine.Reset;
           PurchLine.SetRange(PurchLine."Document Type","Document Type");
           PurchLine.SetRange(PurchLine."Document No.","No.");
           if PurchLine.Find('-') then begin
              repeat
                 if (PurchLine.Type=PurchLine.Type::" ") or (PurchLine."No." ='') or (PurchLine."Line Amount"=0) then
                    AllFieldsEntered:=false;
             until PurchLine.Next=0;
             exit(AllFieldsEntered)
           end;
    end;


    procedure SomeLinesCommitted() Exists: Boolean
    var
        PurchLines: Record "Purchase Line";
    begin
        if BCSetup.Get then begin
         Exists:=false;
         PurchLines.Reset;
         PurchLines.SetRange(PurchLines."Document Type","Document Type");
         PurchLines.SetRange(PurchLines."Document No.","No.");
         PurchLines.SetRange(PurchLines.Committed,true);
          if PurchLines.Find('-') then
             Exists:=true
            else
            Exists:=false;
         end;
    end;
}

