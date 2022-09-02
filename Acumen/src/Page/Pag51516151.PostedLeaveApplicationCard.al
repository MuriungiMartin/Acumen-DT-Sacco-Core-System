#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516151 "Posted  Leave Application Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions,Comments';
    SourceTable = "HR Leave Application";

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
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Responsibility Center";"Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Type";"Leave Type")
                {
                    ApplicationArea = Basic;
                    Editable = "Leave TypeEditable";
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        GetLeaveStats("Leave Type");
                        //  CurrPage.UPDATE;
                        
                        HREmp.Get("Employee No");
                        if "Leave Type"='ANNUAL' then begin
                          if "Days Applied">dLeft then
                           Error('Days applied cannot exceed leave balance for this leave');
                        end else begin
                         HRLeaveTypes.Reset;
                         HRLeaveTypes.SetRange(HRLeaveTypes.Code,"Leave Type");
                         if HRLeaveTypes.Find('-') then begin
                          if "Days Applied">HRLeaveTypes.Days then
                           Error('Days applied cannot exceed leave balance for this leave');
                         end;
                        end;
                        /*
                        IF HREmp.GET("Employee No") THEN BEGIN
                        IF HREmp."Working Sunday"=TRUE THEN
                        SETRANGE("Leave Type",'ANNUAL_W');
                        END;
                        */

                    end;
                }
                field("Days Applied";"Days Applied")
                {
                    ApplicationArea = Basic;
                    Editable = "Days AppliedEditable";
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        HREmp.Get("Employee No");
                        if "Leave Type"='ANNUAL' then begin
                          if "Days Applied">dLeft then
                           Error('Days applied cannot exceed leave balance for this leave');
                        end else begin
                         HRLeaveTypes.Reset;
                         HRLeaveTypes.SetRange(HRLeaveTypes.Code,"Leave Type");
                         if HRLeaveTypes.Find('-') then begin
                          if "Days Applied">HRLeaveTypes.Days then
                           Error('Days applied cannot exceed leave balance for this leave');
                         end;

                        end;
                    end;
                }
                field("Start Date";"Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = "Start DateEditable";
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("Return Date";"Return Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Request Leave Allowance";"Request Leave Allowance")
                {
                    ApplicationArea = Basic;
                }
                label("Employee Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee Details';
                    Style = StrongAccent;
                    StyleExpr = true;
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
                field(Gender;Gender)
                {
                    ApplicationArea = Basic;
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
                field("Approved days";"Approved days")
                {
                    ApplicationArea = Basic;
                }
                label(Control1102755082)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text19010232;
                    Style = StrongAccent;
                    StyleExpr = true;
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
                field("Outstanding Leave Balance";"Outstanding Leave Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";"Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = true;
                }
                label(Control1000000000)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text1;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(Reliever;Reliever)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reliever Code';
                    Editable = RelieverEditable;
                    ShowMandatory = true;
                }
                field("Reliever Name";"Reliever Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
            group("More Leave Details")
            {
                Caption = 'More Leave Details';
                field("Cell Phone Number";"Cell Phone Number")
                {
                    ApplicationArea = Basic;
                    Editable = "Cell Phone NumberEditable";
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("E-mail Address";"E-mail Address")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("Details of Examination";"Details of Examination")
                {
                    ApplicationArea = Basic;
                    Editable = "Details of ExaminationEditable";
                    Importance = Promoted;
                    Visible = false;
                }
                field("Date of Exam";"Date of Exam")
                {
                    ApplicationArea = Basic;
                    Editable = "Date of ExamEditable";
                    Importance = Promoted;
                    Visible = false;
                }
                field("Number of Previous Attempts";"Number of Previous Attempts")
                {
                    ApplicationArea = Basic;
                    Editable = NumberofPreviousAttemptsEditab;
                    Importance = Promoted;
                    Visible = false;
                }
            }
            group("Exam Dates")
            {
                Caption = 'Exam Dates';
                field("Date Of Exam 1";"Date Of Exam 1")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Exam 2";"Date Of Exam 2")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Exam 3";"Date Of Exam 3")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Exam 4";"Date Of Exam 4")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Exam 5";"Date Of Exam 5")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Exam 6";"Date Of Exam 6")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Exam 7";"Date Of Exam 7")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000003;"HR Leave Applicaitons Factbox")
            {
                SubPageLink = "No."=field("Employee No");
            }
            systempart(s;Outlook)
            {
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
                    RunPageLink = "Doc No."=field("Application Code");
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Re-Print")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re-Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HRLeaveApp.Reset;
                        HRLeaveApp.SetRange(HRLeaveApp."Application Code","Application Code");
                        if HRLeaveApp.Find('-') then
                        Report.Run(51516610,true,true,HRLeaveApp);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        HRLeaveApp.Reset;
        HRLeaveApp.SetRange(HRLeaveApp."Application Code","Application Code");
        HRLeaveApp.SetFilter("Date Filter",Format(20180101D)+'..'+Format(HRLeaveApp."Application Date"));
        if HRLeaveApp.Find('-') then
          begin
            HRLeaveApp.CalcFields("Outstanding Leave Balance");
            dLeft:=HRLeaveApp."Outstanding Leave Balance";
          end
    end;

    trigger OnAfterGetRecord()
    begin
                                   EmpDept:='';
                                   //PASS VALUES TO VARIABLES ON THE FORM
                                   FillVariables;
                                   //GET LEAVE STATS FOR THIS EMPLOYEE FROM THE EMPLOYEE TABLE
                                   GetLeaveStats("Leave Type");
                                   //TO PREVENT USER FROM SEEING OTHER PEOPLES LEAVE APPLICATIONS
                                  SetFilter("User ID",UserId);

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
        CalcFields("Outstanding Leave Balance");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Responsibility Center":='FINANCE'
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
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        HRLeaveApp: Record "HR Leave Application";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication;
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
                                    EmpName:=HREmp."First Name"+' '+HREmp."Middle Name"+' '+HREmp."Last Name";
                                    EmpDept:=HREmp."Global Dimension 2 Code";
                                    "Job Tittle":=HREmp.Office;
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
                                    //dLeft :=  HREmp."Leave Balance";
                                    cReimbsd :=HREmp."Cash - Leave Earned";
                                    cPerDay := HREmp."Cash per Leave Day" ;
                                    HREmp.CalcFields(HREmp."Reimbursed Leave Days");
                                    cbf:=HREmp."Reimbursed Leave Days";
                                    end;
    end;


    procedure TESTFIELDS()
    begin
                                        TestField("Leave Type");
                                        TestField("Days Applied");
                                        TestField("Start Date");
                                        TestField(Reliever);
                                        TestField(Supervisor);
    end;


    procedure Updatecontrols()
    begin

        if Status=Status::New then begin
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
        /*varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        REPEAT
          IF DetermineIfIncludesNonWorking("Leave Type") =FALSE THEN BEGIN
            fReturnDate := CALCDATE('1D', fReturnDate);
            IF DetermineIfIsNonWorking(fReturnDate) THEN
              varDaysApplied := varDaysApplied + 1
            ELSE
              varDaysApplied := varDaysApplied;
            varDaysApplied := varDaysApplied - 1
          END
          ELSE BEGIN
            fReturnDate := CALCDATE('1D', fReturnDate);
            varDaysApplied := varDaysApplied - 1;
          END;
        UNTIL varDaysApplied = 0;
        EXIT(fReturnDate);
               */

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
        /*ReturnDateLoop := TRUE;
        fEndDate := fDate;
        IF fEndDate <> 0D THEN BEGIN
          fEndDate := CALCDATE('-1D', fEndDate);
          WHILE (ReturnDateLoop) DO BEGIN
          IF DetermineIfIsNonWorking(fEndDate) THEN
            fEndDate := CALCDATE('-1D', fEndDate)
           ELSE
            ReturnDateLoop := FALSE;
          END
          END;
        EXIT(fEndDate);
         */

    end;


    procedure CreateLeaveLedgerEntries()
    begin
        TestField("Approved days");
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
        LeaveGjline."Leave Period":='2014';
        LeaveGjline."Document No.":="Application Code";
        LeaveGjline."Staff No.":="Employee No";
        LeaveGjline.Validate(LeaveGjline."Staff No.");
        LeaveGjline."Posting Date":=Today;
        LeaveGjline."Leave Entry Type":=LeaveGjline."leave entry type"::Negative;
        LeaveGjline."Leave Approval Date":=Today;
        LeaveGjline.Description:='Leave Taken';
        LeaveGjline."Leave Type":="Leave Type";
        //------------------------------------------------------------
        //HRSetup.RESET;
        //HRSetup.FIND('-');
        HRSetup.TestField(HRSetup."Leave Posting Period[FROM]");
        HRSetup.TestField(HRSetup."Leave Posting Period[TO]");
        //------------------------------------------------------------
        LeaveGjline."Leave Period Start Date":=HRSetup."Leave Posting Period[FROM]";
        LeaveGjline."Leave Period End Date":=HRSetup."Leave Posting Period[TO]";
        LeaveGjline."No. of Days":="Approved days";
        if LeaveGjline."No. of Days"<>0 then
        LeaveGjline.Insert(true);
        
        //Post Journal
        LeaveGjline.Reset;
        LeaveGjline.SetRange("Journal Template Name",HRSetup."Leave Template");
        LeaveGjline.SetRange("Journal Batch Name",HRSetup."Leave Batch");
        if LeaveGjline.Find('-') then begin
        Codeunit.Run(Codeunit::Codeunit55560,LeaveGjline);
        end;
        Status:=Status::Posted;
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
             HREmailParameters.Body+' '+"Application Code"+' '+ HREmailParameters."Body 2",true);
             SMTP.Send();


        Message('Leave applicant has been notified successfully');
        end;
    end;
}

