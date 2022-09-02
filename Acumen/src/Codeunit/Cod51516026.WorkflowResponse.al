#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516026 "WorkflowResponse"
{
    // 1.Code unit to handle workflow responses


    trigger OnRun()
    begin
    end;

    var
        WorkflowResponse: Codeunit "Workflow Response Handling";


    procedure STOWorkflowResposnseCode(): Code[128]
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]

    procedure AddMyWorkflowResponsetoLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponseToLibrary(STOWorkflowResposnseCode,Database::"Standing Orders",'Approve sto Request.','GROUP 0');
    end;


    procedure StoWorkflowResponse(var STO: Record "Standing Orders")
    begin
        Codeunit.Run(Codeunit::Stopost,STO);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]

    procedure ExecuteWorkflowResponseCode(var ResponseExecuted: Boolean;Variant: Variant;xVariant: Variant;ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowHandling: Codeunit "Workflow Response Handling";
    begin
        /*IF WorkflowResponse.GetApprovalCommentCode(ResponseWorkflowStepInstance.AddResponseToLibrary,0,FALSE)THEN
          CASE WorkflowResponse.AddResponseToLibrary OF
            STOWorkflowResposnseCode:
              BEGIN
                STOWorkflowResposnseCode(Variant);
                ResponseExecuted:=TRUE;
                END;
            END;*/

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]

    procedure AddWorkflowResponseCombinationtolib(ResponseFunctionName: Code[128])
    begin
    end;
}

