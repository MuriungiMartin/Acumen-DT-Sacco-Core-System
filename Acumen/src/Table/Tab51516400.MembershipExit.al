#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516400 "Membership Exit"
{

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Closure  Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No."; Code[20])
        {
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            begin
                GenSetup.Get();
                IntTotal := 0;
                LoanTotal := 0;
                "User ID" := UserId;
                "Mode Of Disbursement" := "mode of disbursement"::Vendor;
                //*********************Restrict No of Withdrawals******************************//
                Closure.Reset;
                Closure.SetRange(Closure."Member No.", "Member No.");
                Closure.SetRange(Closure.Posted, false);
                if Closure.Find('-') then begin
                    Error('The Member has another withdrawal application Closure No %1', Closure."No.");
                end;
                //*********************Restrict No of Withdrawals******************************//


                if Cust.Get("Member No.") then begin
                    Cust.CalcFields(Cust."Current Shares", Cust."Shares Retained");//ITOMA
                    "Member Name" := Cust.Name;
                    "Member Deposits" := Cust."Current Shares";
                    "FOSA Account No." := Cust."FOSA Account No.";
                    "Unpaid Dividends" := Cust."Dividend Amount";
                    "Share Capital" := Cust."Shares Retained";
                    "Refundable Share Capital" := 0;
                    if "Share Capital" > 2000 then
                        "Refundable Share Capital" := Cust."Shares Retained" - 2000;
                    if Cust."Risk Fund" < 0 then
                        "Risk Beneficiary" := true;

                    if "Risk Beneficiary" <> true then
                        //"Risk Refundable":=(GenSetup."Risk Beneficiary (%)"/100)*"Risk Fund";


                        "Total Adds" := "Member Deposits" + "Unpaid Dividends" + "Risk Refundable";


                    Loans.Reset;
                    Loans.SetRange(Loans."Client Code", "Member No.");
                    Loans.SetRange(Loans.Posted, true);
                    Loans.SetRange(Loans.Source, Loans.Source::BOSA);
                    Loans.SetFilter(Loans."Outstanding Balance", '>0');
                    if Loans.Find('-') then begin
                        repeat
                            Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");
                            IntTotal := IntTotal + Loans."Oustanding Interest";
                            LoanTotal := LoanTotal + Loans."Outstanding Balance";
                        until Loans.Next = 0;
                    end;

                    //FOSA Loans
                    Loans.Reset;
                    Loans.SetRange(Loans."Client Code", "Member No.");
                    Loans.SetRange(Loans.Posted, true);
                    Loans.SetRange(Loans.Source, Loans.Source::FOSA);
                    Loans.SetFilter(Loans."Outstanding Balance", '>0');
                    if Loans.Find('-') then begin
                        repeat
                            Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");
                            IntTotalFOSA := IntTotalFOSA + Loans."Oustanding Interest";
                            LoanTotalFOSA := LoanTotalFOSA + Loans."Outstanding Balance";
                        until Loans.Next = 0;
                    end;
                end;

                "Total Loan" := LoanTotal;
                "Total Interest" := IntTotal;
                "Total Loans FOSA" := LoanTotalFOSA;
                "Total Oustanding Int FOSA" := IntTotalFOSA;
                "Total Lesses" := "Total Loan" + "Total Interest" + "Total Loans FOSA" + "Total Oustanding Int FOSA";
                //+GenSetup."Withdrawal Fee"+((GenSetup."Withdrawal Fee"*GenSetup."Excise Duty(%)")/100);
                "Net Payable to the Member" := "Total Adds" - "Total Lesses";
            end;
        }
        field(3; "Member Name"; Text[50])
        {
        }
        field(4; "Closing Date"; Date)
        {
        }
        field(5; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "Total Loan"; Decimal)
        {
        }
        field(8; "Total Interest"; Decimal)
        {
        }
        field(9; "Member Deposits"; Decimal)
        {
        }
        field(10; "No. Series"; Code[20])
        {
        }
        field(11; "Closure Type"; Option)
        {
            OptionCaption = 'Withdrawal - Normal,Withdrawal - Death,Withdrawal - Death(Defaulter),Retirement';
            OptionMembers = "Withdrawal - Normal","Withdrawal - Death","Withdrawal - Death(Defaulter)",Retirement;
        }
        field(12; "Mode Of Disbursement"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee,Member,Investor';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;
        }
        field(13; "Paying Bank"; Code[20])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                if ("Mode Of Disbursement" = "mode of disbursement"::Customer) or ("Mode Of Disbursement" = "mode of disbursement"::Vendor) then begin
                    if "Paying Bank" = '' then
                        Error('You Must Specify the Paying bank');
                end;
            end;
        }
        field(14; "Cheque No."; Code[20])
        {
        }
        field(15; "FOSA Account No."; Code[20])
        {
        }
        field(16; Payee; Text[80])
        {
        }
        field(17; "Net Pay"; Decimal)
        {
        }
        field(18; "Risk Fund"; Decimal)
        {
        }
        field(19; "Risk Beneficiary"; Boolean)
        {
        }
        field(20; "Risk Refundable"; Decimal)
        {
        }
        field(21; "Total Adds"; Decimal)
        {
        }
        field(22; "Total Lesses"; Decimal)
        {
        }
        field(23; "Unpaid Dividends"; Decimal)
        {
        }
        field(24; "Total Loans FOSA"; Decimal)
        {
        }
        field(25; "Total Oustanding Int FOSA"; Decimal)
        {
        }
        field(26; "Net Payable to the Member"; Decimal)
        {
        }
        field(27; "Risk Fund Arrears"; Decimal)
        {
        }
        field(28; "Withdrawal Application Date"; Date)
        {

            trigger OnValidate()
            begin
                //GenSetup.GET();
            end;
        }
        field(29; "Reason For Withdrawal"; Option)
        {
            OptionCaption = 'Relocation,Financial Constraints,House/Group Challages,Join another Institution,Personal Reasons,Other';
            OptionMembers = Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other;
        }
        field(30; "Sell Share Capital to"; Code[20])
        {
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Sell Share Capital to") then begin
                    "Sell Shares Member Name" := Cust.Name;
                end;
            end;
        }
        field(31; "Sell Shares Member Name"; Code[20])
        {
        }
        field(32; "Share Capital Transfer Fee"; Decimal)
        {
        }
        field(33; "Sell Share Capital"; Boolean)
        {

            trigger OnValidate()
            begin
                GenSetup.Get();
                "Share Capital Transfer Fee" := GenSetup."Share Capital Transfer Fee";
            end;
        }
        field(34; "Share Capital"; Decimal)
        {
        }
        field(35; "Share Capital to Sell"; Decimal)
        {
            CalcFormula = sum("M_Withdrawal Share Cap Sell".Amount where("Document No" = field("No.")));
            FieldClass = FlowField;
        }
        field(36; "Posting Date"; Date)
        {
        }
        field(37; "User ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Refundable Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Date Approved"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Expected Posting Date" := CalcDate('<60D>', "Date Approved");
            end;
        }
        field(41; "Expected Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Ten WIthdrawal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(43; Overpayment; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Bank AccNo"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "clear Exit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Ready to Exit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "cheque Date"; Date)
        {
            DataClassification = ToBeClassified;
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

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Closure  Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Closure  Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Cust: Record "Member Register";
        Loans: Record "Loans Register";
        MemLed: Record "Cust. Ledger Entry";
        IntTotal: Decimal;
        LoanTotal: Decimal;
        GenSetup: Record "Sacco General Set-Up";
        IntTotalFOSA: Decimal;
        LoanTotalFOSA: Decimal;
        Closure: Record "Membership Exit";
        Shares: Decimal;
}

