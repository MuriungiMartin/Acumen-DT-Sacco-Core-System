#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516985 "CRM Training Card"
{
    PageType = Card;
    SourceTable = "CRM Trainings";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Duration Units"; "Duration Units")
                {
                    ApplicationArea = Basic;
                }
                field(Duration; Duration)
                {
                    ApplicationArea = Basic;
                }
                field("Cost Of Training"; "Cost Of Training")
                {
                    ApplicationArea = Basic;
                }
                field(Location; Location)
                {
                    ApplicationArea = Basic;
                }
                field("Re-Assessment Date"; "Re-Assessment Date")
                {
                    ApplicationArea = Basic;
                }
                field("Need Source"; "Need Source")
                {
                    ApplicationArea = Basic;
                }
                field(Provider; Provider)
                {
                    ApplicationArea = Basic;
                }
                field("Provider Name"; "Provider Name")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approval Status';
                    Editable = false;
                    Importance = Additional;
                }
                field("Training Status"; "Training Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Created On"; "Created On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
            }
            part(Control19; "CRM Trainees")
            {
                SubPageLink = "Training Code" = field(Code);
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(ImportTrainees)
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = XMLport "Import BD Trainees";
            }
            action("Close Training")
            {
                ApplicationArea = Basic;
                Enabled = EnableActivateTraining;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to close this training?', false) = true then begin
                        "Training Status" := "training status"::Closed;
                    end;
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send Approval Request';
                Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Text001: label 'This request is already pending approval';
                    ApprovalsMgmt: Codeunit WorkflowIntegration;
                begin

                    if ApprovalsMgmt.CheckCRMTrainingApprovalsWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendCRMTrainingForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Approvalmgt: Codeunit WorkflowIntegration;
                begin
                    if Confirm('Are you sure you want to cancel this approval request', false) = true then
                        ApprovalsMgmt.OnCancelCRMTrainingApprovalRequest(Rec);
                    Status := Status::Open;
                    Modify;
                end;
            }
            action(Approval)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining;
                begin
                    DocumentType := Documenttype::HouseChange;
                    ApprovalEntries.Setfilters(Database::"House Group Change Request", DocumentType, Code);
                    ApprovalEntries.Run;
                end;
            }
            action("Training Cost/Suppliers")
            {
                ApplicationArea = Basic;
                Image = Form;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "CRM Training Suppliers";
                RunPageLink = "CRM Training No" = field(Code);
            }
        }
    }

    var
        EnableActivateTraining: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        EnabledApprovalWorkflowsExist: Boolean;
}

