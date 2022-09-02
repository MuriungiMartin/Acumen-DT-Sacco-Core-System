#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 55482 "Doc CancelMgt"
{

    trigger OnRun()
    begin
    end;


    procedure CanceSalesDoc(var Rec: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        ReleaseDoc: Codeunit "Release Sales Document";
        ArchiveManagement: Codeunit ArchiveManagement;
    begin
        //This function cancels a sales document irrespective of the type
        //Author:Obara Jackson Odhiambo
        //Date:10th Dec 2008
        //COPYRIGHT:KOGELO DEVELOPERS
        Rec.TestField(Rec.Status,Rec.Status::Released);
        Rec.TestField(Rec.Cancelled,false);
        Rec.Mark:=true;

        //new addition
          ArchiveManagement.ArchSalesDocumentNoConfirm(Rec);

        ReleaseDoc.PerformManualReopen(Rec);
        with Rec do begin

          SalesLine.Reset;
          SalesLine.SetRange(SalesLine."Document Type","Document Type");
          SalesLine.SetRange(SalesLine."Document No.","No.");
          if SalesLine.Count >0 then begin
              SalesLine.FindFirst();
              repeat
                //check qty shipped
                if SalesLine."Quantity Shipped"<>0 then
                  begin
                    SalesLine.Quantity:=SalesLine."Quantity Shipped";
                  end
                else
                  begin
                    SalesLine.Quantity:=0;
                    SalesLine.Validate(SalesLine.Quantity);
                  end;
                    SalesLine."Qty. to Ship":=0;
                    SalesLine."Qty. to Invoice":=0;
                    SalesLine.Modify;
              until SalesLine.Next=0;
            end;
        //update the document to show that it was cancelled
        Cancelled:=true;
        "Cancelled By":=UserId;
        "Cancelled Date":=Today;
        Modify;
        end;

        //ReleaseDoc.PerformManualRelease(Rec);
    end;


    procedure CancelPurchaseDoc(var Rec: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        ReleaseDoc: Codeunit "Release Purchase Document";
        ArchiveManagement: Codeunit ArchiveManagement;
    begin
        //This function cancels a sales document irrespective of the type
        //Author:Obara Jackson Odhiambo
        //Date:10th Dec 2008
        //COPYRIGHT:KOGELO DEVELOPERS

        Rec.TestField(Rec.Status,Rec.Status::Released);
        Rec.TestField(Rec.Cancelled,false);

        Rec.Mark:=true;

        //ReleaseDoc.PerformManualRelease(Rec);
        ArchiveManagement.ArchPurchDocumentNoConfirm(Rec);

        ReleaseDoc.PerformManualReopen(Rec);
        with Rec do begin

          PurchLine.Reset;
          PurchLine.SetRange(PurchLine."Document Type","Document Type");
          PurchLine.SetRange(PurchLine."Document No.","No.");
          if PurchLine.Count >0 then begin
              PurchLine.FindFirst();
              repeat
                //check qty shipped
                if PurchLine."Quantity Received"<>0 then
                  begin
                    PurchLine.Quantity:=PurchLine."Quantity Received";
                  end
                else
                  begin
                    PurchLine.Quantity:=0;
                  end;
                    PurchLine."Qty. to Receive":=0;
                    PurchLine."Qty. to Invoice":=0;
                    PurchLine.Modify;
              until PurchLine.Next=0;
            end;
        Cancelled:=true;
        "Cancelled By":=UserId;
        "Cancelled Date":=Today;
        Modify;
        end;
    end;
}

