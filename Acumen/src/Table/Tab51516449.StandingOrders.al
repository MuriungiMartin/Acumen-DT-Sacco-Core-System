#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516449 "Standing Orders"
{

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Standing Orders Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Source Account No."; Code[20])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                if Account.Get("Source Account No.") then begin
                    "Staff/Payroll No." := Account."Personal No.";
                    "Account Name" := Account.Name;
                    "BOSA Account No." := Account."BOSA Account No";

                end;


                ObjAccount.Reset;
                ObjAccount.SetRange(ObjAccount."No.", "Source Account No.");
                if ObjAccount.FindSet then begin
                    if ObjAccount.Status <> ObjAccount.Status::Active then begin
                        Error('The specified source account status is not active,account status is %1', ObjAccount.Status);
                    end;
                end;
            end;
        }
        field(3; "Staff/Payroll No."; Code[20])
        {
        }
        field(4; "Account Name"; Text[50])
        {
        }
        field(5; "Destination Account Type"; Option)
        {
            OptionCaption = 'Inter Savings,Other Banks,BOSA,FOSA Loan';
            OptionMembers = Internal,External,BOSA,"FOSA Loan";

            trigger OnValidate()
            begin
                if "Destination Account Type" = "destination account type"::External then begin
                    "Don't Allow Partial Deduction" := true
                end else
                    "Don't Allow Partial Deduction" := false;
            end;
        }
        field(6; "Destination Account No."; Code[50])
        {
            TableRelation = if ("Destination Account Type" = const(Internal)) Vendor."No." where("Creditor Type" = const("FOSA Account"));

            trigger OnValidate()
            begin
                if "Destination Account Type" = "destination account type"::BOSA then
                    Error('Not applicable for BOSA Standing Orders.');

                if Account.Get("Destination Account No.") then begin
                    "Destination Account Name" := Account.Name;

                end;
            end;
        }
        field(7; "Destination Account Name"; Text[50])
        {

            trigger OnValidate()
            begin
                /*IF "Destination Account Type" = "Destination Account Type"::BOSA THEN
                ERROR('Not applicable for BOSA Standing Orders.');
                */

            end;
        }
        field(8; "BOSA Account No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(9; "Effective/Start Date"; Date)
        {

            trigger OnValidate()
            begin
                "Next Run Date" := "Effective/Start Date";
            end;
        }
        field(10; "End Date"; Date)
        {
        }
        field(11; Duration; DateFormula)
        {

            trigger OnValidate()
            begin
                TestField("Effective/Start Date");
                TestField(Duration);
                "End Date" := CalcDate(Duration, "Effective/Start Date");
            end;
        }
        field(12; Frequency; DateFormula)
        {
        }
        field(13; "Don't Allow Partial Deduction"; Boolean)
        {
        }
        field(14; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(15; "Standing Order Description"; Text[50])
        {
        }
        field(16; Amount; Decimal)
        {
        }
        field(17; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(18; "Bank Code"; Code[20])
        {
            TableRelation = Banks.Code;

            trigger OnValidate()
            begin
                /*
                IF BanksList.GET("Bank Code") THEN BEGIN
                "Bank Name":=BanksList."Bank Name";
                "Branch Name":=BanksList.Branch;
                END;
                */

            end;
        }
        field(19; "Transacting Branch"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(20; "Allocated Amount"; Decimal)
        {
            CalcFormula = sum("Receipt Allocation"."Total Amount" where("Document No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; Unsuccessfull; Boolean)
        {
        }
        field(22; Balance; Decimal)
        {
        }
        field(23; Effected; Boolean)
        {
        }
        field(24; "Next Run Date"; Date)
        {
        }
        field(25; "Old STO No."; Code[20])
        {
        }
        field(26; "Uneffected STO"; Boolean)
        {
        }
        field(27; "Auto Process"; Boolean)
        {
        }
        field(28; "Date Reset"; Date)
        {
        }
        field(29; "Reset Again"; Boolean)
        {
        }
        field(30; "None Salary"; Boolean)
        {
        }
        field(31; "ID. NO."; Code[20])
        {
        }
        field(32; Invalid; Boolean)
        {
        }
        field(50000; "Company Code"; Code[30])
        {
            CalcFormula = lookup(Vendor."Employer Code" where("No." = field("Source Account No.")));
            FieldClass = FlowField;
        }
        field(50001; "Posted By"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50002; "Standing Order Type"; Option)
        {
            OptionCaption = 'Date Based,Salary,Pension';
            OptionMembers = "Date Based",Salary,Pension;
        }
        field(50003; "Is Active"; Boolean)
        {
        }
        field(50004; "No of Tolerance Days"; DateFormula)
        {
        }
        field(50005; "End of Tolerance Date"; Date)
        {
        }
        field(50006; "Next Attempt Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Source Account No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Standing Orders Nos.");
            NoSeriesMgt.InitSeries(NoSetup."Standing Orders Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;


        //IF UsersID.GET(USERID) THEN
        //"Transacting Branch":=UsersID.Branch;

        ObjGensetup.Get();
        "No of Tolerance Days" := ObjGensetup."Sto max tolerance Days";
        "Don't Allow Partial Deduction" := ObjGensetup."Dont Allow Sto Partial Ded.";
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Account: Record Vendor;
        UsersID: Record User;
        BanksList: Record Banks;
        "Bank Name": Text[30];
        ObjAccount: Record Vendor;
        ObjGensetup: Record "Sacco General Set-Up";
}

