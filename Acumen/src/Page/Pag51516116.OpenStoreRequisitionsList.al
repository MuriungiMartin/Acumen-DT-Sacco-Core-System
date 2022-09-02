#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516116 "Open Store Requisitions List"
{
    ApplicationArea = Basic;
    Caption = 'Released Store Requisitions';
    CardPageID = "Store Requisition Header";
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Cancellation,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Store Requistion Header P";
    SourceTableView = where(Status=const(Open),
                            Cancelled=const(false));
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
                field("Request date";"Request date")
                {
                    ApplicationArea = Basic;
                }
                field("Request Description";"Request Description")
                {
                    ApplicationArea = Basic;
                }
                field("Requester ID";"Requester ID")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field(TotalAmount;TotalAmount)
                {
                    ApplicationArea = Basic;
                }
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Issuing Store";"Issuing Store")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755010;Notes)
            {
            }
            systempart(Control1102755011;MyNotes)
            {
            }
            systempart(Control1102755012;Links)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action1102755026>")
            {
                Caption = '&Functions';
                action("<Action1102755028>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Store Requisition';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                           Error('Open the store requisition card to post. Thank you!!');

                        if not LinesExists then
                           Error('There are no Lines created for this Document');

                           if Status=Status::Posted then
                              Error('The Document Has Already been Posted');

                           if Status<>Status::Released    then
                              Error('The Document Has not yet been Approved');


                            TestField("Issuing Store");
                            ReqLine.Reset;
                            ReqLine.SetRange(ReqLine."Requistion No","No.");
                            TestField("Issuing Store");
                            if ReqLine.Find('-') then begin
                            repeat
                            //Issue
                              if InventorySetup.Get then begin
                                     InventorySetup.TestField(InventorySetup."Item Jnl Template");
                                     InventorySetup.TestField(InventorySetup."Item Jnl Batch");
                                     GenJnline.Reset;
                                     GenJnline.SetRange(GenJnline."Journal Template Name",InventorySetup."Item Jnl Template");
                                     GenJnline.SetRange(GenJnline."Journal Batch Name",InventorySetup."Item Jnl Batch");
                                     if GenJnline.Find('-') then GenJnline.DeleteAll;
                                     LineNo:=LineNo+1000;
                                     GenJnline.Init;
                                     GenJnline."Journal Template Name":=InventorySetup."Item Jnl Template";
                                     GenJnline."Journal Batch Name":=InventorySetup."Item Jnl Batch";
                                     GenJnline."Line No.":=LineNo;
                                     GenJnline."Entry Type":=GenJnline."entry type"::"Negative Adjmt.";
                                     GenJnline."Document No.":="No.";
                                     GenJnline."Item No.":=ReqLine."No.";
                                     GenJnline.Validate("Item No.");
                                     GenJnline."Location Code":="Issuing Store";
                                     GenJnline.Validate("Location Code");
                                     GenJnline."Posting Date":="Request date";
                                     GenJnline.Description:=ReqLine.Description;
                                     GenJnline.Quantity:=ReqLine.Quantity;
                                     GenJnline."Shortcut Dimension 1 Code":="Global Dimension 1 Code";
                                     GenJnline.Validate("Shortcut Dimension 1 Code");
                                     GenJnline."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
                                     GenJnline.Validate("Shortcut Dimension 2 Code");
                                     GenJnline.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                                     GenJnline.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                                     GenJnline.Validate(Quantity);
                                     GenJnline.Validate("Unit Amount");
                                     GenJnline."Reason Code":='221';
                                     GenJnline.Validate("Reason Code");
                                     GenJnline.Insert(true);

                                     ReqLine."Request Status":=ReqLine."request status"::Closed;

                                  end;
                           until ReqLine. Next=0;
                                    //Post Entries
                                    GenJnline.Reset;
                                    GenJnline.SetRange(GenJnline."Journal Template Name",InventorySetup."Item Jnl Template");
                                    GenJnline.SetRange(GenJnline."Journal Batch Name",InventorySetup."Item Jnl Batch");
                                    Codeunit.Run(Codeunit::"Item Jnl.-Post",GenJnline);
                                    //End Post entries

                                  //Modify All
                                  Post:=false;
                                  Post:=JournlPosted.PostedSuccessfully();
                                  if Post then
                                        ReqLine.ModifyAll(ReqLine."Request Status",ReqLine."request status"::Closed);
                           end;
                    end;
                }
                separator(Action1102755018)
                {
                }
                action("<Action1102755032>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType:=Documenttype::Requisition;
                        ApprovalEntries.Setfilters(Database::Transactions,DocumentType,"No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("<Action1102755030>")
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

                        //Release the Imprest for Approval
                        // IF ApprovalMgt.SendSRequestApprovalRequest(Rec) THEN;
                    end;
                }
                action("<Action1102755031>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                         //IF ApprovalMgt.CancelSRRequestApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                separator(Action1102755014)
                {
                }
                action("<Action1102755036>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Print/Preview';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                           if Status<>Status::Posted then
                            Error('You can only print a Material Requisition after it Fully Approved And Posted');


                        Reset;
                        SetFilter("No.","No.");
                        Report.Run(51516103,true,true,Rec);
                        Reset;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        /*
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center" ,UserMgt.GetPurchasesFilter());
          FILTERGROUP(0);
        END;
        
        IF UserMgt.GetSetDimensions(USERID,2) <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Shortcut Dimension 2 Code",UserMgt.GetSetDimensions(USERID,2));
          FILTERGROUP(0);
        END;
        */
        /*HREmp.RESET;
        HREmp.SETRANGE(HREmp."User ID",USERID);
        IF HREmp.GET THEN
        SETRANGE("User ID",HREmp."User ID")
        ELSE*/
        //user id may not be the creator of the doc
        SetRange("User ID",UserId);

    end;

    var
        UserMgt: Codeunit "User Setup Management BRr";
        ReqLine: Record "Store Requistion Lines";
        InventorySetup: Record "Inventory Setup";
        GenJnline: Record "Item Journal Line";
        LineNo: Integer;
        Post: Boolean;
        JournlPosted: Codeunit "Journal Post Successful";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        HREmp: Record "HR Employees";


    procedure LinesExists(): Boolean
    var
        PayLines: Record "Store Requistion Lines";
    begin
         HasLines:=false;
         PayLines.Reset;
         PayLines.SetRange(PayLines."Requistion No","No.");
          if PayLines.Find('-') then begin
             HasLines:=true;
             exit(HasLines);
          end;
    end;
}

