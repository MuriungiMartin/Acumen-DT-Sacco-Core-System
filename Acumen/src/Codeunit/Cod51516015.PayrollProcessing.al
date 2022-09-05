#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516015 "Payroll Processing"
{
    // ++Note
    // Tax on Excess Pension Not Clear /Not indicated anywhere
    // Low Interest Benefits
    // VOQ


    trigger OnRun()
    begin
    end;

    var
        Text020: label 'Because of circular references, the program cannot calculate a formula.';
        Text012: label 'You have entered an illegal value or a nonexistent row number.';
        Text013: label 'You have entered an illegal value or a nonexistent column number.';
        Text017: label 'The error occurred when the program tried to calculate:\';
        Text018: label 'Acc. Sched. Line: Row No. = %1, Line No. = %2, Totaling = %3\';
        Text019: label 'Acc. Sched. Column: Column No. = %4, Line No. = %5, Formula  = %6';
        Text023: label 'Formulas ending with a percent sign require %2 %1 on a line before it.';
        NHFLACUMEN: Decimal;
        VitalSetup: Record "Payroll General Setup.";
        curReliefPersonal: Decimal;
        curReliefInsurance: Decimal;
        curReliefMorgage: Decimal;
        curMaximumRelief: Decimal;
        SFR: Decimal;
        curNssfEmployee: Decimal;
        DUEDATE: Date;
        curNssf_Employer_Factor: Decimal;
        prNHIF: Record "Payroll NHIF Setup.";
        intNHIF_BasedOn: Option Gross,Basic,"Taxable Pay";
        intNSSF_BasedOn: Option Gross,Basic,"Taxable Pay";
        curMaxPensionContrib: Decimal;
        curRateTaxExPension: Decimal;
        curOOIMaxMonthlyContrb: Decimal;
        curOOIDecemberDedc: Decimal;
        curLoanMarketRate: Decimal;
        curLoanCorpRate: Decimal;
        PostingGroup: Record "Payroll Posting Groups.";
        TaxAccount: Code[20];
        salariesAcc: Code[20];
        PayablesAcc: Code[20];
        NSSFR: Decimal;
        NSSFEMPyer: Code[20];
        PensionEMPyer: Code[20];
        NSSFEMPyee: Code[20];
        NHIFEMPyer: Code[20];
        NHIFEMPyee: Code[20];
        HrEmployee: Record "Payroll Employee.";
        CoopParameters: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF,Overtime,DevShare,NHIF;
        PayrollType: Code[20];
        SpecialTranAmount: Decimal;
        EmpSalary: Record "Payroll Employee.";
        txBenefitAmt: Decimal;
        TelTaxACC: Code[20];
        loans: Record "Loans Register";
        Management: Boolean;


    procedure fnInitialize()
    begin
        //Initialize Global Setup Items

        HrEmployee.Reset;
        HrEmployee.SetRange(HrEmployee."No.", HrEmployee."No.");
        if HrEmployee.Find('-') then
            // MESSAGE(FORMAT(HrEmployee."No."));
            VitalSetup.FindFirst;
        with VitalSetup do begin
            curReliefPersonal := "Tax Relief";
            curReliefInsurance := "Insurance Relief";
            curReliefMorgage := HrEmployee."Morgage Relief";
            NSSFR := 0;
            //MESSAGE(FORMAT(curReliefMorgage));
            //"Mortgage Relief"; //Same as HOSP
            curMaximumRelief := "Max Relief";
            curNssfEmployee := "NSSF Employee";
            curNssf_Employer_Factor := "NSSF Employer Factor";
            intNHIF_BasedOn := "NHIF Based on";
            curMaxPensionContrib := "Max Pension Contribution";
            curRateTaxExPension := "Tax On Excess Pension";
            curOOIMaxMonthlyContrb := "OOI Deduction";
            curOOIDecemberDedc := "OOI December";
            curLoanMarketRate := "Loan Market Rate";
            curLoanCorpRate := "Loan Corporate Rate";


        end;
    end;


    procedure fnProcesspayroll(strEmpCode: Code[20]; dtDOE: Date; curBasicPay: Decimal; blnPaysPaye: Boolean; blnPaysNssf: Boolean; blnPaysNhif: Boolean; SelectedPeriod: Date; dtOpenPeriod: Date; Membership: Text[30]; ReferenceNo: Text[30]; dtTermination: Date; blnGetsPAYERelief: Boolean; Dept: Code[20]; PayrollCode: Code[20])
    var
        strTableName: Text[50];
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        strTransDescription: Text[50];
        TGroup: Text[30];
        TGroupOrder: Integer;
        TSubGroupOrder: Integer;
        curSalaryArrears: Decimal;
        curPayeArrears: Decimal;
        curGrossPay: Decimal;
        curTotAllowances: Decimal;
        curExcessPension: Decimal;
        curNSSF: Decimal;
        curDefinedContrib: Decimal;
        curPensionStaff: Decimal;
        curNonTaxable: Decimal;
        curGrossTaxable: Decimal;
        curBenefits: Decimal;
        curValueOfQuarters: Decimal;
        curUnusedRelief: Decimal;
        curInsuranceReliefAmount: Decimal;
        curMorgageReliefAmount: Decimal;
        curTaxablePay: Decimal;
        curTaxCharged: Decimal;
        curPAYE: Decimal;
        prPeriodTransactions: Record "prPeriod Transactions.";
        intYear: Integer;
        intMonth: Integer;
        LeapYear: Boolean;
        CountDaysofMonth: Integer;
        DaysWorked: Integer;
        prSalaryArrears: Record "Payroll Salary Arrears.";
        prEmployeeTransactions: Record "Payroll Employee Transactions.";
        prTransactionCodes: Record "Payroll Transaction Code.";
        strExtractedFrml: Text[250];
        SpecialTransType: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage;
        TransactionType: Option Income,Deduction;
        curPensionCompany: Decimal;
        curTaxOnExcessPension: Decimal;
        prUnusedRelief: Record "Employee Unused Relief.";
        curNhif_Base_Amount: Decimal;
        curNHIF: Decimal;
        curTotalDeductions: Decimal;
        curNetRnd_Effect: Decimal;
        curNetPay: Decimal;
        curTotCompanyDed: Decimal;
        curOOI: Decimal;
        curHOSP: Decimal;
        curLoanInt: Decimal;
        strTransCode: Text[250];
        fnCalcFringeBenefit: Decimal;
        prEmployerDeductions: Record "Payroll Employer Deductions.";
        JournalPostingType: Option " ","G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Staff,"None",Member;
        JournalAcc: Code[20];
        Customer: Record Customer;
        JournalPostAs: Option " ",Debit,Credit;
        IsCashBenefit: Decimal;
        Teltax: Decimal;
        Teltax2: Decimal;
        prEmployeeTransactions2: Record "Payroll Employee Transactions.";
        prTransactionCodes3: Record "Payroll Transaction Code.";
        curTransAmount2: Decimal;
        curNssf_Base_Amount: Decimal;
        CurrInsuranceRel: Decimal;
        EmployeeP: Record "Payroll Employee.";
    begin
        //Initialize
        fnInitialize;
        fnGetJournalDet(strEmpCode);
        //PayrollType
        PayrollType := PayrollCode;

        if EmployeeP.Get(strEmpCode) then
            Management := EmployeeP."Is Management";

        //check if the period selected=current period. If not, do NOT run this function
        if SelectedPeriod <> dtOpenPeriod then exit;
        intMonth := Date2dmy(SelectedPeriod, 2);
        intYear := Date2dmy(SelectedPeriod, 3);

        if curBasicPay > 0 then begin
            //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
            if (Date2dmy(dtDOE, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                CountDaysofMonth := fnDaysInMonth(dtDOE);
                DaysWorked := fnDaysWorked(dtDOE, false);
                curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth)
            end;

            //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
            if dtTermination <> 0D then begin
                if (Date2dmy(dtTermination, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                    CountDaysofMonth := fnDaysInMonth(dtTermination);
                    DaysWorked := fnDaysWorked(dtTermination, true);
                    curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth)
                end;
            end;

            curTransAmount := curBasicPay;
            strTransDescription := 'Basic Pay';
            TGroup := 'BASIC SALARY';
            TGroupOrder := 1;
            TSubGroupOrder := 1;
            fnUpdatePeriodTrans(strEmpCode, 'BPAY', TGroup, TGroupOrder,
            TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept,
            salariesAcc, Journalpostas::Debit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

            //Salary Arrears
            prSalaryArrears.Reset;
            prSalaryArrears.SetRange(prSalaryArrears."Employee Code", strEmpCode);
            prSalaryArrears.SetRange(prSalaryArrears."Period Month", intMonth);
            prSalaryArrears.SetRange(prSalaryArrears."Period Year", intYear);
            if prSalaryArrears.Find('-') then begin
                repeat
                    curSalaryArrears := prSalaryArrears."Salary Arrears";
                    curPayeArrears := prSalaryArrears."PAYE Arrears";

                    //Insert [Salary Arrears] into period trans [ARREARS]
                    curTransAmount := curSalaryArrears;
                    strTransDescription := 'Salary Arrears';
                    TGroup := 'ARREARS';
                    TGroupOrder := 1;
                    TSubGroupOrder := 2;
                    fnUpdatePeriodTrans(strEmpCode, prSalaryArrears."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                      strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept, salariesAcc,
                      Journalpostas::Debit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

                    //Insert [PAYE Arrears] into period trans [PYAR]
                    curTransAmount := curPayeArrears;
                    strTransDescription := 'P.A.Y.E Arrears';
                    TGroup := 'STATUTORIES';
                    TGroupOrder := 7;
                    TSubGroupOrder := 4;
                    fnUpdatePeriodTrans(strEmpCode, 'PYAR', TGroup, TGroupOrder, TSubGroupOrder,
                       strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept,
                       TaxAccount, Journalpostas::Debit, Journalpostingtype::"G/L Account", '', Coopparameters::none)

                until prSalaryArrears.Next = 0;
            end;

            //Get Earnings
            prEmployeeTransactions.Reset;
            prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
            // prEmployeeTransactions.SETRANGE(prEmployeeTransactions.Suspended,FALSE);
            if prEmployeeTransactions.Find('-') then begin
                curTotAllowances := 0;
                IsCashBenefit := 0;
                repeat
                    prTransactionCodes.Reset;
                    prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                    prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."transaction type"::Income);
                    //prTransactionCodes.SETRANGE(prTransactionCodes."Special Transaction",prTransactionCodes."Special Transaction"::Ignore);
                    if prTransactionCodes.Find('-') then begin
                        curTransAmount := 0;
                        curTransBalance := 0;
                        strTransDescription := '';
                        strExtractedFrml := '';
                        if prTransactionCodes."Is Formulae" then begin
                            if Management then
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Formula for Management Prov")
                            else
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formulae);

                            curTransAmount := ROUND(fnFormulaResult(strExtractedFrml), 0.05, '<'); //Get the calculated amount

                        end else begin
                            curTransAmount := prEmployeeTransactions.Amount;
                        end;

                        if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::None then //[0=None, 1=Increasing, 2=Reducing]
                            curTransBalance := 0;
                        if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Increasing then
                            curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
                        if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Reducing then
                            curTransBalance := prEmployeeTransactions.Balance - curTransAmount;


                        //Prorate Allowances Here
                        //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
                        if (Date2dmy(dtDOE, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                            CountDaysofMonth := fnDaysInMonth(dtDOE);
                            DaysWorked := fnDaysWorked(dtDOE, false);
                            curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
                        end;

                        //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                        if dtTermination <> 0D then begin
                            if (Date2dmy(dtTermination, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                                CountDaysofMonth := fnDaysInMonth(dtTermination);
                                DaysWorked := fnDaysWorked(dtTermination, true);
                                curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
                            end;
                        end;
                        // Prorate Allowances Here



                        //Add Non Taxable Here
                        if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transaction" =
                        prTransactionCodes."special transaction"::Ignore) then
                            curNonTaxable := curNonTaxable + curTransAmount;


                        //Added to ensure special transaction that are not taxable are not inlcuded in list of Allowances
                        if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transaction" <>
                        prTransactionCodes."special transaction"::Ignore) then
                            curTransAmount := 0;


                        curTotAllowances := curTotAllowances + curTransAmount; //Sum-up all the allowances
                        curTransAmount := curTransAmount;
                        curTransBalance := curTransBalance;
                        strTransDescription := prTransactionCodes."Transaction Name";
                        TGroup := 'ALLOWANCE';
                        TGroupOrder := 3;
                        TSubGroupOrder := 0;


                        //Get the posting Details
                        JournalPostingType := Journalpostingtype::" ";
                        JournalAcc := '';
                        if prTransactionCodes.SubLedger <> prTransactionCodes.Subledger::" " then begin
                            if prTransactionCodes.SubLedger = prTransactionCodes.Subledger::Customer then begin

                                HrEmployee.Get(strEmpCode);
                                Customer.Reset;
                                Customer.SetRange(Customer."No.", HrEmployee."Sacco Membership No.");
                                if Customer.Find('-') then begin
                                    JournalAcc := Customer."No.";
                                    JournalPostingType := Journalpostingtype::Member;

                                end;
                            end;
                        end else begin
                            JournalAcc := prTransactionCodes."G/L Account";
                            JournalPostingType := Journalpostingtype::"G/L Account";
                        end;

                        //Get is Cash Benefits
                        if prTransactionCodes."Is Cash" then
                            IsCashBenefit := IsCashBenefit + curTransAmount;
                        //End posting Details

                        fnUpdatePeriodTrans(strEmpCode, prTransactionCodes."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                        strTransDescription, curTransAmount, curTransBalance, intMonth, intYear, prEmployeeTransactions.Membership,
                        prEmployeeTransactions."Reference No", SelectedPeriod, Dept, JournalAcc, Journalpostas::Debit, JournalPostingType, '',
                        prTransactionCodes."Co-Op Parameters");

                    end;
                until prEmployeeTransactions.Next = 0;
            end;


            //Calc GrossPay = (BasicSalary + Allowances + SalaryArrears) [Group Order = 4]
            curGrossPay := (curBasicPay + curTotAllowances + curSalaryArrears);
            curTransAmount := curGrossPay;
            strTransDescription := 'Gross Pay';
            TGroup := 'GROSS PAY';
            TGroupOrder := 4;
            TSubGroupOrder := 0;
            fnUpdatePeriodTrans(strEmpCode, 'GPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth,
             intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '', Coopparameters::none);

            //Get the NSSF amount

            //Get the N.S.S.F amount for the month GBT
            curNssf_Base_Amount := 0;

            if intNSSF_BasedOn = Intnssf_basedon::Gross then //>NHIF calculation can be based on:
                curNssf_Base_Amount := curGrossPay;
            if intNSSF_BasedOn = Intnssf_basedon::Basic then
                curNssf_Base_Amount := curBasicPay;



            if blnPaysNssf then
                // curNSSF := curNssfEmployee;
                curNSSF := 200;              //fnGetEmployeeNSSF(curNssf_Base_Amount);client using the old rates
            curTransAmount := 200;// curNSSF;
            curNSSF := 200;// curNSSF;
            strTransDescription := 'N.S.S.F';
            TGroup := 'STATUTORIES';
            TGroupOrder := 7;
            TSubGroupOrder := 1;
            fnUpdatePeriodTrans(strEmpCode, 'NSSF', TGroup, TGroupOrder, TSubGroupOrder,
            strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, NSSFEMPyee,
            Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::NSSF);


            //Get the Defined contribution to post based on the Max Def contrb allowed   ****************All Defined Contributions not included
            curDefinedContrib := 200;//curNSSF; //(curNSSF + curPensionStaff + curNonTaxable) - curMorgageReliefAmount
            curTransAmount := curDefinedContrib;
            strTransDescription := 'Defined Contributions';
            TGroup := 'TAX CALCULATIONS';
            TGroupOrder := 6;
            TSubGroupOrder := 1;

            fnUpdatePeriodTrans(strEmpCode, 'DEFCON', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth,
            intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '', Coopparameters::none);


            //Get the Gross taxable amount
            //>GrossTaxable = Gross + Benefits + nValueofQuarters  ******Confirm CurValueofQuaters
            curGrossTaxable := curGrossPay + curBenefits + curValueOfQuarters;

            //>If GrossTaxable = 0 Then TheDefinedToPost = 0
            if curGrossTaxable = 0 then curDefinedContrib := 0;


            VitalSetup.Get();
            //Get Insurance Relief
            /*EmployeeP.RESET;
            EmployeeP.SETRANGE(EmployeeP."No.",strEmpCode);
            IF EmployeeP.FIND('-') THEN BEGIN

                 CurrInsuranceRel := EmployeeP."Insurance Premium"*(VitalSetup."Insurance Relief"/100);


                 //Insert Insurance Relief
                 curTransAmount := CurrInsuranceRel;
                 strTransDescription := 'Insurance Relief';
                 TGroup := 'TAX CALCULATIONS'; TGroupOrder := 6; TSubGroupOrder := 8;
                  fnUpdatePeriodTrans (strEmpCode, 'INSRD', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
             curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",JournalPostingType::" ",'',
             CoopParameters::none);

           END;*/

            //Personal Relief
            if blnGetsPAYERelief then begin
                curReliefPersonal := curReliefPersonal + curUnusedRelief; //*****Get curUnusedRelief
                curTransAmount := curReliefPersonal;
                strTransDescription := 'Personal Relief';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 9;
                fnUpdatePeriodTrans(strEmpCode, 'PSNR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                 Coopparameters::none);
            end;


            ////////////////////NDUVASON
            HrEmployee.Reset;
            HrEmployee.SetRange(HrEmployee."No.", HrEmployee."No.");
            if HrEmployee.Find('-') then
                curReliefMorgage := HrEmployee."Morgage Relief";
            if blnGetsPAYERelief then begin
                curReliefMorgage := HrEmployee."Morgage Relief";// curReliefPersonal + curUnusedRelief; //*****Get curUnusedRelief
                curTransAmount := curReliefMorgage;
                strTransDescription := 'Morgage Relief';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 9;
                fnUpdatePeriodTrans(strEmpCode, 'MSNR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                 Coopparameters::none);
            end;
            /*HrEmployee.RESET;
              HrEmployee.SETRANGE(HrEmployee."No.",HrEmployee."No.");
              IF HrEmployee.FIND('-') THEN
                curReliefMorgage:=HrEmployee."Morgage Relief";
            IF blnGetsPAYERelief THEN
            BEGIN
             curReliefMorgage :=HrEmployee."Morgage Relief";// curReliefPersonal + curUnusedRelief; //*****Get curUnusedRelief
             curTransAmount := curReliefMorgage;
             strTransDescription := 'Morgage Relief';
             TGroup := 'TAX CALCULATIONS'; TGroupOrder := 6; TSubGroupOrder := 9;
             fnUpdatePeriodTrans (strEmpCode, 'SNR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
              curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",JournalPostingType::" ",'',
              CoopParameters::none);
            END ;*/
            NHFLACUMEN := 0;

            HrEmployee.Reset;
            HrEmployee.SetRange(HrEmployee."No.", HrEmployee."No.");
            if HrEmployee.Find('-') then
                curReliefMorgage := HrEmployee."Morgage Relief";
            HrEmployee.CalcFields(HrEmployee."Cummulative NHIF");
            //prNHIF.RESET;
            // prNHIF.SETRANGE(
            if blnGetsPAYERelief then begin
                //NHFLACUMEN:=fnGetEmployeeNHIF(curNhif_Base_Amount);
                NSSFR := 1700 * 0.15;//(HrEmployee."Cummulative NHIF"*0.15);// curReliefPersonal + curUnusedRelief; //*****Get curUnusedRelief
                curTransAmount := NSSFR;
                strTransDescription := 'NHIF Relief';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 9;
                fnUpdatePeriodTrans(strEmpCode, 'NSNR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                 Coopparameters::none);
            end;
            HrEmployee.Reset;
            HrEmployee.SetRange(HrEmployee."No.", HrEmployee."No.");
            if HrEmployee.Find('-') then
                curReliefMorgage := HrEmployee."Morgage Relief";
            if HrEmployee."Pays Pension" = true then begin

                if blnGetsPAYERelief then begin
                    NSSFR := (HrEmployee."Basic Pay" * 0.05);// curReliefPersonal + curUnusedRelief; //*****Get curUnusedRelief
                    curTransAmount := NSSFR;
                    strTransDescription := 'Pension Relief';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 9;
                    fnUpdatePeriodTrans(strEmpCode, 'PPSNR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                     curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                     Coopparameters::none);
                end;
            end;

            //ELSE
            // curReliefPersonal := 0;

            //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            //>Pension Contribution [self] relief
            curPensionStaff := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
            Specialtranstype::"Defined Contribution", false);//Self contrib Pension is 1 on [Special Transaction]
            if curPensionStaff > 0 then begin
                if curPensionStaff > curMaxPensionContrib then
                    curTransAmount := curMaxPensionContrib
                else
                    curTransAmount := curPensionStaff;
                strTransDescription := 'Pension Relief';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 2;
                fnUpdatePeriodTrans(strEmpCode, 'PNSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                Coopparameters::none)
            end;

            //if he PAYS paye only*******************I
            /*IF blnPaysPaye AND blnGetsPAYERelief THEN
            BEGIN
              //Get Insurance Relief
              SpecialTranAmount:=0;
              curInsuranceReliefAmount:=fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
              SpecialTransType::"Life Insurance",FALSE); //Insurance is 3 on [Special Transaction]

              IF curInsuranceReliefAmount > 0 THEN BEGIN
                  curTransAmount := curInsuranceReliefAmount;
                  strTransDescription := 'Insurance Relief';
                  TGroup := 'TAX CALCULATIONS'; TGroupOrder := 6; TSubGroupOrder := 8;
                  fnUpdatePeriodTrans (strEmpCode, 'INSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                  curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",JournalPostingType::" ",'',
                  CoopParameters::none);
              END;*/

            //>OOI
            HrEmployee.Reset;
            HrEmployee.SetRange(HrEmployee."No.", HrEmployee."No.");
            if HrEmployee.Find('-') then
                curReliefMorgage := HrEmployee."Morgage Relief";
            // MESSAGE(FORMAT(curReliefMorgage));
            curOOI := HrEmployee."Morgage Relief";/*fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,/////NDUVASON
          SpecialTransType::"Owner Occupier Interest",FALSE);*/ //Morgage is LAST on [Special Transaction]
            if curOOI > 0 then begin
                if curOOI <= curOOIMaxMonthlyContrb then
                    curTransAmount := curReliefMorgage//curOOInet
                else
                    curTransAmount := curReliefMorgage;//curOOIMaxMonthlyContrb;

                strTransDescription := 'Owner Occupier Interest';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 3;
                fnUpdatePeriodTrans(strEmpCode, 'OOI', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                Coopparameters::none);
            end;
            HrEmployee.Reset;
            HrEmployee.SetRange(HrEmployee."No.", HrEmployee."No.");
            if HrEmployee.Find('-') then
                curReliefMorgage := HrEmployee."Morgage Relief";
            //HOSP
            curHOSP := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
            Specialtranstype::"Home Ownership Savings Plan", false);
            HrEmployee.Reset;
            HrEmployee.SetRange(HrEmployee."No.", HrEmployee."No.");
            if HrEmployee.Find('-') then
                curReliefMorgage := HrEmployee."Morgage Relief";
            //Home Ownership Savings Plan
            if curHOSP > 0 then begin
                if curHOSP <= curReliefMorgage then
                    curTransAmount := curHOSP
                else
                    curTransAmount := curReliefMorgage;
                Message(Format(curReliefMorgage));
                strTransDescription := 'Home Ownership Savings Plan';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 4;
                fnUpdatePeriodTrans(strEmpCode, 'HOSP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                Coopparameters::none);
            end;

            /*//Enter NonTaxable Amount
            IF curNonTaxable>3499 THEN BEGIN
                        Teltax:=0;
                        Teltax2:=0;

                        Teltax:=curNonTaxable*0.3;
                        Teltax2:=Teltax*0.3;
                        //curTransAmount := Teltax2;
                        //MESSAGE('The telephone tax is %1',Teltax2);


                  strTransDescription := 'Telephone Tax';
                  TGroup := 'TAX CALCULATIONS'; TGroupOrder := 6; TSubGroupOrder := 5;
                  fnUpdatePeriodTrans (strEmpCode, 'NONTAX', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                  Teltax2, 0, intMonth, intYear,'','',SelectedPeriod,Dept,TelTaxACC,JournalPostAs::Credit,JournalPostingType::"G/L Account",'',
                  CoopParameters::none);
            END; */

            /*
            IF curNonTaxable>0 THEN BEGIN
                  strTransDescription := 'Other Non-Taxable Benefits';
                  TGroup := 'TAX CALCULATIONS'; TGroupOrder := 6; TSubGroupOrder := 5;
                  fnUpdatePeriodTrans (strEmpCode, 'NONTAX', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                  curNonTaxable, 0, intMonth, intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",JournalPostingType::" ",'',
                  CoopParameters::none);
            END;
            */

        end;

        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        /*
         //>Company pension, Excess pension, Tax on excess pension
         curPensionCompany := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear, SpecialTransType::"Defined Contribution",
         TRUE); //Self contrib Pension is 1 on [Special Transaction]
         IF curPensionCompany > 0 THEN BEGIN
             curTransAmount := curPensionCompany;
             strTransDescription := 'Pension (Company)';
             //Update the Employer deductions table
        
             curExcessPension:= curPensionCompany - curMaxPensionContrib;
             IF curExcessPension > 0 THEN BEGIN
                 curTransAmount := curExcessPension;
                 strTransDescription := 'Excess Pension Employee';
                 TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 5;
                 fnUpdatePeriodTrans (strEmpCode, 'EXCP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0,
                  intMonth,intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",JournalPostingType::" ",'',CoopParameters::none);
        
                 curTaxOnExcessPension := (curRateTaxExPension / 100) * curExcessPension;
                 curTransAmount := curTaxOnExcessPension;
                 strTransDescription := 'Tax on ExPension Employee';
                 TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 6;
                 fnUpdatePeriodTrans (strEmpCode, 'TXEP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0,
                  intMonth,intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",JournalPostingType::" ",'',CoopParameters::none);
        
                 strTransDescription := 'Tax on ExPension Employer';
                 TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 6;
                 fnUpdatePeriodTrans (strEmpCode, 'TXEP2', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, 65780, 0,
                  intMonth,intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",JournalPostingType::" ",'',CoopParameters::none);
        
        
             END;
         END;
        
         */
        //Get the Taxable amount for calculation of PAYE
        //>prTaxablePay = (GrossTaxable - SalaryArrears) - (TheDefinedToPost + curSelfPensionContrb + MorgageRelief)

        if curPensionStaff > curMaxPensionContrib then
            curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curMaxPensionContrib + curHOSP + curNonTaxable + curOOI)

        else
            curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curPensionStaff + curOOI + curHOSP + curNonTaxable + NSSFR + curMorgageReliefAmount);
        //Taxable Benefit
        txBenefitAmt := 0;
        if EmpSalary.Get(strEmpCode) then begin
            if EmpSalary."Pays NSSF" = false then begin
                if fnCheckPaysPension(strEmpCode, SelectedPeriod) = true then begin
                    if (EmpSalary."Basic Pay" * 0.1) > 20000 then begin
                        txBenefitAmt := EmpSalary."Basic Pay" * 0.2;
                    end else begin
                        txBenefitAmt := ((EmpSalary."Basic Pay" * 0.2) + (EmpSalary."Basic Pay" * 0.1)) - 20000;
                        if txBenefitAmt < 0 then
                            txBenefitAmt := 0;
                    end;
                    strTransDescription := 'Taxable Pension';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 6;
                    fnUpdatePeriodTrans(strEmpCode, 'TXBB', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                     txBenefitAmt, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                     Coopparameters::none);
                end;
            end;
        end;
        curTransAmount := curTaxablePay + txBenefitAmt;
        strTransDescription := 'Taxable Pay';
        TGroup := 'TAX CALCULATIONS';
        TGroupOrder := 6;
        TSubGroupOrder := 6;
        fnUpdatePeriodTrans(strEmpCode, 'TXBP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
         curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
         Coopparameters::none);
        SFR := 0;
        //Get the Tax charged for the month
        HrEmployee.Reset;
        HrEmployee.SetRange(HrEmployee."No.", HrEmployee."No.");
        if HrEmployee.Find('-') then
            HrEmployee.CalcFields(HrEmployee."Cummulative NHIF");
        SFR := ROUND(HrEmployee."Cummulative NHIF" * 0.15, 1, '=');
        curTaxablePay := curTaxablePay + txBenefitAmt;
        curTaxCharged := fnGetEmployeePaye(curTaxablePay) - (curInsuranceReliefAmount + curReliefPersonal + CurrInsuranceRel) + (SFR * -1);//SUTU
                                                                                                                                           //MESSAGE(FORMAT(SFR));
        curTransAmount := curTaxCharged + 1280;
        if curTaxCharged < 0 then curTransAmount := 0;
        strTransDescription := 'Tax Charged';
        TGroup := 'TAX CALCULATIONS';
        TGroupOrder := 6;
        TSubGroupOrder := 7;
        fnUpdatePeriodTrans(strEmpCode, 'TXCHRG', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
        Coopparameters::none);



        //Get the Net PAYE amount to post for the month
        if (curReliefPersonal + curInsuranceReliefAmount) > curMaximumRelief then
            //curPAYE :=ROUND( curTaxCharged - curMaximumRelief,1,'<')
            curPAYE := (curTaxCharged - curMaximumRelief)
        else
            //curPAYE := curTaxCharged - (curReliefPersonal + curInsuranceReliefAmount);
            //curPAYE := ROUND(curTaxCharged,1,'<');
            curPAYE := (curTaxCharged);
        if not blnPaysPaye then curPAYE := 0; //Get statutory Exemption for the staff. If exempted from tax, set PAYE=0
        curTransAmount := curPAYE;//+curTransAmount2;
        if curPAYE < 0 then curTransAmount := 0;
        strTransDescription := 'P.A.Y.E';
        TGroup := 'STATUTORIES';
        TGroupOrder := 7;
        TSubGroupOrder := 3;
        fnUpdatePeriodTrans(strEmpCode, 'PAYE', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
         curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, TaxAccount, Journalpostas::Credit,
         Journalpostingtype::"G/L Account", '', Coopparameters::none);

        //Store the unused relief for the current month
        //>If Paye<0 then "Insert into tblprUNUSEDRELIEF
        if curPAYE < 0 then begin
            prUnusedRelief.Reset;
            prUnusedRelief.SetRange(prUnusedRelief."Employee No.", strEmpCode);
            prUnusedRelief.SetRange(prUnusedRelief."Period Month", intMonth);
            prUnusedRelief.SetRange(prUnusedRelief."Period Year", intYear);
            if prUnusedRelief.Find('-') then
                prUnusedRelief.Delete;

            prUnusedRelief.Reset;
            with prUnusedRelief do begin
                Init;
                "Employee No." := strEmpCode;
                "Unused Relief" := curPAYE;
                "Period Month" := intMonth;
                "Period Year" := intYear;
                Insert;

                curPAYE := 0;
            end;
        end;

        //Deductions: get all deductions for the month
        //Loans: calc loan deduction amount, interest, fringe benefit (employer deduction), loan balance
        //>Balance = (Openning Bal + Deduction)...//Increasing balance
        //>Balance = (Openning Bal - Deduction)...//Reducing balance
        //>NB: some transactions (e.g Sacco shares) can be made by cheque or cash. Allow user to edit the outstanding balance

        //Get the N.H.I.F amount for the month GBT
        curNhif_Base_Amount := 0;

        if intNHIF_BasedOn = Intnhif_basedon::Gross then //>NHIF calculation can be based on:
            curNhif_Base_Amount := curGrossPay;
        if intNHIF_BasedOn = Intnhif_basedon::Basic then
            curNhif_Base_Amount := curBasicPay;
        if intNHIF_BasedOn = Intnhif_basedon::"Taxable Pay" then
            curNhif_Base_Amount := curTaxablePay;

        if blnPaysNhif then begin
            //curNHIF:=450;
            curNHIF := fnGetEmployeeNHIF(curNhif_Base_Amount);
            // curNHIF:=320;
            curTransAmount := curNHIF;
            strTransDescription := 'N.H.I.F';
            TGroup := 'STATUTORIES';
            TGroupOrder := 7;
            TSubGroupOrder := 2;
            fnUpdatePeriodTrans(strEmpCode, 'NHIF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
             curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
             NHIFEMPyee, Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::NHIF);
        end;

        prEmployeeTransactions.Reset;
        prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
        prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);

        if prEmployeeTransactions.Find('-') then begin
            curTotalDeductions := 0;
            repeat
                prTransactionCodes.Reset;
                prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."transaction type"::Deduction);
                if prTransactionCodes.Find('-') then begin
                    curTransAmount := 0;
                    curTransBalance := 0;
                    strTransDescription := '';
                    strExtractedFrml := '';

                    if prTransactionCodes."Is Formulae" then begin
                        if Management then
                            strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Formula for Management Prov")
                        else
                            strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formulae);

                        curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount

                    end else begin
                        curTransAmount := prEmployeeTransactions.Amount;
                    end;

                    //**************************If "deduct Premium" is not ticked and the type is insurance- Dennis*****
                    if (prTransactionCodes."Special Transaction" = prTransactionCodes."special transaction"::"Life Insurance")
                      and (prTransactionCodes."Deduct Premium" = false) then begin
                        curTransAmount := 0;
                    end;

                    //**************************If "deduct Premium" is not ticked and the type is mortgage- Dennis*****
                    if (prTransactionCodes."Special Transaction" = prTransactionCodes."special transaction"::Morgage)
                     and (prTransactionCodes."Deduct Mortgage" = false) then begin
                        curTransAmount := 0;
                    end;

                    if prTransactionCodes."IsCo-Op/LnRep" = true then begin
                        CoopParameters := prTransactionCodes."Co-Op Parameters";
                    end;


                    //Get the posting Details
                    JournalPostingType := Journalpostingtype::" ";
                    JournalAcc := '';
                    if prTransactionCodes.SubLedger <> prTransactionCodes.Subledger::" " then begin
                        if prTransactionCodes.SubLedger = prTransactionCodes.Subledger::Customer then begin
                            HrEmployee.Get(strEmpCode);

                            //IF prTransactionCodes.CustomerPostingGroup ='' THEN
                            //Customer.SETRANGE(Customer."Employer Code",'KPSS');

                            if prTransactionCodes."Customer Posting Group" <> '' then begin
                                Customer.SetRange(Customer."Customer Posting Group", prTransactionCodes."Customer Posting Group");
                            end;
                            Customer.Reset;
                            Customer.SetRange(Customer."No.", HrEmployee."Payroll No");
                            //MESSAGE('%1,%2,%3',JournalAcc,strEmpCode,Customer."Payroll/Staff No");
                            if Customer.Find('-') then begin
                                JournalAcc := Customer."No.";
                                JournalPostingType := Journalpostingtype::Member;
                            end;
                        end;
                    end else begin
                        JournalAcc := prTransactionCodes."G/L Account";
                        JournalPostingType := Journalpostingtype::"G/L Account";
                    end;

                    //End posting Details

                    /*
                          //Loan Calculation is Amortized do Calculations here -Monthly Principal and Interest Keeps on Changing
                          IF (prTransactionCodes."Special Transaction"=prTransactionCodes."Special Transaction"::"Staff Loan") AND
                             (prTransactionCodes."Repayment Method" = prTransactionCodes."Repayment Method"::Amortized) THEN BEGIN
                             curTransAmount:=0; curLoanInt:=0;
                             curLoanInt:=fnCalcLoanInterest (strEmpCode, prEmployeeTransactions."Transaction Code",
                             prTransactionCodes."Interest Rate",prTransactionCodes."Repayment Method",
                                prEmployeeTransactions."Original Amount",prEmployeeTransactions.Balance,SelectedPeriod,FALSE);
                             //Post the Interest
                             //IF (curLoanInt<>0) THEN BEGIN
                                    //curTransAmount := curLoanInt;
                                    curTransAmount := prEmployeeTransactions.Amount;
                                     MESSAGE('TUKO1');
                                    curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                                    curTransBalance:=0;
                                    strTransCode := prEmployeeTransactions."Transaction Code"+'-REP';
                                    strTransDescription := prEmployeeTransactions."Transaction Name"+ 'Principle';
                                    TGroup := 'DEDUCTIONS'; TGroupOrder := 8; TSubGroupOrder := 1;
                                    fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                                      strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
                                      prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No",SelectedPeriod,Dept,
                                      JournalAcc,JournalPostAs::Credit,JournalPostingType,prEmployeeTransactions."Loan Number",
                                      CoopParameters::loan);
                             // END;
                             //Get the Principal Amt
                             //curTransAmount:=prEmployeeTransactions."Amortized Loan Total Repay Amt"-curLoanInt;
                             curTransAmount := prEmployeeTransactions.Amount;
                              //Modify PREmployeeTransaction Table
                              prEmployeeTransactions.Amount:=curTransAmount;
                              prEmployeeTransactions.MODIFY;
                          END;
                          //Loan Calculation Amortized

                          CASE prTransactionCodes."Balance Type" OF //[0=None, 1=Increasing, 2=Reducing]
                              prTransactionCodes."Balance Type"::None:
                                   curTransBalance := 0;
                              prTransactionCodes."Balance Type"::Increasing:
                                  curTransBalance := prEmployeeTransactions.Balance+ curTransAmount;
                             prTransactionCodes."Balance Type"::Reducing:
                             BEGIN
                                  //curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                  IF prEmployeeTransactions.Balance < prEmployeeTransactions.Amount THEN BEGIN
                                       curTransAmount := prEmployeeTransactions.Balance;
                                       curTransBalance := 0;
                                   END ELSE BEGIN
                                       curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                   END;
                                   IF curTransBalance < 0 THEN BEGIN
                                       curTransAmount := 0;
                                       curTransBalance := 0;
                                   END;
                             END
                        END;

                          curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                          curTransAmount := curTransAmount;
                          curTransBalance := curTransBalance;
                          strTransDescription := prTransactionCodes."Transaction Name";
                          TGroup := 'DEDUCTIONS'; TGroupOrder := 8; TSubGroupOrder := 0;
                          fnUpdatePeriodTrans (strEmpCode, prEmployeeTransactions."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                           strTransDescription,curTransAmount, curTransBalance, intMonth,
                           intYear, prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No",SelectedPeriod,Dept,
                           JournalAcc,JournalPostAs::Credit,JournalPostingType,prEmployeeTransactions."Loan Number",
                           prTransactionCodes."co-op parameters");

                  //Check if transaction is loan. Get the Interest on the loan & post it at this point before moving next ****Loan Calculation
                          IF (prTransactionCodes."Special Transaction"=prTransactionCodes."Special Transaction"::"Staff Loan") AND
                             (prTransactionCodes."Repayment Method" <> prTransactionCodes."Repayment Method"::Amortized) THEN BEGIN

                               curLoanInt:=fnCalcLoanInterest (strEmpCode, prEmployeeTransactions."Transaction Code",
                              prTransactionCodes."Interest Rate",
                               prTransactionCodes."Repayment Method", prEmployeeTransactions."Original Amount",
                               prEmployeeTransactions.Balance,SelectedPeriod,prTransactionCodes.Welfare);
                               // IF curLoanInt > 0 THEN BEGIN
                                   // curTransAmount := curLoanInt;
                                    curTransAmount:=prEmployeeTransactions.Amount;
                                   // MESSAGE('TUKO2');

                                    curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                                    curTransBalance:=0;
                                    strTransCode := prEmployeeTransactions."Transaction Code"+'-INT';
                                    strTransDescription := prEmployeeTransactions."Transaction Name"+ 'Interest';
                                    TGroup := 'DEDUCTIONS'; TGroupOrder := 8; TSubGroupOrder := 1;
                                    fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                                      strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
                                      prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No",SelectedPeriod,Dept,
                                      JournalAcc,JournalPostAs::Credit,JournalPostingType,prEmployeeTransactions."Loan Number",
                                      CoopParameters::"loan Interest");
                               //END;
                         END;

                  */
                    //End Loan transaction calculation
                    //Fringe Benefits and Low interest Benefits
                    if prTransactionCodes."Fringe Benefit" = true then begin
                        if prTransactionCodes."Interest Rate" < curLoanMarketRate then begin
                            fnCalcFringeBenefit := (((curLoanMarketRate - prTransactionCodes."Interest Rate") * curLoanCorpRate) / 1200)
                             * prEmployeeTransactions.Balance;
                        end;
                    end else begin
                        fnCalcFringeBenefit := 0;
                    end;
                    if fnCalcFringeBenefit > 0 then begin
                        fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code" + '-FRG',
                         'EMP', TGroupOrder, TSubGroupOrder, 'Fringe Benefit Tax', fnCalcFringeBenefit, 0, intMonth, intYear,
                          prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod)

                    end;
                    //End Fringe Benefits

                    //Loan Calculation is Amortized do Calculations here -Monthly Principal and Interest Keeps on Changing
                    if (prTransactionCodes."Special Transaction" = prTransactionCodes."special transaction"::"Staff Loan") and
                       (prTransactionCodes."Repayment Method" = prTransactionCodes."repayment method"::Reducing) then begin
                        curTransAmount := 0;
                        curLoanInt := 0;
                        if (FnLoanInterestExempted(prEmployeeTransactions."Loan Number") = false) then
                            curLoanInt := fnCalcLoanInterest(strEmpCode, prEmployeeTransactions."Transaction Code", //prEmployeeTransactions."Outstanding Interest";
                             FnGetInterestRate(prEmployeeTransactions."Transaction Code"), prTransactionCodes."Repayment Method",
                               prEmployeeTransactions.Amount, prEmployeeTransactions.Balance, SelectedPeriod, false);
                        curTransAmount := curLoanInt;
                        curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                        curTransBalance := 0;
                        strTransCode := prEmployeeTransactions."Transaction Code" + '-INT';
                        strTransDescription := prEmployeeTransactions."Transaction Name" + 'Interest';
                        TGroup := 'DEDUCTIONS';
                        TGroupOrder := 8;
                        TSubGroupOrder := 1;
                        if curTransAmount <> 0 then
                            fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                              strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
                              prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                              JournalAcc, Journalpostas::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                              Coopparameters::"loan Interest");
                        curTransAmount := prEmployeeTransactions.Amount;
                        prEmployeeTransactions.Amount := curTransAmount;
                        prEmployeeTransactions.Modify;
                    end;
                    //Loan Calculation Amortized



                    case prTransactionCodes."Balance Type" of //[0=None, 1=Increasing, 2=Reducing]
                        prTransactionCodes."balance type"::None:
                            curTransBalance := 0;
                        prTransactionCodes."balance type"::Increasing:
                            curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
                        prTransactionCodes."balance type"::Reducing:
                            begin
                                //curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                if prEmployeeTransactions.Balance < prEmployeeTransactions.Amount then begin
                                    curTransAmount := prEmployeeTransactions.Balance;
                                    curTransBalance := 0;
                                end else begin
                                    curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                end;
                                if curTransBalance < 0 then begin
                                    curTransAmount := 0;
                                    curTransBalance := 0;
                                end;
                            end
                    end;

                    if (prTransactionCodes."Special Transaction" = prTransactionCodes."special transaction"::"Staff Loan") and
                       (prTransactionCodes."Repayment Method" = prTransactionCodes."repayment method"::Amortized) then begin
                        curTransAmount := 0;
                        curLoanInt := 0;
                        curLoanInt := fnCalcLoanInterest(strEmpCode, prEmployeeTransactions."Transaction Code",
                        prTransactionCodes."Interest Rate", prTransactionCodes."Repayment Method",
                          prEmployeeTransactions."Original Amount", prEmployeeTransactions.Balance, SelectedPeriod, false);
                        //Post the Interest
                        //IF (curLoanInt<>0) THEN BEGIN
                        curTransAmount := curLoanInt;
                        // curTransAmount := prEmployeeTransactions.Amount-curLoanInt;

                        curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                        curTransBalance := 0;
                        strTransCode := prEmployeeTransactions."Transaction Code" + '-INT';
                        strTransDescription := prEmployeeTransactions."Transaction Name" + 'Interest';
                        TGroup := 'DEDUCTIONS';
                        TGroupOrder := 8;
                        TSubGroupOrder := 1;
                        fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                          strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
                          prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                          JournalAcc, Journalpostas::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                          Coopparameters::"loan Interest");
                        // END;
                        //Get the Principal Amt
                        curTransAmount := prEmployeeTransactions.Amount;
                        // curTransAmount :=curLoanInt;// prEmployeeTransactions.Amount;
                        //Modify PREmployeeTransaction Table
                        prEmployeeTransactions.Amount := curTransAmount;
                        prEmployeeTransactions.Modify;
                    end;
                    //Loan Calculation Amortized

                    case prTransactionCodes."Balance Type" of //[0=None, 1=Increasing, 2=Reducing]
                        prTransactionCodes."balance type"::None:
                            curTransBalance := 0;
                        prTransactionCodes."balance type"::Increasing:
                            curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
                        prTransactionCodes."balance type"::Reducing:
                            begin
                                //curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                if prEmployeeTransactions.Balance < prEmployeeTransactions.Amount then begin
                                    curTransAmount := prEmployeeTransactions.Balance;
                                    curTransBalance := 0;
                                end else begin
                                    curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                end;
                                if curTransBalance < 0 then begin
                                    curTransAmount := 0;
                                    curTransBalance := 0;
                                end;
                            end
                    end;

                    curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                    curTransAmount := curTransAmount;
                    curTransBalance := curTransBalance;
                    strTransDescription := prTransactionCodes."Transaction Name";
                    TGroup := 'DEDUCTIONS';
                    TGroupOrder := 8;
                    TSubGroupOrder := 0;
                    fnUpdatePeriodTrans(strEmpCode, prEmployeeTransactions."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                     strTransDescription, curTransAmount, curTransBalance, intMonth,
                     intYear, prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                     JournalAcc, Journalpostas::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                     prTransactionCodes."Co-Op Parameters");

                    //Create Employer Deduction
                    if (prTransactionCodes."Employer Deduction") or (prTransactionCodes."Include Employer Deduction") then begin
                        if prTransactionCodes."Formulae for Employer" <> '' then begin
                            strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Formulae for Employer");
                            curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount
                        end else begin
                            curTransAmount := prEmployeeTransactions."Employer Amount";
                        end;
                        if curTransAmount > 0 then
                            fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code",
                             'EMP', TGroupOrder, TSubGroupOrder, '', curTransAmount, 0, intMonth, intYear,
                              prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod)

                    end;
                    //Employer deductions

                end;

            until prEmployeeTransactions.Next = 0;
            //GET TOTAL DEDUCTIONS
            /*curTotalDeductions:=curTotalDeductions;
                  curTransBalance:=0;
                  strTransCode := 'OTHER-DED';
                  strTransDescription := 'Other Deductions';
                  TGroup := 'DEDUCTIONS'; TGroupOrder := 8; TSubGroupOrder := 8;
                  fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                    strTransDescription, curTotalDeductions, curTransBalance, intMonth, intYear,
                    prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No",SelectedPeriod,Dept,
                    '',JournalPostAs::" ",JournalPostingType::" ",'',CoopParameters::none);
                    */
            curTotalDeductions := curTotalDeductions + curNSSF + curNHIF + curPAYE + curPayeArrears;
            curTransBalance := 0;
            strTransCode := 'TOT-DED';
            strTransDescription := 'TOTAL DEDUCTION';
            TGroup := 'DEDUCTIONS';
            TGroupOrder := 8;
            TSubGroupOrder := 9;
            fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
              strTransDescription, curTotalDeductions, curTransBalance, intMonth, intYear,
              prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
              '', Journalpostas::" ", Journalpostingtype::" ", '', Coopparameters::none)

            //END GET TOTAL DEDUCTIONS
        end;

        //Net Pay: calculate the Net pay for the month in the following manner:
        //>Nett = Gross - (xNssfAmount + curMyNhifAmt + PAYE + PayeArrears + prTotDeductions)
        //...Tot Deductions also include (SumLoan + SumInterest)
        //curNetPay := curGrossPay - (curNSSF + curNHIF + curPAYE + curPayeArrears + curTotalDeductions+IsCashBenefit+Teltax2);
        //  curNetPay := curGrossPay - ROUND((curTotalDeductions+IsCashBenefit+Teltax2),0.05,'<');
        curNetPay := curGrossPay - ROUND((curTotalDeductions + Teltax2), 0.05, '<');//NDUVASON
                                                                                    //>Nett = Nett - curExcessPension
                                                                                    //...Excess pension is only used for tax. Staff is not paid the amount hence substract it

        //  IF strEmpCode='011687' THEN
        // ERROR('%1 %2 %3',curGrossPay,curNetPay,ROUND(curNetPay,0.05,'<'));

        curNetPay := ROUND(curNetPay, 0.05, '<'); //- curExcessPension
                                                  // IF strEmpCode='011687' THEN
                                                  // ERROR('%1 %2 %3',curGrossPay,ROUND((curTotalDeductions+IsCashBenefit+Teltax2),0.05,'<'),curNetPay);
                                                  //>Nett = Nett - cSumEmployerDeductions
                                                  //...Employer Deductions are used for reporting as cost to company BUT dont affect Net pay
        curNetPay := curNetPay;//- ROUND(curTotCompanyDed,0.05,'<'); //******Get Company Deduction*****
        if curGrossPay < 24000 then
            curNetPay := curGrossPay - (curTotalDeductions + 800);
        //MESSAGE(FORMAT(curNetPay));
        curNetRnd_Effect := ROUND(curNetPay, 0.05, '<') - ROUND(curNetPay, 0.05, '<');
        curTransAmount := ROUND(curNetPay, 0.05, '<');
        strTransDescription := 'Net Pay';
        TGroup := 'NET PAY';
        TGroupOrder := 9;
        TSubGroupOrder := 0;

        fnUpdatePeriodTrans(strEmpCode, 'NPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
        PayablesAcc, Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

        //Rounding Effect: if the Net pay is rounded, take the rounding effect &
        //save it as an earning for the staff for the next month
        //>Insert the Netpay rounding effect into the tblRoundingEffect table


        //Negative pay: if the NetPay<0 then log the entry
        //>Display an on screen report
        //>Through a pop-up to the user
        //>Send an email to the user or manager
        //END

    end;


    procedure fnBasicPayProrated(strEmpCode: Code[20]; Month: Integer; Year: Integer; BasicSalary: Decimal; DaysWorked: Integer; DaysInMonth: Integer) ProratedAmt: Decimal
    begin
        ProratedAmt := ROUND((DaysWorked / DaysInMonth) * BasicSalary, 0.05, '<');
    end;


    procedure fnDaysInMonth(dtDate: Date) DaysInMonth: Integer
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
        // SysDate.SETFILTER(SysDate."Period No.",'1..5');
        if SysDate.Find('-') then
            DaysInMonth := SysDate.Count;
    end;


    procedure fnUpdatePeriodTrans(EmpCode: Code[20]; TCode: Code[20]; TGroup: Code[20]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date; Department: Code[20]; JournalAC: Code[20]; PostAs: Option " ",Debit,Credit; JournalACType: Option " ","G/L Account",Customer,Vendor; LoanNo: Code[20]; CoopParam: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension)
    var
        prPeriodTransactions: Record "prPeriod Transactions.";
        prSalCard: Record "Payroll Employee.";
    begin
        if curAmount = 0 then exit;
        with prPeriodTransactions do begin
            Init;
            "Employee Code" := EmpCode;
            "Transaction Code" := TCode;
            "Group Text" := TGroup;
            "Transaction Name" := Description;
            Amount := ROUND(curAmount, 0.05, '<');
            Balance := curBalance;
            "Original Amount" := Balance;
            "Group Order" := GroupOrder;
            "Sub Group Order" := SubGroupOrder;
            Membership := mMembership;
            "Reference No" := ReferenceNo;
            "Period Month" := Month;
            "Period Year" := Year;
            "Payroll Period" := dtOpenPeriod;
            "Department Code" := Department;
            "Journal Account Type" := JournalACType;
            "Post As" := PostAs;
            "Journal Account Code" := JournalAC;
            "Loan Number" := LoanNo;
            "coop parameters" := CoopParam;
            "Payroll Code" := PayrollType;
            //Paymode
            if prSalCard.Get(EmpCode) then
                "Payment Mode" := prSalCard."Payment Mode";
            Insert;

            //Update the prEmployee Transactions  with the Amount
            fnUpdateEmployeeTrans("Employee Code", "Transaction Code", Amount, "Period Month", "Period Year", "Payroll Period");
        end;
    end;


    procedure fnGetSpecialTransAmount(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage; blnCompDedc: Boolean) SpecialTransAmount: Decimal
    var
        prEmployeeTransactions: Record "Payroll Employee Transactions.";
        prTransactionCodes: Record "Payroll Transaction Code.";
        strExtractedFrml: Text[250];
    begin
        SpecialTransAmount := 0;
        prTransactionCodes.Reset;
        prTransactionCodes.SetRange(prTransactionCodes."Special Transaction", intSpecTransID);
        if prTransactionCodes.Find('-') then begin
            repeat
                prEmployeeTransactions.Reset;
                prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                // prEmployeeTransactions.SETRANGE(prEmployeeTransactions.Suspended,FALSE);
                if prEmployeeTransactions.Find('-') then begin

                    //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
                    //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
                    case intSpecTransID of
                        Intspectransid::"Defined Contribution":
                            if prTransactionCodes."Is Formulae" then begin
                                strExtractedFrml := '';
                                if Management then
                                    strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Formula for Management Prov")
                                else
                                    strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formulae);

                                SpecialTransAmount := SpecialTransAmount + (fnFormulaResult(strExtractedFrml)); //Get the calculated amount
                            end else
                                SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

                        Intspectransid::"Life Insurance":
                            SpecialTransAmount := SpecialTransAmount + ((curReliefInsurance / 100) * prEmployeeTransactions.Amount);

                        //
                        Intspectransid::"Owner Occupier Interest":
                            SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;


                        Intspectransid::"Home Ownership Savings Plan":
                            SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

                        Intspectransid::Morgage:
                            begin
                                SpecialTransAmount := SpecialTransAmount + curReliefMorgage;

                                if SpecialTransAmount > curReliefMorgage then begin
                                    SpecialTransAmount := curReliefMorgage
                                end;

                            end;

                    end;
                end;
            until prTransactionCodes.Next = 0;
        end;
        SpecialTranAmount := SpecialTransAmount;
    end;


    procedure fnGetEmployeePaye(curTaxablePay: Decimal) PAYE: Decimal
    var
        prPAYE: Record "Payroll PAYE Setup.";
        curTempAmount: Decimal;
        KeepCount: Integer;
    begin
        KeepCount := 0;
        prPAYE.Reset;
        if prPAYE.FindFirst then begin
            if curTaxablePay < prPAYE."PAYE Tier" then exit;
            repeat
                KeepCount += 1;
                curTempAmount := curTaxablePay;
                if curTaxablePay = 0 then exit;
                if KeepCount = prPAYE.Count then   //this is the last record or loop
                    curTaxablePay := curTempAmount
                else
                    if curTempAmount >= prPAYE."PAYE Tier" then
                        curTempAmount := prPAYE."PAYE Tier"
                    else
                        curTempAmount := curTempAmount;

                PAYE := PAYE + (curTempAmount * (prPAYE.Rate / 100));
                curTaxablePay := curTaxablePay - curTempAmount;

            until prPAYE.Next = 0;
        end;
    end;


    procedure fnGetEmployeeNHIF(curBaseAmount: Decimal) NHIF: Decimal
    var
        prNHIF: Record "Payroll NHIF Setup.";
    begin

        prNHIF.Reset;
        prNHIF.SetCurrentkey(prNHIF."Tier Code");
        if prNHIF.FindFirst then begin
            repeat
                if ((curBaseAmount >= prNHIF."Lower Limit") and (curBaseAmount <= prNHIF."Upper Limit")) then
                    NHIF := prNHIF.Amount;
            until prNHIF.Next = 0;
        end;
    end;


    procedure fnPureFormula(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; strFormula: Text[250]) Formula: Text[250]
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
                TransCodeAmount := fnGetTransAmount(strEmpCode, TransCode, intMonth, intYear);
                //Reset Transcode
                TransCode := '';
                //Get Final Formula
                FinalFormula := FinalFormula + Format(TransCodeAmount);
                //End Get Transcode
            end;
        end;
        Formula := FinalFormula;
    end;


    procedure fnGetTransAmount(strEmpCode: Code[20]; strTransCode: Code[20]; intMonth: Integer; intYear: Integer) TransAmount: Decimal
    var
        prEmployeeTransactions: Record "Payroll Employee Transactions.";
        prPeriodTransactions: Record "prPeriod Transactions.";
    begin
        prEmployeeTransactions.Reset;
        prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", strTransCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
        prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
        if prEmployeeTransactions.FindFirst then begin

            TransAmount := prEmployeeTransactions.Amount;
            if prEmployeeTransactions."No of Units" <> 0 then
                TransAmount := prEmployeeTransactions."No of Units";

        end;
        if TransAmount = 0 then begin
            prPeriodTransactions.Reset;
            prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", strEmpCode);
            prPeriodTransactions.SetRange(prPeriodTransactions."Transaction Code", strTransCode);
            prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
            prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
            if prPeriodTransactions.FindFirst then
                TransAmount := prPeriodTransactions.Amount;
        end;
    end;


    procedure fnFormulaResult(strFormula: Text[250]) Results: Decimal
    var
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit AccSchedManagement;
    begin
        // Results :=
        //  AccSchedMgt.EvaluateExpression(true, strFormula, AccSchedLine, ColumnLayout, CalcAddCurr);
    end;


    procedure fnClosePayrollPeriod(dtOpenPeriod: Date; PayrollCode: Code[20]) Closed: Boolean
    var
        dtNewPeriod: Date;
        intNewMonth: Integer;
        intNewYear: Integer;
        prEmployeeTransactions: Record "Payroll Employee Transactions.";
        prPeriodTransactions: Record "prPeriod Transactions.";
        intMonth: Integer;
        intYear: Integer;
        prTransactionCodes: Record "Payroll Transaction Code.";
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        prEmployeeTrans: Record "Payroll Employee Transactions.";
        prPayrollPeriods: Record "Payroll Calender.";
        prNewPayrollPeriods: Record "Payroll Calender.";
        CreateTrans: Boolean;
        ControlInfo: Record "Control-Information.";
    begin
        //ControlInfo.GET();
        dtNewPeriod := CalcDate('1M', dtOpenPeriod);
        intNewMonth := Date2dmy(dtNewPeriod, 2);
        intNewYear := Date2dmy(dtNewPeriod, 3);

        intMonth := Date2dmy(dtOpenPeriod, 2);
        intYear := Date2dmy(dtOpenPeriod, 3);

        prEmployeeTransactions.Reset;
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);

        //Multiple Payroll
        if ControlInfo."Multiple Payroll" then
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Payroll Code", PayrollCode);

        if prEmployeeTransactions.Find('-') then begin
            repeat
                prTransactionCodes.Reset;
                prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                if prTransactionCodes.Find('-') then begin
                    with prTransactionCodes do begin
                        case prTransactionCodes."Balance Type" of
                            prTransactionCodes."balance type"::None:
                                begin
                                    curTransAmount := prEmployeeTransactions.Amount;
                                    curTransBalance := 0;
                                end;
                            prTransactionCodes."balance type"::Increasing:
                                begin
                                    curTransAmount := prEmployeeTransactions.Amount;
                                    curTransBalance := prEmployeeTransactions.Balance + prEmployeeTransactions.Amount;
                                end;
                            prTransactionCodes."balance type"::Reducing:
                                begin
                                    curTransAmount := prEmployeeTransactions.Amount;
                                    if prEmployeeTransactions.Balance < prEmployeeTransactions.Amount then begin
                                        curTransAmount := prEmployeeTransactions.Balance;
                                        curTransBalance := 0;
                                    end else begin
                                        curTransBalance := prEmployeeTransactions.Balance - prEmployeeTransactions.Amount;
                                    end;

                                    if curTransBalance < 0 then begin
                                        curTransAmount := 0;
                                        curTransBalance := 0;
                                    end;
                                end;
                        end;
                    end;
                end;

                //For those transactions with Start and End Date Specified
                if (prEmployeeTransactions."Start Date" <> 0D) and (prEmployeeTransactions."End Date" <> 0D) then begin
                    if prEmployeeTransactions."End Date" < dtNewPeriod then begin
                        curTransAmount := 0;
                        curTransBalance := 0;
                    end;
                end;
                //End Transactions with Start and End Date

                if (prTransactionCodes.Frequency = prTransactionCodes.Frequency::Fixed) and
                   (prEmployeeTransactions."Stop for Next Period" = false) then //DENNO ADDED THIS TO CHECK FREQUENCY AND STOP IF MARKED
                 begin
                    if (curTransAmount <> 0) then  //Update the employee transaction table
                     begin
                        if ((prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Reducing) and (curTransBalance <> 0)) or
                         (prTransactionCodes."Balance Type" <> prTransactionCodes."balance type"::Reducing) then
                            prEmployeeTransactions.Balance := curTransBalance;
                        prEmployeeTransactions.Modify;


                        //Insert record for the next period
                        with prEmployeeTrans do begin
                            Init;
                            "No." := prEmployeeTransactions."No.";
                            "Transaction Code" := prEmployeeTransactions."Transaction Code";
                            "Transaction Name" := prEmployeeTransactions."Transaction Name";
                            "Transaction Type" := prEmployeeTransactions."Transaction Type";
                            Amount := curTransAmount;
                            Balance := curTransBalance;
                            "Amtzd Loan Repay Amt" := prEmployeeTransactions."Amtzd Loan Repay Amt";
                            "Original Amount" := prEmployeeTransactions."Original Amount";
                            Membership := prEmployeeTransactions.Membership;
                            "Reference No" := prEmployeeTransactions."Reference No";
                            "Loan Number" := prEmployeeTransactions."Loan Number";
                            "Period Month" := intNewMonth;
                            "Period Year" := intNewYear;
                            "Payroll Period" := dtNewPeriod;
                            "Payroll Code" := PayrollCode;
                            Insert;
                        end;
                    end;
                end
            until prEmployeeTransactions.Next = 0;
        end;

        //Update the Period as Closed
        prPayrollPeriods.Reset;
        prPayrollPeriods.SetRange(prPayrollPeriods."Period Month", intMonth);
        prPayrollPeriods.SetRange(prPayrollPeriods."Period Year", intYear);
        prPayrollPeriods.SetRange(prPayrollPeriods.Closed, false);
        if ControlInfo."Multiple Payroll" then
            prPayrollPeriods.SetRange(prPayrollPeriods."Payroll Code", PayrollCode);

        if prPayrollPeriods.Find('-') then begin
            prPayrollPeriods.Closed := true;
            prPayrollPeriods."Date Closed" := Today;
            prPayrollPeriods.Modify;
        end;

        //Enter a New Period
        with prNewPayrollPeriods do begin
            Init;
            "Period Month" := intNewMonth;
            "Period Year" := intNewYear;
            "Period Name" := Format(dtNewPeriod, 0, '<Month Text>') + '' + Format(intNewYear);
            "Date Opened" := dtNewPeriod;
            Closed := false;
            "Payroll Code" := PayrollCode;
            Insert;
        end;

        //Effect the transactions for the P9
        fnP9PeriodClosure(intMonth, intYear, dtOpenPeriod, PayrollCode);

        //Take all the Negative pay (Net) for the current month & treat it as a deduction in the new period
        fnGetNegativePay(intMonth, intYear, dtOpenPeriod);
    end;


    procedure fnGetNegativePay(intMonth: Integer; intYear: Integer; dtOpenPeriod: Date)
    var
        prPeriodTransactions: Record "prPeriod Transactions.";
        prEmployeeTransactions: Record "Payroll Employee Transactions.";
        intNewMonth: Integer;
        intNewYear: Integer;
        dtNewPeriod: Date;
    begin
        dtNewPeriod := CalcDate('1M', dtOpenPeriod);
        intNewMonth := Date2dmy(dtNewPeriod, 2);
        intNewYear := Date2dmy(dtNewPeriod, 3);

        prPeriodTransactions.Reset;
        prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
        prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
        prPeriodTransactions.SetRange(prPeriodTransactions."Group Order", 9);
        prPeriodTransactions.SetFilter(prPeriodTransactions.Amount, '<0');

        if prPeriodTransactions.Find('-') then begin
            repeat
                with prEmployeeTransactions do begin
                    Init;
                    "No." := prPeriodTransactions."Employee Code";
                    "Transaction Code" := 'NEGP';
                    "Transaction Name" := 'Negative Pay';
                    Amount := prPeriodTransactions.Amount;
                    Balance := 0;
                    "Original Amount" := 0;
                    "Period Month" := intNewMonth;
                    "Period Year" := intNewYear;
                    "Payroll Period" := dtNewPeriod;
                    Insert;
                end;
            until prPeriodTransactions.Next = 0;
        end;
    end;


    procedure fnP9PeriodClosure(intMonth: Integer; intYear: Integer; dtCurPeriod: Date; PayrollCode: Code[20])
    var
        P9EmployeeCode: Code[20];
        P9BasicPay: Decimal;
        P9Allowances: Decimal;
        P9Benefits: Decimal;
        P9ValueOfQuarters: Decimal;
        P9DefinedContribution: Decimal;
        P9OwnerOccupierInterest: Decimal;
        P9GrossPay: Decimal;
        P9TaxablePay: Decimal;
        P9TaxCharged: Decimal;
        P9InsuranceRelief: Decimal;
        P9TaxRelief: Decimal;
        P9Paye: Decimal;
        P9NSSF: Decimal;
        P9NHIF: Decimal;
        P9Deductions: Decimal;
        P9NetPay: Decimal;
        prPeriodTransactions: Record "prPeriod Transactions.";
        prEmployee: Record "Payroll Employee.";
    begin
        P9BasicPay := 0;
        P9Allowances := 0;
        P9Benefits := 0;
        P9ValueOfQuarters := 0;
        P9DefinedContribution := 0;
        P9OwnerOccupierInterest := 0;
        P9GrossPay := 0;
        P9TaxablePay := 0;
        P9TaxCharged := 0;
        P9InsuranceRelief := 0;
        P9TaxRelief := 0;
        P9Paye := 0;
        P9NSSF := 0;
        P9NHIF := 0;
        P9Deductions := 0;
        P9NetPay := 0;

        prEmployee.Reset;
        prEmployee.SetRange(prEmployee.Status, prEmployee.Status::Active);
        if prEmployee.Find('-') then begin
            repeat

                P9BasicPay := 0;
                P9Allowances := 0;
                P9Benefits := 0;
                P9ValueOfQuarters := 0;
                P9DefinedContribution := 0;
                P9OwnerOccupierInterest := 0;
                P9GrossPay := 0;
                P9TaxablePay := 0;
                P9TaxCharged := 0;
                P9InsuranceRelief := 0;
                P9TaxRelief := 0;
                P9Paye := 0;
                P9NSSF := 0;
                P9NHIF := 0;
                P9Deductions := 0;
                P9NetPay := 0;

                prPeriodTransactions.Reset;
                prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
                prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
                prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", prEmployee."No.");
                if prPeriodTransactions.Find('-') then begin
                    repeat
                        with prPeriodTransactions do begin
                            case prPeriodTransactions."Group Order" of
                                1: //Basic pay & Arrears
                                    begin
                                        if "Sub Group Order" = 1 then P9BasicPay := Amount; //Basic Pay
                                        if "Sub Group Order" = 2 then P9BasicPay := P9BasicPay + Amount; //Basic Pay Arrears
                                    end;
                                3:  //Allowances
                                    begin
                                        P9Allowances := P9Allowances + Amount
                                    end;
                                4: //Gross Pay
                                    begin
                                        P9GrossPay := Amount
                                    end;
                                6: //Taxation
                                    begin
                                        if "Sub Group Order" = 1 then P9DefinedContribution := Amount; //Defined Contribution
                                        if "Sub Group Order" = 9 then P9TaxRelief := Amount; //Tax Relief
                                        if "Sub Group Order" = 8 then P9InsuranceRelief := Amount; //Insurance Relief
                                        if "Sub Group Order" = 6 then P9TaxablePay := Amount; //Taxable Pay
                                        if "Sub Group Order" = 7 then P9TaxCharged := Amount; //Tax Charged
                                    end;
                                7: //Statutories
                                    begin
                                        if "Sub Group Order" = 1 then P9NSSF := Amount; //Nssf
                                        if "Sub Group Order" = 2 then P9NHIF := Amount; //Nhif
                                        if "Sub Group Order" = 3 then P9Paye := Amount; //paye
                                        if "Sub Group Order" = 4 then P9Paye := P9Paye + Amount; //Paye Arrears
                                    end;
                                8://Deductions
                                    begin
                                        P9Deductions := P9Deductions + Amount;
                                    end;
                                9: //NetPay
                                    begin
                                        P9NetPay := Amount;
                                    end;
                            end;
                        end;
                    until prPeriodTransactions.Next = 0;
                end;
                //Update the P9 Details

                if P9NetPay <> 0 then
                    fnUpdateP9Table(prEmployee."No.", P9BasicPay, P9Allowances, P9Benefits, P9ValueOfQuarters, P9DefinedContribution,
                        P9OwnerOccupierInterest, P9GrossPay, P9TaxablePay, P9TaxCharged, P9InsuranceRelief, P9TaxRelief, P9Paye, P9NSSF,
                        P9NHIF, P9Deductions, P9NetPay, dtCurPeriod, PayrollCode);

            until prEmployee.Next = 0;
        end;
    end;


    procedure fnUpdateP9Table(P9EmployeeCode: Code[20]; P9BasicPay: Decimal; P9Allowances: Decimal; P9Benefits: Decimal; P9ValueOfQuarters: Decimal; P9DefinedContribution: Decimal; P9OwnerOccupierInterest: Decimal; P9GrossPay: Decimal; P9TaxablePay: Decimal; P9TaxCharged: Decimal; P9InsuranceRelief: Decimal; P9TaxRelief: Decimal; P9Paye: Decimal; P9NSSF: Decimal; P9NHIF: Decimal; P9Deductions: Decimal; P9NetPay: Decimal; dtCurrPeriod: Date; prPayrollCode: Code[20])
    var
        prEmployeeP9Info: Record "Payroll Employee P9.";
        intYear: Integer;
        intMonth: Integer;
    begin
        intMonth := Date2dmy(dtCurrPeriod, 2);
        intYear := Date2dmy(dtCurrPeriod, 3);

        prEmployeeP9Info.Reset;
        with prEmployeeP9Info do begin
            Init;
            "Employee Code" := P9EmployeeCode;
            "Basic Pay" := P9BasicPay;
            Allowances := P9Allowances;
            Benefits := P9Benefits;
            "Value Of Quarters" := P9ValueOfQuarters;
            "Defined Contribution" := P9DefinedContribution;
            "Owner Occupier Interest" := P9OwnerOccupierInterest;
            "Gross Pay" := P9GrossPay;
            "Taxable Pay" := P9TaxablePay;
            "Tax Charged" := P9TaxCharged;
            "Insurance Relief" := P9InsuranceRelief;
            "Tax Relief" := P9TaxRelief;
            PAYE := P9Paye;
            NSSF := P9NSSF;
            NHIF := P9NHIF;
            Deductions := P9Deductions;
            "Net Pay" := P9NetPay;
            "Period Month" := intMonth;
            "Period Year" := intYear;
            "Payroll Period" := dtCurrPeriod;
            "Payroll Code" := prPayrollCode;
            Insert;
        end;
    end;


    procedure fnDaysWorked(dtDate: Date; IsTermination: Boolean) DaysWorked: Integer
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
        // SysDate.SETFILTER(SysDate."Period No.",'1..5');
        if SysDate.Find('-') then
            DaysWorked := SysDate.Count;
    end;


    procedure fnSalaryArrears(EmpCode: Text[30]; TransCode: Text[30]; CBasic: Decimal; StartDate: Date; EndDate: Date; dtOpenPeriod: Date; dtDOE: Date; dtTermination: Date)
    var
        FirstMonth: Boolean;
        startmonth: Integer;
        startYear: Integer;
        "prEmployee P9 Info": Record "Payroll Employee P9.";
        P9BasicPay: Decimal;
        P9taxablePay: Decimal;
        P9PAYE: Decimal;
        ProratedBasic: Decimal;
        SalaryArrears: Decimal;
        SalaryVariance: Decimal;
        SupposedTaxablePay: Decimal;
        SupposedTaxCharged: Decimal;
        SupposedPAYE: Decimal;
        PAYEVariance: Decimal;
        PAYEArrears: Decimal;
        PeriodMonth: Integer;
        PeriodYear: Integer;
        CountDaysofMonth: Integer;
        DaysWorked: Integer;
    begin
        fnInitialize;

        FirstMonth := true;
        if EndDate > StartDate then begin
            while StartDate < EndDate do begin
                //fnGetEmpP9Info
                startmonth := Date2dmy(StartDate, 2);
                startYear := Date2dmy(StartDate, 3);

                "prEmployee P9 Info".Reset;
                "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Employee Code", EmpCode);
                "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Period Month", startmonth);
                "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Period Year", startYear);
                if "prEmployee P9 Info".Find('-') then begin
                    P9BasicPay := "prEmployee P9 Info"."Basic Pay";
                    P9taxablePay := "prEmployee P9 Info"."Taxable Pay";
                    P9PAYE := "prEmployee P9 Info".PAYE;

                    if P9BasicPay > 0 then   //Staff payment history is available
                     begin
                        if FirstMonth then begin                 //This is the first month in the arrears loop
                            if Date2dmy(StartDate, 1) <> 1 then //if the date doesn't start on 1st, we have to prorate the salary
                             begin
                                //ProratedBasic := ProratePay.fnProratePay(P9BasicPay, CBasic, StartDate); ********
                                //Get the Basic Salary (prorate basic pay if needed) //Termination Remaining
                                if (Date2dmy(dtDOE, 2) = Date2dmy(StartDate, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(StartDate, 3)) then begin
                                    CountDaysofMonth := fnDaysInMonth(dtDOE);
                                    DaysWorked := fnDaysWorked(dtDOE, false);
                                    ProratedBasic := fnBasicPayProrated(EmpCode, startmonth, startYear, P9BasicPay, DaysWorked, CountDaysofMonth)
                                end;

                                //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                                if dtTermination <> 0D then begin
                                    if (Date2dmy(dtTermination, 2) = Date2dmy(StartDate, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(StartDate, 3)) then begin
                                        CountDaysofMonth := fnDaysInMonth(dtTermination);
                                        DaysWorked := fnDaysWorked(dtTermination, true);
                                        ProratedBasic := fnBasicPayProrated(EmpCode, startmonth, startYear, P9BasicPay, DaysWorked, CountDaysofMonth)
                                    end;
                                end;

                                SalaryArrears := (CBasic - ProratedBasic)
                            end
                            else begin
                                SalaryArrears := (CBasic - P9BasicPay);
                            end;
                        end;
                        SalaryVariance := SalaryVariance + SalaryArrears;
                        SupposedTaxablePay := P9taxablePay + SalaryArrears;

                        //To calc paye arrears, check if the Supposed Taxable Pay is > the taxable pay for the loop period
                        if SupposedTaxablePay > P9taxablePay then begin
                            SupposedTaxCharged := fnGetEmployeePaye(SupposedTaxablePay);
                            SupposedPAYE := SupposedTaxCharged - curReliefPersonal;
                            PAYEVariance := SupposedPAYE - P9PAYE;
                            PAYEArrears := PAYEArrears + PAYEVariance;
                        end;
                        FirstMonth := false;               //reset the FirstMonth Boolean to False
                    end;
                end;
                StartDate := CalcDate('+1M', StartDate);
            end;
            if SalaryArrears <> 0 then begin
                PeriodYear := Date2dmy(dtOpenPeriod, 3);
                PeriodMonth := Date2dmy(dtOpenPeriod, 2);
                fnUpdateSalaryArrears(EmpCode, TransCode, StartDate, EndDate, SalaryArrears, PAYEArrears, PeriodMonth, PeriodYear,
                dtOpenPeriod);
            end

        end
        else
            Error('The start date must be earlier than the end date');
    end;


    procedure fnUpdateSalaryArrears(EmployeeCode: Text[50]; TransCode: Text[50]; OrigStartDate: Date; EndDate: Date; SalaryArrears: Decimal; PayeArrears: Decimal; intMonth: Integer; intYear: Integer; payperiod: Date)
    var
        FirstMonth: Boolean;
        ProratedBasic: Decimal;
        SalaryVariance: Decimal;
        PayeVariance: Decimal;
        SupposedTaxablePay: Decimal;
        SupposedTaxCharged: Decimal;
        SupposedPaye: Decimal;
        CurrentBasic: Decimal;
        StartDate: Date;
        "prSalary Arrears": Record "Payroll Salary Arrears.";
    begin
        "prSalary Arrears".Reset;
        "prSalary Arrears".SetRange("prSalary Arrears"."Employee Code", EmployeeCode);
        "prSalary Arrears".SetRange("prSalary Arrears"."Transaction Code", TransCode);
        "prSalary Arrears".SetRange("prSalary Arrears"."Period Month", intMonth);
        "prSalary Arrears".SetRange("prSalary Arrears"."Period Year", intYear);
        if "prSalary Arrears".Find('-') = false then begin
            "prSalary Arrears".Init;
            "prSalary Arrears"."Employee Code" := EmployeeCode;
            "prSalary Arrears"."Transaction Code" := TransCode;
            "prSalary Arrears"."Start Date" := OrigStartDate;
            "prSalary Arrears"."End Date" := EndDate;
            "prSalary Arrears"."Salary Arrears" := SalaryArrears;
            "prSalary Arrears"."PAYE Arrears" := PayeArrears;
            "prSalary Arrears"."Period Month" := intMonth;
            "prSalary Arrears"."Period Year" := intYear;
            "prSalary Arrears"."Payroll Period" := payperiod;
            "prSalary Arrears".Insert;
        end
    end;


    procedure fnCalcLoanInterest(strEmpCode: Code[20]; strTransCode: Code[20]; InterestRate: Decimal; RecoveryMethod: Option Reducing,"Straight line",Amortized; LoanAmount: Decimal; Balance: Decimal; CurrPeriod: Date; Welfare: Boolean) LnInterest: Decimal
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
        LnInterest := ROUND(curLoanInt, 0.05, '<');
    end;


    procedure fnUpdateEmployerDeductions(EmpCode: Code[20]; TCode: Code[20]; TGroup: Code[20]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date)
    var
        prEmployerDeductions: Record "Payroll Employer Deductions.";
    begin

        if curAmount = 0 then exit;
        with prEmployerDeductions do begin
            Init;
            "Employee Code" := EmpCode;
            "Transaction Code" := TCode;
            Amount := curAmount;
            "Period Month" := Month;
            "Period Year" := Year;
            "Payroll Period" := dtOpenPeriod;
            Insert;
        end;
    end;


    procedure fnDisplayFrmlValues(EmpCode: Code[30]; intMonth: Integer; intYear: Integer; Formula: Text[50]) curTransAmount: Decimal
    var
        pureformula: Text[50];
    begin
        pureformula := fnPureFormula(EmpCode, intMonth, intYear, Formula);
        curTransAmount := fnFormulaResult(pureformula); //Get the calculated amount
    end;


    procedure fnUpdateEmployeeTrans(EmpCode: Code[20]; TransCode: Code[20]; Amount: Decimal; Month: Integer; Year: Integer; PayrollPeriod: Date)
    var
        prEmployeeTrans: Record "Payroll Employee Transactions.";
    begin
        prEmployeeTrans.Reset;
        prEmployeeTrans.SetRange(prEmployeeTrans."No.", EmpCode);
        /*prEmployeeTrans.SETRANGE(prEmployeeTrans."Transaction Code",TransCode);
        prEmployeeTrans.SETRANGE(prEmployeeTrans."Payroll Period",PayrollPeriod);
        prEmployeeTrans.SETRANGE(prEmployeeTrans."Period Month",Month);
        prEmployeeTrans.SETRANGE(prEmployeeTrans."Period Year",Year);*/
        if prEmployeeTrans.Find('-') then begin
            // prEmployeeTrans.Amount:=Amount;
            //prEmployeeTrans.MODIFY;}
            FnUpdateBalances(prEmployeeTrans);
        end;

    end;


    procedure fnGetJournalDet(strEmpCode: Code[20])
    var
        SalaryCard: Record "Payroll Employee.";
    begin
        //Get Payroll Posting Accounts
        if SalaryCard.Get(strEmpCode) then begin
            if PostingGroup.Get(SalaryCard."Posting Group") then begin
                //Comment This for the Time Being

                PostingGroup.TestField("Salary Account");
                PostingGroup.TestField("Income Tax Account");
                PostingGroup.TestField("Net Salary Payable");
                PostingGroup.TestField("SSF Employer Account");
                // PostingGroup.TESTFIELD("Pension Employer Acc");

                TaxAccount := PostingGroup."Income Tax Account";
                salariesAcc := PostingGroup."Salary Account";
                PayablesAcc := PostingGroup."Net Salary Payable";
                // PayablesAcc:=SalaryCard."Bank Account Number";
                NSSFEMPyer := PostingGroup."SSF Employer Account";
                NSSFEMPyee := PostingGroup."SSF Employee Account";
                //NHIFEMPyee:=PostingGroup."NHIF Employee Account";
                NHIFEMPyee := PostingGroup."NHIF Employee Account";
                PensionEMPyer := PostingGroup."Pension Employer Acc";
                //TelTaxACC:=PostingGroup."Telephone Tax Acc";
            end else begin
                //ERROR('Please specify Posting Group in Employee No.  '+strEmpCode);
            end;
        end;
        //End Get Payroll Posting Accounts
    end;


    procedure fnGetSpecialTransAmount2(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage; blnCompDedc: Boolean)
    var
        prEmployeeTransactions: Record "Payroll Employee Transactions.";
        prTransactionCodes: Record "Payroll Transaction Code.";
        strExtractedFrml: Text[250];
    begin
        SpecialTranAmount := 0;
        prTransactionCodes.Reset;
        prTransactionCodes.SetRange(prTransactionCodes."Special Transaction", intSpecTransID);
        if prTransactionCodes.Find('-') then begin
            repeat
                prEmployeeTransactions.Reset;
                prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
                if prEmployeeTransactions.Find('-') then begin

                    //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
                    //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
                    case intSpecTransID of
                        Intspectransid::"Defined Contribution":
                            if prTransactionCodes."Is Formulae" then begin
                                strExtractedFrml := '';
                                if Management then
                                    strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Formula for Management Prov")
                                else
                                    strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formulae);

                                SpecialTranAmount := SpecialTranAmount + (fnFormulaResult(strExtractedFrml)); //Get the calculated amount
                            end else
                                SpecialTranAmount := SpecialTranAmount + prEmployeeTransactions.Amount;

                        Intspectransid::"Life Insurance":
                            SpecialTranAmount := SpecialTranAmount + ((curReliefInsurance / 100) * prEmployeeTransactions.Amount);

                        //
                        Intspectransid::"Owner Occupier Interest":
                            SpecialTranAmount := SpecialTranAmount + prEmployeeTransactions.Amount;


                        Intspectransid::"Home Ownership Savings Plan":
                            SpecialTranAmount := SpecialTranAmount + prEmployeeTransactions.Amount;

                        Intspectransid::Morgage:
                            begin
                                SpecialTranAmount := SpecialTranAmount + curReliefMorgage;

                                if SpecialTranAmount > curReliefMorgage then begin
                                    SpecialTranAmount := curReliefMorgage
                                end;

                            end;

                    end;
                end;
            until prTransactionCodes.Next = 0;
        end;
    end;


    procedure fnCheckPaysPension(pnEmpCode: Code[20]; pnPayperiod: Date) PaysPens: Boolean
    var
        pnTranCode: Record "Payroll Transaction Code.";
        pnEmpTrans: Record "Payroll Employee Transactions.";
    begin
        PaysPens := false;
        pnEmpTrans.Reset;
        pnEmpTrans.SetRange(pnEmpTrans."No.", pnEmpCode);
        pnEmpTrans.SetRange(pnEmpTrans."Payroll Period", pnPayperiod);
        if pnEmpTrans.Find('-') then begin
            repeat
                if pnTranCode.Get(pnEmpTrans."Transaction Code") then
                    if pnTranCode."Co-Op Parameters" = pnTranCode."co-op parameters"::Welfare then
                        PaysPens := true;
            until pnEmpTrans.Next = 0;
        end;
    end;


    procedure fnGetEmployeeNSSF(curBaseAmount: Decimal) NSSF: Decimal
    var
        prNSSF: Record "Payroll NSSF Setup.";
    begin
        prNSSF.Reset;
        prNSSF.SetRange(prNSSF."Tier Code");
        if prNSSF.Find('-') then begin
            repeat
                if ((curBaseAmount >= prNSSF."Lower Limit") and (curBaseAmount <= prNSSF."Upper Limit")) then
                    NSSF := prNSSF."Tier 1 Employee Deduction" + prNSSF."Tier 2 Employee Deduction";
            until prNSSF.Next = 0;
        end;
    end;


    procedure fnGetEmployerNSSF(curBaseAmount: Decimal) NSSF: Decimal
    var
        prNSSF: Record "Payroll NSSF Setup.";
    begin
        prNSSF.Reset;
        prNSSF.SetRange(prNSSF."Tier Code");
        if prNSSF.Find('-') then begin
            repeat
                if ((curBaseAmount >= prNSSF."Lower Limit") and (curBaseAmount <= prNSSF."Upper Limit")) then
                    NSSF := prNSSF."Tier 1 Employer Contribution" + prNSSF."Tier 2 Employer Contribution";
            until prNSSF.Next = 0;
        end;
    end;

    local procedure FnUpdateBalances("Payroll Employee Transactions.": Record "Payroll Employee Transactions.")
    var
        ObjMemberLedger: Record "Cust. Ledger Entry";
        Totalshares: Decimal;
        ObjLoanRegister: Record "Loans Register";
        LNPric: Decimal;
        ObjPRTransactioons: Record "prPeriod Transactions.";
    begin
        ObjPRTransactioons.Reset;
        ObjPRTransactioons.SetRange(ObjPRTransactioons."Employee Code", "Payroll Employee Transactions."."No.");
        if ObjPRTransactioons.Find('-') then
            Report.Run(51516591, false, false, ObjPRTransactioons);
    end;

    local procedure FnGetInterestRate(LoanProductCode: Code[40]) InterestRate: Decimal
    var
        ObjLoanProducts: Record "Loan Products Setup";
    begin
        ObjLoanProducts.Reset;
        ObjLoanProducts.SetRange(ObjLoanProducts.Code, LoanProductCode);
        if ObjLoanProducts.Find('-') then begin
            InterestRate := ObjLoanProducts."Interest rate";
        end;
        exit(InterestRate);
    end;

    local procedure FnLoanInterestExempted(LoanNo: Code[50]) Found: Boolean
    var
        ObjExemptedLoans: Record "Loan Repay Schedule-Calc";
    begin
        ObjExemptedLoans.Reset;
        ObjExemptedLoans.SetRange(ObjExemptedLoans."Loan Category", LoanNo);
        if ObjExemptedLoans.Find('-') then begin
            Found := true;
        end;
        exit(Found);
    end;
}

