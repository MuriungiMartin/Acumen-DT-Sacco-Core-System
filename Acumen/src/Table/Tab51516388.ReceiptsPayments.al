#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516388 "Receipts & Payments"
{

    fields
    {
        field(1; "Transaction No."; Code[20])
        {
        }
        field(2; "Account No."; Code[30])
        {
            NotBlank = true;
            TableRelation = if ("Account Type" = const(Member)) "Member Register"."No." where("Customer Type" = filter(Member))
            else
            if ("Account Type" = const(Debtor)) Customer."No."
            else
            if ("Account Type" = const("G/L Account")) "G/L Account"."No."
            else
            if ("Account Type" = const("FOSA Loan")) "Member Register"."No." where("Customer Type" = const(Member))
            else
            if ("Account Type" = const(Vendor)) Vendor."No." where("Creditor Type" = filter("FOSA Account"))
            else
            if ("Account Type" = const(Micro)) "Member Register"."No." where("Customer Posting Group" = filter('MICRO'));

            trigger OnValidate()
            begin
                //TESTFIELD(Source);

                if ("Account Type" = "account type"::"FOSA Loan") or
                   ("Account Type" = "account type"::Debtor) then begin
                    if Cust.Get("Account No.") then begin
                        Name := Cust.Name;

                    end;
                end;
                if ("Account Type" = "account type"::Member) or ("Account Type" = "account type"::Micro) then begin
                    if Mem.Get("Account No.") then
                        Name := Mem.Name;
                end;

                if ("Account Type" = "account type"::Vendor) then begin
                    if Vend.Get("Account No.") then
                        Name := Vend.Name;
                end;

                if ("Account Type" = "account type"::"G/L Account") then begin
                    if GLAcct.Get("Account No.") then begin
                        Name := GLAcct.Name;
                    end;
                end;
            end;
        }
        field(3; Name; Text[50])
        {
        }
        field(4; Amount; Decimal)
        {
            NotBlank = true;
        }
        field(5; "Cheque No."; Code[20])
        {

            trigger OnValidate()
            begin
                BOSARcpt.Reset;
                BOSARcpt.SetRange(BOSARcpt."Cheque No.", "Cheque No.");
                BOSARcpt.SetRange(BOSARcpt.Posted, true);
                if BOSARcpt.Find('-') then
                    Error('Cheque no already exist in a posted receipt.');

                if "Receipt Mode" = "receipt mode"::Cheque then begin
                    if StrLen("Cheque No.") <> 6 then
                        Error('Cheque No. Can not be more or less than 6 Characters');
                end;
            end;
        }
        field(6; "Cheque Date"; Date)
        {
        }
        field(7; Posted; Boolean)
        {
            Editable = true;
        }
        field(8; "Employer No."; Code[20])
        {
            Editable = true;
            TableRelation = if (Source = const(BOSA),
                                "Receipt Mode" = filter(Cheque | "Deposit Slip" | Mpesa | "Standing order" | EFT)) "Bank Account"."No." where("Account Type" = filter(" "))
            else
            if (Source = const(FOSA),
                                         "Receipt Mode" = filter(Cheque | "Deposit Slip" | Mpesa | "Standing order" | EFT)) "Bank Account"."No." where("Account Type" = filter(" "))
            else
            if (Source = const(BOSA),
                                                  "Receipt Mode" = const(Cash)) "Bank Account"."No." where("Account Type" = filter(Cashier))
            else
            if (Source = const(FOSA),
                                                           "Receipt Mode" = const(Cash)) "Bank Account"."No." where("Account Type" = filter(Cashier))
            else
            if (Source = const(BOSA),
                                                                    "Receipt Mode" = const(Mpesa)) "Bank Account"."No." where("Account Type" = filter(PayBill));
        }
        field(9; "User ID"; Code[50])
        {
            Editable = false;
        }
        field(10; "Allocated Amount"; Decimal)
        {
            CalcFormula = sum("Receipt Allocation".Amount where("Document No" = field("Transaction No."),
                                                                 "Member No" = field("Account No.")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                CalcFields("Un allocated Amount");
                Validate("Un allocated Amount");
            end;
        }
        field(11; "Transaction Date"; Date)
        {
            Editable = true;
        }
        field(12; "Transaction Time"; Time)
        {
            Editable = false;
        }
        field(13; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(14; "Account Type"; Option)
        {
            OptionCaption = 'Member,Debtor,G/L Account,FOSA Loan,Customer,Vendor,Micro';
            OptionMembers = Member,Debtor,"G/L Account","FOSA Loan",Customer,Vendor,Micro;
        }
        field(15; "Transaction Slip Type"; Option)
        {
            OptionCaption = ' ,Standing Order,Direct Debit,Direct Deposit,Cash,Cheque,M-Pesa';
            OptionMembers = " ","Standing Order","Direct Debit","Direct Deposit",Cash,Cheque,"M-Pesa";
        }
        field(16; "Bank Name"; Code[50])
        {
        }
        field(50000; Insuarance; Decimal)
        {
            FieldClass = Normal;
        }
        field(50001; "Un allocated Amount"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(50002; Source; Option)
        {
            OptionCaption = 'BOSA,FOSA,MICRO';
            OptionMembers = BOSA,FOSA,MICRO;
        }
        field(50003; "Receipt Mode"; Option)
        {
            OptionCaption = 'Cash,Cheque,Mpesa,Standing order,Deposit Slip,EFT';
            OptionMembers = Cash,Cheque,Mpesa,"Standing order","Deposit Slip",EFT;

            trigger OnValidate()
            begin
                if "Receipt Mode" = "receipt mode"::Mpesa then
                    "Employer No." := 'M-PESA PAYBILL ACCOU'
                else
                    "Employer No." := '';
            end;
        }
        field(50004; Remarks; Text[50])
        {
        }
        field(50005; "Code"; Code[20])
        {
        }
        field(50006; Type; Option)
        {
            NotBlank = true;
            OptionMembers = " ",Receipt,Payment,Imprest,Advance;
        }
        field(50007; Description; Text[50])
        {
        }
        field(50008; "Default Grouping"; Code[20])
        {
            Editable = false;
        }
        field(50009; "Transation Remarks"; Text[50])
        {
        }
        field(50010; "Customer Payment On Account"; Boolean)
        {
        }
        field(50011; "G/L Account"; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"."No.";

            trigger OnValidate()
            begin
                GLAcc.Reset;

                if GLAcc.Get("G/L Account") then begin
                    //IF Type=Type::Payment THEN
                    //  GLAcc.TESTFIELD(GLAcc."Budget Controlled",TRUE);
                    if GLAcc."Direct Posting" = false then begin
                        Error('Direct Posting must be True');
                    end;
                end;

                /*PayLine.RESET;
                PayLine.SETRANGE(PayLine.Type,Code);
                IF PayLine.FIND('-') THEN
                   ERROR('This Transaction Code Is Already in Use You Cannot Delete');uncomment*/

            end;
        }
        field(50012; Blocked; Boolean)
        {
        }
        field(50013; "Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(50014; "Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,2,2';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(50015; "Excess Transaction Type"; Option)
        {
            OptionCaption = 'Deposits,Fosa Saving';
            OptionMembers = Deposits,"Fosa Saving";
        }
        field(50016; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Transaction No.")
        {
            Clustered = true;
        }
        key(Key2; "Account Type", Posted)
        {
            SumIndexFields = Amount;
        }
        key(Key3; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*
        IF Posted THEN
        ERROR('Cannot delete a posted transaction');
        */

    end;

    trigger OnInsert()
    begin
        if "Transaction No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."BOSA Receipts Nos");
            NoSeriesMgt.InitSeries(NoSetup."BOSA Receipts Nos", xRec."No. Series", 0D, "Transaction No.", "No. Series");
        end;

        "User ID" := UserId;
        "Transaction Date" := Today;
        if "Receipt Mode" = "receipt mode"::Cash then begin
            "Posting Date" := Today;
        end;
        if "Receipt Mode" = "receipt mode"::Mpesa then begin
            "Employer No." := 'M-PESA PAYBILL ACCOU';
        end;

        "Transaction Time" := Time;
        Source := Source::BOSA;
        "Global Dimension 2 Code" := SFactory.FnGetUserBranch();

        Banks.Reset;
        Banks.SetRange(Banks.CashierID, UserId);
        Banks.SetRange(Banks."Account Type", Banks."account type"::Cashier);
        if Banks.Find('-') then begin
            "Employer No." := Banks."No.";
            "Bank Name" := Banks.Name;
        end;
    end;

    trigger OnModify()
    begin
        /*IF Posted THEN
        ERROR('Cannot modify a posted transaction');
        */

    end;

    trigger OnRename()
    begin
        /*IF Posted THEN
        ERROR('Cannot rename a posted transaction');
        */

    end;

    var
        Cust: Record Customer;
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BOSARcpt: Record "Receipts & Payments";
        GLAcct: Record "G/L Account";
        Mem: Record "Member Register";
        Vend: Record Vendor;
        GLAcc: Record "G/L Account";
        PayLine: Record "Payment Line.";
        Banks: Record "Bank Account";
        SFactory: Codeunit "SURESTEP Factory.";
}

