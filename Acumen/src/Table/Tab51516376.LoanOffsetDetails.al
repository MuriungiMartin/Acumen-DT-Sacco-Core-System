#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516376 "Loan Offset Details"
{
    DrillDownPageID = "Loan Offset Detail List";
    LookupPageID = "Loan Offset Detail List";

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(2; "Loan Top Up"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Client Code"),
                                                                Posted = const(true),
                                                                "Outstanding Balance" = filter(> 0));

            trigger OnValidate()
            begin
                if Confirm('Are you Sure you Want to bridge this loan?', true) = true then begin

                    ObjLoans.Reset;
                    ObjLoans.SetRange(ObjLoans."Loan  No.", "Loan Top Up");
                    if ObjLoans.FindSet then begin
                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            MinAmountforOffset := (ObjLoans."Approved Amount" * (ObjLoanType."Allowable Loan Offset(%)" / 100));

                            if ObjLoans.Get("Loan Top Up") then begin
                                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                                LoanBal := ObjLoans."Outstanding Balance";
                            end;
                            //    IF LoanBal>MinAmountforOffset THEN BEGIN
                            //      MESSAGE('LoanBal is %1',LoanBal);
                            //      MESSAGE('MinAmountforOffset is %1',MinAmountforOffset);
                            //      MESSAGE('The Loan has not meet the minimum requirement to be offset Loan Balance=%1:50% of the Initial Loan=%2',LoanBal,MinAmountforOffset);
                            //      ERROR('The Loan has not meet the minimum requirement to be offset');
                            //      END;
                        end;
                    end;




                    "Loan Type" := '';
                    "Principle Top Up" := 0;
                    "Interest Top Up" := 0;
                    "Total Top Up" := 0;

                    ObjRepaymentSchedule.Reset;
                    ObjRepaymentSchedule.SetRange("Loan No.", "Loan Top Up");
                    ObjRepaymentSchedule.SetFilter("Repayment Date", '>%1', Today);
                    if ObjRepaymentSchedule.Find('-') then
                        "Remaining Installments" := ObjRepaymentSchedule.Count;

                    ObjRepaymentSchedule.Reset;
                    ObjRepaymentSchedule.SetRange("Loan No.", "Loan Top Up");
                    ObjRepaymentSchedule.SetFilter("Repayment Date", '<=%1', Today);
                    if ObjRepaymentSchedule.Find('-') then
                        "Loan Age" := ObjRepaymentSchedule.Count;

                    Loans.Reset;
                    Loans.SetRange(Loans."Loan  No.", "Loan No.");
                    if Loans.Find('-') then
                        ApplicationDate := Loans."Application Date";

                    Loans.Reset;
                    Loans.SetRange(Loans."Loan  No.", "Loan Top Up");
                    if Loans.Find('-') then begin
                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due", Loans."Oustanding Interest");
                        "Loan Type" := Loans."Loan Product Type";
                        Loantypes.Reset;
                        Loantypes.SetRange(Loantypes.Code, "Loan Type");
                        if Loantypes.Find('-') then begin
                            Commision := Loantypes."Top Up Commision" * Loans."Outstanding Balance" / 100;
                        end;
                        if Cust.Get(Loans."Client Code") then begin
                            "ID. NO" := Cust."ID No.";
                            "Staff No" := Cust."Personal No";
                        end;
                        "Interest Rate" := Loans.Interest;

                        "Interest Due at Clearance" := ((0.01 * Loans."Approved Amount" + 0.01 * Loans."Outstanding Balance") * Loans.Interest / 12 * ("Loan Age")) / 2 - "Interest Paid";
                        "Interest Top Up" := ((0.01 * Loans."Approved Amount" + 0.01 * Loans."Outstanding Balance") * Loans.Interest / 12 * ("Loan Age" + 1)) / 2 - "Interest Paid"; //Nafaka Formula
                        if (Date2dmy(ApplicationDate, 1) > 15) then begin
                            "Interest Due at Clearance" := ((0.01 * Loans."Approved Amount" + 0.01 * Loans."Outstanding Balance") * Loans.Interest / 12 * ("Loan Age" + 1)) / 2 - "Interest Paid";
                            "Interest Top Up" := ((0.01 * Loans."Approved Amount" + 0.01 * Loans."Outstanding Balance") * Loans.Interest / 12 * ("Loan Age" + 1)) / 2 - "Interest Paid"; //Nafaka Formula
                        end;
                        "Principle Top Up" := Loans."Outstanding Balance";
                        "Interest Top Up" := Loans."Oustanding Interest";
                        Commision := Loans."Outstanding Balance" * 0.1;
                        "Total Top Up" := "Principle Top Up" + "Interest Top Up" + Commision;
                        "Outstanding Balance" := Loans."Outstanding Balance";
                        "Monthly Repayment" := Loans.Repayment;
                    end;
                    Loans.Bridged := true;
                    Loans.Modify
                end;

                if Loans.Get("Loan No.") then begin
                    if "Total Top Up" > Loans."Requested Amount" then
                        Error('You Can not offset more than the requested loan amount');
                end;
            end;
        }
        field(3; "Client Code"; Code[20])
        {
        }
        field(4; "Loan Type"; Code[20])
        {
        }
        field(5; "Principle Top Up"; Decimal)
        {

            trigger OnValidate()
            begin
                //IF Loantypes.GET("Loan Type") THEN BEGIN
                //"Interest Top Up":="Principle Top Up"*(Loantypes."Interest rate"/100);
                //END;

                //"Interest Top Up":="Principle Top Up"*(1.75/100);


                Loans.Reset;
                Loans.SetRange(Loans."Loan  No.", "Loan Top Up");
                if Loans.Find('-') then begin
                    Loans.CalcFields(Loans."Outstanding Balance");
                    if "Principle Top Up" > Loans."Outstanding Balance" then
                        Error(Text00, "Loan Top Up");
                    // "Interest Top Up":="Principle Top Up"*(Loans.Interest/100);
                end;

                if "Principle Top Up" > Loans."Requested Amount" then
                    Error(Text001, "Loan No.");
                //"Interest Top Up":="Principle Top Up"*(Loans.Interest/100);
                //END;


                if Commision < 500 then begin
                    Commision := 500
                end else begin
                    Commision := ROUND(("Principle Top Up" + "Interest Top Up") * (GenSetUp."Top up Commission" / 100), 1, '>');

                end;
                "Total Top Up" := "Principle Top Up" + "Interest Top Up";//+Commision;


                "Total Top Up" := "Principle Top Up" + "Interest Top Up";
            end;
        }
        field(6; "Interest Top Up"; Decimal)
        {

            trigger OnValidate()
            begin
                /*"Total Top Up":="Principle Top Up" +"Interest Top Up"+Commision;
                
                Loans.RESET;
                Loans.SETRANGE(Loans."Loan  No.","Loan Top Up");
                IF Loans.FIND('-') THEN BEGIN
                Loans.CALCFIELDS(Loans."Interest Due");
                IF "Principle Top Up" < Loans."Outstanding Balance" THEN
                ERROR('Amount cannot be greater than the interest due.');
                
                END;
                */
                GenSetUp.Get();
                Commision := ROUND(("Principle Top Up" + "Interest Top Up") * (GenSetUp."Top up Commission" / 100), 1, '>');
                "Total Top Up" := "Principle Top Up" + "Interest Top Up";//+Commision;
                Commision := ROUND(("Principle Top Up" + "Interest Top Up") * (GenSetUp."Top up Commission" / 100), 1, '>');

                if Commision < 500 then begin
                    Commision := 500
                end else begin
                    Commision := ROUND(("Principle Top Up" + "Interest Top Up") * (GenSetUp."Top up Commission" / 100), 1, '>');

                end;
                Commision := Loans."Outstanding Balance" * 0.1;

            end;
        }
        field(7; "Total Top Up"; Decimal)
        {
        }
        field(8; "Monthly Repayment"; Decimal)
        {
        }
        field(9; "Interest Paid"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("Client Code"),
                                                                   "Loan No" = field("Loan Top Up"),
                                                                   "Transaction Type" = filter("Interest Paid")));
            FieldClass = FlowField;
        }
        field(10; "Outstanding Balance"; Decimal)
        {
            FieldClass = Normal;
        }
        field(11; "Interest Rate"; Decimal)
        {
            CalcFormula = sum("Loans Register".Interest where("Loan  No." = field("Loan Top Up"),
                                                               "Client Code" = field("Client Code")));
            FieldClass = FlowField;
        }
        field(12; "ID. NO"; Code[20])
        {
        }
        field(13; Commision; Decimal)
        {

            trigger OnValidate()
            begin
                "Total Top Up" := "Principle Top Up" + "Interest Top Up" + Commision;
            end;
        }
        field(14; "Partial Bridged"; Boolean)
        {

            trigger OnValidate()
            begin

                LoansTop.Reset;
                LoansTop.SetRange(LoansTop."Loan  No.", "Loan Top Up");
                if LoansTop.Find('-') then begin
                    if "Partial Bridged" = true then
                        LoansTop."partially Bridged" := true;
                    LoansTop.Modify;
                end;
            end;
        }
        field(15; "Remaining Installments"; Decimal)
        {
        }
        field(16; "Finale Instalment"; Decimal)
        {
        }
        field(17; "Penalty Charged"; Decimal)
        {
        }
        field(18; "Staff No"; Code[20])
        {
        }
        field(19; "Commissioning Balance"; Decimal)
        {

            trigger OnValidate()
            begin
                GenSetUp.Get();
                Commision := ROUND(("Commissioning Balance") * (GenSetUp."Top up Commission" / 100), 1, '>');
                "Total Top Up" := "Principle Top Up" + "Interest Top Up" + Commision;
            end;
        }
        field(20; "Interest Due at Clearance"; Decimal)
        {
        }
        field(21; "Loan Age"; Integer)
        {
        }
        field(22; "BOSA No"; Code[50])
        {
        }
        field(23; "50% of Initial Loan"; Decimal)
        {
        }
        field(24; "FOSA Account"; Code[30])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Client Code"));
        }
        field(25; "Loan Offset From FOSA"; Boolean)
        {
        }
        field(26; "Loan Offset From FOSA Date"; Date)
        {
        }
        field(27; "Loan Offset From FOSA By"; Code[30])
        {
        }
        field(28; "Additional Top Up Commission"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Client Code", "Loan Top Up")
        {
            Clustered = true;
            SumIndexFields = "Total Top Up", "Principle Top Up";
        }
        key(Key2; "Principle Top Up")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Client Code", "Loan Type", "Principle Top Up", "Interest Top Up", "Total Top Up", "Monthly Repayment", "Interest Paid", "Outstanding Balance", "Interest Rate", Commision)
        {
        }
    }

    var
        Loans: Record "Loans Register";
        Loantypes: Record "Loan Products Setup";
        Interest: Decimal;
        Cust: Record "Member Register";
        LoansTop: Record "Loans Register";
        GenSetUp: Record "Sacco General Set-Up";
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        ApplicationDate: Date;
        ObjLoans: Record "Loans Register";
        ObjLoanType: Record "Loan Products Setup";
        MinAmountforOffset: Decimal;
        LoanBal: Decimal;
        Text00: label 'Amount cannot be greater than the loan oustanding balance for%1.';
        Text001: label 'Amount cannot be greater than the loan oustanding balance for %1';
}

