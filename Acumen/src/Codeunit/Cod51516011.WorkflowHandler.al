#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516011 "WorkflowHandler"
{

    trigger OnRun()
    begin
    end;

    var
        WorkflowManagement: Codeunit "Workflow Management";
        STO: Record "Standing Orders";
        ApprovalEntryTable: Record "Approval Entry";
        StoNo: Code[20];
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        Workflowsetup: Codeunit "Workflow Setup";
        WEevents: Codeunit "Approvals Mgmt.";

    procedure RunWorkflowOnSendSTOforApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendSTOforApproval'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendSTOforApproval', '', false, false)]

    procedure RunWorkflowOnSendSTOforApproval(var STO: Record "Standing Orders")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendSTOforApprovalCode, STO);
        STO.Status := STO.Status::Pending;
        STO.Modify(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]

    procedure RunWorkflowOnApproveApprovalRequestforSTO(var ApprovalEntry: Record "Approval Entry")
    begin
        STO.Reset;
        STO.SetRange("No.", ApprovalEntry."Document No.");
        if STO.FindFirst then begin
            STO.Status := STO.Status::Approved;
            STO.Modify(true);
        end;
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveApprovalRequestforSTOCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;


    procedure RunWorkflowOnApproveApprovalRequestforSTOCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveApprovalRequestforSTO'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddworkfloEventsToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendSTOforApprovalCode, Database::"Standing Orders", 'Send sto for approval', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprovalRequestforSTOCode, Database::"Approval Entry", 'Approve Approval request for STO', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestforSTOCode, Database::"Approval Entry", 'Reject Approval request for STO', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestforSTOCode, Database::"Approval Entry", 'Delegate Approval request for STO', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddworkflowTablerelationstoLibrary()
    begin
        Workflowsetup.InsertTableRelation(Database::"Standing Orders", 0, Database::"Approval Entry", 22);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]

    procedure RunWorkflowOnRejectApprovalRequestforSTO(var ApprovalEntry: Record "Approval Entry")
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestforSTOCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        STO.Reset;
        STO.SetRange("No.", ApprovalEntry."Document No.");
        if STO.FindFirst then begin
            STO.Status := STO.Status::Rejected;
            STO.Modify(true);
        end;
    end;


    procedure RunWorkflowOnRejectApprovalRequestforSTOCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectApprovalRequestforSTO'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]

    procedure RunWorkflowOnDelegateApprovalRequestforSTO(var ApprovalEntry: Record "Approval Entry")
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateApprovalRequestforSTOCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        STO.Reset;
        STO.SetRange("No.", ApprovalEntry."Document No.");
        if STO.FindFirst then begin
            STO.Status := STO.Status::Open;
            STO.Modify(true);
        end;
    end;


    procedure RunWorkflowOnDelegateApprovalRequestforSTOCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateApprovalRequestforSTO'));
    end;

    [EventSubscriber(Objecttype::Page, 51516449, 'OnAfterActionEvent', 'Send Approval Request', false, false)]
    local procedure SendApprovalRequestSTO(var Rec: Record "Standing Orders")
    begin
        //if WEevents.ISSTOWorkflowEnabled(Rec) then begin
        // WEevents.OnSendSTOforApproval(Rec);
        //  end;
    end;
}

