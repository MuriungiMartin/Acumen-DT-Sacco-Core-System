#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516294 "HR Emp Transfer Card"
{
    PageType = Card;
    SourceTable = "HR Employee Transfer Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Request No";"Request No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Requested";"Date Requested")
                {
                    ApplicationArea = Basic;
                }
                field("Date Approved";"Date Approved")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transfer details Updated";"Transfer details Updated")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1000000021;"Hr Employee Transfer Line")
            {
                SubPageLink = "Request No"=field("Request No");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Show")
            {
                Caption = '&Show';
                action(Comments)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = false;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Disciplinary Approvals","Activity Approval","Exit Approval","Medical Claim Approval",Jv,"BackToOffice ","Training Needs",EmpTransfer;
                    begin
                        /*DocumentType:=DocumentType::EmpTransfer;
                        
                        ApprovalComments.SETTABLEVIEW(DATABASE::"HR Employee Transfer Header",DocumentType,"Request No");
                        ApprovalComments.SetUpLine(DATABASE::"HR Employee Transfer Header",DocumentType,"Request No");
                        ApprovalComments.RUN;
                        */

                    end;
                }
                action("Update Changes")
                {
                    ApplicationArea = Basic;
                    Caption = 'Update Changes';
                    Image = Union;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Disciplinary Approvals","Activity Approval","Exit Approval","Medical Claim Approval",Jv,"BackToOffice ","Training Needs",EmpTransfer;
                    begin
                        if "Transfer details Updated"=true then
                        Error('Staff details have been updated already');

                        if Status<>Status::Approved then
                          Error('Document must be first approved before changes are effected');

                        TransferLine.Reset;
                        TransferLine.SetRange(TransferLine."Request No","Request No");
                        if TransferLine.Find('-') then begin

                        Staff.Reset;
                        if Staff.Get(TransferLine."Employee No") then begin
                        Staff.Office:=TransferLine."New Department";
                        Staff."Global Dimension 2 Code":=TransferLine."New Global Dimension 2 Code";
                        Staff.Modify
                          end;
                          end;
                          "Transfer details Updated":=true;
                          Modify;


                          Message('Employee Successfully Transfered to the new department/Branch');
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
            }
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
                        //TransferLine.TESTFIELD(TransferLine."New Department");
                        //TransferLine.TESTFIELD(TransferLine."New Global Dimension 2 Code");

                        if Confirm('Do you want to send for Approval?',true)=false then exit;
                        //IF ApprovalsMgmt.CheckSalesApprovalsWorkflowEnabled(Rec) THEN
                         // ApprovalsMgmt.OnSendSalesDocForApproval(Rec);



                          Status:=Status::Approved;
                          "Date Approved":=Today;
                          Modify;
                          Message('Transaction Approved');
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    begin
                        //ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);

                        if Status<>Status::New then begin
                        Status:=Status::New;

                          Message('Approval Request Cancelled');
                          end;
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        if Status<>Status::New then
          Error('Deletion of transaction Impossible!');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Date Requested":=Today;
    end;

    var
        ApprovalComments: Page "Approval Comments";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        Staff: Record "HR Employees";
        TransferLine: Record "HR Employee Transfer Lines";
}

