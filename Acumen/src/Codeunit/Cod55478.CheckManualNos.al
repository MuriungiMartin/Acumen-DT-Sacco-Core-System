#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 55478 "Check Manual Nos"
{

    trigger OnRun()
    begin
    end;


    procedure SalesOrderNoUsed(var OrderNo: Code[20]) Used: Boolean
    var
        SalesInvHeader: Record "Sales Invoice Header";
    begin
        //check if the order number has already been used within the system
        Used:=false;
        SalesInvHeader.Reset;
        SalesInvHeader.SetRange(SalesInvHeader."Order No.",OrderNo);
        if SalesInvHeader.Count >0 then
          begin
            Used:= true;
          end
        else
          begin
            Used:= false;
          end;
    end;


    procedure InvoiceNoUsed(var InvoiceNo: Code[20]) Used: Boolean
    var
        SalesInvHeader: Record "Sales Invoice Header";
    begin
        //check if the order number has already been used within the system
        Used:=false;
        SalesInvHeader.Reset;
        SalesInvHeader.SetRange(SalesInvHeader."Pre-Assigned No.",InvoiceNo);
        if SalesInvHeader.Count >0 then
          begin
            Used:= true;
          end
        else
          begin
            Used:= false;
          end;
    end;


    procedure CreditMemoUsed(var CrMemoNo: Code[20]) Used: Boolean
    var
        SalesCrMemo: Record "Sales Cr.Memo Header";
    begin
        //check if the credit memo number has already been used within the system
        Used:=false;
        SalesCrMemo.Reset;
        SalesCrMemo.SetRange(SalesCrMemo."Pre-Assigned No.",CrMemoNo);
        if SalesCrMemo.Count >0 then
          begin
            Used:=true;
          end
        else
          begin
            Used:=false;
          end;
    end;


    procedure SalesReturnNoUsed(var ReturnNo: Code[20]) Used: Boolean
    var
        SalesReturn: Record "Return Receipt Header";
    begin
        //check if the sales return order has been used in the system
        Used:=false;
        SalesReturn.Reset;
        SalesReturn.SetRange(SalesReturn."Return Order No.",ReturnNo);
        if SalesReturn.Count >0 then
          begin
            Used:=true;
          end
        else
          begin
            Used:=false;
          end;
    end;


    procedure WhsePostedShipmentNoUsed(var ShipNo: Code[20]) Used: Boolean
    var
        PostedWhseShpmtHeader: Record "Posted Whse. Shipment Header";
    begin
        //check if the warehouse shipment header no has already been used
        Used:=false;
        PostedWhseShpmtHeader.Reset;
        PostedWhseShpmtHeader.SetRange(PostedWhseShpmtHeader."Whse. Shipment No.",ShipNo);
        if PostedWhseShpmtHeader.Count >0 then
          begin
            Used:=true;
          end
        else
          begin
            Used:=false;
          end;
    end;


    procedure WhsePostedReceiptNoUsed(var ReceiptNo: Code[20]) Used: Boolean
    var
        WhsePostedRcptHeader: Record "Posted Whse. Receipt Header";
    begin
        //check if the warehuse receipt number has already been used
        Used:=false;
        WhsePostedRcptHeader.Reset;
        WhsePostedRcptHeader.SetRange(WhsePostedRcptHeader."Whse. Receipt No.",ReceiptNo);
        if WhsePostedRcptHeader.Count>0 then
          begin
            Used:=true;
          end
        else
          begin
            Used:=false;
          end;
    end;


    procedure TransferOrderNoUsed(var TransferOrderNo: Code[20]) Used: Boolean
    var
        TransferReceipt: Record "Transfer Receipt Header";
        TransferShipment: Record "Transfer Shipment Header";
    begin
        //check if the transfer order number has already been used
        Used:=false;
        TransferReceipt.Reset;
        TransferReceipt.SetRange(TransferReceipt."Transfer Order No.",TransferOrderNo);
        if TransferReceipt.Count >0 then
          begin
            Used:=true;
          end
        else
          begin
            Used:=false;
          end;

        TransferShipment.Reset;
        TransferShipment.SetRange(TransferShipment."Transfer Order No.",TransferOrderNo);
        if TransferShipment.Count >0 then
          begin
            Used:=true;
          end
        else
          begin
            Used:=false;
          end;
    end;


    procedure PurchaseOrderNoUsed(var PurchOrderNo: Code[20]) Used: Boolean
    var
        PurchInv: Record "Purch. Inv. Header";
    begin
        //check if the purchase order number has been used within the system
        Used:=false;
        PurchInv.Reset;
        PurchInv.SetRange(PurchInv."Order No.",PurchOrderNo);
        if PurchInv.Count >0 then
          begin
            Used:=true;
          end
        else
          begin
            Used:=false;
          end;
    end;


    procedure PurchaseInvoiceNoUsed(var InvoiceNo: Code[20]) Used: Boolean
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        //check if the purchase invoice number has been used within the system
        Used:=false;
        PurchInvHeader.Reset;
        PurchInvHeader.SetRange(PurchInvHeader."Pre-Assigned No.",InvoiceNo);
        if PurchInvHeader.Count >0 then
          begin
            Used:=true;
          end
        else
          begin
            Used:=false;
          end;
    end;


    procedure PurchaseReturnOrderNoUsed(var ReturnOrderNo: Code[20]) Used: Boolean
    var
        RetOrder: Record "Return Shipment Header";
    begin
        //check if the return order number has been used within the system
        Used:=false;
        RetOrder.Reset;
        RetOrder.SetRange(RetOrder."Return Order No.",ReturnOrderNo);
        if RetOrder.Count >0 then
          begin
            Used:=true;
          end
        else
          begin
            Used:=false;
          end;
    end;


    procedure PurchaseCreditMemoNoUsed(var CrMemoNo: Code[20]) Used: Boolean
    var
        CrMemo: Record "Purch. Cr. Memo Hdr.";
    begin
        //check if the credit memo number has already been used within the system
        Used:=false;
        CrMemo.Reset;
        CrMemo.SetRange(CrMemo."Pre-Assigned No.",CrMemoNo);
        if CrMemo.Count >0 then
          begin
            Used:=true;
          end
        else
          begin
            Used:=false;
          end;
    end;
}

