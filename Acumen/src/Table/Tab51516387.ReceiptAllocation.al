#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516387 "Receipt Allocation"
{
    DrillDownPageID = "Receipt Allocation-BOSA";
    LookupPageID = "Receipt Allocation-BOSA";

    fields
    {
        field(1; "Document No"; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Member No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Member Register"."No.";
        }
        field(3; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Registration Fee,Share Capital,Interest Paid,Loan Repayment,Deposit Contribution,Insurance Contribution,Benevolent Fund,Loan,Unallocated Funds,Dividend,FOSA Account,Loan Insurance Charged,Loan Insurance Paid,Recovery Account,FOSA Shares,Additional Shares,Interest Due,Capital Reserve,Commission,Children,Holiday,School Fees';
            OptionMembers = " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Capital Reserve",Commission,Children,Holiday,"School Fees";

            trigger OnValidate()
            begin
                "Loan No." := '';
                Amount := 0;
                if "Transaction Type" = "transaction type"::"FOSA Account" then
                    "Global Dimension 1 Code" := 'FOSA';

                if (("Transaction Type" <> "transaction type"::"FOSA Account") and ("Transaction Type" <> "transaction type"::" ")) then begin
                    "Account Type" := "account type"::Member
                end else
                    "Account Type" := "account type"::Vendor;
                if Cust.Get("Member No") then begin
                    Cust.CalcFields("Current Shares", "Shares Retained");
                    if "Transaction Type" = "transaction type"::"Deposit Contribution" then
                        "Amount Balance" := Cust."Current Shares";
                    if "Transaction Type" = "transaction type"::"Share Capital" then
                        "Amount Balance" := Cust."Shares Retained";
                    if "Transaction Type" = "transaction type"::"Capital Reserve" then
                        "Amount Balance" := Cust."Captital Reserve";
                end;
            end;
        }
        field(4; "Loan No."; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Member No"),
                                                                "Outstanding Balance" = filter(<> 0));

            trigger OnValidate()
            begin

                if Loans.Get("Loan No.") then begin
                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");
                    if Loans."Outstanding Balance" > 0 then begin
                        Amount := Loans."Loan Principle Repayment";
                        if Loans."Outstanding Balance" < Loans."Loan Principle Repayment" then
                            Amount := Loans."Outstanding Balance";
                        "Amount Balance" := Loans."Outstanding Balance";
                        "Interest Amount" := Loans."Loan Interest Repayment";
                    end;
                    if "Transaction Type" = "transaction type"::"Interest Paid" then begin
                        Amount := Loans."Oustanding Interest";
                        "Amount Balance" := Loans."Oustanding Interest";
                    end;

                end;



                "Total Amount" := Amount + "Interest Amount";
            end;
        }
        field(5; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                if (("Transaction Type" = "transaction type"::"Interest Paid") or ("Transaction Type" = "transaction type"::Loan) or ("Transaction Type" = "transaction type"::"Loan Repayment")) then begin
                    if "Loan No." = '' then
                        Error('You must specify loan no. for loan transactions.');
                end;
            end;
        }
        field(6; "Interest Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if ("Transaction Type" = "transaction type"::"Loan Repayment") then begin
                    if "Loan No." = '' then
                        Error('You must specify loan no. for loan transactions.');
                end;
                "Total Amount" := Amount + "Interest Amount";
            end;
        }
        field(7; "Total Amount"; Decimal)
        {
            Editable = false;
        }
        field(8; "Amount Balance"; Decimal)
        {
        }
        field(9; "Interest Balance"; Decimal)
        {
        }
        field(10; "Loan ID"; Code[10])
        {
        }
        field(11; "Prepayment Date"; Date)
        {
        }
        field(50000; "Loan Insurance"; Decimal)
        {
            BlankZero = true;

            trigger OnValidate()
            begin

                //Loans.GET();
                CalcFields("Applied Amount");

                if "Applied Amount" > 100000 then
                    //Loans.SETRANGE(Loans."Client Code","Member No");
                   "Loan Insurance" := "Applied Amount" * 0.25;
            end;
        }
        field(50001; "Applied Amount"; Decimal)
        {
            CalcFormula = lookup("Loans Register"."Approved Amount" where("Loan  No." = field("Loan No.")));
            FieldClass = FlowField;
        }
        field(50002; Insurance; Decimal)
        {
        }
        field(50003; "Un Allocated Amount"; Decimal)
        {
        }
        field(51516150; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(51516151; "Global Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(51516152; "Cash Clearing Charge"; Decimal)
        {
        }
        field(51516153; "Loan Outstanding Balance"; Decimal)
        {
        }
        field(51516154; "Mpesa Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,Investor';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor;
        }
        field(51516155; "Mpesa Account No"; Code[20])
        {
            TableRelation = if ("Mpesa Account Type" = filter(Member)) "Member Register"."No."
            else
            if ("Mpesa Account Type" = filter(Vendor)) Vendor."No."
            else
            if ("Mpesa Account Type" = filter("G/L Account")) "G/L Account"."No.";
        }
        field(51516156; "Cummulative Total Payment Loan"; Decimal)
        {
        }
        field(51516157; "Loan Product Name"; Code[80])
        {
        }
        field(51516158; "Total Allocation"; Decimal)
        {
            CalcFormula = sum("Receipt Allocation".Amount where("Document No" = field("Document No")));
            FieldClass = FlowField;
        }
        field(51516160; "Account No"; Code[100])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor where("BOSA Account No" = field("Member No"))
            else
            if ("Account Type" = const(Member)) "BOSA Accounts No Buffer" where("Member No" = field("Member No"));

            trigger OnValidate()
            begin
                ObjAccountNoBuffer.Reset;
                ObjAccountNoBuffer.SetRange(ObjAccountNoBuffer."Account No", "Account No");
                if ObjAccountNoBuffer.FindSet then begin
                    "Transaction Type" := ObjAccountNoBuffer."Transaction Type";
                end;
            end;
        }
        field(51516161; "Account Type"; Option)
        {
            Caption = 'Account Type';
            InitValue = Member;
            OptionCaption = 'G/L Account,Customer,FOSA Account/Vendor,Bank Account,Fixed Asset,IC Partner,Employee,BOSA Account,Investor';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;
        }
        field(51516162; "Loan PayOff Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Document No", "Transaction Type", "Loan No.", "Member No", "Global Dimension 1 Code", "Global Dimension 2 Code")
        {
            Clustered = true;
        }
        key(Key2; "Member No")
        {
        }
        key(Key3; "Loan No.")
        {
        }
        key(Key4; "Account No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Loans: Record "Loans Register";
        Cust: Record "Member Register";
        PTEN: Text;
        DataSheet: Record "Data Sheet Main";
        Customer: Record "Member Register";
        LoansR: Record "Loans Register";
        GenSetup: Record "Sacco General Set-Up";
        ReceiptAll: Record "Receipt Allocation";
        ReceiptH: Record "Receipts & Payments";
        SFactory: Codeunit "SURESTEP Factory.";
        ObjAccountNoBuffer: Record "BOSA Accounts No Buffer";
        ObjLoans: Record "Loans Register";
        ObjProductCharges: Record "Loan Product Charges";
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        VarInsuranceAmount: Decimal;
        VarTransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid";
        VarAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor;
        VarBalAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor;
        VarBalAccountNo: Code[20];
        ObjSurestep: Codeunit "SURESTEP Factory.";
        ObjLoanType: Record "Loan Products Setup";
        ObjReceiptAll: Record "Receipt Allocation";

    local procedure FnGetFosaAccount(AccountType: Code[100]): Code[100]
    var
        ObjSavingsProducts: Record Vendor;
    begin
        ObjSavingsProducts.Reset;
        ObjSavingsProducts.SetRange("Account Type", AccountType);
        ObjSavingsProducts.SetRange("BOSA Account No", "Member No");
        if ObjSavingsProducts.Find('-') then
            exit(ObjSavingsProducts."No.");
    end;
}

