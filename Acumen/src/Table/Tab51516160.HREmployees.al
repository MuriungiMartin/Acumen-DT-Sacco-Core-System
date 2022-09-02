#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516160 "HR Employees"
{
    Caption = 'HR Employees';
    DataCaptionFields = "No.","First Name","Middle Name","Last Name","Job Title","Search Name";
    DrillDownPageID = "HR Employee List";
    LookupPageID = "HR Employee List";

    fields
    {
        field(1;"No.";Code[20])
        {
            Editable = true;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                  HrSetup.Get;
                  NoSeriesMgt.TestManual(HrSetup."Employee Nos.");
                  "No. Series" := '';
                end;

                if "No." = '' then begin
                  HrSetup.Get;
                  if "Contract Type"="contract type"::Deployed then begin
                     HrSetup.TestField(HrSetup."Deployed Nos");
                     NoSeriesMgt.InitSeries(HrSetup."Deployed Nos",xRec."No. Series",0D,"No.","No. Series");
                  end
                  else if "Contract Type"="contract type"::"Full Time" then begin
                    HrSetup.TestField(HrSetup."Full Time Nos");
                    NoSeriesMgt.InitSeries(HrSetup."Full Time Nos",xRec."No. Series",0D,"No.","No. Series");
                  end else if "Contract Type"="contract type"::Board then begin
                    HrSetup.TestField(HrSetup."Board Nos");
                    NoSeriesMgt.InitSeries(HrSetup."Board Nos",xRec."No. Series",0D,"No.","No. Series");
                  end else if "Contract Type"="contract type"::Committee then begin
                    HrSetup.TestField(HrSetup."Committee Nos");
                    NoSeriesMgt.InitSeries(HrSetup."Committee Nos",xRec."No. Series",0D,"No.","No. Series");
                  end;
                end;
            end;
        }
        field(2;"First Name";Text[80])
        {
        }
        field(3;"Middle Name";Text[50])
        {
        }
        field(4;"Last Name";Text[50])
        {

            trigger OnValidate()
            var
                Reason: Text[30];
            begin
            end;
        }
        field(5;Initials;Text[15])
        {

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Initials)) or ("Search Name" = '') then
                  "Search Name" := Initials;
            end;
        }
        field(7;"Search Name";Code[50])
        {
        }
        field(8;"Postal Address";Text[80])
        {
        }
        field(9;"Residential Address";Text[80])
        {
        }
        field(10;City;Text[30])
        {
        }
        field(11;"Post Code";Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                 PostCode.Reset;
                 PostCode.SetRange(PostCode.Code,"Post Code");
                 if PostCode.Find('-') then begin
                 City:=PostCode.City;
                 end;
            end;
        }
        field(12;County;Text[30])
        {
        }
        field(13;"Home Phone Number";Text[30])
        {
        }
        field(14;"Cellular Phone Number";Text[30])
        {
        }
        field(15;"Work Phone Number";Text[30])
        {
        }
        field(16;"Ext.";Text[7])
        {
        }
        field(17;"E-Mail";Text[80])
        {
            ExtendedDatatype = EMail;
        }
        field(19;Picture;Blob)
        {
            SubType = Bitmap;
        }
        field(21;"ID Number";Text[30])
        {
        }
        field(22;"Union Code";Code[15])
        {
            TableRelation = Union;
        }
        field(23;"UIF Number";Text[30])
        {
        }
        field(24;Gender;Option)
        {
            OptionMembers = " ",Male,Female;
        }
        field(25;"Country Code";Code[20])
        {
            TableRelation = "Country/Region";
        }
        field(28;"Statistics Group Code";Code[20])
        {
            TableRelation = "Employee Statistics Group";
        }
        field(31;Status;Option)
        {
            Editable = false;
            OptionCaption = 'Active,Inactive';
            OptionMembers = Active,Inactive;

            trigger OnValidate()
            begin
                "Status Change Date":=Today;
            end;
        }
        field(35;"Location/Division Code";Code[20])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(4));

            trigger OnValidate()
            begin
                //IF SalCard.GET("No.") THEN BEGIN
                //SalCard."Pays Pension":="Location/Division Code";
                //SalCard.MODIFY;
                //END;
            end;
        }
        field(36;"Department Code";Code[20])
        {

            trigger OnValidate()
            begin
                ///IF SalCard.GET("No.") THEN BEGIN
                //SalCard."Gratuity %":="Department Code";
                //SalCard.MODIFY;
                //END;
            end;
        }
        field(37;Office;Code[40])
        {
            Description = 'Dimension 3';
        }
        field(38;"Resource No.";Code[20])
        {
            TableRelation = Resource;
        }
        field(39;Comment;Boolean)
        {
            Editable = false;
        }
        field(40;"Last Date Modified";Date)
        {
            Editable = false;
        }
        field(41;"Date Filter";Date)
        {
            FieldClass = FlowFilter;
        }
        field(42;"Department Filter 1";Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(3));
        }
        field(43;"Office Filter";Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(47;"Employee No. Filter";Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(49;"Fax Number";Text[30])
        {
        }
        field(50;"Company E-Mail";Text[80])
        {
        }
        field(51;Title;Option)
        {
            OptionMembers = MR,MRS,MISS,MS,DR," ENG. ","DR.",CC,Prof;
        }
        field(52;"Salespers./Purch. Code";Code[20])
        {
        }
        field(53;"No. Series";Code[20])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(54;"Known As";Text[30])
        {
        }
        field(55;Position;Text[30])
        {

            trigger OnValidate()
            begin
                  /*
                      IF ((Position <> xRec.Position) AND (xRec.Position <> '')) THEN BEGIN
                        Jobs.RESET;
                        Jobs.SETRANGE(Jobs."Job ID",Position);
                        IF Jobs.FIND('-') THEN BEGIN
                            Payroll.RESET;
                            Payroll.SETRANGE(Payroll.Code,"No.");
                            IF Payroll.FIND('-') THEN BEGIN
                                Payroll."Salary Scheme Category":=Jobs.Category;
                                Payroll."Salary Steps":=Jobs.Grade;
                                Payroll.VALIDATE(Payroll."Salary Steps");
                                Payroll.MODIFY;
                            END
                        END
                
                
                
                          {
                        CareerEvent.SetMessage('Job Title Changed');
                       CareerEvent.RUNMODAL;
                       OK:= CareerEvent.ReturnResult;
                        IF OK THEN BEGIN
                           CareerHistory.INIT;
                           IF NOT CareerHistory.FIND('-') THEN
                            CareerHistory."Line No.":=1
                          ELSE BEGIN
                            CareerHistory.FIND('+');
                            CareerHistory."Line No.":=CareerHistory."Line No."+1;
                          END;
                
                           CareerHistory."Employee No.":= "No.";
                           CareerHistory."Date Of Event":= WORKDATE;
                           CareerHistory."Career Event":= 'Job Title Changed';
                           CareerHistory."Job Title":= "Position Title";
                           CareerHistory."Employee First Name":= "Known As";
                           CareerHistory."Employee Last Name":= "Last Name";
                           CareerHistory.INSERT;
                        END;
                        }
                
                    END;
                 */

            end;
        }
        field(57;"Full / Part Time";Option)
        {
            OptionMembers = "Full Time"," Part Time",Contract;
        }
        field(58;"Contract Type";Option)
        {
            Caption = 'Contract Status';
            OptionCaption = 'Contract,Secondment,Temporary,Volunteer,Project Staff,Consultant-Contract,Consultant,Deployed,Board,Committee,Full Time';
            OptionMembers = Contract,Secondment,"Temporary",Volunteer,"Project Staff","Consultant-Contract",Consultant,Deployed,Board,Committee,"Full Time";
        }
        field(59;"Contract End Date";Date)
        {
        }
        field(60;"Notice Period";Code[20])
        {
        }
        field(61;"Union Member?";Boolean)
        {
        }
        field(62;"Shift Worker?";Boolean)
        {
        }
        field(63;"Contracted Hours";Decimal)
        {
        }
        field(64;"Pay Period";Option)
        {
            OptionMembers = Weekly,"2 Weekly","4 Weekly",Monthly," ";
        }
        field(65;"Pay Per Period";Decimal)
        {
        }
        field(66;"Cost Code";Code[20])
        {
        }
        field(68;"Secondment Institution";Text[30])
        {
        }
        field(69;"UIF Contributor?";Boolean)
        {
        }
        field(73;"Marital Status";Option)
        {
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(74;"Ethnic Origin";Option)
        {
            OptionMembers = African,Indian,White,Coloured;
        }
        field(75;"First Language (R/W/S)";Code[15])
        {
        }
        field(76;"Driving Licence";Code[15])
        {
        }
        field(77;"Vehicle Registration Number";Code[15])
        {
        }
        field(78;Disabled;Option)
        {
            OptionMembers = No,Yes," ";

            trigger OnValidate()
            begin
                if (Disabled = Disabled::Yes) then
                   Status := Status::"5";
            end;
        }
        field(79;"Health Assesment?";Boolean)
        {
        }
        field(80;"Health Assesment Date";Date)
        {
        }
        field(81;"Date Of Birth";Date)
        {
        }
        field(82;Age;Text[80])
        {
        }
        field(83;"Date Of Join";Date)
        {
        }
        field(84;"Length Of Service";Text[80])
        {
        }
        field(85;"End Of Probation Date";Date)
        {
        }
        field(86;"Pension Scheme Join";Date)
        {
        }
        field(87;"Time Pension Scheme";Text[80])
        {
        }
        field(88;"Medical Scheme Join";Date)
        {
        }
        field(89;"Time Medical Scheme";Text[80])
        {
            //This property is currently not supported
            //TestTableRelation = true;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;
        }
        field(90;"Date Of Leaving";Date)
        {
        }
        field(91;Paterson;Code[15])
        {
        }
        field(92;Peromnes;Code[15])
        {
        }
        field(93;Hay;Code[15])
        {
        }
        field(94;Castellion;Code[15])
        {
        }
        field(95;"Per Annum";Decimal)
        {
        }
        field(96;"Allow Overtime";Option)
        {
            OptionMembers = Yes,No," ";
        }
        field(97;"Medical Scheme No.";Text[30])
        {
            TableRelation = "HR Medical Schemes"."Scheme No";

            trigger OnValidate()
            begin
                        //MedicalAidBenefit.SETRANGE("Employee No.","No.");

                ObjMedicalScheme.Reset;
                ObjMedicalScheme.SetRange(ObjMedicalScheme."Scheme No","Medical Scheme No.");
                if ObjMedicalScheme.FindSet then
                  begin
                    if Confirm('Confirm adding this Employee to this Medical Scheme',false)=true then
                      begin

                        ObjSchemeMembers.Init;
                        ObjSchemeMembers."Scheme No":="Medical Scheme No.";
                        ObjSchemeMembers."Employee No":="No.";
                        ObjSchemeMembers."First Name":="First Name";
                        ObjSchemeMembers."Last Name":="Last Name";
                        ObjSchemeMembers.Designation:=Position;
                        ObjSchemeMembers."Scheme Join Date":=Today;
                        ObjSchemeMembers."In-patient Limit":="Medical In-Patient Limit";
                        ObjSchemeMembers."Out-Patient Limit":="Medical Out-Patient Limit";
                        ObjSchemeMembers."Maximum Cover":="Medical Maximum Cover";
                        ObjSchemeMembers."No Of Dependants":="Medical No Of Dependants";
                        ObjSchemeMembers.Insert;

                        "Medical Scheme Name":=ObjMedicalScheme."Scheme Name";
                        end;
                    end;
            end;
        }
        field(98;"Medical Scheme Head Member";Text[60])
        {

            trigger OnValidate()
            begin
                      //  MedicalAidBenefit.SETRANGE("Employee No.","No.");
                      //   OK := MedicalAidBenefit.FIND('+');
                      //  IF OK THEN BEGIN
                        //  REPEAT
                        //   MedicalAidBenefit."Medical Aid Head Member":= "Medical Aid Head Member";
                       //    MedicalAidBenefit.MODIFY;
                        //  UNTIL MedicalAidBenefit.NEXT = 0;
                       // END;
            end;
        }
        field(99;"Number Of Dependants";Integer)
        {

            trigger OnValidate()
            begin
                        // MedicalAidBenefit.SETRANGE("Employee No.","No.");
                        // OK := MedicalAidBenefit.FIND('+');
                       // IF OK THEN BEGIN
                          //REPEAT
                         //  MedicalAidBenefit."Number Of Dependants":= "Number Of Dependants";
                         //  MedicalAidBenefit.MODIFY;
                          //UNTIL MedicalAidBenefit.NEXT = 0;
                      // END;
            end;
        }
        field(100;"Medical Scheme Name";Text[100])
        {

            trigger OnValidate()
            begin
                         //MedicalAidBenefit.SETRANGE("Employee No.","No.");
                         //OK := MedicalAidBenefit.FIND('+');
                       //IF OK THEN BEGIN
                         // REPEAT
                          // MedicalAidBenefit."Medical Aid Name":= "Medical Aid Name";
                         //  MedicalAidBenefit.MODIFY;
                         // UNTIL MedicalAidBenefit.NEXT = 0;
                       // END;
            end;
        }
        field(101;"Amount Paid By Employee";Decimal)
        {

            trigger OnValidate()
            begin
                       //  MedicalAidBenefit.SETRANGE("Employee No.","No.");
                      //  OK := MedicalAidBenefit.FIND('+');
                     //   IF OK THEN BEGIN
                     //     REPEAT
                     //      MedicalAidBenefit."Amount Paid By Employee":= "Amount Paid By Employee";
                    //       MedicalAidBenefit.MODIFY;
                    //     UNTIL MedicalAidBenefit.NEXT = 0;
                    //    END;
            end;
        }
        field(102;"Amount Paid By Company";Decimal)
        {

            trigger OnValidate()
            begin
                       //  MedicalAidBenefit.SETRANGE("Employee No.","No.");
                      //   OK := MedicalAidBenefit.FIND('+');
                      //  IF OK THEN BEGIN
                         // REPEAT
                     //      MedicalAidBenefit."Amount Paid By Company":= "Amount Paid By Company";
                     //      MedicalAidBenefit.MODIFY;
                         // UNTIL MedicalAidBenefit.NEXT = 0;
                     //   END;
            end;
        }
        field(103;"Receiving Car Allowance ?";Boolean)
        {
        }
        field(104;"Second Language (R/W/S)";Code[15])
        {
        }
        field(105;"Additional Language";Code[15])
        {
        }
        field(106;"Cell Phone Reimbursement?";Boolean)
        {
        }
        field(107;"Amount Reimbursed";Decimal)
        {
        }
        field(108;"UIF Country";Code[15])
        {
            TableRelation = "Country/Region".Code;
        }
        field(109;"Direct/Indirect";Option)
        {
            OptionMembers = Direct,Indirect;
        }
        field(110;"Primary Skills Category";Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(111;Level;Option)
        {
            OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";
        }
        field(112;"Termination Category";Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;

            trigger OnValidate()
            var
                "Lrec Resource": Record Resource;
                OK: Boolean;
            begin
            end;
        }
        field(113;"Job Specification";Code[30])
        {
            Description = 'To put description on Job title field';
            TableRelation = "HR Jobss"."Job ID";

            trigger OnValidate()
            begin
                objJobs.Reset;
                objJobs.SetRange(objJobs."Job ID","Job Specification");
                if objJobs.Find('-') then begin
                 "Job Title":=objJobs."Job Description";
                end;
            end;
        }
        field(114;DateOfBirth;Date)
        {
        }
        field(115;DateEngaged;Text[8])
        {
        }
        field(116;"Postal Address2";Text[30])
        {
        }
        field(117;"Postal Address3";Text[20])
        {
        }
        field(118;"Residential Address2";Text[30])
        {
        }
        field(119;"Residential Address3";Text[20])
        {
        }
        field(120;"Post Code2";Code[20])
        {
            TableRelation = "Post Code";
        }
        field(121;Citizenship;Code[15])
        {
            TableRelation = "Country/Region".Code;
        }
        field(122;"Name Of Manager";Text[45])
        {
        }
        field(123;"User ID";Code[30])
        {
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = true;

            trigger OnLookup()
            begin
                UserMgt.LookupUserID("User ID");
            end;

            trigger OnValidate()
            begin
                UserMgt.ValidateUserID("User ID");

                if "User ID" = '' then exit;

                HREmp.Reset;
                if HREmp.Get("User ID") then
                begin
                   EmpFullName:=HREmp."First Name" + SPACER + HREmp."Middle Name" + SPACER + HREmp."Last Name";
                   Error('UserID [%1] has already been assigned to another Employee [%2]',"User ID",EmpFullName);
                end;
            end;
        }
        field(124;"Disabling Details";Text[30])
        {
        }
        field(125;"Disability Grade";Text[30])
        {
        }
        field(126;"Passport Number";Text[30])
        {
        }
        field(127;"2nd Skills Category";Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(128;"3rd Skills Category";Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(129;PensionJoin;Text[30])
        {
        }
        field(130;DateLeaving;Text[30])
        {
        }
        field(131;Region;Code[20])
        {
            TableRelation = "Dimension Value".Code where ("Dimension Code"=const('REGION'));
        }
        field(132;"Manager Emp No";Code[30])
        {
        }
        field(133;Temp;Text[20])
        {
        }
        field(134;"Employee Qty";Integer)
        {
            CalcFormula = count("HR Employees");
            FieldClass = FlowField;
        }
        field(135;"Employee Act. Qty";Integer)
        {
            CalcFormula = count("HR Employees");
            FieldClass = FlowField;
        }
        field(136;"Employee Arc. Qty";Integer)
        {
            CalcFormula = count("HR Employees");
            FieldClass = FlowField;
        }
        field(137;"Contract Location";Text[20])
        {
            Description = 'Location where contract was closed';
        }
        field(138;"First Language Read";Boolean)
        {
        }
        field(139;"First Language Write";Boolean)
        {
        }
        field(140;"First Language Speak";Boolean)
        {
        }
        field(141;"Second Language Read";Boolean)
        {
        }
        field(142;"Second Language Write";Boolean)
        {
        }
        field(143;"Second Language Speak";Boolean)
        {
        }
        field(144;"Custom Grading";Code[20])
        {
        }
        field(145;"PIN No.";Code[20])
        {
        }
        field(146;"NSSF No.";Code[20])
        {
        }
        field(147;"NHIF No.";Code[20])
        {
        }
        field(148;"Cause of Inactivity Code";Code[15])
        {
            Caption = 'Cause of Inactivity Code';
            TableRelation = "Cause of Inactivity";
        }
        field(149;"Grounds for Term. Code";Code[15])
        {
            Caption = 'Grounds for Term. Code';
            TableRelation = "Grounds for Termination";
        }
        field(150;"Sacco Staff No";Code[20])
        {
        }
        field(151;"Period Filter";Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(152;"HELB No";Text[15])
        {
        }
        field(153;"Co-Operative No";Text[30])
        {
        }
        field(154;"Wedding Anniversary";Date)
        {
        }
        field(156;"Competency Area";Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(157;"Cost Center Code";Code[20])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2),
                                                          "Dimension Value Type"=const(Standard));

            trigger OnValidate()
            begin
                //IF SalCard.GET("No.") THEN BEGIN
                //SalCard."Gratuity Amount":="Cost Center Code";
                //SalCard.MODIFY;
                //END;
            end;
        }
        field(158;"Position To Succeed";Code[20])
        {
        }
        field(159;"Succesion Date";Date)
        {
        }
        field(160;"Send Alert to";Code[20])
        {
        }
        field(161;Tribe;Code[15])
        {
        }
        field(162;Religion;Code[20])
        {
            TableRelation = "HR Lookup Values".Code where (Type=filter(Religion));
        }
        field(163;"Job Title";Text[40])
        {
        }
        field(164;"Post Office No";Text[10])
        {
        }
        field(165;"Posting Group";Code[15])
        {
            NotBlank = false;
            TableRelation = "Payroll Posting Groups.";
        }
        field(166;"Payroll Posting Group";Code[10])
        {
            TableRelation = "Payroll Employee."."No.";
        }
        field(167;"Served Notice Period";Boolean)
        {
        }
        field(168;"Exit Interview Date";Date)
        {
        }
        field(169;"Exit Interview Done by";Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(170;"Allow Re-Employment In Future";Boolean)
        {
        }
        field(171;"Medical Scheme Name #2";Text[15])
        {

            trigger OnValidate()
            begin
                         //MedicalAidBenefit.SETRANGE("Employee No.","No.");
                         //OK := MedicalAidBenefit.FIND('+');
                       //IF OK THEN BEGIN
                         // REPEAT
                          // MedicalAidBenefit."Medical Aid Name":= "Medical Aid Name";
                         //  MedicalAidBenefit.MODIFY;
                         // UNTIL MedicalAidBenefit.NEXT = 0;
                       // END;
            end;
        }
        field(172;"Resignation Date";Date)
        {
        }
        field(173;"Suspension Date";Date)
        {
        }
        field(174;"Demised Date";Date)
        {
        }
        field(175;"Retirement date";Date)
        {
        }
        field(176;"Retrenchment date";Date)
        {
        }
        field(177;Campus;Code[15])
        {
            TableRelation = "Dimension Value".Code where ("Dimension Code"=const('CAMPUS'));
        }
        field(178;Permanent;Boolean)
        {
        }
        field(179;"Library Category";Option)
        {
            OptionMembers = "ADMIN STAFF","TEACHING STAFF",DIRECTORS;
        }
        field(180;Category;Code[15])
        {
        }
        field(181;"Payroll Departments";Code[15])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(3));
        }
        field(188;"Salary Grade";Code[15])
        {
            TableRelation = "Payment Terms".Field1396040;

            trigger OnValidate()
            begin
                if not Confirm('Changing the Grade will affect the Basic Salary',false) then
                   Error('You have opted to abort the process');
                
                
                "Salary Notch/Step":='';
                /*
                IF SalCard.GET("No.") THEN BEGIN
                //SalCard.Gratuity:="Salary Grade";
                SalCard.MODIFY;
                END;
                
                
                {
                IF SalGrade.GET("Salary Grade") THEN BEGIN
                    IF SalGrade."Salary Amount"<>0 THEN BEGIN
                       IF SalCard.GET("No.") THEN BEGIN
                          SalCard."Basic Pay":=SalGrade."Salary Amount";
                          SalCard.MODIFY;
                       END;
                    END;
                END;
                }*/

            end;
        }
        field(189;"Company Type";Option)
        {
            OptionCaption = 'Others,USAID';
            OptionMembers = Others,USAID;
        }
        field(190;"Main Bank";Code[15])
        {
        }
        field(191;"Branch Bank";Code[20])
        {
        }
        field(192;"Lock Bank Details";Boolean)
        {
        }
        field(193;"Bank Account Number";Code[20])
        {
        }
        field(195;"Payroll Code";Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(196;"Holiday Days Entitlement";Decimal)
        {
        }
        field(197;"Holiday Days Used";Decimal)
        {
        }
        field(198;"Payment Mode";Option)
        {
            Description = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = " ","Bank Transfer",Cheque,Cash,FOSA;
        }
        field(199;"Hourly Rate";Decimal)
        {
        }
        field(200;"Daily Rate";Decimal)
        {
        }
        field(300;"Social Security No.";Code[20])
        {
        }
        field(301;"Pension House";Code[20])
        {
        }
        field(302;"Salary Notch/Step";Code[20])
        {

            trigger OnValidate()
            begin
                /*
                IF SalCard.GET("No.") THEN BEGIN
                IF SalGrade.GET("Salary Grade") THEN
                SalaryGrades."Pays NHF":=SalGrade."Pays NHF";
                SalCard."Fosa Accounts":="Salary Notch/Step";
                
                SalNotch.RESET;
                SalNotch.SETRANGE(SalNotch."Salary Grade","Salary Grade");
                SalNotch.SETRANGE(SalNotch."Salary Notch","Salary Notch/Step");
                IF SalNotch.FIND('-') THEN BEGIN
                IF SalNotch."Salary Amount"<>0 THEN BEGIN
                IF SalCard.GET("No.") THEN BEGIN
                SalCard."Basic Pay":=SalNotch."Salary Amount";
                END;
                END;
                END;
                
                SalCard.MODIFY;
                END ELSE BEGIN
                SalCard.INIT;
                SalCard."Employee Code":="No.";
                SalCard."Pays PAYE":=TRUE;
                //SalCard."Pays Pension":="Location/Division Code";
                SalCard."Gratuity %":="Department Code";
                //SalCard."Gratuity Amount":="Cost Center Code";
                //SalCard.Gratuity:="Salary Grade";
                SalCard."Fosa Accounts":="Salary Notch/Step";
                IF SalGrade.GET("Salary Grade") THEN
                SalaryGrades."Pays NHF":=SalGrade."Pays NHF";
                
                SalNotch.RESET;
                SalNotch.SETRANGE(SalNotch."Salary Grade","Salary Grade");
                SalNotch.SETRANGE(SalNotch."Salary Notch","Salary Notch/Step");
                IF SalNotch.FIND('-') THEN BEGIN
                IF SalNotch."Salary Amount"<>0 THEN BEGIN
                SalCard."Basic Pay":=SalNotch."Salary Amount";
                END;
                END;
                SalCard.INSERT;
                
                END;
                
                
                objPayrollPeriod.RESET;
                objPayrollPeriod.SETRANGE(objPayrollPeriod.Closed,FALSE);
                IF objPayrollPeriod.FIND('-') THEN BEGIN
                NotchTrans.RESET;
                NotchTrans.SETRANGE(NotchTrans."Salary Grade","Salary Grade");
                NotchTrans.SETRANGE(NotchTrans."Salary Step/Notch","Salary Notch/Step");
                IF NotchTrans.FIND('-') THEN BEGIN
                REPEAT
                EmpTrans.RESET;
                EmpTrans.SETCURRENTKEY(EmpTrans."Employee Code",EmpTrans."Transaction Code");
                EmpTrans.SETRANGE(EmpTrans."Employee Code","No.");
                EmpTrans.SETRANGE(EmpTrans."Transaction Code",NotchTrans."Transaction Code");
                EmpTrans.SETRANGE(EmpTrans."Payroll Period",objPayrollPeriod."Date Opened");
                IF EmpTrans.FIND('-') THEN BEGIN
                EmpTrans.Amount:=NotchTrans.Amount;
                EmpTrans.MODIFY;
                END ELSE BEGIN
                EmpTransR.INIT;
                EmpTransR."Employee Code":="No.";
                EmpTransR."Transaction Code":=NotchTrans."Transaction Code";
                EmpTransR."Period Month":=objPayrollPeriod."Period Month";
                EmpTransR."Period Year":=objPayrollPeriod."Period Year";
                EmpTransR."Payroll Period":=objPayrollPeriod."Date Opened";
                EmpTransR."Transaction Name":=NotchTrans."Transaction Name";
                EmpTransR.Amount:=NotchTrans.Amount;
                EmpTransR.INSERT;
                
                END;
                
                
                UNTIL NotchTrans.NEXT = 0;
                END;
                
                END;
                */

            end;
        }
        field(303;"Status Change Date";Date)
        {
        }
        field(304;"Previous Month Filter";Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(305;"Current Month Filter";Date)
        {
            FieldClass = FlowFilter;
        }
        field(306;"Prev. Basic Pay";Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where ("Employee Code"=field("No."),
                                                                    "Transaction Code"=const('BPAY'),
                                                                    "Payroll Period"=field("Previous Month Filter")));
            FieldClass = FlowField;
        }
        field(307;"Curr. Basic Pay";Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where ("Employee Code"=field("No."),
                                                                    "Transaction Code"=const('BPAY'),
                                                                    "Payroll Period"=field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(308;"Prev. Gross Pay";Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where ("Employee Code"=field("No."),
                                                                    "Transaction Code"=const('GPAY'),
                                                                    "Payroll Period"=field("Previous Month Filter")));
            FieldClass = FlowField;
        }
        field(309;"Curr. Gross Pay";Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where ("Employee Code"=field("No."),
                                                                    "Transaction Code"=const('GPAY'),
                                                                    "Payroll Period"=field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(310;"Gross Income Variation";Decimal)
        {
            FieldClass = Normal;
        }
        field(311;"Basic Pay";Decimal)
        {
            CalcFormula = sum(Table51516265.Field2 where (Field1=field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(312;"Net Pay";Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where ("Employee Code"=field("No."),
                                                                    "Transaction Code"=const('NPAY'),
                                                                    "Payroll Period"=field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(313;"Transaction Amount";Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where ("Employee Code"=field("No."),
                                                                    "Transaction Code"=field("Transaction Code Filter"),
                                                                    "Payroll Period"=field("Current Month Filter")));
            FieldClass = FlowField;
        }
        field(314;"Transaction Code Filter";Text[30])
        {
            FieldClass = FlowFilter;
            TableRelation = "Job-Journal Line"."Journal Template Name";
        }
        field(317;"Account Type";Option)
        {
            OptionCaption = ' ,Savings,Current';
            OptionMembers = " ",Savings,Current;
        }
        field(318;"Location/Division Filter";Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where ("Dimension Code"=const('LOC/DIV'));
        }
        field(319;"Department Filter";Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where ("Dimension Code"=const('DEPARTMENT'));
        }
        field(320;"Cost Centre Filter";Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where ("Dimension Code"=const('COSTCENTRE'));
        }
        field(323;"Payroll Type";Option)
        {
            Description = 'General,Consultants,Seconded Staff';
            OptionCaption = 'General,Consultants,Seconded Staff';
            OptionMembers = General,Consultants,"Seconded Staff";
        }
        field(324;"Employee Classification";Code[20])
        {
            Description = 'Service';
        }
        field(328;"Department Name";Text[20])
        {
        }
        field(2004;"Total Leave Taken";Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" where ("Staff No."=field("No."),
                                                                             "Posting Date"=field("Date Filter"),
                                                                             "Leave Entry Type"=const(Negative),
                                                                             Closed=const(false),
                                                                             "Leave Type"=const('ANNUAL')));
            DecimalPlaces = 2:2;
            FieldClass = FlowField;
        }
        field(2006;"Total (Leave Days)";Decimal)
        {
            DecimalPlaces = 2:2;
            Editable = false;
        }
        field(2007;"Cash - Leave Earned";Decimal)
        {
            DecimalPlaces = 2:2;
        }
        field(2008;"Reimbursed Leave Days";Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" where ("Staff No."=field("No."),
                                                                             "Posting Date"=field("Date Filter"),
                                                                             "Leave Entry Type"=const(Reimbursement),
                                                                             "Leave Type"=field("Leave Type Filter"),
                                                                             Closed=const(false)));
            DecimalPlaces = 2:2;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                          Validate("Allocated Leave Days");
            end;
        }
        field(2009;"Cash per Leave Day";Decimal)
        {
            DecimalPlaces = 2:2;
        }
        field(2023;"Allocated Leave Days";Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" where ("Staff No."=field("No."),
                                                                             "Posting Date"=field("Date Filter"),
                                                                             "Leave Entry Type"=const(Positive),
                                                                             Closed=const(false)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                CalcFields("Total Leave Taken");
                "Total (Leave Days)" := "Allocated Leave Days"; //+ "Reimbursed Leave Days";
                //SUM UP LEAVE LEDGER ENTRIES
                "Leave Balance" := "Total (Leave Days)" - "Total Leave Taken";
                //TotalDaysVal := Rec."Total Leave Taken";
            end;
        }
        field(2024;"End of Contract Date";Date)
        {
        }
        field(2040;"Leave Period Filter";Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "HR Leave Periods"."Starting Date" where ("New Fiscal Year"=const(false));
        }
        field(3971;"Annual Leave Account";Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" where ("Leave Type"=const('ANNUAL'),
                                                                             "Staff No."=field("No."),
                                                                             "Leave Entry Type"=filter(<>Reimbursement)));
            FieldClass = FlowField;
        }
        field(3972;"Compassionate Leave Acc.";Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" where ("Leave Type"=const('COMPASSIONATE'),
                                                                             "Staff No."=field("No.")));
            FieldClass = FlowField;
        }
        field(3973;"Maternity Leave Acc.";Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" where ("Leave Type"=const('MATERNITY'),
                                                                             "Staff No."=field("No.")));
            FieldClass = FlowField;
        }
        field(3974;"Paternity Leave Acc.";Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" where ("Leave Type"=const('PATERNITY'),
                                                                             "Staff No."=field("No.")));
            FieldClass = FlowField;
        }
        field(3975;"Sick Leave Acc.";Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" where ("Leave Type"=const('SICK'),
                                                                             "Staff No."=field("No.")));
            FieldClass = FlowField;
        }
        field(3976;"Study Leave Acc";Decimal)
        {
        }
        field(3977;"Appraisal Method";Option)
        {
            OptionCaption = ' ,Normal Appraisal,360 Appraisal';
            OptionMembers = " ","Normal Appraisal","360 Appraisal";
        }
        field(3988;"Leave Type";Code[20])
        {
            TableRelation = "HR Leave Types".Code;
        }
        field(50002;"Bosa Member account";Code[20])
        {
            TableRelation = "Member Register";
        }
        field(50003;"Sacco Paying Bank Code";Code[20])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                 /*BankRec.RESET;
                 BankRec.SETRANGE(BankRec."No.","Sacco Paying Bank Code");
                 IF BankRec.FIND('-') THEN BEGIN
                 "Sacco Paying Bank Name":=BankRec.Name;
                  END;
                  */

            end;
        }
        field(50004;"Sacco Paying Bank Name";Text[30])
        {
        }
        field(50005;"Cheque No";Code[20])
        {

            trigger OnValidate()
            begin
                 /*
                 //***Avoid cheque no Duplications
                 BankLedg.RESET;
                 BankLedg.SETRANGE(BankLedg."Bank Account No.","Sacco Paying Bank Code");
                 BankLedg.SETRANGE(BankLedg."External Document No.","Cheque No");
                 IF BankLedg.FIND('-') THEN BEGIN
                 ERROR('A document with the same Cheque no has been posted');
                 END;
                 */

            end;
        }
        field(53900;"Global Dimension 1 Code";Code[30])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));
        }
        field(53901;"Global Dimension 2 Code";Code[30])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(53902;"Responsibility Center";Code[15])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(53903;HR;Boolean)
        {
        }
        field(53904;"Date Of Joining the Company";Date)
        {
        }
        field(53905;"Date Of Leaving the Company";Date)
        {
        }
        field(53906;"Termination Grounds";Option)
        {
            OptionCaption = ' ,Resignation,Non-Renewal Of Contract,Dismissal,Retirement,Death,Other';
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;
        }
        field(53907;"Cell Phone Number";Text[30])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(53908;Grade;Code[20])
        {
            TableRelation = "HR Lookup Values".Code where (Type=const(Grade));
        }
        field(53909;"Employee UserID";Code[30])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(53910;"Leave Balance";Decimal)
        {
        }
        field(53911;"Leave Status";Option)
        {
            OptionCaption = ' ,On Leave,Resumed';
            OptionMembers = " ","On Leave",Resumed;
        }
        field(53912;"Pension Scheme Join Date";Date)
        {
        }
        field(53913;"Medical Scheme Join Date";Date)
        {
        }
        field(53914;"Leave Type Filter";Code[20])
        {
            TableRelation = "HR Leave Types".Code;
        }
        field(53915;"Acrued Leave Days";Decimal)
        {
        }
        field(53916;Supervisor;Boolean)
        {
        }
        field(53917;Signature;Blob)
        {
        }
        field(53918;"Grant/Compliance Officer";Boolean)
        {
        }
        field(53919;"Shortcut Dimension 3 Code";Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where ("Dimension Code"=const('PRODUCT'));

            trigger OnValidate()
            begin
                /*DimVal.RESET;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SETRANGE(DimVal.Code,"Shortcut Dimension 3 Code");
                 IF DimVal.FIND('-') THEN
                    IsCommette:=DimVal.Name
                */

            end;
        }
        field(53920;"Shortcut Dimension 4 Code";Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the Fourth global dimension in the database';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(4));

            trigger OnValidate()
            begin
                /*DimVal.RESET;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SETRANGE(DimVal.Code,"Shortcut Dimension 4 Code");
                 IF DimVal.FIND('-') THEN
                    IsBoardChair:=DimVal.Name
                */

            end;
        }
        field(53921;IsCommette;Boolean)
        {
        }
        field(53922;IsBoardChair;Boolean)
        {
        }
        field(53923;IsPayrollPeriodCreator;Boolean)
        {
        }
        field(53924;"Shortcut Dimension 5 Code";Code[20])
        {
            CaptionClass = '1,2,5';
            Description = 'Stores the reference of the 5th global dimension in the database Station';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(5));

            trigger OnValidate()
            begin
                /*DimVal.RESET;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SETRANGE(DimVal.Code,"Shortcut Dimension 4 Code");
                 IF DimVal.FIND('-') THEN
                    IsBoardChair:=DimVal.Name
                 */

            end;
        }
        field(53925;"Institutional Base";Decimal)
        {
        }
        field(53926;"Bank Code";Code[15])
        {
        }
        field(53927;IsBoard;Boolean)
        {
        }
        field(53928;"Branch Code";Code[15])
        {
        }
        field(53929;"Attachement 1";Blob)
        {
            SubType = Bitmap;
        }
        field(53930;"Attachement 2";Blob)
        {
            SubType = Bitmap;
        }
        field(53931;"Attachement 3";Blob)
        {
            SubType = Bitmap;
        }
        field(53932;"Attachement 4";Blob)
        {
            SubType = Bitmap;
        }
        field(53933;"Attachement 5";Blob)
        {
            SubType = Bitmap;
        }
        field(53934;"Attachement 6";Blob)
        {
            SubType = Bitmap;
        }
        field(53935;"Attachement 7";Blob)
        {
            SubType = Bitmap;
        }
        field(53936;"Attachement 8";Blob)
        {
            SubType = Bitmap;
        }
        field(53937;"Attachement 9";Blob)
        {
            SubType = Bitmap;
        }
        field(53938;"Attachement 10";Blob)
        {
            SubType = Bitmap;
        }
        field(53939;"Pension Number";Code[20])
        {
        }
        field(53940;"Claim Limit";Decimal)
        {

            trigger OnValidate()
            begin
                if "Claim Limit"<0 then
                Error('Your Cannot have Negative Amount');
            end;
        }
        field(53941;"Claim Amount Used";Decimal)
        {
            CalcFormula = sum("HR Medical Claim Entries"."Amount Claimed" where ("Employee No"=field("No.")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                /*ClaimEntries.RESET;
                ClaimEntries.SETRANGE(ClaimEntries."Employee No","No.");
                IF ClaimEntries.FIND('-') THEN BEGIN
                  UsedAMTBuffer:=ClaimEntries."Amount Claimed";
                  END;
                "Claim Remaining Amount":="Claim Limit"-UsedAMTBuffer;
                MODIFY;
                */

            end;
        }
        field(53942;"Fosa Account";Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(53943;"Claim Remaining Amount";Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(53944;"Leave Allowance Claimed";Boolean)
        {
        }
        field(53945;"Leave Allowance Amount";Decimal)
        {
        }
        field(53946;"Medical Out-Patient Limit";Decimal)
        {
        }
        field(53947;"Medical In-Patient Limit";Decimal)
        {
        }
        field(53948;"Medical Maximum Cover";Decimal)
        {
        }
        field(53949;"Medical No Of Dependants";Code[10])
        {
        }
        field(53950;"Outstanding Leave Balance";Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" where ("Staff No."=field("No."),
                                                                             "Posting Date"=field("Date Filter"),
                                                                             "Leave Type"=filter('ANNUAL')));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
            Clustered = true;
        }
        key(Key2;"First Name")
        {
        }
        key(Key3;"Last Name")
        {
        }
        key(Key4;"ID Number")
        {
        }
        key(Key5;"Known As")
        {
        }
        key(Key6;"User ID")
        {
        }
        key(Key7;"Cost Code")
        {
        }
        key(Key8;"Date Of Join","Date Of Leaving")
        {
        }
        key(Key9;"Termination Category")
        {
        }
        key(Key10;"Department Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"No.",Initials,"First Name","Middle Name","Last Name")
        {
        }
    }

    trigger OnDelete()
    begin
        ///ERROR('Cannot be deleted')
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
          HrSetup.Get;
          if "Contract Type"="contract type"::Deployed then begin
             HrSetup.TestField(HrSetup."Deployed Nos");
             NoSeriesMgt.InitSeries(HrSetup."Deployed Nos",xRec."No. Series",0D,"No.","No. Series");
          end
          else if "Contract Type"="contract type"::"Full Time" then begin
            HrSetup.TestField(HrSetup."Full Time Nos");
            NoSeriesMgt.InitSeries(HrSetup."Full Time Nos",xRec."No. Series",0D,"No.","No. Series");
          end else if "Contract Type"="contract type"::Board then begin
            HrSetup.TestField(HrSetup."Board Nos");
            NoSeriesMgt.InitSeries(HrSetup."Board Nos",xRec."No. Series",0D,"No.","No. Series");
          end else if "Contract Type"="contract type"::Committee then begin
            HrSetup.TestField(HrSetup."Committee Nos");
            NoSeriesMgt.InitSeries(HrSetup."Committee Nos",xRec."No. Series",0D,"No.","No. Series");
          end;
        end;
    end;

    trigger OnModify()
    begin
        //"Last Date Modified" := TODAY;
    end;

    trigger OnRename()
    begin
        //"Last Date Modified" := TODAY;
    end;

    var
        Res: Record Resource;
        PostCode: Record "Post Code";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        OK: Boolean;
        User: Record "User Setup";
        ERROR1: label 'Employee Career History Starting Information already exist.';
        MSG1: label 'Employee Career History Starting Information successfully created.';
        ReasonDiaglog: Dialog;
        EmpQualification: Record "Employee Qualification";
        PayStartDate: Date;
        PayPeriodText: Text[30];
        ToD: Date;
        CurrentMonth: Date;
        HrSetup: Record "HR Setup";
        SalGrade: Record "HR Salary Grades";
        SalNotch: Record "HR Salary Notch";
        objPayrollPeriod: Record "prPayroll Periods";
        EmpTrans: Record "prEmployee Transactions";
        EmpTransR: Record "prEmployee Transactions";
        NotchTrans: Record "Salary Step/Notch Transactions";
        SalaryGrades: Record "HR Salary Grades";
        UserMgt: Codeunit "User Management";
        DimVal: Record "Dimension Value";
        objJobs: Record "HR Jobss";
        HREmp: Record "HR Employees";
        EmpFullName: Text;
        SPACER: label ' ';
        BankRec: Record "Bank Account";
        ClaimEntries: Record "HR Medical Claim Entries";
        UsedAMTBuffer: Decimal;
        ObjMedicalScheme: Record "HR Medical Schemes";
        ObjSchemeMembers: Record "HR Insurance Scheme Members";


    procedure AssistEdit(OldEmployee: Record "HR Employees"): Boolean
    begin
    end;


    procedure FullName(): Text[100]
    begin
        if "Middle Name" = '' then
          exit("Known As" + ' ' + "Last Name")
        else
          exit("Known As" + ' ' + "Middle Name" + ' ' + "Last Name");
    end;


    procedure CurrentPayDetails()
    begin
    end;


    procedure UpdtResUsersetp(var HREmpl: Record "HR Employees")
    var
        Res: Record Resource;
        Usersetup: Record "User Setup";
    begin
        /*
        ContMgtSetup.GET;
        IF ContMgtSetup."Customer Integration" =
           ContMgtSetup."Customer Integration"::"No Integration"
        THEN
          EXIT;
        */
        /*
        Res.SETCURRENTKEY("No.");
        Res.SETRANGE("No.",HREmpl."Resource No.");
        IF Res.FIND('-') THEN BEGIN
          Res."Global Dimension 1 Code" := HREmpl."Department Code";
          Res."Global Dimension 2 Code" := HREmpl.Office;
          Res.MODIFY;
        END;
        
        IF Usersetup.GET(HREmpl."User ID") THEN BEGIN
          Usersetup.Department := HREmpl."Department Code";
          Usersetup.Office := HREmpl.Office;
          Usersetup.MODIFY;
        END;
        */

    end;


    procedure SetEmployeeHistory()
    begin
    end;


    procedure GetPayPeriod()
    begin
    end;
}

