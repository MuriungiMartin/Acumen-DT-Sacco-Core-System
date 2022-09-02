#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516380 "Loan Calculator"
{
    DrillDownPageID = UnknownPage50025;
    LookupPageID = UnknownPage50025;

    fields
    {
        field(2;"Loan Product Type";Code[20])
        {
            TableRelation = "Loan Products Setup".Code;

            trigger OnValidate()
            begin
                 LoanType.Reset;
                 LoanType.SetRange(LoanType.Code,"Loan Product Type");
                if LoanType.Find('-') then begin
                "Interest rate":=LoanType."Interest rate";
                "Repayment Method":=LoanType."Repayment Method";
                "Product Description":=LoanType."Product Description";
                Installments:=LoanType."No of Installment";
                //"Administration Fee":=LoanType."Administration Fee";
                "Instalment Period":=LoanType."Instalment Period";
                "Qualification As Per Deposit":=("Current Deposits"*LoanType."Shares Multiplier")-"Total Loans Outstanding";
                "Repayment Frequency":="repayment frequency"::Monthly;

                end;
            end;
        }
        field(3;Installments;Integer)
        {

            trigger OnValidate()
            begin

                TotalMRepay:=0;
                LPrincipal:=0;
                LInterest:=0;
                InterestRate:="Interest rate";
                LoanAmount:="Requested Amount";
                RepayPeriod:=Installments;
                LBalance:="Requested Amount";





                //Repayments for amortised method
                if "Repayment Method"="repayment method"::Amortised then begin
                TestField("Interest rate");
                TestField(Installments);
                TotalMRepay:=ROUND((InterestRate/12/100) / (1 - Power((1 + (InterestRate/12/100)),- RepayPeriod)) * LoanAmount,0.05,'>');
                LInterest:=ROUND(LBalance / 100 / 12 * InterestRate,0.05,'>');
                LPrincipal:=TotalMRepay-LInterest;
                Repayment:=TotalMRepay;
                "Principle Repayment":=LPrincipal;
                "Interest Repayment":=LInterest;
                 "Total Monthly Repayment":= "Principle Repayment"+"Interest Repayment"+"Administration Fee";
                 "Average Repayment":="Total Monthly Repayment"*RepayPeriod/RepayPeriod;

                end;
                //End Repayments for amortised method


                //Repayments for Straight line method

                if "Repayment Method"="repayment method"::"Straight Line" then begin
                TestField("Interest rate");
                TestField(Installments);
                LPrincipal:=ROUND(LoanAmount/RepayPeriod,0.05,'>');
                LInterest:=ROUND((InterestRate/12/100)*LoanAmount,0.05,'>');
                //Grace Period Interest
                //LInterest:=ROUND((LInterest*InitialInstal)/(InitialInstal-InitialGraceInt),0.05,'>');
                Repayment:=LPrincipal+LInterest;
                "Principle Repayment":=LPrincipal;
                "Interest Repayment":=LInterest;
                 "Total Monthly Repayment":= "Principle Repayment"+"Interest Repayment"+"Administration Fee";
                 "Average Repayment":="Total Monthly Repayment"*RepayPeriod/RepayPeriod;

                end;

                //End Repayments for Straight Line method


                //Repayments for reducing balance method
                if "Repayment Method"="repayment method"::"Reducing Balance" then begin
                TestField("Interest rate");
                TestField(Installments);
                LPrincipal:=ROUND(LoanAmount/RepayPeriod,0.05,'>');
                LInterest:=ROUND((InterestRate/12/100)*LBalance,0.05,'>');
                Repayment:=LPrincipal+LInterest;
                "Principle Repayment":=LPrincipal;
                "Interest Repayment":=LInterest;
                "Total Monthly Repayment":= "Principle Repayment"+"Interest Repayment"+"Administration Fee";
                "Average Repayment":="Total Monthly Repayment"*RepayPeriod/RepayPeriod;
                //MESSAGE('%1',RepayPeriod);
                end;
            end;
        }
        field(4;"Principle Repayment";Decimal)
        {
        }
        field(5;"Interest Repayment";Decimal)
        {
        }
        field(6;"Total Monthly Repayment";Decimal)
        {
        }
        field(7;"Product Description";Text[30])
        {
        }
        field(8;"Interest rate";Decimal)
        {
        }
        field(9;"Repayment Method";Option)
        {
            OptionMembers = Amortised,"Reducing Balance","Straight Line",Constants;

            trigger OnValidate()
            begin

                TotalMRepay:=0;
                LPrincipal:=0;
                LInterest:=0;
                InterestRate:="Interest rate";
                LoanAmount:="Requested Amount";
                RepayPeriod:=Installments;
                LBalance:="Requested Amount";





                //Repayments for amortised method
                if "Repayment Method"="repayment method"::Amortised then begin
                TestField("Interest rate");
                TestField(Installments);
                TotalMRepay:=ROUND((InterestRate/12/100) / (1 - Power((1 + (InterestRate/12/100)),- RepayPeriod)) * LoanAmount,0.05,'>');
                LInterest:=ROUND(LBalance / 100 / 12 * InterestRate,0.05,'>');
                LPrincipal:=TotalMRepay-LInterest;
                Repayment:=TotalMRepay;
                "Principle Repayment":=LPrincipal;
                "Interest Repayment":=LInterest;
                 "Total Monthly Repayment":= "Principle Repayment"+"Interest Repayment"+"Administration Fee";
                 "Average Repayment":="Total Monthly Repayment"*RepayPeriod/RepayPeriod;

                end;
                //End Repayments for amortised method


                //Repayments for Straight line method

                if "Repayment Method"="repayment method"::"Straight Line" then begin
                TestField("Interest rate");
                TestField(Installments);
                LPrincipal:=ROUND(LoanAmount/RepayPeriod,0.05,'>');
                LInterest:=ROUND((InterestRate/12/100)*LoanAmount,0.05,'>');
                //Grace Period Interest
                //LInterest:=ROUND((LInterest*InitialInstal)/(InitialInstal-InitialGraceInt),0.05,'>');
                Repayment:=LPrincipal+LInterest;
                "Principle Repayment":=LPrincipal;
                "Interest Repayment":=LInterest;
                 "Total Monthly Repayment":= "Principle Repayment"+"Interest Repayment"+"Administration Fee";
                 "Average Repayment":="Total Monthly Repayment"*RepayPeriod/RepayPeriod;

                end;

                //End Repayments for Straight Line method


                //Repayments for reducing balance method
                if "Repayment Method"="repayment method"::"Reducing Balance" then begin
                TestField("Interest rate");
                TestField(Installments);
                LPrincipal:=ROUND(LoanAmount/RepayPeriod,0.05,'>');
                LInterest:=ROUND((InterestRate/12/100)*LBalance,0.05,'>');
                Repayment:=LPrincipal+LInterest;
                "Principle Repayment":=LPrincipal;
                "Interest Repayment":=LInterest;
                "Total Monthly Repayment":= "Principle Repayment"+"Interest Repayment"+"Administration Fee";
                "Average Repayment":="Total Monthly Repayment"*RepayPeriod/RepayPeriod;
                //MESSAGE('%1',RepayPeriod);
                end;
            end;
        }
        field(10;"Requested Amount";Decimal)
        {

            trigger OnValidate()
            begin

                TotalMRepay:=0;
                LPrincipal:=0;
                LInterest:=0;
                InterestRate:="Interest rate";
                LoanAmount:="Requested Amount";
                RepayPeriod:=Installments;
                LBalance:="Requested Amount";





                //Repayments for amortised method
                if "Repayment Method"="repayment method"::Amortised then begin
                TestField("Interest rate");
                TestField(Installments);
                TotalMRepay:=ROUND((InterestRate/12/100) / (1 - Power((1 + (InterestRate/12/100)),- RepayPeriod)) * LoanAmount,0.05,'>');
                LInterest:=ROUND(LBalance / 100 / 12 * InterestRate,0.05,'>');
                LPrincipal:=TotalMRepay-LInterest;
                Repayment:=TotalMRepay;
                "Principle Repayment":=LPrincipal;
                "Interest Repayment":=LInterest;
                 "Total Monthly Repayment":= "Principle Repayment"+"Interest Repayment"+"Administration Fee";
                 "Average Repayment":="Total Monthly Repayment"*RepayPeriod/RepayPeriod;

                end;
                //End Repayments for amortised method


                //Repayments for Straight line method

                if "Repayment Method"="repayment method"::"Straight Line" then begin
                TestField("Interest rate");
                TestField(Installments);
                LPrincipal:=ROUND(LoanAmount/RepayPeriod,0.05,'>');
                LInterest:=ROUND((InterestRate/12/100)*LoanAmount,0.05,'>');
                //Grace Period Interest
                //LInterest:=ROUND((LInterest*InitialInstal)/(InitialInstal-InitialGraceInt),0.05,'>');
                Repayment:=LPrincipal+LInterest;
                "Principle Repayment":=LPrincipal;
                "Interest Repayment":=LInterest;
                 "Total Monthly Repayment":= "Principle Repayment"+"Interest Repayment"+"Administration Fee";
                 "Average Repayment":="Total Monthly Repayment"*RepayPeriod/RepayPeriod;

                end;

                //End Repayments for Straight Line method


                //Repayments for reducing balance method
                if "Repayment Method"="repayment method"::"Reducing Balance" then begin
                TestField("Interest rate");
                TestField(Installments);
                LPrincipal:=ROUND(LoanAmount/RepayPeriod,0.05,'>');
                LInterest:=ROUND((InterestRate/12/100)*LBalance,0.05,'>');
                Repayment:=LPrincipal+LInterest;
                "Principle Repayment":=LPrincipal;
                "Interest Repayment":=LInterest;
                "Total Monthly Repayment":= "Principle Repayment"+"Interest Repayment"+"Administration Fee";
                "Average Repayment":="Total Monthly Repayment"*RepayPeriod/RepayPeriod;
                //MESSAGE('%1',RepayPeriod);
                end;

                if "Loan Calculator Type"="loan calculator type"::"Member Specific" then begin
                //Qualification As Per Salary
                Psalary:="2/3rds"-"Total Deduction";

                Msalary:=ROUND((Psalary*"Requested Amount")/Repayment,100,'<');
                if  (Psalary>Repayment) or  (Psalary=Repayment) then
                Msalary:="Requested Amount"
                else
                //Msalary:=ROUND((salary*100*Installments)/(100+Installments),100,'<');
                Msalary:=ROUND((Psalary*"Requested Amount")/Repayment,100,'<');
                "Qualification As Per Salary":=Msalary;
                // End Qualification As Per Salary

                //Qualification As Per Deposits
                LoanType.Reset;
                 LoanType.SetRange(LoanType.Code,"Loan Product Type");
                if LoanType.Find('-') then begin
                "Qualification As Per Deposit":=("Current Deposits"*LoanType."Deposits Multiplier")-("Total Loans Outstanding"-"Total Loans To Offset");
                  if "Qualification As Per Deposit">"Requested Amount"then
                  "Qualification As Per Deposit":="Requested Amount"
                  else
                  "Qualification As Per Deposit":="Qualification As Per Deposit"
                end;
                  "Deficit on Deposit":=("Requested Amount"-"Qualification As Per Deposit")/LoanType."Shares Multiplier";
                //End Qualification As Per Deposits

                if "Qualification As Per Deposit"<"Qualification As Per Salary" then
                  "Eligible Amount":="Qualification As Per Deposit"
                else
                if "Qualification As Per Salary"<"Qualification As Per Deposit" then
                  "Eligible Amount":="Qualification As Per Salary"
                end;
            end;
        }
        field(11;"Administration Fee";Decimal)
        {
        }
        field(12;Repayment;Decimal)
        {
        }
        field(13;"Average Repayment";Decimal)
        {
        }
        field(14;"Repayment Start Date";Date)
        {
        }
        field(15;"Instalment Period";DateFormula)
        {
        }
        field(16;"Grace Period - Principle (M)";Integer)
        {
        }
        field(17;"Grace Period - Interest (M)";Integer)
        {
        }
        field(18;"Eligible Amount";Decimal)
        {
        }
        field(19;"Princible Repayment 2";Decimal)
        {
        }
        field(20;"Interest Repayment 2";Decimal)
        {
        }
        field(21;"Total Monthly Repayment 2";Decimal)
        {
        }
        field(22;"Total Outstanding Bosa Loans";Decimal)
        {
        }
        field(23;"Member No";Code[20])
        {
            TableRelation = "Member Register";

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.","Member No");
                
                if Cust.Find('-') then begin
                Cust.CalcFields(Cust."Outstanding Balance",Cust."Current Savings");
                "Total Loans Outstanding":=Cust."Outstanding Balance";
                "Member Name":=Cust.Name;
                "Current Deposits":=Cust."Current Savings";
                
                end;
                Modify;
                 /*
                Cust.CALCFIELDS(Cust."Outstanding Balance");
                IF Cust.GET("Member No")  THEN BEGIN
                "Total Loans Outstanding":=Cust."Outstanding Balance";
                END;*/
                Message('"Total Loans Outstanding" IS %1',"Total Loans Outstanding");

            end;
        }
        field(24;"Total Loans Outstanding";Decimal)
        {
        }
        field(25;"Member Name";Text[50])
        {
        }
        field(26;"Current Deposits";Decimal)
        {
        }
        field(27;"Net Pay";Decimal)
        {
        }
        field(28;"Qualification As Per Deposit";Decimal)
        {
        }
        field(29;"Qualification As Per Salary";Decimal)
        {
        }
        field(30;"Total Loans To Offset";Decimal)
        {
            CalcFormula = sum("Loan Calc. Loans to Offset"."Total Top Up" where ("Client Code"=field("Member No")));
            FieldClass = FlowField;
        }
        field(31;"Basic Pay";Decimal)
        {

            trigger OnValidate()
            begin
                //2Thirds
                "2/3rds":=ROUND(("Basic Pay")*2/3,0.05,'>');
                "1/3rd":=ROUND(("Basic Pay")*1/3,0.05,'>');
            end;
        }
        field(32;"Total Deduction";Decimal)
        {
        }
        field(33;"2/3rds";Decimal)
        {

            trigger OnValidate()
            begin
                "Qualification As Per Salary":=("2/3rds"*100*Installments)/(100+Installments);
            end;
        }
        field(34;"1/3rd";Decimal)
        {
        }
        field(35;"Deficit on Deposit";Decimal)
        {
        }
        field(36;"Repayment Frequency";Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly,Quaterly';
            OptionMembers = Daily,Weekly,Monthly,Quaterly;
        }
        field(37;"Loan Disbursement Date";Date)
        {
        }
        field(38;"Loan Principle Repayment";Decimal)
        {
        }
        field(39;"Loan Interest Repayment";Decimal)
        {
        }
        field(40;"Loan Calculator Type";Option)
        {
            OptionCaption = ' ,Member Specific,Product Specific';
            OptionMembers = " ","Member Specific","Product Specific";
        }
    }

    keys
    {
        key(Key1;"Loan Product Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LoanType: Record "Loan Products Setup";
        TotalMRepay: Decimal;
        LPrincipal: Decimal;
        LInterest: Decimal;
        InterestRate: Decimal;
        LoanAmount: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        BosaLoans: Record "Loans Register";
        FosaLoans: Record Vendor;
        Cust: Record "Member Register";
        Psalary: Decimal;
        Msalary: Decimal;
}

