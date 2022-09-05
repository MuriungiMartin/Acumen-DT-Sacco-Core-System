#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516307 "HR Leave Planner Card"
{
    PageType = Card;
    SourceTable = "HR Leave Planner Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application Code"; "Application Code")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No"; "Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(Names; Names)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Job Tittle"; "Job Tittle")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1000000002; "Hr Leave Planner Lines")
            {
                SubPageLink = "Application Code" = field("Application Code");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
            }
            action("&Approvals")
            {
                ApplicationArea = Basic;
                Caption = '&Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    DocumentType := Documenttype::LeavePlanner;
                    ApprovalEntries.Setfilters(Database::"HR Leave Planner Header", DocumentType, "Application Code");
                    ApprovalEntries.Run;
                end;
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = "Action";
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit WorkflowIntegration;
                    begin
                        //IF ApprovalsMgmt.CheckSalesApprovalsWorkflowEnabled(Rec) THEN
                        //ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit WorkflowIntegration;
                    begin
                        //ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
            }
            action(Print)
            {
                ApplicationArea = Basic;
                Caption = 'Print';
                Image = PrintForm;
                Promoted = true;
                PromotedCategory = Category4;
            }
        }
    }

    var
        OpenApprovalEntriesExist: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Disciplinary Approvals","Activity Approval","Exit Approval","Medical Claim Approval",Jv,"BackToOffice ","Training Needs",EmpTransfer,LeavePlanner;
        ApprovalEntries: Page "Approval Entries";
}

