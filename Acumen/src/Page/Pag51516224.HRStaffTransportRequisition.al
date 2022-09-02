#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516224 "HR Staff Transport Requisition"
{
    PageType = Card;
    SourceTable = "HR Transport Requisition";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Application Code";"Application Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application No';
                    Editable = false;
                }
                field("Employee No";"Employee No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Applicant No.';
                    Editable = false;
                }
                field(EmpName;EmpName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Applicant Name';
                    Editable = false;
                }
                field("Job Tittle";"Job Tittle")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Title';
                    Editable = false;
                }
                field(EmpJobDesc;EmpJobDesc)
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Description';
                }
                field(EmpDept;EmpDept)
                {
                    ApplicationArea = Basic;
                    Caption = 'Department';
                    Editable = false;
                }
                field("Start Date";"Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Days Applied";"Days Applied")
                {
                    ApplicationArea = Basic;
                    Caption = 'No of Days';
                }
                field("Time of Trip";"Time of Trip")
                {
                    ApplicationArea = Basic;
                }
                field("From Destination";"From Destination")
                {
                    ApplicationArea = Basic;
                }
                field("To Destination";"To Destination")
                {
                    ApplicationArea = Basic;
                }
                field("Return Date";"Return Date")
                {
                    ApplicationArea = Basic;
                }
                field("Purpose of Trip";"Purpose of Trip")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(Supervisor;Supervisor)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SupervisorName;SupervisorName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Supervisor Name';
                    Editable = false;
                }
                field("Supervisor Email";"Supervisor Email")
                {
                    ApplicationArea = Basic;
                    Caption = 'Supervisor Email';
                    Editable = false;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field(Comment;Comment)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                separator(Action1102755017)
                {
                }
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
                separator(Action1102755018)
                {
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Caption = 'Print';
                    Image = Print;

                    trigger OnAction()
                    begin
                        HRLeaveApp.Reset;
                        HRLeaveApp.SetRange(HRLeaveApp."Application Code","Application Code");
                        if HRLeaveApp.Find('-') then
                        Report.Run(53919,true,true,HRLeaveApp);
                    end;
                }
                action("Attachments (Handover Docs)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Attachments (Handover Docs)';

                    trigger OnAction()
                    begin
                        if DoclLink.Get("Application Code",FieldCaption("Application Code")) then begin
                        DoclLink.PlaceFilter(true,DoclLink."Employee No");
                        Page.RunModal(53998,DoclLink);
                        end else begin
                        DoclLink.Init;
                        DoclLink."Employee No":="Application Code";
                        DoclLink."Document Description":=FieldCaption("Application Code");
                        DoclLink.Insert;
                        Commit;
                        DoclLink.PlaceFilter(true,DoclLink."Employee No");
                        Page.RunModal(53998,DoclLink);
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
                                   UpdateControls();
        
                                                           //PASS VALUES TO VARIABLES ON THE FORM
                                   FillVariables;
                                   //GET LEAVE STATS FOR THIS EMPLOYEE FROM THE EMPLOYEE TABLE
                                   //GetLeaveStats("Leave Type");
                                   //TO PREVENT USER FROM SEEING OTHER PEOPLES LEAVE APPLICATIONS
                                  //SETFILTER("User ID",USERID);
                                  /*
                                   IF Status=Status::Approved THEN// or IF Status:=Status::"Pending Approval" THEN
                                   CurrForm.EDITABLE:=FALSE;
        
                                   IF Status=Status::"Pending Approval" THEN// or IF Status:=Status::"Pending Approval" THEN
                                   CurrForm.EDITABLE:=FALSE;
                                  */

    end;

    trigger OnOpenPage()
    begin
                               //SETFILTER("User ID",USERID);
                               /*IF "Employee No"<>'' THEN*/
                               UpdateControls;

    end;

    var
        HREmp: Record "HR Employees";
        EmpJobDesc: Text[30];
        HRJobs: Record "HR Jobss";
        SupervisorName: Text[30];
        SMTP: Codeunit "SMTP Mail";
        URL: Text[500];
        dAlloc: Decimal;
        dEarnd: Decimal;
        dTaken: Decimal;
        dLeft: Decimal;
        cReimbsd: Decimal;
        cPerDay: Decimal;
        cbf: Decimal;
        HRSetup: Record "HR Setup";
        EmpDept: Text[30];
        HRLeaveApp: Record "HR Leave Application";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Budget Transfer","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval";
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
        D: Date;
        EmpName: Text[70];
        DoclLink: Record "HR Leave Attachments";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;


    procedure FillVariables()
    begin
                                    //GET THE APPLICANT DETAILS

                                    HREmp.Reset;
                                    if HREmp.Get("Employee No") then
                                    begin
                                    EmpName:=HREmp.FullName;
                                    EmpDept:=HREmp."Global Dimension 2 Code";
                                    end else begin
                                    EmpDept:='';
                                    end;

                                    //GET THE JOB DESCRIPTION FRON THE HR JOBS TABLE AND PASS IT TO THE VARIABLE
                                    HRJobs.Reset;
                                    if HRJobs.Get("Job Tittle") then
                                    begin
                                    EmpJobDesc:=HRJobs."Job Description";
                                    end else begin
                                    EmpJobDesc:='';
                                    end;

                                    //GET THE APPROVER NAMES
                                    HREmp.Reset;
                                    HREmp.SetRange(HREmp."User ID",Supervisor);
                                    if HREmp.Find('-') then
                                    begin
                                    SupervisorName:=HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                                    end else begin
                                    SupervisorName:='';
                                    end;
    end;


    procedure GetLeaveStats(LeaveType: Text[50])
    begin

                                    dAlloc := 0;
                                    dEarnd := 0;
                                    dTaken := 0;
                                    dLeft := 0;
                                    cReimbsd := 0;
                                    cPerDay := 0;
                                    cbf:=0;
                                    if HREmp.Get("Employee No") then begin
                                    HREmp.SetFilter(HREmp."Leave Type Filter",LeaveType);
                                    HREmp.CalcFields(HREmp."Allocated Leave Days");
                                    dAlloc := HREmp."Allocated Leave Days";
                                    HREmp.Validate(HREmp."Allocated Leave Days");
                                    dEarnd := HREmp."Total (Leave Days)";
                                    HREmp.CalcFields(HREmp."Total Leave Taken");
                                    dTaken := HREmp."Total Leave Taken";
                                    dLeft :=  HREmp."Leave Balance";
                                    cReimbsd :=HREmp."Cash - Leave Earned";
                                    cPerDay := HREmp."Cash per Leave Day" ;
                                    cbf:=HREmp."Reimbursed Leave Days";
                                    end;
    end;


    procedure TESTFIELDS()
    begin
                                        //TESTFIELD("Leave Type");
                                        TestField("Days Applied");
                                        TestField("Start Date");
                                        //TESTFIELD(Reliever);
                                        //TESTFIELD(Supervisor);
    end;


    procedure UpdateControls()
    begin
        
            /*
             IF Status<>Status::New THEN BEGIN
             CurrForm."Leave Type".EDITABLE:=FALSE;
             CurrForm."Days Applied".EDITABLE:=FALSE;
             CurrForm."Start Date".EDITABLE:=FALSE;
             CurrForm.Reliever.EDITABLE:=FALSE;
             CurrForm."Responsibility Center".EDITABLE:=FALSE;
             CurrForm.UPDATECONTROLS();
             END ELSE BEGIN
             CurrForm."Leave Type".EDITABLE:=TRUE;
             CurrForm."Days Applied".EDITABLE:=TRUE;
             CurrForm."Start Date".EDITABLE:=TRUE;
             CurrForm.Reliever.EDITABLE:=TRUE;
             CurrForm."Responsibility Center".EDITABLE:=TRUE;
             CurrForm.UPDATECONTROLS();
             END;
        
             IF Status<>Status::Approved THEN BEGIN
             CurrForm."Leave Type".EDITABLE:=TRUE;
             CurrForm."Days Applied".EDITABLE:=TRUE;
             CurrForm."Start Date".EDITABLE:=TRUE;
             CurrForm.Reliever.EDITABLE:=TRUE;
             CurrForm."Responsibility Center".EDITABLE:=TRUE;
             CurrForm.UPDATECONTROLS();
             END ELSE BEGIN
             CurrForm."Leave Type".EDITABLE:=FALSE;
             CurrForm."Days Applied".EDITABLE:=FALSE;
             CurrForm."Start Date".EDITABLE:=FALSE;
             CurrForm.Reliever.EDITABLE:=FALSE;
             CurrForm."Responsibility Center".EDITABLE:=FALSE;
             CurrForm.UPDATECONTROLS();
             END;
             */

    end;
}

