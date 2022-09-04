#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516248 "Receipts.Processing Checkoff"
{

    fields
    {
        field(1;No;Code[20])
        {

            trigger OnValidate()
            begin
                if No = '' then begin
                NoSetup.Get();
                NoSetup.TestField(NoSetup."Checkoff Proc Block Nos");
                NoSeriesMgt.InitSeries(NoSetup."Checkoff Proc Block Nos",xRec."No. Series",0D,No,"No. Series");
                end;
            end;
        }
        field(2;"No. Series";Code[20])
        {
        }
        field(3;Posted;Boolean)
        {
            Editable = true;
        }
        field(6;"Posted By";Code[60])
        {
            Editable = false;
        }
        field(7;"Date Entered";Date)
        {
        }
        field(9;"Entered By";Text[60])
        {
        }
        field(10;Remarks;Text[150])
        {
        }
        field(19;"Date Filter";Date)
        {
            FieldClass = FlowFilter;
        }
        field(20;"Time Entered";Time)
        {
        }
        field(21;"Posting date";Date)
        {
        }
        field(22;"Account Type";Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(23;"Account No";Code[30])
        {
            TableRelation = if ("Account Type"=const("G/L Account")) "G/L Account"
                            else if ("Account Type"=const(Customer)) Customer
                            else if ("Account Type"=const(Vendor)) Vendor
                            else if ("Account Type"=const("Bank Account")) "Bank Account"
                            else if ("Account Type"=const("Fixed Asset")) "Fixed Asset";

            trigger OnValidate()
            begin
                if "Account Type"="account type"::Customer then begin
                cust.Reset;
                cust.SetRange(cust."No.","Account No");
                if cust.Find('-') then begin
                "Employer Name":=cust.Name;

                end;
                end;

                if "Account Type"="account type"::"G/L Account" then begin
                "GL Account".Reset;
                "GL Account".SetRange("GL Account"."No.","Account No");
                if "GL Account".Find('-') then begin
                "Account Name":="GL Account".Name;
                end;
                end;

                if "Account Type"="account type"::"Bank Account" then begin
                BANKACC.Reset;
                BANKACC.SetRange(BANKACC."No.","Account No");
                if BANKACC.Find('-') then begin
                "Account Name":=BANKACC.Name;

                end;
                end;
            end;
        }
        field(24;"Document No";Code[20])
        {
        }
        field(25;Amount;Decimal)
        {

            trigger OnValidate()
            begin
                 /*
                IF Amount<>"Scheduled Amount" THEN
                ERROR('The Amount must be equal to the Scheduled Amount');
                    */

            end;
        }
        field(26;"Scheduled Amount";Decimal)
        {
            Editable = true;
            FieldClass = FlowField;
        }
        field(27;"Total Count";Integer)
        {
            CalcFormula = sum("ReceiptsProcessing. Checkoff".Amount where ("Receipt Header No"=field(No)));
            FieldClass = FlowField;
        }
        field(28;"Account Name";Code[50])
        {
        }
        field(29;"Employer Code";Code[30])
        {
            TableRelation = "Sacco Employers".Code;
        }
        field(30;"Un Allocated amount-surplus";Decimal)
        {
        }
        field(31;"Employer Name";Text[100])
        {
        }
        field(32;"Loan CutOff Date";Date)
        {
        }
    }

    keys
    {
        key(Key1;No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*IF Posted = TRUE THEN
        ERROR('You cannot delete a Posted Check Off');
        */

    end;

    trigger OnInsert()
    begin

        if No = '' then begin
        NoSetup.Get();
        NoSetup.TestField(NoSetup."Checkoff Proc Block Nos");
        NoSeriesMgt.InitSeries(NoSetup."Checkoff Proc Block Nos",xRec."No. Series",0D,No,"No. Series");
        end;

        "Date Entered":=Today;
        "Time Entered":=Time;
        "Entered By":=UpperCase(UserId);
    end;

    trigger OnModify()
    begin
        /*
        IF Posted = TRUE THEN
        ERROR('You cannot modify a Posted Check Off');
         */

    end;

    trigger OnRename()
    begin
        /*IF Posted = TRUE THEN
        ERROR('You cannot rename a Posted Check Off');
        */

    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        cust: Record "Member Register";
        "GL Account": Record "G/L Account";
        BANKACC: Record "Bank Account";
}

