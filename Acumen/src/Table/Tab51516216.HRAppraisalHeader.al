#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516216 "HR Appraisal Header"
{

    fields
    {
        field(1;"Appraisal No";Code[30])
        {
        }
        field(2;Supervisor;Text[100])
        {
        }
        field(3;"Appraisal Type";Code[30])
        {
            TableRelation = "HR Lookup Values".Code where (Type=const("Appraisal Type"));
        }
        field(4;"Appraisal Period";Code[30])
        {
            TableRelation = "HR Lookup Values".Code where (Type=filter("Appraisal Period"));

            trigger OnValidate()
            begin
                            /*     HRAppraisalGoalSettingH.RESET;
                                 HRAppraisalGoalSettingH.SETRANGE(HRAppraisalGoalSettingH."Appraisal Period","Appraisal Period");
                                 HRAppraisalGoalSettingH.SETRANGE("Employee No","Employee No");
                                 IF HRAppraisalGoalSettingH.FIND('-') THEN
                                 ERROR('Goals for the current Appraisal period have already been filled');
                
                                 //put the open appraisal period
                                 HRLookUpValues.RESET;
                                 HRLookUpValues.SETRANGE(HRLookUpValues.Type,HRLookUpValues.Type::"Appraisal Period");
                                 HRLookUpValues.SETRANGE(HRLookUpValues.Code,"Appraisal Period");
                                 IF HRLookUpValues.FINDFIRST THEN BEGIN
                                   "Evaluation Period End":=HRLookUpValues.From;
                                 END
                */

            end;
        }
        field(5;Status;Option)
        {
            Editable = false;
            OptionMembers = Open,"Pending Approval",Approved,Closed;
        }
        field(6;Recommendations;Text[250])
        {
        }
        field(7;"No Series";Code[20])
        {
        }
        field(8;"Appraisal Stage";Option)
        {
            OptionCaption = 'Target Setting,Target Approval,End Year Evalauation';
            OptionMembers = "Target Setting","Target Approval","End Year Evalauation";
        }
        field(9;Sent;Option)
        {
            OptionCaption = 'Appraisee,Supervisor,Completed,Rated';
            OptionMembers = Appraisee,Supervisor,Completed,Rated;
        }
        field(10;"User ID";Code[100])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(11;Picture;Blob)
        {
            SubType = Bitmap;
        }
        field(12;"Employee No";Code[30])
        {
            Editable = true;
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.","Employee No");
                if HREmp.Find('-') then
                begin
                   "Employee Name":=HREmp."First Name"+' '+HREmp."Middle Name"+' '+HREmp."Last Name";
                //    Department:=;
                   "Job Title":=HREmp."Job Title";
                  //  Gender:=HREmp.Gender;
                   "Date of Employment":=HREmp."Date Of Join";

                end;
            end;
        }
        field(13;"Employee Name";Text[60])
        {
            Editable = false;
        }
        field(14;"Date of Employment";Date)
        {
        }
        field(15;"Job Title";Code[30])
        {
            Editable = false;
            TableRelation = "HR Jobss"."Job ID";
        }
        field(16;Department;Code[20])
        {
            TableRelation = "HR Appraisal Company Target".Code;

            trigger OnValidate()
            begin
                                                /*
                                   IF HRAppraisalRatings.GET(Department) THEN
                                   "Global Dimension 2 Code":=HRAppraisalRatings.Description;
                                   Recommendations:=HRAppraisalRatings.Recommendations;
                                                  */

            end;
        }
        field(17;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));
        }
        field(18;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(19;"Comments Appraisee";Text[250])
        {
        }
        field(20;"Comments Appraiser";Text[250])
        {
        }
        field(21;"Appraisal Date";Date)
        {
        }
        field(22;"Evaluation Period Start";Date)
        {
        }
        field(23;"Evaluation Period End";Date)
        {
        }
        field(24;"Target Type";Option)
        {
            OptionCaption = ' ,Company Targets,Individual Targets,Peer Targets,Surbodinates Targets,Out Agencies Targets,Company Rating,Individual Rating,Peer Rating,Surbodinates Rating,Out Agencies Rating';
            OptionMembers = " ","Company Targets","Individual Targets","Peer Targets","Surbodinates Targets","Out Agencies Targets","Company Rating","Individual Rating","Peer Rating","Surbodinates Rating","Out Agencies Rating";
        }
        field(25;"Responsibility/Duties Agrd Sco";Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where ("Appraisal No"=field("Appraisal No"),
                                                                          "Appraisal Period"=field("Appraisal Period"),
                                                                          "Employee No"=field("Employee No"),
                                                                          Sections=filter("Core Responsibilities/Duties")));
            Caption = 'Responsibility/Duties Agreed Score';
            ExtendedDatatype = Ratio;
            FieldClass = FlowField;
        }
        field(26;"Attendance&Punctuality Agr Sco";Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where ("Appraisal No"=field("Appraisal No"),
                                                                          "Appraisal Period"=field("Appraisal Period"),
                                                                          "Employee No"=field("Employee No"),
                                                                          Sections=filter("Attendance&Punctuality")));
            Caption = 'Attendance & Punctuality Agreed Score';
            FieldClass = FlowField;
        }
        field(27;"Communication Agreed Score";Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where ("Appraisal No"=field("Appraisal No"),
                                                                          "Appraisal Period"=field("Appraisal Period"),
                                                                          "Employee No"=field("Employee No"),
                                                                          Sections=filter(Communication)));
            ExtendedDatatype = Ratio;
            FieldClass = FlowField;
        }
        field(28;"Cooperation Agreed Score";Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where ("Appraisal No"=field("Appraisal No"),
                                                                          "Appraisal Period"=field("Appraisal Period"),
                                                                          "Employee No"=field("Employee No"),
                                                                          Sections=filter(Cooperation)));
            FieldClass = FlowField;
        }
        field(29;"Customer Service Agreed Score";Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where ("Appraisal No"=field("Appraisal No"),
                                                                          "Appraisal Period"=field("Appraisal Period"),
                                                                          "Employee No"=field("Employee No"),
                                                                          Sections=filter("Internal/External Clients")));
            FieldClass = FlowField;
        }
        field(30;"Initiative Agreed Score";Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where ("Appraisal No"=field("Appraisal No"),
                                                                          "Appraisal Period"=field("Appraisal Period"),
                                                                          "Employee No"=field("Employee No"),
                                                                          Sections=filter(Initiative)));
            FieldClass = FlowField;
        }
        field(31;"Quality Agreed Score";Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where ("Appraisal No"=field("Appraisal No"),
                                                                          "Appraisal Period"=field("Appraisal Period"),
                                                                          "Employee No"=field("Employee No"),
                                                                          Sections=filter(Quality)));
            DecimalPlaces = 0:0;
            FieldClass = FlowField;
        }
        field(32;"Teamwork Agreed Score";Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where ("Appraisal No"=field("Appraisal No"),
                                                                          "Appraisal Period"=field("Appraisal Period"),
                                                                          "Employee No"=field("Employee No"),
                                                                          Sections=filter("Team Work")));
            ExtendedDatatype = Ratio;
            FieldClass = FlowField;
        }
        field(33;"Sales Skills Agreed Score";Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where ("Appraisal No"=field("Appraisal No"),
                                                                          "Appraisal Period"=field("Appraisal Period"),
                                                                          "Employee No"=field("Employee No"),
                                                                          Sections=filter("Sales Skills")));
            FieldClass = FlowField;
        }
        field(34;"Leadership Agreed Score";Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where ("Appraisal No"=field("Appraisal No"),
                                                                          "Appraisal Period"=field("Appraisal Period"),
                                                                          "Employee No"=field("Employee No"),
                                                                          Sections=filter(Leadership)));
            FieldClass = FlowField;
        }
        field(35;"Performance Coaching Agreed Sc";Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Agreed Rating" where ("Appraisal No"=field("Appraisal No"),
                                                                          "Appraisal Period"=field("Appraisal Period"),
                                                                          "Employee No"=field("Employee No"),
                                                                          Sections=filter("Performance Coaching")));
            Caption = 'Performance Coaching Agreed Score';
            FieldClass = FlowField;
        }
        field(36;"Action Recomended";Integer)
        {
        }
        field(37;"Job Specific Agreed Score";Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Self Rating" where ("Appraisal No"=field("Appraisal No"),
                                                                        "Appraisal Period"=field("Appraisal Period"),
                                                                        "Employee No"=field("Employee No")));
            FieldClass = FlowField;
        }
        field(38;"Employee Subordinates";Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Sub-ordinates Rating" where ("Appraisal No"=field("Appraisal No"),
                                                                                 "Appraisal Period"=field("Appraisal Period"),
                                                                                 "Employee No"=field("Employee No")));
            Caption = 'Employee Subordinates Agreed Score';
            FieldClass = FlowField;
        }
        field(39;"Employee Peers";Decimal)
        {
            CalcFormula = sum("HR Appraisal Lines"."Peer Rating" where ("Appraisal No"=field("Appraisal No"),
                                                                        "Appraisal Period"=field("Appraisal Period"),
                                                                        "Employee No"=field("Employee No")));
            Caption = 'Employee Peers Agreed Score';
            FieldClass = FlowField;
        }
        field(40;"Job Description";Text[30])
        {
            CalcFormula = lookup("HR Jobss"."Job Description" where ("Job ID"=field("Job Title")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(41;"Appraisal Method";Option)
        {
            OptionCaption = ' ,Normal Appraisal,360 Appraisal';
            OptionMembers = " ","Normal Appraisal","360 Appraisal";
        }
        field(42;"Supervisor ID";Code[20])
        {
            Editable = true;
            TableRelation = "User Setup"."User ID";
        }
        field(43;"Supervisor Job Title";Text[50])
        {
            CalcFormula = lookup("HR Employees"."Job Specification" where ("Employee UserID"=field("Supervisor ID")));
            Editable = true;
            FieldClass = FlowField;
        }
        field(50000;"Responsibility Center";Code[10])
        {
            Caption = 'Responsibility Center';
        }
        field(50011;"Contract Type";Option)
        {
            OptionMembers = Permanent,"Temporary",Voluntary,Probation,Contract;
        }
        field(50014;"Appraisal Approval Status";Option)
        {
            OptionMembers = "Pending Approval",Approved;
        }
        field(50015;"Supervisor UserID";Code[50])
        {
            TableRelation = User."User Name";
        }
        field(50020;"Prev Appraisal Code";Code[50])
        {
        }
        field(50021;"Agreed Goals 1";Text[30])
        {
            Description = 'Agreed goals for the year ahead';
        }
        field(50022;"Responsibility/Duties Comment";Text[100])
        {
            Caption = 'Responsibility/Duties Agreed Score';
            FieldClass = Normal;
        }
        field(50023;"Attendance&Punctuality Comment";Text[30])
        {
            Caption = 'Attendance & Punctuality Agreed Score';
            FieldClass = Normal;
        }
        field(50024;"Communication Agreed Comment";Text[30])
        {
            FieldClass = Normal;
        }
        field(50025;"Cooperation Agreed Comment";Text[30])
        {
            FieldClass = Normal;
        }
        field(50026;"Customer Service Agr Comment";Text[30])
        {
            FieldClass = Normal;
        }
        field(50027;"Initiative Agreed Comment";Text[30])
        {
            FieldClass = Normal;
        }
        field(50028;"Quality Agreed Comment";Text[30])
        {
            FieldClass = Normal;
        }
        field(50029;"Teamwork Agreed Comment";Text[30])
        {
            FieldClass = Normal;
        }
        field(50030;"Sales Skills Agreed Comment";Text[30])
        {
            FieldClass = Normal;
        }
        field(50031;"Leadership Agreed Comment";Text[30])
        {
            FieldClass = Normal;
        }
        field(50032;"Performance Coaching Comment";Text[30])
        {
            Caption = 'Performance Coaching Agreed Score';
            FieldClass = Normal;
        }
    }

    keys
    {
        key(Key1;"Appraisal No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField(Status,Status::Open);
        //Also delete lines
        HRGoalSettingL.Reset;
        HRGoalSettingL.SetRange(HRGoalSettingL."Appraisal No","Appraisal No");
        if HRGoalSettingL.Find('-') then
        begin
            HRGoalSettingL.DeleteAll;
        end;
    end;

    trigger OnInsert()
    begin
        if "Appraisal No" = '' then
        begin
          HRSetup.Get;
          HRSetup.TestField(HRSetup."Appraisal Nos");
          NoSeriesMgt.InitSeries(HRSetup."Appraisal Nos",xRec."No Series",0D,"Appraisal No","No Series");
        end;
        "Appraisal Date":=Today;

        //GET APPLICANT DETAILS FROM HR EMPLOYEES TABLE AND COPY THEM TO THE GOAL SETTING TABLE
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID",UserId);
        if HREmp.Find('-') then
        begin
            "Employee No":=HREmp."No.";
            "Employee Name":=HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            "Date of Employment":=HREmp."Date Of Joining the Company";
            "Global Dimension 1 Code":=HREmp."Global Dimension 1 Code";
            "Global Dimension 2 Code":=HREmp."Global Dimension 2 Code";
            "Job Title":=HREmp."Job Specification";
            "Contract Type":= HREmp."Contract Type" ;
            "User ID":=UserId;
            Supervisor:=HREmpCard.GetSupervisor("User ID");
            HREmp.CalcFields(HREmp.Picture);
            Picture:=HREmp.Picture;
            "Appraisal Stage":="appraisal stage"::"Target Setting";

            //For 360
            HRSetup.Reset;
            if HRSetup.Get then
            begin
                HRSetup.TestField(HRSetup."Min. Leave App. Months");
            end;

            if HREmp."Appraisal Method" = HREmp."appraisal method"::" " then
            begin
                //Default to value in HR Setup if not filled
                "Appraisal Method":=HRSetup."Min. Leave App. Months";
            end else
            begin
                //Select appraisal from Employee PIF
                "Appraisal Method":=HREmp."Appraisal Method";
            end;
            //End for 360

        end else
        begin
            Error('User ID'+' '+UserId+' '+'is not assigned to any employee. Consult the HR Officer so as to be setup as an employee')
        end;


        //Put the open appraisal period
        HRLookUpValues.Reset;
        HRLookUpValues.SetRange(HRLookUpValues.Type,HRLookUpValues.Type::"Appraisal Period");
        HRLookUpValues.SetRange(HRLookUpValues.Closed,false);
        if HRLookUpValues.Find('-') then begin
          "Appraisal Period":=HRLookUpValues.Code;
          "Appraisal Stage":=HRLookUpValues."Appraisal Stage";
          "Evaluation Period Start":=HRLookUpValues.From;
          "Evaluation Period End":=HRLookUpValues."To";
        end
        else
        begin
            Error('There are no open Appraisal Periods, Please define one in HR Lookup Values');
        end;
    end;

    var
        HREmp: Record "HR Employees";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HREmpCard: Page "HR Employee Card";
        HRAppraisalRatings: Record "HR Appraisal Company Target";
        HRAppraisalGoalSettingH: Record "HR Appraisal Header";
        HRGoalSettingL: Record "HR Appraisal Lines";
        HRGoalSettingLNext: Record "HR Appraisal Lines";
        HRLookUpValues: Record "HR Lookup Values";
        LastAppraisal: Record "HR Appraisal Header";
        CompanyScoreAppraisee: Decimal;
        KPIScoreAppraisee: Decimal;
        PFScoreAppraisee: Decimal;
        PFBase: Decimal;
        HrRatings: Record "HR Appraisal Company Target";
        UserSetup: Record "User Setup";
        Approver: Record "User Setup";
        KPIScoreAppraiser: Decimal;
        KPIScoreMgt: Decimal;
        PFScoreAppraiser: Decimal;
        PFScoreMgt: Decimal;


    procedure CalcTotals()
    var
        Employee: Record "HR Employees";
        Job: Record "HR Jobss";
    begin
    end;
}

