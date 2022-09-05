#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516407 "BOSA TransferS Schedule"
{

    fields
    {
        field(1; "No."; Code[10])
        {
        }
        field(2; "Source Account No."; Code[20])
        {
            TableRelation = if ("Source Type" = filter(Customer)) Customer."No."
            else
            if ("Source Type" = filter(Vendor)) Vendor."No."
            else
            if ("Source Type" = filter(Bank)) "Bank Account"."No."
            else
            if ("Source Type" = filter("G/L ACCOUNT")) "G/L Account"."No."
            else
            if ("Source Type" = filter(MEMBER)) Customer."No.";

            trigger OnValidate()
            begin
                if "Source Type" = "source type"::Customer then begin
                    Cust.Reset;
                    if Cust.Get("Source Account No.") then begin
                        "Source Account Name" := Cust.Name;
                        "Destination Account Type" := "destination account type"::FOSA;
                        //"Destination Account No.":=Cust."FOSA Account";
                        Validate("Destination Account No.");
                    end;
                end;

                if "Source Type" = "source type"::Bank then begin
                    Bank.Reset;
                    if Bank.Get("Source Account No.") then begin
                        "Source Account Name" := Bank.Name;
                    end;
                end;

                if "Source Type" = "source type"::Vendor then begin
                    Vend.Reset;
                    if Vend.Get("Source Account No.") then begin
                        "Source Account Name" := Vend.Name;
                    end;
                end;

                if "Source Type" = "source type"::MEMBER then begin
                    memb.Reset;
                    if memb.Get("Source Account No.") then begin
                        "Source Account Name" := memb.Name;
                    end;
                end;


                if "Source Type" = "source type"::"G/L ACCOUNT" then begin
                    "G/L".Reset;
                    if "G/L".Get("Source Account No.") then begin
                        "Source Account Name" := "G/L".Name;
                    end;
                end;
            end;
        }
        field(3; "Source Account Name"; Text[100])
        {
        }
        field(4; "Destination Account Type"; Option)
        {
            OptionCaption = 'FOSA,BANK,bosa,G/L ACCOUNT,MEMBER';
            OptionMembers = FOSA,BANK,bosa,"G/L ACCOUNT",MEMBER;

            trigger OnValidate()
            begin
                /*IF "Destination Account Type"="Destination Account Type"::BANK THEN BEGIN
                "Destination Account No.":='5-02-09276-01';
                VALIDATE("Destination Account No.");
                END;
                   */

            end;
        }
        field(5; "Destination Account No."; Code[20])
        {
            TableRelation = if ("Destination Account Type" = const(FOSA)) Vendor."No."
            else
            if ("Destination Account Type" = const(BANK)) "Bank Account"."No."
            else
            if ("Destination Account Type" = const("G/L ACCOUNT")) "G/L Account"."No."
            else
            if ("Destination Account Type" = const(MEMBER)) Customer."No.";

            trigger OnValidate()
            begin
                if "Destination Account Type" = "destination account type"::FOSA then begin
                    Vend.Reset;
                    if Vend.Get("Destination Account No.") then
                        "Destination Account Name" := Vend.Name;
                end else
                    if "Destination Account Type" = "destination account type"::bosa then begin
                        Cust.Reset;
                        if Cust.Get("Destination Account No.") then
                            "Destination Account Name" := Cust.Name;
                    end;

                if "Destination Account Type" = "destination account type"::"G/L ACCOUNT" then begin
                    "G/L".Reset;
                    if "G/L".Get("Destination Account No.") then begin
                        "Destination Account Name" := "G/L".Name;
                    end;
                end;

                if "Destination Account Type" = "destination account type"::MEMBER then begin
                    memb.Reset;
                    if memb.Get("Destination Account No.") then begin
                        "Destination Account Name" := memb.Name;
                    end;
                end;
                if "Destination Account Type" = "destination account type"::BANK then begin
                    Bank.Reset;
                    if Bank.Get("Destination Account No.") then begin
                        "Destination Account Name" := Bank.Name;
                    end;
                end;
            end;
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; "Source Type"; Option)
        {
            OptionCaption = 'Customer,Vendor,Bank,G/L ACCOUNT,MEMBER';
            OptionMembers = Customer,Vendor,Bank,"G/L ACCOUNT",MEMBER;
        }
        field(8; "Destination Account Name"; Text[100])
        {
        }
        field(9; "Destination Bank No."; Code[20])
        {
        }
        field(10; "Destination Bank Name"; Text[30])
        {
        }
        field(11; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Registration Fee,Loan,Repayment,Withdrawal,Interest Due,Interest Paid,Benevolent Fund,Normal Shares,Penalty Charged,Application Fee,Appraisal Fee,Investment,Unallocated Funds,Shares Capital,Loan Adjustment,Dividend,Withholding Tax,Administration Fee,Insurance Contribution,Prepayment,Withdrawable Deposits,Xmas Contribution,Penalty Paid,Dev Shares,Co-op Shares,Welfare Contribution 2,Loan Penalty,Loan Guard,Lukenya,Konza,Juja,Housing Water,Housing Title,Housing Main,M Pesa Charge ,Insurance Charge,Insurance Paid,FOSA Account,Partial Disbursement,Loan Due,FOSA Shares,Loan Form Fee,PassBook Fee';
            OptionMembers = " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","Welfare Contribution 2","Loan Penalty","Loan Guard",Lukenya,Konza,Juja,"Housing Water","Housing Title","Housing Main","M Pesa Charge ","Insurance Charge","Insurance Paid","FOSA Account","Partial Disbursement","Loan Due","FOSA Shares","Loan Form Fee","PassBook Fee";

            trigger OnValidate()
            begin
                if "Transaction Type" = "transaction type"::"Registration Fee" then
                    Description := 'Registration Fee';
                if "Transaction Type" = "transaction type"::Loan then
                    Description := 'Loan';
                if "Transaction Type" = "transaction type"::Repayment then
                    Description := 'Loan Repayment';
                if "Transaction Type" = "transaction type"::Withdrawal then
                    Description := 'Withdrawal';
                if "Transaction Type" = "transaction type"::"Interest Due" then
                    Description := 'Interest Due';
                if "Transaction Type" = "transaction type"::"Interest Paid" then
                    Description := 'Interest Paid';
                if "Transaction Type" = "transaction type"::"Benevolent Fund" then
                    Description := 'ABF Fund';
                if "Transaction Type" = "transaction type"::"Deposit Contribution" then
                    Description := 'Shares Contribution';
                if "Transaction Type" = "transaction type"::"Appraisal Fee" then
                    Description := 'Appraisal Fee';
                if "Transaction Type" = "transaction type"::"Application Fee" then
                    Description := 'Application Fee';
                if "Transaction Type" = "transaction type"::"Unallocated Funds" then
                    Description := 'Unallocated Funds';
            end;
        }
        field(12; Loan; Code[30])
        {
            TableRelation = if ("Source Type" = const(Customer)) "Loans Register"."Loan  No." where("Client Code" = field("Source Account No."))
            else
            if ("Destination Account Type" = const(bosa)) "Loans Register"."Loan  No." where("Client Code" = field("Destination Account No."))
            else
            if ("Destination Account Type" = const(MEMBER)) "Loans Register"."Loan  No." where("Client Code" = field("Destination Account No."))
            else
            if ("Source Type" = const(MEMBER)) "Loans Register"."Loan  No." where("Client Code" = field("Source Account No."));
        }
        field(13; "Destination Loan"; Code[30])
        {
            TableRelation = if ("Source Type" = const(Customer)) "Loans Register"."Loan  No." where("Client Code" = field("Source Account No."))
            else
            if ("Destination Account Type" = const(bosa)) "Loans Register"."Loan  No." where("Client Code" = field("Destination Account No."))
            else
            if ("Destination Account Type" = const(bosa)) "Loans Register"."Loan  No." where("Client Code" = field("Destination Account No."))
            else
            if ("Destination Account Type" = const(MEMBER)) "Loans Register"."Loan  No." where("Client Code" = field("Destination Account No."))
            else
            "Loans Register";
        }
        field(14; Description; Text[100])
        {
        }
        field(15; "Destination Type"; Option)
        {
            OptionCaption = ' ,Registration Fee,Loan,Repayment,Withdrawal,Interest Due,Interest Paid,Benevolent Fund,Normal Shares,Penalty Charged,Application Fee,Appraisal Fee,Investment,Unallocated Funds,Shares Capital,Loan Adjustment,Dividend,Withholding Tax,Administration Fee,Insurance Contribution,Prepayment,Withdrawable Deposits,Xmas Contribution,Penalty Paid,Dev Shares,Co-op Shares,Welfare Contribution 2,Loan Penalty,Loan Guard,Lukenya,Konza,Juja,Housing Water,Housing Title,Housing Main,M Pesa Charge ,Insurance Charge,Insurance Paid,FOSA Account,Partial Disbursement,Loan Due,FOSA Shares,Loan Form Fee,PassBook Fee';
            OptionMembers = " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","Welfare Contribution 2","Loan Penalty","Loan Guard",Lukenya,Konza,Juja,"Housing Water","Housing Title","Housing Main","M Pesa Charge ","Insurance Charge","Insurance Paid","FOSA Account","Partial Disbursement","Loan Due","FOSA Shares","Loan Form Fee","PassBook Fee";
        }
    }

    keys
    {
        key(Key1; "No.", "Source Account No.", "Destination Bank No.", "Transaction Type", Loan)
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if "Source Account No." <> '' then begin
            Bosa.Reset;
            if Bosa.Get("No.") then begin
                if (Bosa.Posted) or (Bosa.Approved) then
                    Error('Cannot delete approved or posted batch');
            end;
        end;
    end;

    trigger OnModify()
    begin
        if "Source Account No." <> '' then begin
            Bosa.Reset;
            if Bosa.Get("No.") then begin
                if (Bosa.Posted) or (Bosa.Approved) then
                    Error('Cannot modify approved or posted batch');
            end;
        end;
    end;

    trigger OnRename()
    begin
        Bosa.Reset;
        if Bosa.Get("No.") then begin
            if (Bosa.Posted) or (Bosa.Approved) then
                Error('Cannot rename approved or posted batch');
        end;
    end;

    var
        Cust: Record Customer;
        Vend: Record Vendor;
        Bank: Record "Bank Account";
        Bosa: Record "BOSA Transfers";
        "G/L": Record "G/L Account";
        memb: Record Customer;
}

