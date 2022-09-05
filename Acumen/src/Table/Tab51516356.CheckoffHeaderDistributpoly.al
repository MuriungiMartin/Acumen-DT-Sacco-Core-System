#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516356 "CheckoffHeader-Distribut poly"
{

    fields
    {
        field(1; No; Code[20])
        {

            trigger OnValidate()
            begin

                if No <> xRec.No then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Checkoff-Proc Distributed Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "No. Series"; Code[20])
        {
        }
        field(3; Posted; Boolean)
        {
            Editable = false;
        }
        field(6; "Posted By"; Code[60])
        {
            Editable = false;
        }
        field(7; "Date Entered"; Date)
        {
        }
        field(9; "Entered By"; Text[60])
        {
        }
        field(10; Remarks; Text[150])
        {
        }
        field(19; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(20; "Time Entered"; Time)
        {
        }
        field(21; "Posting date"; Date)
        {
        }
        field(22; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(23; "Account No"; Code[30])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset";

            trigger OnValidate()
            begin
                if "Account Type" = "account type"::Customer then begin
                    CustDeb.Reset;
                    CustDeb.SetRange(CustDeb."No.", "Account No");
                    if CustDeb.Find('-') then begin
                        "Employer Name" := CustDeb.Name;
                        "Account No" := CustDeb."No.";
                    end;
                end;

                if "Account Type" = "account type"::"G/L Account" then begin
                    "GL Account".Reset;
                    "GL Account".SetRange("GL Account"."No.", "Account No");
                    if "GL Account".Find('-') then begin
                        "Account Name" := "GL Account".Name;
                    end;
                end;

                if "Account Type" = "account type"::"Bank Account" then begin
                    BANKACC.Reset;
                    BANKACC.SetRange(BANKACC."No.", "Account No");
                    if BANKACC.Find('-') then begin
                        "Account Name" := BANKACC.Name;

                    end;
                end;
            end;
        }
        field(24; "Document No"; Code[20])
        {
        }
        field(25; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                /*
              IF Amount<>"Scheduled Amount" THEN
              ERROR('The Amount must be equal to the Scheduled Amount');
                  */

            end;
        }
        field(26; "Scheduled Amount"; Decimal)
        {
            CalcFormula = sum("Checkoff Lines-Distributed".Amount where("Receipt Header No" = field(No)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Total Count"; Integer)
        {
            CalcFormula = count("CheckoffLinesDistributed poly" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;
        }
        field(28; "Account Name"; Code[50])
        {
        }
        field(29; "Employer Code"; Code[30])
        {
            TableRelation = "Sacco Employers".Code;
        }
        field(30; "Un Allocated amount-surplus"; Decimal)
        {
        }
        field(31; "Employer Name"; Text[100])
        {
        }
        field(32; "Loan CutOff Date"; Date)
        {
        }
        field(33; "Interest Amount"; Decimal)
        {
            FieldClass = Normal;
        }
        field(34; "Employer No.(Old)"; Code[20])
        {
            TableRelation = if ("Account Type" = const(Customer)) Customer."Our Account No.";
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

    trigger OnDelete()
    begin
        if Posted = true then
            Error('You cannot delete a Posted Check Off');
    end;

    trigger OnInsert()
    begin

        if No = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Checkoff-Proc Distributed Nos");
            NoSeriesMgt.InitSeries(NoSetup."Checkoff-Proc Distributed Nos", xRec."No. Series", 0D, No, "No. Series");
        end;

        "Date Entered" := Today;
        "Time Entered" := Time;
        "Entered By" := UpperCase(UserId);
    end;

    trigger OnModify()
    begin

        if Posted = true then
            Error('You cannot modify a Posted Check Off');
    end;

    trigger OnRename()
    begin
        if Posted = true then
            Error('You cannot rename a Posted Check Off');
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        cust: Record Customer;
        "GL Account": Record "G/L Account";
        BANKACC: Record "Bank Account";
        CustDeb: Record Customer;
        CHECKOFFREG: Record "CheckoffLinesDistributed poly";
}

