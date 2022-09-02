tableextension 50011 "PurchaseheaderEXT" extends "Purchase Header"
{
    fields
    {
        // Add changes to table fields here

        field(50000; Copied; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Debit Note"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Request for Quote No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Added this field';
            TableRelation = "Purchase Quote Line"."Document No." where("Prepayment Tax Group Code" = const('1'));

            trigger OnLookup()
            begin

                //REMOVE PREVIOUS DOCUMENT FILTERS.
                RFQVendors.Reset;

                //filter records in the Quotation Request Vendors Table(RFQVendors) according to the current "buy from vendor" selected by the user
                RFQVendors.SetFilter(RFQVendors."Vendor No.", "Buy-from Vendor No.");

                // IF PAGE.RUN(54386,RFQVendors)=ACTION::LookupOK THEN
                begin
                    "Request for Quote No." := RFQVendors."Requisition Document No.";
                    Validate("Request for Quote No.");
                end;
            end;

            trigger OnValidate()
            begin

                //CHECK WHETHER HAS LINES AND DELETE
                if not Confirm('If you change the Request for Quote No. the current lines will be deleted. Do you want to continue?', false) then
                    Error('You have selected to abort the process');
                PurchLine.Reset;
                PurchLine.SetRange(PurchLine."Document No.", "No.");

                if PurchLine.Find('-') then
                    PurchLine.DeleteAll;


                //POPULATTE PURCHASE LINE WHEN USER SELECTS RFQ.
                RFQ.Reset;

                RFQ.SetRange("Document No.", "Request for Quote No.");
                if RFQ.Find('-') then begin
                    repeat
                        PurchLine2.Init;

                        LineNo := LineNo + 1000;
                        PurchLine2."Document Type" := "Document Type";
                        PurchLine2.Validate("Document Type");
                        PurchLine2."Document No." := "No.";
                        PurchLine2.Validate("Document No.");
                        PurchLine2."Line No." := LineNo;
                        PurchLine2.Type := RFQ.Type;
                        PurchLine2."No." := RFQ."No.";
                        PurchLine2.Validate("No.");
                        PurchLine2.Description := RFQ.Description;
                        PurchLine2."Description 2" := RFQ."Description 2";
                        PurchLine2.Quantity := RFQ.Quantity;
                        PurchLine2.Validate(Quantity);
                        PurchLine2."Unit of Measure Code" := RFQ."Unit of Measure Code";
                        PurchLine2.Validate("Unit of Measure Code");
                        PurchLine2."Direct Unit Cost" := RFQ."Direct Unit Cost";
                        PurchLine2.Validate("Direct Unit Cost");
                        PurchLine2."Location Code" := RFQ."Location Code";
                        PurchLine2."RFQ No." := "Request for Quote No.";
                        PurchLine2.Validate("RFQ No.");
                        PurchLine2."Location Code" := "Location Code";
                        PurchLine2."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                        PurchLine2."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                        PurchLine2.Insert(true);

                    until RFQ.Next = 0;
                end;
            end;
        }
        field(50003; "Quote Comments"; Text[150])
        {
            DataClassification = ToBeClassified;
            Description = 'Store Comments of Purchase Quote in the DB (Added)';
        }
        field(50004; "Responsibility Center Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Stores Responsibilty Center Name in the database (Added)';
        }
        field(50005; "Donor Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Stores Donor Name in the database (Added)';
        }
        field(50006; "Pillar Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Stores Pillar Name in the database (Added)';
        }
        field(50009; "Quote Comments 2"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Quote Comments 3"; Text[80])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(50011; "Recommendation 1"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Recommendation 2"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Project Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Archive Unused Doc"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "VAT Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Expensed,Recovered';
            OptionMembers = Expensed,Recovered;
        }
        field(55536; Cancelled; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(55537; "Cancelled By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(55538; "Cancelled Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(55539; DocApprovalType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Purchase,Requisition,Quote,Capex;
        }
        field(55540; "Procurement Type Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Methods";
        }
        field(55541; "Invoice Basis"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "PO Based","Direct Invoice";
        }
        field(55544; "RFQ No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Quote Header" where(Status = const(Released));

            trigger OnLookup()
            begin
                TestField("Responsibility Center");
                TestField("Shortcut Dimension 1 Code");
                TestField("Shortcut Dimension 2 Code");

                RFQHdr.Reset;
                RFQHdr.SetRange(RFQHdr.Status, RFQHdr.Status::Released);
                if Page.RunModal(51516107, RFQHdr) = Action::LookupOK then
                    InsertRFQ(RFQHdr);
            end;
        }
        field(55550; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(55551; "Special Remark"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(55552; "Responsible Officer"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup" where("Procurement Officer" = filter(true));
        }
        field(55553; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,LPO,LSO';
            OptionMembers = " ",LPO,LSO;
        }
        field(55554; "Imprest Purchase Doc No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(55555; "Manual LPO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(55556; "Requisition No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Line"."Document No.";

            trigger OnValidate()
            begin
                /*PurchLine.RESET;
                PurchLine.SETRANGE(PurchLine."Document No.","Requisition No.");
                if PurchLine.find('-') then
                begin
                repeat
                Type:=
                "No.":=
                "Requisition No.";
                
                
                until PurchLine.next=0;
                end
                
                   */

            end;
        }
        field(55557; "Received from (CLient)"; Code[80])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(55558; "Attach Original Invoice"; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(55559; PR; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516000; Narration; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(51516001; "Doc Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',PurchReq';
            OptionMembers = ,PurchReq;
        }
        field(51516002; "User ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(51516003; Completed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516004; Printed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516005; Archived; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516006; "Payment Terms"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        //        VendLimit: Codeunit UnknownCodeunit55485;
        CheckNos: Codeunit "Check Manual Nos";
        Used: Boolean;
        RFQHdr: Record "Purchase Quote Header";
        RFQ: Record "Purchase Quote Line";
        PurchLine2: Record "Purchase Line";
        LineNo: Decimal;
        RFQVendors: Record "Quotation Request Vendors";
        PurchLine: Record "Purchase Line";

    procedure InsertRFQ(var RFQHeader: Record "Purchase Quote Header")
    var
        RFQLines: Record "Purchase Quote Line";
        ReqLines: Record "Purchase Line";
    begin
        //RFQHeader.GET(RFQHeader."Document Type"::"Quotation Request","RFQ No.");

        ReqLines.Reset;
        ReqLines.SetRange(ReqLines."Document Type", "Document Type");
        ReqLines.SetRange(ReqLines."Document No.", "No.");
        ReqLines.DeleteAll;

        RFQLines.SetRange(RFQLines."Document No.", RFQHeader."No.");
        if RFQLines.FindSet then
            repeat
                ReqLines.Init;
                ReqLines.TransferFields(RFQLines);
                ReqLines."Document Type" := "Document Type";
                ReqLines."Document No." := "No.";
                ReqLines."Buy-from Vendor No." := "Buy-from Vendor No.";
                ReqLines."Pay-to Vendor No." := "Pay-to Vendor No.";
                ReqLines.Insert;
            /*
              ReqLines.VALIDATE(ReqLines."No.");
              ReqLines.VALIDATE(ReqLines.Quantity);
              ReqLines.VALIDATE(ReqLines."Direct Unit Cost");
              ReqLines.MODIFY;
            */
            until RFQLines.Next = 0;
        "RFQ No." := RFQHeader."No.";
        Modify;

    end;

}