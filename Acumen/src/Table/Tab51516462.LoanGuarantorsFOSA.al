#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516462 "Loan GuarantorsFOSA"
{

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(2; "Account No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            begin
                TotalGuaranted := 0;

                Date := Today;


                Members.Reset;
                Members.SetRange(Members."No.", "Account No.");
                if Members.Find('-') then begin
                    Members.CalcFields(Members."Current Shares");
                    //"Amount Guaranted":=Members."Current Shares";
                    Names := Members.Name;
                    "Staff/Payroll No." := Members."Personal No";
                    "Current Shares" := Members."Current Shares";
                    "Amount Guaranted" := Members."Current Shares";
                end;

                CustN.Reset;
                CustN.SetRange(CustN."No.", "Account No.");
                if CustN.Find('-') then begin
                    CustN.CalcFields(CustN."Current Shares");
                    if CustN."Current Shares" < 0 then
                        Error('Member has no Deposits');
                end;

                //Check Max garantors
                LoansG := 0;
                LoanGuarantors.Reset;
                LoanGuarantors.SetRange(LoanGuarantors."Account No.", "Account No.");
                if LoanGuarantors.Find('-') then begin
                    if LoanGuarantors.Count > 4 then begin
                        repeat
                            if Loans.Get(LoanGuarantors."Loan No") then begin
                                Loans.CalcFields(Loans."Outstanding Balance");
                                if Loans."Outstanding Balance" > 0 then
                                    LoansG := LoansG + 1;

                            end;
                        until LoanGuarantors.Next = 0;
                    end;
                end;

                if LoansG > 4 then begin
                    if Confirm('Member has guaranteed more than 4 active loans. Do you wish to continue?', false) = false then begin
                        "Account No." := '';
                        "Staff/Payroll No." := '';
                        Names := '';
                        exit;
                    end;
                end;
                //Check Max garantors

                /*LoanGuarantors.RESET;
                LoanGuarantors.SETRANGE(LoanGuarantors."Account No.","Account No.");
                IF LoanGuarantors.FIND('-') THEN BEGIN
                IF LoanGuarantors.COUNT < 10 THEN ERROR('Kindly add more Guarantors. Minimum of 10');
                END;
                */

            end;
        }
        field(3; Names; Text[200])
        {
        }
        field(4; Signed; Boolean)
        {
        }
        field(5; "Amount Guaranted"; Decimal)
        {

            trigger OnValidate()
            begin
                CustN.Reset;
                CustN.SetRange(CustN."No.", "Account No.");
                if CustN.Find('-') then begin
                    CustN.CalcFields(CustN."Current Shares");
                    if CustN."Current Shares" < "Amount Guaranted" then
                        Error('You Cant Guarantee More than your Deposits');
                end;
            end;
        }
        field(6; "Distribution (%)"; Decimal)
        {
        }
        field(7; "Distribution (Amount)"; Decimal)
        {
        }
        field(8; "Staff/Payroll No."; Code[20])
        {

            trigger OnValidate()
            begin
                /*Cust.RESET;
                Cust.SETFILTER(Cust."Account Type",'PRIME|OMEGA|FAHARI');
                Cust.SETRANGE(Cust."Staff No","Staff/Payroll No.");
                IF Cust.FIND('-') THEN BEGIN
                "Account No.":=Cust."No.";
                VALIDATE("Account No.");
                END
                ELSE
                ERROR('Record not found.')
                 */

            end;
        }
        field(9; Substituted; Boolean)
        {

            trigger OnValidate()
            begin
                Date := Today;
            end;
        }
        field(10; "Line No"; Integer)
        {
        }
        field(11; Date; Date)
        {
        }
        field(12; "Self Guarantee"; Boolean)
        {
        }
        field(13; "Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Transaction Type" = filter("Share Capital" | "Interest Paid"),
                                                                  "Loan No" = field("Loan No")));
            FieldClass = FlowField;
        }
        field(14; "Guarantor Outstanding"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Customer No." = field("Account No."),
                                                                  "Transaction Type" = filter("Share Capital" | "Interest Paid")));
            FieldClass = FlowField;
        }
        field(15; "Employer Code"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(16; "Employer Name"; Text[100])
        {
        }
        field(17; Salaried; Boolean)
        {
        }
        field(18; "Current Shares"; Decimal)
        {
        }
        field(19; "Loanee No"; Code[20])
        {
        }
        field(20; "Loanee Name"; Code[70])
        {
        }
        field(21; "Loan Product"; Code[30])
        {
        }
        field(22; "Entry No"; Integer)
        {
        }
        field(23; "FOSA  Accounts"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Loan No", "Staff/Payroll No.", Signed, "Line No", "Entry No")
        {
            Clustered = true;
            SumIndexFields = "Amount Guaranted";
        }
        key(Key2; "Loan No", Signed)
        {
            SumIndexFields = "Amount Guaranted";
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Vendor;
        LoanGuarantor: Record "Loan GuarantorsFOSA";
        LoanApp: Record "Loans Register";
        TotalGuaranted: Decimal;
        LoansG: Integer;
        LoanGuarantors: Record "Loan GuarantorsFOSA";
        Loans: Record "Loans Register";
        Members: Record "Member Register";
        vend: Record "Vendor Ledger Entry";
        CustN: Record "Member Register";
}

