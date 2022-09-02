#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516276 "HR Leave Reimbursment List"
{
    ApplicationArea = Basic;
    CardPageID = "HR Leave Reimbursment Card";
    DeleteAllowed = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Functions,Comments';
    SourceTable = "ReceiptsProcessing. Checkoff";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Staff/Payroll No";"Staff/Payroll No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application No';
                    Editable = "Application CodeEditable";
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Leave Application No";"Leave Application No")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center";"Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = "Responsibility CenterEditable";
                }
                field("No Repayment";"No Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = "Leave TypeEditable";
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                                            GetLeaveStats("No Repayment");
                        //                    CurrPage.UPDATE;
                    end;
                }
                field("Staff Not Found";"Staff Not Found")
                {
                    ApplicationArea = Basic;
                    Editable = "Days AppliedEditable";
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                                           //HREmp.GET("Employee No");
                                            if "No Repayment"='ANNUAL' then
                                            if "Staff Not Found">dLeft then
                                            Error('Days applied cannot exceed leave balance');
                        
                                          /*
                                           IF "Days Applied">HREmp."Acrued Leave Days" THEN
                                           ERROR('Days applied cannot exceed acrued Leave Days')
                                           END
                                          */

                    end;
                }
                field("Date Filter";"Date Filter")
                {
                    ApplicationArea = Basic;
                    Editable = "Start DateEditable";
                    Importance = Promoted;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No";"Employee No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee No.';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field(EmpName;EmpName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Applicant Name';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Job Tittle";"Job Tittle")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Title';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field(EmpJobDesc;EmpJobDesc)
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Description';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field(EmpDept;EmpDept)
                {
                    ApplicationArea = Basic;
                    Caption = 'Department';
                    Editable = false;
                    Enabled = false;
                }
                field(Supervisor;Supervisor)
                {
                    ApplicationArea = Basic;
                    Editable = SupervisorEditable;

                    trigger OnValidate()
                    begin
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
                field(dEarnd;dEarnd)
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Leave Days';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(dTaken;dTaken)
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Leave Taken';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(dLeft;dLeft)
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Balance';
                    Editable = false;
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Application Date";"Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = true;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
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
                action(Attachments)
                {
                    ApplicationArea = Basic;
                    Caption = 'Attachments';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Leave Documents";
                    RunPageLink = "Doc No."=field("Staff/Payroll No");
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
                action("Re-Open")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re-Open';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                                                 Name:=Name::"0";
                                                 Modify;
                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Caption = 'Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HRLeaveApp.Reset;
                        HRLeaveApp.SetRange(HRLeaveApp."Application Code","Staff/Payroll No");
                        if HRLeaveApp.Find('-') then
                        Report.Run(55491,true,true,HRLeaveApp);
                    end;
                }
                action("Create Leave Ledger Entries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Leave Ledger Entries';
                    Image = CreateLinesFromJob;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                                                    CreateLeaveLedgerEntries;
                                                    Reset;
                    end;
                }
                action("&Post Leave Application")
                {
                    ApplicationArea = Basic;
                    Caption = '&Post Leave Application';
                    Image = Post;

                    trigger OnAction()
                    begin
                        if Name=Name::"10" then Error('This Leave application has already been posted');
                        if Name<>Name::"7" then
                        Error('The Leave Status must be Approved')
                        else
                        HRLeaveApp.Reset;
                        HRLeaveApp.SetRange(HRLeaveApp."Application Code","Staff/Payroll No");
                        if HRLeaveApp.Find('-')then begin
                        HRLeaveApp.CreateLeaveLedgerEntries;

                        end;
                             //Dave---To notify leave applicant

                        HREmp.Get("Employee No");
                        HREmp.TestField(HREmp."Company E-Mail");

                        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
                        HREmailParameters.Reset;
                        HREmailParameters.SetRange(HREmailParameters."Associate With",HREmailParameters."associate with"::"Interview Invitations");
                        if HREmailParameters.Find('-') then
                        begin


                             HREmp.TestField(HREmp."Company E-Mail");
                             SMTP.CreateMessage(HREmailParameters."Sender Name",HREmailParameters."Sender Address",HREmp."Company E-Mail",
                             HREmailParameters.Subject,'Dear'+' '+ HREmp."First Name" +' '+
                             HREmailParameters.Body+' '+"Staff/Payroll No"+' '+ HREmailParameters."Body 2",true);
                             SMTP.Send();


                        Message('Leave applicant has been notified successfully');
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
                                   EmpDept:='';
                                   //PASS VALUES TO VARIABLES ON THE FORM
                                   FillVariables;
                                   //GET LEAVE STATS FOR THIS EMPLOYEE FROM THE EMPLOYEE TABLE
                                   GetLeaveStats("No Repayment");
                                   //TO PREVENT USER FROM SEEING OTHER PEOPLES LEAVE APPLICATIONS
                                  //SETFILTER("User ID",USERID);

                                   Updatecontrols;
    end;

    trigger OnInit()
    begin
        NumberofPreviousAttemptsEditab := true;
        "Date of ExamEditable" := true;
        "Details of ExaminationEditable" := true;
        "Cell Phone NumberEditable" := true;
        SupervisorEditable := true;
        RequestLeaveAllowanceEditable := true;
        RelieverEditable := true;
        "Leave Allowance AmountEditable" := true;
        "Start DateEditable" := true;
        "Responsibility CenterEditable" := true;
        "Days AppliedEditable" := true;
        "Leave TypeEditable" := true;
        "Application CodeEditable" := true;
    end;

    var
        HREmp: Record "HR Employees";
        EmpJobDesc: Text[50];
        HRJobs: Record "HR Jobss";
        SupervisorName: Text[60];
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
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        HRLeaveApp: Record "HR Leave Application";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval";
        ApprovalEntries: Page "Approval Entries";
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
        EmpName: Text[70];
        ApprovalComments: Page "Approval Comments";
        [InDataSet]
        "Application CodeEditable": Boolean;
        [InDataSet]
        "Leave TypeEditable": Boolean;
        [InDataSet]
        "Days AppliedEditable": Boolean;
        [InDataSet]
        "Responsibility CenterEditable": Boolean;
        [InDataSet]
        "Start DateEditable": Boolean;
        [InDataSet]
        "Leave Allowance AmountEditable": Boolean;
        [InDataSet]
        RelieverEditable: Boolean;
        [InDataSet]
        RequestLeaveAllowanceEditable: Boolean;
        [InDataSet]
        SupervisorEditable: Boolean;
        [InDataSet]
        "Cell Phone NumberEditable": Boolean;
        [InDataSet]
        "Details of ExaminationEditable": Boolean;
        [InDataSet]
        "Date of ExamEditable": Boolean;
        [InDataSet]
        NumberofPreviousAttemptsEditab: Boolean;
        Text19010232: label 'Leave Statistics';
        Text1: label 'Reliver Details';
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        varDaysApplied: Integer;
        HRLeaveTypes: Record "HR Leave Types";
        BaseCalendarChange: Record "Base Calendar Change";
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        LeaveGjline: Record "HR Journal Line";
        "LineNo.": Integer;
        sDate: Record Date;
        Customized: Record "HR Calendar List";
        HREmailParameters: Record "HR E-Mail Parameters";
        HRLeavePeriods: Record "HR Leave Periods";
        HRJournalBatch: Record "HR Leave Journal Batch";


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
                                    //HREmp.SETFILTER(HREmp."Leave Type Filter",LeaveType);
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
                                        TestField("No Repayment");
                                        TestField("Staff Not Found");
                                        TestField("Date Filter");
                                        TestField(Reliever);
                                        TestField(Supervisor);
    end;


    procedure Updatecontrols()
    begin

        if Name=Name::"0" then begin
        "Application CodeEditable" :=true;
        "Leave TypeEditable" :=true;
        "Days AppliedEditable" :=true;
        "Responsibility CenterEditable" :=true;
        "Start DateEditable" :=true;
        "Leave Allowance AmountEditable" :=true;
        RelieverEditable :=true;
        RequestLeaveAllowanceEditable :=true;
        SupervisorEditable :=true;
        "Cell Phone NumberEditable" :=true;
        //CurrForm."E-mail Address".EDITABLE:=TRUE;
        "Details of ExaminationEditable" :=true;
        "Date of ExamEditable" :=true;
        NumberofPreviousAttemptsEditab :=true;
        end else begin
        "Application CodeEditable" :=false;
        "Leave TypeEditable" :=false;
        "Days AppliedEditable" :=false;
        "Responsibility CenterEditable" :=false;
        "Start DateEditable" :=false;
        "Leave Allowance AmountEditable" :=false;
        RelieverEditable :=false;
        RequestLeaveAllowanceEditable :=false;
        SupervisorEditable :=false;
        "Cell Phone NumberEditable" :=false;
        //CurrForm."E-mail Address".EDITABLE:=FALSE;
        "Details of ExaminationEditable" :=false;
        "Date of ExamEditable" :=false;
        NumberofPreviousAttemptsEditab :=false;
        end;
    end;


    procedure TestLeaveFamily()
    var
        LeaveFamily: Record "HR Leave Family Groups";
        LeaveFamilyEmployees: Record "HR Leave Family Employees";
        Employees: Record "HR Employees";
    begin
        LeaveFamilyEmployees.SetRange(LeaveFamilyEmployees."Employee No","Employee No");
        if LeaveFamilyEmployees.FindSet then //find the leave family employee is associated with
        repeat
          LeaveFamily.SetRange(LeaveFamily.Code,LeaveFamilyEmployees.Family);
          LeaveFamily.SetFilter(LeaveFamily."Max Employees On Leave",'>0');
          if LeaveFamily.FindSet then //find the status other employees on the same leave family
            begin
              Employees.SetRange(Employees."No.",LeaveFamilyEmployees."Employee No");
              Employees.SetRange(Employees."Leave Status",Employees."leave status"::" ");
              if Employees.Count>LeaveFamily."Max Employees On Leave" then
              Error('The Maximum number of employees on leave for this family has been exceeded, Contact th HR manager for more information');
            end
        until LeaveFamilyEmployees.Next = 0;
    end;


    procedure DetermineLeaveReturnDate(var fBeginDate: Date;var fDays: Decimal) fReturnDate: Date
    begin
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        repeat
          if DetermineIfIncludesNonWorking("No Repayment") =false then begin
            fReturnDate := CalcDate('1D', fReturnDate);
            if DetermineIfIsNonWorking(fReturnDate) then
              varDaysApplied := varDaysApplied + 1
            else
              varDaysApplied := varDaysApplied;
            varDaysApplied := varDaysApplied - 1
          end
          else begin
            fReturnDate := CalcDate('1D', fReturnDate);
            varDaysApplied := varDaysApplied - 1;
          end;
        until varDaysApplied = 0;
        exit(fReturnDate);
    end;


    procedure DetermineIfIncludesNonWorking(var fLeaveCode: Code[10]): Boolean
    begin
        if HRLeaveTypes.Get(fLeaveCode) then begin
        if HRLeaveTypes."Inclusive of Non Working Days" = true then
        exit(true);
        end;
    end;


    procedure DetermineIfIsNonWorking(var bcDate: Date) Isnonworking: Boolean
    begin
        
        HRSetup.Find('-');
        HRSetup.TestField(HRSetup."Base Calendar");
        BaseCalendarChange.SetFilter(BaseCalendarChange."Base Calendar Code",HRSetup."Base Calendar");
        BaseCalendarChange.SetRange(BaseCalendarChange.Date,bcDate);
        
        if BaseCalendarChange.Find('-') then begin
        if BaseCalendarChange.Nonworking = false then
        Error('Start date can only be a Working Day Date');
        exit(true);
        end;
        
        /*
        Customized.RESET;
        Customized.SETRANGE(Customized.Date,bcDate);
        IF Customized.FIND('-') THEN BEGIN
            IF Customized."Non Working" = TRUE THEN
            EXIT(TRUE)
            ELSE
            EXIT(FALSE);
        END;
         */

    end;


    procedure DeterminethisLeaveEndDate(var fDate: Date) fEndDate: Date
    begin
        ReturnDateLoop := true;
        fEndDate := fDate;
        if fEndDate <> 0D then begin
          fEndDate := CalcDate('-1D', fEndDate);
          while (ReturnDateLoop) do begin
          if DetermineIfIsNonWorking(fEndDate) then
            fEndDate := CalcDate('-1D', fEndDate)
           else
            ReturnDateLoop := false;
          end
          end;
        exit(fEndDate);
    end;


    procedure CreateLeaveLedgerEntries()
    begin
        HRSetup.Reset;
        if HRSetup.Find('-') then begin
        
        LeaveGjline.Reset;
        LeaveGjline.SetRange("Journal Template Name",HRSetup."Leave Template");
        LeaveGjline.SetRange("Journal Batch Name",HRSetup."Leave Batch");
        LeaveGjline.DeleteAll;
          //Dave
        //HRSetup.TESTFIELD(HRSetup."Leave Template");
        //HRSetup.TESTFIELD(HRSetup."Leave Batch");
        
        HREmp.Get("Employee No");
        HREmp.TestField(HREmp."Company E-Mail");
        
        //POPULATE JOURNAL LINES
        
        "LineNo.":=10000;
        LeaveGjline.Init;
        LeaveGjline."Journal Template Name":=HRSetup."Leave Template";
        LeaveGjline."Journal Batch Name":=HRSetup."Leave Batch";
        LeaveGjline."Line No.":="LineNo.";
        LeaveGjline."Leave Period":='2013';
        LeaveGjline."Document No.":="Staff/Payroll No";
        LeaveGjline."Staff No.":="Employee No";
        LeaveGjline.Validate(LeaveGjline."Staff No.");
        LeaveGjline."Posting Date":=Today;
        LeaveGjline."Leave Entry Type":=LeaveGjline."leave entry type"::Negative;
        LeaveGjline."Leave Approval Date":=Today;
        LeaveGjline.Description:='Leave Taken';
        LeaveGjline."Leave Type":="No Repayment";
        //------------------------------------------------------------
        //HRSetup.RESET;
        //HRSetup.FIND('-');
        HRSetup.TestField(HRSetup."Leave Posting Period[FROM]");
        HRSetup.TestField(HRSetup."Leave Posting Period[TO]");
        //------------------------------------------------------------
        LeaveGjline."Leave Period Start Date":=HRSetup."Leave Posting Period[FROM]";
        LeaveGjline."Leave Period End Date":=HRSetup."Leave Posting Period[TO]";
        if LeaveGjline."No. of Days"<>0 then
        LeaveGjline.Insert(true);
        
        
        //Post Journal
        LeaveGjline.Reset;
        LeaveGjline.SetRange("Journal Template Name",HRSetup."Leave Template");
        LeaveGjline.SetRange("Journal Batch Name",HRSetup."Leave Batch");
        if LeaveGjline.Find('-') then begin
        Codeunit.Run(Codeunit::Codeunit55560,LeaveGjline);
        end;
        Name:=Name::"10";
        Modify;
        
        /*END ELSE BEGIN
        ERROR('You must specify no of days');
        END;
        END;*/
        //NotifyApplicant;
        end;

    end;


    procedure NotifyApplicant()
    begin
        HREmp.Get("Employee No");
        HREmp.TestField(HREmp."Company E-Mail");

        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
        HREmailParameters.Reset;
        HREmailParameters.SetRange(HREmailParameters."Associate With",HREmailParameters."associate with"::"Interview Invitations");
        if HREmailParameters.Find('-') then
        begin


             HREmp.TestField(HREmp."Company E-Mail");
             SMTP.CreateMessage(HREmailParameters."Sender Name",HREmailParameters."Sender Address",HREmp."Company E-Mail",
             HREmailParameters.Subject,'Dear'+' '+ HREmp."First Name" +' '+
             HREmailParameters.Body+' '+"Staff/Payroll No"+' '+ HREmailParameters."Body 2",true);
             SMTP.Send();


        Message('Leave applicant has been notified successfully');
        end;
    end;
}

