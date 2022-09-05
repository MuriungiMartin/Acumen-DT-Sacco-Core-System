#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516298 "Hr Asset Transfer Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "HR Asset Transfer Header";
    SourceTableView = where(Transfered = filter(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = edit;
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control9; "Hr Asset Transfer Lines")
            {
                Editable = Line;
                SubPageLink = "No." = field("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control16; Links)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    begin
                        //IF ApprovalsMgmt.check(Rec) THEN
                        //ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                        Status := Status::Approved;
                        Modify;
                        Message('Successful');
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    begin
                        //ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
            }
            action("Print Review")
            {
                ApplicationArea = Basic;
                Caption = 'Print Review';

                trigger OnAction()
                begin

                    RecHeader.Reset;
                    RecHeader.SetFilter(RecHeader."No.", xRec."No.");
                    Report.Run(54371, true, true, RecHeader);
                end;
            }
            action("Transfer Asset")
            {
                ApplicationArea = Basic;
                Image = TransferFunds;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Status <> Status::Approved then
                        Error('You Cannot transfer the asset if this application is not approved.');

                    TransLines.Reset;
                    TransLines.SetRange(TransLines."No.", "No.");
                    if TransLines.FindSet then begin
                        repeat
                            if ObjFAsset.Get(TransLines."Asset No.") then begin
                                ObjFAsset."Responsible Employee" := TransLines."New Responsible Employee Code";
                                ObjFAsset."Global Dimension 1 Code" := TransLines."New Global Dimension 1 Code";
                                ObjFAsset."Global Dimension 2 Code" := TransLines."New Global Dimension 2 Code";
                                ObjFAsset."Location Code" := TransLines."New Asset Location";
                                ObjFAsset.Modify;
                            end;
                        until TransLines.Next = 0;
                        Transfered := true;
                        "Transfered By" := UserId;
                        "Date Transfered" := Today;
                        Modify;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Updatecontrol;
    end;

    trigger OnAfterGetRecord()
    begin
        if Status <> Status::Open then begin
            Line := false;
            Edit := false;
        end
        else
            if Status = Status::Open then begin
                Line := true;
                Edit := true;
            end;
    end;

    trigger OnInit()
    begin
        if Status <> Status::Open then begin
            Line := false;
            Edit := false;
        end
        else
            if Status = Status::Open then begin
                Line := true;
                Edit := true;
            end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if Status <> Status::Open then begin
            Line := false;
            Edit := false;
        end
        else
            if Status = Status::Open then begin
                Line := true;
                Edit := true;
            end;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        if Status <> Status::Open then begin
            Line := false;
            Edit := false;
        end
        else
            if Status = Status::Open then begin
                Line := true;
                Edit := true;
            end;
    end;

    trigger OnOpenPage()
    begin
        if Status <> Status::Open then begin
            Line := false;
            Edit := false;
        end
        else
            if Status = Status::Open then begin
                Line := true;
                Edit := true;
            end;
    end;

    var
        RecHeader: Record "HR Asset Transfer Header";
        ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Requisition","Transport Requisition",JV,"Grant Task","Concept Note",Proposal,"Job Approval","Disciplinary Approvals",GRN,Clearence,Donation,Transfer,PayChange,Budget,GL,"Cash Purchase","Leave Reimburse",Appraisal,Inspection,Closeout,"Lab Request",ProposalProjectsAreas,"Leave Carry over",EmpTransfer,LeavePlanner,HrAssetTransfer;
        Edit: Boolean;
        Line: Boolean;
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        TransLines: Record "HR Asset Transfer Lines";
        ObjFAsset: Record "Fixed Asset";


    procedure Updatecontrol()
    begin
        /*
        IF Status=Status::Open THEN BEGIN
        Edit:=TRUE;
        Line:=TRUE;
        END ELSE IF Status=Status::"Pending Approval" THEN BEGIN
        Edit:=FALSE;
        Line:=FALSE;
        END ELSE IF Status=Status::Approved THEN BEGIN
        Edit:=FALSE;
        Line:=FALSE;
        END
         */

    end;
}

