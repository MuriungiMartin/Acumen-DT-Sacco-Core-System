#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516896 "Micro_Fin_Schedule"
{

    fields
    {
        field(1; "No."; Code[10])
        {
            Editable = false;
        }
        field(2; "Transction Type"; Option)
        {
            Enabled = false;
            OptionCaption = 'Savings,Repayment,Interest Paid,Registration Paid,Insurance ,Penalty';
            OptionMembers = Savings,Repayment,"Interest Paid","Registration Paid","Insurance ",Penalty;

            trigger OnValidate()
            begin
                //IF "Transction Type"="Transction Type"::Savings THEN

                //Savings,Repayment,Interest Paid
            end;
        }
        field(3; "Account Type"; Option)
        {
            Enabled = false;
            OptionCaption = 'Customer,Vendor,G/L Account';
            OptionMembers = Customer,Vendor,"G/L Account";
        }
        field(4; "Account Number"; Code[20])
        {
            TableRelation = Customer where("Customer Posting Group" = filter('MICRO'));

            trigger OnValidate()
            begin
                Member.Reset;
                Member.SetRange(Member."No.", "Account Number");
                if Member.Find('-') then begin
                    "Account Name" := Member.Name;
                    "Group Code" := Member."Group Account No";
                    Savings := Member."Monthly Contribution";
                end;
            end;
        }
        field(5; "Account Name"; Text[150])
        {
        }
        field(6; Amount; Decimal)
        {

            trigger OnValidate()
            begin

                RunningBAL := 0;
                RunningBAL := Amount;

                "Interest Amount" := 0;
                "Principle Amount" := 0;
                "Excess Amount" := 0;

                Trans.Reset;
                Trans.SetRange(Trans."No.", "No.");
                if Trans.Find('-') then begin

                    if "Expected Penalty Charge" > 0 then begin
                        if RunningBAL > 0 then begin
                            if RunningBAL > "Expected Penalty Charge" then
                                "Penalty Amount" := "Expected Penalty Charge"
                            else
                                "Penalty Amount" := RunningBAL;
                        end;
                        RunningBAL := RunningBAL - "Penalty Amount";
                    end;

                    if "Expected Interest" > 0 then begin
                        if RunningBAL > 0 then begin
                            if RunningBAL > "Expected Interest" then
                                "Interest Amount" := "Expected Interest"
                            else
                                "Interest Amount" := RunningBAL;
                        end;
                        RunningBAL := RunningBAL - "Interest Amount";
                    end;


                    if "Expected Principle Amount" > 0 then begin
                        if RunningBAL > 0 then begin
                            if RunningBAL > "Expected Principle Amount" then
                                "Principle Amount" := "Expected Principle Amount"
                            else
                                "Principle Amount" := RunningBAL;
                        end;
                        RunningBAL := RunningBAL - "Principle Amount";
                        if RunningBAL > 0 then
                            "Excess Amount" := RunningBAL;
                    end;
                end;
            end;
        }
        field(7; "Loan No."; Code[20])
        {
            TableRelation = "Loans Register" where(Posted = const(true),
                                                    "Outstanding Balance" = filter(<> 0),
                                                    Source = filter(FOSA),
                                                    "Client Code" = field("Account Number"));

            trigger OnValidate()
            begin

                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Loan  No.", "Loan No.");
                if LoanApp.Find('-') then begin
                    //"Expected Interest":=LoanApp.Lint;
                end;
            end;
        }
        field(8; "G/L Account"; Code[20])
        {
            Enabled = false;
            TableRelation = "G/L Account"."No.";
        }
        field(9; "Group Code"; Code[20])
        {
        }
        field(90000; "Expected Principle Amount"; Decimal)
        {
            Editable = false;
        }
        field(51516001; "Expected Interest"; Decimal)
        {
            Editable = false;
        }
        field(51516002; Savings; Decimal)
        {

            trigger OnValidate()
            begin


                GenlSetUp.Get();
                if Savings < GenlSetUp."Min. Contribution Bus Loan" then
                    Error(Text001, GenlSetUp."Min. Contribution Bus Loan");


                "Interest Amount" := 0;
                "Principle Amount" := 0;
                //Savings:=0;

                RunningBAL := 0;
                RunningBAL := Amount - Savings * -1;
                if "Expected MF Insurance" > 0 then begin
                    if RunningBAL > 0 then begin
                        if RunningBAL > "Expected MF Insurance" then
                            "MF Insurance Amount" := "Expected MF Insurance"
                        else
                            "MF Insurance Amount" := RunningBAL;
                    end;
                    RunningBAL := RunningBAL - "MF Insurance Amount";
                end;
                if "Expected Appraisal" > 0 then begin
                    if RunningBAL > 0 then begin
                        if RunningBAL > "Expected Appraisal" then
                            "Appraisal Amount" := "Expected Appraisal"
                        else
                            "Appraisal Amount" := RunningBAL;
                    end;
                    RunningBAL := RunningBAL - "Appraisal Amount";
                end;

                if "Expected Penalty Charge" > 0 then begin
                    if RunningBAL > 0 then begin
                        if RunningBAL > "Expected Penalty Charge" then
                            "Penalty Amount" := "Expected Penalty Charge"
                        else
                            "Penalty Amount" := RunningBAL;
                    end;
                    RunningBAL := RunningBAL - "Penalty Amount";
                end;

                if "Expected Interest" > 0 then begin
                    if RunningBAL > 0 then begin
                        if RunningBAL > "Expected Interest" then
                            "Interest Amount" := "Expected Interest"
                        else
                            "Interest Amount" := RunningBAL;
                    end;
                    RunningBAL := RunningBAL - "Interest Amount";
                end;


                if "Expected Principle Amount" > 0 then begin
                    if RunningBAL > 0 then begin
                        "Principle Amount" := RunningBAL
                    end;
                end;

                if RunningBAL > 0 then
                    OutBal := RunningBAL;
            end;
        }
        field(51516003; "Interest Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Interest Amount" > "Expected Interest" then
                    Error('Amount cannot be more than the interest amount');
            end;
        }
        field(51516004; "Principle Amount"; Decimal)
        {

            trigger OnValidate()
            begin

                if "Principle Amount" > "Outstanding Balance" then begin
                    "Principle Amount" := "Outstanding Balance";
                end else
                    "Principle Amount" := "Principle Amount";

                if "Principle Amount" > "Outstanding Balance" then
                    Error('Amount cannot be more than the oustanding balance');
            end;
        }
        field(51516005; "Expected Penalty Charge"; Decimal)
        {
        }
        field(51516006; "Penalty Amount"; Decimal)
        {
        }
        field(51516007; "Expected MF Insurance"; Decimal)
        {
        }
        field(51516008; "MF Insurance Amount"; Decimal)
        {
        }
        field(51516009; "Expected Appraisal"; Decimal)
        {
        }
        field(51516010; "Appraisal Amount"; Decimal)
        {
        }
        field(51516011; "Branch Code"; Code[20])
        {
        }
        field(51516012; "Loan Application Fee"; Decimal)
        {
        }
        field(51516013; "Registration Fee"; Decimal)
        {
        }
        field(51516014; "Loan Insurance Fee"; Decimal)
        {
        }
        field(51516015; "Printing_Stationary Fee"; Decimal)
        {
        }
        field(51516016; "Outstanding Balance"; Decimal)
        {
            Editable = false;
        }
        field(51516017; "Loans No."; Code[50])
        {
            TableRelation = "Loans Register"."Loan  No." where(Posted = const(true),
                                                                "Outstanding Balance" = filter(<> 0),
                                                                Source = const(MICRO),
                                                                "Client Code" = field("Account Number"));

            trigger OnValidate()
            begin


                GetLoans.Reset;
                GetLoans.SetRange(GetLoans."Loan  No.", "Loans No.");
                GetLoans.SetRange(GetLoans.Posted, true);
                if GetLoans.Find('-') then
                    GetLoans.CalcFields(GetLoans."Outstanding Balance", GetLoans."Interest Due", GetLoans."Oustanding Interest");
                "Expected Principle Amount" := GetLoans."Loan Principle Repayment";
                if GetLoans."Oustanding Interest" > 0 then begin
                    "Expected Interest" := GetLoans."Oustanding Interest";
                    "Interest Amount" := GetLoans."Oustanding Interest";
                end else
                    "Expected Interest" := 0;
                "Interest Amount" := 0;

                if GetLoans."Loan Principle Repayment" > GetLoans."Outstanding Balance" then begin
                    "Principle Amount" := GetLoans."Outstanding Balance";
                end else
                    "Principle Amount" := GetLoans."Loan Principle Repayment";

                if GetLoans."Outstanding Balance" > 0 then begin
                    if (GetLoans."Outstanding Balance" < GetLoans."Loan Principle Repayment") then
                        "Outstanding Balance" := GetLoans."Outstanding Balance"

                    else
                        "Outstanding Balance" := GetLoans."Loan Principle Repayment"

                end;
            end;
        }
        field(51516018; OutBal; Decimal)
        {
            Editable = false;
        }
        field(51516019; "Deposits Contribution"; Decimal)
        {
        }
        field(51516020; "Amount Received"; Decimal)
        {
        }
        field(51516021; "Excess Amount"; Decimal)
        {
        }
        field(51516022; "Share Capital"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Account Number")
        {
            Clustered = true;
            SumIndexFields = Amount, Savings;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Trans.Reset;
        if Trans.Get("No.") then
            if Trans.Posted = true then
                Error('Cannot delete a posted transaction');
    end;

    trigger OnInsert()
    begin
        Trans.Reset;
        if Trans.Get("No.") then
            if Trans.Posted = true then
                Error('Cannot modify a posted transaction');
    end;

    trigger OnModify()
    begin
        Trans.Reset;
        if Trans.Get("No.") then
            if Trans.Posted = true then
                Error('Cannot modify a posted transaction');
    end;

    trigger OnRename()
    begin
        Trans.Reset;
        if Trans.Get("No.") then
            if Trans.Posted = true then
                Error('Cannot modify a posted transaction');
    end;

    var
        Vend: Record Vendor;
        GL: Record "G/L Account";
        RunningBAL: Decimal;
        LoanApp: Record "Loans Register";
        Trans: Record Micro_Fin_Transactions;
        Member: Record Customer;
        GetLoans: Record "Loans Register";
        GenlSetUp: Record "Sacco General Set-Up";
        Text001: label 'Monthly contribution cannot be less than minimum contributions of  Kshs%1';
}

