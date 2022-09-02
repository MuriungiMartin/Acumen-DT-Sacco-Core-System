#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516281 "HR 360 Appraisal Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Appraisal';
    SourceTable = "HR Appraisal Header";

    layout
    {
        area(content)
        {
            group("HR Appraisal Header")
            {
                field("Appraisal No";"Appraisal No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Employee No";"Employee No")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Employee Name";"Employee Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Job Title";"Job Title")
                {
                    ApplicationArea = Basic;
                }
                field("Job Description";"Job Description")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Supervisor;Supervisor)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Appraisal Period";"Appraisal Period")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Appraisal Date";"Appraisal Date")
                {
                    ApplicationArea = Basic;
                }
                field("Evaluation Period Start";"Evaluation Period Start")
                {
                    ApplicationArea = Basic;
                }
                field("Evaluation Period End";"Evaluation Period End")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Stage";"Appraisal Stage")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Appraisal Method";"Appraisal Method")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin

                        //Testfields
                        TestField(Status,Status::Open);
                        TestField("Appraisal Method");

                        if Confirm(Text0003,false,"Appraisal Method") = false then
                        begin
                            Error('Process aborted, Press F5 to discard changes');
                        end else
                        begin
                            //Delete Lines
                            HRAppLines.Reset;
                            HRAppLines.SetRange(HRAppLines."Appraisal No","Appraisal No");
                            HRAppLines.SetRange(HRAppLines."Appraisal Period","Appraisal Period");
                            HRAppLines.SetRange(HRAppLines."Employee No","Employee No");
                            if HRAppLines.Find('-') then
                            begin
                                HRAppLines.DeleteAll;
                                //Subpage Visibility
                                fn_ShowSubPages;
                            end;

                        end;
                    end;
                }
                field("Appraisal Approval Status";"Appraisal Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Promoted;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Promoted;
                }
            }
            part(PersonalObjectives;"HR Appraisal Lines-Objectives")
            {
                ShowFilter = false;
            }
            part(JobSpecificObjectives;"HR 360 Appraisal Lines - JS")
            {
                ShowFilter = false;
            }
            part(EmployeeSubordinatesObjectives;"HR 360 Appraisal Lines - JS")
            {
                ShowFilter = false;
                Visible = SubPageVisible;
            }
            part(PeerObjectives;"HR 360 Appraisal Lines - JS")
            {
                ShowFilter = false;
                Visible = SubPageVisible;
            }
            part(ExternalSourcesObjectives;"HR 360 Appraisal Lines - ExS")
            {
                ShowFilter = false;
                Visible = SubPageVisible;
            }
        }
        area(factboxes)
        {
            systempart(Control43;Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Approvals)
            {
                Caption = 'Approvals';
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
                        //IF ApprovalsMgmt.CheckSalesApprovalsWorkflowEnabled(Rec) THEN
                         // ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
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
                action("Print Form")
                {
                    ApplicationArea = Basic;
                    Caption = 'Print Form';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HRAppHeader.Reset;
                        HRAppHeader.SetRange(HRAppHeader."Appraisal No","Appraisal No");
                        if HRAppHeader.Find('-') then
                           Report.Run(Report::"HR Appraisal Form",true,true,HRAppHeader);
                    end;
                }
            }
            group(ActionGroup1000000008)
            {
                Caption = 'Functions';
                action("Load Appraisal Sections")
                {
                    ApplicationArea = Basic;
                    Image = CreateInteraction;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        TestField("Job Title");
                        TestField(Status,Status::Open);
                        TestField("Appraisal Stage","appraisal stage"::"Target Setting");


                        if Confirm(Text0001,false) = false then exit;

                        //Job Specific
                        HRAppEvalAreas.Reset;
                        HRAppEvalAreas.SetRange(HRAppEvalAreas."Categorize As",HRAppEvalAreas."categorize as"::"Job Specific");
                        HRAppEvalAreas.SetRange(HRAppEvalAreas."Assign To","Job Title");
                        HRAppEvalAreas.SetRange(HRAppEvalAreas."Appraisal Period","Appraisal Period");
                        HRAppEvalAreas.SetRange(HRAppEvalAreas.Blocked,false);
                        if HRAppEvalAreas.Find('-') then
                        begin
                            HRAppLines.Reset;
                            HRAppLines.SetRange(HRAppLines."Appraisal No","Appraisal No");
                            HRAppLines.SetRange(HRAppLines."Appraisal Period","Appraisal Period");
                            HRAppLines.SetRange(HRAppLines."Employee No","Employee No");
                            HRAppLines.SetRange(HRAppLines."Categorize As",HRAppLines."categorize as"::"Job Specific");
                            if HRAppLines.Find('-') then begin
                                HRAppLines.DeleteAll;
                                fn_LoadSections;
                            end else
                            begin
                                fn_LoadSections;
                            end;
                        end else
                        begin
                            //if no sections are found
                            Error(Text0002,"Job Title");
                        end;

                        //Load 360 Sections
                        case "Appraisal Method" of
                            "appraisal method"::"360 Appraisal":
                            begin
                                //Load 360 Sections
                                fn_Load360Sections;
                            end;
                        end;
                        //End for 360
                    end;
                }
                action(SendSupervisor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send to Supervisor';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        TestField("Appraisal Stage","appraisal stage"::"Target Setting");
                        TestField("Employee No");

                        if Confirm('Send to supervisor?',false) = false then exit;

                        "Appraisal Stage":="appraisal stage"::"Target Approval";
                        Message('Appraisal sent to supervisor');
                    end;
                }
                action(ReturnAppraisee)
                {
                    ApplicationArea = Basic;
                    Caption = 'Return to Appraisee';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        TestField("Appraisal Stage","appraisal stage"::"Target Approval");

                        if Confirm('Return to appraisee?',false) = false then exit;

                        "Appraisal Stage":="appraisal stage"::"Target Setting";
                        Message('Appraisal returned to appraisee');
                    end;
                }
                action(ReturnSupervisor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Return to Supervisor';
                    Image = Return;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        TestField("Appraisal Stage","appraisal stage"::"End Year Evalauation");

                        if Confirm('Return to supervisor?',false) = false then exit;

                        "Appraisal Stage":="appraisal stage"::"Target Approval";
                        Message('Appraisal returned to supervisor');
                    end;
                }
                action(ApproveTargets)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve Targets';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        TestField("Appraisal Stage","appraisal stage"::"Target Approval");
                        TestField("Employee No");

                        if Confirm('Approve targets?',false) = false then exit;

                        "Appraisal Stage":="appraisal stage"::"End Year Evalauation";
                        Message('Appraisal targets approved');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        //GET APPLICANT DETAILS FROM HR EMPLOYEES TABLE AND COPY THEM TO THE GOAL SETTING TABLE
        HREmp.Reset;
        if HREmp.Get("Employee No") then
        begin
            "Employee Name":=HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            "Date of Employment":=HREmp."Date Of Joining the Company";
            "Global Dimension 1 Code":=HREmp."Global Dimension 1 Code";
            "Global Dimension 2 Code":=HREmp."Global Dimension 2 Code";
            "Job Title":=HREmp."Job Specification";
            "Contract Type":= HREmp."Contract Type" ;
            "User ID":=HREmp."User ID";
            //Supervisor
            Supervisor:=HREmpCard.GetSupervisor("User ID");
            //Superisor ID
            "Supervisor ID":=HREmpCard.GetSupervisorID("User ID");
            HREmp.CalcFields(HREmp.Picture);
            Picture:=HREmp.Picture;


        end else
        begin
            Error('Employee No'+' '+"Employee No"+' '+'is not assigned to any employee. Consult the HR Officer so as to be setup as an employee')
        end;



        //Show Hide Subpages
        fn_ShowSubPages;
    end;

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        HRAppEvalAreas: Record "HR Appraisal Eval Areas";
        HRAppLines: Record "HR Appraisal Lines";
        Text0001: label 'Load Appraisal Sections?. \\NB: Existing Lines will be deleted';
        HRAppLines2: Record "HR Appraisal Lines";
        HREmp: Record "HR Employees";
        HREmpCard: Page "HR Employee Card";
        HRAppHeader: Record "HR Appraisal Header";
        Text0002: label 'No job specific sections for [Job ID: %1] are defined';
        LastLineNo: Integer;
        HRJobResp: Record "HR Job Responsiblities";
        HRSetup: Record "HR Setup";
        HREmp2: Record "HR Employees";
        SubPageVisible: Boolean;
        Text0003: label 'Change Appraisal Method to [%1]? \\NB: Existing Lines will be deleted';


    procedure enableDisable() enableDisable: Boolean
    begin
         enableDisable:=false;
    end;


    procedure fn_LoadSections()
    begin
        //Load Job Specific Evaluation Sections

        repeat
          //Get last no.
          HRAppLines2.Reset;
          if HRAppLines2.Find('+') then
          begin
              LastLineNo:=HRAppLines2."Line No";
          end else
          begin
              LastLineNo:=1;
          end;

          HRAppLines.Init;

          HRAppLines."Line No":=LastLineNo+1;
          HRAppLines."Appraisal No":="Appraisal No";
          HRAppLines."Appraisal Period":="Appraisal Period";
          HRAppLines."Employee No":="Employee No";
          HRAppLines."Categorize As":=HRAppEvalAreas."Categorize As";
          HRAppLines."Sub Category":=HRAppEvalAreas."Sub Category";
          HRAppLines."Perfomance Goals and Targets":=HRAppEvalAreas.Description;

          HRAppLines.Insert;
        until HRAppEvalAreas.Next=0;

        //message('Process Complete');
    end;


    procedure fn_Load360Sections()
    begin

        //Employee's Subordinates
        HRAppEvalAreas.Reset;
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Categorize As",HRAppEvalAreas."categorize as"::"Employee's Subordinates");
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Appraisal Period","Appraisal Period");
        if HRAppEvalAreas.Find('-') then
        begin
            HRAppLines.Reset;
            HRAppLines.SetRange(HRAppLines."Appraisal No","Appraisal No");
            HRAppLines.SetRange(HRAppLines."Appraisal Period","Appraisal Period");
            HRAppLines.SetRange(HRAppLines."Employee No","Employee No");
            HRAppLines.SetRange(HRAppLines."Categorize As",HRAppLines."categorize as"::"Employee's Subordinates");
            if HRAppLines.Find('-') then
            begin
                HRAppLines.DeleteAll;
                fn_LoadSections;
            end else
            begin
                fn_LoadSections;
            end;
        end;

        //Employee's Peers
        HRAppEvalAreas.Reset;
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Categorize As",HRAppEvalAreas."categorize as"::"Employee's Peers");
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Appraisal Period","Appraisal Period");
        if HRAppEvalAreas.Find('-') then
        begin
            HRAppLines.Reset;
            HRAppLines.SetRange(HRAppLines."Appraisal No","Appraisal No");
            HRAppLines.SetRange(HRAppLines."Appraisal Period","Appraisal Period");
            HRAppLines.SetRange(HRAppLines."Employee No","Employee No");
            HRAppLines.SetRange(HRAppLines."Categorize As",HRAppLines."categorize as"::"Employee's Peers");
            if HRAppLines.Find('-') then
            begin
                HRAppLines.DeleteAll;
                fn_LoadSections;
            end else
            begin
                fn_LoadSections;
            end;
        end;

        //External Sources (Vendors and Customers)
        HRAppEvalAreas.Reset;
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Categorize As",HRAppEvalAreas."categorize as"::"External Sources");
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Appraisal Period","Appraisal Period");
        if HRAppEvalAreas.Find('-') then
        begin
            HRAppLines.Reset;
            HRAppLines.SetRange(HRAppLines."Appraisal No","Appraisal No");
            HRAppLines.SetRange(HRAppLines."Appraisal Period","Appraisal Period");
            HRAppLines.SetRange(HRAppLines."Employee No","Employee No");
            HRAppLines.SetRange(HRAppLines."Categorize As",HRAppLines."categorize as"::"External Sources");
            if HRAppLines.Find('-') then
            begin
                HRAppLines.DeleteAll;
                fn_LoadSections;
            end else
            begin
                fn_LoadSections;
            end;
        end;
    end;


    procedure fn_ShowSubPages()
    begin
        //Visbility of Subpages
        if "Appraisal Method" <> "appraisal method"::"360 Appraisal" then
        begin
            SubPageVisible:=false;
        end else
        begin
            SubPageVisible:=true;
        end;
    end;
}

