#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516016 "prPayrollProcessingXX"
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
        VitalSetup: Record "prVital Setup Info.";
        curReliefPersonal: Decimal;
        curReliefInsurance: Decimal;
        curReliefMorgage: Decimal;
        curMaximumRelief: Decimal;
        curNssfEmployee: Decimal;
        curNssf_Employer_Factor: Decimal;
        intNHIF_BasedOn: Option Gross,Basic,"Taxable Pay";
        curMaxPensionContrib: Decimal;
        curRateTaxExPension: Decimal;
        curOOIMaxMonthlyContrb: Decimal;
        curOOIDecemberDedc: Decimal;
        curLoanMarketRate: Decimal;
        curLoanCorpRate: Decimal;
        PostingGroup: Record "prEmployee Posting Group";
        TaxAccount: Code[20];
        salariesAcc: Code[20];
        PayablesAcc: Code[20];
        NSSFEMPyer: Code[20];
        PensionEMPyer: Code[20];
        NSSFEMPyee: Code[20];
        NHIFEMPyer: Code[20];
        NHIFEMPyee: Code[20];
        HrEmployee: Record "HR Employees";
        CoopParameters: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","Development Loan","SACCO Deposit",Insurance,"School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF,"Admin fee";
        TelAllowance: Decimal;


    procedure fnInitialize()
    begin

        //Initialize Global Setup Items
        VitalSetup.FindFirst;
        with VitalSetup do begin
            curReliefPersonal := "Tax Relief";
            curReliefInsurance := "Insurance Relief";
            curReliefMorgage := "Mortgage Relief"; //Same as HOSP
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


    procedure fnProcesspayroll(strEmpCode: Code[20]; dtDOE: Date; curBasicPay: Decimal; blnPaysPaye: Boolean; blnPaysNssf: Boolean; blnPaysNhif: Boolean; SelectedPeriod: Date; dtOpenPeriod: Date; Membership: Text[30]; ReferenceNo: Text[30]; dtTermination: Date; blnGetsPAYERelief: Boolean; Dept: Code[20])
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
        prPeriodTransactions: Record "prPeriod Transactions";
        intYear: Integer;
        intMonth: Integer;
        LeapYear: Boolean;
        CountDaysofMonth: Integer;
        DaysWorked: Integer;
        prSalaryArrears: Record "prSalary Arrears";
        prEmployeeTransactions: Record "prEmployee Transactions";
        prTransactionCodes: Record "prTransaction Codes";
        strExtractedFrml: Text[250];
        SpecialTransType: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage;
        TransactionType: Option Income,Deduction;
        curPensionCompany: Decimal;
        curTaxOnExcessPension: Decimal;
        prUnusedRelief: Record "prUnused Relief";
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
        prEmployerDeductions: Record "prEmployer Deductions.";
        JournalPostingType: Option " ","G/L Account",Customer,Vendor,Member;
        JournalAcc: Code[20];
        Customer: Record Customer;
        JournalPostAs: Option " ",Debit,Credit;
        IsCashBenefit: Decimal;
        TotFrigeBenefits: Decimal;
        HREmployes: Record "HR Employees";
        TotDedArrears: Decimal;
    begin

        //Initialize
        fnInitialize;
        fnGetJournalDet(strEmpCode);

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
                    strTransDescription := 'Salary Arrears- Provident';
                    //TGroup := 'ARREARS'; TGroupOrder := 1; TSubGroupOrder := 1;
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
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
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
            if prEmployeeTransactions.Find('-') then begin
                IsCashBenefit := 0;
                curTotAllowances := 0;
                repeat

                    prTransactionCodes.Reset;
                    prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                    prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."transaction type"::Income);

                    if prTransactionCodes.Find('-') then begin

                        curTransAmount := 0;
                        curTransBalance := 0;
                        strTransDescription := '';
                        strExtractedFrml := '';

                        if prTransactionCodes."Is Formula" then begin
                            strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                            curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount

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
                        if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transactions" =
                        prTransactionCodes."special transactions"::Ignore) then
                            curNonTaxable := curNonTaxable + curTransAmount;

                        //Added to ensure special transaction that are not taxable are not inlcuded in list of Allowances
                        if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transactions" <>
                        prTransactionCodes."special transactions"::Ignore) then
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
                        if prTransactionCodes.Subledger <> prTransactionCodes.Subledger::" " then begin
                            if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Customer then begin
                                HrEmployee.Get(strEmpCode);
                                Customer.Reset;
                                Customer.SetRange(Customer."Personal No", HrEmployee."No.");
                                if Customer.Find('-') then begin
                                    JournalAcc := Customer."No.";
                                    JournalPostingType := Journalpostingtype::Member;
                                end;

                            end else begin
                                JournalAcc := prTransactionCodes."GL Account";
                                JournalPostingType := Journalpostingtype::"G/L Account";
                            end;
                        end;
                        //Cash Benefits
                        if prTransactionCodes."Is Cash" then
                            IsCashBenefit := IsCashBenefit + curTransAmount;

                        //End posting Details


                        fnUpdatePeriodTrans(strEmpCode, prTransactionCodes."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                        strTransDescription, curTransAmount, curTransBalance, intMonth, intYear, prEmployeeTransactions.Membership,
                        prEmployeeTransactions."Reference No", SelectedPeriod, Dept, JournalAcc, Journalpostas::Debit, JournalPostingType, '',
                        prTransactionCodes."coop parameters");

                    end;
                until prEmployeeTransactions.Next = 0;
            end;


            // Telephone allowance taxable but does not affect net
            prEmployeeTransactions.Reset;
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", 'D027');
            if prEmployeeTransactions.Find('-') then begin
                //REPEAT
                TelAllowance := prEmployeeTransactions.Amount;
                //UNTIL prEmployeeTransactions.NEXT=0;
            end;
            //MESSAGE('the allowance is %1',TelAllowance);


            /*
         //aRREAS pROVIDEND
           prEmployeeTransactions.RESET;
          prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Employee Code",strEmpCode);
          prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Month",intMonth);
          prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Year",intYear);
          prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Transaction Code",'E0006');
          IF prEmployeeTransactions.FIND('-') THEN BEGIN
            IsCashBenefit:=0;
            curTotAllowances:= 0;
            REPEAT

              prTransactionCodes.RESET;
              prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Code",'E0006');
              //prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Code",prEmployeeTransactions."Transaction Code");
              //prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Type",prTransactionCodes."Transaction Type"::Income);

              IF prTransactionCodes.FIND('-') THEN BEGIN

                curTransAmount:=0; curTransBalance := 0; strTransDescription := ''; strExtractedFrml := '';

                IF prTransactionCodes."Is Formula" THEN BEGIN
                    strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                    curTransAmount := prEmployerDeductions.Amount*0.1;//fnFormulaResult(strExtractedFrml); //Get the calculated amount

                END ELSE BEGIN
                    curTransAmount := prEmployeeTransactions.Amount*0.1;;
                END;



               IF prTransactionCodes."Balance Type"=prTransactionCodes."Balance Type"::None THEN //[0=None, 1=Increasing, 2=Reducing]
                         curTransBalance := 0;
               IF prTransactionCodes."Balance Type"=prTransactionCodes."Balance Type"::Increasing THEN
                         curTransBalance := prEmployeeTransactions.Balance+ curTransAmount;
               IF prTransactionCodes."Balance Type"= prTransactionCodes."Balance Type"::Reducing THEN
                         curTransBalance := prEmployeeTransactions.Balance - curTransAmount;

                     {
                  //Prorate Allowances Here
                   //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
                   IF (DATE2DMY(dtDOE,2)=DATE2DMY(dtOpenPeriod,2)) AND (DATE2DMY(dtDOE,3)=DATE2DMY(dtOpenPeriod,3))THEN BEGIN
                      CountDaysofMonth:=fnDaysInMonth(dtDOE);
                      DaysWorked:=fnDaysWorked(dtDOE,FALSE);
                      curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount,DaysWorked,CountDaysofMonth)
                   END;

                  //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                  IF dtTermination<>0D THEN BEGIN
                   IF (DATE2DMY(dtTermination,2)=DATE2DMY(dtOpenPeriod,2)) AND (DATE2DMY(dtTermination,3)=DATE2DMY(dtOpenPeriod,3))THEN
         BEGIN
                     CountDaysofMonth:=fnDaysInMonth(dtTermination);
                     DaysWorked:=fnDaysWorked(dtTermination,TRUE);
                     curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount,DaysWorked,CountDaysofMonth)
                   END;
                  END;
                 // Prorate Allowances Here
                      }

                  //Add Non Taxable Here
                  IF (NOT prTransactionCodes.Taxable) AND (prTransactionCodes."Special Transactions" =
                  prTransactionCodes."Special Transactions"::Ignore) THEN
                      curNonTaxable:=curNonTaxable+curTransAmount;

                  //Added to ensure special transaction that are not taxable are not inlcuded in list of Allowances
                  IF (NOT prTransactionCodes.Taxable) AND (prTransactionCodes."Special Transactions" <>
                  prTransactionCodes."Special Transactions"::Ignore) THEN
                     curTransAmount:=0;

                  curTotAllowances := curTotAllowances + curTransAmount; //Sum-up all the allowances

                  curTransAmount := curTransAmount;
                  curTransBalance := curTransBalance;
                  strTransDescription := prTransactionCodes."Transaction Name";
                  TGroup := 'DEDUCTIONS'; TGroupOrder := 8; TSubGroupOrder := 0;

                  //Get the posting Details
                  JournalPostingType:=JournalPostingType::" ";JournalAcc:='';
                  IF prTransactionCodes.Subledger<>prTransactionCodes.Subledger::" " THEN BEGIN
                     IF prTransactionCodes.Subledger=prTransactionCodes.Subledger::Customer THEN BEGIN
                         HrEmployee.GET(strEmpCode);
                         Customer.RESET;
                         Customer.SETRANGE(Customer."Payroll/Staff No",HrEmployee."No.");
                         IF Customer.FIND('-') THEN BEGIN
                            JournalAcc:=Customer."No.";
                            JournalPostingType:=JournalPostingType::Member;
                         END;

                  END ELSE BEGIN
                     JournalAcc:=prTransactionCodes."GL Account";
                     JournalPostingType:=JournalPostingType::"G/L Account";
                  END;
                   END;
                   //Cash Benefits
                   IF prTransactionCodes."Is Cash" THEN
                      IsCashBenefit:=IsCashBenefit+curTransAmount;

                  //End posting Details


                  fnUpdatePeriodTrans(strEmpCode,prTransactionCodes."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                  strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,prEmployeeTransactions.Membership,
                  prEmployeeTransactions."Reference No",SelectedPeriod,Dept,JournalAcc,JournalPostAs::Debit,JournalPostingType,'',
                  prTransactionCodes."coop parameters");

              END;
            UNTIL prEmployeeTransactions.NEXT=0;
          END;

         //ARREAS pROVIDEND

               */

            //Calc GrossPay = (BasicSalary + Allowances + SalaryArrears) [Group Order = 4]
            curGrossPay := (curBasicPay + curTotAllowances);// + curSalaryArrears);
            curTransAmount := ROUND(curGrossPay, 1); //curGrossPay;
                                                     //curTransAmount := curGrossPay;
            strTransDescription := 'Gross Pay';
            TGroup := 'GROSS PAY';
            TGroupOrder := 4;
            TSubGroupOrder := 0;
            fnUpdatePeriodTrans(strEmpCode, 'GPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth,
             intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '', Coopparameters::none);

            //Get the NSSF amount
            if blnPaysNssf then
                curNSSF := curNssfEmployee;
            curTransAmount := curNSSF;
            strTransDescription := 'N.S.S.F';
            TGroup := 'STATUTORIES';
            TGroupOrder := 7;
            TSubGroupOrder := 1;
            fnUpdatePeriodTrans(strEmpCode, 'NSSF', TGroup, TGroupOrder, TSubGroupOrder,
            strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, NSSFEMPyee,
            Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::NSSF);


            //Get the Defined contribution to post based on the Max Def contrb allowed   ****************All Defined Contributions not included
            curDefinedContrib := curNSSF; //(curNSSF + curPensionStaff + curNonTaxable) - curMorgageReliefAmount
            curTransAmount := curDefinedContrib;
            strTransDescription := 'Defined Contributions';
            TGroup := 'TAX CALCULATIONS';
            TGroupOrder := 6;
            TSubGroupOrder := 1;
            fnUpdatePeriodTrans(strEmpCode, 'DEFCON', TGroup, TGroupOrder, TSubGroupOrder,
             strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ",
             Journalpostingtype::" ", '', Coopparameters::none);


            //Get the Gross taxable amount
            //>GrossTaxable = Gross + Benefits + nValueofQuarters  ******Confirm CurValueofQuaters
            curGrossTaxable := curGrossPay + curBenefits + curValueOfQuarters;

            //>If GrossTaxable = 0 Then TheDefinedToPost = 0
            if curGrossTaxable = 0 then curDefinedContrib := 0;

            //Personal Relief
            // if get relief is ticked  - DENNO ADDED
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
            end
            else
                curReliefPersonal := 0;

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
            if blnPaysPaye and blnGetsPAYERelief then begin
                //Get Insurance Relief
                curInsuranceReliefAmount := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                Specialtranstype::"Life Insurance", false); //Insurance is 3 on [Special Transaction]
                if curInsuranceReliefAmount > 0 then begin
                    curTransAmount := curInsuranceReliefAmount;
                    strTransDescription := 'Insurance Relief';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 8;
                    fnUpdatePeriodTrans(strEmpCode, 'INSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                    Coopparameters::none);
                end;

                //>OOI
                curOOI := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                Specialtranstype::"Owner Occupier Interest", false); //Morgage is LAST on [Special Transaction]
                if curOOI > 0 then begin
                    if curOOI <= curOOIMaxMonthlyContrb then
                        curTransAmount := curOOI
                    else
                        curTransAmount := curOOIMaxMonthlyContrb;

                    strTransDescription := 'Owner Occupier Interest';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 3;
                    fnUpdatePeriodTrans(strEmpCode, 'OOI', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                    Coopparameters::none);
                end;



                //aRREAS pROVIDEND
                prEmployeeTransactions.Reset;
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", 'E0006');
                if prEmployeeTransactions.Find('-') then begin
                    IsCashBenefit := 0;
                    curTotAllowances := 0;
                    repeat

                        prTransactionCodes.Reset;
                        prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", 'E0006');
                        //prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Code",prEmployeeTransactions."Transaction Code");
                        //prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Type",prTransactionCodes."Transaction Type"::Income);

                        if prTransactionCodes.Find('-') then begin

                            curTransAmount := 0;
                            curTransBalance := 0;
                            strTransDescription := '';
                            strExtractedFrml := '';

                            if prTransactionCodes."Is Formula" then begin
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                                curTransAmount := prEmployerDeductions.Amount * 0.1;//fnFormulaResult(strExtractedFrml); //Get the calculated amount

                            end else begin
                                curTransAmount := prEmployeeTransactions.Amount * 0.1;
                                ;

                            end;
                            curTotalDeductions := curTotalDeductions + curTransAmount;
                            TotDedArrears := TotDedArrears + curTransAmount;
                            //curTransBalance :=curTransAmount;


                            curTransAmount := curTransAmount;
                            curTransBalance := curTransBalance + TotDedArrears;
                            curTotalDeductions := curTotalDeductions + TotDedArrears;
                            strTransDescription := 'Arreas Providend';
                            TGroup := 'DEDUCTIONS';
                            TGroupOrder := 8;
                            TSubGroupOrder := 0;

                            //Get the posting Details
                            JournalPostingType := Journalpostingtype::" ";
                            JournalAcc := '';
                            if prTransactionCodes.Subledger <> prTransactionCodes.Subledger::" " then begin
                                if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Customer then begin
                                    HrEmployee.Get(strEmpCode);
                                    Customer.Reset;
                                    Customer.SetRange(Customer."Personal No", HrEmployee."No.");
                                    if Customer.Find('-') then begin
                                        JournalAcc := Customer."No.";
                                        JournalPostingType := Journalpostingtype::Member;
                                    end;

                                end else begin
                                    JournalAcc := prTransactionCodes."GL Account";
                                    JournalPostingType := Journalpostingtype::"G/L Account";
                                end;
                            end;
                            //Cash Benefits
                            if prTransactionCodes."Is Cash" then
                                IsCashBenefit := IsCashBenefit + curTransAmount;

                            //End posting Details

                            Message('The curSalaryArrears is %1', curTotalDeductions);

                            fnUpdatePeriodTrans(strEmpCode, 'D0009', TGroup, TGroupOrder, TSubGroupOrder,
                            strTransDescription, curTransAmount, curTransBalance, intMonth, intYear, prEmployeeTransactions.Membership,
                            prEmployeeTransactions."Reference No", SelectedPeriod, Dept, JournalAcc, Journalpostas::Debit, JournalPostingType, '',
                            prTransactionCodes."coop parameters");

                        end;
                    until prEmployeeTransactions.Next = 0;
                end;


                //ARREAS pROVIDEND


                //HOSP
                curHOSP := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                Specialtranstype::"Home Ownership Savings Plan", false); //Home Ownership Savings Plan
                if curHOSP > 0 then begin
                    if curHOSP <= curReliefMorgage then
                        curTransAmount := curHOSP
                    else begin
                        curTransAmount := curReliefMorgage;
                        curHOSP := curReliefMorgage; //I reset it here

                    end;


                    strTransDescription := 'Home Ownership Savings Plan';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 4;
                    fnUpdatePeriodTrans(strEmpCode, 'HOSP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                    Coopparameters::none);
                end;

                //Enter NonTaxable Amount
                if curNonTaxable > 0 then begin
                    strTransDescription := 'Other Non-Taxable Benefits';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 5;
                    fnUpdatePeriodTrans(strEmpCode, 'NONTAX', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curNonTaxable, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                    Coopparameters::none);
                end;

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
                     strTransDescription := 'Excess Pension';
                     TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 5;
                     fnUpdatePeriodTrans (strEmpCode, 'EXCP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0,
                      intMonth,intYear,'','',SelectedPeriod);

                     curTaxOnExcessPension := (curRateTaxExPension / 100) * curExcessPension;
                     curTransAmount := curTaxOnExcessPension;
                     strTransDescription := 'Tax on ExPension';
                     TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 6;
                     fnUpdatePeriodTrans (strEmpCode, 'TXEP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0,
                      intMonth,intYear,'','',SelectedPeriod);
                 END;
             END;
             */

            //Get the Taxable amount for calculation of PAYE
            //>prTaxablePay = (GrossTaxable - SalaryArrears) - (TheDefinedToPost + curSelfPensionContrb + MorgageRelief)


            //Add HOSP and MORTGAGE KIM{}
            if curPensionStaff > curMaxPensionContrib then
                curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curMaxPensionContrib + curOOI + curHOSP + curNonTaxable)
            else
                curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curPensionStaff + curOOI + curHOSP + curNonTaxable);
            curTaxablePay := ROUND(curTaxablePay, 1);
            curTransAmount := curTaxablePay;
            strTransDescription := 'Taxable Pay';
            TGroup := 'TAX CALCULATIONS';
            TGroupOrder := 6;
            TSubGroupOrder := 6;
            fnUpdatePeriodTrans(strEmpCode, 'TXBP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
             curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
             Coopparameters::none);

            //Get the Tax charged for the month
            curTaxCharged := fnGetEmployeePaye(curTaxablePay);
            curTaxCharged := ROUND(curTaxCharged, 1);
            curTransAmount := curTaxCharged;
            strTransDescription := 'Tax Charged';
            TGroup := 'TAX CALCULATIONS';
            TGroupOrder := 6;
            TSubGroupOrder := 7;
            fnUpdatePeriodTrans(strEmpCode, 'TXCHRG', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
            curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
            Coopparameters::none);


            //Get the Net PAYE amount to post for the month
            if (curReliefPersonal + curInsuranceReliefAmount) > curMaximumRelief then
                curPAYE := curTaxCharged - curMaximumRelief
            else
                curPAYE := curTaxCharged - (curReliefPersonal + curInsuranceReliefAmount);

            if not blnPaysPaye then curPAYE := 0; //Get statutory Exemption for the staff. If exempted from tax, set PAYE=0
            curTransAmount := curPAYE;
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
                prUnusedRelief.SetRange(prUnusedRelief."Employee Code", strEmpCode);
                prUnusedRelief.SetRange(prUnusedRelief."Period Month", intMonth);
                prUnusedRelief.SetRange(prUnusedRelief."Period Year", intYear);
                if prUnusedRelief.Find('-') then
                    prUnusedRelief.Delete;

                prUnusedRelief.Reset;
                with prUnusedRelief do begin
                    Init;
                    "Employee Code" := strEmpCode;
                    "Unused Relief" := curPAYE;
                    "Period Month" := intMonth;
                    "Period Year" := intYear;
                    Insert;
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
                curNHIF := fnGetEmployeeNHIF(curNhif_Base_Amount);
                curTransAmount := curNHIF;
                strTransDescription := 'N.H.I.F';
                TGroup := 'STATUTORIES';
                TGroupOrder := 7;
                TSubGroupOrder := 2;
                fnUpdatePeriodTrans(strEmpCode, 'NHIF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                 NHIFEMPyee, Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);
            end;

            prEmployeeTransactions.Reset;
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
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

                        if prTransactionCodes."Is Formula" then begin
                            strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                            curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount

                        end else begin
                            curTransAmount := prEmployeeTransactions.Amount;
                        end;

                        //**************************If "deduct Premium" is not ticked and the type is insurance- Dennis*****
                        if (prTransactionCodes."Special Transactions" = prTransactionCodes."special transactions"::"Life Insurance")
                          and (prTransactionCodes."Deduct Premium" = false) then begin
                            curTransAmount := 0;
                        end;

                        //**************************If "deduct Premium" is not ticked and the type is mortgage- Dennis*****
                        if (prTransactionCodes."Special Transactions" = prTransactionCodes."special transactions"::Morgage)
                         and (prTransactionCodes."Deduct Mortgage" = false) then begin
                            curTransAmount := 0;
                        end;
                        /*// OYALOM
                         IF strEmpCode='12096' THEN BEGIN
                         MESSAGE(FORMAT(prEmployeeTransactions."Transaction Code"));
                         MESSAGE(FORMAT( prTransactionCodes.Subledger));
                         MESSAGE(FORMAT(prTransactionCodes."GL Account"));
                         END;
                         \*/
                        //customer
                        //Get the posting Details
                        JournalPostingType := Journalpostingtype::" ";
                        JournalAcc := '';

                        if prTransactionCodes.Subledger <> prTransactionCodes.Subledger::" " then begin

                            if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Customer then begin
                                HrEmployee.Get(strEmpCode);
                                Customer.Reset;
                                Customer.SetRange(Customer."No.", HrEmployee."No.");
                                if Customer.Find('-') then begin
                                    JournalAcc := Customer."No.";
                                    JournalPostingType := Journalpostingtype::Member;
                                end;
                            end else begin
                                JournalAcc := prTransactionCodes."GL Account";
                                JournalPostingType := Journalpostingtype::"G/L Account";
                            end;



                            //End posting Details


                            //Loan Calculation is Amortized do Calculations here -Monthly Principal and Interest Keeps on Changing
                            if (prTransactionCodes."Special Transactions" = prTransactionCodes."special transactions"::StaffLoan) and
                               (prTransactionCodes."Repayment Method" = prTransactionCodes."repayment method"::Amortized) then begin
                                curTransAmount := 0;
                                curLoanInt := 0;
                                curLoanInt := fnCalcLoanInterest(strEmpCode, prEmployeeTransactions."Transaction Code",
                                prTransactionCodes."Interest Rate", prTransactionCodes."Repayment Method",
                                   prEmployeeTransactions."Original Amount", prEmployeeTransactions.Balance, SelectedPeriod, false);
                                //Post the Interest
                                if (curLoanInt <> 0) then begin
                                    curTransAmount := curLoanInt;
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
                                      Coopparameters::"loan Interest")
                                end;

                                //Get the Principal Amt
                                curTransAmount := prEmployeeTransactions."Amortized Loan Total Repay Amt" - curLoanInt;
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
                             prTransactionCodes."coop parameters");

                            //Check if transaction is loan. Get the Interest on the loan & post it at this point before moving next ****Loan Calculation
                            if (prTransactionCodes."Special Transactions" = prTransactionCodes."special transactions"::StaffLoan) and
                               (prTransactionCodes."Repayment Method" <> prTransactionCodes."repayment method"::Amortized) then begin

                                curLoanInt := fnCalcLoanInterest(strEmpCode, prEmployeeTransactions."Transaction Code",
                               prTransactionCodes."Interest Rate",
                                prTransactionCodes."Repayment Method", prEmployeeTransactions."Original Amount",
                                prEmployeeTransactions.Balance, SelectedPeriod, prTransactionCodes.Welfare);
                                if curLoanInt > 0 then begin
                                    curTransAmount := curLoanInt;
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
                                      Coopparameters::"loan Interest")
                                end;
                            end;
                            //End Loan transaction calculation
                            //Fringe Benefits and Low interest Benefits

                            if prTransactionCodes."Fringe Benefit" = true then begin
                                if curLoanCorpRate < curLoanMarketRate then begin
                                    // fnCalcFringeBenefit := (((curLoanMarketRate - prTransactionCodes."Interest Rate") * curLoanCorpRate) / 1200)
                                    fnCalcFringeBenefit := (((curLoanMarketRate - curLoanCorpRate)) / 1200)
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



                            //Create Employer Deduction
                            if (prTransactionCodes."Employer Deduction") or (prTransactionCodes."Include Employer Deduction") then begin
                                if prTransactionCodes."Is Formula for employer" <> '' then begin
                                    strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Is Formula for employer");
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

                        end;// OYALO M2;
                    end;

                until prEmployeeTransactions.Next = 0;
                //GET TOTAL DEDUCTIONS
                curTotalDeductions := curTotalDeductions + TotDedArrears;
                curTransBalance := 0;
                curTransBalance := curTransBalance + TotDedArrears;
                strTransCode := 'TOT-DED';
                strTransDescription := 'TOTAL DEDUCTION';
                TGroup := 'DEDUCTIONS';
                TGroupOrder := 8;
                TSubGroupOrder := 9;
                fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                  strTransDescription, curTotalDeductions, curTransBalance, intMonth, intYear,
                  prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                  '', Journalpostas::" ", Journalpostingtype::" ", '', Coopparameters::none);

                //END GET TOTAL DEDUCTIONS
            end;

            //fosa account
            HREmployes.Reset;
            HREmployes.SetRange(HREmployes."No.", strEmpCode);
            if HREmployes.Find('-') then begin
                JournalAcc := HREmployes."Bank Account Number";



                //Net Pay: calculate the Net pay for the month in the following manner:
                //>Nett = Gross - (xNssfAmount + curMyNhifAmt + PAYE + PayeArrears + prTotDeductions)
                //...Tot Deductions also include (SumLoan + SumInterest)
                curNetPay := (curGrossPay) - (curNSSF + curNHIF + curPAYE + curPayeArrears + curTotalDeductions + IsCashBenefit - TotDedArrears);

                //>Nett = Nett - curExcessPension
                //...Excess pension is only used for tax. Staff is not paid the amount hence substract it
                curNetPay := curNetPay; //- curExcessPension

                //>Nett = Nett - cSumEmployerDeductions
                //...Employer Deductions are used for reporting as cost to company BUT dont affect Net pay
                curNetPay := curNetPay - curTotCompanyDed; //******Get Company Deduction*****

                curNetRnd_Effect := curNetPay - ROUND(curNetPay, 1);
                curNetPay := ROUND(curNetPay, 1);
                curTransAmount := curNetPay;
                strTransDescription := 'Net Pay';
                TGroup := 'NET PAY';
                TGroupOrder := 9;
                TSubGroupOrder := 0;
                fnUpdatePeriodTrans(strEmpCode, 'NPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                JournalAcc, Journalpostas::Credit, Journalpostingtype::Vendor, '', Coopparameters::none);
                //PayablesAcc,JournalPostAs::Credit,JournalPostingType::"G/L Account",'',CoopParameters::none);

                //Rounding Effect: if the Net pay is rounded, take the rounding effect &
                //save it as an earning for the staff for the next month
                //>Insert the Netpay rounding effect into the tblRoundingEffect table


                //Negative pay: if the NetPay<0 then log the entry
                //>Display an on screen report
                //>Through a pop-up to the user
                //>Send an email to the user or manager
            end;
        end;

    end;


    procedure fnBasicPayProrated(strEmpCode: Code[20]; Month: Integer; Year: Integer; BasicSalary: Decimal; DaysWorked: Integer; DaysInMonth: Integer) ProratedAmt: Decimal
    begin
        ProratedAmt := ROUND((DaysWorked / DaysInMonth) * BasicSalary);
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
        SysDate.SetFilter(SysDate."Period No.", '1..5');
        if SysDate.Find('-') then
            DaysInMonth := SysDate.Count;
    end;


    procedure fnUpdatePeriodTrans(EmpCode: Code[20]; TCode: Code[20]; TGroup: Code[20]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date; Department: Code[20]; JournalAC: Code[20]; PostAs: Option " ",Debit,Credit; JournalACType: Option " ","G/L Account",Customer,Vendor; LoanNo: Code[60]; CoopParam: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","Development Loan","SACCO Deposit",Insurance,"School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF,"Admin fee")
    var
        prPeriodTransactions: Record "prPeriod Transactions";
    begin

        if curAmount = 0 then exit;
        with prPeriodTransactions do begin
            Init;
            "Employee Code" := EmpCode;
            "Transaction Code" := TCode;
            "Group Text" := TGroup;
            "Transaction Name" := Description;
            Amount := curAmount;
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
            Insert;
            //Update the prEmployee Transactions  with the Amount
            fnUpdateEmployeeTrans("Employee Code", "Transaction Code", Amount, "Period Month", "Period Year", "Payroll Period");
        end;
    end;


    procedure fnGetSpecialTransAmount(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage; blnCompDedc: Boolean) SpecialTransAmount: Decimal
    var
        prEmployeeTransactions: Record "prEmployee Transactions";
        prTransactionCodes: Record "prTransaction Codes";
        strExtractedFrml: Text[250];
    begin

        SpecialTransAmount := 0;
        prTransactionCodes.Reset;
        prTransactionCodes.SetRange(prTransactionCodes."Special Transactions", intSpecTransID);
        if prTransactionCodes.Find('-') then begin
            repeat
                prEmployeeTransactions.Reset;
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                if prEmployeeTransactions.Find('-') then begin

                    //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
                    //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
                    case intSpecTransID of
                        Intspectransid::"Defined Contribution":
                            if prTransactionCodes."Is Formula" then begin
                                strExtractedFrml := '';
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
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
    end;


    procedure fnGetEmployeePaye(curTaxablePay: Decimal) PAYE: Decimal
    var
        prPAYE: Record "PR PAYE";
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
        prNHIF: Record "PR NHIF";
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
        prEmployeeTransactions: Record "prEmployee Transactions";
        prPeriodTransactions: Record "prPeriod Transactions";
    begin

        prEmployeeTransactions.Reset;
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", strTransCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
        if prEmployeeTransactions.FindFirst then
            TransAmount := prEmployeeTransactions.Amount;

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


    procedure fnClosePayrollPeriod(dtOpenPeriod: Date) Closed: Boolean
    var
        dtNewPeriod: Date;
        intNewMonth: Integer;
        intNewYear: Integer;
        prEmployeeTransactions: Record "prEmployee Transactions";
        prPeriodTransactions: Record "prPeriod Transactions";
        intMonth: Integer;
        intYear: Integer;
        prTransactionCodes: Record "Payroll Transaction Code.";
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        prEmployeeTrans: Record "prEmployee Transactions";
        prPayrollPeriods: Record "prPayroll Periods";
        prNewPayrollPeriods: Record "prPayroll Periods";
        CreateTrans: Boolean;
    begin

        dtNewPeriod := CalcDate('1M', dtOpenPeriod);
        intNewMonth := Date2dmy(dtNewPeriod, 2);
        intNewYear := Date2dmy(dtNewPeriod, 3);

        intMonth := Date2dmy(dtOpenPeriod, 2);
        intYear := Date2dmy(dtOpenPeriod, 3);

        prEmployeeTransactions.Reset;
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
        //prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Employee Code",'KPSS091');


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
                            "Employee Code" := prEmployeeTransactions."Employee Code";
                            "Transaction Code" := prEmployeeTransactions."Transaction Code";
                            "Transaction Name" := prEmployeeTransactions."Transaction Name";
                            Amount := curTransAmount;
                            Balance := curTransBalance;
                            "Amortized Loan Total Repay Amt" := prEmployeeTransactions."Amortized Loan Total Repay Amt";
                            "Original Amount" := prEmployeeTransactions."Original Amount";
                            Membership := prEmployeeTransactions.Membership;
                            "Reference No" := prEmployeeTransactions."Reference No";
                            "Loan Number" := prEmployeeTransactions."Loan Number";
                            "Period Month" := intNewMonth;
                            "Period Year" := intNewYear;
                            "Payroll Period" := dtNewPeriod;
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
            "Period Name" := Format(dtNewPeriod, 0, '<Month Text>') + ' ' + Format(intNewYear);
            "Date Opened" := dtNewPeriod;
            Closed := false;
            Insert;
        end;

        //Effect the transactions for the P9
        fnP9PeriodClosure(intMonth, intYear, dtOpenPeriod);

        //Take all the Negative pay (Net) for the current month & treat it as a deduction in the new period
        fnGetNegativePay(intMonth, intYear, dtOpenPeriod);
    end;


    procedure fnGetNegativePay(intMonth: Integer; intYear: Integer; dtOpenPeriod: Date)
    var
        prPeriodTransactions: Record "prPeriod Transactions";
        prEmployeeTransactions: Record "prEmployee Transactions";
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
                    "Employee Code" := prPeriodTransactions."Employee Code";
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


    procedure fnP9PeriodClosure(intMonth: Integer; intYear: Integer; dtCurPeriod: Date)
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
        prPeriodTransactions: Record "prPeriod Transactions";
        prEmployee: Record "HR Employees";
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
                prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", prEmployee."No.");
                prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
                prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
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
                        P9NHIF, P9Deductions, P9NetPay, dtCurPeriod);

            until prEmployee.Next = 0;
        end;
    end;


    procedure fnUpdateP9Table(P9EmployeeCode: Code[20]; P9BasicPay: Decimal; P9Allowances: Decimal; P9Benefits: Decimal; P9ValueOfQuarters: Decimal; P9DefinedContribution: Decimal; P9OwnerOccupierInterest: Decimal; P9GrossPay: Decimal; P9TaxablePay: Decimal; P9TaxCharged: Decimal; P9InsuranceRelief: Decimal; P9TaxRelief: Decimal; P9Paye: Decimal; P9NSSF: Decimal; P9NHIF: Decimal; P9Deductions: Decimal; P9NetPay: Decimal; dtCurrPeriod: Date)
    var
        prEmployeeP9Info: Record "prEmployee P9 Info";
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
        SysDate.SetFilter(SysDate."Period No.", '1..5');
        if SysDate.Find('-') then
            DaysWorked := SysDate.Count;
    end;


    procedure fnSalaryArrears(EmpCode: Text[30]; TransCode: Text[30]; CBasic: Decimal; StartDate: Date; EndDate: Date; dtOpenPeriod: Date; dtDOE: Date; dtTermination: Date)
    var
        FirstMonth: Boolean;
        startmonth: Integer;
        startYear: Integer;
        "prEmployee P9 Info": Record "prEmployee P9 Info";
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
        "prSalary Arrears": Record "prSalary Arrears";
    begin

        "prSalary Arrears".Reset;
        "prSalary Arrears".SetRange("prSalary Arrears"."Employee Code", EmployeeCode);
        "prSalary Arrears".SetRange("prSalary Arrears"."Transaction Code", TransCode);
        "prSalary Arrears".SetRange("prSalary Arrears"."Period Month", intMonth);
        "prSalary Arrears".SetRange("prSalary Arrears"."Period Year", intYear);
        if "prSalary Arrears".Find('-') = false then begin
            "prSalary Arrears"."Employee Code" := EmployeeCode;
            "prSalary Arrears"."Transaction Code" := TransCode;
            "prSalary Arrears"."Start Date" := OrigStartDate;
            "prSalary Arrears"."End Date" := EndDate;
            "prSalary Arrears"."Salary Arrears" := SalaryArrears;
            "prSalary Arrears"."PAYE Arrears" := PayeArrears;
            "prSalary Arrears"."Period Month" := intMonth;
            "prSalary Arrears"."Period Year" := intYear;
            "prSalary Arrears"."Payroll Period" := payperiod;
            "prSalary Arrears".Modify;
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
        LnInterest := ROUND(curLoanInt, 1);
    end;


    procedure fnUpdateEmployerDeductions(EmpCode: Code[20]; TCode: Code[20]; TGroup: Code[20]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date)
    var
        prEmployerDeductions: Record "prEmployer Deductions.";
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
        prEmployeeTrans: Record "prEmployee Transactions";
    begin

        prEmployeeTrans.Reset;
        prEmployeeTrans.SetRange(prEmployeeTrans."Employee Code", EmpCode);
        prEmployeeTrans.SetRange(prEmployeeTrans."Transaction Code", TransCode);
        prEmployeeTrans.SetRange(prEmployeeTrans."Payroll Period", PayrollPeriod);
        prEmployeeTrans.SetRange(prEmployeeTrans."Period Month", Month);
        prEmployeeTrans.SetRange(prEmployeeTrans."Period Year", Year);
        if prEmployeeTrans.Find('-') then begin
            prEmployeeTrans.Amount := Amount;
            prEmployeeTrans.Modify;
        end;
    end;


    procedure fnGetJournalDet(strEmpCode: Code[20])
    var
        //    SalaryCard: Record UnknownRecord51516265;
        HrEmp: Record "HR Employees";
    begin

        //Get Payroll Posting Accounts
        //IF SalaryCard.GET(strEmpCode) THEN BEGIN
        if HrEmp.Get(strEmpCode) then begin
            if PostingGroup.Get(HrEmp."Posting Group") then begin
                //Comment This for the Time Being
                /*
                PostingGroup.TESTFIELD("Salary Account");
                PostingGroup.TESTFIELD("Income Tax Account");
                PostingGroup.TESTFIELD("Net Salary Payable");
                PostingGroup.TESTFIELD("SSF Employer Account");
                PostingGroup.TESTFIELD("Pension Employer Acc");
                */
                TaxAccount := PostingGroup."Income Tax Account";
                salariesAcc := PostingGroup."Salary Account";
                PayablesAcc := PostingGroup."Net Salary Payable";
                NSSFEMPyer := PostingGroup."NSSF Employer Account";
                NSSFEMPyee := PostingGroup."NSSF Employee Account";
                NHIFEMPyee := PostingGroup."NHIF Employee Account";
                PensionEMPyer := PostingGroup."Pension Employer Acc";
            end;
        end;
        //End Get Payroll Posting Accounts

    end;
}

