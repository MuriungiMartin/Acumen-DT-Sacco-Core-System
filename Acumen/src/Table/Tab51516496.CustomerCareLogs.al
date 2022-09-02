#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516496 "Customer Care Logs"
{

    fields
    {
        field(1; No; Code[20])
        {

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Customer Care Log Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[20])
        {
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            begin

                if "Calling As" = "calling as"::"As Member" then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."No.", "Member No");
                    if Cust.Find('-') then begin
                        Cust.CalcFields(Cust."Outstanding Balance", Cust."Current Shares", Cust."Insurance Fund", Cust."Un-allocated Funds",
                        Cust."Shares Retained");
                        "Member Name" := Cust.Name;
                        "Payroll No" := Cust."Personal No";
                        "Loan Balance" := Cust."Outstanding Balance";
                        "Current Deposits" := Cust."Current Shares";
                        "ID No" := Cust."ID No.";
                        "Phone No" := Cust."Mobile Phone No";
                        "Passport No" := Cust."Passport No.";
                        Email := Cust."E-Mail";
                        Gender := Cust.Gender;
                        Status := Cust.Status;

                        //"Holiday Savings":=Cust."Insurance Fund";
                        "Share Capital" := Cust."Shares Retained";
                        Source := Cust."Customer Posting Group";
                    end;
                end else
                    if "Calling As" = "calling as"::"As Employer" then begin
                        "Member Name" := PRD.Name;
                        "Phone No" := PRD."Phone No.";

                    end
            end;
        }
        field(3; "Member Name"; Text[60])
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
            Description = 'Pending,Received,Resolved';
            OptionCaption = ' ,Pending,Received,Resolved';
            OptionMembers = " ",Pending,Received,Resolved;
        }
        field(10; "ID No"; Code[20])
        {
        }
        field(11; "Phone No"; Text[30])
        {
        }
        field(12; "Passport No"; Text[30])
        {
        }
        field(13; Email; Text[60])
        {
        }
        field(14; Gender; Option)
        {
            Description = 'Male,Female';
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(15; "Query Code"; Code[20])
        {
            TableRelation = Customer;
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
        field(25; "Resolved User"; Code[20])
        {
        }
        field(26; "Resolved Date"; Date)
        {
        }
        field(27; "Resolved Time"; Time)
        {
        }
        field(28; "Caller Reffered To"; Code[20])
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
            end;
        }
        field(29; "Received From"; Code[20])
        {
        }
        field(30; "Calling As"; Option)
        {
            OptionCaption = 'As Member,As Employer,As Non Member,As Others';
            OptionMembers = "As Member","As Employer","As Non Member","As Others";
        }
        field(31; "Contact Mode"; Option)
        {
            OptionCaption = 'Physical,Phone Call,E-Mail,Letter';
            OptionMembers = Physical,"Phone Call","E-Mail",Letter;
        }
        field(32; "Calling For"; Option)
        {
            OptionCaption = 'Inquiry,Request,Appreciation,Complaint,Criticism,Payment,Receipt,Loan Form,Housing';
            OptionMembers = Inquiry,Request,Appreciation,Complaint,Criticism,Payment,Receipt,"Loan Form",Housing;
        }
        field(33; "Date Sent"; Date)
        {
        }
        field(34; "Time Sent"; Time)
        {
        }
        field(35; "Sent By"; Code[20])
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
            SalesSetup.TestField(SalesSetup."Customer Care Log Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Customer Care Log Nos", xRec."No. Series", 0D, No, "No. Series");
        end;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Loans: Record "Loans Register";
        GenSetUp: Record "Sacco General Set-Up";
        Cust: Record "Member Register";
        PVApp: Record "Cust. Ledger Entry";
        UserMgt: Codeunit "User Setup Management";
        PRD: Record Customer;
}

