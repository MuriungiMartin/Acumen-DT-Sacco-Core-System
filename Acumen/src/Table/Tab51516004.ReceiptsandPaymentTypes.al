#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516004 "Receipts and Payment Types"
{
    DrillDownPageID = "Receipt and Payment Types List";
    LookupPageID = "Receipt and Payment Types List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {

            trigger OnValidate()
            begin

                PayLine.Reset;
                PayLine.SetRange(PayLine.Type, Code);
                if PayLine.Find('-') then
                    Error('This Transaction Code Is Already in Use You cannot Modify');

                PayLine.Reset;
                PayLine.SetRange(PayLine.Type, Code);
                if PayLine.Find('-') then
                    Error('This Transaction Code Is Already in Use You Cannot Delete');
            end;
        }
        field(3; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,None';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,"None";

            trigger OnValidate()
            begin
                if "Account Type" = "account type"::"G/L Account" then
                    "Direct Expense" := true
                else
                    "Direct Expense" := false;

                PayLine.Reset;
                PayLine.SetRange(PayLine.Type, Code);
                if PayLine.Find('-') then
                    Error('This Transaction Code Is Already in Use You cannot Modify');
            end;
        }
        field(4; Type; Option)
        {
            NotBlank = true;
            OptionMembers = " ",Receipt,Payment,Imprest,Claim,Advance;
        }
        field(5; "VAT Chargeable"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(6; "Withholding Tax Chargeable"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(7; "VAT Code"; Code[20])
        {
            TableRelation = "Tariff Codes";
        }
        field(8; "Withholding Tax Code"; Code[20])
        {
            TableRelation = "Tariff Codes";
        }
        field(9; "Default Grouping"; Code[20])
        {
            TableRelation = if ("Account Type" = const(Customer)) "Customer Posting Group"
            else
            if ("Account Type" = const(Vendor)) "Vendor Posting Group";
        }
        field(10; "G/L Account"; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"."No.";

            trigger OnValidate()
            begin
                GLAcc.Reset;
                if GLAcc.Get("G/L Account") then begin
                    "G/L Account Name" := GLAcc.Name;
                    if Type = Type::Payment then
                        GLAcc.TestField(GLAcc."Budget Controlled", true);

                    if GLAcc."Direct Posting" = false then begin
                        Error('Direct Posting must be True');
                    end;
                end;
            end;

            // PayLine.Reset;
            // PayLine.SetRange(PayLine.Type, Code);
            // if PayLine.Find('-') then 


        }
        field(11; "Pending Voucher"; Boolean)
        {
        }
        field(12; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                if "Account Type" <> "account type"::"Bank Account" then begin
                    Error('You can only enter Bank No where Account Type is Bank Account');
                end;
            end;
        }
        field(13; "Transation Remarks"; Text[250])
        {
            NotBlank = true;
        }
        field(14; "Payment Reference"; Option)
        {
            OptionMembers = Normal,"Farmer Purchase",Grant;
        }
        field(15; "Customer Payment On Account"; Boolean)
        {
        }
        field(16; "Direct Expense"; Boolean)
        {
            Editable = false;
        }
        field(17; "Calculate Retention"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(18; "Retention Code"; Code[20])
        {
            TableRelation = "Tariff Codes";
        }
        field(19; Blocked; Boolean)
        {
        }
        field(20; "Based On Travel Rates Table"; Boolean)
        {
        }
        field(21; "VAT Withheld Code"; Code[10])
        {
            TableRelation = "Tariff Codes".Code;
        }
        field(22; "G/L Account Name"; Text[100])
        {
        }
        field(24; code1; Code[30])
        {
        }
        field(29; Posted; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code", Type)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        PayLine.Reset;
        PayLine.SetRange(PayLine.Type, Code);
        if PayLine.Find('-') then
            Error('This Transaction Code Is Already in Use You Cannot Delete');
    end;

    var
        GLAcc: Record "G/L Account";
        PayLine: Record "Payment Line.";
}

