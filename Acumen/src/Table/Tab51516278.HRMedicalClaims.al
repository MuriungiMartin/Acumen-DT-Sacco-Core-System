#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516278 "HR Medical Claims"
{

    fields
    {
        field(1; "Member No"; Code[20])
        {
            Editable = true;
            TableRelation = "HR Employees";

            trigger OnValidate()
            begin
                BankAcc.Reset;
                BankAcc.SetRange(BankAcc."No.", "Member No");
                if BankAcc.FindFirst then begin
                    "Patient Name" := BankAcc."First Name";
                end;
            end;
        }
        field(2; "Claim Type"; Option)
        {
            OptionMembers = Inpatient,Outpatient;
        }
        field(3; "Claim Date"; Date)
        {
            Editable = false;
        }
        field(4; "Patient Name"; Text[100])
        {
            Editable = false;
        }
        field(5; "Document Ref"; Text[50])
        {
        }
        field(6; "Date of Service"; Date)
        {

            trigger OnValidate()
            begin
                if "Date of Service" > "Claim Date" then
                    Error('Visit Date must be before or on the claim Date');
            end;
        }
        field(7; "Attended By"; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(8; "Amount Charged"; Decimal)
        {
        }
        field(9; Comments; Text[250])
        {
        }
        field(10; "Claim No"; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin

                if "Claim No" <> xRec."Claim No" then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Medical Claims Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(11; Dependants; Code[50])
        {
            TableRelation = "HR Employee Kin"."Other Names" where("Employee Code" = field("Member No"));

            trigger OnValidate()
            begin
                MDependants.Reset;
                MDependants.SetRange(MDependants."Employee Code", Dependants);
                if MDependants.Find('-') then begin
                    "Patient Name" := MDependants.SurName + ' ' + MDependants."Other Names";
                end;
            end;
        }
        field(12; Status; Option)
        {
            Description = 'Stores the status of the record in the database';
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(3967; "No. Series"; Code[10])
        {
        }
        field(3968; "Amount Claimed"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Amount Claimed" > "Claim Limit" then
                    Error('You cannot claim More than your Limit');

                if "Amount Claimed" > "Amount Charged" then
                    Error('You cannot bclaim more than the amount charged');


                Balance := "Claim Limit" - "Amount Claimed";
            end;
        }
        field(3969; "Hospital/Medical Centre"; Text[70])
        {
        }
        field(3970; "Claim Limit"; Decimal)
        {
        }
        field(3971; "User ID"; Code[50])
        {
            Editable = false;
        }
        field(3972; Balance; Decimal)
        {
        }
        field(3973; "FOSA Account"; Code[20])
        {
            Editable = false;
        }
        field(3974; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                Bank.Reset;
                Bank.SetRange(Bank."No.", "Bank Account");
                if Bank.Find('-') then begin
                    "Bank Name" := Bank.Name;
                end;
            end;
        }
        field(3975; "Bank Name"; Text[50])
        {
            Editable = false;
        }
        field(3976; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(3977; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(3978; Posted; Boolean)
        {
            Editable = false;
        }
        field(3979; "Date Posted"; Date)
        {
        }
        field(3980; "Posted By"; Code[30])
        {
        }
        field(3981; "Time Posted"; Time)
        {
        }
    }

    keys
    {
        key(Key1; "Member No", "Claim No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Claim No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Medical Claims Nos");
            NoSeriesMgt.InitSeries(HRSetup."Medical Claims Nos", xRec."No. Series", 0D, "Claim No", "No. Series");
        end;

        /*HREmp.RESET;
        HREmp.SETRANGE(HREmp."User ID",USERID);
        
        //populate employee  details
        
        "Member No":=HREmp."No.";
           // Gender:=HREmp.Gender;
           // "Application Date":=TODAY;
            "User ID":=USERID;
           // "Job Tittle":=HREmp."Job Title";
           // HREmp.CALCFIELDS(HREmp.Picture);
            //Picture:=HREmp.Picture;*/

        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin
            "Patient Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            "Member No" := HREmp."No.";
            "Claim Limit" := HREmp."Claim Limit";
            "User ID" := UserId;
            "FOSA Account" := HREmp."Fosa Account"
        end;



        "Claim Date" := Today;

        if "Claim Limit" = 0 then
            Error('Your Claim Limit is Exhausted');

    end;

    var
        MDependants: Record "HR Employee Kin";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRSetup: Record "HR Setup";
        BankAcc: Record "HR Employees";
        HREmp: Record "HR Employees";
        HRLeaveEntries: Record "HR Leave Ledger Entries";
        intEntryNo: Integer;
        "LineNo.": Integer;
        MedGjline: Record "HR Journal Line";
        Bank: Record "Bank Account";

    local procedure CreateLeaveLedgerEntries()
    begin
        TestField("Amount Claimed");
        HRSetup.Reset;
        if HRSetup.Find('-') then begin

            MedGjline.Reset;
            MedGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
            MedGjline.SetRange("Journal Batch Name", HRSetup."Leave Batch");
            MedGjline.DeleteAll;
            //Dave
            //HRSetup.TESTFIELD(HRSetup."Leave Template");
            //HRSetup.TESTFIELD(HRSetup."Leave Batch");

            HREmp.Get("Member No");
            //HREmp.TESTFIELD(HREmp."Company E-Mail");

            //POPULATE JOURNAL LINES

            "LineNo." := 10000;
            MedGjline.Init;
            MedGjline."Journal Template Name" := HRSetup."Leave Template";
            MedGjline."Journal Batch Name" := HRSetup."Leave Batch";
            MedGjline."Line No." := "LineNo.";
            //MedGjline."Leave Period":='2014';
            MedGjline."Document No." := "Claim No";
            MedGjline."Staff No." := "Member No";
            MedGjline.Validate(MedGjline."Staff No.");
            MedGjline."Posting Date" := Today;
            MedGjline."Leave Entry Type" := MedGjline."leave entry type"::Negative;
            MedGjline."Leave Approval Date" := Today;
            MedGjline.Description := 'Medical Claim Purpose';
            MedGjline."Claim Type" := "Claim Type";
            MedGjline.Amount := "Amount Claimed";
            //------------------------------------------------------------
            //HRSetup.RESET;
            //HRSetup.FIND('-');
            HRSetup.TestField(HRSetup."Leave Posting Period[FROM]");
            HRSetup.TestField(HRSetup."Leave Posting Period[TO]");
            //------------------------------------------------------------
            //MedGjline."Leave Period Start Date":=HRSetup."Leave Posting Period[FROM]";
            //MedGjline."Leave Period End Date":=HRSetup."Leave Posting Period[TO]";
            //MedGjline."No. of Days":="Approved days";
            if MedGjline.Amount <> 0 then
                MedGjline.Insert(true);

            //Post Journal
            MedGjline.Reset;
            MedGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
            MedGjline.SetRange("Journal Batch Name", HRSetup."Leave Batch");
            if MedGjline.Find('-') then begin
                //Codeunit.Run(Codeunit::Codeunit55560,MedGjline);
            end;
            // Status:=Status::;
            Modify;
        end;
    end;
}

