#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516226 "HR Transport Requisition"
{
    // DrillDownPageID = UnknownPage55651;
    // LookupPageID = UnknownPage55651;

    fields
    {
        field(1; "Application Code"; Code[20])
        {

            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                if "Application Code" <> xRec."Application Code" then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Transport Req Nos");
                    "No series" := '';
                end;
            end;
        }
        field(4; "Days Applied"; Decimal)
        {
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin


                //TESTFIELD("Leave Type");
                //CALCULATE THE END DATE AND RETURN DATE
                begin
                    if ("Days Applied" <> 0) and ("Start Date" <> 0D) then
                        "Return Date" := DetermineLeaveReturnDate("Start Date", "Days Applied");
                    "End Date" := DeterminethisLeaveEndDate("Return Date");
                    Modify;
                end;
            end;
        }
        field(5; "Start Date"; Date)
        {

            trigger OnValidate()
            begin

                if "Start Date" = 0D then begin
                    "Return Date" := 0D;
                    exit;
                end else begin
                    if DetermineIfIsNonWorking("Start Date") = true then begin
                        ;
                        Error('Start date must be a working day');
                    end;
                    Validate("Days Applied");
                end;
            end;
        }
        field(6; "Return Date"; Date)
        {
            Caption = 'Return Date';
            Editable = false;
        }
        field(7; "Application Date"; Date)
        {
        }
        field(12; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,HOD Approval,HR Approval,Final Approval,Rejected,Canceled,Approved,On leave,Resumed';
            OptionMembers = New,"Pending Approval","HOD Approval","HR Approval",MDApproval,Rejected,Canceled,Approved,"On leave",Resumed;
        }
        field(15; "Applicant Comments"; Text[250])
        {
        }
        field(17; "No series"; Code[30])
        {
        }
        field(28; Selected; Boolean)
        {
        }
        field(3900; "End Date"; Date)
        {
            Editable = false;
        }
        field(3921; "E-mail Address"; Date)
        {
            Editable = false;
        }
        field(3924; "Entry No"; Integer)
        {
        }
        field(3936; "Cell Phone Number"; Text[50])
        {
        }
        field(3937; "Request Leave Allowance"; Boolean)
        {
        }
        field(3940; Names; Text[100])
        {
        }
        field(3942; "Leave Allowance Entittlement"; Boolean)
        {
        }
        field(3943; "Leave Allowance Amount"; Decimal)
        {
        }
        field(3945; "Details of Examination"; Text[200])
        {
        }
        field(3947; "Date of Exam"; Date)
        {
        }
        field(3952; Description; Text[30])
        {
        }
        field(3955; "Supervisor Email"; Text[30])
        {
        }
        field(3958; "Job Tittle"; Text[50])
        {
        }
        field(3959; "User ID"; Code[50])
        {
        }
        field(3961; "Employee No"; Code[20])
        {
        }
        field(3962; Supervisor; Code[20])
        {
        }
        field(3963; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center";
        }
        field(3964; Comment; Boolean)
        {
        }
        field(3965; "Purpose of Trip"; Text[100])
        {
        }
        field(3966; "Transport type"; Code[10])
        {
            TableRelation = "HR Lookup Values".Type where(Type = filter("Transport Type"));
        }
        field(3967; "Time of Trip"; Time)
        {
        }
        field(3968; "Pickup Point"; Text[30])
        {
        }
        field(3969; "From Destination"; Text[30])
        {
        }
        field(3970; "To Destination"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Application Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Status <> Status::New then
            Error(mcontent + ' ' + "Application Code" + ' ' + mcontent2);

        /*LVApplicants.RESET;
        LVApplicants.SETRANGE(LVApplicants."Application Code","Application Code");
        IF LVApplicants.FINDFIRST THEN
          BEGIN
                IF (LVApplicants.Status=LVApplicants.Status::Approved) OR
                (LVApplicants.Status=LVApplicants.Status::"Pending Approval") THEN
               ERROR('You Cannot Delete this record, this record if status is not pending');
          END;
          */

    end;

    trigger OnInsert()
    begin
        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Application Code" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Leave Application Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Leave Application Nos.", xRec."No series", 0D, "Application Code", "No series");
        end;
        //GET APPLICANT DETAILS FROM HR EMPLOYEES TABLE AND COPY THEM TO THE LEAVE APPLICATION TABLE
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin
            "Employee No" := HREmp."No.";
            "Job Tittle" := HREmp."Job Title";
            HREmp.Get(HREmp."No.");
            HREmp.CalcFields(HREmp.Picture);
            //Picture:=HREmp.Picture;
            "User ID" := UserId;
        end else begin
            Error('User Must be Setup as an employee first. Consult the HR Officer so as to be setup as an employee')
        end;
        //GET LEAVE APPROVER DETAILS FROM USER SETUP TABLE COPY THEM TO THE LEAVE APPLICATION TABLE
        UserSetup.Reset;
        if UserSetup.Get(UserId) then begin
            Supervisor := UserSetup."Approver ID";
            UserSetup.Reset;
            if UserSetup.Get(Supervisor) then
                "Supervisor Email" := UserSetup."E-Mail";
        end;
        //POPULATE FIELDS
        "Application Date" := Today;
    end;

    trigger OnModify()
    begin
        /*ImprestHeader.RESET;
        ImprestHeader.SETRANGE(ImprestHeader."No.",No);
        IF ImprestHeader.FINDFIRST THEN
          BEGIN
                IF (ImprestHeader.Status=ImprestHeader.Status::Approved) OR
                (ImprestHeader.Status=ImprestHeader.Status::Posted)OR
                (ImprestHeader.Status=ImprestHeader.Status::"Pending Approval") THEN
               ERROR('You Cannot Delete this record its status is not Pending');
          END;
          TESTFIELD(Committed,FALSE);
         */

    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        HREmp: Record "HR Employees";
        varDaysApplied: Integer;
        HRLeaveTypes: Record "HR Leave Types";
        BaseCalendarChange: Record "Base Calendar Change";
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        SMTP: Codeunit "SMTP Mail";
        LeaveGjline: Record "HR Journal Line";
        "LineNo.": Integer;
        ApprovalComments: Record "Approval Comment Line";
        URL: Text[500];
        sDate: Record Date;
        Customized: Record "HR Calendar List";
        HREmailParameters: Record "HR E-Mail Parameters";
        LVApplicants: Record "HR Leave Application";
        mcontent: label 'Status must be new on Leave Application No.';
        mcontent2: label '. Please cancel the approval request and try again';


    procedure DetermineLeaveReturnDate(var fBeginDate: Date; var fDays: Decimal) fReturnDate: Date
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
        /*
        HRSetup.FIND('-');
        HRSetup.TESTFIELD(HRSetup."Base Calendar");
        BaseCalendarChange.SETFILTER(BaseCalendarChange."Base Calendar Code",HRSetup."Base Calendar");
        BaseCalendarChange.SETRANGE(BaseCalendarChange.Date,bcDate);
        
        IF BaseCalendarChange.FIND('-') THEN BEGIN
        IF BaseCalendarChange.Nonworking = TRUE THEN
        ERROR('Start date can only be a Working Day Date');
        EXIT(TRUE);
        END;
        */
        Customized.Reset;
        Customized.SetRange(Customized.Date, bcDate);
        if Customized.Find('-') then begin
            if Customized."Non Working" = true then
                exit(true)
            else
                exit(false);
        end;

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


        HREmp.Get("Employee No");
        HREmp.TestField(HREmp."Company E-Mail");

        Reset;
        SetRange(Selected, true);
        if Find('-') then
            //REPEAT
            Selected := false;
        Modify;

        //POPULATE JOURNAL LINES
        LeaveGjline.Reset;
        LeaveGjline.SetRange("Journal Template Name", 'ISSUE');
        LeaveGjline.SetRange("Journal Batch Name", 'LEAVE');
        LeaveGjline.DeleteAll;


        "LineNo." := 10000;
        LeaveGjline.Init;
        LeaveGjline."Journal Template Name" := 'ISSUE';
        LeaveGjline."Journal Batch Name" := 'LEAVE';
        LeaveGjline."Line No." := "LineNo.";
        LeaveGjline."Leave Period" := '2013';
        LeaveGjline."Document No." := "Application Code";
        LeaveGjline."Staff No." := "Employee No";
        //LeaveGjline."Staff Name"
        LeaveGjline.Validate(LeaveGjline."Staff No.");
        LeaveGjline."Posting Date" := Today;
        LeaveGjline."Leave Entry Type" := LeaveGjline."leave entry type"::Negative;
        LeaveGjline."Leave Approval Date" := Today;
        LeaveGjline.Description := 'Leave Taken';
        //LeaveGjline."Leave Type":="Leave Type";
        //------------------------------------------------------------
        HRSetup.Reset;
        HRSetup.Find('-');
        HRSetup.TestField(HRSetup."Leave Posting Period[FROM]");
        HRSetup.TestField(HRSetup."Leave Posting Period[TO]");
        //------------------------------------------------------------
        LeaveGjline."Leave Period Start Date" := HRSetup."Leave Posting Period[FROM]";
        LeaveGjline."Leave Period End Date" := HRSetup."Leave Posting Period[TO]";
        //--------------------------------------------------------------------------
        ApprovalComments.Reset;
        ApprovalComments.SetRange(ApprovalComments."Document No.", "Application Code");
        ApprovalComments.SetRange(ApprovalComments."User ID", Supervisor);
        if ApprovalComments.Find('-') then
            //ApprovalComments.TESTFIELD(ApprovalComments."Aproved Days");

            LeaveGjline."No. of Days" := ApprovalComments."Approved Days";

        Message(Format(ApprovalComments."Approved Days"));

        LeaveGjline.Insert(true);
        //MESSAGE('Lines copied to HR Journal');


        //Post Journal

        LeaveGjline.Reset;
        LeaveGjline.SetRange("Journal Template Name", 'ISSUE');
        LeaveGjline.SetRange("Journal Batch Name", 'LEAVE');
        if LeaveGjline.Find('-') then begin
            //  Codeunit.Run(Codeunit::Codeunit55560,LeaveGjline);
        end;

        /*END ELSE BEGIN
        ERROR('You must specify no of days');
        END;
        END;*/
        //NotifyApplicant;

    end;


    procedure NotifyApplicant()
    var
        Recipient: List of [Text];
    begin
        HREmp.Get("Employee No");

        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
        HREmailParameters.Reset;
        HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."associate with"::"Interview Invitations");
        if HREmailParameters.Find('-') then begin
            //REPEAT
            HREmp.TestField(HREmp."Company E-Mail");
            Recipient.Add(hremp."Company E-Mail");
            SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address",Recipient,
            HREmailParameters.Subject, 'Dear' + ' ' + HREmp."First Name" + ' ' +
            HREmailParameters.Body + ' ' + "Application Code" + ' ' + HREmailParameters."Body 2", true);
            SMTP.Send();
            //UNTIL HREmp.NEXT=0;

            Message('Leave applicant has been notified');
        end;
    end;
}

