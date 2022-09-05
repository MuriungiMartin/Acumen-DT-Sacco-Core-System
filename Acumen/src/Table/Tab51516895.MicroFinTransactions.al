#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516895 "Micro_Fin_Transactions"
{

    fields
    {
        field(1; "No."; Code[10])
        {
            Editable = true;
        }
        field(2; "Transaction Date"; Date)
        {
            Editable = true;
        }
        field(3; "Transaction Time"; Time)
        {
            Editable = true;
        }
        field(4; "Micro Saver Control Account"; Code[20])
        {
            Editable = true;
            TableRelation = Vendor."No.";
        }
        field(5; "Group Code"; Code[20])
        {
            Editable = true;
            TableRelation = Customer."No." where("Group Account" = filter(true));

            trigger OnValidate()
            begin
                if Posted <> true then begin
                    MicroSubform.Reset;
                    MicroSubform.SetRange(MicroSubform."No.", "No.");
                    if MicroSubform.Find('-') then
                        MicroSubform.DeleteAll;

                    //***************
                    Member.Reset;
                    Member.SetRange(Member."Group Account No", "Group Code");
                    if Member.Find('-') then begin
                        "Account Name" := Member."Group Account Name";
                        "Group Name" := Member."Group Account Name";
                        "Micro Officer" := Member."Loan Officer Name";
                        "Branch Code" := Member."Global Dimension 2 Code";


                    end;
                    GroupMembers.Reset;
                    GroupMembers.SetRange(GroupMembers."Group Account No", "Group Code");
                    if GroupMembers.Find('-') then begin
                        //GroupMembers.CALCFIELDS(GroupMembers."Balance (LCY)");
                        repeat
                            GroupMembers.CalcFields(GroupMembers."Balance (LCY)");
                            MicroSubform.Init;
                            MicroSubform."No." := "No.";
                            MicroSubform."Account Number" := GroupMembers."No.";
                            MicroSubform."Account Name" := GroupMembers.Name;
                            MicroSubform."Group Code" := "Group Code";
                            MicroSubform.Savings := GroupMembers."Balance (LCY)";

                            LoanApplic.Reset;
                            LoanApplic.SetRange(LoanApplic.Source, LoanApplic.Source::MICRO);
                            LoanApplic.SetRange(LoanApplic."Client Code", GroupMembers."No.");
                            LoanApplic.SetFilter(LoanApplic."Outstanding Balance", '>0');
                            if LoanApplic.Find('-') then begin
                                LoanApplic.CalcFields(LoanApplic."Outstanding Balance", LoanApplic."Interest Due", LoanApplic."Oustanding Interest");
                                ///LoanApplic.CALCFIELDS(LoanApplic.Penalty);
                                if LoanApplic."Outstanding Balance" > 0 then begin
                                    MicroSubform."Expected Principle Amount" := LoanApplic.Repayment;
                                    MicroSubform."Expected Interest" := LoanApplic."Interest Due";
                                    //MicroSubform."Expected Interest":=LoanApplic.Lint;
                                    MicroSubform."Outstanding Balance" := LoanApplic."Outstanding Balance";
                                    MicroSubform."Branch Code" := "Branch Code";
                                    ///IF LoanApplic.Penalty>0 THEN
                                    ///MicroSubform."Expected Penalty Charge":=LoanApplic.Penalty;
                                    MicroSubform."Loan No." := LoanApplic."Loan  No.";
                                end;
                            end;
                            MicroSubform."Branch Code" := "Branch Code";

                            MicroSubform.Insert;
                        until GroupMembers.Next = 0;
                    end;
                end;
            end;
        }
        field(6; Amount; Decimal)
        {
            Editable = true;
        }
        field(7; Balance; Decimal)
        {
        }
        field(8; Posted; Boolean)
        {
        }
        field(9; "Posted By"; Code[80])
        {
            Editable = false;
            TableRelation = "User Setup";
        }
        field(10; "Total Repayment"; Decimal)
        {
            Editable = true;
            FieldClass = Normal;
        }
        field(11; "Account No"; Code[20])
        {
            TableRelation = "Bank Account"."No." where("Account Type" = const(Cashier));

            trigger OnValidate()
            begin
                if "Account Type" = "account type"::"Bank Account" then begin
                    BANKACC.Reset;
                    BANKACC.SetRange(BANKACC."No.", "Account No");
                    BANKACC.SetRange(BANKACC.CashierID, UserId);
                    if BANKACC.Find('-') then begin
                        "Account Name" := BANKACC.Name;
                    end else
                        Error('You need a till for this transaction')
                end else
                    if "Account Type" = "account type"::Vendor then begin
                        VEND.Reset;
                        VEND.SetRange(VEND."No.", "Account No");
                        if VEND.Find('-') then begin
                            "Account Name" := VEND.Name;
                        end;
                    end;
                //cyrus
            end;
        }
        field(12; "No. Series"; Code[10])
        {
        }
        field(13; "Savings/Loan Rep"; Option)
        {
            OptionMembers = Savings,"Loan Repayment";
        }
        field(14; "Post to InterBranch Account"; Boolean)
        {

            trigger OnValidate()
            begin
                if "Post to InterBranch Account" = true then begin
                    if Confirm('Are you sure you want to post this to inter branch account?', false) = false then
                        Error('The teller account has to be specified first')
                    else
                        "Account No" := '';
                end;
            end;
        }
        field(15; "Branch Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(16; "Total Savings"; Decimal)
        {
            CalcFormula = sum(Micro_Fin_Schedule.Savings where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(17; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";

            trigger OnValidate()
            begin
                /*
                IF ("Account Type"<>"Account Type"::"Bank Account") OR ("Account Type"<>"Account Type"::Vendor)  THEN
                ERROR('Option not activated');
                                      */

            end;
        }
        field(18; "Account Name"; Code[50])
        {
            Editable = false;
        }
        field(19; "Total Penalty"; Decimal)
        {
            CalcFormula = sum(Micro_Fin_Schedule."Penalty Amount" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(20; "Total Principle"; Decimal)
        {
            CalcFormula = sum(Micro_Fin_Schedule."Principle Amount" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(21; "Total Interest"; Decimal)
        {
            CalcFormula = sum(Micro_Fin_Schedule."Interest Amount" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(22; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(23; "Total Amount"; Decimal)
        {
            CalcFormula = sum(Micro_Fin_Schedule."Amount Received" where("No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Captured By"; Code[100])
        {
            Editable = false;
            TableRelation = "User Setup";
        }
        field(25; "Activity Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(26; "Payment Description"; Text[80])
        {
        }
        field(27; "Group Name"; Code[150])
        {
        }
        field(28; "Group Meeting Day"; Date)
        {
        }
        field(29; "Micro Officer"; Code[100])
        {
            TableRelation = "Loan Officers Details";
        }
        field(30; "Total Excess"; Decimal)
        {
            CalcFormula = sum(Micro_Fin_Schedule."Excess Amount" where("No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Posted then
            Error('Cannot delete a posted transaction');
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Micro Finance Transactions");
            noseriesmgt.InitSeries(SalesSetup."Micro Finance Transactions", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        /*OfficeGroup.RESET;
        OfficeGroup.SETRANGE(OfficeGroup."User ID",USERID);
        IF OfficeGroup.FIND('-') THEN BEGIN
        OfficeGroup.TESTFIELD(OfficeGroup."Shortcut Dimension 2 Code");
        "Branch Code":=OfficeGroup."Shortcut Dimension 2 Code";
        
        END;
        */

        "Activity Code" := 'MICRO';
        "Transaction Date" := Today;
        "Transaction Time" := Time;
        "Posted By" := UserId;

    end;

    trigger OnModify()
    begin
        if Posted then
            Error('Cannot modify a posted transaction');
    end;

    var
        GroupMembers: Record Customer;
        LoanApplic: Record "Loans Register";
        noseriesmgt: Codeunit NoSeriesManagement;
        SalesSetup: Record "Sacco No. Series";
        MicroSubform: Record Micro_Fin_Schedule;
        BANKACC: Record "Bank Account";
        VEND: Record Vendor;
        OfficeGroup: Record "User Setup";
        Member: Record Customer;
}

