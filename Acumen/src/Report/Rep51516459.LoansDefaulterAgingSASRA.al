#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516459_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516459 "Loans Defaulter Aging - SASRA."
{
    RDLCLayout = './Layouts/LoansDefaulterAging-SASRA..rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            CalcFields = "Outstanding Balance", "Last Pay Date";
            DataItemTableView = sorting("Loan  No.") where("Outstanding Balance" = filter(> 0));
            RequestFilterFields = Source, "Loan Product Type", "Outstanding Balance", "Date filter", "Account No";
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
            column(DaysInArrears_LoansRegister; "Loans Register"."Loan Insurance Paid")
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
            column(LoanProductType; "Loans Register"."Loan Product Type")
            {
            }
            column(AsAt; AsAt)
            {
            }
            trigger OnPreDataItem();
            begin

                GrandTotal := 0;
                Company.Get();
                Company.CalcFields(Company.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                RepaymentPeriod := AsAt;
                //MESSAGE(FORMAT(AsAt));
                if "Loans Register"."Repayment Frequency" = "Loans Register"."repayment frequency"::Monthly then begin
                    if RepaymentPeriod = CalcDate('CM', RepaymentPeriod) then begin
                        LastMonth := RepaymentPeriod;
                    end else begin
                        LastMonth := CalcDate('-1M', RepaymentPeriod);
                    end;
                    LastMonth := CalcDate('CM', LastMonth);
                end;
                DateFilter := '..' + Format(AsAt);
                Loans.Reset;
                Loans.SetRange(Loans."Loan  No.", "Loans Register"."Loan  No.");
                Loans.SetFilter(Loans."Date filter", DateFilter);
                if Loans.Find('-') then begin
                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Scheduled Principal to Date", Loans."Principal Paid", Loans."Schedule Repayments");
                    LBal := Loans."Outstanding Balance";
                    //MESSAGE('##Loan Balance %1',FORMAT(LBal));
                    LSchedule.Reset;
                    LSchedule.SetRange(LSchedule."Loan No.", "Loans Register"."Loan  No.");
                    LSchedule.SetFilter(LSchedule."Repayment Date", DateFilter);
                    // IF LSchedule.GET(LSchedule."Loan No.") THEN
                    if LSchedule.Find('-') then
                        ScheduledLoanBal := LSchedule."Loan Balance";
                    //ScheduledLoanBal:=Loans."Scheduled Principal to Date";
                    //ScheduledLoanBal:=Loans."Schedule Repayments";
                    //  MESSAGE(FORMAT(ScheduledLoanBal));
                    ExpectedBalance := ROUND(ScheduledLoanBal, 1, '>');
                    //MESSAGE('##Expected Balance %1',FORMAT(ExpectedBalance));
                    Arrears := LBal - ExpectedBalance;
                    //MESSAGE(FORMAT(Arrears));
                end;
                //MESSAGE('Principal=%1 Balance=%2 ExepectedBal=%3 Arrear=%4,ScheduledLoanBal=%5',"Loans Register"."Approved Amount",LBal,ExpectedBalance,Arrears,ScheduledLoanBal);
                // MESSAGE('%1',Loans."Scheduled Principal to Date");
                if (Arrears <= 0) or (Arrears = 0) then begin
                    Arrears := 0
                end else
                    Arrears := Arrears;
                "Amount in Arrears" := Arrears;
                //"No.ofMonthsinArrears":=
                Modify;
                // IF Arrears<> 0 THEN BEGIN
                if Loans."Outstanding Balance" > 0 then
                    "No.ofMonthsinArrears" := ROUND((Arrears / Loans."Loan Principle Repayment") * 30, 1, '>');
                // MESSAGE('%1',"No.ofMonthsinArrears");
                /*IF Loans."Loan Product Type"='FIXED ADV' THEN
                  "No.ofMonthsinArrears":=0;
                IF Loans."Loan Product Type"='MSADV' THEN BEGIN
                 Numberofdays:=AsAt-"Loans Register"."Loan Disbursement Date";
                 IF Numberofdays<=0 THEN
                   "No.ofMonthsinArrears":=0;
                     Arrears:=0;
                     "Amount in Arrears":= Arrears;
                MODIFY;
                END;*/
                //END;
                //"No.ofMonthsinArrears"*30;
                // MESSAGE('%1 %2 %3',"No.ofMonthsinArrears",Arrears,Loans.Repayment);
                if ("No.ofMonthsinArrears" <= 0) then begin
                    "Loans Register"."Loans Category" := "Loans Register"."loans category"::Perfoming
                end else
                    if (("No.ofMonthsinArrears" > 0) and ("No.ofMonthsinArrears" <= 30)) then begin
                        "Loans Register"."Loans Category" := "Loans Register"."loans category"::Watch
                    end else
                        if ("No.ofMonthsinArrears" > 30) and ("No.ofMonthsinArrears" <= 180) then begin
                            "Loans Register"."Loans Category" := "Loans Register"."loans category"::Substandard
                        end else
                            if ("No.ofMonthsinArrears" > 180) and ("No.ofMonthsinArrears" <= 360) then begin
                                "Loans Register"."Loans Category" := "Loans Register"."loans category"::Doubtful
                            end else
                                if ("No.ofMonthsinArrears" > 360) then begin
                                    "Loans Register"."Loans Category" := "Loans Register"."loans category"::Loss
                                end;
                if "Loans Register"."Expected Date of Completion" <= Today then
                    "Loans Register"."Loans Category" := "Loans Register"."loans category"::Loss;
                "Loans Register"."Loans Category-SASRA" := "Loans Register"."loans category-sasra"::Loss;
                "No of Months in Arrears" := "No.ofMonthsinArrears";
                "Loans Register"."Loan Insurance Paid" := "No.ofMonthsinArrears";
                "Loans Register".Modify;
                if ("No.ofMonthsinArrears" <= 0) then begin
                    "Loans Register"."Loans Category-SASRA" := "Loans Register"."loans category-sasra"::Perfoming
                end else
                    if (("No.ofMonthsinArrears" > 0) and ("No.ofMonthsinArrears" <= 30)) then begin
                        "Loans Register"."Loans Category-SASRA" := "Loans Register"."loans category-sasra"::Watch
                    end else
                        if ("No.ofMonthsinArrears" > 30) and ("No.ofMonthsinArrears" <= 180) then begin
                            "Loans Register"."Loans Category-SASRA" := "Loans Register"."loans category-sasra"::Substandard
                        end else
                            if ("No.ofMonthsinArrears" > 180) and ("No.ofMonthsinArrears" <= 360) then begin
                                "Loans Register"."Loans Category-SASRA" := "Loans Register"."loans category-sasra"::Doubtful
                            end else
                                if ("No.ofMonthsinArrears" > 360) then begin
                                    "Loans Register"."Loans Category" := "Loans Register"."loans category"::Loss
                                    //MESSAGE(FORMAT("Loans Register"."Loans Category"));
                                end;
                "Loans Register".Modify;
                if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Perfoming then
                    "0Month" := "Loans Register"."Outstanding Balance";
                // ELSE
                if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Watch then
                    "1Month" := "Loans Register"."Outstanding Balance";
                // ELSE
                if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Substandard then
                    "2Month" := "Loans Register"."Outstanding Balance";
                //ELSE
                if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Doubtful then
                    "3Month" := "Loans Register"."Outstanding Balance";
                // ELSE
                if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Loss then
                    Over3Month := "Loans Register"."Outstanding Balance";
                "Loans Register".Modify;
                GrandTotal := GrandTotal + "Loans Register"."Outstanding Balance";
                if ("1Month" + "2Month" + "3Month" + Over3Month) > 0 then
                    NoLoans := NoLoans + 1;

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
        ExpectedBalance: Decimal;
        Numberofdays: Integer;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516459_v6_3_0_2259;
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
