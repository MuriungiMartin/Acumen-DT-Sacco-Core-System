#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516183 "HR Leave Application"
{
    DrillDownPageID = "HR Leave Applications List";
    LookupPageID = "HR Leave Applications List";

    fields
    {
        field(1;"Application Code";Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                if "Application Code" <> xRec."Application Code" then begin
                  HRSetup.Get;
                  NoSeriesMgt.TestManual(HRSetup."Leave Application Nos.");
                  "No series" := '';
                end;
            end;
        }
        field(3;"Leave Type";Code[30])
        {
            TableRelation = "HR Leave Types".Code;

            trigger OnValidate()
            begin
                HRLeaveTypes.Reset;
                HRLeaveTypes.SetRange(HRLeaveTypes.Code,"Leave Type");
                if HRLeaveTypes.Find('-') then begin
                 HREmp.Reset;
                 HREmp.SetRange(HREmp."No.","Employee No");
                 HREmp.SetRange(HREmp.Gender,HRLeaveTypes.Gender);
                  if HREmp.Find('-') then exit
                  else
                   if HRLeaveTypes.Gender<>HRLeaveTypes.Gender::Both then
                    Error('This leave type is restricted to the '+ Format(HRLeaveTypes.Gender) +' gender');
                end;
            end;
        }
        field(4;"Days Applied";Decimal)
        {

            trigger OnValidate()
            begin
                /*
                TESTFIELD("Leave Type");
                //CALCULATE THE END DATE AND RETURN DATE
                BEGIN
                IF ("Days Applied" <> 0) AND ("Start Date" <> 0D) THEN
                "Return Date" := DetermineLeaveReturnDate("Start Date","Days Applied");
                "End Date" := DeterminethisLeaveEndDate("Return Date");
                MODIFY;
                END;
                 */
                
                CalcFields("Available Days");
                if (("Available Days"=0) or ("Days Applied">"Available Days"))  then begin
                Error('Applied days must not be more than leave balance.');
                end;
                if ("Days Applied" <> 0) and ("Start Date" <> 0D) then begin
                  Validate("Start Date")
                end;
                "Approved days":="Days Applied";

            end;
        }
        field(5;"Start Date";Date)
        {

            trigger OnValidate()
            begin
                /*{
                IF "Leave Type"<>'EMERGENCY' THEN BEGIN
                    Calendar.RESET;
                    Calendar.SETRANGE("Period Type",Calendar."Period Type"::Date);
                    Calendar.SETFILTER("Period Start",'%1..%2',TODAY,"Start Date");
                    empMonths := Calendar.COUNT;
                END ELSE
                     empMonths := 0;
                
                IF "Leave Type"<>'EMERGENCY' THEN BEGIN
                 IF empMonths<30 THEN ERROR('You have to apply for leave one month earlier');
                END;
                 }
                IF "Start Date"=0D THEN BEGIN
                "Return Date":=0D;
                EXIT;
                END ELSE BEGIN
                      IF DetermineIfIsNonWorking("Start Date")= TRUE THEN BEGIN;
                      ERROR('Start date must be a working day');
                      END;
                      VALIDATE("Days Applied");
                END;
                 */
                
                
                
                
                
                //new start date validation
                dates.Reset;
                dates.SetRange(dates."Period Start","Start Date");
                dates.SetFilter(dates."Period Type",'=%1',dates."period type"::Date);
                if dates.Find('-') then
                  if ((dates."Period Name"='Sunday') or (dates."Period Name"='Saturday')) then begin
                  if (dates."Period Name"='Sunday') then Error('You can not start your leave on a Sunday')
                  else if (dates."Period Name"='Saturday') then Error('You can not start your leave on a Saturday')
                  end;
                BaseCalendar.Reset;
                BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code",GeneralOptions."Base Calendar");
                BaseCalendar.SetRange(BaseCalendar.Date,"Start Date");
                if BaseCalendar.Find('-') then begin
                repeat
                if BaseCalendar.Nonworking = true then begin
                if BaseCalendar.Description<>'' then
                 Error('You can not start your Leave on a Holiday - '''+BaseCalendar.Description+'''')
                 else Error('You can not start your Leave on a Holiday');
                end;
                until BaseCalendar.Next=0;
                end;
                
                // For Annual Holidays
                BaseCalendar.Reset;
                BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code",GeneralOptions."Base Calendar");
                BaseCalendar.SetRange(BaseCalendar."Recurring System",BaseCalendar."recurring system"::"Annual Recurring");
                if BaseCalendar.Find('-') then begin
                repeat
                if ((Date2dmy("Start Date",1)=BaseCalendar."Date Day") and (Date2dmy("Start Date",2)=BaseCalendar."Date Month")) then begin
                if BaseCalendar.Nonworking = true then begin
                if BaseCalendar.Description<>'' then
                 Error('You can not start your Leave on a Holiday - '''+BaseCalendar.Description+'''')
                 else Error('You can not start your Leave on a Holiday');
                end;
                end;
                until BaseCalendar.Next=0;
                end;
                
                
                if ("Days Applied" <> 0) and ("Start Date" <> 0D) then begin
                   "End Date":=CalcEndDate("Start Date","Days Applied" );
                   "Return Date" :=CalcReturnDate("End Date");
                   //"Approved End Date":="End Date";
                
                end;
                
                /*Start Date - OnLookup()
                
                End Date - OnValidate()
                
                End Date - OnLookup()
                
                Purpose - OnValidate()
                
                Purpose - OnLookup()
                
                Leave Type - OnValidate()
                  CALCFIELDS("Availlable Days");
                 IF Emp.GET("Employee No") THEN BEGIN
                 Emp.CALCFIELDS(Emp."Leave Balance");
                 "Leave Balance":=Emp."Leave Balance";
                 END;
                  */
                
                
                  if "Start Date"<"Application Date"then
                Error('You cannot Start your leave before the application date');

            end;
        }
        field(6;"Return Date";Date)
        {
            Caption = 'Return Date';
            Editable = true;
        }
        field(7;"Application Date";Date)
        {
        }
        field(12;Status;Option)
        {
            OptionCaption = 'New,Pending Approval,HOD Approval,HR Approval,Final Approval,Rejected,Canceled,Approved,On leave,Resumed,Posted';
            OptionMembers = New,"Pending Approval","HOD Approval","HR Approval",MDApproval,Rejected,Canceled,Approved,"On leave",Resumed,Posted;

            trigger OnValidate()
            begin
                if Status=Status::Approved then
                 begin
                  intEntryNo:=0;

                  HRLeaveEntries.Reset;
                  HRLeaveEntries.SetRange(HRLeaveEntries."Entry No.");
                   if HRLeaveEntries.Find('-') then intEntryNo:=HRLeaveEntries."Entry No.";

                  intEntryNo:=intEntryNo+1;

                  HRLeaveEntries.Init;
                  HRLeaveEntries."Entry No.":=intEntryNo;
                  HRLeaveEntries."Staff No.":="Employee No";
                  HRLeaveEntries."Staff Name":= Names;
                  HRLeaveEntries."Posting Date":=Today;
                  HRLeaveEntries."Leave Entry Type":=HRLeaveEntries."leave entry type"::Negative;
                  HRLeaveEntries."Leave Approval Date":="Application Date";
                  HRLeaveEntries."Document No.":="Application Code";
                  HRLeaveEntries."External Document No.":="Employee No";
                  HRLeaveEntries."Job ID":="Job Tittle";
                  HRLeaveEntries."No. of days":="Days Applied";
                  HRLeaveEntries."Leave Start Date":="Start Date";
                  HRLeaveEntries."Leave Posting Description":='Leave';
                  HRLeaveEntries."Leave End Date":="End Date";
                  HRLeaveEntries."Leave Return Date":="Return Date";
                  HRLeaveEntries."User ID" :="User ID";
                  HRLeaveEntries."Leave Type":="Leave Type";
                  HRLeaveEntries.Insert;
                  "Posting Date":=Today;
                  Modify;
                end;
            end;
        }
        field(15;"Applicant Comments";Text[250])
        {
        }
        field(17;"No series";Code[30])
        {
        }
        field(18;Gender;Option)
        {
            Editable = false;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(28;Selected;Boolean)
        {
        }
        field(31;"Current Balance";Decimal)
        {
        }
        field(36;"Department Code";Code[20])
        {

            trigger OnValidate()
            begin
                /*IF SalCard.GET("No.") THEN BEGIN
                SalCard.Department:="Department Code";
                SalCard.MODIFY;
                END;
                */

            end;
        }
        field(3900;"End Date";Date)
        {
            Editable = false;
        }
        field(3901;"Total Taken";Decimal)
        {
            DecimalPlaces = 2:2;
        }
        field(3921;"E-mail Address";Text[60])
        {
            Editable = false;
            ExtendedDatatype = EMail;
        }
        field(3924;"Entry No";Integer)
        {
        }
        field(3929;"Start Date Filter";Date)
        {
            FieldClass = FlowFilter;
        }
        field(3936;"Cell Phone Number";Text[50])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(3937;"Request Leave Allowance";Boolean)
        {

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.","Employee No");
                if HREmp.Find('-') then begin
                  if HREmp."Leave Allowance Claimed"=true then
                    Error('Leave Allowance has been claimed');
                  Allowance:=HREmp."Leave Allowance Amount";
                  if "Request Leave Allowance"=true then begin
                  "Leave Allowance Amount":=Allowance;

                end
                else begin
                  "Leave Allowance Amount":=0;


                end;
                  //HREmp."Leave Allowance Claimed":=TRUE;
                  //HREmp.MODIFY;

                end;
            end;
        }
        field(3939;Picture;Blob)
        {
        }
        field(3940;Names;Text[100])
        {
        }
        field(3942;"Leave Allowance Entittlement";Decimal)
        {
            CalcFormula = lookup("HR Employees"."Leave Allowance Amount" where ("No."=field("Employee No")));
            FieldClass = FlowField;
        }
        field(3943;"Leave Allowance Amount";Decimal)
        {
        }
        field(3945;"Details of Examination";Text[200])
        {
        }
        field(3947;"Date of Exam";Date)
        {
        }
        field(3949;Reliever;Code[50])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                                    //DISPLAY RELEIVERS NAME
                                    if Reliever = "Employee No" then
                                    Error('Employee cannot relieve him/herself');

                                    if HREmp.Get(Reliever) then
                                    "Reliever Name":=HREmp.FullName;
            end;
        }
        field(3950;"Reliever Name";Text[100])
        {
        }
        field(3952;Description;Text[30])
        {
        }
        field(3955;"Supervisor Email";Text[50])
        {
        }
        field(3956;"Number of Previous Attempts";Text[200])
        {
        }
        field(3958;"Job Tittle";Text[50])
        {
        }
        field(3959;"User ID";Code[50])
        {
        }
        field(3961;"Employee No";Code[20])
        {

            trigger OnValidate()
            begin
                /*HREmp.RESET;
                HREmp.SETRANGE(HREmp."No.","Employee No");
                IF HREmp.FIND('-') THEN BEGIN
                "Employee Name":=HREmp."First Name"+ ' ' +HREmp."Middle Name"+ ' ' +HREmp."Last Name";
                  MODIFY;
                END
                */

            end;
        }
        field(3962;Supervisor;Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(3969;"Responsibility Center";Code[20])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(3970;"Approved days";Integer)
        {

            trigger OnValidate()
            begin
                 if "Approved days">"Days Applied" then
                 Error(TEXT001);
            end;
        }
        field(3971;Attachments;Integer)
        {
            CalcFormula = count("Company Documents" where ("Doc No."=field("Application Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(3972;Emergency;Boolean)
        {
            Description = 'This is used to ensure one can apply annual leave which is emergency';
        }
        field(3973;"Approver Comments";Text[200])
        {
        }
        field(3974;"Available Days";Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" where ("Staff No."=field("Employee No")));
            FieldClass = FlowField;
        }
        field(3975;Reliever2;Code[50])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                                    //DISPLAY RELEIVERS NAME
                                    if Reliever2 = "Employee No" then
                                    Error('Employee cannot relieve him/herself');

                                    if HREmp.Get(Reliever2) then
                                    "Reliever Name2":=HREmp.FullName;
            end;
        }
        field(3976;"Reliever Name2";Text[100])
        {
            Editable = false;
        }
        field(3977;"Date Of Exam 1";Date)
        {

            trigger OnValidate()
            begin
                  if "Date Of Exam 1"<"Application Date"then
                Error('You cannot Start your leave before the application date');


                if "Date Of Exam 1"="Date Of Exam 7"then
                Error('Date already assigned');
                if "Date Of Exam 1"="Date Of Exam 3"then
                Error('Date already assigned');

                if "Date Of Exam 1"="Date Of Exam 4"then
                Error('Date already assigned');

                if "Date Of Exam 1"="Date Of Exam 5"then
                Error('Date already assigned');

                if "Date Of Exam 1"="Date Of Exam 6"then
                Error('Date already assigned');

                if "Date Of Exam 1"="Date Of Exam 2"then
                Error('Date already assigned');
            end;
        }
        field(3978;"Date Of Exam 2";Date)
        {

            trigger OnValidate()
            begin
                  if "Date Of Exam 2"<"Application Date"then
                Error('You cannot Start your leave before the application date');

                if "Date Of Exam 2"="Date Of Exam 1"then
                Error('Date already assigned');
                if "Date Of Exam 2"="Date Of Exam 3"then
                Error('Date already assigned');

                if "Date Of Exam 2"="Date Of Exam 4"then
                Error('Date already assigned');

                if "Date Of Exam 2"="Date Of Exam 5"then
                Error('Date already assigned');

                if "Date Of Exam 2"="Date Of Exam 6"then
                Error('Date already assigned');

                if "Date Of Exam 2"="Date Of Exam 7"then
                Error('Date already assigned');
            end;
        }
        field(3979;"Date Of Exam 3";Date)
        {

            trigger OnValidate()
            begin
                  if "Date Of Exam 3"<"Application Date"then
                Error('You cannot Start your leave before the application date');

                  if "Date Of Exam 3"="Date Of Exam 1"then
                Error('Date already assigned');
                if "Date Of Exam 3"="Date Of Exam 2"then
                Error('Date already assigned');

                if "Date Of Exam 3"="Date Of Exam 4"then
                Error('Date already assigned');

                if "Date Of Exam 3"="Date Of Exam 5"then
                Error('Date already assigned');

                if "Date Of Exam 3"="Date Of Exam 6"then
                Error('Date already assigned');

                if "Date Of Exam 3"="Date Of Exam 7"then
                Error('Date already assigned');
            end;
        }
        field(3980;"Date Of Exam 4";Date)
        {

            trigger OnValidate()
            begin
                  if "Date Of Exam 4"<"Application Date"then
                Error('You cannot Start your leave before the application date');

                if "Date Of Exam 4"="Date Of Exam 1"then
                Error('Date already assigned');
                if "Date Of Exam 4"="Date Of Exam 3"then
                Error('Date already assigned');

                if "Date Of Exam 4"="Date Of Exam 2"then
                Error('Date already assigned');

                if "Date Of Exam 4"="Date Of Exam 5"then
                Error('Date already assigned');

                if "Date Of Exam 4"="Date Of Exam 6"then
                Error('Date already assigned');

                if "Date Of Exam 4"="Date Of Exam 7"then
                Error('Date already assigned');
            end;
        }
        field(3981;"Date Of Exam 5";Date)
        {

            trigger OnValidate()
            begin
                  if "Date Of Exam 5"<"Application Date"then
                Error('You cannot Start your leave before the application date');

                if "Date Of Exam 5"="Date Of Exam 1"then
                Error('Date already assigned');
                if "Date Of Exam 5"="Date Of Exam 3"then
                Error('Date already assigned');

                if "Date Of Exam 5"="Date Of Exam 4"then
                Error('Date already assigned');

                if "Date Of Exam 5"="Date Of Exam 2"then
                Error('Date already assigned');

                if "Date Of Exam 5"="Date Of Exam 6"then
                Error('Date already assigned');

                if "Date Of Exam 5"="Date Of Exam 7"then
                Error('Date already assigned');
            end;
        }
        field(3982;"Date Of Exam 6";Date)
        {

            trigger OnValidate()
            begin
                  if "Date Of Exam 6"<"Application Date"then
                Error('You cannot Start your leave before the application date');

                if "Date Of Exam 6"="Date Of Exam 1"then
                Error('Date already assigned');
                if "Date Of Exam 6"="Date Of Exam 3"then
                Error('Date already assigned');

                if "Date Of Exam 6"="Date Of Exam 4"then
                Error('Date already assigned');

                if "Date Of Exam 6"="Date Of Exam 5"then
                Error('Date already assigned');

                if "Date Of Exam 6"="Date Of Exam 2"then
                Error('Date already assigned');

                if "Date Of Exam 6"="Date Of Exam 7"then
                Error('Date already assigned');
            end;
        }
        field(3983;"Date Of Exam 7";Date)
        {

            trigger OnValidate()
            begin
                 if "Date Of Exam 7"<"Application Date"then
                Error('You cannot Start your leave before the application date');

                if "Date Of Exam 7"="Date Of Exam 1"then
                Error('Date already assigned');
                if "Date Of Exam 7"="Date Of Exam 3"then
                Error('Date already assigned');

                if "Date Of Exam 7"="Date Of Exam 4"then
                Error('Date already assigned');

                if "Date Of Exam 7"="Date Of Exam 5"then
                Error('Date already assigned');

                if "Date Of Exam 7"="Date Of Exam 6"then
                Error('Date already assigned');

                if "Date Of Exam 7"="Date Of Exam 2"then
                Error('Date already assigned');
            end;
        }
        field(3984;"Employee Name";Text[150])
        {
        }
        field(3985;"Address No.";Text[80])
        {
        }
        field(3986;"Outstanding Leave Balance";Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" where ("Staff No."=field("Employee No"),
                                                                             "Posting Date"=field("Date Filter"),
                                                                             "Leave Type"=const('ANNUAL')));
            FieldClass = FlowField;
        }
        field(3987;"Date Filter";Date)
        {
            FieldClass = FlowFilter;
        }
        field(3988;"Posting Date";Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Application Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
         if Status<>Status::New then Error('You cannot delete this leave application');
    end;

    trigger OnInsert()
    begin
        //No. Series
        if "Application Code" = '' then
        begin
          HRSetup.Get;
          HRSetup.TestField(HRSetup."Leave Application Nos.");
          NoSeriesMgt.InitSeries(HRSetup."Leave Application Nos.",xRec."No series",0D,"Application Code","No series");
        end;

        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID",UserId);
        if HREmp.Find('-') then
        begin
            HREmp.TestField(HREmp."Date Of Join");

            Calendar.Reset;
            Calendar.SetRange("Period Type",Calendar."period type"::Month);
            Calendar.SetRange("Period Start",HREmp."Date Of Join",Today);
            empMonths := Calendar.Count;

            //Minimum duration in months for Leave Applications
            if HRSetup.Get then
            begin
                HRSetup.TestField(HRSetup."Min. Leave App. Months");
                if empMonths < HRSetup."Min. Leave App. Months" then Error(Text002,HRSetup."Min. Leave App. Months");
            end;

            //Populate fields
            "Employee No":=HREmp."No.";
            Gender:=HREmp.Gender;
            "Application Date":=Today;
            "User ID":=UserId;
            "Job Tittle":=HREmp."Job Title";
            HREmp.CalcFields(HREmp.Picture);
            Picture:=HREmp.Picture;
            //Approver details
            GetApplicantSupervisor(UserId);
        end else
        begin
            Error('UserID'+' '+'['+UserId+']'+' has not been assigned to any employee. Please consult the HR officer for assistance')
        end;
    end;

    var
        TEXT001: label 'Days Approved cannot be more than applied days';
        Text002: label 'You cannot apply for leave until your are over [%1] months old in the company';
        Text003: label 'UserID [%1] does not exist in [%2]';
        Allowance: Decimal;
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HREmp: Record "HR Employees";
        varDaysApplied: Integer;
        HRLeaveTypes: Record "HR Leave Types";
        BaseCalendarChange: Record "Job-Ledger Entryy";
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
        HRLeavePeriods: Record "HR Leave Periods";
        HRJournalBatch: Record "HR Leave Journal Batch";
        HRLeaveEntries: Record "HR Leave Ledger Entries";
        intEntryNo: Integer;
        Calendar: Record Date;
        empMonths: Integer;
        HRLeaveApp: Record "HR Leave Application";
        mWeekDay: Integer;
        empGender: Option Female;
        mMinDays: Integer;
        dates: Record Date;
        BaseCalendar: Record "Base Calendar Change";
        GeneralOptions: Record "HR Setup";
        LeaveTypes: Record "HR Leave Types";


    procedure DetermineIfIsNonWorking(var bcDate: Date;var ltype: Record "HR Leave Types") ItsNonWorking: Boolean
    var
        dates: Record Date;
    begin
        Clear(ItsNonWorking);
        GeneralOptions.Find('-');
        //One off Hollidays like Good Friday
        BaseCalendar.Reset;
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code",GeneralOptions."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar.Date,bcDate);
        if BaseCalendar.Find('-') then begin
        if BaseCalendar.Nonworking = true then
        ItsNonWorking:=true;
        end;

        // For Annual Holidays
        BaseCalendar.Reset;
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code",GeneralOptions."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar."Recurring System",BaseCalendar."recurring system"::"Annual Recurring");
        if BaseCalendar.Find('-') then begin
        repeat
        if ((Date2dmy(bcDate,1)=BaseCalendar."Date Day") and (Date2dmy(bcDate,2)=BaseCalendar."Date Month")) then begin
        if BaseCalendar.Nonworking = true then
        ItsNonWorking:=true;
        end;
        until BaseCalendar.Next=0;
        end;

        if ItsNonWorking=false then begin
        // Check if its a weekend
        dates.Reset;
        dates.SetRange(dates."Period Type",dates."period type"::Date);
        dates.SetRange(dates."Period Start",bcDate);
        if dates.Find('-') then begin
        //if date is a sunday
        if dates."Period Name"='Sunday' then begin
        //check if Leave includes sunday
        if ltype."Inclusive of Sunday"=false then ItsNonWorking:=true;
        end else if dates."Period Name"='Saturday' then begin
        //check if Leave includes sato
         if ltype."Inclusive of Saturday"=false then ItsNonWorking:=true;
        end;
        end;
        end;
    end;


    procedure DetermineIfIncludesNonWorking(var fLeaveCode: Code[10]): Boolean
    begin
        if LeaveTypes.Get(fLeaveCode) then begin
        if LeaveTypes."Inclusive of Non Working Days" = true then
        exit(true);
        end;
    end;


    procedure DetermineLeaveReturnDate(var fBeginDate: Date;var fDays: Decimal) fReturnDate: Date
    var
        ltype: Record "HR Leave Types";
    begin
        ltype.Reset;
        if ltype.Get("Leave Type") then begin
        end;
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        repeat
          if DetermineIfIncludesNonWorking("Leave Type") =false then begin
            fReturnDate := CalcDate('1D', fReturnDate);
            if DetermineIfIsNonWorking(fReturnDate,ltype) then begin
             varDaysApplied := varDaysApplied + 1;
        end else
              varDaysApplied := varDaysApplied;
            varDaysApplied := varDaysApplied + 1
          end
          else begin
            fReturnDate := CalcDate('1D', fReturnDate);
            varDaysApplied := varDaysApplied -1;
          end;
        until varDaysApplied = 0;
        exit(fReturnDate);
    end;


    procedure DeterminethisLeaveEndDate(var fDate: Date) fEndDate: Date
    var
        ltype: Record "HR Leave Types";
    begin
        if ltype.Get("Leave Type") then begin
        end;
        ReturnDateLoop := true;
        fEndDate := fDate;
        if fEndDate <> 0D then begin
          fEndDate := CalcDate('1D', fEndDate);
          while (ReturnDateLoop) do begin
          if DetermineIfIsNonWorking(fEndDate,ltype) then
            fEndDate := CalcDate('-1D', fEndDate)
           else
            ReturnDateLoop := false;
          end
          end;
        exit(fEndDate);
    end;


    procedure CreateLeaveLedgerEntries()
    begin
        if Status=Status::Posted then Error('Leave Already posted');
        TestField("Approved days");
        HRSetup.Reset;
        if HRSetup.Find('-') then begin
        
        LeaveGjline.Reset;
        LeaveGjline.SetRange("Journal Template Name",HRSetup."Leave Template");
        LeaveGjline.SetRange("Journal Batch Name",HRSetup."Leave Batch");
        LeaveGjline.DeleteAll;
          //Dave
        HRSetup.TestField(HRSetup."Leave Template");
        HRSetup.TestField(HRSetup."Leave Batch");
        
        HREmp.Get("Employee No");
        HREmp.TestField(HREmp."E-Mail");
        
        //POPULATE JOURNAL LINES
        
        "LineNo.":=10000;
        LeaveGjline.Init;
        LeaveGjline."Journal Template Name":=HRSetup."Leave Template";
        LeaveGjline."Journal Batch Name":=HRSetup."Leave Batch";
        LeaveGjline."Line No.":="LineNo.";
        LeaveGjline."Leave Period":='2018';
        LeaveGjline."Leave Application No.":="Application Code";
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
        LeaveGjline."No. of Days":="Approved days"*1;
        if LeaveGjline."No. of Days"<>0 then
        LeaveGjline.Insert(true);
        
        //Post Journal
        LeaveGjline.Reset;
        LeaveGjline.SetRange("Journal Template Name",HRSetup."Leave Template");
        LeaveGjline.SetRange("Journal Batch Name",HRSetup."Leave Batch");
        if LeaveGjline.Find('-') then begin
        Codeunit.Run(Codeunit::"HR Leave Jnl.-Post",LeaveGjline);
        end;
        Status:=Status::Posted;
        "Posting Date":=Today;
        Modify;
        
        /*END ELSE BEGIN
        ERROR('You must specify no of days');
        END;
        END;*/
        //NotifyApplicant;
        end;

    end;


    procedure NotifyApplicant()
    var
    Recipient: List of [Text];
    begin
        HREmp.Get("Employee No");
        HREmp.TestField(HREmp."Company E-Mail");

        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
        HREmailParameters.Reset;
        HREmailParameters.SetRange(HREmailParameters."Associate With",HREmailParameters."associate with"::"Interview Invitations");
        if HREmailParameters.Find('-') then
        begin


             HREmp.TestField(HREmp."Company E-Mail");
             Recipient.Add(HREmp."Company E-Mail");
             SMTP.CreateMessage(HREmailParameters."Sender Name",HREmailParameters."Sender Address",Recipient,
             HREmailParameters.Subject,'Dear'+' '+ HREmp."First Name" +' '+
             HREmailParameters.Body+' '+"Application Code"+' '+ HREmailParameters."Body 2",true);
             SMTP.Send();


        Message('Leave applicant has been notified successfully');
        end;
    end;

    local procedure GetApplicantSupervisor(EmpUserID: Code[50]) SupervisorID: Code[10]
    var
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        HREmp2: Record "HR Employees";
    begin
        /*SupervisorID:='';
        
        UserSetup.RESET;
        IF UserSetup.GET(EmpUserID) THEN
        BEGIN
            UserSetup.TESTFIELD(UserSetup."Approver ID");
        
            //Get supervisor e-mail
            UserSetup2.RESET;
            IF UserSetup2.GET(UserSetup."Approver ID") THEN
            BEGIN
                UserSetup2.TESTFIELD(UserSetup2."E-Mail");
                "Supervisor Email":=UserSetup2."E-Mail";
            END;
        
        END ELSE
        BEGIN
            ERROR(Text003,EmpUserID,UserSetup.TABLECAPTION);
        END;
          */

    end;


    procedure CalcEndDate(SDate: Date;LDays: Integer) LEndDate: Date
    var
        EndLeave: Boolean;
        DayCount: Integer;
        ltype: Record "HR Leave Types";
    begin
          ltype.Reset;
          if ltype.Get("Leave Type") then begin
          end;
           SDate:=SDate-1;
           EndLeave:=false;
           while EndLeave=false do begin
           if not DetermineIfIsNonWorking(SDate,ltype) then
           DayCount:=DayCount+1;
           SDate:=SDate+1;
           if DayCount>LDays then
           EndLeave:=true;
           end;
           LEndDate:=SDate-1;

        while DetermineIfIsNonWorking(LEndDate,ltype)=true do
        begin
        LEndDate:=LEndDate+1;
        end;
    end;


    procedure CalcReturnDate(EndDate: Date) RDate: Date
    var
        EndLeave: Boolean;
        DayCount: Integer;
        LEndDate: Date;
        ltype: Record "HR Leave Types";
    begin
           if ltype.Get("Leave Type") then begin
           end;
          /* EndLeave:=FALSE;
           EndDate:=EndDate+1;
           LEndDate:=EndDate;
           CLEAR(DayCount);
           WHILE EndLeave=FALSE DO BEGIN
           IF NOT DetermineIfIsNonWorking(EndDate,ltype) THEN BEGIN
           DayCount:=DayCount+1;
           EndDate:=EndDate+1;
        
           END ELSE BEGIN
           EndLeave:=TRUE;
           END;
           END;
             */
           RDate:=EndDate+1;
        while DetermineIfIsNonWorking(RDate,ltype)=true do
        begin
         RDate:= RDate+1;
        end;

    end;


    procedure GetDate(var Applied_Dayes: Integer;var Start_Date: Date)
    var
        DaysCount: Integer;
        NewDate: Date;
        Last_is_WotkingDay: Boolean;
    begin
        /*clear(DaysCount);
        clear(NewDate);
         NewDate:=Start_Date;
        repeat
        DaysCount:=DaysCount+1;
        Last_is_WotkingDay:=false;
        
        until (() AND ()) */

    end;


    procedure ItsHolliday(var Start_Date: Date) holliday: Boolean
    var
        baseCal: Record "Base Calendar Change";
        days: Integer;
        Months: Integer;
        bool_Non_Working: Boolean;
    begin
        Clear(days);
        Clear(Months);
        Clear(bool_Non_Working);
        days:=Date2dmy(Start_Date,1);
        Months:=Date2dmy(Start_Date,2);
        baseCal.Reset;
        baseCal.SetFilter(baseCal."Recurring System",'=%1',baseCal."recurring system"::"Annual Recurring");
        if baseCal.Find('-') then begin
        repeat
         if ((Months=Date2dmy(baseCal.Date,1)) and (days=Date2dmy(baseCal.Date,1))) then bool_Non_Working:=true;
        until ((((Months=Date2dmy(baseCal.Date,1)) and (days=Date2dmy(baseCal.Date,1)))) or (baseCal.Next=0))
        end;
    end;


    procedure ItsSunday(var Start_Date: Date;var LeaveType: Integer)
    var
        leave_types: Record "HR Leave Types";
        dates: Record Date;
    begin
    end;
}

