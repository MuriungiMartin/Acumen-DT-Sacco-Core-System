#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516105 "RFQ Header"
{
    PageType = Document;
    SourceTable = "Purchase Quote Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Description";"Posting Description")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Code";"Ship-to Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Ship-to Name";"Ship-to Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Ship-to Address";"Ship-to Address")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Opening Date";"Expected Opening Date")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Closing Date";"Expected Closing Date")
                {
                    ApplicationArea = Basic;
                }
                field("Location Code";"Location Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Control1102755012;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code";"Currency Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
            part(Control1102755015;"RFQ Subform")
            {
                SubPageLink = "Document No."=field("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup1102755017)
            {
                action("Get Document Lines")
                {
                    ApplicationArea = Basic;
                    Caption = 'Get Document Lines';
                    Image = GetLines;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CurrPage.Update(true);
                        InsertRFQLines;
                    end;
                }
                action("Assign Vendor(s)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Assign Vendor(s)';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Vends: Record "Quotation Request Vendors";
                    begin

                        Vends.Reset;
                        Vends.SetRange(Vends."Document Type","Document Type");
                        Vends.SetRange(Vends."Requisition Document No.","No.");

                        Page.Run(Page::"Quotation Request Vendors",Vends);
                    end;
                }
                action("Print/Preview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Print/Preview';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    var
                        Vend: Record "Quotation Request Vendors";
                        repvend: Report "RFQ Report";
                    begin
                        if Status=Status::Open then
                           Error('RFQ Must be Released. Current Status is Open');
                        
                        PQH.SetRecfilter;
                        PQH.SetFilter(PQH."Document Type",'%1',"Document Type");
                        PQH.SetFilter("No.","No.");
                        if PQH.Find ('-') then
                        Report.Run(Report::"RFQ Report",true,true,PQH);
                        //repvend.SETTABLEVIEW(PQH);
                        //repvend.NEWPAGEPERRECORD(TRUE);
                        //repvend.RUN;
                        /*
                        Vend.RESET;
                        Vend.SETRANGE(Vend."Requisition Document No.","No.");
                        IF Vend.FINDSET THEN BEGIN
                        // REPEAT
                          //MESSAGE(Vend."Vendor Name");
                          REPORT.RUN(REPORT::"RFQ Report",TRUE,TRUE,Vend);
                         //UNTIL Vend.NEXT=0;
                        END;
                        */

                    end;
                }
                action("Create Quotes")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Vendor Quotes';
                    Image = VendorPayment;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        RFQLines: Record "Purchase Quote Line";
                        PurchaseHeader: Record "Purchase Header";
                        PurchaseLines: Record "Purchase Line";
                        Vends: Record "Quotation Request Vendors";
                    begin
                        Vends.SetRange(Vends."Requisition Document No.","No.");
                        if Vends.FindSet then
                        repeat
                        //create header
                          PurchaseHeader.Init;
                          PurchaseHeader."Document Type":=PurchaseHeader."document type"::Quote;
                          PurchaseHeader.DocApprovalType:=PurchaseHeader.Docapprovaltype::Quote;
                          PurchaseHeader."No.":='';
                          PurchaseHeader."Responsibility Center":="Responsibility Center";
                          PurchaseHeader."Shortcut Dimension 1 Code":="Shortcut Dimension 1 Code";
                          PurchaseHeader."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
                          PurchaseHeader.Insert(true);
                          PurchaseHeader.Validate("Buy-from Vendor No.",Vends."Vendor No.");
                          PurchaseHeader."Responsibility Center":="Responsibility Center";
                          PurchaseHeader."Shortcut Dimension 1 Code":="Shortcut Dimension 1 Code";
                          PurchaseHeader."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
                        //  PurchaseHeader.validate("RFQ No.","No.");
                          PurchaseHeader.Modify;
                          PurchaseHeader.Insert(true);
                        
                        //create lines
                        
                          RFQLines.SetRange(RFQLines."Document No.","No.");
                          if RFQLines.FindSet then
                          repeat
                            PurchaseLines.Init;
                            PurchaseLines.TransferFields(RFQLines);
                            PurchaseLines."Document Type":=PurchaseLines."document type"::Quote;
                            PurchaseLines."Document No.":="No.";
                            PurchaseLines.Insert;
                          /*
                            ReqLines.VALIDATE(ReqLines."No.");
                            ReqLines.VALIDATE(ReqLines.Quantity);
                            ReqLines.VALIDATE(ReqLines."Direct Unit Cost");
                            ReqLines.MODIFY;
                          */
                          until RFQLines.Next=0;
                        until Vends.Next=0;

                    end;
                }
                action("Bid Analysis")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bid Analysis';
                    Image = Worksheet;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                        PurchaseLines: Record "Purchase Line";
                        ItemNoFilter: Text[250];
                        RFQNoFilter: Text[250];
                        InsertCount: Integer;
                        BidAnalysis: Record "Bid Analysis";
                    begin
                        //deletebidanalysis for this vendor
                        BidAnalysis.SetRange(BidAnalysis."RFQ No.","No.");
                        BidAnalysis.DeleteAll;


                        //insert the quotes from vendors

                        PurchaseHeader.SetRange(PurchaseHeader."No.","No.");
                        PurchaseHeader.FindSet;
                        repeat
                          PurchaseLines.Reset;
                          PurchaseLines.SetRange("Document No.",PurchaseHeader."No.");
                          if PurchaseLines.FindSet then
                          repeat
                            BidAnalysis.Init;
                            BidAnalysis."RFQ No.":="No.";
                            BidAnalysis."RFQ Line No.":=PurchaseLines."Line No.";
                            BidAnalysis."Quote No.":=PurchaseLines."Document No.";
                            BidAnalysis."Vendor No.":=PurchaseHeader."Buy-from Vendor No.";
                            BidAnalysis."Item No.":=PurchaseLines."No.";
                            BidAnalysis.Description:=PurchaseLines.Description;
                            BidAnalysis.Quantity:=PurchaseLines.Quantity;
                            BidAnalysis."Unit Of Measure":=PurchaseLines."Unit of Measure";
                            BidAnalysis.Amount:=PurchaseLines."Direct Unit Cost";
                            BidAnalysis."Line Amount":=BidAnalysis.Quantity*BidAnalysis. Amount;
                            BidAnalysis.Insert(true);
                            InsertCount+=1;
                           until PurchaseLines.Next=0;
                        until PurchaseHeader.Next=0;
                        //MESSAGE('%1 records have been inserted to the bid analysis',InsertCount);
                    end;
                }
            }
            group(Status)
            {
                Caption = 'Status';
                action(Cancel)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        
                        //check if the quotation for request number has already been used
                        /*
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE(PurchHeader."Request for Quote No.","No.");
                        IF PurchHeader.FINDFIRST THEN
                          BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          END;
                        */
                        if Confirm('Cancel Document?',false)=false then begin exit end;
                        Status:=Status::Cancelled;
                        Modify;

                    end;
                }
                action(Stop)
                {
                    ApplicationArea = Basic;
                    Caption = 'Stop';
                    Image = Stop;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        
                        //check if the quotation for request number has already been used
                        /*
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE(PurchHeader."Request for Quote No.","No.");
                        IF PurchHeader.FINDFIRST THEN
                          BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          END;
                        */
                        if Confirm('Close Document?',false)=false then begin exit end;
                        Status:=Status::Closed;
                        Modify;

                    end;
                }
                action(Close)
                {
                    ApplicationArea = Basic;
                    Caption = 'Close';
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        
                        //check if the quotation for request number has already been used
                        /*
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE(PurchHeader."Request for Quote No.","No.");
                        IF PurchHeader.FINDFIRST THEN
                          BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          END;
                        */
                        if Confirm('Close Document?',false)=false then begin exit end;
                        Status:=Status::Closed;
                        Modify;

                    end;
                }
                action(Release)
                {
                    ApplicationArea = Basic;
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        if Confirm('Release document?',false)=false then begin exit end;
                        //check if the document has any lines
                        Lines.Reset;
                        Lines.SetRange(Lines."Document Type","Document Type");
                        Lines.SetRange(Lines."Document No.","No.");
                        if Lines.FindFirst then
                          begin
                            repeat
                              Lines.TestField(Lines.Quantity);
                              //Lines.TESTFIELD(Lines."Direct Unit Cost");
                              Lines.TestField("No.");
                            until Lines.Next=0;
                          end
                        else
                          begin
                            Error('Document has no lines');
                          end;
                        Status:=Status::Released;
                        "Released By":=UserId;
                        "Release Date":=Today;
                        Modify;
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        //check if the quotation for request number has already been used
                        PurchHeader.Reset;
                        PurchHeader.SetRange(PurchHeader."Document Type",PurchHeader."document type"::Quote);
                        //PurchHeader.SETRANGE(purchheader."request for quote no","No.");
                        if PurchHeader.FindFirst then
                          begin
                            Error('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          end;

                        if Confirm('Reopen Document?',false)=false then begin exit end;
                        Status:=Status::Open;
                        Modify;
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Location.Reset;
        Location.SetRange(Location.Code,'MOMBASA');
        if Location.FindFirst then begin
          "Ship-to Code":= Location.Code;
          Validate("Ship-to Code");
        end;
        //"Ship-to Code":='KIAMBU';
        "Location Code":='MOMBASA';
        "Shortcut Dimension 1 Code":='BOSA';
        "Shortcut Dimension 2 Code":='MOMBASA';
    end;

    var
        PurchHeader: Record "Purchase Header";
        PParams: Record "Purchase Quote Params";
        Lines: Record "Purchase Quote Line";
        PQH: Record "Purchase Quote Header";
        Location: Record Location;


    procedure InsertRFQLines()
    var
        Counter: Integer;
        Collection: Record "Purchase Line";
        CollectionList: Page "PRF Lists";
    begin
        CollectionList.LookupMode(true);
        if CollectionList.RunModal = Action::LookupOK then begin
          CollectionList.SetSelection(Collection);
          Counter := Collection.Count;
          if Counter > 0 then begin
            if Collection.FindSet then
              repeat
                Lines.Init;
                Lines.TransferFields(Collection);
                Lines."Document Type":="Document Type";
                Lines."Document No.":="No.";
                Lines."Line No.":=0;
                Lines."PRF No":=Collection."Document No.";
                Lines."PRF Line No.":=Collection."Line No.";
                Lines.Insert(true);
                //Collection.Copied:=TRUE;
                //Collection.MODIFY;
             until Collection.Next = 0;
          end;
        end;
    end;
}

