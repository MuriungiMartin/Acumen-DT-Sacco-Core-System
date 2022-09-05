#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516118 "Store Requisitions List-App"
{
    ApplicationArea = Basic;
    CardPageID = "Store Requisition Header";
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Cancellation,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Store Requistion Header P";
    SourceTableView = where(Status = filter(Released));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field("Request date"; "Request date")
                {
                    ApplicationArea = Basic;
                }
                field("Request Description"; "Request Description")
                {
                    ApplicationArea = Basic;
                }
                field("Requester ID"; "Requester ID")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field(TotalAmount; TotalAmount)
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Issuing Store"; "Issuing Store")
                {
                    ApplicationArea = Basic;
                }
                field("Function Name"; "Function Name")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Center Name"; "Budget Center Name")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755010; Notes)
            {
            }
            systempart(Control1102755011; MyNotes)
            {
            }
            systempart(Control1102755012; Links)
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

                        if Status <> Status::Posted then
                            Error('You can only print a Purchase Order after it Fully Approved And Posted');

                        Reset;
                        SetFilter("No.", "No.");
                        Report.Run(51516103, true, true, Rec);
                        Reset;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin

        // if UserMgt.GetPurchasesFilter() <> '' then begin
        //   FilterGroup(2);
        //   SetRange("Responsibility Center" ,UserMgt.GetPurchasesFilter());
        //   FilterGroup(0);
        // end;
        /*
        HREmp.RESET;
        HREmp.SETRANGE(HREmp."User ID",USERID);
        IF HREmp.GET THEN
        SETRANGE("User ID",HREmp."User ID")
        ELSE
        //user id may not be the creator of the doc
        SETRANGE("User ID",USERID);
        */
        /*
        IF UserMgt.GetSetDimensions(USERID,2) <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Shortcut Dimension 2 Code",UserMgt.GetSetDimensions(USERID,2));
          FILTERGROUP(0);
        END;
        */

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
        HREmp: Record "HR Employees";


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
}

