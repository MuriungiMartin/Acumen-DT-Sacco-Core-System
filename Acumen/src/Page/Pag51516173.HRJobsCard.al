#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516173 "HR Jobs Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions,Job';
    SourceTable = "HR Jobss";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = Edit;
                field("Job ID"; "Job ID")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Job Description"; "Job Description")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Position Reporting to"; "Position Reporting to")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Grade; Grade)
                {
                    ApplicationArea = Basic;
                }
                field("Main Objective"; "Main Objective")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor/Manager"; "Supervisor/Manager")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Name"; "Supervisor Name")
                {
                    ApplicationArea = Basic;
                }
                field("No of Posts"; "No of Posts")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Occupied Positions"; "Occupied Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Vacant Positions"; "Vacant Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Requisitions"; "Employee Requisitions")
                {
                    ApplicationArea = Basic;
                }
                field("Key Position"; "Key Position")
                {
                    ApplicationArea = Basic;
                }
                field("Date Created"; "Date Created")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Is Supervisor"; "Is Supervisor")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account"; "G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HR Jobs Factbox")
            {
                SubPageLink = "Job ID" = field("Job ID");
            }
            systempart(Control1102755006; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Job)
            {
                action("Raise Requisition")
                {
                    ApplicationArea = Basic;
                    Caption = 'Raise Requisition';
                    Image = Job;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Employee Requisition Card";
                    RunPageLink = "Job ID" = field("Job ID");
                }
                action("Job Qualifications")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Qualifications';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Requirement Lines";
                    RunPageLink = "Job Id" = field("Job ID");
                }
                action(Responsibilities)
                {
                    ApplicationArea = Basic;
                    Caption = 'Responsibilities';
                    Image = JobResponsibility;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Responsiblities Lines";
                    RunPageLink = "Job ID" = field("Job ID");
                }
                action(Occupants)
                {
                    ApplicationArea = Basic;
                    Caption = 'Occupants';
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Occupants";
                    RunPageLink = "Job ID" = field("Job ID");
                }
            }
            group(Functions)
            {
                Caption = 'Functions';
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
                        TestField("Job ID");
                        TestField("Job Description");

                        if Status <> Status::New then
                            Error('Stats must be New.');

                        if ApprovalsMgmt.CheckNewJobApprovalWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendNewJobForApproval(Rec);
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
                        if Status <> Status::"Pending Approval" then
                            Error('Stats must be pending approval');

                        if Confirm('Are you sure you want to cancel the approval request ?', true) = false then
                            exit;

                        if ApprovalsMgmt.CheckNewJobApprovalWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnCancelNewJobApprovalRequest(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControls;

        Validate("Vacant Positions");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdateControls
    end;

    var
        HREmployees: Record "HR Employees";
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        Edit: Boolean;

    local procedure UpdateControls()
    begin
        if Status = Status::New then begin
            Edit := true;
        end else
            if (Status = Status::"Pending Approval") or (Status = Status::Rejected) or (Status = Status::Approved) then begin
                Edit := false;
            end;
    end;


    procedure RecordLinkCheck(job: Record "HR Jobss") RecordLnkExist: Boolean
    var
        objRecordLnk: Record "Record Link";
        TableCaption: RecordID;
        objRecord_Link: RecordRef;
    begin
        objRecord_Link.GetTable(job);
        TableCaption := objRecord_Link.RecordId;
        objRecordLnk.Reset;
        objRecordLnk.SetRange(objRecordLnk."Record ID", TableCaption);
        if objRecordLnk.Find('-') then exit(true) else exit(false);
    end;
}

