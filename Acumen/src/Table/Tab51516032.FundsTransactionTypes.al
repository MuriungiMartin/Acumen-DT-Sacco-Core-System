#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516032 "Funds Transaction Types"
{

    fields
    {
        field(10; "Transaction Code"; Code[30])
        {
        }
        field(11; "Transaction Description"; Text[50])
        {
        }
        field(12; "Transaction Type"; Option)
        {
            Editable = true;
            OptionCaption = 'Payment,Receipt,Imprest,Claim';
            OptionMembers = Payment,Receipt,Imprest,Claim;
        }
        field(13; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,Investor';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor;
        }
        field(14; "Account No"; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const(Member)) "Member Register";

            trigger OnValidate()
            begin
                if "Account Type" = "account type"::"G/L Account" then begin
                    GLAcc.Reset;
                    GLAcc.SetRange(GLAcc."No.", "Account No");
                    if GLAcc.FindFirst then begin
                        "Account Name" := GLAcc.Name;
                    end;
                end;
                if "Account Type" = "account type"::Customer then begin
                    Customer.Reset;
                    Customer.SetRange(Customer."No.", "Account No");
                    if Customer.FindFirst then begin
                        "Account Name" := Customer.Name;
                    end;
                end;
                if "Account Type" = "account type"::Vendor then begin
                    Vendor.Reset;
                    Vendor.SetRange(Vendor."No.", "Account No");
                    if Vendor.FindFirst then begin
                        "Account Name" := Vendor.Name;
                    end;
                end;
                /*IF "Account Type"="Account Type"::"8" THEN BEGIN
                   Member.RESET;
                   Member.SETRANGE(Member."No.","Account No");
                   IF Member.FINDFIRST THEN BEGIN
                     "Account Name":=Member.Name;
                   END;
                END;
                */
                if "Account No" = '' then
                    "Account Name" := '';

            end;
        }
        field(15; "Account Name"; Text[50])
        {
            Editable = false;
        }
        field(16; "Default Grouping"; Code[20])
        {
            TableRelation = if ("Account Type" = const(Customer)) "Customer Posting Group"
            else
            if ("Account Type" = const(Vendor)) "Vendor Posting Group"
            else
            if ("Account Type" = const(Member)) "Member Register"
            else
            if ("Account Type" = const("Bank Account")) "Bank Account Posting Group"
            else
            if ("Account Type" = const("Fixed Asset")) "FA Posting Group";
        }
        field(17; "VAT Chargeable"; Boolean)
        {
        }
        field(18; "VAT Code"; Code[20])
        {
            TableRelation = "Funds Tax Codes"."Tax Code" where(Type = const(VAT));
        }
        field(19; "Withholding Tax Chargeable"; Boolean)
        {
        }
        field(20; "Withholding Tax Code"; Code[20])
        {
            TableRelation = "Funds Tax Codes"."Tax Code" where(Type = const("W/Tax"));
        }
        field(21; "Retention Chargeable"; Boolean)
        {
        }
        field(22; "Retention Code"; Code[20])
        {
        }
        field(23; "Meeting Transaction"; Boolean)
        {
        }
        field(24; "Meeting Type"; Code[50])
        {
        }
        field(51516549; "Customer Type"; Option)
        {
            OptionCaption = ' ,Applicant,Member,CPD Applicant,CPD Provider';
            OptionMembers = " ",Applicant,Member,"CPD Applicant","CPD Provider";
        }
        field(51516550; Blocked; Boolean)
        {
        }
        field(51516551; "Pending Voucher"; Boolean)
        {
        }
        field(51516552; "Payment Reference"; Option)
        {
            OptionMembers = Normal,"Farmer Purchase",Grant;
        }
        field(51516553; "Direct Expense"; Boolean)
        {
            Editable = false;
        }
        field(51516554; "VAT Withheld Code"; Code[10])
        {
            TableRelation = "Funds Tax Codes"."Tax Code";
        }
        field(51516555; "G/L Account Name"; Text[100])
        {
        }
        field(51516556; "G/L Account"; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"."No.";

            trigger OnValidate()
            begin
                GLAcc.Reset;
                if GLAcc.Get("G/L Account") then begin
                    "G/L Account Name" := GLAcc.Name;
                    if "Transaction Type" = "transaction type"::Payment then
                        GLAcc.TestField(GLAcc."Budget Controlled", true);

                    if GLAcc."Direct Posting" = false then begin
                        Error('Direct Posting must be True');
                    end;
                end;

                // PayLine.Reset;
                // PayLine.SetRange(PayLine.Type, "Transaction Code");
                // if PayLine.Find('-') then

            end;
        }
        field(51516557; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                if "Account Type" <> "account type"::"Bank Account" then begin
                    Error('You can only enter Bank No where Account Type is Bank Account');
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Transaction Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        "G/L Account": Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLAcc: Record "G/L Account";
        PayLine: Record "Payment Line.";
}

