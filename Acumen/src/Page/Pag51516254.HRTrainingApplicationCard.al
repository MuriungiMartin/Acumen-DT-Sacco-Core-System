#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516254 "HR Training Application Card"
{
    DeleteAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Show';
    SourceTable = "HR Training Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Application No";"Application No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date";"Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No.";"Employee No.")
                {
                    ApplicationArea = Basic;
                    Editable = "Employee No.Editable";
                }
                field("Training Group No.";"Training Group No.")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Participant";"No. of Participant")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name";"Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employee Department";"Employee Department")
                {
                    ApplicationArea = Basic;
                    Editable = "Employee DepartmentEditable";
                }
                field("Course Title";"Course Title")
                {
                    ApplicationArea = Basic;
                    Editable = "Course TitleEditable";
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Purpose of Training";"Purpose of Training")
                {
                    ApplicationArea = Basic;
                    MultiLine = false;
                }
                field("From Date";"From Date")
                {
                    ApplicationArea = Basic;
                }
                field("To Date";"To Date")
                {
                    ApplicationArea = Basic;
                }
                field(Duration;Duration)
                {
                    ApplicationArea = Basic;
                }
                field("Duration Units";"Duration Units")
                {
                    ApplicationArea = Basic;
                }
                field(Location;Location)
                {
                    ApplicationArea = Basic;
                }
                field("Cost Of Training";"Cost Of Training")
                {
                    ApplicationArea = Basic;
                    Caption = 'Estimated Cost';
                }
                field("Approved Cost";"Approved Cost")
                {
                    ApplicationArea = Basic;
                }
                field(Provider;Provider)
                {
                    ApplicationArea = Basic;
                }
                field("Provider Name";"Provider Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Responsibility Center";"Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = "Responsibility CenterEditable";
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755004;"HR Trainings Factbox")
            {
                SubPageLink = "Application No"=field("Application No");
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

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application","Transport Requisition";
                    begin
                        DocumentType:=Documenttype::"Training Application";

                        //ApprovalComments.Setfilters(DATABASE::"HR Training Applications",DocumentType,"Application No");
                        //ApprovalComments.SetUpLine(DATABASE::"HR Training Applications",DocumentType,"Application No");
                        //ApprovalComments.RUN;
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

                        Status:=Status::Approved;
                        Modify;
                        Message('Fully Approved');
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
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    begin
                        //ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
                action("&Print")
                {
                    ApplicationArea = Basic;
                    Caption = '&Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        TestField(Status,Status::Approved);

                        HRTrainingApplications.SetRange(HRTrainingApplications."Application No","Application No");
                        if HRTrainingApplications.Find('-') then
                        Report.Run(51516603,true,true,HRTrainingApplications);
                    end;
                }
                action("<A ction1102755042>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Status:=Status::New;
                        Modify;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        if Status=Status::New then begin
        "Responsibility CenterEditable" :=true;
        "Application NoEditable" :=true;
        "Employee No.Editable" :=true;
        "Employee NameEditable" :=true;
        "Employee DepartmentEditable" :=true;
        "Purpose of TrainingEditable" :=true;
        "Course TitleEditable" :=true;
        end else begin
        "Responsibility CenterEditable" :=false;
        "Application NoEditable" :=false;
        "Employee No.Editable" :=false;
        "Employee NameEditable" :=false;
        "Employee DepartmentEditable" :=false;
        "Purpose of TrainingEditable" :=false;
        "Course TitleEditable" :=false;
        end;
    end;

    trigger OnInit()
    begin
        "Course TitleEditable" := true;
        "Purpose of TrainingEditable" := true;
        "Employee DepartmentEditable" := true;
        "Employee NameEditable" := true;
        "Employee No.Editable" := true;
        "Application NoEditable" := true;
        "Responsibility CenterEditable" := true;
    end;

    var
        HREmp: Record "HR Employees";
        EmpNames: Text[40];
        sDate: Date;
        HRTrainingApplications: Record "HR Training Applications";
        ApprovalComments: Page "Approval Comments";
        [InDataSet]
        "Responsibility CenterEditable": Boolean;
        [InDataSet]
        "Application NoEditable": Boolean;
        [InDataSet]
        "Employee No.Editable": Boolean;
        [InDataSet]
        "Employee NameEditable": Boolean;
        [InDataSet]
        "Employee DepartmentEditable": Boolean;
        [InDataSet]
        "Purpose of TrainingEditable": Boolean;
        [InDataSet]
        "Course TitleEditable": Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;


    procedure TESTFIELDS()
    begin
        TestField("Course Title");
        TestField("From Date");
        TestField("To Date");
        TestField("Duration Units");
        TestField(Duration);
        TestField("Cost Of Training");
        TestField(Location);
        TestField(Provider);
        TestField("Purpose of Training");
    end;
}

