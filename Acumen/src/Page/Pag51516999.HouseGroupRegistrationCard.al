#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516999 "House Group Registration Card"
{
    PageType = Card;
    SourceTable = "House Groups Registration";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Cell Group Code";"Cell Group Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cell Group Name";"Cell Group Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date Formed";"Date Formed")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Date";"Meeting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Group Leader";"Group Leader")
                {
                    ApplicationArea = Basic;
                }
                field("Group Leader Name";"Group Leader Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Group Leader Email";"Group Leader Email")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assistant group Leader";"Assistant group Leader")
                {
                    ApplicationArea = Basic;
                }
                field("Assistant Group Name";"Assistant Group Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assistant Group Leader Email";"Assistant Group Leader Email")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Credit Officer";"Credit Officer")
                {
                    ApplicationArea = Basic;
                }
                field("Field Officer";"Field Officer")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Place";"Meeting Place")
                {
                    ApplicationArea = Basic;
                }
                field("No of Members";"No of Members")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By";"Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created On";"Created On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(EnableCreateHouse)
            {
                ApplicationArea = Basic;
                Caption = 'Create Group';
                Enabled = EnableCreateHouse;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Create this House Group?',false)=true then begin
                      if ObjSaccoNos.Get then
                        begin
                            ObjSaccoNos.TestField(ObjSaccoNos."House Group Nos");
                             VarHouseNo:=NoSeriesMgt.GetNextNo(ObjSaccoNos."House Group Nos",0D,true);

                            ObjHouseG.Init;
                            ObjHouseG."Cell Group Code":=VarHouseNo;
                            ObjHouseG."Cell Group Name":="Cell Group Name";
                            ObjHouseG."Group Leader":="Group Leader";
                            ObjHouseG."Group Leader Name":="Group Leader Name";
                            ObjHouseG."Group Leader Email":="Group Leader Email";
                            ObjHouseG."Group Leader Phone No":="Group Leader Phone No";
                            ObjHouseG."Assistant group Leader":="Assistant group Leader";
                            ObjHouseG."Assistant Group Name":="Assistant Group Name";
                            ObjHouseG."Assistant Group Leader Email":="Assistant Group Leader Email";
                            ObjHouseG."Assistant Group Leader Phone N":="Assistant Group Leader Phone N";
                            ObjHouseG."Meeting Place":="Meeting Place";
                            ObjHouseG.Insert;

                      end;
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
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    if ApprovalsMgmt.CheckHouseRegistrationApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendHouseRegistrationForApproval(Rec);
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
                    Approvalmgt: Codeunit "Approvals Mgmt.";
                begin
                    if Confirm('Are you sure you want to cancel this approval request',false)=true then
                     ApprovalsMgmt.OnCancelHouseRegistrationApprovalRequest(Rec);
                      Status:=Status::Open;
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
                begin
                    DocumentType:=Documenttype::HouseRegistration;
                    ApprovalEntries.Setfilters(Database::"House Groups Registration",DocumentType,"Cell Group Code");
                    ApprovalEntries.Run;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EnableCreateHouse:=false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist :=true;

        if ((Rec.Status=Status::Approved) ) then
            EnableCreateHouse:=true;
    end;

    trigger OnOpenPage()
    begin
        EnableCreateHouse:=false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist :=true;

        if ((Rec.Status=Status::Approved) ) then
            EnableCreateHouse:=true;
    end;

    var
        ObjCellGroups: Record "Member House Groups";
        ObjCust: Record "Member Register";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff;
        EnableCreateHouse: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        MemberNoEditable: Boolean;
        AccountNoEditable: Boolean;
        ChangeTypeEditable: Boolean;
        AccountTypeEditable: Boolean;
        VarBOSANOKVisible: Boolean;
        VarFOSANOKVisible: Boolean;
        VarAccountAgentVisible: Boolean;
        ObjSaccoNos: Record "Sacco No. Series";
        VarHouseNo: Code[30];
        ObjHouseG: Record "Member House Groups";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

