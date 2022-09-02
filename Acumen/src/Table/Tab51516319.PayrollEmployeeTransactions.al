#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516319 "Payroll Employee Transactions."
{

    fields
    {
        field(9;"Sacco Membership No.";Code[20])
        {
        }
        field(10;"No.";Code[20])
        {
        }
        field(11;"Transaction Code";Code[20])
        {

            trigger OnValidate()
            begin

                  PayrollTrans.Reset;
                 PayrollTrans.SetRange(PayrollTrans."Transaction Code","Transaction Code");
                 if PayrollTrans.FindFirst then begin
                  "Transaction Name":=PayrollTrans."Transaction Name";
                  "Transaction Type":=PayrollTrans."Transaction Type";

                 end;



                if HR.Get("Payroll Code") then begin
                Membership:=HR."Sacco Membership No.";
                end;




                if "Transaction Code"='010-023' then begin
                SCARD.Reset;
                SCARD.SetRange(SCARD."No.","No.");
                if SCARD.Find('-')then begin
                  if SCARD."Is Management" then
                    Amount:=ROUND(((SCARD."Basic Pay"*(25/100))),0.1,'<');
                end;
                end;

                if "Transaction Code"='010-009' then begin
                SCARD.Reset;
                SCARD.SetRange(SCARD."No.","No.");
                if SCARD.Find('-')then begin
                  if SCARD."Is Management" then
                    Amount:=(SCARD."Basic Pay"*(0.05)*12)
                  else
                    Amount:=(SCARD."Basic Pay"*(0.075)*12);


                end;
                end;

                if "Transaction Code"='D022' then begin
                SCARD.Reset;
                SCARD.SetRange(SCARD."No.","No.");
                if SCARD.Find('-')then begin
                Amount:=SCARD."Basic Pay"*(0.01);
                end;
                end;

                if "Transaction Code"='D001' then begin
                if MEMB.Get("No.") then begin
                MEMB.CalcFields(MEMB."Current Shares");
                Balance:= MEMB."Current Shares"*-1;

                end;
                end;
            end;
        }
        field(12;"Transaction Name";Text[100])
        {
            Editable = false;
        }
        field(13;"Transaction Type";Option)
        {
            OptionCaption = 'Income,Deduction';
            OptionMembers = Income,Deduction;
        }
        field(14;Amount;Decimal)
        {

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange(Employee."No.","No.");
                if Employee.FindFirst then begin
                  if Employee."Currency Code" = '' then
                    "Amount(LCY)" := Amount
                  else
                    "Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(Today,Employee."Currency Code",Amount,Employee."Currency Factor"));
                end;
            end;
        }
        field(15;"Amount(LCY)";Decimal)
        {
            Editable = false;
        }
        field(16;Balance;Decimal)
        {
        }
        field(17;"Balance(LCY)";Decimal)
        {
        }
        field(18;"Period Month";Integer)
        {
            Editable = false;
        }
        field(19;"Period Year";Integer)
        {
            Editable = false;
        }
        field(20;"Payroll Period";Date)
        {
            Editable = false;
            TableRelation = "Payroll Calender."."Date Opened";
        }
        field(21;"No of Repayments";Decimal)
        {
        }
        field(22;Membership;Code[20])
        {
        }
        field(23;"Reference No";Text[30])
        {
        }
        field(24;"Employer Amount";Decimal)
        {

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange(Employee."No.","No.");
                if Employee.FindFirst then begin
                  if Employee."Currency Code" = '' then
                    "Employer Amount(LCY)" := "Employer Amount"
                  else
                    "Employer Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(Today,Employee."Currency Code","Employer Amount",Employee."Currency Factor"));
                end;
            end;
        }
        field(25;"Employer Amount(LCY)";Decimal)
        {
            Editable = false;
        }
        field(26;"Employer Balance";Decimal)
        {
            Editable = false;
        }
        field(27;"Employer Balance(LCY)";Decimal)
        {
            Editable = false;
        }
        field(28;"Stop for Next Period";Boolean)
        {
        }
        field(29;"Amtzd Loan Repay Amt";Decimal)
        {

            trigger OnValidate()
            begin
                /*Employee.RESET;
                Employee.SETRANGE(Employee.Em,"No.");
                IF Employee.FINDFIRST THEN BEGIN
                  IF Employee."Currency Code" = '' THEN
                    "Amtzd Loan Repay Amt(LCY)" :="Amtzd Loan Repay Amt"
                  ELSE
                    "Amtzd Loan Repay Amt(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(TODAY,Employee."Currency Code","Amtzd Loan Repay Amt",Employee."Currency Factor"));
                END;
                */

            end;
        }
        field(30;"Amtzd Loan Repay Amt(LCY)";Decimal)
        {
        }
        field(31;"Start Date";Date)
        {
        }
        field(32;"End Date";Date)
        {
        }
        field(33;"Loan Number";Code[20])
        {
            TableRelation = "Loans Register"."Loan  No.";

            trigger OnValidate()
            begin

                if Loans.Get("Loan Number") then begin
                Loans.CalcFields(Loans."Outstanding Balance",Loans."Oustanding Interest");
                Balance:=Loans."Outstanding Balance";
                "Amtzd Loan Repay Amt":=Loans.Repayment;
                Amount:=Loans."Loan Principle Repayment";
                "Original Amount":=Loans."Approved Amount";
                "Interest Charged":=Loans."Oustanding Interest";
                "Outstanding Interest":=Loans."Oustanding Interest";
                "Loan Repayment Amount":=Loans."Loan Principle Repayment";
                //"Outstanding Interest":=Loans."Loan Interest Repayment";//Loans."Oustanding Interest";
                //MESSAGE('%1-%2-%3',Balance,"Amtzd Loan Repay Amt",Amount);
                Modify;
                end;
            end;
        }
        field(34;"Payroll Code";Code[20])
        {
        }
        field(35;"No of Units";Decimal)
        {
        }
        field(36;Suspended;Boolean)
        {
        }
        field(37;"Entry No";Integer)
        {
        }
        field(38;"IsCoop/LnRep";Boolean)
        {
        }
        field(39;Grants;Code[20])
        {
        }
        field(40;"Posting Group";Code[20])
        {
        }
        field(41;"Original Amount";Decimal)
        {
        }
        field(42;"Outstanding Interest";Decimal)
        {
        }
        field(43;"Member No";Code[20])
        {
        }
        field(44;"Loan Repayment Amount";Decimal)
        {
        }
        field(45;"Original Deduction Amount";Decimal)
        {

            trigger OnValidate()
            begin
                /*Amount:="Original Deduction Amount";
                Amount:="Original Deduction Amount"-"Outstanding Interest";
                "Interest Charged":="Outstanding Interest";//FnLoan("Loan Number","Payroll Period");
                "Amount(LCY)":=Amount;
                */

            end;
        }
        field(46;"Interest Charged";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"No.","Payroll Period","Transaction Code","Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
         PayrollCalender.Reset;
         PayrollCalender.SetRange(PayrollCalender.Closed,false);
         if PayrollCalender.FindFirst then begin
          "Period Month":=PayrollCalender."Period Month";
          "Period Year":=PayrollCalender."Period Year";
          "Payroll Period":=PayrollCalender."Date Opened";
         end;
    end;

    var
        Employee: Record "Payroll Employee.";
        CurrExchRate: Record "Currency Exchange Rate";
        PayrollCalender: Record "Payroll Calender.";
        PayrollTrans: Record "Payroll Transaction Code.";
        Loans: Record "Loans Register";
        HR: Record "Payroll Employee.";
        SCARD: Record "Payroll Employee.";
        MEMB: Record "Member Register";

    local procedure FnGetInterestRate(LoanProductCode: Code[40]) InterestRate: Decimal
    var
        ObjLoanProducts: Record "Loan Products Setup";
    begin
        ObjLoanProducts.Reset;
        ObjLoanProducts.SetRange(ObjLoanProducts.Code,LoanProductCode);
        if ObjLoanProducts.Find('-') then begin
          InterestRate:=ObjLoanProducts."Interest rate";
          end;
          exit(InterestRate);
    end;

    local procedure FnLoanInterestExempted(LoanNo: Code[50]) Found: Boolean
    var
        ObjExemptedLoans: Record "Loan Repay Schedule-Calc";
    begin
        ObjExemptedLoans.Reset;
        ObjExemptedLoans.SetRange(ObjExemptedLoans."Loan Category",LoanNo);
        if ObjExemptedLoans.Find('-') then begin
          Message('Found');
          Found:=true;
          end;
          exit(Found);
    end;


    procedure fnCalcLoanInterest(InterestRate: Decimal;RecoveryMethod: Option Reducing,"Straight line",Amortized;LoanAmount: Decimal;Balance: Decimal) LnInterest: Decimal
    var
        curLoanInt: Decimal;
        intMonth: Integer;
        intYear: Integer;
    begin
        curLoanInt := 0;
        if InterestRate > 0 then begin
            if RecoveryMethod = Recoverymethod::"Straight line" then
                 curLoanInt := (InterestRate / 1200) * LoanAmount;

            if RecoveryMethod = Recoverymethod::Reducing then

                 curLoanInt := (InterestRate / 1200) * Balance;

            if RecoveryMethod = Recoverymethod::Amortized then
                 curLoanInt := (InterestRate / 1200) * Balance;
        end else
            curLoanInt := 0;
        LnInterest:=ROUND(curLoanInt,1);
    end;

    local procedure FnLoan(LoanNo: Code[50];PayrollPeriod: Date) Interest: Decimal
    var
        ObjLoans: Record "Loans Register";
        FilterDate: Text[100];
    begin
        FilterDate:='..'+Format(PayrollPeriod);
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.",LoanNo);
        ObjLoans.SetFilter(ObjLoans."Date filter",FilterDate);
        if ObjLoans.Find('-') then begin
          ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
          ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
          if not FnLoanInterestExempted(LoanNo) then begin

          //MESSAGE('%1 %2 %3 %4',FnGetInterestRate(ObjLoans."Loan Product Type"),FORMAT(ObjLoans."Repayment Method"),ObjLoans."Approved Amount",ObjLoans."Outstanding Balance");
          //Interest:=fnCalcLoanInterest(FnGetInterestRate(ObjLoans."Loan Product Type"),ObjLoans."Repayment Method",ObjLoans."Approved Amount",ObjLoans."Outstanding Balance");
          //"Interest Charged":=ObjLoans."Oustanding Interest";//Interest;
          end;
          end;
          exit(Interest);
    end;
}

