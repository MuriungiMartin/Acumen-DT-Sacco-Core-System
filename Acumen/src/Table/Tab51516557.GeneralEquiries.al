#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516557 "General Equiries."
{

    fields
    {
        field(1; No; Code[20])
        {

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Crm logs Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[20])
        {
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            begin


                ObjCust.Reset;
                ObjCust.SetRange(ObjCust."No.", "Member No");
                if ObjCust.Find('-') then begin
                    ObjCust.CalcFields(ObjCust."Outstanding Balance", ObjCust."Current Shares", ObjCust."Insurance Fund", ObjCust."Un-allocated Funds",
                    ObjCust."Shares Retained");
                    "Member Name" := ObjCust.Name;
                    "Payroll No" := ObjCust."Personal No";
                    "Current Deposits" := ObjCust."Current Shares";
                    "Loan Balance" := ObjCust."Outstanding Balance";
                    "ID No" := ObjCust."ID No.";
                    "Phone No" := ObjCust."Mobile Phone No";
                    "Passport No" := ObjCust."Passport No.";
                    "Fosa account" := ObjCust."FOSA Account";
                    Email := ObjCust."E-Mail";
                    Gender := ObjCust.Gender;
                    Status := ObjCust.Status;
                    Address := ObjCust.Address;
                    City := ObjCust.City;
                    "Company No" := ObjCust."Employer Code";
                    "Company Name" := ObjCust."Employer Name";
                    "Share Capital" := ObjCust."Shares Retained";
                    Source := ObjCust."Customer Posting Group";
                    "Employment Info" := ObjCust."Employment Info";
                    "Employer Code" := ObjCust."Employer Code";
                    "Employer Name" := ObjCust."Employer Name";
                    "Nature Of Business" := ObjCust."Nature Of Business";
                    "Business Name" := ObjCust."Business Name";
                    "Physical Business Location" := ObjCust."Physical Business Location";
                    "Terms of Employment" := ObjCust."Terms Of Employment";
                    "Date of Employment" := ObjCust."Date of Employment";
                    "Nature Of Business" := ObjCust."Nature Of Business";
                    "Expected Monthly Income" := ObjCust."Expected Monthly Income";
                    Industry := ObjCust.Industry;
                    "Referee Member No" := ObjCust."Referee Member No";
                    "Referee Name" := ObjCust."Referee Name";
                    "Referee Mobile Phone No" := ObjCust."Referee Mobile Phone No";
                    "Referee ID No" := ObjCust."Referee ID No";
                end;

            end;
        }
        field(3; "Member Name"; Code[60])
        {
        }
        field(4; "Payroll No"; Code[20])
        {
        }
        field(5; "Loan Balance"; Decimal)
        {
        }
        field(6; "Current Deposits"; Decimal)
        {
        }
        field(7; "Holiday Savings"; Decimal)
        {
        }
        field(8; Description; Text[250])
        {
        }
        field(9; Status; Option)
        {
            Description = ' ,New,Pending,Resolved';
            OptionCaption = 'New,Pending,Resolved';
            OptionMembers = New,Pending,Resolved;
        }
        field(10; "ID No"; Code[20])
        {
        }
        field(11; "Phone No"; Code[30])
        {
        }
        field(12; "Passport No"; Code[30])
        {
        }
        field(13; Email; Text[60])
        {
        }
        field(14; Gender; Option)
        {
            Description = 'Male,Female';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(15; "Query Code"; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if "Calling As" = "calling as"::"As Employer" then begin
                    PRD.Reset;
                    PRD.SetRange(PRD."No.", "Query Code");
                    if PRD.Find('-') then begin
                        "Company No" := PRD."No.";
                        "Company Name" := PRD.Name;
                        "Company Address" := PRD.Address;
                        "Company Email" := PRD."E-Mail";
                        "Company postal code" := PRD."Post Code";
                        "Company Telephone" := PRD."Phone No.";
                    end;
                end;
            end;
        }
        field(16; "Share Capital"; Decimal)
        {
        }
        field(17; Source; Code[20])
        {
            Description = 'BOSA,FOSA';
        }
        field(18; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(19; "Application User"; Code[20])
        {
        }
        field(20; "Application Date"; Date)
        {
        }
        field(21; "Application Time"; Time)
        {
        }
        field(22; "Receive User"; Code[20])
        {
        }
        field(23; "Receive date"; Date)
        {
        }
        field(24; "Receive Time"; Time)
        {
        }
        field(25; "Resolved User"; Code[50])
        {
        }
        field(26; "Resolved Date"; Date)
        {
        }
        field(27; "Resolved Time"; Time)
        {
        }
        field(28; "Caller Reffered To"; Code[50])
        {
            TableRelation = User."User Name";

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                UserMgt.LookupUserID("Caller Reffered To");
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit "User Management";
            begin
                UserMgt.ValidateUserID("Caller Reffered To");

                ObjUsers.Reset;
                ObjUsers.SetRange(ObjUsers."User Name", UserId);
                if ObjUsers.Find('-') then begin
                    "Escalated User Email" := ObjUsers."Contact Email";
                end;
            end;
        }
        field(29; "Received From"; Code[20])
        {
        }
        field(30; "Calling As"; Option)
        {
            OptionCaption = ' ,As Member,As Employer,As Non Member,As Others';
            OptionMembers = " ","As Member","As Employer","As Non Member","As Others";
        }
        field(31; "Contact Mode"; Option)
        {
            OptionCaption = ' ,Physical,Phone Call,E-Mail,Letter,Facebook,Tweeter,Instagram,Website';
            OptionMembers = " ",Physical,"Phone Call","E-Mail",Letter,Facebook,Tweeter,Instagram,Website;
        }
        field(32; "Calling For"; Option)
        {
            OptionCaption = ' ,Enquiry,Request,Appreciation,Complaint,Criticism,Payment,Receipt,Loan Form,Housing';
            OptionMembers = " ",Enquiry,Request,Appreciation,Complaint,Criticism,Payment,Receipt,"Loan Form",Housing;
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
        field(36; "Employer Cases types"; Code[20])
        {
            TableRelation = "CRM Case Types".Code;
        }
        field(68027; "ID No."; Code[50])
        {
            Description = '//surestep crm';

            trigger OnValidate()
            begin
                /*IF "ID No."<>'' THEN BEGIN
                Cust.RESET;
                Cust.SETRANGE(Cust."ID No.","ID No.");
                Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                IF Cust.FIND('-') THEN BEGIN
                IF Cust."No." <> "No." THEN
                   ERROR('ID No. already exists');
                END;
                END;
                
                
                
                Vend2.RESET;
                Vend2.SETRANGE(Vend2."Creditor Type",Vend2."Creditor Type"::Account);
                Vend2.SETRANGE(Vend2."Staff No","Payroll/Staff No");
                IF Vend2.FIND('-') THEN BEGIN
                REPEAT
                Vend2."ID No.":="ID No.";
                Vend2.MODIFY;
                UNTIL Vend2.NEXT = 0;
                END;
                    */

            end;
        }
        field(68028; Address; Code[50])
        {
            Description = '//surestep crm';
        }
        field(68029; City; Code[50])
        {
            Description = '//surestep crm';
        }
        field(68030; "Company No"; Code[50])
        {
            Description = '//surestep crm';
        }
        field(68031; "Company Name"; Code[50])
        {
            Description = '//surestep crm';
        }
        field(68032; "First Name"; Code[30])
        {
            Description = '//surestep crm';
        }
        field(68033; "Middle Name"; Code[30])
        {
            Description = '//surestep crm';
        }
        field(68034; "Last Name"; Code[30])
        {
            Description = '//surestep crm';
        }
        field(68035; "Country/Region Code"; Code[30])
        {
            Description = '//surestep crm';
        }
        field(68036; "Salesperson Code"; Code[30])
        {
            Description = '//surestep crm';
        }
        field(68037; "User comment"; Text[250])
        {
            Description = '//surestep crm';
        }
        field(68038; "Fosa account"; Code[30])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No"));
        }
        field(68039; "Loan No"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Member No"));

            trigger OnValidate()
            begin
                if Loans.Get("Loan No") then begin
                    Loans.CalcFields(Loans."Outstanding Balance");
                    "Loan Balance" := Loans."Outstanding Balance";
                    Message('Loan balance is %1', "Loan Balance");
                end;
            end;
        }
        field(68040; "Type of Cases"; Code[30])
        {
            TableRelation = "CRM Case Types".Code;
        }
        field(68041; "Available Current Balance"; Decimal)
        {
        }
        field(68042; Send; Boolean)
        {
        }
        field(68043; "Company Address"; Code[50])
        {
        }
        field(68044; "Company postal code"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(68045; "Company Telephone"; Code[15])
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
            TableRelation = "Member Register"."No.";

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
        field(69202; "Escalated User Email"; Text[50])
        {
        }
        field(69203; "Case Resolution Details"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if No = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Crm logs Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Crm logs Nos", xRec."No. Series", 0D, No, "No. Series");
        end;

        "Captured By" := UserId;
        "Captured On" := Today;

        ObjUser.Reset;
        ObjUser.SetRange(ObjUser."User Name", UserId);
        if ObjUser.FindSet then begin
            "Lead Region" := ObjUser."Branch Code";
        end;
    end;

    var
        SalesSetup: Record "Crm General Setup.";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Loans: Record "Loans Register";
        GenSetUp: Record "Sacco General Set-Up";
        Cust: Record "Member Register";
        PVApp: Record "Cust. Ledger Entry";
        UserMgt: Codeunit "User Setup Management";
        PRD: Record Customer;
        ObjEmployers: Record "Sacco Employers";
        ObjUser: Record User;
        ObjCust: Record "Member Register";
        ObjUsers: Record User;
}

