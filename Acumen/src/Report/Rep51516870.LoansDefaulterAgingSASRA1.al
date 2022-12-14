#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516870_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516870 "Loans Defaulter Aging - SASRA1"
{
    RDLCLayout = './Layouts/LoansDefaulterAging-SASRA1.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") where(Posted = const(true), "Outstanding Balance" = filter(> 0));
            RequestFilterFields = Source, "Loan Product Type", "Outstanding Balance", "Date filter";
            column(ReportForNavId_4645; 4645) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(CurrReport_PAGENO; Format(ReportForNav.PageNo))
            {
            }
            column(UserId; UserId)
            {
            }
            column(Loans__Loan__No__; "Loans Register"."Loan  No.")
            {
            }
            column(Arrears; Arrears)
            {
            }
            column(Loans__Loan_Product_Type_; "Loans Register"."Loan Product Type")
            {
            }
            column(Loans_Loans__Staff_No_; "Loans Register"."Staff No")
            {
            }
            column(Loans__Client_Name_; "Loans Register"."Client Name")
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Client Code")
            {
            }
            column(Loans_Loans__Outstanding_Balance_; "Loans Register"."Outstanding Balance")
            {
            }
            column(V2Month_; "2Month")
            {
            }
            column(V3Month_; "3Month")
            {
            }
            column(Over3Month; Over3Month)
            {
            }
            column(V1Month_; "1Month")
            {
            }
            column(V0Month_; "0Month")
            {
            }
            column(AmountinArrears_LoansRegister; "Loans Register"."Amount in Arrears")
            {
            }
            column(NoofMonthsinArrears_LoansRegister; "Loans Register"."No of Months in Arrears")
            {
            }
            column(Loans_Loans__Outstanding_Balance__Control1000000016; "Loans Register"."Outstanding Balance")
            {
            }
            column(InterestDue_LoansRegister; "Loans Register"."Interest Due")
            {
            }
            column(Loans__Approved_Amount_; "Loans Register"."Approved Amount")
            {
            }
            column(Loans_Loans__Interest_Due_; "Loans Register"."Interest Due")
            {
            }
            column(TotalBalance; "Loans Register"."Outstanding Balance" + "Loans Register"."Interest Due")
            {
            }
            column(V1MonthC_; "1MonthC")
            {
            }
            column(V2MonthC_; "2MonthC")
            {
            }
            column(V3MonthC_; "3MonthC")
            {
            }
            column(Over3MonthC; Over3MonthC)
            {
            }
            column(NoLoans; NoLoans)
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(V0Month__Control1102760031; "0Month")
            {
            }
            column(V1Month__Control1102760032; "1Month")
            {
            }
            column(V2Month__Control1102760033; "2Month")
            {
            }
            column(V3Month__Control1102760034; "3Month")
            {
            }
            column(Over3Month_Control1102760035; Over3Month)
            {
            }
            column(V0MonthC_; "0MonthC")
            {
            }
            column(Loans_Aging_Analysis__SASRA_Caption; Loans_Aging_Analysis__SASRA_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loans__Loan__No__Caption; FieldCaption("Loan  No."))
            {
            }
            column(Loan_TypeCaption; Loan_TypeCaptionLbl)
            {
            }
            column(Staff_No_Caption; Staff_No_CaptionLbl)
            {
            }
            column(Loans__Client_Name_Caption; FieldCaption("Client Name"))
            {
            }
            column(Oustanding_BalanceCaption; Oustanding_BalanceCaptionLbl)
            {
            }
            column(PerformingCaption; PerformingCaptionLbl)
            {
            }
            column(V1___30_Days_Caption; V1___30_Days_CaptionLbl)
            {
            }
            column(V0_Days_Caption; V0_Days_CaptionLbl)
            {
            }
            column(WatchCaption; WatchCaptionLbl)
            {
            }
            column(V31___180_Days_Caption; V31___180_Days_CaptionLbl)
            {
            }
            column(SubstandardCaption; SubstandardCaptionLbl)
            {
            }
            column(V181___360_Days_Caption; V181___360_Days_CaptionLbl)
            {
            }
            column(DoubtfulCaption; DoubtfulCaptionLbl)
            {
            }
            column(Over_360_DaysCaption; Over_360_DaysCaptionLbl)
            {
            }
            column(LossCaption; LossCaptionLbl)
            {
            }
            column(TotalsCaption; TotalsCaptionLbl)
            {
            }
            column(CountCaption; CountCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(Arrears1; "No.ofMonthsinArrears")
            {
            }
            trigger OnPreDataItem();
            begin

                //CREATETOTALS("0Day","1Day","2Day","3Day",Over3Day);
                GrandTotal := 0;
                Company.Get();
                Company.CalcFields(Company.Picture);
                /*Loans.RESET;
				Loans.SETCURRENTKEY(Loans.Source,Loans."Client Code");
				Loans.SETRANGE(Loans."Loan  No.","Loan  No.");
				IF Loans.FIND('-') THEN
				*/

            end;

            trigger OnAfterGetRecord();
            begin
                RepaymentPeriod := AsAt;
                Loans.Reset;
                Loans.SetCurrentkey(Loans.Source, Loans."Client Code");
                Loans.SetRange(Loans."Loan  No.", "Loan  No.");
                if Loans.Find('-') then begin
                    //Get Last Day of the previous month
                    if Loans."Repayment Frequency" = Loans."repayment frequency"::Monthly then begin
                        if RepaymentPeriod = CalcDate('CM', RepaymentPeriod) then begin
                            LastMonth := RepaymentPeriod;
                        end else begin
                            LastMonth := CalcDate('-1M', RepaymentPeriod);
                        end;
                        LastMonth := CalcDate('CM', LastMonth);
                    end;
                    //End Get Last Day of the previous month
                    //----------Generate Repayment Schedule----------------------
                    SFactory.FnGenerateRepaymentSchedule("Loan  No.");
                    //Get Scheduled Balance
                    LSchedule.Reset;
                    LSchedule.SetRange(LSchedule."Loan No.", "Loan  No.");
                    LSchedule.SetRange(LSchedule."Repayment Date", LastMonth);
                    if LSchedule.FindFirst then begin
                        ScheduledLoanBal := LSchedule."Loan Amount";
                    end;
                    //End Get Scheduled Balance
                    //MESSAGE('ScheduledLoanBal IS %1',ScheduledLoanBal);
                    //Get Loan Bal as per the date filter
                    DateFilter := '..' + Format(LastMonth);
                    Loans.Reset;
                    Loans.SetRange(Loans."Loan  No.", "Loan  No.");
                    Loans.SetFilter(Loans."Date filter", DateFilter);
                    if Loans.Find('-') then begin
                        Loans.CalcFields(Loans."Outstanding Balance");
                        LBal := Loans."Outstanding Balance";
                    end;
                    //End Get Loan Bal as per the date filter
                    //MESSAGE('LBal IS %1',LBal);
                    //Amount in Arrears
                    // Arrears:=(LBal-ScheduledLoanBal);
                    // MESSAGE(FORMAT(Arrears));
                    Arrears := (ScheduledLoanBal - LBal);
                    if (Arrears > 0) or (Arrears = 0) then begin
                        Arrears := 0
                    end else
                        Arrears := Arrears;
                    "Amount in Arrears" := Arrears;
                    Modify;
                    //End Amount in Arrears
                    if Arrears <> 0 then begin
                        if Loans.Repayment <> 0 then begin
                            // IF Loans."Loan Principle Repayment" >0 THEN
                            // "No.ofMonthsinArrears":=ROUND(Arrears/Loans.Repayment,1,'>')*-1;
                            "No.ofMonthsinArrears" := ROUND((Arrears / Loans."Loan Principle Repayment"), 1, '>') * -1;
                            /* IF (Arrears<0)  THEN BEGIN
                              "No.ofMonthsinArrears":=0;
                               END;*/
                            //MESSAGE(FORMAT("No.ofMonthsinArrears"));
                            //  "Loans Register".MODIFY;
                            Modify;
                        end;
                    end;
                    //"Loans Register"."No of Months in Arrears":=0;
                    //MESSAGE(FORMAT("No of Months in Arrears"));
                    if (Arrears = 0) then begin
                        // "No.ofMonthsinArrears":=0;
                        Loans."Loans Category" := Loans."loans category"::Perfoming
                    end else
                        if ("No.ofMonthsinArrears" = 1) then begin
                            Loans."Loans Category" := Loans."loans category"::Watch
                        end else
                            if ("No.ofMonthsinArrears" > 1) and ("No.ofMonthsinArrears" <= 6) then begin
                                Loans."Loans Category" := Loans."loans category"::Substandard
                            end else
                                if ("No.ofMonthsinArrears" > 6) and ("No.ofMonthsinArrears" <= 12) then begin
                                    Loans."Loans Category" := Loans."loans category"::Doubtful
                                end else
                                    if ("No.ofMonthsinArrears" > 12) then begin
                                        Loans."Loans Category" := Loans."loans category"::Loss
                                    end;
                    // "No of Months in Arrears":="No.ofMonthsinArrears";
                    "No of Months in Arrears" := "No.ofMonthsinArrears";
                    //  "Loans Register"."Loan Insurance Paid":="No.ofMonthsinArrears";
                    "Loans Register".Modify;
                    Modify;
                    if ("No.ofMonthsinArrears" = 0) then begin
                        "0Month" := "Loans Register"."Outstanding Balance";
                        "0MonthC" := "0MonthC" + 1;
                    end else
                        if ("No.ofMonthsinArrears" = 1) then begin
                            "1Month" := "Loans Register"."Outstanding Balance";
                            "1MonthC" := "1MonthC" + 1;
                        end else
                            if ("No.ofMonthsinArrears" > 1) and ("No.ofMonthsinArrears" <= 6) then begin
                                "2Month" := "Loans Register"."Outstanding Balance";
                                "2MonthC" := "2MonthC" + 1;
                            end else
                                if ("No.ofMonthsinArrears" > 6) and ("No.ofMonthsinArrears" <= 12) then begin
                                    "3Month" := "Loans Register"."Outstanding Balance";
                                    "3MonthC" := "3MonthC" + 1;
                                end else
                                    if ("No.ofMonthsinArrears" > 12) then begin
                                        Over3Month := "Loans Register"."Outstanding Balance";
                                        Over3MonthC := Over3MonthC + 1;
                                    end;
                    GrandTotal := GrandTotal + "Loans Register"."Outstanding Balance";
                    if ("1Month" + "2Month" + "3Month" + Over3Month) > 0 then
                        NoLoans := NoLoans + 1;
                end;

            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                field("As At"; AsAt)
                {
                    ApplicationArea = Basic;
                }
                field(ForNavOpenDesigner; ReportForNavOpenDesigner)
                {
                    ApplicationArea = Basic;
                    Caption = 'Design';
                    Visible = ReportForNavAllowDesign;
                    trigger OnValidate()
                    begin
                        ReportForNav.LaunchDesigner(ReportForNavOpenDesigner);
                        CurrReport.RequestOptionsPage.Close();
                    end;

                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            ReportForNavOpenDesigner := false;
        end;
    }

    trigger OnInitReport()
    begin
        ;
        ReportsForNavInit;

    end;

    trigger OnPostReport()
    begin
        ;
        ReportForNav.Post;
    end;

    trigger OnPreReport()
    begin
        ;
        ReportsForNavPre;
    end;

    var
        "1Month": Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        AsAt: Date;
        LastDueDate: Date;
        DFormula: DateFormula;
        "0MonthC": Integer;
        "1MonthC": Integer;
        "2MonthC": Integer;
        "3MonthC": Integer;
        Over3MonthC: Integer;
        NoLoans: Integer;
        PhoneNo: Text[30];
        Cust: Record Customer;
        "StaffNo.": Text[30];
        Deposits: Decimal;
        GrandTotal: Decimal;
        "0Month": Decimal;
        LoanProduct: Record "Loan Products Setup";
        FirstMonthDate: Date;
        EndMonthDate: Date;
        Loans_Aging_Analysis__SASRA_CaptionLbl: label 'Loans Aging Analysis (SASRA)';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Staff_No_CaptionLbl: label 'Staff No.';
        Oustanding_BalanceCaptionLbl: label 'Oustanding Balance';
        PerformingCaptionLbl: label 'Performing';
        V1___30_Days_CaptionLbl: label '(1 - 30 Days)';
        V0_Days_CaptionLbl: label '(0 Days)';
        WatchCaptionLbl: label 'Watch';
        V31___180_Days_CaptionLbl: label '(31 - 180 Days)';
        SubstandardCaptionLbl: label 'Substandard';
        V181___360_Days_CaptionLbl: label '(181 - 360 Days)';
        DoubtfulCaptionLbl: label 'Doubtful';
        Over_360_DaysCaptionLbl: label 'Over 360 Days';
        LossCaptionLbl: label 'Loss';
        TotalsCaptionLbl: label 'Totals';
        CountCaptionLbl: label 'Count';
        Grand_TotalCaptionLbl: label 'Grand Total';
        "0Day": Decimal;
        "1Day": Decimal;
        "2Day": Decimal;
        "3Day": Decimal;
        Over3Day: Decimal;
        LSchedule: Record "Loan Repayment Schedule";
        RepaymentPeriod: Date;
        Loans: Record "Loans Register";
        LastMonth: Date;
        ScheduledLoanBal: Decimal;
        DateFilter: Text;
        LBal: Decimal;
        Arrears: Decimal;
        "No.ofMonthsinArrears": Integer;
        Company: Record "Company Information";
        SFactory: Codeunit "SURESTEP Factory.";

    local procedure GenerateSchedule()
    begin
        /*Loans.RESET;
		Loans.SETRANGE(Loans."Loan  No.",LoanNumber);
		Loans.SETFILTER(Loans."Approved Amount",'>%1',0);
		//LoansRec.SETFILTER(LoansRec.Posted,'=%1',TRUE);
		IF Loans.FIND('-') THEN BEGIN
		  IF ((Loans."Issued Date"<>0D) AND (Loans."Repayment Start Date"<>0D)) THEN BEGIN
		Loans.TESTFIELD(LoansRec."Loan Disbursement Date");
		Loans.TESTFIELD(LoansRec."Repayment Start Date");
		LSchedule.RESET;
		LSchedule.SETRANGE(RSchedule."Loan No.",LoansRec."Loan  No.");
		LSchedule.DELETEALL;
		//LoanAmount:=LoansRec."Approved Amount";
		LoanAmount:=Loans."Approved Amount";
		InterestRate:=Loans.Interest;
		RepayPeriod:=Loans.Installments;
		InitialInstal:=Loans.Installments+LoansRec."Grace Period - Principle (M)";
		//LBalance:=LoansRec."Approved Amount";
		LBalance:=Loans."Approved Amount";
		RunDate:=Loans."Repayment Start Date";
		InstalNo:=0;
		//Repayment Frequency
		IF Loans."Repayment Frequency"=Loans."Repayment Frequency"::Daily THEN
		RunDate:=CALCDATE('-1D',RunDate)
		ELSE IF Loans."Repayment Frequency"=Loans."Repayment Frequency"::Weekly THEN
		RunDate:=CALCDATE('-1W',RunDate)
		ELSE IF Loans."Repayment Frequency"=Loans."Repayment Frequency"::Monthly THEN
		RunDate:=CALCDATE('-1M',RunDate)
		ELSE IF Loans."Repayment Frequency"=Loans."Repayment Frequency"::Quaterly THEN
		RunDate:=CALCDATE('-1Q',RunDate);
		//Repayment Frequency
		REPEAT
		InstalNo:=InstalNo+1;
		//Repayment Frequency
		IF Loans."Repayment Frequency"=Loans."Repayment Frequency"::Daily THEN
		RunDate:=CALCDATE('1D',RunDate)
		ELSE IF Loans."Repayment Frequency"=Loans."Repayment Frequency"::Weekly THEN
		RunDate:=CALCDATE('1W',RunDate)
		ELSE IF Loans."Repayment Frequency"=Loans."Repayment Frequency"::Monthly THEN
		RunDate:=CALCDATE('1M',RunDate)
		ELSE IF Loans."Repayment Frequency"=Loans."Repayment Frequency"::Quaterly THEN
		RunDate:=CALCDATE('1Q',RunDate);
		IF LoansRec."Repayment Method"=LoansRec."Repayment Method"::Amortised THEN BEGIN
		LoansRec.TESTFIELD(LoansRec.Installments);
		TotalMRepay:=ROUND((InterestRate/12/100) / (1 - POWER((1 +(InterestRate/12/100)),- (RepayPeriod))) * (LoanAmount),0.0001,'>');
		LInterest:=ROUND(LBalance / 100 / 12 * InterestRate,0.0001,'>');
		LPrincipal:=TotalMRepay-LInterest;
		END;
		IF LoansRec."Repayment Method"=LoansRec."Repayment Method"::"Straight Line" THEN BEGIN
		LoansRec.TESTFIELD(LoansRec.Interest);
		LoansRec.TESTFIELD(LoansRec.Installments);
		LPrincipal:=LoanAmount/RepayPeriod;
		LInterest:=(InterestRate/12/100)*LoanAmount/RepayPeriod;
		END;
		IF LoansRec."Repayment Method"=LoansRec."Repayment Method"::"Reducing Balance" THEN BEGIN
		LoansRec.TESTFIELD(LoansRec.Interest);
		LoansRec.TESTFIELD(LoansRec.Installments);
		LPrincipal:=LoanAmount/RepayPeriod;
		LInterest:=(InterestRate/12/100)*LBalance;
		END;
		IF LoansRec."Repayment Method"=LoansRec."Repayment Method"::Constants THEN BEGIN
		LoansRec.TESTFIELD(LoansRec.Repayment);
		IF LBalance < LoansRec.Repayment THEN
		LPrincipal:=LBalance
		ELSE
		LPrincipal:=LoansRec.Repayment;
		LInterest:=LoansRec.Interest;
		END;
		//Grace Period
		IF GrPrinciple > 0 THEN BEGIN
		LPrincipal:=0
		END ELSE BEGIN
		LBalance:=LBalance-LPrincipal;
		END;
		IF GrInterest > 0 THEN
		LInterest:=0;
		GrPrinciple:=GrPrinciple-1;
		GrInterest:=GrInterest-1;
		EVALUATE(RepayCode,FORMAT(InstalNo));
		RSchedule.INIT;
		RSchedule."Repayment Code":=RepayCode;
		RSchedule."Interest Rate":=InterestRate;
		RSchedule."Loan No.":=LoansRec."Loan  No.";
		RSchedule."Loan Amount":=LoanAmount;
		RSchedule."Instalment No":=InstalNo;
		RSchedule."Repayment Date":=CALCDATE('CM',RunDate);
		RSchedule."Member No.":=LoansRec."Client Code";
		RSchedule."Loan Category":=LoansRec."Loan Product Type";
		RSchedule."Monthly Repayment":=LInterest + LPrincipal;
		RSchedule."Monthly Interest":=LInterest;
		RSchedule."Principal Repayment":=LPrincipal;
		RSchedule."Loan Balance":=LBalance;
		RSchedule.INSERT;
		WhichDay:=DATE2DWY(RSchedule."Repayment Date",1);
		UNTIL LBalance < 1
		END;
		END;
		COMMIT;*/

    end;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516870_v6_3_0_2259;
        ReportForNavOpenDesigner: Boolean;
        [InDataSet]
        ReportForNavAllowDesign: Boolean;

    local procedure ReportsForNavInit();
    var
        ApplicationSystemConstants: Codeunit "Application System Constants";
        addInFileName: Text;
        tempAddInFileName: Text;
        path: DotNet Path;
        ReportForNavObject: Variant;
    begin
        addInFileName := ApplicationPath() + 'Add-ins\ReportsForNAV_6_3_0_2259\ForNav.Reports.6.3.0.2259.dll';
        if not File.Exists(addInFileName) then begin
            tempAddInFileName := path.GetTempPath() + '\Microsoft Dynamics NAV\Add-Ins\' + ApplicationSystemConstants.PlatformFileVersion() + '\ForNav.Reports.6.3.0.2259.dll';
            if not File.Exists(tempAddInFileName) then
                Error('Please install the ForNAV DLL version 6.3.0.2259 in your service tier Add-ins folder under the file name "%1"\\If you already have the ForNAV DLL on the server, you should move it to this folder and rename it to match this file name.', addInFileName);
        end;
        ReportForNavObject := ReportForNav.GetLatest(CurrReport.OBJECTID, CurrReport.Language, SerialNumber, UserId, CompanyName);
        ReportForNav := ReportForNavObject;
        ReportForNav.Init();
    end;

    local procedure ReportsForNavPre();
    begin
        ReportForNav.OpenDesigner := ReportForNavOpenDesigner;
        if not ReportForNav.Pre() then CurrReport.Quit();
    end;

    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
