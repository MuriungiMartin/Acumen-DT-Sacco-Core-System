#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516439_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516439 "Loans Defaulter Aging-SASRAS."
{
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/LoansDefaulterAging-SASRAS..rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where("Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Client Code", "Loan Product Type", "Outstanding Balance", "Date filter", "Employer Code", "Loan  No.";
            column(ReportForNavId_4645; 4645) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; Format(ReportForNav.PageNo))
            {
            }
            column(UserId; UserId)
            {
            }
            column(PrincipleArrears_loans; LoanS."Amount in Arrears")
            {
            }
            column(Loans__Loan__No__; "Loans Register"."Loan  No.")
            {
            }
            column(Loans__Loan_Product_Type_; "Loans Register"."Loan Product Type")
            {
            }
            column(Loans_Loans__Staff_No_; LoanS."Staff No")
            {
            }
            column(Loans__Client_Name_; "Loans Register"."Client Name")
            {
            }
            column(ClientCode_loans; LoanS."Client Code")
            {
            }
            column(Loans_Loans__Outstanding_Balance_; LoanS."Outstanding Balance")
            {
            }
            column(OustandingInterest_loans; LoanS."Oustanding Interest")
            {
            }
            column(V2Month_; "2Month")
            {
            }
            column(LoansCategorySASRA_loans; LoanS."Loans Category-SASRA")
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
            column(Loans_Loans__Outstanding_Balance__Control1000000016; LoanS."Outstanding Balance")
            {
            }
            column(Loans__Approved_Amount_; "Loans Register"."Approved Amount")
            {
            }
            column(Loans_Loans__Interest_Due_; LoanS."Interest Due")
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
            column(Arrears_Amount; DifinOutBal)
            {
            }
            column(ClientCodecj; "Loans Register"."Client Code")
            {
            }
            column(ClientNamecj; "Loans Register"."Client Name")
            {
            }
            trigger OnPreDataItem();
            begin

                GrandTotal := 0;
                if AsAt = 0D then
                    AsAt := Today;
                DifinOutBal := 0;
            end;

            trigger OnAfterGetRecord();
            begin
                LoanS.SetFilter(LoanS."Date filter", '..' + Format(AsAt));
                //EVALUATE(DFormula,'1Q');
                Cust.Reset;
                if LoanS.Source = LoanS.Source::FOSA then
                    Cust.SetRange(Cust."No.", LoanS."BOSA No")
                else
                    Cust.SetRange(Cust."No.", LoanS."Client Code");
                if Cust.Find('-') then begin
                    // PhoneNo := Cust."FDR Deposit Status Type";
                    //"StaffNo." := Cust."Personal No";
                    //Deposits := Cust."Current Shares";
                end;
                "0Month" := 0;
                "1Month" := 0;
                "2Month" := 0;
                "3Month" := 0;
                Over3Month := 0;
                DaysinArrears := 0;
                DurationInArrears := 0;
                RepaymentAmount := 0;
                LoanS.CalcFields(LoanS."Outstanding Balance", LoanS."Oustanding Interest");//,loans."Last Pay Date");
                                                                                           /*IF  (loans."Approved Amount" >0) AND (loans.Installments>0) THEN
                                                                                           RepaymentAmount:=(loans."Approved Amount"/loans.Installments);
                                                                                           IF (RepaymentAmount>0) THEN
                                                                                           IF (loans."Amount In Arrears"=0) THEN
                                                                                           DurationInArrears:=0
                                                                                           ELSE
                                                                                           DurationInArrears:=ROUND((loans."Amount In Arrears"/RepaymentAmount),1,'<');
                                                                                           */
                                                                                           //IF loans."Last Pay Date"=0D THEN
                if LoanS.Find('-') then begin
                    LoanS.Reset;
                    LoanS.SetRange(LoanS."Loan  No.", "Loan  No.");
                    LoanS.CalcFields(LoanS."Outstanding Balance");
                    APaid := LoanS."Approved Amount" - LoanS."Outstanding Balance";
                    if LoanS."Loan Principle Repayment" > 0 then
                        PPaid := ROUND((APaid / LoanS."Loan Principle Repayment"), 1);
                    // SPERIOD:=CALCDATE(FORMAT((loans."Expected Date of Completion"-loans."Issued Date")/30));
                    //MESSAGE(FORMAT(SPERIOD));
                    EPeriod := ROUND(((AsAt - LoanS."Issued Date") / 30), 1, '<');
                    Expected := ROUND((((AsAt - LoanS."Issued Date") / 30) * LoanS."Loan Principle Repayment"), 1, '<');
                    // IF EPeriod>SPERIOD THEN
                    // Expected:=(SPERIOD-PPaid)*loans."Loan Principle Repayment";
                    //MESSAGE(FORMAT(Expected));
                    DAmount := ROUND((Expected - APaid), 1, '<');
                    if LoanS."Loan Principle Repayment" > 0 then
                        DInstal := ROUND((DAmount / LoanS."Loan Principle Repayment"), 1, '<');
                    //loans."Defaulted install":=DInstal;
                    //MESSAGE(FORMAT(DInstal));
                    LoanS."Amount in Arrears" := DAmount;
                    if DAmount >= LoanS."Outstanding Balance" then
                        LoanS."Amount in Arrears" := LoanS."Outstanding Balance";
                    //MESSAGE(FORMAT(loans."Principle Arrears"));
                    //loans."Defaulted Instal":=DInstal;
                    LoanS.Modify;
                    //END;
                    // DaysinArrears:=AsAt-loans."Last Pay Date";
                    //DurationInArrears:=ROUND(DaysinArrears/30,1,'=');
                    DurationInArrears := DInstal;
                    if (DurationInArrears <= 0) and (DurationInArrears < 1) then begin
                        if LoanS."Expected Date of Completion" >= AsAt then
                            "0Month" := LoanS."Outstanding Balance";
                        "0MonthC" := "0MonthC" + 1;
                        Count1 := Count1 + 1;
                        LoanS."Loans Category-SASRA" := LoanS."loans category-sasra"::Perfoming;
                        LoanS."Loans Category" := LoanS."loans category"::Perfoming;
                    end else
                        if (DurationInArrears >= 1) and (DurationInArrears <= 2) then begin
                            if LoanS."Expected Date of Completion" >= AsAt then
                                "1Month" := LoanS."Outstanding Balance";
                            "1MonthC" := "1MonthC" + 1;
                            Count2 := Count2 + 1;
                            "Loans Category-SASRA" := "loans category-sasra"::Watch;
                            "Loans Category" := "loans category"::Watch;
                        end else
                            if (DurationInArrears > 2) and (DurationInArrears <= 6) then begin
                                if LoanS."Expected Date of Completion" >= AsAt then
                                    "2Month" := LoanS."Outstanding Balance";
                                "2MonthC" := "2MonthC" + 1;
                                Count3 := Count3 + 1;
                                //loans."Expected Date of Completion">2M;
                                "Loans Category-SASRA" := "loans category-sasra"::Substandard;
                                "Loans Category" := "loans category"::Substandard;
                            end else
                                if (DurationInArrears > 6) and (DurationInArrears < 12) then begin
                                    if LoanS."Expected Date of Completion" >= AsAt then
                                        //"Loans Category-SASRA"<>Loss;
                                        "3Month" := LoanS."Outstanding Balance";
                                    "3MonthC" := "3MonthC" + 1;
                                    Count4 := Count4 + 1;
                                    "Loans Category-SASRA" := "loans category-sasra"::Doubtful;
                                    "Loans Category" := "loans category"::Doubtful;
                                end else
                                    if (DurationInArrears >= 12) then begin
                                        Over3Month := LoanS."Outstanding Balance";
                                        Over3MonthC := Over3MonthC + 1;
                                        Count5 := Count5 + 1;
                                        "Loans Category-SASRA" := "loans category-sasra"::Loss;
                                        "Loans Category" := "loans category"::Loss;
                                    end;
                    if LoanS."Expected Date of Completion" <= AsAt then
                        Over3Month := LoanS."Outstanding Balance";
                    Over3MonthC := Over3MonthC + 1;
                    Count5 := Count5 + 1;
                    "Loans Category-SASRA" := "loans category-sasra"::Loss;
                    "Loans Category" := "loans category"::Loss;
                    Modify;
                    // //DifinOutBal:=(loans.Frequency-loans."Amount In Arrears")*-1;
                    //
                    // loans.SETFILTER(loans."Date filter",'..'+FORMAT(AsAt));
                    //
                    // EVALUATE(DFormula,'1Q');
                    //
                    // Cust.RESET;
                    // IF loans.Source = loans.Source::BOSA THEN
                    // Cust.SETRANGE(Cust."No.",loans."BOSA No")
                    // ELSE
                    // Cust.SETRANGE(Cust."No.",loans."Client Code");
                    // IF Cust.FIND('-') THEN BEGIN
                    // Cust.CALCFIELDS(Cust."Current Shares");
                    // PhoneNo := Cust."Phone No.";
                    // "StaffNo." := Cust."Personal No";
                    // Deposits := Cust."Current Shares";
                    // END;
                    //
                    // "0Month":=0;
                    // "1Month":=0;
                    // "2Month":=0;
                    // "3Month":=0;
                    // Over3Month:=0;
                    // DaysinArrears:=0;
                    // DurationInArrears:=0;
                    // RepaymentAmount:=0;
                    // loans.CALCFIELDS(loans."Outstanding Balance",loans."Oustanding Interest",loans."Last Pay Date");
                    // {IF  (loans."Approved Amount" >0) AND (loans.Installments>0) THEN
                    // RepaymentAmount:=(loans."Approved Amount"/loans.Installments);
                    // IF (RepaymentAmount>0) THEN
                    // IF (loans."Amount In Arrears"=0) THEN
                    // DurationInArrears:=0
                    // ELSE
                    // DurationInArrears:=ROUND((loans."Amount In Arrears"/RepaymentAmount),1,'<');
                    // }
                    // IF loans."Last Pay Date"<>0D THEN
                    // DaysinArrears:=AsAt-loans."Last Pay Date";
                    // DurationInArrears:=ROUND(DaysinArrears/30,1,'=');
                    // IF (DurationInArrears >=0) AND (DurationInArrears <1)   THEN BEGIN
                    // "0Month":=loans."Outstanding Balance";
                    // "0MonthC":="0MonthC"+1;
                    // Count1:=Count1+1;
                    // "Loans Category-SASRA":="Loans Category-SASRA"::Watch;
                    // END ELSE IF (DurationInArrears >=1) AND (DurationInArrears <2)  THEN BEGIN
                    // "1Month":=loans."Outstanding Balance";
                    // "1MonthC":="1MonthC"+1;
                    // Count2:=Count2+1;
                    // "Loans Category-SASRA":="Loans Category-SASRA"::Substandard;
                    // END ELSE IF (DurationInArrears >=2) AND (DurationInArrears <=6) THEN BEGIN
                    // "2Month":=loans."Outstanding Balance";
                    // "2MonthC":="2MonthC"+1;
                    // Count3:=Count3+1;
                    // "Loans Category-SASRA":="Loans Category-SASRA"::Doubtful;
                    // END ELSE IF (DurationInArrears >6) AND (DurationInArrears <=12) THEN BEGIN
                    // "3Month":=loans."Outstanding Balance";
                    // "3MonthC":="3MonthC"+1;
                    // Count4:=Count4+1;
                    // "Loans Category-SASRA":="Loans Category-SASRA"::Loss;
                    // END ELSE IF (DurationInArrears >12)  THEN BEGIN
                    // Over3Month:=loans."Outstanding Balance";
                    // Over3MonthC:=Over3MonthC+1;
                    // Count5:=Count5+1;
                    // "Loans Category-SASRA":="Loans Category-SASRA"::"5";
                    // END;
                    //
                    // loans.MODIFY;
                    //loans.MODIFY;
                    //DifinOutBal:=(loans.Frequency-loans."Amount In Arrears")*-1;}
                    //FnRunGetLoanCategory("Loan  No.");
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
                field(AsAt; AsAt)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cutoffdate';
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
        /* IF Usersetup.GET(USERID) THEN
       BEGIN
       IF Usersetup."View FOSA"=FALSE THEN ERROR ('You dont have permissions to view FOSA Module, Contact your system administrator! ')
       END;
       */
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
        Expected: Decimal;
        APaid: Decimal;
        DAmount: Decimal;
        SPERIOD: Date;
        PPaid: Integer;
        AArears: Decimal;
        DInstal: Integer;
        EPeriod: Integer;
        "3MonthC": Integer;
        Over3MonthC: Integer;
        NoLoans: Integer;
        PhoneNo: Text[50];
        Cust: Record Customer;
        "StaffNo.": Text[50];
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
        Usersetup: Record "User Setup";
        Count1: Integer;
        Count2: Integer;
        Count3: Integer;
        Count4: Integer;
        Count5: Integer;
        DurationInArrears: Integer;
        RepaymentAmount: Decimal;
        DifinOutBal: Decimal;
        DaysinArrears: Decimal;
        RepaymentPeriod: Date;
        LastMonth: Date;
        LSchedule: Record "Loan Repayment Schedule";
        ScheduledLoanBal: Decimal;
        DateFilter: Text;
        LBal: Decimal;
        Arreas: Decimal;
        "No.OfMonthsonArrears": Integer;
        LoanS: Record "Loans Register";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516439_v6_3_0_2259;
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
