#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516551 "Loan Member Loans"
{
    DrillDownPageID = "Loan Offset Detail List";
    LinkedObject = false;
    LookupPageID = "Loan Offset Detail List";

    fields
    {
        field(1; "Document No"; Code[20])
        {
            TableRelation = "Loan Recovery Header"."Document No";
        }
        field(2; "Loan No."; Code[20])
        {
            TableRelation = "Loan Recovery Header"."Loan to Attach";

            trigger OnValidate()
            begin
                Loans.Reset;
                Loans.SetRange(Loans."Loan  No.", Loans."Client Code");

                if Confirm('Are you Sure you Want to PayOff this loan?', true) = true then begin

                    "Loan Type" := '';
                    "Approved Loan Amount" := 0;
                    "Loan Instalments" := 0;
                    "Monthly Repayment" := 0;
                    Loantypes.Reset;
                    Loantypes.SetRange(Loantypes.Code, "Loan Type");



                    Loans.Reset;
                    Loans.SetRange(Loans."Loan  No.", "Loan No.");
                    if Loans.Find('-') then begin
                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due", Loans."Oustanding Interest");
                        "Loan Type" := Loans."Loan Product Type";
                        if Cust.Get(Loans."Client Code") then begin
                            "Staff No" := Cust."ID No.";
                            "Staff No" := Cust."Personal No";
                        end;

                        "Approved Loan Amount" := Loans."Outstanding Balance";
                        "Loan Instalments" := Loans."Oustanding Interest";
                        "Monthly Repayment" := "Approved Loan Amount" + "Loan Instalments";
                        "Loan Outstanding" := "Monthly Repayment";
                        "Outstanding Balance" := Loans.Repayment;
                        GenSetUp.Get();
                        if Loantypes.Get("Loan Type") then begin
                        end;
                    end;
                    "Monthly Repayment" := "Approved Loan Amount" + "Loan Instalments";
                    Loans.Bridged := true;
                    Loans.Modify
                end;


                if Loans.Get("Document No") then begin
                    if "Monthly Repayment" > Loans."Requested Amount" then
                        Error('You Can not PayOff more than the requested amount');
                end;
                "Monthly Repayment" := "Approved Loan Amount" + "Loan Instalments";
            end;
        }
        field(3; "Member No"; Code[20])
        {
        }
        field(4; "Loan Type"; Code[20])
        {
        }
        field(5; "Approved Loan Amount"; Decimal)
        {
        }
        field(6; "Loan Instalments"; Decimal)
        {
        }
        field(7; "Monthly Repayment"; Decimal)
        {
        }
        field(8; "Outstanding Balance"; Decimal)
        {
        }
        field(9; "Outstanding Interest"; Decimal)
        {
        }
        field(10; "Interest Rate"; Decimal)
        {
        }
        field(11; "ID. NO"; Code[20])
        {
        }
        field(12; "Staff No"; Code[20])
        {
        }
        field(13; Posted; Boolean)
        {
        }
        field(14; "Posting Date"; Date)
        {
        }
        field(15; "Loan Outstanding"; Decimal)
        {
        }
        field(16; "Amont Guaranteed"; Decimal)
        {

            trigger OnValidate()
            begin
                //Shares:=Shares*-1;
                //MESSAGE('SHARE %1',Shares);




                if "Amont Guaranteed" > (Shares) then
                    Error('You cannot guarantee more than your shares of %1', Shares);


                /*
                IF Cust.GET("Member No") THEN BEGIN
                Cust.CALCFIELDS(Cust."Outstanding Balance",Cust."Current Shares");//,Cust."Loans Guaranteed"
                Name:=Cust.Name;
                "Loan Balance":=Cust."Outstanding Balance";
                Shares:=Cust."Current Shares"*-1;
                END;
                */

            end;
        }
        field(17; Shares; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("Member No"),
                                                                   "Transaction Type" = filter(Loan),
                                                                   "Posting Date" = field("Date Filter")));
            Editable = true;
            FieldClass = FlowField;
        }
        field(18; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(19; "Defaulter Loan"; Decimal)
        {
        }
        field(20; "Guarantor Number"; Code[50])
        {
        }
        field(22; "Guarantors Committed Shares"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("Guarantor Number")));
            FieldClass = FlowField;
        }
        field(23; "Guarantors Free Shares"; Decimal)
        {
        }
        field(24; "Guarantors Current Shares"; Decimal)
        {
            FieldClass = Normal;
        }
        field(25; "Defaulter Loan No"; Code[50])
        {
        }
        field(26; "Member Name"; Code[50])
        {
        }
        field(27; "Equal Liability Amount"; Decimal)
        {
        }
        field(28; "Current Member Deposits"; Decimal)
        {
        }
        field(29; "Variance From Deposits"; Decimal)
        {
        }
        field(30; "Guarantor Amount Apportioned"; Decimal)
        {
        }
        field(31; "Amount from Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Amount from Deposits" > "Approved Loan Amount" then
                    Error('The maximun from deposits is ' + Format("Approved Loan Amount"));
                "Defaulter Loan" := "Approved Loan Amount" - "Amount from Deposits";
            end;
        }
        field(32; "Amount to Trustee Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Guarantor Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No", "Member No", "Loan No.", "Guarantor Number")
        {
            Clustered = true;
            SumIndexFields = "Monthly Repayment", "Approved Loan Amount";
        }
        key(Key2; "Approved Loan Amount")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Member No", "Loan Type", "Approved Loan Amount", "Loan Instalments", "Monthly Repayment", "Outstanding Balance", "Outstanding Interest", "Interest Rate", "ID. NO", Posted)
        {
        }
    }

    var
        Loans: Record "Loans Register";
        Loantypes: Record "Loan Products Setup";
        Interest: Decimal;
        Cust: Record Customer;
        LoansTop: Record "Loans Register";
        GenSetUp: Record "Sacco General Set-Up";
        LoansG: Record "Loans Guarantee Details";
        GuarantorRecH: Record "Loan Recovery Header";
        LoanResch: Record "Loan Repayment Schedule";
}

