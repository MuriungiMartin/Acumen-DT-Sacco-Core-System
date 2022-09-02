#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516100 "Purchase Quote Header"
{
    Caption = 'Purchase Header';
    LookupPageID = UnknownPage56069;

    fields
    {
        field(1;"Document Type";Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quotation Request,Open Tender,Restricted Tender';
            OptionMembers = "Quotation Request","Open Tender","Restricted Tender";
        }
        field(3;"No.";Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(11;"Your Reference";Text[30])
        {
            Caption = 'Your Reference';
        }
        field(12;"Ship-to Code";Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = Location.Code where ("Use As In-Transit"=const(false));

            trigger OnValidate()
            begin
                if "Ship-to Code"<>'' then begin
                  location.Get("Ship-to Code");
                    "Location Code":="Ship-to Code";
                    "Ship-to Name":=location.Name;
                    "Ship-to Name 2":=location."Name 2";
                    "Ship-to Address":=location.Address;
                    "Ship-to Address 2":=location."Address 2";
                    "Ship-to City":=location.City;
                    "Ship-to Contact":=location.Contact;
                end
            end;
        }
        field(13;"Ship-to Name";Text[50])
        {
            Caption = 'Ship-to Name';
        }
        field(14;"Ship-to Name 2";Text[50])
        {
            Caption = 'Ship-to Name 2';
        }
        field(15;"Ship-to Address";Text[50])
        {
            Caption = 'Ship-to Address';
        }
        field(16;"Ship-to Address 2";Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(17;"Ship-to City";Text[30])
        {
            Caption = 'Ship-to City';
        }
        field(18;"Ship-to Contact";Text[50])
        {
            Caption = 'Ship-to Contact';
        }
        field(19;"Expected Opening Date";Date)
        {
            Caption = 'Expected Opening Date';
        }
        field(20;"Posting Date";Date)
        {
            Caption = 'Posting Date';
        }
        field(21;"Expected Closing Date";Date)
        {
            Caption = 'Expected Closing Date';
        }
        field(22;"Posting Description";Text[50])
        {
            Caption = 'Posting Description';
        }
        field(23;"Payment Terms Code";Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(24;"Due Date";Date)
        {
            Caption = 'Due Date';
        }
        field(25;"Payment Discount %";Decimal)
        {
            Caption = 'Payment Discount %';
            DecimalPlaces = 0:5;
        }
        field(26;"Pmt. Discount Date";Date)
        {
            Caption = 'Pmt. Discount Date';
        }
        field(27;"Shipment Method Code";Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(28;"Location Code";Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where ("Use As In-Transit"=const(false));
        }
        field(29;"Shortcut Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));
        }
        field(30;"Shortcut Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(31;"Vendor Posting Group";Code[10])
        {
            Caption = 'Vendor Posting Group';
            Editable = false;
            TableRelation = "Vendor Posting Group";
        }
        field(32;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(33;"Currency Factor";Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0:15;
            Editable = false;
            MinValue = 0;
        }
        field(35;"Prices Including VAT";Boolean)
        {
            Caption = 'Prices Including VAT';

            trigger OnValidate()
            var
                PurchLine: Record "Purchase Line";
                Currency: Record Currency;
                RecalculatePrice: Boolean;
            begin
            end;
        }
        field(37;"Invoice Disc. Code";Code[20])
        {
            Caption = 'Invoice Disc. Code';
        }
        field(41;"Language Code";Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(43;"Purchaser Code";Code[10])
        {
            Caption = 'Purchaser Code';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                ApprovalEntry: Record "Approval Entry";
            begin
            end;
        }
        field(45;"Order Class";Code[10])
        {
            Caption = 'Order Class';
        }
        field(46;Comment;Boolean)
        {
            CalcFormula = exist("Purch. Comment Line" where ("Document Type"=field("Document Type"),
                                                             "No."=field("No."),
                                                             "Document Line No."=const(0)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47;"No. Printed";Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
        }
        field(51;"On Hold";Code[3])
        {
            Caption = 'On Hold';
        }
        field(52;"Applies-to Doc. Type";Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(53;"Applies-to Doc. No.";Code[20])
        {
            Caption = 'Applies-to Doc. No.';
        }
        field(55;"Bal. Account No.";Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = if ("Bal. Account Type"=const("G/L Account")) "G/L Account"
                            else if ("Bal. Account Type"=const("Bank Account")) "Bank Account";
        }
        field(57;Receive;Boolean)
        {
            Caption = 'Receive';
        }
        field(58;Invoice;Boolean)
        {
            Caption = 'Invoice';
        }
        field(60;Amount;Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line".Amount where ("Document Type"=field("Document Type"),
                                                            "Document No."=field("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61;"Amount Including VAT";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Amount Including VAT" where ("Document Type"=field("Document Type"),
                                                                            "Document No."=field("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62;"Receiving No.";Code[20])
        {
            Caption = 'Receiving No.';
        }
        field(63;"Posting No.";Code[20])
        {
            Caption = 'Posting No.';
        }
        field(64;"Last Receiving No.";Code[20])
        {
            Caption = 'Last Receiving No.';
            Editable = false;
            TableRelation = "Purch. Rcpt. Header";
        }
        field(65;"Last Posting No.";Code[20])
        {
            Caption = 'Last Posting No.';
            Editable = false;
            TableRelation = "Purch. Inv. Header";
        }
        field(73;"Reason Code";Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(74;"Gen. Bus. Posting Group";Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(76;"Transaction Type";Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(77;"Transport Method";Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(78;"VAT Country/Region Code";Code[10])
        {
            Caption = 'VAT Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(91;"Ship-to Post Code";Code[20])
        {
            Caption = 'Ship-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(92;"Ship-to County";Text[30])
        {
            Caption = 'Ship-to County';
        }
        field(93;"Ship-to Country/Region Code";Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(94;"Bal. Account Type";Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(95;"Order Address Code";Code[10])
        {
            Caption = 'Order Address Code';

            trigger OnValidate()
            var
                PayToVend: Record Vendor;
            begin
            end;
        }
        field(97;"Entry Point";Code[10])
        {
            Caption = 'Entry Point';
            TableRelation = "Entry/Exit Point";
        }
        field(98;Correction;Boolean)
        {
            Caption = 'Correction';
        }
        field(99;"Document Date";Date)
        {
            Caption = 'Document Date';
        }
        field(101;"Area";Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(102;"Transaction Specification";Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(104;"Payment Method Code";Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(107;"No. Series";Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108;"Posting No. Series";Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(109;"Receiving No. Series";Code[10])
        {
            Caption = 'Receiving No. Series';
            TableRelation = "No. Series";
        }
        field(114;"Tax Area Code";Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(115;"Tax Liable";Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(116;"VAT Bus. Posting Group";Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(118;"Applies-to ID";Code[20])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            var
                TempVendLedgEntry: Record "Vendor Ledger Entry";
            begin
            end;
        }
        field(119;"VAT Base Discount %";Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0:5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            var
                ChangeLogMgt: Codeunit "Change Log Management";
                RecRef: RecordRef;
                xRecRef: RecordRef;
            begin
            end;
        }
        field(120;Status;Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Closed,Cancelled,Stopped;
        }
        field(121;"Invoice Discount Calculation";Option)
        {
            Caption = 'Invoice Discount Calculation';
            Editable = false;
            OptionCaption = 'None,%,Amount';
            OptionMembers = "None","%",Amount;
        }
        field(122;"Invoice Discount Value";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Invoice Discount Value';
            Editable = false;
        }
        field(123;"Send IC Document";Boolean)
        {
            Caption = 'Send IC Document';
        }
        field(124;"IC Status";Option)
        {
            Caption = 'IC Status';
            OptionCaption = 'New,Pending,Sent';
            OptionMembers = New,Pending,Sent;
        }
        field(125;"Buy-from IC Partner Code";Code[20])
        {
            Caption = 'Buy-from IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(126;"Pay-to IC Partner Code";Code[20])
        {
            Caption = 'Pay-to IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(129;"IC Direction";Option)
        {
            Caption = 'IC Direction';
            OptionCaption = 'Outgoing,Incoming';
            OptionMembers = Outgoing,Incoming;
        }
        field(151;"Quote No.";Code[20])
        {
            Caption = 'Quote No.';
            Editable = false;
        }
        field(5043;"No. of Archived Versions";Integer)
        {
            CalcFormula = max("Purchase Header Archive"."Version No." where ("Document Type"=field("Document Type"),
                                                                             "No."=field("No."),
                                                                             "Doc. No. Occurrence"=field("Doc. No. Occurrence")));
            Caption = 'No. of Archived Versions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5048;"Doc. No. Occurrence";Integer)
        {
            Caption = 'Doc. No. Occurrence';
        }
        field(5050;"Campaign No.";Code[20])
        {
            Caption = 'Campaign No.';
            TableRelation = Campaign;
        }
        field(5052;"Buy-from Contact No.";Code[20])
        {
            Caption = 'Buy-from Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
            end;

            trigger OnValidate()
            var
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
            end;
        }
        field(5053;"Pay-to Contact No.";Code[20])
        {
            Caption = 'Pay-to Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
            end;

            trigger OnValidate()
            var
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
            end;
        }
        field(5700;"Responsibility Center";Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = Table56016;
        }
        field(5752;"Completely Received";Boolean)
        {
            CalcFormula = min("Purchase Line"."Completely Received" where ("Document Type"=field("Document Type"),
                                                                           "Document No."=field("No."),
                                                                           Type=filter(<>" "),
                                                                           "Location Code"=field("Location Filter")));
            Caption = 'Completely Received';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5753;"Posting from Whse. Ref.";Integer)
        {
            Caption = 'Posting from Whse. Ref.';
        }
        field(5754;"Location Filter";Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(5790;"Requested Receipt Date";Date)
        {
            Caption = 'Requested Receipt Date';
        }
        field(5791;"Promised Receipt Date";Date)
        {
            Caption = 'Promised Receipt Date';
        }
        field(5792;"Lead Time Calculation";DateFormula)
        {
            Caption = 'Lead Time Calculation';
        }
        field(5793;"Inbound Whse. Handling Time";DateFormula)
        {
            Caption = 'Inbound Whse. Handling Time';
        }
        field(5796;"Date Filter";Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5801;"Return Shipment No.";Code[20])
        {
            Caption = 'Return Shipment No.';
        }
        field(5802;"Return Shipment No. Series";Code[10])
        {
            Caption = 'Return Shipment No. Series';
            TableRelation = "No. Series";
        }
        field(5803;Ship;Boolean)
        {
            Caption = 'Ship';
        }
        field(5804;"Last Return Shipment No.";Code[20])
        {
            Caption = 'Last Return Shipment No.';
            Editable = false;
            TableRelation = "Return Shipment Header";
        }
        field(9000;"Assigned User ID";Code[50])
        {
            Caption = 'Assigned User ID';
            TableRelation = "User Setup";
        }
        field(54240;Copied;Boolean)
        {
        }
        field(54241;"Debit Note";Boolean)
        {
        }
        field(54243;"PRF No";Code[10])
        {
            TableRelation = "Purchase Header"."No." where ("Document Type"=const(Quote),
                                                           Status=filter(Released));

            trigger OnLookup()
            begin
                PurchHeader.Reset;
                PurchHeader.SetRange(PurchHeader."Document Type",PurchHeader."document type"::Quote);
                PurchHeader.SetRange(PurchHeader.DocApprovalType,PurchHeader.Docapprovaltype::Requisition);
                PurchHeader.SetRange(PurchHeader.Status,PurchHeader.Status::Released);
                if Page.RunModal(53,PurchHeader)=Action::LookupOK then
                begin
                  "PRF No":=PurchHeader."No.";
                  Validate("PRF No");
                end
            end;

            trigger OnValidate()
            begin
                  AutoPopPurchLine;
            end;
        }
        field(54244;"Released By";Code[50])
        {
        }
        field(54245;"Release Date";Date)
        {
        }
        field(55536;Cancelled;Boolean)
        {
        }
        field(55537;"Cancelled By";Code[50])
        {
        }
        field(55538;"Cancelled Date";Date)
        {
        }
        field(55539;DocApprovalType;Option)
        {
            OptionMembers = Purchase,Requisition,Quote;
        }
        field(55540;"Procurement Type Code";Code[20])
        {
            TableRelation = Transactions;
        }
        field(99008500;"Date Received";Date)
        {
            Caption = 'Date Received';
        }
        field(99008501;"Time Received";Time)
        {
            Caption = 'Time Received';
        }
        field(99008504;"BizTalk Purchase Quote";Boolean)
        {
            Caption = 'BizTalk Purchase Quote';
        }
        field(99008505;"BizTalk Purch. Order Cnfmn.";Boolean)
        {
            Caption = 'BizTalk Purch. Order Cnfmn.';
        }
        field(99008506;"BizTalk Purchase Invoice";Boolean)
        {
            Caption = 'BizTalk Purchase Invoice';
        }
        field(99008507;"BizTalk Purchase Receipt";Boolean)
        {
            Caption = 'BizTalk Purchase Receipt';
        }
        field(99008508;"BizTalk Purchase Credit Memo";Boolean)
        {
            Caption = 'BizTalk Purchase Credit Memo';
        }
        field(99008509;"Date Sent";Date)
        {
            Caption = 'Date Sent';
        }
        field(99008510;"Time Sent";Time)
        {
            Caption = 'Time Sent';
        }
        field(99008511;"BizTalk Request for Purch. Qte";Boolean)
        {
            Caption = 'BizTalk Request for Purch. Qte';
        }
        field(99008512;"BizTalk Purchase Order";Boolean)
        {
            Caption = 'BizTalk Purchase Order';
        }
        field(99008520;"Vendor Quote No.";Code[20])
        {
            Caption = 'Vendor Quote No.';
        }
        field(99008521;"BizTalk Document Sent";Boolean)
        {
            Caption = 'BizTalk Document Sent';
        }
    }

    keys
    {
        key(Key1;"Document Type","No.")
        {
            Clustered = true;
        }
        key(Key2;"No.","Document Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Check if the number has been inserted by the user
        if "No."='' then
          begin
            PurchSetup.Reset;
            PurchSetup.Get();
            PurchSetup.TestField(PurchSetup."Quotation Request No");
            NoSeriesMgt.InitSeries(PurchSetup."Quotation Request No",xRec."No. Series",Today,"No.","No. Series");
          end;
    end;

    trigger OnModify()
    begin
        if xRec."No."<>"No." then
          begin
            PurchSetup.Get();
            NoSeriesMgt.TestManual(PurchSetup."Quotation Request No");
          end;
    end;

    var
        Text000: label 'Do you want to print receipt %1?';
        Text001: label 'Do you want to print invoice %1?';
        Text002: label 'Do you want to print credit memo %1?';
        Text003: label 'You cannot rename a %1.';
        Text004: label 'Do you want to change %1?';
        Text005: label 'You cannot reset %1 because the document still has one or more lines.';
        Text006: label 'You cannot change %1 because the order is associated with one or more sales orders.';
        Text007: label '%1 is greater than %2 in the %3 table.\';
        Text008: label 'Confirm change?';
        Text009: label 'Deleting this document will cause a gap in the number series for receipts. ';
        Text010: label 'An empty receipt %1 will be created to fill this gap in the number series.\\';
        Text011: label 'Do you want to continue?';
        Text012: label 'Deleting this document will cause a gap in the number series for posted invoices. ';
        Text013: label 'An empty posted invoice %1 will be created to fill this gap in the number series.\\';
        Text014: label 'Deleting this document will cause a gap in the number series for posted credit memos. ';
        Text015: label 'An empty posted credit memo %1 will be created to fill this gap in the number series.\\';
        Text016: label 'If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created.\\';
        Text018: label 'You must delete the existing purchase lines before you can change %1.';
        Text019: label 'You have changed %1 on the purchase header, but it has not been changed on the existing purchase lines.\';
        Text020: label 'You must update the existing purchase lines manually.';
        Text021: label 'The change may affect the exchange rate used on the price calculation of the purchase lines.';
        Text022: label 'Do you want to update the exchange rate?';
        Text023: label 'You cannot delete this document. Your identification is set up to process from %1 %2 only.';
        Text024: label 'Do you want to print return shipment %1?';
        Text025: label 'You have modified the %1 field. Note that the recalculation of VAT may cause penny differences, so you must check the amounts afterwards. ';
        Text027: label 'Do you want to update the %2 field on the lines to reflect the new value of %1?';
        Text028: label 'Your identification is set up to process from %1 %2 only.';
        Text029: label 'Deleting this document will cause a gap in the number series for return shipments. ';
        Text030: label 'An empty return shipment %1 will be created to fill this gap in the number series.\\';
        Text032: label 'You have modified %1.\\';
        Text033: label 'Do you want to update the lines?';
        Text034: label 'You cannot change the %1 when the %2 has been filled in.';
        Text037: label 'Contact %1 %2 is not related to vendor %3.';
        Text038: label 'Contact %1 %2 is related to a different company than vendor %3.';
        Text039: label 'Contact %1 %2 is not related to a vendor.';
        Text040: label 'You can not change the %1 field because %2 %3 has %4 = %5 and the %6 has already been assigned %7 %8.';
        Text041: label 'The purchase %1 %2 has item tracking. Do you want to delete it anyway?';
        Text042: label 'You must cancel the approval process if you wish to change the %1.';
        Text043: label 'Do you want to print prepayment invoice %1?';
        Text044: label 'Do you want to print prepayment credit memo %1?';
        Text045: label 'Deleting this document will cause a gap in the number series for prepayment invoices. ';
        Text046: label 'An empty prepayment invoice %1 will be created to fill this gap in the number series.\\';
        Text047: label 'Deleting this document will cause a gap in the number series for prepayment credit memos. ';
        Text049: label '%1 is set up to process from %2 %3 only.';
        Text050: label 'Reservations exist for this order. These reservations will be canceled if a date conflict is caused by this change.\\';
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        location: Record Location;
        PurchHeader: Record "Purchase Header";


    procedure AutoPopPurchLine()
    var
        reqLine: Record "Purchase Line";
        PurchLine2: Record "Purchase Quote Line";
        LineNo: Integer;
        delReqLine: Record "Purchase Quote Line";
    begin
        PurchLine2.SetRange("Document Type","Document Type");
        PurchLine2.SetRange("Document No.","No.");
        PurchLine2.DeleteAll;
        PurchLine2.Reset;

        //reqLine.SETRANGE(reqLine."Document Type","Document Type");
        reqLine.SetRange(reqLine."Document No.","PRF No");

        if reqLine.Find('-') then
         begin
          PurchLine2.Init;
          repeat
           if reqLine.Quantity<>0 then
           begin
             LineNo:=LineNo+1000;
             PurchLine2."Document Type":="Document Type";
             PurchLine2.Validate("Document Type");
             PurchLine2."Document No.":="No.";
             PurchLine2.Validate("Document No.");
             PurchLine2."Line No.":=LineNo;
             PurchLine2.Type:=reqLine.Type;
             PurchLine2."Expense Code":=reqLine."Expense Code";    //Denno added---
             PurchLine2."No.":=reqLine."No.";
             PurchLine2.Validate("No.");
             PurchLine2.Description:=reqLine.Description;
             PurchLine2.Quantity:=reqLine.Quantity;
             PurchLine2.Validate(Quantity);
             PurchLine2."Unit of Measure Code":=reqLine."Unit of Measure Code";
             PurchLine2.Validate("Unit of Measure Code");
             PurchLine2."Unit of Measure":=reqLine."Unit of Measure";
             PurchLine2."Direct Unit Cost":=reqLine."Direct Unit Cost";
             PurchLine2.Validate("Direct Unit Cost");
             PurchLine2."Location Code":=reqLine."Location Code";
             PurchLine2."Location Code":="Location Code";
             PurchLine2."Shortcut Dimension 1 Code":="Shortcut Dimension 1 Code";
             PurchLine2."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
             PurchLine2.Insert(true);
           end
          until reqLine.Next=0;
         end;
    end;
}

