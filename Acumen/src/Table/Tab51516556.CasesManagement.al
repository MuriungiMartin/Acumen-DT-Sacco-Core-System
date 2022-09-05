#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516556 "Cases Management"
{
    // LookupPageID = UnknownPage53954;

    fields
    {
        field(1; "Case Number"; Code[20])
        {
        }
        field(3; "Date of Complaint"; Date)
        {
        }
        field(4; "Type of cases"; Code[30])
        {
            NotBlank = true;
            TableRelation = "CRM Case Types".Code;
        }
        field(5; "Recommended Action"; Code[50])
        {
        }
        field(6; "Case Description"; Text[250])
        {
        }
        field(7; Accuser; Code[50])
        {
        }
        field(8; "Resource#1"; Code[50])
        {
            TableRelation = User."User Name";

            trigger OnLookup()
            var
                UserMgt: Codeunit UserManagementCUExt;
            begin
                UserMgt.LookupUser("Resource#1");
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit UserManagementCUExt;
                User: Record User;
            begin
                if casem.Get("Resource#1") then begin
                    "Resource Assigned" := casem."Resource#1";
                    Message("Resource Assigned");
                end;
                UserMgt.ValidateUserName(User, User, "Resource#1");
            end;
        }
        field(9; "Resource #2"; Code[50])
        {
            TableRelation = User."User Name";

            trigger OnLookup()
            var
                UserMgt: Codeunit UserManagementCUExt;
            begin
                UserMgt.LookupUser("Resource #2");
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit UserManagementCUExt;
                User: Record User;
            begin
                if casen.Get("Resource #2") then begin
                    "Resource Assigned" := "Resource #2";
                    Message("Resource Assigned");
                end;
                UserMgt.ValidateUserName(User, User, "Resource #2");
            end;
        }
        field(10; "Action Taken"; Code[100])
        {
        }
        field(11; "Date To Settle Case"; Date)
        {
        }
        field(12; "Document Link"; Text[200])
        {
        }
        field(13; "Solution Remarks"; Code[50])
        {
        }
        field(14; Comments; Text[250])
        {
        }
        field(15; "Case Solved"; Boolean)
        {
        }
        field(16; "Body Handling The Complaint"; Code[20])
        {
        }
        field(17; Recomendations; Code[20])
        {
        }
        field(18; Implications; Integer)
        {
        }
        field(19; "Support Documents"; Option)
        {
            OptionMembers = Yes,No;
        }
        field(20; "Policy Guidlines In Effect"; Code[20])
        {
        }
        field(21; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Escalated,Resolved,Recalled';
            OptionMembers = Open,Escalated,Resolved,Recalled;
        }
        field(22; "Mode of Lodging the Complaint"; Text[30])
        {
        }
        field(23; "No. Series"; Code[20])
        {
        }
        field(24; "Resource Assigned"; Code[30])
        {
            TableRelation = User."User Name";

            trigger OnLookup()
            var
                UserMgt: Codeunit UserManagementCUExt;
            begin
                UserMgt.LookupUser("Resource Assigned");
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit UserManagementCUExt;
                User: Record User;
            begin
                UserMgt.ValidateUserName(User, User, "Resource Assigned");
            end;
        }
        field(25; Selected; Boolean)
        {
        }
        field(26; "Closed By"; Code[20])
        {
        }
        field(28; "Caller Reffered To"; Code[50])
        {
            TableRelation = User."User Name";

            trigger OnLookup()
            var
                UserMgt: Codeunit UserManagementCUExt;
            begin
                UserMgt.LookupUser("Caller Reffered To");
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit UserManagementCUExt;
                User: Record User;
            begin
                UserMgt.ValidateUserName(User, User, "Caller Reffered To");

                ObjUsers.Reset;
                ObjUsers.SetRange(ObjUsers."User Name", UserId);
                if ObjUsers.FindSet then begin
                    "Escalated User Email" := ObjUsers."Contact Email";
                end;
            end;
        }
        field(29; "Received From"; Code[50])
        {
        }
        field(33; "Date Sent"; Date)
        {
        }
        field(34; "Time Sent"; Time)
        {
        }
        field(35; "Sent By"; Code[50])
        {
            Description = '//surestep crm';
        }
        field(36; SLA; Option)
        {
            OptionCaption = ' ,24HRS,48HRS,72HRS';
            OptionMembers = " ","24HRS","48HRS","72HRS";

            trigger OnValidate()
            begin
                if SLA = Sla::"24HRS" then
                    CPeriod := 1;
                if SLA = Sla::"48HRS" then
                    CPeriod := 2;
                if SLA = Sla::"72HRS" then
                    CPeriod := 3;
                //*** validate
                currYear := Date2dmy(Today, 3);
                StartDate := 0D;
                EndDate := 0D;
                Month := Date2dmy("Case Received  Date", 2);
                DAY := Date2dmy("Case Received  Date", 1);


                StartDate := Dmy2date(1, Month, currYear); // StartDate will be the date of the first day of the month

                if Month = 12 then begin
                    Month := 0;
                    currYear := currYear + 1;

                end;
                EndDate := Dmy2date(1, Month, currYear) - 1;
                "Date To Settle Case" := CalcDate(Format(CPeriod) + 'D', "Case Received  Date");
            end;
        }
        field(37; "Case Received  Date"; Date)
        {
            Editable = false;
        }
        field(3963; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(3964; "Member No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(3965; "FOSA Account."; Code[50])
        {
            TableRelation = Vendor."No.";
        }
        field(3966; "Account Name."; Text[50])
        {
        }
        field(3967; "Loan No"; Code[20])
        {
            TableRelation = "Loans Register";
        }
        field(3968; "Receive User"; Code[50])
        {
            TableRelation = User."User Name";
        }
        field(3969; "Receive date"; Date)
        {
        }
        field(3970; "Receive Time"; Time)
        {
        }
        field(3971; "Resolved User"; Code[50])
        {
            TableRelation = User."User Name";
        }
        field(3972; "Resolved Date"; Date)
        {
        }
        field(3973; "Resolved Time"; Time)
        {
        }
        field(68030; "Company No"; Code[50])
        {
            Description = '//surestep crm';
        }
        field(68031; "Company Name"; Text[100])
        {
            Description = '//surestep crm';
        }
        field(68043; "Company Address"; Code[50])
        {
        }
        field(68044; "Company postal code"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(68045; "Company Telephone"; Code[20])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(68046; "Company Email"; Text[30])
        {
            ExtendedDatatype = EMail;
        }
        field(68047; "Company website"; Text[30])
        {
            ExtendedDatatype = URL;
        }
        field(68121; "Employment Info"; Option)
        {
            OptionCaption = ' ,Employed,Self-Employed,Contracting,Others';
            OptionMembers = " ",Employed,"Self-Employed",Contracting,Others;
        }
        field(68123; "Others Details"; Text[30])
        {
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
        field(69174; "Employer Address"; Code[20])
        {
        }
        field(69175; "Date of Employment"; Date)
        {
        }
        field(69176; "Position Held"; Code[20])
        {
        }
        field(69177; "Expected Monthly Income"; Decimal)
        {
        }
        field(69178; "Nature Of Business"; Option)
        {
            OptionCaption = 'Sole Proprietorship, Partnership';
            OptionMembers = "Sole Proprietorship"," Partnership";
        }
        field(69179; Industry; Code[20])
        {
        }
        field(69180; "Business Name"; Code[20])
        {
        }
        field(69181; "Physical Business Location"; Code[20])
        {
        }
        field(69182; "Year of Commence"; Date)
        {
        }
        field(69183; "Employer Code"; Code[20])
        {
            TableRelation = "Sacco Employers".Code;

            trigger OnValidate()
            begin
                if ObjEmployers.Get("Employer Code") then begin
                    "Employer Name" := ObjEmployers.Description;
                end;
            end;
        }
        field(69184; "Employer Name"; Code[50])
        {
        }
        field(69185; "Terms of Employment"; Option)
        {
            OptionMembers = " ",Permanent,Contract,Casual;
        }
        field(69186; Occupation; Text[50])
        {
        }
        field(69187; Department; Code[20])
        {
        }
        field(69188; "Referee Member No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Referee Member No") then begin
                    "Referee Name" := Cust.Name;
                    "Referee Mobile Phone No" := Cust."Mobile Phone No";
                    "Referee ID No" := Cust."ID No.";
                end;
            end;
        }
        field(69189; "Referee Name"; Code[40])
        {
            Editable = false;
        }
        field(69190; "Referee ID No"; Code[20])
        {
            Editable = false;
        }
        field(69191; "Referee Mobile Phone No"; Code[20])
        {
            Editable = false;
        }
        field(69192; "Lead Status"; Option)
        {
            OptionCaption = 'Open,Converted to Opportunity,Closed';
            OptionMembers = Open,"Converted to Opportunity",Closed;
        }
        field(69193; "Captured By"; Code[20])
        {
        }
        field(69194; "Captured On"; Date)
        {
        }
        field(69195; "Lead Region"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(2));
        }
        field(69196; "Physical Meeting Location"; Text[40])
        {
        }
        field(69198; "Date of Escalation"; Date)
        {
        }
        field(69199; "Time of Escalation"; Time)
        {
        }
        field(69200; "Date Resolved"; Date)
        {
        }
        field(69201; "Time Resolved"; Time)
        {
        }
        field(69202; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                /*
                IF "Calling As"="Calling As"::"As Member" THEN BEGIN
                  Cust.RESET;
                  Cust.SETRANGE(Cust."No.","Member No");
                    IF Cust.FIND('-') THEN BEGIN
                      Cust.CALCFIELDS(Cust."Outstanding Balance",Cust."Current Shares",Cust."Insurance Fund",Cust."Un-allocated Funds",
                      Cust."Shares Retained");
                      "Member Name":=Cust.Name;
                      "Payroll No":=Cust."Personal No";
                      "Current Deposits":= Cust."Current Shares";
                      "ID No":= Cust."ID No.";
                      "Phone No":=Cust."Mobile Phone No";
                      "Passport No":= Cust."Passport No.";
                      "Fosa account":=Cust."FOSA Account";
                      Email:=Cust."E-Mail";
                      Gender:=Cust.Gender;
                      Status:=Cust.Status;
                      Address:=Cust.Address;
                      City:=Cust.City;
                      "Company No":=Cust."Employer Code";
                      "Company Name":=Cust."Employer Name";
                      "Share Capital":=Cust."Shares Retained";
                       Source:=Cust."Customer Posting Group";
                      "Employment Info":=Cust."Employment Info";
                      "Employer Code":=Cust."Employer Code";
                      "Employer Name":=Cust."Employer Name";
                      "Nature Of Business":=Cust."Nature Of Business";
                      "Business Name":=Cust."Business Name";
                      "Physical Business Location":=Cust."Physical Business Location";
                      "Terms of Employment":=Cust."Terms Of Employment";
                      "Referee Member No":=Cust."Referee Member No";
                      "Referee Name":=Cust."Referee Name";
                      "Referee Mobile Phone No":=Cust."Referee Mobile Phone No";
                      "Referee ID No":=Cust."Referee ID No";
                      END;
                        END ELSE
                          IF "Calling As"="Calling As"::"As Member" THEN BEGIN
                          "Member Name":=PRD.Name;
                          "Phone No":=PRD."Phone No.";
                END
                */

            end;
        }
        field(69203; "Member Name"; Code[60])
        {
        }
        field(69204; "Payroll No"; Code[20])
        {
        }
        field(69205; "Loan Balance"; Decimal)
        {
        }
        field(69206; "Current Deposits"; Decimal)
        {
        }
        field(69207; "Holiday Savings"; Decimal)
        {
        }
        field(69208; Description; Text[250])
        {
        }
        field(69209; "Share Capital"; Decimal)
        {
        }
        field(69210; "ID No"; Code[20])
        {
        }
        field(69211; Gender; Option)
        {
            Description = 'Male,Female';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(69212; "Escalated User Email"; Text[30])
        {
        }
        field(69213; "Case Resolution Details"; Text[250])
        {
        }
        field(69214; "Captured By Email"; Text[50])
        {
        }
        field(69215; "Initiated Enquiry No"; Code[30])
        {
        }
        field(69216; "Recall Reason"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Resource Assigned", "Case Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Case Number" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Cases nos");
            NoSeriesMgt.InitSeries(HRSetup."Cases nos", xRec."No. Series", 0D, "Case Number", "No. Series");
        end;
    end;

    trigger OnModify()
    begin
        /* IF Status=Status::Assigned THEN
         ERROR('You cannot modify a closed case');
         */

    end;

    var
        HRSetup: Record "Crm General Setup.";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        casem: Record "Cases Management";
        casen: Record "Cases Management";
        CPeriod: Integer;
        currYear: Integer;
        StartDate: Date;
        EndDate: Date;
        Month: Integer;
        DAY: Integer;
        ObjEmployers: Record "Sacco Employers";
        Cust: Record Customer;
        ObjUsers: Record User;
}

