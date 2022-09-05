#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516002 "Payroll Managementt"
{

    trigger OnRun()
    begin
    end;

    var
        PersonalRelief: Decimal;
        "PersonalRelief(LCY)": Decimal;
        InsuranceRelief: Decimal;
        "InsuranceRelief(LCY)": Decimal;
        MorgageRelief: Decimal;
        "MorgageRelief(LCY)": Decimal;
        MaximumRelief: Decimal;
        "MaximumRelief(LCY)": Decimal;
        NssfEmployee: Decimal;
        "NssfEmployee(LCY)": Decimal;
        NssfEmployerFactor: Decimal;
        "NssfEmployerFactor(LCY)": Decimal;
        NHIFBasedOn: Option Gross,Basic,"Taxable Pay";
        NSSFBasedOn: Option Gross,Basic,"Taxable Pay";
        MaxPensionContrib: Decimal;
        "MaxPensionContrib(LCY)": Decimal;
        RateTaxExPension: Decimal;
        "RateTaxExPension(LCY)": Decimal;
        OOIMaxMonthlyContrb: Decimal;
        "OOIMaxMonthlyContrb(LCY)": Decimal;
        OOIDecemberDedc: Decimal;
        "OOIDecemberDedc(LCY)": Decimal;
        LoanMarketRate: Decimal;
        "LoanMarketRate(LCY)": Decimal;
        LoanCorpRate: Decimal;
        "LoanCorpRate(LCY)": Decimal;
        NSSFBaseAmount: Decimal;
        "NSSFBaseAmount(LCY)": Decimal;
        NHIFBaseAmount: Decimal;
        "NHIFBaseAmount(LCY)": Decimal;
        EmpBasicPay: Decimal;
        "EmpBasicPay(LCY)": Decimal;
        EmpEarning: Decimal;
        "EmpEarning(LCY)": Decimal;
        EmpDeduction: Decimal;
        "EmpDeduction(LCY)": Decimal;
        EmpPaye: Decimal;
        "EmpPaye(LCY)": Decimal;
        EmpPayeBenefit: Decimal;
        "EmpPayeBenefit(LCY)": Decimal;
        EmpGrossPay: Decimal;
        "EmpGrossPay(LCY)": Decimal;
        EmpGrossTaxable: Decimal;
        "EmpGrossTaxable(LCY)": Decimal;
        EmpBenefits: Decimal;
        "EmpBenefits(LCY)": Decimal;
        EmpValueOfQuarters: Decimal;
        "EmpValueOfQuarters(LCY)": Decimal;
        EmpTaxableEarning: Decimal;
        "EmpTaxableEarning(LCY)": Decimal;
        EmpPersonalRelief: Decimal;
        "EmpPersonalRelief(LCY)": Decimal;
        EmpUnusedRelief: Decimal;
        "EmpUnusedRelief(LCY)": Decimal;
        EmpNetPay: Decimal;
        "EmpNetPay(LCY)": Decimal;
        currentAmount: Decimal;
        "currentAmount(LCY)": Decimal;
        Description: Text[100];
        "Account Type": Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor;
        "Account No.": Code[20];
        "Posting Type": Option " ",Debit,Credit;
        "Transaction Code": Code[20];
        "Transaction Type": Code[50];
        Grouping: Integer;
        SubGrouping: Integer;
        TransDescription: Text[100];
        ExchangeRateDate: Date;
        CurrExchRate: Record "Currency Exchange Rate";
        PayrollPostingGroup: Record "Payroll Posting Groups.";
        PayrollGenSetup: Record "Payroll General Setup.";
        EmployeeTransactions: Record "Payroll Employee Transactions.";
        EmpTotalAllowances: Decimal;
        "EmpTotalAllowances(LCY)": Decimal;
        PayrollTransactions: Record "Payroll Transaction Code.";
        TransFormula: Text[250];
        CurBalance: Decimal;
        "CurBalance(LCY)": Decimal;
        EmpTotalNonTaxAllowances: Decimal;
        "EmpTotalNonTaxAllowances(LCY)": Decimal;
        Customer: Record Customer;
        TALLOWANCE: label 'ALLOWANCE';
        CurMonth: Integer;
        CurYear: Integer;
        TCODE_BPAY: label 'BPAY';
        TTYPE_BPAY: label 'Basic Pay';
        TotalSalaryArrears: Decimal;
        currentGrossPay: Decimal;
        "currentGrossPay(LCY)": Decimal;
        EmpSalaryArrear: Decimal;
        "EmpSalaryArrear(LCY)": Decimal;
        TCODE_GPAY: label 'GPAY';
        TTYPE_GPAY: label 'Gross Pay';
        EmpPAYEArrears: Decimal;
        "EmpPAYEArrears(LCY)": Decimal;
        "Salary Arrears": Record "Payroll Salary Arrears.";
        TCODE_SARREARS: label 'ARREARS';
        TTYPE_SARREARS: label 'Salary Arrears';
        TCODE_PARREARS: label 'PYAR';
        TTYPE_STATUTORIES: label 'STATUTORIES';
        EmpLoan: Decimal;
        "EmpLoan(LCY)": Decimal;
        EmpFringeBenefit: Decimal;
        TCODE_NSSF: label 'NSSF';
        TCODE_NSSFEMP: label 'NSSFEMP';
        "EmpFringeBenefit(LCY)": Decimal;
        TCODE_NHIF: label 'NHIF';
        EmpDefinedContrib: Decimal;
        "EmpDefinedContrib(LCY)": Decimal;
        EmpStaffPension: Decimal;
        "EmpStaffPension(LCY)": Decimal;
        EmpLessAllowanceNSSF: Decimal;
        "EmpLessAllowanceNSSF(LCY)": Decimal;
        EmpLessAllowanceNHIF: Decimal;
        "EmpLessAllowanceNHIF(LCY)": Decimal;
        EmpPensionStaff: Decimal;
        "EmpPensionStaff(LCY)": Decimal;
        EmpOOI: Decimal;
        "EmpOOI(LCY)": Decimal;
        EmpHOSP: Decimal;
        "EmpHOSP(LCY)": Decimal;
        EmpNonTaxable: Decimal;
        "EmpNonTaxable(LCY)": Decimal;
        EmpTaxCharged: Decimal;
        "EmpTaxCharged(LCY)": Decimal;
        InsuranceReliefAmount: Decimal;
        "InsuranceReliefAmount(LCY)": Decimal;
        UnusedRelief: Record "Employee Unused Relief.";
        EmpNSSF: Decimal;
        "EmpNSSF(LCY)": Decimal;
        EmpNHIF: Decimal;
        "EmpNHIF(LCY)": Decimal;
        EmpTotalDeductions: Decimal;
        "EmpTotalDeductions(LCY)": Decimal;


    procedure ProcessPayroll("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20]; PaysPAYE: Boolean; PaysNHIF: Boolean; PaysNSSF: Boolean; GetsPAYERelief: Boolean; GetsPAYEBenefit: Boolean; Secondary: Boolean; PayeBenefitPercent: Decimal)
    begin
        Initialize("Payroll Period");
        //Basic Pay
        ProcessBasicPay("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);
        //SalaryArrears
        ProcessSalaryArrears("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);
        //Earnings
        ProcessEarnings("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);
        //GrossPay
        ProcessGrossPay("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);
        //Deductions
        ProcessDeductions("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);
        //NSSF
        if PaysNSSF then begin
            ProcessEmployeeNSSF("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                            BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department, PaysNSSF);
            ProcessEmployerNSSF("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                            BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department, PaysNSSF);
        end;
        //NHIF
        if PaysNHIF then begin
            ProcessNHIF("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                            BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department, PaysNHIF);
        end;

        //Gross Taxable
        ProcessGrossTaxable();

        //Taxable Pay
        ProcessTaxablePay("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);

        //PAYE
        if PaysPAYE then begin
            //Personal Relief
            if GetsPAYERelief then begin
                ProcessPersonalRelief("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                              BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);
            end else begin
                EmpPersonalRelief := 0;
                "EmpPersonalRelief(LCY)" := 0;
            end;
            //Process PAYE
            ProcessEmpPAYE("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                            BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department, Secondary, GetsPAYEBenefit, PayeBenefitPercent);
        end;
        //NetPay
        ProcessNetPay("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);

        //End
    end;

    local procedure Initialize("Payroll Period": Date)
    begin
        CurMonth := Date2dmy("Payroll Period", 2);
        CurYear := Date2dmy("Payroll Period", 3);
        //Constants
        PayrollGenSetup.Get;

        PersonalRelief := PayrollGenSetup."Tax Relief";
        InsuranceRelief := PayrollGenSetup."Insurance Relief";
        MorgageRelief := PayrollGenSetup."Mortgage Relief";
        MaximumRelief := PayrollGenSetup."Max Relief";
        NssfEmployee := PayrollGenSetup."NSSF Employee";
        NssfEmployerFactor := PayrollGenSetup."NSSF Employer Factor";
        NHIFBasedOn := PayrollGenSetup."NHIF Based on";
        NSSFBasedOn := PayrollGenSetup."NSSF Based on";
        MaxPensionContrib := PayrollGenSetup."Max Pension Contribution";
        RateTaxExPension := PayrollGenSetup."Tax On Excess Pension";
        OOIMaxMonthlyContrb := PayrollGenSetup."OOI Deduction";
        OOIDecemberDedc := PayrollGenSetup."OOI December";
        LoanMarketRate := PayrollGenSetup."Loan Market Rate";
        LoanCorpRate := PayrollGenSetup."Loan Corporate Rate";
    end;

    local procedure ProcessBasicPay("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    var
        DaysInMonth: Integer;
        DaysWorked: Integer;
    begin
        //Setup Constants
        "Transaction Code" := TCODE_BPAY;
        "Transaction Type" := TTYPE_BPAY;
        TransDescription := 'Basic Pay';
        Grouping := 1;
        SubGrouping := 1;
        EmpBasicPay := 0;
        "EmpBasicPay(LCY)" := 0;
        currentAmount := 0;
        "currentAmount(LCY)" := 0;

        //Calculate the Basic Pay
        EmpBasicPay := BasicPay;
        "EmpBasicPay(LCY)" := "BasicPay(LCY)";

        //If Based on Timesheet then Prorate
        PayrollGenSetup.Get;
        if BasedOnTimeSheet then begin
            DaysInMonth := GetDaysInMonth("Payroll Period");
            DaysWorked := GetDaysWorkedTimesheet("Employee No", "Payroll Period");
            EmpBasicPay := CalculateProratedAmount("Employee No", EmpBasicPay, Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
            "EmpBasicPay(LCY)" := CalculateProratedAmount("Employee No", "EmpBasicPay(LCY)", Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
            //End Based on Timesheet
        end else begin
            //If Employed on this Payroll Period then Prorate Amount
            if (Date2dmy("Joining Date", 2) = Date2dmy("Payroll Period", 2)) and (Date2dmy("Joining Date", 3) = Date2dmy("Payroll Period", 3)) then begin
                DaysInMonth := GetDaysInMonth("Joining Date");
                DaysWorked := GetDaysWorked("Joining Date", false);
                EmpBasicPay := CalculateProratedAmount("Employee No", EmpBasicPay, Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                "EmpBasicPay(LCY)" := CalculateProratedAmount("Employee No", "EmpBasicPay(LCY)", Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
            end;
            //If Terminated on this Payroll Period then Prorate Amount
            if "Leaving Date" <> 0D then
                if (Date2dmy("Leaving Date", 2) = Date2dmy("Payroll Period", 2)) and (Date2dmy("Leaving Date", 3) = Date2dmy("Payroll Period", 3)) then begin
                    DaysInMonth := GetDaysInMonth("Joining Date");
                    DaysWorked := GetDaysWorked("Joining Date", true);
                    EmpBasicPay := CalculateProratedAmount("Employee No", EmpBasicPay, Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                    "EmpBasicPay(LCY)" := CalculateProratedAmount("Employee No", "EmpBasicPay(LCY)", Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                end;
        end;
        //Insert Into Monthly Transactions
        currentAmount := EmpBasicPay;
        "currentAmount(LCY)" := "EmpBasicPay(LCY)";

        if PayrollPostingGroup.Get("Posting Group") then begin
            "Account Type" := "account type"::"G/L Account";
            "Account No." := PayrollPostingGroup."Salary Account";
        end;

        //Insert Into Monthly Transactions
        InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
        TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
        "Account No.", "posting type"::Debit, "Global Dimension 1 Code", "Global Dimension 2 Code", EmployeeTransactions.Membership,
        EmployeeTransactions."Reference No", Department);
    end;

    local procedure ProcessSalaryArrears("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    begin
        //Salary Arrears
        /* "Salary Arrears".RESET;
         "Salary Arrears".SETRANGE("Salary Arrears"."Employee Code","Employee No");
         "Salary Arrears".SETRANGE("Salary Arrears"."Period Month",CurMonth);
         "Salary Arrears".SETRANGE("Salary Arrears"."Period Year",CurYear);
         IF "Salary Arrears".FINDFIRST THEN BEGIN
            //Salary Arrears------------------------------------------------------------------------------------------------------------
              //Setup Constants
              "Transaction Code":=TCODE_SARREARS;
              "Transaction Type":=TTYPE_SARREARS;
              TransDescription:=FORMAT(TTYPE_SARREARS)+':'+FORMAT("Payroll Period");
              Grouping:=1;SubGrouping:=2;
              currentAmount:=0;
              "currentAmount(LCY)":=0;
              SalaryArrear:=0;
              "SalaryArrear(LCY)":=0;
        
              SalaryArrear:="Salary Arrears"."Salary Arrears";
              "SalaryArrear(LCY)":="Salary Arrears"."Salary Arrears(LCY)";
        
              currentAmount:=SalaryArrears;
              "currentAmount(LCY)":="SalaryArrears(LCY)";
        
              IF PayrollPostingGroup.GET("Posting Group") THEN BEGIN
                 "Account Type":="Account Type"::"G/L Account";
                 "Account No.":=PayrollPostingGroup."Salary Account";
              END;
        
              //Insert Into Monthly Transactions
              InsertMonthlyTransactions("Employee No","Transaction Code","Transaction Type",Grouping,SubGrouping,
               TransDescription,currentAmount,"currentAmount(LCY)",0,0,"Payroll Period",CurMonth, CurYear,"Account Type",
               "Account No.","Posting Type"::Debit,"Global Dimension 1 Code","Global Dimension 2 Code",'',
               '',Department);
            //End Salary Arrears--------------------------------------------------------------------------------------------------------
        
            //PAYE Arrears--------------------------------------------------------------------------------------------------------------
        
              //Setup Constants
              "Transaction Code":=TCODE_PARREARS;
              "Transaction Type":=TTYPE_PARREARS;
              TransDescription:=FORMAT(TTYPE_PARREARS)+':'+FORMAT("Payroll Period");
              Grouping:=7;SubGrouping:=4;
              currentAmount:=0;
              "currentAmount(LCY)":=0;
              PAYEArrear:=0;
              "PAYEArrear(LCY)":=0;
        
        
              PAYEArrear:="Salary Arrears"."PAYE Arrears";
              "PAYEArrear(LCY)":="Salary Arrears"."PAYE Arrears(LCY)";
              currentAmount:=PAYEArrears;
              "currentAmount(LCY)":="PAYEArrears(LCY)";
        
              IF PayrollPostingGroup.GET("Posting Group") THEN BEGIN
                 "Account Type":="Account Type"::"G/L Account";
                 "Account No.":=PayrollPostingGroup."Income Tax Account";
              END;
        
              //Insert Into Monthly Transactions
              InsertMonthlyTransactions("Employee No","Transaction Code","Transaction Type",Grouping,SubGrouping,
               TransDescription,currentAmount,"currentAmount(LCY)",0,0,"Payroll Period",CurMonth, CurYear,"Account Type",
               "Account No.","Posting Type"::Debit,"Global Dimension 1 Code","Global Dimension 2 Code",'',
               '',Department);
        
             //End PAYE Arrears----------------------------------------------------------------------------------------------------------
         END;
         */

    end;

    local procedure ProcessEarnings("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimesheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    var
        DaysInMonth: Integer;
        DaysWorked: Integer;
    begin
        EmpTotalAllowances := 0;
        "EmpTotalAllowances(LCY)" := 0;
        EmpTotalNonTaxAllowances := 0;
        "EmpTotalNonTaxAllowances(LCY)" := 0;

        //Get Earnings
        EmployeeTransactions.Reset;
        EmployeeTransactions.SetRange(EmployeeTransactions."No.", "Employee No");
        EmployeeTransactions.SetRange(EmployeeTransactions."Period Month", CurMonth);
        EmployeeTransactions.SetRange(EmployeeTransactions."Period Year", CurYear);
        EmployeeTransactions.SetRange(EmployeeTransactions."Transaction Type", EmployeeTransactions."transaction type"::Income);
        if EmployeeTransactions.FindSet then begin
            repeat
                currentAmount := 0;
                "currentAmount(LCY)" := 0;
                CurBalance := 0;
                TransDescription := '';
                TransFormula := '';
                "Transaction Code" := '';
                Grouping := 0;
                SubGrouping := 0;

                PayrollTransactions.Reset;
                PayrollTransactions.SetRange(PayrollTransactions."Transaction Code", EmployeeTransactions."Transaction Code");
                if PayrollTransactions.FindFirst then begin
                    if PayrollTransactions."Is Formulae" then begin
                        TransFormula := ExpandFormula("Employee No", CurMonth, CurYear, PayrollTransactions.Formulae);
                        currentAmount := FormulaResult(TransFormula);
                        "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"));
                    end else begin
                        currentAmount := EmployeeTransactions.Amount;
                        "currentAmount(LCY)" := EmployeeTransactions."Amount(LCY)";
                    end;
                    //If Based on Timesheet then Prorate
                    PayrollGenSetup.Get;
                    if BasedOnTimesheet then begin
                        DaysInMonth := GetDaysInMonth("Payroll Period");
                        DaysWorked := GetDaysWorkedTimesheet("Employee No", "Payroll Period");
                        currentAmount := CalculateProratedAmount("Employee No", currentAmount, Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                        "currentAmount(LCY)" := CalculateProratedAmount("Employee No", "currentAmount(LCY)", Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                        //End Based on Timesheet
                    end else begin
                        //If Employed on this Payroll Period then Prorate Amount
                        if (Date2dmy("Joining Date", 2) = Date2dmy("Payroll Period", 2)) and (Date2dmy("Joining Date", 3) = Date2dmy("Payroll Period", 3)) then begin
                            DaysInMonth := GetDaysInMonth("Joining Date");
                            DaysWorked := GetDaysWorked("Joining Date", false);
                            currentAmount := CalculateProratedAmount("Employee No", currentAmount, Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                            "currentAmount(LCY)" := CalculateProratedAmount("Employee No", "currentAmount(LCY)", Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                        end;
                        //If Terminated on this Payroll Period then Prorate Amount
                        if "Leaving Date" <> 0D then
                            if (Date2dmy("Leaving Date", 2) = Date2dmy("Payroll Period", 2)) and (Date2dmy("Leaving Date", 3) = Date2dmy("Payroll Period", 3)) then begin
                                DaysInMonth := GetDaysInMonth("Joining Date");
                                DaysWorked := GetDaysWorked("Joining Date", true);
                                currentAmount := CalculateProratedAmount("Employee No", currentAmount, Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                                "currentAmount(LCY)" := CalculateProratedAmount("Employee No", "currentAmount(LCY)", Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                            end;
                    end;
                    //Calculate Transaction Balances
                    if PayrollTransactions."Balance Type" = PayrollTransactions."balance type"::None then begin  //Balance Type None
                        CurBalance := 0;
                        "CurBalance(LCY)" := 0;
                    end;
                    if PayrollTransactions."Balance Type" = PayrollTransactions."balance type"::Increasing then begin//Balance Type Increasing
                        CurBalance := EmployeeTransactions.Balance + currentAmount;
                        "CurBalance(LCY)" := EmployeeTransactions."Balance(LCY)" + "currentAmount(LCY)";
                    end;
                    if PayrollTransactions."Balance Type" = PayrollTransactions."balance type"::Reducing then begin//Balance Type Decreasing
                        CurBalance := EmployeeTransactions.Balance - currentAmount;
                        "CurBalance(LCY)" := EmployeeTransactions."Balance(LCY)" - "currentAmount(LCY)";
                    end;
                    //Sum All NonTaxable Allowances
                    if (not PayrollTransactions.Taxable) and (PayrollTransactions."Special Transaction" = PayrollTransactions."special transaction"::Ignore) then begin
                        EmpTotalNonTaxAllowances := EmpTotalNonTaxAllowances + currentAmount;
                        "EmpTotalNonTaxAllowances(LCY)" := "EmpTotalNonTaxAllowances(LCY)" + "currentAmount(LCY)";
                    end;
                    //Exclude Special transaction that are not taxable in list of Allowances
                    if (not PayrollTransactions.Taxable) and (PayrollTransactions."Special Transaction" <> PayrollTransactions."special transaction"::Ignore) then begin
                        currentAmount := 0;
                        "currentAmount(LCY)" := 0;
                    end;
                    //Sum All Allowances
                    EmpTotalAllowances := EmpTotalAllowances + currentAmount;
                    "EmpTotalAllowances(LCY)" := "EmpTotalAllowances(LCY)" + "currentAmount(LCY)";

                    TransDescription := PayrollTransactions."Transaction Name";
                    "Transaction Type" := TALLOWANCE;
                    Grouping := 3;
                    SubGrouping := 0;

                    //Posting Details
                    if PayrollTransactions.SubLedger <> PayrollTransactions.Subledger::" " then begin
                        if PayrollTransactions.SubLedger = PayrollTransactions.Subledger::Customer then begin
                            Customer.Reset;
                            Customer.SetRange(Customer."No.", "Employee No");
                            if Customer.FindFirst then begin
                                "Account Type" := "account type"::Customer;
                                "Account No." := Customer."No.";
                            end;
                        end;
                    end else begin
                        "Account Type" := "account type"::"G/L Account";
                        "Account No." := PayrollTransactions."G/L Account";
                    end;
                    //End posting Details

                    InsertMonthlyTransactions("Employee No", PayrollTransactions."Transaction Code", "Transaction Type", Grouping, SubGrouping,
                     TransDescription, currentAmount, "currentAmount(LCY)", CurBalance, "CurBalance(LCY)", "Payroll Period", CurMonth, CurYear, "Account Type",
                     "Account No.", "posting type"::Debit, "Global Dimension 1 Code", "Global Dimension 2 Code", EmployeeTransactions.Membership,
                     EmployeeTransactions."Reference No", Department);

                end;
            until EmployeeTransactions.Next = 0;
        end;
    end;

    local procedure ProcessGrossPay("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    begin
        //Set Variables
        "Transaction Code" := TCODE_GPAY;
        "Transaction Type" := TTYPE_GPAY;
        TransDescription := 'Gross Pay';
        Grouping := 4;
        SubGrouping := 0;
        EmpGrossPay := 0;
        "EmpGrossPay(LCY)" := 0;
        currentAmount := 0;
        "currentAmount(LCY)" := 0;


        EmpGrossPay := (EmpBasicPay + EmpTotalAllowances + EmpSalaryArrear);
        "EmpGrossPay(LCY)" := ("EmpBasicPay(LCY)" + "EmpTotalAllowances(LCY)" + "EmpSalaryArrear(LCY)");

        currentAmount := EmpGrossPay;
        "currentAmount(LCY)" := "EmpGrossPay(LCY)";

        //Insert into Monthly Transaction
        InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
        TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
        "Account No.", "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '',
         '', Department);
    end;

    local procedure ProcessDeductions("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimesheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    begin
        EmpDeduction := 0;
        "EmpDeduction(LCY)" := 0;

        //Get Earnings
        EmployeeTransactions.Reset;
        EmployeeTransactions.SetRange(EmployeeTransactions."No.", "Employee No");
        EmployeeTransactions.SetRange(EmployeeTransactions."Period Month", CurMonth);
        EmployeeTransactions.SetRange(EmployeeTransactions."Period Year", CurYear);
        EmployeeTransactions.SetRange(EmployeeTransactions."Transaction Type", EmployeeTransactions."transaction type"::Deduction);
        if EmployeeTransactions.FindSet then begin
            repeat
                currentAmount := 0;
                "currentAmount(LCY)" := 0;
                CurBalance := 0;
                TransDescription := '';
                TransFormula := '';
                "Transaction Code" := '';
                Grouping := 0;
                SubGrouping := 0;

                PayrollTransactions.Reset;
                PayrollTransactions.SetRange(PayrollTransactions."Transaction Code", EmployeeTransactions."Transaction Code");
                if PayrollTransactions.FindFirst then begin
                    if PayrollTransactions."Is Formulae" then begin
                        TransFormula := ExpandFormula("Employee No", CurMonth, CurYear, PayrollTransactions.Formulae);
                        currentAmount := FormulaResult(TransFormula);
                        "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"));
                    end else begin
                        currentAmount := EmployeeTransactions.Amount;
                        "currentAmount(LCY)" := EmployeeTransactions."Amount(LCY)";
                    end;

                    PayrollGenSetup.Get;
                    if (PayrollTransactions."Special Transaction" = PayrollTransactions."special transaction"::"Life Insurance") and (PayrollTransactions."Deduct Premium" = false) then begin
                        currentAmount := 0;
                        "currentAmount(LCY)" := 0;
                    end;

                    if (PayrollTransactions."Special Transaction" = PayrollTransactions."special transaction"::Morgage) and (PayrollTransactions."Deduct Mortgage" = false) then begin
                        currentAmount := 0;
                        "currentAmount(LCY)" := 0;
                    end;

                    //Posting Details
                    if PayrollTransactions.SubLedger <> PayrollTransactions.Subledger::" " then begin
                        if PayrollTransactions.SubLedger = PayrollTransactions.Subledger::Customer then begin
                            Customer.Reset;
                            Customer.SetRange(Customer."No.", "Employee No");
                            if Customer.FindFirst then begin
                                "Account Type" := "account type"::Customer;
                                "Account No." := Customer."No.";
                            end;
                        end;
                    end else begin
                        "Account Type" := "account type"::"G/L Account";
                        "Account No." := PayrollTransactions."G/L Account";
                    end;
                    //End posting Details

                    //Amortized Loan Calculation
                    if (PayrollTransactions."Special Transaction" = PayrollTransactions."special transaction"::"Staff Loan") and
                       (PayrollTransactions."Repayment Method" = PayrollTransactions."repayment method"::Amortized) then begin

                        currentAmount := 0;
                        "currentAmount(LCY)" := 0;
                        EmpLoan := 0;
                        "EmpLoan(LCY)" := 0;
                        EmpLoan := CalculateLoanInterest("Employee No", EmployeeTransactions."Transaction Code",
                                     PayrollTransactions."Interest Rate", PayrollTransactions."Repayment Method",
                                     EmployeeTransactions."Original Amount", EmployeeTransactions.Balance, "Payroll Period", false);
                        if "Currency Code" <> '' then
                            "EmpLoan(LCY)" := CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", EmpLoan, "Currency Factor")
                        else
                            "EmpLoan(LCY)" := 0;
                        //Post the Interest
                        if (EmpLoan <> 0) then begin
                            currentAmount := EmpLoan;
                            "currentAmount(LCY)" := "EmpLoan(LCY)";

                            EmpDeduction := EmpDeduction + currentAmount;
                            "EmpDeduction(LCY)" := "EmpDeduction(LCY)" + "currentAmount(LCY)";

                            CurBalance := 0;
                            "CurBalance(LCY)" := 0;

                            "Transaction Code" := EmployeeTransactions."Transaction Code" + '-INT';
                            TransDescription := EmployeeTransactions."Transaction Name" + 'Interest';
                            "Transaction Type" := 'DEDUCTIONS';
                            Grouping := 8;
                            SubGrouping := 1;
                            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
                                TransDescription, currentAmount, "currentAmount(LCY)", CurBalance, "CurBalance(LCY)", "Payroll Period", CurMonth, CurYear, "Account Type",
                                "Account No.", "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '', '', Department);

                        end;
                        currentAmount := EmployeeTransactions."Amtzd Loan Repay Amt" - EmpLoan;
                        "currentAmount(LCY)" := EmployeeTransactions."Amtzd Loan Repay Amt(LCY)" - "EmpLoan(LCY)";
                    end;
                    //End Amortized Loan

                    //Calculate Transaction Balances
                    if PayrollTransactions."Balance Type" = PayrollTransactions."balance type"::None then begin  //Balance Type None
                        CurBalance := 0;
                        "CurBalance(LCY)" := 0;
                    end;
                    if PayrollTransactions."Balance Type" = PayrollTransactions."balance type"::Increasing then begin//Balance Type Increasing
                        CurBalance := EmployeeTransactions.Balance + currentAmount;
                        "CurBalance(LCY)" := EmployeeTransactions."Balance(LCY)" + "currentAmount(LCY)";
                    end;
                    if PayrollTransactions."Balance Type" = PayrollTransactions."balance type"::Reducing then begin//Balance Type Decreasing
                        if EmployeeTransactions.Balance < EmployeeTransactions.Amount then begin
                            currentAmount := EmployeeTransactions.Balance;
                            "currentAmount(LCY)" := EmployeeTransactions."Balance(LCY)";
                            CurBalance := 0;
                            "CurBalance(LCY)" := 0;
                        end else begin
                            CurBalance := EmployeeTransactions.Balance - currentAmount;
                            "CurBalance(LCY)" := EmployeeTransactions."Balance(LCY)" - "currentAmount(LCY)";
                        end;
                        if CurBalance < 0 then begin
                            currentAmount := 0;
                            "currentAmount(LCY)" := 0;
                            CurBalance := 0;
                            "CurBalance(LCY)" := 0;
                        end;
                    end;
                    EmpDeduction := EmpDeduction + currentAmount;
                    "EmpDeduction(LCY)" := "EmpDeduction(LCY)" + "currentAmount(LCY)";

                    "Transaction Code" := PayrollTransactions."Transaction Code";
                    TransDescription := PayrollTransactions."Transaction Name";
                    "Transaction Type" := 'DEDUCTIONS';
                    Grouping := 8;
                    SubGrouping := 0;
                    InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
                          TransDescription, currentAmount, "currentAmount(LCY)", CurBalance, "CurBalance(LCY)", "Payroll Period", CurMonth, CurYear, "Account Type",
                          "Account No.", "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '', '', Department);

                    //If transaction is loan. Do Loan Calculation
                    if (PayrollTransactions."Special Transaction" = PayrollTransactions."special transaction"::"Staff Loan") and
                       (PayrollTransactions."Repayment Method" <> PayrollTransactions."repayment method"::Amortized) then begin

                        EmpLoan := CalculateLoanInterest("Employee No", EmployeeTransactions."Transaction Code",
                                     PayrollTransactions."Interest Rate", PayrollTransactions."Repayment Method",
                                     EmployeeTransactions."Original Amount", EmployeeTransactions.Balance, "Payroll Period", false);
                        if "Currency Code" <> '' then
                            "EmpLoan(LCY)" := CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", EmpLoan, "Currency Factor")
                        else
                            "EmpLoan(LCY)" := 0;

                        if EmpLoan > 0 then begin
                            currentAmount := EmpLoan;
                            "currentAmount(LCY)" := "EmpLoan(LCY)";

                            EmpDeduction := EmpDeduction + currentAmount;
                            "EmpDeduction(LCY)" := "EmpDeduction(LCY)" + "currentAmount(LCY)";

                            CurBalance := 0;
                            "Transaction Code" := EmployeeTransactions."Transaction Code" + '-INT';
                            TransDescription := EmployeeTransactions."Transaction Name" + 'Interest';
                            "Transaction Type" := 'DEDUCTIONS';
                            Grouping := 8;
                            SubGrouping := 1;
                            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
                                    TransDescription, currentAmount, "currentAmount(LCY)", CurBalance, "CurBalance(LCY)", "Payroll Period", CurMonth, CurYear, "Account Type",
                                    "Account No.", "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '', '', Department);

                        end;
                    end;
                    //End Loan Calculation
                    //Fringe Benefits and Low interest Benefits
                    if PayrollTransactions."Fringe Benefit" = true then begin
                        if PayrollTransactions."Interest Rate" < LoanMarketRate then begin
                            EmpFringeBenefit := (((LoanMarketRate - PayrollTransactions."Interest Rate") * LoanCorpRate) / 1200) * EmployeeTransactions.Balance;
                            "EmpFringeBenefit(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", EmpFringeBenefit, "Currency Factor"));
                        end;
                    end else begin
                        EmpFringeBenefit := 0;
                    end;
                    if EmpFringeBenefit > 0 then
                        InsertEmployerDeductions("Employee No", EmployeeTransactions."Transaction Code" + '-FRG',
                                'EMP', Grouping, SubGrouping, 'Fringe Benefit Tax', EmpFringeBenefit, "EmpFringeBenefit(LCY)", 0, 0, CurMonth, CurYear,
                                 EmployeeTransactions.Membership, EmployeeTransactions."Reference No", "Payroll Period", '');

                    //End Fringe Benefits

                    //Create Employer Deduction
                    if (PayrollTransactions."Employer Deduction") or (PayrollTransactions."Include Employer Deduction") then begin
                        if PayrollTransactions."Formulae for Employer" <> '' then begin
                            TransFormula := ExpandFormula("Employee No", CurMonth, CurYear, PayrollTransactions."Formulae for Employer");
                            currentAmount := FormulaResult(TransFormula);
                            "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"));
                        end else begin
                            currentAmount := EmployeeTransactions."Employer Amount";
                            "currentAmount(LCY)" := EmployeeTransactions."Employer Amount(LCY)";
                        end;
                        if currentAmount > 0 then
                            InsertEmployerDeductions("Employee No", EmployeeTransactions."Transaction Code",
                                    'EMP', Grouping, SubGrouping, 'DEDUCTION', currentAmount, "currentAmount(LCY)", 0, 0, CurMonth, CurYear,
                                     EmployeeTransactions.Membership, EmployeeTransactions."Reference No", "Payroll Period", '');

                    end;
                    //Employer deductions
                end;
            until EmployeeTransactions.Next = 0;
        end;
    end;

    local procedure ProcessEmployeeNSSF("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20]; PayesNSSF: Boolean)
    var
        NSSFAmt: Decimal;
        "NSSFAmt(LCY)": Decimal;
    begin
        NSSFBaseAmount := 0;
        "NSSFBaseAmount(LCY)" := 0;
        EmpNSSF := 0;
        "EmpNSSF(LCY)" := 0;
        currentAmount := 0;
        "currentAmount(LCY)" := 0;

        if PayesNSSF then begin
            if NSSFBasedOn = Nssfbasedon::Gross then begin
                NSSFBaseAmount := EmpGrossPay;
                "NSSFBaseAmount(LCY)" := "EmpGrossPay(LCY)";
            end;
            if NSSFBasedOn = Nssfbasedon::Basic then begin
                NSSFBaseAmount := EmpBasicPay;
                "NSSFBaseAmount(LCY)" := "EmpBasicPay(LCY)";
            end;
            EmpNSSF := CalculateEmployeeNSSF(NSSFBaseAmount);
            "EmpNSSF(LCY)" := CalculateEmployeeNSSF("NSSFBaseAmount(LCY)");
            currentAmount := EmpNSSF;
            "currentAmount(LCY)" := "EmpNSSF(LCY)";

            "Transaction Code" := TCODE_NSSF;
            TransDescription := 'N.S.S.F';
            "Transaction Type" := TTYPE_STATUTORIES;
            Grouping := 7;
            SubGrouping := 1;
            if PayrollPostingGroup.Get("Posting Group") then begin
                "Account Type" := "account type"::"G/L Account";
                "Account No." := PayrollPostingGroup."SSF Employee Account";
            end;

            //Insert Into Monthly Transactions
            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
            TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
            "Account No.", "posting type"::Credit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
            '', Department);
        end;
    end;

    local procedure ProcessEmployerNSSF("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20]; PayesNSSF: Boolean)
    var
        NSSFAmt: Decimal;
        ExpenseAccount: Code[20];
        "NSSFAmt(LCY)": Decimal;
    begin
        NSSFBaseAmount := 0;
        "NSSFBaseAmount(LCY)" := 0;
        NSSFAmt := 0;
        "NSSFAmt(LCY)" := 0;
        currentAmount := 0;
        "currentAmount(LCY)" := 0;

        if PayesNSSF then begin
            if NSSFBasedOn = Nssfbasedon::Gross then begin
                NSSFBaseAmount := EmpGrossPay;
                "NSSFBaseAmount(LCY)" := "EmpGrossPay(LCY)";
            end;
            if NSSFBasedOn = Nssfbasedon::Basic then begin
                NSSFBaseAmount := EmpBasicPay;
                "NSSFBaseAmount(LCY)" := "EmpBasicPay(LCY)";
            end;
            NSSFAmt := CalculateEmployeeNSSF(NSSFBaseAmount);
            "NSSFAmt(LCY)" := CalculateEmployerNSSF("NSSFBaseAmount(LCY)");
            currentAmount := NSSFAmt;
            "currentAmount(LCY)" := "NSSFAmt(LCY)";

            "Transaction Code" := TCODE_NSSFEMP;
            TransDescription := 'N.S.S.F';
            "Transaction Type" := TTYPE_STATUTORIES;
            Grouping := 7;
            SubGrouping := 1;
            if PayrollPostingGroup.Get("Posting Group") then begin
                "Account Type" := "account type"::"G/L Account";
                "Account No." := PayrollPostingGroup."SSF Employee Account";
                ExpenseAccount := PayrollPostingGroup."SSF Employer Account"
            end;

            //Insert Into Monthly Transactions
            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
            TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
            "Account No.", "posting type"::Credit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
            '', Department);
            //Debit to Expense A/C
            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
            TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
            ExpenseAccount, "posting type"::Debit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
            '', Department);
            //Remove Employer Deductions
            RemoveEmployerDeduction("Employee No", "Transaction Code", CurMonth, CurYear);
            //Insert Employer Deductions
            InsertEmployerDeductions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
            TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, CurMonth, CurYear, '', '', "Payroll Period", '');

            //Insert Defined contribution
            "Transaction Code" := 'DEFCON';
            "Transaction Type" := 'TAX CALCULATIONS';
            TransDescription := 'Defined Contributions';
            Grouping := 6;
            SubGrouping := 1;
            EmpDefinedContrib := NSSFAmt; //(NSSFAmt + StaffPension + TotalNonTaxAllowances) - MorgageRelief
            "EmpDefinedContrib(LCY)" := "NSSFAmt(LCY)";//(NSSFAmt(LCY) + StaffPension(LCY) + TotalNonTaxAllowances(LCY)) - MorgageRelief(LCY)
            currentAmount := EmpDefinedContrib;
            "currentAmount(LCY)" := "EmpDefinedContrib(LCY)";

            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
            TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "account type"::"G/L Account",
            '', "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '',
            '', Department);
        end;
    end;

    local procedure ProcessNHIF("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20]; PayesNHIF: Boolean)
    var
        NHIFAmt: Decimal;
        "NHIFAmt(LCY)": Decimal;
    begin
        NHIFBaseAmount := 0;
        "NHIFBaseAmount(LCY)" := 0;
        EmpNHIF := 0;
        "EmpNHIF(LCY)" := 0;
        currentAmount := 0;
        "currentAmount(LCY)" := 0;

        if PayesNHIF then begin
            if NHIFBasedOn = Nhifbasedon::Gross then begin
                NHIFBaseAmount := EmpGrossPay;
                "NHIFBaseAmount(LCY)" := "EmpGrossPay(LCY)";
            end;
            if NHIFBasedOn = Nhifbasedon::Basic then begin
                NHIFBaseAmount := EmpBasicPay;
                "NHIFBaseAmount(LCY)" := "EmpBasicPay(LCY)";
            end;
            EmpNHIF := CalculateNHIF(NHIFBaseAmount);
            "EmpNHIF(LCY)" := CalculateNHIF("NHIFBaseAmount(LCY)");
            currentAmount := EmpNHIF;
            "currentAmount(LCY)" := "EmpNHIF(LCY)";

            "Transaction Code" := TCODE_NHIF;
            TransDescription := 'N.H.I.F';
            "Transaction Type" := TTYPE_STATUTORIES;
            Grouping := 7;
            SubGrouping := 2;
            if PayrollPostingGroup.Get("Posting Group") then begin
                "Account Type" := "account type"::"G/L Account";
                "Account No." := PayrollPostingGroup."NHIF Employee Account";
            end;

            //Insert Into Monthly Transactions
            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
            TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
            "Account No.", "posting type"::Credit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
            '', Department);
        end;
    end;

    local procedure ProcessGrossTaxable()
    begin
        EmpGrossTaxable := 0;
        "EmpGrossTaxable(LCY)" := 0;
        //Get the Gross taxable amount
        EmpGrossTaxable := EmpGrossPay + EmpBenefits + EmpValueOfQuarters;
        "EmpGrossTaxable(LCY)" := "EmpGrossPay(LCY)" + "EmpBenefits(LCY)" + "EmpValueOfQuarters(LCY)";

        //If EmpGrossTaxable = 0 Then DefinedContrib ToPost = 0
        if EmpGrossTaxable = 0 then EmpDefinedContrib := 0;
        if "EmpGrossTaxable(LCY)" = 0 then "EmpDefinedContrib(LCY)" := 0;
    end;

    local procedure ProcessPersonalRelief("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    begin
        "Transaction Code" := 'PSNR';
        "Transaction Type" := 'TAX CALCULATIONS';
        Grouping := 6;
        SubGrouping := 9;
        TransDescription := 'Personal Relief';
        EmpPersonalRelief := 0;
        "EmpPersonalRelief(LCY)" := 0;

        EmpPersonalRelief := PersonalRelief + EmpUnusedRelief;
        "EmpPersonalRelief(LCY)" := "PersonalRelief(LCY)" + "EmpUnusedRelief(LCY)";

        currentAmount := EmpPersonalRelief;
        "currentAmount(LCY)" := "EmpPersonalRelief(LCY)";

        "Account Type" := "account type"::"G/L Account";
        "Account No." := '';
        //Insert Into Monthly Transactions
        InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
         TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
         "Account No.", "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '',
         '', Department);
    end;

    local procedure ProcessTaxablePay("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    begin
        "Transaction Code" := 'TXBP';
        "Transaction Type" := 'TAX CALCULATIONS';
        Grouping := 6;
        SubGrouping := 6;
        TransDescription := 'Taxable Pay';
        EmpTaxableEarning := 0;
        "EmpTaxableEarning(LCY)" := 0;

        if EmpPensionStaff > MaxPensionContrib then
            EmpTaxableEarning := EmpGrossTaxable - (EmpSalaryArrear + EmpDefinedContrib + MaxPensionContrib + EmpOOI + EmpHOSP + EmpNonTaxable)
        else
            EmpTaxableEarning := EmpGrossTaxable - (EmpSalaryArrear + EmpDefinedContrib + EmpPensionStaff + EmpOOI + EmpHOSP + EmpNonTaxable);

        if "Currency Code" <> '' then
            "EmpTaxableEarning(LCY)" := CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", EmpTaxableEarning, "Currency Factor")
        else
            "EmpTaxableEarning(LCY)" := EmpTaxableEarning;

        currentAmount := EmpTaxableEarning;
        "currentAmount(LCY)" := "EmpTaxableEarning(LCY)";

        "Account Type" := "account type"::"G/L Account";
        "Account No." := '';

        //Insert Into Monthly Transactions
        InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
        TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
        "Account No.", "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '',
        '', Department);
    end;

    local procedure ProcessEmpPAYE("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20]; Secondary: Boolean; GetsPayeBenefit: Boolean; PayeBenefitPercent: Decimal)
    begin
        //Get the Tax charged for the month
        "Transaction Code" := 'TXCHRG';
        "Transaction Type" := 'TAX CALCULATIONS';
        Grouping := 6;
        SubGrouping := 7;
        TransDescription := 'Tax Charged';
        EmpTaxCharged := 0;
        "EmpTaxCharged(LCY)" := 0;

        if Secondary = false then begin
            EmpTaxCharged := CalculatePAYE(EmpTaxableEarning, false);
        end else begin
            EmpTaxCharged := CalculatePAYE(EmpTaxableEarning, true);
        end;
        if "Currency Code" <> '' then
            "EmpTaxCharged(LCY)" := CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", EmpTaxCharged, "Currency Factor")
        else
            "EmpTaxCharged(LCY)" := EmpTaxCharged;

        currentAmount := EmpTaxCharged;
        "currentAmount(LCY)" := "EmpTaxCharged(LCY)";

        "Account Type" := "account type"::"G/L Account";
        "Account No." := '';
        //Insert Into Monthly Transactions
        InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
        TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
        "Account No.", "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '',
        '', Department);

        //Insert PAYE amount to post for the month
        "Transaction Code" := 'PAYE';
        "Transaction Type" := 'STATUTORIES';
        Grouping := 7;
        SubGrouping := 3;
        TransDescription := 'P.A.Y.E';
        EmpPaye := 0;
        "EmpPaye(LCY)" := 0;

        if (EmpPersonalRelief + InsuranceReliefAmount) > MaximumRelief then begin
            EmpPaye := EmpTaxCharged - MaximumRelief;
            "EmpPaye(LCY)" := "EmpTaxCharged(LCY)" - "MaximumRelief(LCY)";
        end else begin
            EmpPaye := EmpTaxCharged - (EmpPersonalRelief + InsuranceReliefAmount);
            "EmpPaye(LCY)" := "EmpTaxCharged(LCY)" - ("EmpPersonalRelief(LCY)" + "InsuranceReliefAmount(LCY)");
        end;
        //If EmpPaye>0 then "Insert into MonthlyTrans table
        if EmpPaye > 0 then begin
            currentAmount := EmpPaye;
            "currentAmount(LCY)" := "EmpPaye(LCY)";

            if PayrollPostingGroup.Get("Posting Group") then begin
                "Account Type" := "account type"::"G/L Account";
                "Account No." := PayrollPostingGroup."Income Tax Account";
            end;
            //Insert Into Monthly Transactions
            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
             TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
             "Account No.", "posting type"::Credit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
             '', Department);
        end;

        //If EmpPaye<0 then "Insert into Uuused Relif table
        if EmpPaye < 0 then begin
            UnusedRelief.Reset;
            UnusedRelief.SetRange(UnusedRelief."Employee No.", "Employee No");
            UnusedRelief.SetRange(UnusedRelief."Period Month", CurMonth);
            UnusedRelief.SetRange(UnusedRelief."Period Year", CurYear);
            if UnusedRelief.FindSet then
                UnusedRelief.Delete;

            UnusedRelief.Reset;
            with UnusedRelief do begin
                Init;
                "Employee No." := "Employee No";
                "Unused Relief" := EmpPaye;
                "Unused Relief(LCY)" := "EmpPaye(LCY)";
                "Period Month" := CurMonth;
                "Period Year" := CurYear;
                Insert;
            end;
        end;

        //PAYE Benefit
        if GetsPayeBenefit then begin
            "Transaction Code" := 'PAYEBEN';
            "Transaction Type" := 'STATUTORIES';
            Grouping := 7;
            SubGrouping := 10;
            TransDescription := 'P.A.Y.E Benefit';
            EmpPayeBenefit := 0;
            "EmpPayeBenefit(LCY)" := 0;

            EmpPayeBenefit := EmpPaye * (PayeBenefitPercent / 100);
            "EmpPayeBenefit(LCY)" := "EmpPaye(LCY)" * (PayeBenefitPercent / 100);

            currentAmount := EmpPayeBenefit;
            "currentAmount(LCY)" := "EmpPayeBenefit(LCY)";
            if PayrollPostingGroup.Get("Posting Group") then begin
                "Account Type" := "account type"::"G/L Account";
                "Account No." := PayrollPostingGroup."PAYE Benefit A/C";
            end;
            //Insert Into Monthly Transactions
            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
             TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
             "Account No.", "posting type"::Debit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
             '', Department);
        end;
    end;

    local procedure ProcessNetPay("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    begin
        "Transaction Code" := 'NPAY';
        "Transaction Type" := 'NET PAY';
        Grouping := 9;
        SubGrouping := 0;
        TransDescription := 'Net Pay';
        EmpNetPay := 0;
        "EmpNetPay(LCY)" := 0;

        EmpNetPay := EmpGrossPay - (EmpNSSF + EmpNHIF + EmpPaye + EmpPAYEArrears + EmpDeduction);
        "EmpNetPay(LCY)" := "EmpGrossPay(LCY)" - ("EmpNSSF(LCY)" + "EmpNHIF(LCY)" + "EmpPaye(LCY)" + "EmpPAYEArrears(LCY)" + "EmpDeduction(LCY)");

        currentAmount := EmpNetPay + (EmpPayeBenefit);
        "currentAmount(LCY)" := "EmpNetPay(LCY)" + ("EmpPayeBenefit(LCY)");

        if PayrollPostingGroup.Get("Posting Group") then begin
            "Account Type" := "account type"::"G/L Account";
            "Account No." := PayrollPostingGroup."Net Salary Payable";
        end;
        //Insert Into Monthly Transactions
        InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
           TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
           "Account No.", "posting type"::Credit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
           '', Department);
    end;

    local procedure CalculateProratedAmount("Employee No": Code[20]; "Basic Pay": Decimal; "Payroll Month": Integer; "Payroll Year": Integer; DaysInMonth: Integer; DaysWorked: Integer) Amount: Decimal
    begin
        Amount := ROUND((DaysWorked / DaysInMonth) * "Basic Pay");
    end;


    procedure GetDaysInMonth(dtDate: Date) DaysInMonth: Integer
    var
        Day: Integer;
        SysDate: Record Date;
        Expr1: Text[30];
        FirstDay: Date;
        LastDate: Date;
        TodayDate: Date;
    begin
        TodayDate := dtDate;

        Day := Date2dmy(TodayDate, 1);
        Expr1 := Format(-Day) + 'D+1D';
        FirstDay := CalcDate(Expr1, TodayDate);
        LastDate := CalcDate('1M-1D', FirstDay);

        SysDate.Reset;
        SysDate.SetRange(SysDate."Period Type", SysDate."period type"::Date);
        SysDate.SetRange(SysDate."Period Start", FirstDay, LastDate);
        if SysDate.FindSet then
            DaysInMonth := SysDate.Count;
    end;


    procedure GetDaysWorked(dtDate: Date; IsTermination: Boolean) DaysWorked: Integer
    var
        Day: Integer;
        SysDate: Record Date;
        Expr1: Text[30];
        FirstDay: Date;
        LastDate: Date;
        TodayDate: Date;
    begin
        TodayDate := dtDate;

        Day := Date2dmy(TodayDate, 1);
        Expr1 := Format(-Day) + 'D+1D';
        FirstDay := CalcDate(Expr1, TodayDate);
        LastDate := CalcDate('1M-1D', FirstDay);

        SysDate.Reset;
        SysDate.SetRange(SysDate."Period Type", SysDate."period type"::Date);
        if not IsTermination then
            SysDate.SetRange(SysDate."Period Start", dtDate, LastDate)
        else
            SysDate.SetRange(SysDate."Period Start", FirstDay, dtDate);
        if SysDate.FindSet then
            DaysWorked := SysDate.Count;
    end;


    procedure GetDaysWorkedTimesheet(EmployeeNo: Code[20]; PayrollPeriod: Date) DaysWorked: Integer
    var
        Day: Integer;
        SysDate: Record Date;
        Expr1: Text[30];
        FirstDay: Date;
        LastDate: Date;
        TodayDate: Date;
        EmployeeTimesheet: Record "HR Employee Timesheet.";
        BaseCalender: Record "Base Calendar";
        BaseCalenderLines: Record "Base Calendar Change";
        HRSetup: Record "HR General Setup.";
        NonWorkingDays: Integer;
        DayDate: Date;
        DayName: Text;
        Nonworking: Boolean;
        CalendarMgmt: Codeunit "Calendar Management";
    begin
        /* DaysWorked:=0;NonWorkingDays:=0;
         EmployeeTimesheet.RESET;
         EmployeeTimesheet.SETRANGE(EmployeeTimesheet."Employee No",EmployeeNo);
         EmployeeTimesheet.SETRANGE(EmployeeTimesheet."Period Month",DATE2DMY(PayrollPeriod,2));
         EmployeeTimesheet.SETRANGE(EmployeeTimesheet."Period Year",DATE2DMY(PayrollPeriod,3));
         IF EmployeeTimesheet.FINDSET THEN BEGIN
          REPEAT
             DaysWorked:=DaysWorked+1;
          UNTIL EmployeeTimesheet.NEXT=0;
         END;
         //Get Nonworking Days
         //Get the HR Base Calender
         IF HRSetup.GET THEN BEGIN
          FirstDay:=PayrollPeriod;
          LastDate:=CALCDATE('<CM>',FirstDay);
          SysDate.RESET;
          SysDate.SETRANGE(SysDate."Period Type",SysDate."Period Type"::Date);
          SysDate.SETRANGE(SysDate."Period Start",FirstDay,LastDate);
          IF SysDate.FINDSET THEN BEGIN
            REPEAT
              Nonworking := CalendarMgmt.CheckDateStatus(HRSetup."HR Base Calender",SysDate."Period Start",Description);
              IF Nonworking THEN
                NonWorkingDays:=NonWorkingDays+1;
            UNTIL SysDate.NEXT=0;
          END;
         END;
         //return days worked + non working days
         DaysWorked:=DaysWorked+NonWorkingDays;
         */

    end;

    local procedure CalculatePAYE(TaxablePay: Decimal; IsSecondary: Boolean) PAYE: Decimal
    var
        PAYESetup: Record "Payroll PAYE Setup.";
        TempAmount: Decimal;
        "Count": Integer;
    begin
        Count := 0;
        PAYESetup.Reset;
        if IsSecondary = false then begin
            if PAYESetup.FindFirst then begin
                if TaxablePay < PAYESetup."PAYE Tier" then exit;
                repeat
                    Count += 1;
                    TempAmount := TaxablePay;
                    if TaxablePay = 0 then exit;
                    if Count = PAYESetup.Count then   //If Last Record
                        TaxablePay := TempAmount
                    else                             //If Not Last Record
                        if TempAmount >= PAYESetup."PAYE Tier" then
                            TempAmount := PAYESetup."PAYE Tier"
                        else
                            TempAmount := TempAmount;

                    PAYE := PAYE + (TempAmount * (PAYESetup.Rate / 100));
                    TaxablePay := TaxablePay - TempAmount;
                until PAYESetup.Next = 0;
            end;
        end else begin
            if PAYESetup.FindLast then begin
                PAYE := TaxablePay * (PAYESetup.Rate / 100);
            end;
        end
    end;

    local procedure CalculateNHIF(BaseAmount: Decimal) NHIF: Decimal
    var
        NHIFSetup: Record "Payroll NHIF Setup.";
    begin
        NHIFSetup.Reset;
        NHIFSetup.SetCurrentkey(NHIFSetup."Tier Code");
        if NHIFSetup.FindSet then begin
            repeat
                if ((BaseAmount >= NHIFSetup."Lower Limit") and (BaseAmount <= NHIFSetup."Upper Limit")) then
                    NHIF := NHIFSetup.Amount;
            until NHIFSetup.Next = 0;
        end;
    end;

    local procedure CalculateEmployerNSSF(BaseAmount: Decimal) NSSF: Decimal
    var
        NSSFSetup: Record "Payroll NSSF Setup.";
    begin
        NSSFSetup.Reset;
        NSSFSetup.SetCurrentkey(NSSFSetup."Tier Code");
        if NSSFSetup.FindSet then begin
            repeat
                if ((BaseAmount >= NSSFSetup."Lower Limit") and (BaseAmount <= NSSFSetup."Upper Limit")) then
                    NSSF := NSSFSetup."Tier 1 Employer Contribution" + NSSFSetup."Tier 2 Employer Contribution";
            until NSSFSetup.Next = 0;
        end;
    end;

    local procedure CalculateEmployeeNSSF(BaseAmount: Decimal) NSSF: Decimal
    var
        NSSFSetup: Record "Payroll NSSF Setup.";
    begin
        NSSFSetup.Reset;
        NSSFSetup.SetCurrentkey(NSSFSetup."Tier Code");
        if NSSFSetup.FindSet then begin
            repeat
                if ((BaseAmount >= NSSFSetup."Lower Limit") and (BaseAmount <= NSSFSetup."Upper Limit")) then
                    NSSF := NSSFSetup."Tier 1 Employee Deduction" + NSSFSetup."Tier 2 Employee Deduction";
            until NSSFSetup.Next = 0;
        end;
    end;

    local procedure CalculateTaxablePay()
    begin
    end;

    local procedure CalculateNetPay()
    begin
    end;


    procedure CalculateLoanInterest(EmpCode: Code[20]; TransCode: Code[20]; InterestRate: Decimal; RecoveryMethod: Option Reducing,"Straight line",Amortized; LoanAmount: Decimal; Balance: Decimal; CurrPeriod: Date; Welfare: Boolean) LnInterest: Decimal
    var
        curLoanInt: Decimal;
        intMonth: Integer;
        intYear: Integer;
    begin
        intMonth := Date2dmy(CurrPeriod, 2);
        intYear := Date2dmy(CurrPeriod, 3);

        curLoanInt := 0;

        if InterestRate > 0 then begin
            if RecoveryMethod = Recoverymethod::"Straight line" then //Straight Line Method [1]
                curLoanInt := (InterestRate / 1200) * LoanAmount;

            if RecoveryMethod = Recoverymethod::Reducing then //Reducing Balance [0]

                 curLoanInt := (InterestRate / 1200) * Balance;

            if RecoveryMethod = Recoverymethod::Amortized then //Amortized [2]
                curLoanInt := (InterestRate / 1200) * Balance;
        end else
            curLoanInt := 0;

        //Return the Amount
        LnInterest := ROUND(curLoanInt);
    end;

    local procedure CalculateSpecialTrans(EmpCode: Code[20]; Month: Integer; Year: Integer; TransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage; CompDeduction: Boolean) TransAmount: Decimal
    var
        EmployeeTransactions: Record "Payroll Employee Transactions.";
        TransactionCodes: Record "Payroll Transaction Code.";
        TransFormula: Text[250];
    begin
        TransAmount := 0;
        TransactionCodes.Reset;
        TransactionCodes.SetRange(TransactionCodes."Special Transaction", TransID);
        if TransactionCodes.FindSet then begin
            repeat
                EmployeeTransactions.Reset;
                EmployeeTransactions.SetRange(EmployeeTransactions."No.", EmpCode);
                EmployeeTransactions.SetRange(EmployeeTransactions."Transaction Code", TransactionCodes."Transaction Code");
                EmployeeTransactions.SetRange(EmployeeTransactions."Period Month", Month);
                EmployeeTransactions.SetRange(EmployeeTransactions."Period Year", Year);
                EmployeeTransactions.SetRange(EmployeeTransactions.Suspended, false);
                if EmployeeTransactions.FindFirst then begin
                    case TransID of
                        Transid::"Defined Contribution":
                            if TransactionCodes."Is Formulae" then begin
                                TransFormula := '';
                                TransFormula := ExpandFormula(EmployeeTransactions."No.", Month, Year, TransactionCodes.Formulae);
                                TransAmount := TransAmount + FormulaResult(TransFormula);
                            end else
                                TransAmount := TransAmount + EmployeeTransactions.Amount;

                        Transid::"Life Insurance":
                            TransAmount := TransAmount + ((InsuranceRelief / 100) * EmployeeTransactions.Amount);

                        Transid::"Owner Occupier Interest":
                            TransAmount := TransAmount + EmployeeTransactions.Amount;


                        Transid::"Home Ownership Savings Plan":
                            TransAmount := TransAmount + EmployeeTransactions.Amount;

                        Transid::Morgage:
                            begin
                                TransAmount := TransAmount + MorgageRelief;
                                if TransAmount > MorgageRelief then begin
                                    TransAmount := MorgageRelief
                                end;
                            end;

                    end;
                end;
            until TransactionCodes.Next = 0;
        end;
        TransAmount := TransAmount;
    end;

    local procedure InsertMonthlyTransactions(EmpNo: Code[20]; TransCode: Code[20]; TransType: Code[20]; Grouping: Integer; SubGrouping: Integer; Description: Text[50]; Amount: Decimal; "Amount(LCY)": Decimal; Balance: Decimal; "Balance(LCY)": Decimal; "Payroll Period": Date; Month: Integer; Year: Integer; "Account Type": Option " ","G/L Account",Customer,Vendor; "Account No": Code[20]; "Posting Type": Option " ",Debit,Credit; "Global Dimension 1 Code": Code[50]; "Global Dimension 2 Code": Code[50]; Membership: Text[30]; ReferenceNo: Text[30]; Department: Code[20])
    var
        MonthlyTransactions: Record "Payroll Monthly Transactions.";
        PayrollEmployee: Record "Payroll Employee.";
    begin
        if currentAmount = 0 then exit;
        MonthlyTransactions.Init;
        MonthlyTransactions."No." := EmpNo;
        MonthlyTransactions."Transaction Code" := TransCode;
        MonthlyTransactions."Group Text" := TransType;
        MonthlyTransactions."Transaction Name" := Description;
        MonthlyTransactions.Amount := ROUND(Amount);
        MonthlyTransactions."Amount(LCY)" := ROUND("Amount(LCY)");
        MonthlyTransactions.Balance := Balance;
        MonthlyTransactions."Balance(LCY)" := "Balance(LCY)";
        MonthlyTransactions.Grouping := Grouping;
        MonthlyTransactions.SubGrouping := SubGrouping;
        MonthlyTransactions.Membership := Membership;
        MonthlyTransactions."Reference No" := ReferenceNo;
        MonthlyTransactions."Period Month" := Month;
        MonthlyTransactions."Period Year" := Year;
        MonthlyTransactions."Payroll Period" := "Payroll Period";
        //MonthlyTransactions."Department Code":=Department;
        MonthlyTransactions."Posting Type" := "Posting Type";
        MonthlyTransactions."Account Type" := "Account Type";
        MonthlyTransactions."Account No" := "Account No";
        //MonthlyTransactions."Payroll Code":=PayrollCode;
        MonthlyTransactions."Global Dimension 1" := "Global Dimension 1 Code";
        MonthlyTransactions."Global Dimension 2" := "Global Dimension 2 Code";
        if PayrollEmployee.Get(EmpNo) then
            MonthlyTransactions."Payment Mode" := PayrollEmployee."Payment Mode";

        if MonthlyTransactions.Insert then
            //Update Employee Transactions  with the Amount
            UpdateEmployeeTransactions(EmpNo, TransCode, Amount, "Amount(LCY)", "Payroll Period", Month, Year);
    end;

    local procedure UpdateEmployeeTransactions(EmpNo: Code[20]; TransCode: Code[20]; Amount: Decimal; "Amount(LCY)": Decimal; PayrollPeriod: Date; Month: Integer; Year: Integer)
    var
        PayrollEmpTrans: Record "Payroll Employee Transactions.";
    begin
        PayrollEmpTrans.Reset;
        PayrollEmpTrans.SetRange(PayrollEmpTrans."No.", EmpNo);
        PayrollEmpTrans.SetRange(PayrollEmpTrans."Transaction Code", TransCode);
        PayrollEmpTrans.SetRange(PayrollEmpTrans."Payroll Period", PayrollPeriod);
        PayrollEmpTrans.SetRange(PayrollEmpTrans."Period Month", Month);
        PayrollEmpTrans.SetRange(PayrollEmpTrans."Period Year", Year);
        if PayrollEmpTrans.FindFirst then begin
            PayrollEmpTrans.Amount := Amount;
            PayrollEmpTrans."Amount(LCY)" := "Amount(LCY)";
            PayrollEmpTrans.Modify;
        end;
    end;

    local procedure InsertEmployeeDeductions()
    begin
    end;

    local procedure InsertEmployerDeductions(EmpCode: Code[20]; TransCode: Code[20]; TransType: Code[20]; Grouping: Integer; SubGrouping: Integer; Description: Text[50]; currentAmount: Decimal; "currentAmount(LCY)": Decimal; currentBalance: Decimal; "currentBalance(LCY)": Decimal; Month: Integer; Year: Integer; Membership: Text[30]; ReferenceNo: Text[30]; PayrollPeriod: Date; PayrollCode: Code[20])
    var
        EmployerDeductions: Record "Payroll Employer Deductions.";
    begin
        if currentAmount = 0 then exit;
        with EmployerDeductions do begin
            Init;
            "Employee Code" := EmpCode;
            "Transaction Code" := TransCode;
            Amount := currentAmount;
            "Period Month" := Month;
            "Period Year" := Year;
            "Payroll Period" := PayrollPeriod;
            "Payroll Code" := PayrollCode;
            "Amount(LCY)" := "currentAmount(LCY)";
            Group := Grouping;
            SubGroup := SubGrouping;
            "Transaction Type" := TransType;
            Description := Description;
            Balance := currentBalance;
            "Balance(LCY)" := "currentBalance(LCY)";
            "Membership No" := Membership;
            "Reference No" := ReferenceNo;
            Insert;
        end;
    end;

    local procedure RemoveEmployerDeduction(EmpCode: Code[20]; TransCode: Code[20]; Month: Integer; Year: Integer)
    var
        "Payroll Employer Ded": Record "Payroll Employer Deductions.";
    begin
        "Payroll Employer Ded".Reset;
        "Payroll Employer Ded".SetRange("Payroll Employer Ded"."Employee Code", EmpCode);
        "Payroll Employer Ded".SetRange("Payroll Employer Ded"."Transaction Code", TransCode);
        "Payroll Employer Ded".SetRange("Payroll Employer Ded"."Period Month", Month);
        "Payroll Employer Ded".SetRange("Payroll Employer Ded"."Period Year", Year);
        if "Payroll Employer Ded".FindSet then
            "Payroll Employer Ded".DeleteAll;
    end;

    local procedure InsertSalaryArrears()
    begin
    end;

    local procedure InsertP9Information()
    begin
    end;

    local procedure ExpandFormula(EmpNo: Code[20]; Month: Integer; Year: Integer; strFormula: Text[250]) Formula: Text[250]
    var
        Where: Text[30];
        Which: Text[30];
        i: Integer;
        TransCode: Code[20];
        Char: Text[1];
        FirstBracket: Integer;
        StartCopy: Boolean;
        FinalFormula: Text[250];
        TransCodeAmount: Decimal;
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit AccSchedManagement;
    begin
        TransCode := '';
        for i := 1 to StrLen(strFormula) do begin
            Char := CopyStr(strFormula, i, 1);
            if Char = '[' then StartCopy := true;

            if StartCopy then TransCode := TransCode + Char;
            //Copy Characters as long as is not within []
            if not StartCopy then
                FinalFormula := FinalFormula + Char;
            if Char = ']' then begin
                StartCopy := false;
                //Get Transcode
                Where := '=';
                Which := '[]';
                TransCode := DelChr(TransCode, Where, Which);
                //Get TransCodeAmount
                TransCodeAmount := GetTransAmount(EmpNo, TransCode, Month, Year);
                //Reset Transcode
                TransCode := '';
                //Get Final Formula
                FinalFormula := FinalFormula + Format(TransCodeAmount);
                //End Get Transcode
            end;
        end;
        Formula := FinalFormula;
    end;

    local procedure GetTransAmount(EmpNo: Code[20]; TransCode: Code[20]; Month: Integer; Year: Integer) TransAmount: Decimal
    var
        EmployeeTransactions: Record "Payroll Employee Transactions.";
        MonthlyTransactions: Record "Payroll Monthly Transactions.";
        EmpPayrollCard: Record "Payroll Employee.";
    begin
        EmployeeTransactions.Reset;
        EmployeeTransactions.SetRange(EmployeeTransactions."No.", EmpNo);
        EmployeeTransactions.SetRange(EmployeeTransactions."Transaction Code", TransCode);
        EmployeeTransactions.SetRange(EmployeeTransactions."Period Month", Month);
        EmployeeTransactions.SetRange(EmployeeTransactions."Period Year", Year);
        EmployeeTransactions.SetRange(EmployeeTransactions.Suspended, false);
        if EmployeeTransactions.FindFirst then begin
            TransAmount := EmployeeTransactions.Amount;
            if EmployeeTransactions."No of Units" <> 0 then
                TransAmount := EmployeeTransactions."No of Units";
        end;

        if TransAmount = 0 then begin
            MonthlyTransactions.Reset;
            MonthlyTransactions.SetRange(MonthlyTransactions."No.", EmpNo);
            MonthlyTransactions.SetRange(MonthlyTransactions."Transaction Code", TransCode);
            MonthlyTransactions.SetRange(MonthlyTransactions."Period Month", Month);
            MonthlyTransactions.SetRange(MonthlyTransactions."Period Year", Year);
            if MonthlyTransactions.FindFirst then
                TransAmount := MonthlyTransactions.Amount;
        end;

        if (TransAmount = 0) and (TransCode = 'BPAY') then begin
            EmpPayrollCard.Reset;
            EmpPayrollCard.SetRange(EmpPayrollCard."No.", EmpNo);
            if EmpPayrollCard.FindFirst then begin
                TransAmount := EmpPayrollCard."Basic Pay";
            end;
        end;
    end;

    local procedure FormulaResult(Formula: Text[250]) Results: Decimal
    var
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit AccSchedManagement;
    begin
        // Results:=AccSchedMgt. (true,Formula,AccSchedLine,ColumnLayout,CalcAddCurr);
    end;


    procedure ClosePayrollPeriod(CurrentPayrollPeriod: Date)
    var
        NewPayrollPeriod: Date;
        NewYear: Integer;
        NewMonth: Integer;
    begin
        //-----------------------------------------------------
        /*
        ControlInfo.GET();
        curGOKAmount:=0;
        curKVBAmount:=0;
        NewPayrollPeriod := CALCDATE('1M',CurrentPayrollPeriod);
        
        NewYear:= DATE2DMY(NewPayrollPeriod,3);
        NewMonth:= DATE2DMY(NewPayrollPeriod,2);
        
        CurrentMonth:= DATE2DMY(CurrentPayrollPeriod,2);
        CurrentYear:= DATE2DMY(CurrentPayrollPeriod,3);
        
        Month := DATE2DMY(CurrentPayrollPeriod,2);
        Year := DATE2DMY(CurrentPayrollPeriod,3);
        
        EmployeeTransactions.RESET;
        EmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Month",intMonth);
        EmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Year",intYear);
        {
        //Multiple Payroll
        IF ControlInfo."Multiple Payroll" THEN BEGIN
            prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Payroll Code",PayrollCode);
        END;
        }
        IF prEmployeeTransactions.FINDSET THEN BEGIN
          REPEAT
           prTransactionCodes.RESET;
           prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Code",prEmployeeTransactions."Transaction Code");
           IF prTransactionCodes.FIND('-') THEN BEGIN
            WITH prTransactionCodes DO BEGIN
              CASE prTransactionCodes."Balance Type" OF
                prTransactionCodes."Balance Type"::None:
                 BEGIN
                  curTransAmount:=prEmployeeTransactions.Amount;
                  curKVBAmount:=prEmployeeTransactions."KVB Amount";
                  curGOKAmount:=prEmployeeTransactions."GOK Amount";
                  curTransBalance:= 0;
                 END;
                prTransactionCodes."Balance Type"::Increasing:
                 BEGIN
                   curTransAmount := prEmployeeTransactions.Amount;
                   curKVBAmount:=prEmployeeTransactions."KVB Amount";
                   curGOKAmount:=prEmployeeTransactions."GOK Amount";
                   curTransBalance := prEmployeeTransactions.Balance + prEmployeeTransactions.Amount;
                 END;
                prTransactionCodes."Balance Type"::Reducing:
                 BEGIN
                   curTransAmount := prEmployeeTransactions.Amount;
                   curKVBAmount:=prEmployeeTransactions."KVB Amount";
                   curGOKAmount:=prEmployeeTransactions."GOK Amount";
        
                   IF prEmployeeTransactions.Balance < prEmployeeTransactions.Amount THEN BEGIN
                       curTransAmount := prEmployeeTransactions.Balance;
                       curTransBalance := 0;
                   END ELSE BEGIN
                       curTransBalance := prEmployeeTransactions.Balance - prEmployeeTransactions.Amount;
                   END;
                   IF curTransBalance < 0 THEN
                    BEGIN
                       curTransAmount:=0;
                       curTransBalance:=0;
                    END;
                  END;
              END;
            END;
           END;
        
            //For those transactions with Start and End Date Specified
               IF (prEmployeeTransactions."Start Date"<>0D) AND (prEmployeeTransactions."End Date"<>0D) THEN BEGIN
                   IF prEmployeeTransactions."End Date"<dtNewPeriod THEN BEGIN
                       curTransAmount:=0;
                       curTransBalance:=0;
                   END;
               END;
            //End Transactions with Start and End Date
        
          IF (prTransactionCodes.Frequency=prTransactionCodes.Frequency::Fixed) AND
             (prEmployeeTransactions."Stop for Next Period"=FALSE) THEN
           BEGIN
            IF (curTransAmount <> 0) OR (curKVBAmount <> 0) OR (curGOKAmount <> 0) THEN  //Update the employee transaction table
             BEGIN
             IF ((prTransactionCodes."Balance Type"=prTransactionCodes."Balance Type"::Reducing) AND (curTransBalance <> 0)) OR
              (prTransactionCodes."Balance Type"<>prTransactionCodes."Balance Type"::Reducing) THEN
              prEmployeeTransactions.Balance:=curTransBalance;
              prEmployeeTransactions.MODIFY;
        
        
           //Insert record for the next period
            WITH prEmployeeTrans DO BEGIN
              INIT;
              "Employee Code":= prEmployeeTransactions."Employee Code";
              "Transaction Code":= prEmployeeTransactions."Transaction Code";
              "Transaction Name":= prEmployeeTransactions."Transaction Name";
               Amount:= curTransAmount;
               "KVB Amount":=curKVBAmount;
               "GOK Amount":=curGOKAmount;
               Balance:= curTransBalance;
               "Amortized Loan Total Repay Amt":=prEmployeeTransactions. "Amortized Loan Total Repay Amt";
              "Original Amount":= prEmployeeTransactions."Original Amount";
               Membership:= prEmployeeTransactions.Membership;
              "Reference No":= prEmployeeTransactions."Reference No";
              "Loan Number":=prEmployeeTransactions."Loan Number";
              "Period Month":= intNewMonth;
              "Period Year":= intNewYear;
              "Payroll Period":= dtNewPeriod;
              "Payroll Code" :=PayrollCode;
               INSERT;
              END;
          END;
          END
          UNTIL prEmployeeTransactions.NEXT=0;
        
        {-----No idea of what this is for-----------------------------
        prsalCard.RESET;
        IF prsalCard.FIND('-') THEN BEGIN
          REPEAT
          BEGIN
          IF prsalCard."Current Round Up">0 THEN BEGIN
            WITH prEmployeeTrans DO BEGIN
              INIT;
              "Employee Code":= prsalCard."Employee Code";
              "Transaction Code":= 'D066';
              "Transaction Name":= 'Rounding Up Effect';
               Amount:= prsalCard."Current Round Up";
              "Period Month":= intNewMonth;
              "Period Year":= intNewYear;
              "Payroll Period":= dtNewPeriod;
              "Payroll Code" :=PayrollCode;
               INSERT;
             END;
             END ELSE IF prsalCard."Current Round Down">0 THEN BEGIN
            WITH prEmployeeTrans DO BEGIN
              INIT;
              "Employee Code":= prsalCard."Employee Code";
              "Transaction Code":= 'P021';
              "Transaction Name":= 'Rounding Down Effect';
               Amount:= prsalCard."Current Round Down";
              "Period Month":= intNewMonth;
              "Period Year":= intNewYear;
              "Payroll Period":= dtNewPeriod;
              "Payroll Code" :=PayrollCode;
               INSERT;
             END;
             END;
        
            prsalCard."Preveous Round Down":=prsalCard."Current Round Down";
            prsalCard."Preveous Round Up":=prsalCard."Current Round Up";
            prsalCard."Period Month":=intNewMonth;
            prsalCard."Period Year":=intNewYear;
            prsalCard."Current Round Down":=0;
            prsalCard."Current Round Up":=0;
            prsalCard."Current Month":=intOldMonth;
            prsalCard."Current Year":=intOldYear;
            prsalCard.MODIFY;
          END;
          UNTIL prsalCard.NEXT=0;
        END;
        -----No idea of what this is for-----------------------------}
        END;
        
        //Update the Period as Closed
        prPayrollPeriods.RESET;
        prPayrollPeriods.SETRANGE(prPayrollPeriods."Period Month",intMonth);
        prPayrollPeriods.SETRANGE(prPayrollPeriods."Period Year",intYear);
        prPayrollPeriods.SETRANGE(prPayrollPeriods.Closed,FALSE);
        IF ControlInfo."Multiple Payroll" THEN
            prPayrollPeriods.SETRANGE(prPayrollPeriods."Payroll Code",PayrollCode);
        
        IF prPayrollPeriods.FIND('-') THEN BEGIN
           prPayrollPeriods.Closed:=TRUE;
           prPayrollPeriods."Date Closed":=TODAY;
           prPayrollPeriods.MODIFY;
        END;
        
        //Enter a New Period
        WITH prNewPayrollPeriods DO BEGIN
          INIT;
            "Period Month":=intNewMonth;
            "Period Year":= intNewYear;
            "Period Name":= FORMAT(dtNewPeriod,0,'<Month Text>')+' - '+FORMAT(intNewYear);
            "Date Opened":= dtNewPeriod;
             Closed :=FALSE;
             "Payroll Code":=PayrollCode;
            INSERT;
        END;
        
        //Effect the transactions for the P9
        fnP9PeriodClosure (intMonth, intYear, dtOpenPeriod,PayrollCode);
        
        //Take all the Negative pay (Net) for the current month & treat it as a deduction in the new period
        fnGetNegativePay(intMonth, intYear,dtOpenPeriod);*/
        //-----------------------------------------------------------------------------------

    end;
}

