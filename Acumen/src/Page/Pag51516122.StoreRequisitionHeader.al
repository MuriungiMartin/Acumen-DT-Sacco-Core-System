#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516122 "Store Requisition Header"
{
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Cancellation,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Store Requistion Header P";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field("Request date"; "Request date")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = statuseditable;
                }
                field("Function Name"; "Function Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = statuseditable;
                }
                field("Budget Center Name"; "Budget Center Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    Editable = false;
                }
                field("Request Description"; "Request Description")
                {
                    ApplicationArea = Basic;
                    Editable = statuseditable;
                }
                field("Required Date"; "Required Date")
                {
                    ApplicationArea = Basic;
                    Editable = statuseditable;
                }
                field("Issuing Store"; "Issuing Store")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Job No"; "Job No")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field(Cancelled; Cancelled)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Cancelled By"; "Cancelled By")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
            part(Control1102755015; "Store Requisition Line")
            {
                Editable = true;
                SubPageLink = "Requistion No" = field("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Post Store Requisition")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Store Requisition';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = true;

                    trigger OnAction()
                    var
                        ItemLedger: Record "Item Ledger Entry";
                    begin


                        if Usersetup.Get(UserId) then begin
                            if Usersetup."Post Stores Requisition" = false then Error('You dont have permission to post this requisition, Contact your system administrator! ')
                        end;

                        if not LinesExists then
                            Error('There are no Lines created for this Document');

                        if Status = Status::Posted then
                            Error('The Document Has Already been Posted');

                        if Status <> Status::Released then
                            Error('The Document Has not yet been Approved');

                        if InventorySetup.Get then begin
                            InventorySetup.TestField(InventorySetup."Item Jnl Template");
                            InventorySetup.TestField(InventorySetup."Item Jnl Batch");
                            GenJnline.Reset;
                            GenJnline.SetRange(GenJnline."Journal Template Name", InventorySetup."Item Jnl Template");
                            GenJnline.SetRange(GenJnline."Journal Batch Name", InventorySetup."Item Jnl Batch");
                            if GenJnline.Find('-') then GenJnline.DeleteAll;

                            /*ReqLine.RESET;
                            ReqLine.SETRANGE(ReqLine."Requistion No","No.");
                            IF ReqLine.FIND ('-') THEN BEGIN
                            Item.RESET;
                            Item.SETRANGE(Item."No.",ReqLine."No.");
                            IF Item.FIND ('-') THEN BEGIN
                            IssStore:=Item."Location Code";
                            END;
                            END;*/


                            ReqLine.Reset;
                            ReqLine.SetRange(ReqLine."Requistion No", "No.");
                            if ReqLine.Find('-') then begin
                                repeat
                                    Item.Reset;
                                    Item.SetRange(Item."No.", ReqLine."No.");
                                    if Item.Find('-') then begin
                                        IssStore := Item."Location Code";
                                    end;

                                    //Issue

                                    LineNo := LineNo + 1000;
                                    GenJnline.Init;
                                    GenJnline."Journal Template Name" := InventorySetup."Item Jnl Template";
                                    GenJnline."Journal Batch Name" := InventorySetup."Item Jnl Batch";
                                    GenJnline."Line No." := LineNo;
                                    GenJnline."Entry Type" := GenJnline."entry type"::"Negative Adjmt.";
                                    GenJnline."Document No." := "No.";
                                    GenJnline."Item No." := ReqLine."No.";
                                    GenJnline.Validate("Item No.");
                                    GenJnline."Location Code" := IssStore;
                                    GenJnline."Bin Code" := ReqLine."Bin Code";
                                    GenJnline.Validate(GenJnline."Location Code", "Issuing Store");
                                    GenJnline."Posting Date" := "Request date";
                                    GenJnline.Description := ReqLine.Description;
                                    ItemLedger.Reset;
                                    ItemLedger.SetRange(ItemLedger."Item No.", ReqLine."No.");
                                    ItemLedger.SetRange(ItemLedger."Location Code", ReqLine."Issuing Store");
                                    ItemLedger.CalcSums(Quantity);
                                    if ItemLedger.Quantity <= 0 then
                                        Error('Item %1 is out of stock in store %2', ReqLine.Description, ReqLine."Issuing Store");
                                    GenJnline.Quantity := ReqLine.Quantity;
                                    GenJnline."Shortcut Dimension 1 Code" := ReqLine."Shortcut Dimension 1 Code";
                                    GenJnline.Validate("Shortcut Dimension 1 Code");
                                    GenJnline."Shortcut Dimension 2 Code" := ReqLine."Shortcut Dimension 2 Code";
                                    GenJnline.Validate("Shortcut Dimension 2 Code");
                                    //GenJnline."Lot No.":=ReqLine."Lot No.";
                                    GenJnline.ValidateShortcutDimCode(3, ReqLine."Shortcut Dimension 3 Code");
                                    GenJnline.ValidateShortcutDimCode(4, ReqLine."Shortcut Dimension 4 Code");
                                    GenJnline.Validate(Quantity);
                                    GenJnline.Validate("Unit Amount");
                                    ///GenJnline."Reason Code":='ITEMJNL';
                                    GenJnline.Validate("Reason Code");
                                    GenJnline."Gen. Prod. Posting Group" := ReqLine."Gen. Prod. Posting Group";
                                    GenJnline."Gen. Bus. Posting Group" := ReqLine."Gen. Bus. Posting Group";
                                    //Get the inventory posting Group
                                    Item.Reset;
                                    Item.SetRange(Item."No.", ReqLine."No.");
                                    if Item.FindLast then begin
                                        GenJnline."Inventory Posting Group" := Item."Inventory Posting Group";
                                    end;
                                    GenJnline.Insert(true);

                                    ReqLine."Request Status" := ReqLine."request status"::Closed;

                                //Denno Added to take care of lot numbers-----------------
                                //If Lot No field  Exist then insert reservation line
                                /*  ResEntry.RESET;
                                  ResEntry.SETRANGE(ResEntry."Entry No.");
                                  IF ResEntry.FIND('+') THEN LastResNo:=ResEntry."Entry No.";

                                  LastResNo:=LastResNo+1;

                                  IF ReqLine."Lot No."<>'' THEN BEGIN
                                   ResEntry.INIT;
                                   ResEntry."Entry No.":=LastResNo;   //ResEntry."Entry No."
                                   ResEntry."Item No.":=ReqLine."No.";
                                   ResEntry."Location Code":=ReqLine."Issuing Store";
                                   ResEntry."Quantity (Base)":=-ReqLine.Quantity;
                                   ResEntry.VALIDATE("Quantity (Base)");
                                   ResEntry.Quantity:=-ReqLine.Quantity;
                                   ResEntry."Qty. to Handle (Base)":=-ReqLine.Quantity;
                                   ResEntry.VALIDATE("Qty. to Handle (Base)");
                                   ResEntry."Reservation Status":=ResEntry."Reservation Status"::Prospect;
                                   ResEntry."Creation Date":="Request date";
                                   ResEntry."Source Type":=83;
                                   ResEntry."Source Subtype":=3;
                                   ResEntry."Source ID":='ITEM';
                                   ResEntry."Source Batch Name":='DEFAULT';
                                   ResEntry."Source Ref. No.":=  LineNo;
                                   ResEntry."Lot No.":= ReqLine."Lot No.";
                                   ResEntry."Item Tracking":=ResEntry."Item Tracking"::"Lot No.";
                                   ResEntry.INSERT;

                                  END;  */
                                //End Denno Added to take care of lot numbers-----------------

                                until ReqLine.Next = 0;

                                //Post Entries
                                GenJnline.Reset;
                                GenJnline.SetRange(GenJnline."Journal Template Name", InventorySetup."Item Jnl Template");
                                GenJnline.SetRange(GenJnline."Journal Batch Name", InventorySetup."Item Jnl Batch");
                                Codeunit.Run(Codeunit::"Item Jnl.-Post", GenJnline);
                                //End Post entries
                                Status := Status::Posted;
                                Modify;


                                ReqLine.Reset;
                                ReqLine.SetRange(ReqLine."Requistion No", "No.");
                                if ReqLine.Find('-') then begin
                                    repeat
                                        ReqLine."Request Status" := ReqLine."request status"::Closed;
                                        ReqLine."Posting Date" := "Request date";
                                        ReqLine.Modify;

                                    until ReqLine.Next = 0;
                                end;


                                // Modify All
                                Post := false;
                                Post := JournlPosted.PostedSuccessfully();
                                if Post then begin
                                    ReqLine.ModifyAll(ReqLine."Request Status", ReqLine."request status"::Closed);
                                    Status := Status::Posted;
                                    Modify;
                                end
                            end;
                        end;

                        Status := Status::Posted;
                        Modify;

                    end;
                }
                separator(Action1102755029)
                {
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        DocumentType := Documenttype::Requisition;
                        ApprovalEntries.Setfilters(Database::Transactions, DocumentType, "No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if not LinesExists then
                            Error('There are no Lines created for this Document');

                        //Status:=Status::Released;
                        //MODIFY;

                        TestField(Status, Status::Open);
                        TestField("Global Dimension 1 Code");

                        TestField("Shortcut Dimension 2 Code");
                        //Release the Imprest for Approval
                        //IF ApprovalMgt.SendSRequestApprovalRequest(Rec) THEN;

                        // if ApprovalsMgmt.CheckSReqApplicationApprovalsWorkflowEnabled(Rec) then
                        //     ApprovalsMgmt.OnSendSReqApplicationForApproval(Rec);
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        //IF ApprovalMgt.CancelSRRequestApprovalRequest(Rec,TRUE,TRUE) THEN;
                        /*
                        IF CONFIRM('Cancel Approval?',FALSE)=FALSE THEN BEGIN EXIT END;
                        Status:=Status::Open;
                        MODIFY;
                        */

                        //  ApprovalsMgmt.OnCancelSReqApplicationApprovalRequest(Rec);

                    end;
                }
                separator(Action1102755035)
                {
                }
                action("Print/Preview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Print/Preview';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin


                        //IF Status<>Status::Posted THEN
                        // ERROR('You can only print a Material Requisiton after it Fully Approved And Posted');

                        Reset;
                        SetFilter("No.", "No.");
                        Report.Run(51516103, true, true, Rec);
                        Reset;
                    end;
                }
                action("Cancel Document")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Usersetup.Get(UserId) then begin
                            if Usersetup."Cancel Requisition" = true then begin
                                Status := Status::Cancelled;
                                Cancelled := true;
                                "Cancelled By" := UserId;
                                Modify;
                                Message('Document Cancelled!');
                            end else
                                Error('You have no rights to cancel the document!');
                        end;
                    end;
                }
                action("Send Approval")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        PayLines: Record "Store Requistion Lines";
                    begin

                        if Confirm('Release document?', false) = false then begin exit end;
                        //check if the document has any lines
                        /*PayLines.RESET;
                        //PayLines.SETRANGE(PayLines."Document Type","Document Type");
                        PayLines.SETRANGE(PayLines."No.","No.");
                        IF PayLines.FINDFIRST THEN
                          BEGIN
                            REPEAT
                              PayLines.TESTFIELD(PayLines."Quantity Requested");
                              //Lines.TESTFIELD(Lines."Direct Unit Cost");
                              PayLines.TESTFIELD("No.");
                            UNTIL PayLines.NEXT=0;
                          END
                        ELSE
                          BEGIN
                            ERROR('Document has no lines');
                          END;*/
                        Status := Status::Released;
                        //"Released By":=USERID;
                        //"Release Date":=TODAY;
                        Modify;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPageUpdate;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Error('Not Allowed!');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        SHeader.Reset;
        SHeader.SetRange("User ID", UserId);
        SHeader.SetRange(SHeader.Status, SHeader.Status::Open);
        // SHeader.SETRANGE(SHeader."Request date",TODAY);
        if SHeader.Count > 1 then
            Error('You have unused requisition records under your account,please utilize/release them for approval' +
              ' before creating a new record');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        "Issuing Store" := 'NAIROBI';

        "Responsibility Center" := UserMgt.GetPurchasesFilter();
        //Add dimensions if set by default here
        "Global Dimension 1 Code" := UserMgt.GetSetDimensions(UserId, 1);
        Validate("Global Dimension 1 Code");
        "Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(UserId, 2);
        Validate("Shortcut Dimension 2 Code");
        "Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(UserId, 3);
        Validate("Shortcut Dimension 3 Code");
        "Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(UserId, 4);
        Validate("Shortcut Dimension 4 Code");

        UpdateControls;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        if Status = Status::"Pending Approval" then
            CurrPage.Editable := false;

        if Status = Status::Open then begin
            PageActionsVisible := false;
        end else
            if Status <> Status::Open then begin
                PageActionsVisible := true;
            end;
        "Responsibility Center" := 'FINANCE';

        /*
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center" ,UserMgt.GetPurchasesFilter());
          FILTERGROUP(0);
        END;
        */
        //SETRANGE("User ID",USERID);

    end;

    var
        UserMgt: Codeunit "User Setup Management BR.";
        ReqLine: Record "Store Requistion Lines";
        InventorySetup: Record "Inventory Setup";
        GenJnline: Record "Item Journal Line";
        LineNo: Integer;
        Post: Boolean;
        JournlPosted: Codeunit "Journal Post Successful";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        ApprovalEntries: Page "Approval Entries";
        StatusEditable: Boolean;
        PageActionsVisible: Boolean;
        Text046: label 'The %1 does not match the quantity defined in item tracking.';
        ResEntry: Record "Reservation Entry";
        LastResNo: Integer;
        InventoryPostingSetup: Record "Inventory Posting Setup";
        Item: Record Item;
        SHeader: Record "Store Requistion Header P";
        IssStore: Code[20];
        Usersetup: Record "User Setup";
        ApprovalsMgmt: Codeunit WorkflowIntegration;


    procedure LinesExists(): Boolean
    var
        PayLines: Record "Store Requistion Lines";
    begin
        HasLines := false;
        PayLines.Reset;
        PayLines.SetRange(PayLines."Requistion No", "No.");
        if PayLines.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;


    procedure UpdateControls()
    begin
        if Status = Status::Open then
            StatusEditable := true
        else
            StatusEditable := false;
    end;


    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        CurrPage.Update;
    end;

    local procedure CheckTrackingSpecification(var PurchLine: Record "Store Requistion Lines")
    var
        PurchLineToCheck: Record "Store Requistion Lines";
        ReservationEntry: Record "Reservation Entry";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        ItemTrackingManagement: Codeunit "Item Tracking Management";
        ErrorFieldCaption: Text[250];
        SignFactor: Integer;
        PurchLineQtyHandled: Decimal;
        PurchLineQtyToHandle: Decimal;
        TrackingQtyHandled: Decimal;
        TrackingQtyToHandle: Decimal;
        Inbound: Boolean;
        SNRequired: Boolean;
        LotRequired: Boolean;
        SNInfoRequired: Boolean;
        LotInfoReguired: Boolean;
        CheckPurchLine: Boolean;
    begin
        // if a PurchaseLine is posted with ItemTracking then the whole quantity of
        // the regarding PurchaseLine has to be post with Item-Tracking

        TrackingQtyToHandle := 0;
        TrackingQtyHandled := 0;

        PurchLineToCheck.Copy(PurchLine);
        PurchLineToCheck.SetRange(Type, PurchLineToCheck.Type::Item);
        //IF PurchHeader.Receive THEN BEGIN ---- Denno
        //  PurchLineToCheck.SETFILTER("Quantity Received",'<>%1',0);
        //  ErrorFieldCaption := PurchLineToCheck.FIELDCAPTION("Qty. to Receive");
        //END ELSE BEGIN
        PurchLineToCheck.SetFilter(Quantity, '<>%1', 0);
        ErrorFieldCaption := PurchLineToCheck.FieldCaption(Quantity);
        //END;

        if PurchLineToCheck.FindSet then begin
            ReservationEntry."Source Type" := Database::"Transaction Charges";
            ReservationEntry."Source Subtype" := 0;//PurchHeader."Document Type";
            SignFactor := CreateReservEntry.SignFactor(ReservationEntry);
            repeat
                // Only Item where no SerialNo or LotNo is required
                // Item.Get(PurchLineToCheck."No.");
                // if Item."Item Tracking Code" <> '' then begin
                //     Inbound := (PurchLineToCheck.Quantity * SignFactor) > 0;
                //     ItemTrackingCode.Code := Item."Item Tracking Code";
                //     // ItemTrackingManagement.GetItemTrackingSettings(ItemTrackingCode,
                //     GenJnline."entry type"::"Negative Adjmt.",
                //       Inbound,
                //       SNRequired,
                //       LotRequired,
                //       SNInfoRequired,
                //       LotInfoReguired);
                //     CheckPurchLine := (SNRequired = false) and (LotRequired = false);
                //     if CheckPurchLine then
                //         CheckPurchLine := GetTrackingQuantities(PurchLineToCheck, 0, TrackingQtyToHandle, TrackingQtyHandled);
                // end else
                //     CheckPurchLine := false;

                TrackingQtyToHandle := 0;
                TrackingQtyHandled := 0;

                if CheckPurchLine then begin
                    GetTrackingQuantities(PurchLineToCheck, 1, TrackingQtyToHandle, TrackingQtyHandled);
                    TrackingQtyToHandle := TrackingQtyToHandle * SignFactor;
                    TrackingQtyHandled := TrackingQtyHandled * SignFactor;
                    /*      IF PurchHeader.Receive THEN BEGIN
                            PurchLineQtyToHandle := PurchLineToCheck."Qty. to Receive (Base)";
                            PurchLineQtyHandled := PurchLineToCheck."Qty. Received (Base)";
                          END ELSE */
                    begin
                        PurchLineQtyToHandle := PurchLineToCheck.Quantity;
                        PurchLineQtyHandled := PurchLineToCheck.Quantity;
                    end;
                    if ((TrackingQtyHandled + TrackingQtyToHandle) <> (PurchLineQtyHandled + PurchLineQtyToHandle)) or
                       (TrackingQtyToHandle <> PurchLineQtyToHandle)
                    then
                        Error(StrSubstNo(Text046, ErrorFieldCaption));
                end;
            until PurchLineToCheck.Next = 0;
        end;

    end;

    local procedure GetTrackingQuantities(PurchLine: Record "Store Requistion Lines"; FunctionType: Option CheckTrackingExists,GetQty; var TrackingQtyToHandle: Decimal; var TrackingQtyHandled: Decimal): Boolean
    var
        TrackingSpecification: Record "Tracking Specification";
        ReservEntry: Record "Reservation Entry";
    begin
        with TrackingSpecification do begin
            SetCurrentkey("Source ID", "Source Type", "Source Subtype", "Source Batch Name",
              "Source Prod. Order Line", "Source Ref. No.");
            SetRange("Source Type", Database::"Transaction Charges");
            SetRange("Source Subtype", 0);
            SetRange("Source ID", PurchLine."Requistion No");
            SetRange("Source Batch Name", '');
            SetRange("Source Prod. Order Line", 0);
            SetRange("Source Ref. No.", PurchLine."Line No.");
        end;
        with ReservEntry do begin
            SetCurrentkey(
              "Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
              "Source Batch Name", "Source Prod. Order Line");
            SetRange("Source ID", PurchLine."Requistion No");
            SetRange("Source Ref. No.", PurchLine."Line No.");
            SetRange("Source Type", Database::"Transaction Charges");
            SetRange("Source Subtype", 0);
            SetRange("Source Batch Name", '');
            SetRange("Source Prod. Order Line", 0);
        end;

        case FunctionType of
            Functiontype::CheckTrackingExists:
                begin
                    TrackingSpecification.SetRange(Correction, false);
                    if not TrackingSpecification.IsEmpty then
                        exit(true);
                    ReservEntry.SetFilter("Serial No.", '<>%1', '');
                    if not ReservEntry.IsEmpty then
                        exit(true);
                    ReservEntry.SetRange("Serial No.");
                    ReservEntry.SetFilter("Lot No.", '<>%1', '');
                    if not ReservEntry.IsEmpty then
                        exit(true);
                end;
            Functiontype::GetQty:
                begin
                    TrackingSpecification.CalcSums("Quantity Handled (Base)");
                    TrackingQtyHandled := TrackingSpecification."Quantity Handled (Base)";
                    if ReservEntry.FindSet then
                        repeat
                            if (ReservEntry."Lot No." <> '') or (ReservEntry."Serial No." <> '') then
                                TrackingQtyToHandle := TrackingQtyToHandle + ReservEntry."Qty. to Handle (Base)";
                        until ReservEntry.Next = 0;
                end;
        end;
    end;
}

