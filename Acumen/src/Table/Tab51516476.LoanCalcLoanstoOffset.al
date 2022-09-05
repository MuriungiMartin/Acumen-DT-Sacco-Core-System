#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516476 "Loan Calc. Loans to Offset"
{
    DrillDownPageID = "Loan Offset Detail List";
    LookupPageID = "Loan Offset Detail List";

    fields
    {
        field(1; "Client Code"; Code[20])
        {
            TableRelation = "Loan Calculator"."Member No";
        }
        field(2; "Loan Top Up"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Client Code"),
                                                                Posted = const(true),
                                                                "Outstanding Balance" = filter(> 0));

            trigger OnValidate()
            begin

                if Confirm('Are you Sure you Want to bridge this loan?', true) = true then begin

                    "Loan Type" := '';
                    "Principle Top Up" := 0;
                    "Interest Top Up" := 0;
                    "Total Top Up" := 0;
                    Loantypes.Reset;
                    Loantypes.SetRange(Loantypes.Code, "Loan Type");


                    Loans.Reset;
                    Loans.SetRange(Loans."Loan  No.", "Loan Top Up");
                    if Loans.Find('-') then begin
                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due", Loans."Oustanding Interest");
                        "Loan Type" := Loans."Loan Product Type";
                        if Cust.Get(Loans."Client Code") then begin
                            "ID. NO" := Cust."ID No.";
                            "Staff No" := Cust."Personal No";
                        end;

                        "Principle Top Up" := Loans."Outstanding Balance";
                        "Interest Top Up" := Loans."Oustanding Interest";
                        "Total Top Up" := "Principle Top Up" + "Interest Top Up";
                        "Monthly Repayment" := Loans.Repayment;
                        GenSetUp.Get();
                        Commision := ROUND(("Principle Top Up" + "Interest Top Up") * (GenSetUp."Top up Commission" / 100), 1, '>');
                        "Total Top Up" := "Principle Top Up" + "Interest Top Up";//+Commision;
                    end;
                    Commision := ROUND(("Principle Top Up" + "Interest Top Up") * (GenSetUp."Top up Commission" / 100), 1, '>');

                    if Commision < 500 then begin
                        Commision := 500
                    end else begin
                        Commision := ROUND(("Principle Top Up" + "Interest Top Up") * (GenSetUp."Top up Commission" / 100), 1, '>');

                    end;


                    Loans.Bridged := true;
                    Loans.Modify
                end;
            end;
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
                        Error('Amount cannot be greater than the loan oustanding balance.');
                    // "Interest Top Up":="Principle Top Up"*(Loans.Interest/100);
                end;

                if "Principle Top Up" > Loans."Requested Amount" then
                    Error('Amount cannot be greater than the loan oustanding balance.');
                //"Interest Top Up":="Principle Top Up"*(Loans.Interest/100);
                //END;
                GenSetUp.Get();
                Commision := ROUND(("Principle Top Up" + "Interest Top Up") * (GenSetUp."Top up Commission" / 100), 1, '>');

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
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Customer No." = field("Client Code"),
                                                                  "Loan No" = field("Loan Top Up"),
                                                                  "Transaction Type" = filter("Insurance Contribution")));
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
    }

    keys
    {
        key(Key1; "Client Code", "Loan Top Up")
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
        fieldgroup(DropDown; "Loan Type", "Principle Top Up", "Interest Top Up", "Total Top Up", "Monthly Repayment", "Interest Paid", "Outstanding Balance", "Interest Rate", Commision)
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
}

