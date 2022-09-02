#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516014 "CustomizedWorkflowEvents"
{
    // 1.This codeunit is used for new workflow events


    trigger OnRun()
    begin
    end;


    procedure StoWorkflowEventCode(): Code[128]
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddMyWorkflowEventToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(StoWorkflowEventCode,Database::"Standing Orders",'Sto workflo Approval is sent.',0,false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::Stopost, 'OnPostSto', '', false, false)]

    procedure RunWorkflowOnSendStoApproval(var STO: Record "Standing Orders")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(StoWorkflowEventCode,STO);
    end;
}

