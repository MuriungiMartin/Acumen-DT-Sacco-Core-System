#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516360 "Membership Applications"
{
    Caption = 'Membership Applications';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "Membership Application List";
    LookupPageID = "Membership Application List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Member Application Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';

            trigger OnLookup()
            begin
                FnCreateDefaultSavingsProducts();
            end;

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
                    "Search Name" := Name;
                Name := UpperCase(Name);
                FnCreateDefaultSavingsProducts();
            end;
        }
        field(3; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }
        field(4; "Name 2"; Text[50])
        {
            Caption = 'Name 2';

            trigger OnLookup()
            begin
                //FnCreateDefaultSavingsProducts();
            end;

            trigger OnValidate()
            begin
                //FnCreateDefaultSavingsProducts();
                "Name 2" := "First Name" + "Name 2";
            end;
        }
        field(5; Address; Text[50])
        {
            Caption = 'Address';

            trigger OnValidate()
            begin
                Address := UpperCase(Address);
            end;
        }
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';

            trigger OnValidate()
            begin
                "Address 2" := UpperCase("Address 2");
            end;
        }
        field(7; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            begin
                "Phone No." := UpperCase("Phone No.")
            end;
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                DimValue.Reset;
                DimValue.SetRange(DimValue.Code, "Global Dimension 2 Code");
                if DimValue.Find('-') then begin
                    "Member Branch Code" := DimValue.Code;
                end;
                // FnCreateDefaultSavingsProducts();
            end;
        }
        field(10; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
        }
        field(11; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(12; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(68000; "Customer Type"; Option)
        {
            OptionCaption = ' ,Member,FOSA,Investments,Property';
            OptionMembers = " ",Member,FOSA,Investments,Property;
        }
        field(68001; "Registration Date"; Date)
        {
        }
        field(68002; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(68003; "Employer Code"; Code[20])
        {
            TableRelation = "Sacco Employers";

            trigger OnValidate()
            begin
                /*Employer.GET("Employer Code");
                "Employer Name":=Employer.Description;*/
                Employer.Reset;
                Employer.SetRange(Employer.Code, "Employer Code");
                if Employer.Find('-') then begin
                    "Employer Name" := Employer.Description;
                end;

            end;
        }
        field(68004; "Date of Birth"; Date)
        {

            trigger OnValidate()
            begin
                if "Date of Birth" > Today then
                    Error('Date of birth cannot be greater than today');

                if "Account Category" <> "account category"::Parish then begin
                    if "Date of Birth" <> 0D then begin
                        if GenSetUp.Get() then begin
                            if CalcDate(GenSetUp."Min. Member Age", "Date of Birth") > Today then
                                Error('Applicant bellow the mininmum membership age of %1', GenSetUp."Min. Member Age");
                        end;
                    end;
                end;
                Age := Dates.DetermineAge("Date of Birth", Today);
            end;
        }
        field(68005; "E-Mail (Personal)"; Text[50])
        {
        }
        field(68006; "Station/Department"; Code[20])
        {
            TableRelation = "HR Leave Attachments"."Employee No" where("Document Link" = field("Employer Code"));
        }
        field(68007; "Home Address"; Text[50])
        {

            trigger OnValidate()
            begin
                "Home Address" := UpperCase("Home Address");
            end;
        }
        field(68008; Location; Text[30])
        {
        }
        field(68009; "Sub-Location"; Text[50])
        {
        }
        field(68010; District; Text[50])
        {
        }
        field(68011; "Payroll No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Payroll No" <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."Personal No", "Payroll No");
                    Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                    if Cust.Find('-') then begin
                        Error('Payroll No already exists in the Members List');
                    end;
                end;
            end;
        }
        field(68012; "ID No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "ID No." <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."ID No.", "ID No.");
                    Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                    if Cust.Find('-') then begin
                        if (Cust."No." <> "No.") and (Cust.Status = Cust.Status::Active) then
                            Error('ID No. already exists in the Members List');
                    end;
                end;

                if "Passport No." = '' then begin
                    if StrLen("ID No.") < 5 then
                        Error('Member ID No. Can not be less than 5 Characters');
                end;
                ObjMemberApplication.Reset;
                ObjMemberApplication.SetRange(ObjMemberApplication."ID No.", "ID No.");
                if ObjMemberApplication.FindFirst = true then
                    Error('ID Number already exists.Duplicate ID Numbers are allowed.');
            end;
        }
        field(68013; "Mobile Phone No"; Code[30])
        {

            trigger OnValidate()
            begin
                if StrLen("Mobile Phone No") <> 12 then
                    Error('Mobile No. Can not be more or less than 12 Characters');

                if "Mobile Phone No" <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."Mobile Phone No", "Mobile Phone No");
                    if Cust.Find('-') then
                        Error('This Mobile Number is already in use by an active Member.Kindly  use another number');
                end;

                if "Mobile Phone No" <> '' then begin
                    ObjMemberApplication.Reset;
                    ObjMemberApplication.SetRange(ObjMemberApplication."Mobile Phone No", "Mobile Phone No");
                    if ObjMemberApplication.Find('-') = true then
                        Error('This Mobile Number %1 is already in use.Kindly  use another number', ObjMemberApplication."Mobile Phone No");
                end;
            end;
        }
        field(68014; "Marital Status"; Option)
        {
            OptionCaption = ' ,Single,Married,Divorced,Widower,Widow';
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(68015; Signature; MediaSet)
        {
        }
        field(68016; "Passport No."; Code[50])
        {
        }
        field(68017; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(68018; "Monthly Contribution"; Decimal)
        {
        }
        field(68019; "Investment B/F"; Decimal)
        {
        }
        field(68020; "Dividend Amount"; Decimal)
        {
        }
        field(68021; "Name of Chief"; Text[50])
        {
        }
        field(68022; "Office Telephone No."; Code[50])
        {
        }
        field(68023; "Extension No."; Code[30])
        {
        }
        field(68024; "Insurance Contribution"; Decimal)
        {
        }
        field(68025; Province; Code[50])
        {
        }
        field(68026; "Current File Location"; Code[50])
        {
            CalcFormula = max("File Movement Tracker".Station where("Member No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68027; "Village/Residence"; Text[50])
        {
        }
        field(68028; "File Movement Remarks"; Text[100])
        {
        }
        field(68029; "Office Branch"; Code[20])
        {
        }
        field(68030; Department; Code[20])
        {
            TableRelation = "Member Departments"."No.";
        }
        field(68031; Section; Code[20])
        {
            TableRelation = "Member Section"."No.";
        }
        field(68032; "No. Series"; Code[10])
        {
        }
        field(68033; Occupation; Text[30])
        {
        }
        field(68034; Designation; Text[30])
        {
        }
        field(68035; "Terms of Employment"; Option)
        {
            OptionMembers = " ",Permanent,Contract,Casual;
        }
        field(68036; Category; Code[20])
        {
        }
        field(68037; Picture; MediaSet)
        {
        }
        field(68038; "Postal Code"; Code[20])
        {
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                PostCode.Reset;
                PostCode.SetRange(PostCode.Code, "Postal Code");
                if PostCode.Find('-') then begin
                    Town := PostCode.City;
                    City := PostCode.City;
                end;
            end;
        }
        field(68039; City; Text[30])
        {
            Caption = 'City';
            TableRelation = "Post Code".City;

            trigger OnLookup()
            begin
                //PostCode.LookUpCity(City,"Postal Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Postal Code",'','','');
            end;
        }
        field(68040; "Contact Person"; Code[20])
        {
        }
        field(68041; "Approved By"; Code[20])
        {
        }
        field(68042; "Sent for Approval By"; Code[20])
        {
        }
        field(68043; "Responsibility Centre"; Code[20])
        {
        }
        field(68044; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                //IF ("Country/Region Code" <> xRec."Country/Region Code") AND (xRec."Country/Region Code" <> '') THEN
                //PostCode.ClearFields(City,"Post Code",County);
            end;
        }
        field(68045; County; Text[30])
        {
            Caption = 'County';
            TableRelation = "Buffer c";
        }
        field(68046; "Bank Code"; Code[20])
        {
        }
        field(68047; "Bank Name"; Code[20])
        {
        }
        field(68048; "Bank Account No"; Code[20])
        {
        }
        field(68049; "Contact Person Phone"; Code[30])
        {

            trigger OnValidate()
            begin
                if StrLen("Contact Person Phone") <> 12 then
                    Error('Contact Person phone No. Can not be more or less than 12 Characters');
            end;
        }
        field(68050; "ContactPerson Relation"; Code[20])
        {
            TableRelation = "Relationship Types";
        }
        field(68051; "Recruited By"; Code[30])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Recruited By");
                if Cust.Find('-') then begin
                    "Recruiter Name" := Cust.Name;
                end;

                /*IF User.GET("Recruited By") THEN
                "Recruiter Name":=User."Full Name";*/

                HREmployee.Reset;
                HREmployee.SetRange(HREmployee."No.", "Recruited By");
                if HREmployee.Find('-') then begin
                    "Recruiter Name" := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                end;

            end;
        }
        field(68052; "ContactPerson Occupation"; Code[20])
        {
        }
        field(68053; Dioces; Code[30])
        {
        }
        field(68054; "Mobile No. 2"; Code[20])
        {

            trigger OnValidate()
            begin
                if StrLen("Mobile No. 2") <> 12 then
                    Error('Mobile No. Can not be more or less than 12 Characters');
            end;
        }
        field(68055; "Employer Name"; Code[50])
        {
        }
        field(68056; Title; Option)
        {
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(68057; Town; Code[30])
        {
        }
        field(68058; "Received 1 Copy Of ID"; Boolean)
        {
        }
        field(68059; "Received 1 Copy Of Passport"; Boolean)
        {
        }
        field(68060; "Specimen Signature"; Boolean)
        {
        }
        field(68061; "Home Postal Code"; Code[20])
        {
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                PostCode.Reset;
                PostCode.SetRange(PostCode.Code, "Home Postal Code");
                if PostCode.Find('-') then begin
                    "Home Town" := PostCode.City
                end;
            end;
        }
        field(68062; Created; Boolean)
        {
        }
        field(68063; "Incomplete Application"; Boolean)
        {
        }
        field(68064; "Created By"; Text[60])
        {
        }
        field(68065; "Assigned No."; Code[30])
        {
            CalcFormula = lookup(Customer."No." where("ID No." = field("ID No.")));
            FieldClass = FlowField;
        }
        field(68066; "Home Town"; Text[60])
        {
        }
        field(68067; "Recruiter Name"; Text[50])
        {
        }
        field(68068; "Copy of Current Payslip"; Boolean)
        {
        }
        field(68069; "Member Registration Fee Receiv"; Boolean)
        {
        }
        field(68070; "Account Category"; Option)
        {
            OptionCaption = 'Single,Joint,Corporate,Group,Parish,Church,Church Department';
            OptionMembers = Single,Joint,Corporate,Group,Parish,Church,"Church Department";
        }
        field(68071; "Copy of KRA Pin"; Boolean)
        {
        }
        field(68072; "Contact person age"; Date)
        {

            trigger OnValidate()
            begin
                /* IF "Contact person age" > TODAY THEN
                 ERROR('Age cannot be greater than today');
                
                
                IF "Contact person age" <> 0D THEN BEGIN
                IF GenSetUp.GET() THEN BEGIN
                IF CALCDATE(GenSetUp."Min. Member Age","Contact person age") > TODAY THEN
                ERROR('Contact person should be atleast 18years and above %1',GenSetUp."Min. Member Age");
                END;
                END;  */

            end;
        }
        field(68073; "First member name"; Text[30])
        {
        }
        field(68075; "Date Establish"; Date)
        {
        }
        field(68076; "Registration No"; Code[30])
        {
        }
        field(68077; "ID No.2"; Code[30])
        {
        }
        field(68079; "Registration office"; Text[30])
        {
            TableRelation = Location.Code;
        }
        field(68080; "Picture 2"; Blob)
        {
            SubType = Bitmap;
        }
        field(68081; "Signature  2"; Blob)
        {
            SubType = Bitmap;
        }
        field(68082; Title2; Option)
        {
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(68083; "Mobile No. 3"; Code[20])
        {

            trigger OnValidate()
            begin
                if StrLen("Mobile No. 3") <> 12 then
                    Error('Mobile No. Can not be more or less than 12 Characters');
            end;
        }
        field(68084; "Date of Birth2"; Date)
        {

            trigger OnValidate()
            begin
                if "Date of Birth" > Today then
                    Error('Date of birth cannot be greater than today');


                if "Date of Birth" <> 0D then begin
                    if GenSetUp.Get() then begin
                        if CalcDate(GenSetUp."Min. Member Age", "Date of Birth") > Today then
                            Error('Applicant bellow the mininmum membership age of %1', GenSetUp."Min. Member Age");
                    end;
                end;
            end;
        }
        field(68085; "Marital Status2"; Option)
        {
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(68086; Gender2; Option)
        {
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(68087; Address3; Code[30])
        {
        }
        field(68088; "Home Postal Code2"; Code[20])
        {
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                PostCode.Reset;
                PostCode.SetRange(PostCode.Code, "Home Postal Code");
                if PostCode.Find('-') then begin
                    "Home Town" := PostCode.City
                end;
            end;
        }
        field(68089; "Home Town2"; Text[20])
        {
        }
        field(68090; "Payroll/Staff No2"; Code[20])
        {
        }
        field(68100; "Employer Code2"; Code[20])
        {
            TableRelation = "HR Asset Transfer Header";

            trigger OnValidate()
            begin
                Employer.Get("Employer Code");
                "Employer Name" := Employer.Description;
            end;
        }
        field(68101; "Employer Name2"; Code[30])
        {
        }
        field(68102; "E-Mail (Personal2)"; Text[50])
        {
        }
        field(68103; Age; Text[50])
        {
        }
        field(68104; "Copy of constitution"; Boolean)
        {
        }
        field(68105; "Nominee Envelope No."; Code[20])
        {
        }
        field(68106; "Self Recruited"; Boolean)
        {
        }
        field(68107; "Relationship With Recruiter"; Code[20])
        {
        }
        field(68108; "Application Category"; Option)
        {
            OptionCaption = 'New Application,Account Reactivation,Transfer';
            OptionMembers = "New Application","Account Reactivation",Transfer;
        }
        field(68109; "Rejoining Date"; Date)
        {
        }
        field(68110; "Previous Reg. Date"; Date)
        {
        }
        field(68112; "Office Extension"; Code[20])
        {
        }
        field(68113; "Appointment Letter"; Boolean)
        {
        }
        field(68114; "Date of Appointment"; Date)
        {
        }
        field(68115; "Terms Of Service"; Option)
        {
            OptionCaption = ' ,Permanent,Temporary,Contract,Private,Probation';
            OptionMembers = " ",Permanent,"Temporary",Contract,Private,Probation;
        }
        field(68116; "Home Country"; Code[20])
        {
            TableRelation = "Post Code"."Country/Region Code";
        }
        field(68117; "Home Page"; Text[1])
        {
        }
        field(68118; "Basic Pay"; Decimal)
        {

            trigger OnValidate()
            begin
                GenSetUp.Get();
                //IF "Monthly Contribution"=0 THEN BEGIN
                //  "Monthly Contribution":="Basic Pay"*(GenSetUp."Min Deposit Cont.(% of Basic)"/100);
                //  IF "Monthly Contribution"<GenSetUp."Min. Contribution" THEN BEGIN
                //    "Monthly Contribution":=GenSetUp."Min. Contribution"
                //    END ELSE
                //  "Monthly Contribution":="Monthly Contribution";
                // END;
            end;
        }
        field(68119; "Members Parish"; Code[20])
        {
            TableRelation = "Member's Parishes".Code;

            trigger OnValidate()
            begin
                Parishes.Reset;
                Parishes.SetRange(Parishes.Code, "Members Parish");
                if Parishes.Find('-') then begin
                    "Parish Name" := Parishes.Description;
                    "Member Share Class" := Parishes."Share Class";
                end;
            end;
        }
        field(68120; "Parish Name"; Text[15])
        {
        }
        field(68121; "Employment Info"; Option)
        {
            OptionCaption = ' ,Employed,UnEmployed,Contracting,Others';
            OptionMembers = " ",Employed,UnEmployed,Contracting,Others;
        }
        field(68122; "Contracting Details"; Text[30])
        {
        }
        field(68123; "Others Details"; Text[50])
        {
        }
        field(68124; Products; Option)
        {
            OptionCaption = 'BOSA Account,BOSA+Current Account,BOSA+Smart Saver,BOSA+Fixed Deposit,Smart Saver Only,Current Only,Fixed  Deposit Only,Fixed+Smart Saver,Fixed+Current,Current+Smart Saver';
            OptionMembers = "BOSA Account","BOSA+Current Account","BOSA+Smart Saver","BOSA+Fixed Deposit","Smart Saver Only","Current Only","Fixed  Deposit Only","Fixed+Smart Saver","Fixed+Current","Current+Smart Saver";
        }
        field(68125; "Joint Account Name"; Text[30])
        {
        }
        field(68126; "Postal Code 2"; Code[2])
        {
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                "Postal Code 2" := UpperCase("Postal Code 2");
            end;
        }
        field(68127; "Town 2"; Code[2])
        {

            trigger OnValidate()
            begin
                "Town 2" := UpperCase("Town 2");
            end;
        }
        field(68128; "Passport 2"; Code[1])
        {

            trigger OnValidate()
            begin
                "Passport 2" := UpperCase("Passport 2");
            end;
        }
        field(68129; "Member Parish 2"; Code[20])
        {
            TableRelation = "Member's Parishes".Code;

            trigger OnValidate()
            begin
                "Member Parish 2" := UpperCase("Member Parish 2");

                Parishes.Reset;
                Parishes.SetRange(Parishes.Code, "Member Parish 2");
                if Parishes.Find('-') then begin
                    "Member Parish Name 2" := Parishes.Description;
                    //"Member Share Class":=Parishes."Share Class";
                end;
            end;
        }
        field(68130; "Member Parish Name 2"; Text[30])
        {

            trigger OnValidate()
            begin
                "Member Parish Name 2" := UpperCase("Member Parish Name 2");
            end;
        }
        field(68131; "Name of the Group/Corporate"; Text[30])
        {

            trigger OnValidate()
            begin
                "Name of the Group/Corporate" := UpperCase("Name of the Group/Corporate");
                Name := "Name of the Group/Corporate";
            end;
        }
        field(68132; "Date of Registration"; Date)
        {
        }
        field(68133; "No of Members"; Integer)
        {
        }
        field(68134; "Group/Corporate Trade"; Code[20])
        {
            TableRelation = "Type of Trade";

            trigger OnValidate()
            begin
                "Group/Corporate Trade" := UpperCase("Group/Corporate Trade");
            end;
        }
        field(68135; "Certificate No"; Code[20])
        {
        }
        field(68136; "KRA PIN"; Code[20])
        {
        }
        field(68137; "Signing Instructions"; Code[20])
        {
        }
        field(68138; "Need a Cheque book"; Boolean)
        {
        }
        field(68140; "Group Account No"; Code[20])
        {
            TableRelation = Customer."No." where("Group Account" = filter(true));

            trigger OnValidate()
            begin
                //"Group Account Name":='';
                /*MemberAppl.RESET;
                IF MemberAppl.GET("Group Account No") THEN BEGIN
                IF MemberAppl."Group Account"=TRUE THEN
                "Group Account Name":=MemberAppl.Name;
                "Recruited By":=MemberAppl."Recruited By";
                "Salesperson Name":=MemberAppl."Loan Officer Name";
                END;
                
                {``
                GenSetUp.GET;
                 IF "Group Account No" = '5000' THEN BEGIN
                  "Monthly Contribution":=GenSetUp."Business Min. Shares";
                 END;
                 }
                {
                MemberAppl.SETRANGE(MemberAppl."Group Account No","BOSA Account No.");
                MemberAppl.SETRANGE(MemberAppl."Group Account",TRUE);
                IF MemberAppl.FIND('-') THEN BEGIN
                "Group Account Name":=MemberAppl.Name;
                END
                }
                */

                if Cust.Get("Group Account No") then begin
                    "Group Account Name" := Cust.Name;
                    "Salesperson Name" := Cust."Business Loan Officer";
                end;

            end;
        }
        field(68141; "Group Account Name"; Code[26])
        {
        }
        field(68142; "BOSA Account No."; Code[20])
        {
            TableRelation = Customer where("Customer Posting Group" = filter('MEMBER'));

            trigger OnValidate()
            begin
                /*
                GenSetUp.GET();
                
                CustMember.RESET;
                CustMember.SETRANGE(CustMember."No.","BOSA Account No.");
                IF CustMember.FIND('-') THEN
                
                CustMember.TESTFIELD(CustMember."FOSA Account No.");
                //CustMember.TESTFIELD(CustMember."Member Category");
                CustMember.TESTFIELD(CustMember."ID No.");
                //CustMember.TESTFIELD(CustMember."Date of Birth");
                CustMember.TESTFIELD(CustMember."Global Dimension 2 Code");
                
                IF CustMember.Status<>CustMember.Status::Active THEN BEGIN
                ERROR(Text0024,CustMember.Status);
                END;
                {IF "Class B Category"="Class B Category"::Sibling THEN BEGIN
                ERROR(Text0026,CustMember."Member Category");
                END;}
                
                
                
                */


                GenSetUp.Get();

                CustMember.Reset;
                CustMember.SetRange(CustMember."No.", "BOSA Account No.");
                if CustMember.FindSet then begin
                    //CustMember.CALCFIELDS(CustMember.Picture,CustMember.Signature);
                    Name := CustMember.Name;
                    "Payroll No" := CustMember."Personal No";
                    "ID No." := CustMember."ID No.";
                    "FOSA Account No." := CustMember."FOSA Account No.";
                    "Account Category" := CustMember."Account Category";
                    "Postal Code" := CustMember."Post Code";
                    "Phone No." := CustMember."Phone No.";
                    "Employer Code" := CustMember."Employer Code";
                    "Date of Birth" := CustMember."Date of Birth";
                    "Phone No." := CustMember."Phone No.";
                    Address := CustMember.Address;
                    "Village/Residence" := CustMember."Village/Residence";
                    "Mobile Phone No" := CustMember."Mobile Phone No";
                    "Mobile Phone No" := CustMember."Phone No.";
                    "Marital Status" := CustMember."Marital Status";
                    Gender := CustMember.Gender;
                    "E-Mail (Personal)" := CustMember."E-Mail";
                    Picture := CustMember.Piccture;
                    Signature := CustMember.Signature;
                    "Global Dimension 2 Code" := CustMember."Global Dimension 2 Code";
                    "Account Category" := CustMember."Member Category";
                    "Bank Code" := CustMember."Bank Code";
                    "Bank Name" := CustMember."Bank Branch Code";
                    "Bank Account No" := CustMember."Bank Account No.";
                    "Member Share Class" := CustMember."Member Share Class";
                    County := CustMember.County;
                    "Member Dioces" := CustMember.Dioces;
                    "Member Arch Dioces" := CustMember."Arch Dioces";
                    "Members Parish" := CustMember."Members Parish";
                    Modify;

                end;

            end;
        }
        field(68143; "FOSA Account No."; Code[20])
        {
        }
        field(68144; "Micro Group Code"; Code[20])
        {
        }
        field(68145; Source; Option)
        {
            Editable = false;
            OptionCaption = 'Bosa,Micro';
            OptionMembers = Bosa,Micro;
        }
        field(68150; "Account Type"; Option)
        {
            OptionCaption = ' ,Single,Group';
            OptionMembers = " ",Single,Group;
        }
        field(69090; "Postal Code 3"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(69091; "Town 3"; Code[20])
        {
        }
        field(69092; "Passport 3"; Code[20])
        {
        }
        field(69093; "Member Parish 3"; Code[20])
        {
            TableRelation = "Member's Parishes".Code;

            trigger OnValidate()
            begin
                Parishes.Reset;
                Parishes.SetRange(Parishes.Code, "Member Parish 3");
                if Parishes.Find('-') then begin
                    "Member Parish Name 3" := Parishes.Description;
                    //"Member Share Class":=Parishes."Share Class";
                end;
            end;
        }
        field(69094; "Member Parish Name 3"; Text[20])
        {
        }
        field(69100; "ID No.3"; Code[20])
        {
        }
        field(69101; "Picture 3"; Blob)
        {
            SubType = Bitmap;
        }
        field(69102; "Signature  3"; Blob)
        {
            SubType = Bitmap;
        }
        field(69103; Title3; Option)
        {
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(69104; "Mobile No. 4"; Code[20])
        {
        }
        field(69105; "Date of Birth3"; Date)
        {

            trigger OnValidate()
            begin
                if "Date of Birth" > Today then
                    Error('Date of birth cannot be greater than today');


                if "Date of Birth" <> 0D then begin
                    if GenSetUp.Get() then begin
                        if CalcDate(GenSetUp."Min. Member Age", "Date of Birth") > Today then
                            Error('Applicant bellow the mininmum membership age of %1', GenSetUp."Min. Member Age");
                    end;
                end;
            end;
        }
        field(69106; "Marital Status3"; Option)
        {
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(69107; Gender3; Option)
        {
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(69108; Address4; Code[20])
        {
        }
        field(69109; "Home Postal Code3"; Code[20])
        {
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                /*PostCode.RESET;
                PostCode.SETRANGE(PostCode.Code,"Home Postal Code2");
                IF PostCode.FIND('-') THEN BEGIN
                "Home Town":=PostCode.City
                END;
                */

            end;
        }
        field(69110; "Home Town3"; Text[20])
        {
        }
        field(69111; "Payroll/Staff No3"; Code[20])
        {
        }
        field(69112; "Employer Code3"; Code[20])
        {

            trigger OnValidate()
            begin
                /*Employer.GET("Employer Code");
                "Employer Name":=Employer.Description;
                */

            end;
        }
        field(69113; "Employer Name3"; Code[20])
        {
        }
        field(69114; "E-Mail (Personal3)"; Text[20])
        {
        }
        field(69115; "First Name3"; Code[10])
        {
        }
        field(69116; "Middle Name 3"; Code[10])
        {
        }
        field(69117; "Last Name3"; Code[10])
        {
        }
        field(69118; "Name 3"; Code[30])
        {

            trigger OnValidate()
            begin
                "Name 3" := "First Name" + "Name 2" + "Name 3";
            end;
        }
        field(69120; "Secondary Mobile No"; Code[10])
        {
        }
        field(69121; "How Did you know of DIMKES"; Option)
        {
            OptionCaption = ' ,Newspaper,Radio,Television Adverst,Website,Facebook,Tweeter,Another Member,Sales Representative,Staff,Others';
            OptionMembers = " ",Newspaper,Radio,"Television Adverst",Website,Facebook,Tweeter,"Another Member","Sales Representative",Staff,Others;
        }
        field(69122; "Member Share Class"; Option)
        {
            OptionCaption = ' ,Class A,Class B';
            OptionMembers = " ","Class A","Class B";
        }
        field(69123; "Member's Residence"; Code[20])
        {
        }
        field(69124; "First Name"; Code[20])
        {
        }
        field(69125; "Middle Name"; Code[20])
        {
        }
        field(69126; "Last Name"; Code[20])
        {
        }
        field(69127; "First Name2"; Code[20])
        {
        }
        field(69128; "Middle Name2"; Code[20])
        {
        }
        field(69129; "Last Name2"; Code[20])
        {
        }
        field(69130; "Member Share Class2"; Option)
        {
            OptionCaption = ' ,Class A,Class B';
            OptionMembers = " ","Class A","Class B";
        }
        field(69131; "Member Branch Code"; Code[20])
        {
            //  TableRelation = "Dimension Value".Field51516220 where("Global Dimension No." = filter(2));
        }
        field(69132; "Captured By"; Code[20])
        {
        }
        field(69139; "Employer No"; Code[20])
        {
        }
        field(69146; "FOSA Account Type"; Code[20])
        {
            Editable = false;
            TableRelation = "Account Types-Saving Products".Code;
        }
        field(69147; "Sales Code"; Code[15])
        {

            trigger OnValidate()
            begin
                /*IF LoanOfficers.GET("Sales Code") THEN BEGIN
                  "Salesperson Name":=LoanOfficers."Account Name";
                  END;
                */

            end;
        }
        field(69148; "Salesperson Name"; Code[20])
        {
        }
        field(69149; "Group Account"; Boolean)
        {
        }
        field(69150; "Any Other Sacco"; Text[10])
        {
        }
        field(69151; "Member classes"; Option)
        {
            OptionCaption = ' ,Plantinum A,Plantinum B,Diamond,Gold';
            OptionMembers = " ","Plantinum A","Plantinum B",Diamond,Gold;
        }
        field(69165; "Member class"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Class A,Class B';
            OptionMembers = ,"Class A","Class B";
        }
        field(69167; "Employment Terms"; Option)
        {
            OptionCaption = ' ,Permanent,Casual';
            OptionMembers = " ",Permanent,Casual;
        }
        field(69168; "Employer Type"; Option)
        {
            OptionCaption = ' ,Employed,Business';
            OptionMembers = " ",Employed,Business;
        }
        field(69169; "Individual Group"; Boolean)
        {
        }
        field(69170; "Member County"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = County.Code;
        }
        field(69171; "Member Dioces"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dioces.Code;
        }
        field(69172; "Member Arch Dioces"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Arch Dioces".Code;
        }
        field(69173; "Signing Instruction"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Any to Sign","Two to Sign","Three to Sign","All to Sign",SELF,SINGLE;
        }
        field(69174; "Joint Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(69175; "IPRS Details"; Boolean)
        {

        }
        field(69176; "IPRS Error Description"; text[100])
        {

        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Name")
        {
        }
        key(Key3; Name, Address, "Phone No.")
        {
        }
        key(Key4; Name)
        {
        }
        key(Key5; "Phone No.")
        {
        }
        key(Key6; "Global Dimension 2 Code")
        {
        }
        key(Key7; "Global Dimension 1 Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, "Phone No.", "Global Dimension 2 Code", "Global Dimension 1 Code")
        {
        }
    }

    trigger OnDelete()
    var
        CampaignTargetGr: Record "Campaign Target Group";
        ContactBusRel: Record "Contact Business Relation";
        Job: Record Job;
        CampaignTargetGrMgmt: Codeunit "Campaign Target Group Mgt";
        StdCustSalesCode: Record "Standard Customer Sales Code";
    begin
        /*IF (Status=Status::Approved) OR(Status=Status::Rejected) THEN
       ERROR('Status must be pending');*/

    end;

    trigger OnInsert()
    var
        UserMgt: Codeunit "User Management";
    begin

        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Member Application Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Member Application Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        GenSetUp.Get();
        "Created By" := UserId;

        "Registration Date" := Today;
        "Customer Posting Group" := GenSetUp."Default Customer Posting Group";
        //"Recruited By":=USERID;
        //"Monthly Contribution":=GenSetUp."Monthly Share Contributions";
        // "Global Dimension 1 Code":='NAIROBI';
        // "Global Dimension 2 Code":='BOSA';
        "Captured By" := UserId;


        UsersRec.Reset;
        UsersRec.SetRange(UsersRec."User Name", UserId);
        if UsersRec.Find('-') then begin
            //"Global Dimension 2 Code":=UsersRec."Branch Code";
        end;

        Validate("Global Dimension 2 Code");
    end;

    trigger OnModify()
    begin
        /*IF (Status=Status::Approved) OR(Status=Status::Rejected)  THEN
        MESSAGE('Status must be pending');
        
        IF ("Created By" <> UPPERCASE(USERID)) AND (Status=Status::Open) THEN
        ERROR('Cannot modify an application being processed by %1',"Created By");*/
        UsersRec.Reset;
        UsersRec.SetRange(UsersRec."User Name", UserId);
        if UsersRec.Find('-') then begin
            //"Global Dimension 2 Code":=UsersRec."Branch Code";
        end;

        Validate("Global Dimension 2 Code");

    end;

    trigger OnRename()
    begin
        /*IF (Status=Status::Approved) OR(Status=Status::Rejected) THEN
        ERROR('Status must be pending');
        
        IF ("Created By" <> UPPERCASE(USERID)) AND (Status=Status::Open) THEN
        ERROR('Cannot modify an application being processed by %1',"Created By");*/

    end;

    var
        Text000: label 'You cannot delete %1 %2 because there is at least one outstanding Sales %3 for this customer.';
        Text002: label 'Do you wish to create a contact for %1 %2?';
        SalesSetup: Record "Sacco No. Series";
        Text003: label 'Contact %1 %2 is not related to customer %3 %4.';
        Text004: label 'post';
        Text005: label 'create';
        Text006: label 'You cannot %1 this type of document when Customer %2 is blocked with type %3';
        Text007: label 'You cannot delete %1 %2 because there is at least one not cancelled Service Contract for this customer.';
        Text008: label 'Deleting the %1 %2 will cause the %3 to be deleted for the associated Service Items. Do you want to continue?';
        Text009: label 'Cannot delete customer.';
        Text010: label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3. Enter another code.';
        Text011: label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?';
        Text012: label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.';
        Text013: label 'You cannot delete %1 %2 because there is at least one outstanding Service %3 for this customer.';
        Text014: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text015: label 'You cannot delete %1 %2 because there is at least one %3 associated to this customer.';
        GenSetUp: Record "Sacco General Set-Up";
        MinShares: Decimal;
        MovementTracker: Record "Movement Tracker";
        Cust: Record Customer;
        Vend: Record Vendor;
        CustFosa: Code[20];
        Vend2: Record Vendor;
        FOSAAccount: Record Vendor;
        StatusPermissions: Record "Status Change Permision";
        RefundsR: Record "Refunds";
        Text016: label 'You cannot change the contents of the %1 field because this %2 has one or more posted ledger entries.';
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PostCode: Record "Post Code";
        User: Record User;
        Employer: Record "Sacco Employers";
        DataSheet: Record "Data Sheet Main";
        Parishes: Record "Member's Parishes";
        UsersRec: Record User;
        Dates: Codeunit "Dates Calculation";
        DAge: DateFormula;
        HREmployee: Record "HR Employees";
        DimValue: Record "Dimension Value";
        CustMember: Record Customer;
        ObjMemberApplication: Record "Membership Applications";


    procedure FnCreateDefaultSavingsProducts()
    var
        ObjSavingsProduct: Record "Account Types-Saving Products";
        ObjSelectedSavingsProducts: Record "Membership Reg. Products Appli";
    begin
        ObjSelectedSavingsProducts.Reset;
        ObjSelectedSavingsProducts.SetRange(ObjSelectedSavingsProducts."Membership Applicaton No", "No.");
        ObjSelectedSavingsProducts.SetRange(ObjSelectedSavingsProducts."Default Product", true);
        if ObjSelectedSavingsProducts.FindSet then
            ObjSelectedSavingsProducts.DeleteAll;

        ObjSavingsProduct.Reset;
        ObjSavingsProduct.SetRange(ObjSavingsProduct."Default Account", true);
        if ObjSavingsProduct.FindSet(true) then begin
            repeat
                if ObjSavingsProduct."Default Account" = true then begin
                    ObjSelectedSavingsProducts.Init;
                    ObjSelectedSavingsProducts."Membership Applicaton No" := "No.";
                    ObjSelectedSavingsProducts.Names := Name;
                    ObjSelectedSavingsProducts."Default Product" := true;
                    ObjSelectedSavingsProducts.Product := ObjSavingsProduct.Code;
                    ObjSelectedSavingsProducts."Product Name" := ObjSavingsProduct.Description;
                    ObjSelectedSavingsProducts."Product Source" := ObjSavingsProduct."Activity Code";
                    ObjSelectedSavingsProducts.Insert;
                    ObjSelectedSavingsProducts.Validate(ObjSelectedSavingsProducts.Product);
                    ObjSelectedSavingsProducts.Modify;
                end;
            until ObjSavingsProduct.Next = 0;
        end
    end;


    procedure FnCreateDefaultSavingsProductsNew()
    var
        ObjSavingsProduct: Record "Account Types-Saving Products";
        ObjSelectedSavingsProducts: Record "Membership Reg. Products Appli";
    begin
        /*ObjSelectedSavingsProducts.RESET;
        ObjSelectedSavingsProducts.SETRANGE(ObjSelectedSavingsProducts."Membership Applicaton No","No.");
        ObjSelectedSavingsProducts.SETRANGE(ObjSelectedSavingsProducts."Default Product",TRUE);
        IF ObjSelectedSavingsProducts.FINDSET THEN
          ObjSelectedSavingsProducts.DELETEALL;
        */
        ObjSavingsProduct.Reset;
        ObjSavingsProduct.SetRange(ObjSavingsProduct."Default Account", true);
        if ObjSavingsProduct.FindSet(true) then begin
            repeat
                if ObjSavingsProduct."Default Account" = true then begin
                    ObjSelectedSavingsProducts.Init;
                    ObjSelectedSavingsProducts."Membership Applicaton No" := "No.";
                    ObjSelectedSavingsProducts.Names := Name;
                    ObjSelectedSavingsProducts."Default Product" := true;
                    ObjSelectedSavingsProducts.Product := ObjSavingsProduct.Code;
                    ObjSelectedSavingsProducts."Product Name" := ObjSavingsProduct.Description;
                    ObjSelectedSavingsProducts."Product Source" := ObjSavingsProduct."Activity Code";
                    ObjSelectedSavingsProducts.Insert;
                    //ObjSelectedSavingsProducts.VALIDATE(ObjSelectedSavingsProducts.Product);
                    //ObjSelectedSavingsProducts.MODIFY;
                    Message('Assignd Product %1', ObjSelectedSavingsProducts.Product);
                end;
            until ObjSavingsProduct.Next = 0;
        end

    end;
}

