#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516103 "Posted Purchase Requisitions"
{
    ApplicationArea = Basic;
    CardPageID = "Released Internal Requisitions";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Budget,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type"=filter(Quote),
                            DocApprovalType=filter(Requisition),
                            Status=const(Released),
                            PR=const(true),
                            Completed=const(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Description";"Posting Description")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Receipt Date";"Requested Receipt Date")
                {
                    ApplicationArea = Basic;
                }
                field("Procurement Type Code";"Procurement Type Code")
                {
                    ApplicationArea = Basic;
                }
                field("Order Date";"Order Date")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date";"Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center";"Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Assigned User ID";"Assigned User ID")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field(Completed;Completed)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755012;Notes)
            {
            }
            systempart(Control1102755013;MyNotes)
            {
            }
            systempart(Control1102755014;Links)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("<Action59>")
            {
                Caption = '&Quote';
                action("<Action61>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        CalcInvDiscForHeader;
                        Commit;
                        Page.RunModal(Page::"Purchase Statistics",Rec);
                    end;
                }
                action("<Action62>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No."=field("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("<Action63>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type"=field("Document Type"),
                                  "No."=field("No."),
                                  "Document Line No."=const(0);
                }
                action("<Action111>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action("<Action152>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        ApprovalEntries.Setfilters(Database::"Purchase Header","Document Type","No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
            group("<Action104>")
            {
                Caption = '&Line';
                group("<Action105>")
                {
                    Caption = 'Item Availability by';
                    action("<Action109>")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Variant';
                    }
                    action("<Action106>")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Location';
                    }
                }
                action("<Action112>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                action("<Action168>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                }
                action("<Action5800>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Item Charge &Assignment';
                }
                action("<Action6500>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                }
            }
        }
        area(processing)
        {
            action("<Action69>")
            {
                ApplicationArea = Basic;
                Caption = 'Make &Order';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    if LinesCommitted then
                       Error('All Lines should be committed');

                    //IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                     // CODEUNIT.RUN(CODEUNIT::"Purch.-Quote to Order (Yes/No)",Rec);
                end;
            }
            group("<Action64>")
            {
                Caption = 'F&unctions';
                action("<Action65>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }
                separator(Action1102755037)
                {
                }
                action("<Action67>")
                {
                    ApplicationArea = Basic;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                }
                action("<Action18>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Insert &Ext. Texts';
                }
                separator(Action1102755034)
                {
                }
                action("<Action143>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator(Action1102755032)
                {
                }
                action("<Action66>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RunModal;
                        Clear(CopyPurchDoc);
                    end;
                }
                action("<Action138>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Archi&ve Document';

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.Update(false);
                    end;
                }
                separator(Action1102755029)
                {
                }
                action("<Action153>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if LinesCommitted then
                           Error('All Lines should be committed');

                        //IF ApprovalMgt.SendPurchaseApprovalRequest(Rec) THEN;
                    end;
                }
                action("<Action154>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        //IF ApprovalMgt.CancelPurchaseApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                separator(Action1102755026)
                {
                }
                action("<Action1102755002>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Check Budget Availability';
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        BCSetup: Record "Budgetary Control Setup";
                    begin

                        BCSetup.Get;
                        if not BCSetup.Mandatory then
                           exit;

                        if Status=Status::Released then
                          Error('This document has already been released. This functionality is available for open documents only');
                        if not SomeLinesCommitted then begin
                           if not Confirm( 'Some or All the Lines Are already Committed do you want to continue',true, "Document Type") then
                                Error('Budget Availability Check and Commitment Aborted');
                          DeleteCommitment.Reset;
                          DeleteCommitment.SetRange(DeleteCommitment."Document Type",DeleteCommitment."document type"::LPO);
                          DeleteCommitment.SetRange(DeleteCommitment."Document No.","No.");
                          DeleteCommitment.DeleteAll;
                        end;
                           Commitment.CheckPurchase(Rec);
                           Message('Budget Availability Checking Complete');
                    end;
                }
                action("<Action1102755003>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Budget Commitment';
                    Image = Reject;
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
                separator(Action1102755023)
                {
                }
                action("<Action118>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        if LinesCommitted then
                           Error('All Lines should be committed');

                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("<Action119>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        if LinesCommitted then
                           Error('All Lines should be committed');

                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(Action1102755020)
                {
                }
                action("<Action135>")
                {
                    ApplicationArea = Basic;
                    Caption = '&Send BizTalk Rqst. for Purch. Quote';

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        //IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                        //  BizTalkManagement.SendReqforPurchQuote(Rec);
                    end;
                }
            }
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


                    if LinesCommitted then
                       Error('All Lines should be committed');
                      Reset;
                      SetRange("No.","No.");
                      Report.Run(51516358,true,true,Rec);
                      Reset;
                    //DocPrint.PrintPurchHeader(Rec);
                end;
            }
            action(PurchHistoryBtn)
            {
                ApplicationArea = Basic;
                Caption = 'Purchase H&istory';
                Visible = PurchHistoryBtnVisible;

                trigger OnAction()
                begin
                    //PurchInfoPaneMgmt.LookupVendPurchaseHistory(Rec,"Pay-to Vendor No.",TRUE);
                end;
            }
            action("<Action158>")
            {
                ApplicationArea = Basic;
                Caption = '&Contacts';

                trigger OnAction()
                begin
                    //PurchInfoPaneMgmt.LookupContacts(Rec);
                end;
            }
            action("<Action159>")
            {
                ApplicationArea = Basic;
                Caption = 'Order &Addresses';

                trigger OnAction()
                begin
                    //PurchInfoPaneMgmt.LookupOrderAddr(Rec);
                end;
            }
        }
    }

    var
        PurchSetup: Record "Purchases & Payables Setup";
        CopyPurchDoc: Report "Copy Purchase Document";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management BRr";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchInfoPaneMgmt: Codeunit "Purchases Info-Pane Management";
        Commitment: Codeunit "Budgetary Control";
        BCSetup: Record "Budgetary Control Setup";
        DeleteCommitment: Record Committment;
        PurchLine: Record "Purchase Line";
        [InDataSet]
        PurchHistoryBtnVisible: Boolean;
        [InDataSet]
        PayToCommentPictVisible: Boolean;
        [InDataSet]
        PayToCommentBtnVisible: Boolean;
        [InDataSet]
        PurchHistoryBtn1Visible: Boolean;
        [InDataSet]
        PurchLinesEditable: Boolean;
        ApprovalEntries: Page "Approval Entries";

    local procedure ApproveCalcInvDisc()
    begin
    end;

    local procedure UpdateInfoPanel()
    var
        DifferBuyFromPayTo: Boolean;
    begin
        DifferBuyFromPayTo := "Buy-from Vendor No." <> "Pay-to Vendor No.";
        PurchHistoryBtnVisible := DifferBuyFromPayTo;
        PayToCommentPictVisible := DifferBuyFromPayTo;
        PayToCommentBtnVisible := DifferBuyFromPayTo;
        //PurchHistoryBtn1Visible := PurchInfoPaneMgmt.DocExist(Rec,"Buy-from Vendor No.");
        //IF DifferBuyFromPayTo THEN
          //PurchHistoryBtnVisible := PurchInfoPaneMgmt.DocExist(Rec,"Pay-to Vendor No.")
    end;


    procedure LinesCommitted() Exists: Boolean
    var
        PurchLines: Record "Purchase Line";
    begin
         if BCSetup.Get() then  begin
            if not BCSetup.Mandatory then begin
               Exists:=false;
               exit;
            end;
         end else begin
               Exists:=false;
               exit;
         end;
        if BCSetup.Get then begin
         Exists:=false;
         PurchLines.Reset;
         PurchLines.SetRange(PurchLines."Document Type","Document Type");
         PurchLines.SetRange(PurchLines."Document No.","No.");
         PurchLines.SetRange(PurchLines.Committed,false);
          if PurchLines.Find('-') then
             Exists:=true;
        end else
            Exists:=false;
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
             Exists:=true;
        end else
            Exists:=false;
    end;


    procedure UpdateControls()
    begin
              if Status<>Status::Open then begin
                PurchLinesEditable :=false;
              end else
                PurchLinesEditable :=true;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;

        UpdateControls;
    end;
}

