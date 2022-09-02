#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516344 "Inspection Header"
{

    fields
    {
        field(1;"No.";Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                  PurchPayblesSetup.Get;
                  NoSeriesMgt.TestManual(PurchPayblesSetup."Inspection Nos");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Purchase Order No.";Code[10])
        {
            TableRelation = "Purch. Rcpt. Header"."Order No.";

            trigger OnValidate()
            begin
                
                 PurchHeaderNo := "Purchase Order No.";
                
                 //Populate header
                 PostedPurchaseHeader.Reset;
                 PostedPurchaseHeader.SetRange(PostedPurchaseHeader."Order No.","Purchase Order No.");
                 if PostedPurchaseHeader.Find('-') then begin
                
                      "Supplier No." := PostedPurchaseHeader."Buy-from Vendor No.";
                      "Supplier Name" := PostedPurchaseHeader."Pay-to Name";
                      "Date Received" := PostedPurchaseHeader."Posting Date";
                       Department := PostedPurchaseHeader."Responsibility Center";
                       "ReceiptNo." := PostedPurchaseHeader."No.";
                
                  end;
                
                  //Populate Lines
                  PostedPurchaseLine.Reset;
                  PostedPurchaseLine.SetRange(PostedPurchaseLine."Document No.","ReceiptNo.");
                  if PostedPurchaseLine.Find('-') then begin
                  //Delete any existing inspection lines with this document no.
                  InspectionLine.SetRange(InspectionLine."Document No.","No.");
                  if InspectionLine.Find('-') then begin
                  Error('All lines must first be deleted before changing Order No. ');
                   /*InspectionLine.DELETEALL;
                  InspectionLine.MODIFY;*/
                  //InspectionLine.INSERT;
                
                  end;
                         PurchLine.Reset;
                         PurchLine.SetRange(PurchLine."Document No.",PurchHeaderNo);
                          repeat
                
                               InspectionLine.Init;
                               InspectionLine."Purchase Order No." :=  PurchHeaderNo;
                               InspectionLine.Description := PostedPurchaseLine.Description;
                               InspectionLine."Receipt Voucher No." := PostedPurchaseLine."Document No.";
                               //InspectionLine."Quantity Ordered" := PostedPurchaseLine.Quantity;
                               InspectionLine."Document No." := "No.";
                               //InspectionLine."Delivery Note" :=
                
                               //************Get quantity from posted purchase line **************************
                
                               PurchLine.Next;
                               InspectionLine."Quantity Ordered" := PurchLine.Quantity;
                
                               InspectionLine.Insert;
                          until PostedPurchaseLine.Next = 0;
                  end;

            end;
        }
        field(3;"Supplier No.";Code[10])
        {
        }
        field(4;"Supplier Name";Text[50])
        {
        }
        field(5;"Date Received";Date)
        {
        }
        field(6;"Time Out";Date)
        {
        }
        field(7;Department;Text[30])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(3));
        }
        field(8;"ReceiptNo.";Code[20])
        {
        }
        field(9;"No. Series";Code[20])
        {
        }
        field(10;Status;Option)
        {
            OptionCaption = 'Open,Released,Pending Approval,Approved';
            OptionMembers = Open,Released,"Pending Approval",Approved;
        }
        field(11;"Responsibility Center";Code[20])
        {
            TableRelation = "Responsibility Center BR";
        }
        field(12;"Time In";Time)
        {
        }
        field(13;"Time Out.";Time)
        {
        }
    }

    keys
    {
        key(Key1;"No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchPayablesSetup: Record "Purchases & Payables Setup";
    begin
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
          PurchPayblesSetup.Get;;
          PurchPayblesSetup.TestField(PurchPayblesSetup."Inspection Nos");
          NoSeriesMgt.InitSeries(PurchPayblesSetup."Inspection Nos",xRec."No. Series",0D,"No.","No. Series");
        end;
    end;

    var
        PostedPurchaseHeader: Record "Purch. Rcpt. Header";
        PostedPurchaseLine: Record "Purch. Rcpt. Line";
        InspectionLine: Record "Inspection Line";
        PurchHeaderNo: Code[20];
        PurchPayblesSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchLine: Record "Purchase Line Replica";
}

