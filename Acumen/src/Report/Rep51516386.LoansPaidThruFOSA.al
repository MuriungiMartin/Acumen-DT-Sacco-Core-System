#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516386_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516386 "Loans Paid Thru FOSA"
{
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/LoansPaidThruFOSA.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where(Posted = filter(true));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Loan Disbursement Date", Source;
            column(ReportForNavId_4645; 4645) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address2; Company."Address 2")
            {
            }
            column(Company_PhoneNo; Company."Phone No.")
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(CurrReport_PAGENO; Format(ReportForNav.PageNo))
            {
            }
            column(Loan_No; LAppl."Loan  No.")
            {
            }
            column(Loan_Product_Type; LAppl."Loan Product Type")
            {
            }
            column(Client_Code; LAppl."Client Code")
            {
            }
            column(Approved_Amount; LoanAp."Approved Amount")
            {
            }
            column(Loan_Status; LAppl."Loan Status")
            {
            }
            column(Issued_Date; LoanAp."Issued Date")
            {
            }
            column(Outstanding_Bal; LoanAp."Outstanding Balance")
            {
            }
            column(Outstanding_Int; LoanAp."Oustanding Interest")
            {
            }
            column(UserId; UserId)
            {
            }
            column(Verified_By__________________________________________________Caption; Verified_By__________________________________________________CaptionLbl)
            {
            }
            column(Confirmed_By__________________________________________________Caption; Confirmed_By__________________________________________________CaptionLbl)
            {
            }
            column(Sign________________________Caption; Sign________________________CaptionLbl)
            {
            }
            column(Sign________________________Caption_Control1102755003; Sign________________________Caption_Control1102755003Lbl)
            {
            }
            column(Date________________________Caption; Date________________________CaptionLbl)
            {
            }
            column(Date________________________Caption_Control1102755005; Date________________________Caption_Control1102755005Lbl)
            {
            }
            column(NameCreditOff; NameCreditOff)
            {
            }
            column(NameCreditDate; NameCreditDate)
            {
            }
            column(NameCreditSign; NameCreditSign)
            {
            }
            column(NameCreditMNG; NameCreditMNG)
            {
            }
            column(NameCreditMNGDate; NameCreditMNGDate)
            {
            }
            column(NameCreditMNGSign; NameCreditMNGSign)
            {
            }
            column(NameCEO; NameCEO)
            {
            }
            column(NameCEOSign; NameCEOSign)
            {
            }
            column(NameCEODate; NameCEODate)
            {
            }
            column(CreditCom1; CreditCom1)
            {
            }
            column(CreditCom1Date; CreditCom1Date)
            {
            }
            column(CreditCom2; CreditCom2)
            {
            }
            column(CreditCom2Sign; CreditCom2Sign)
            {
            }
            column(CreditCom2Date; CreditCom2Date)
            {
            }
            column(CreditCom3; CreditCom3)
            {
            }
            column(CreditComDate3; CreditComDate3)
            {
            }
            column(CreditComSign3; CreditComSign3)
            {
            }
            column(COMPPIC; PICTURE)
            {
            }
            column(Name; Name)
            {
            }
            trigger OnPreDataItem();
            begin
                if LoanProdType.Get("Loans Register".GetFilter("Loans Register"."Loan Product Type")) then
                    LoanType := LoanProdType."Product Description";
                LCount := 0;
                if "Loans Register".GetFilter("Loans Register"."Branch Code") <> '' then begin
                    DValue.Reset;
                    DValue.SetRange(DValue."Global Dimension No.", 2);
                    DValue.SetRange(DValue.Code, "Loans Register".GetFilter("Loans Register"."Branch Code"));
                    if DValue.Find('-') then
                        RFilters := 'Branch: ' + DValue.Name;
                end;
            end;

            trigger OnAfterGetRecord();
            begin
                /*
				BOSABal:=0;
				SuperBal:=0;
				Deposits:=0;
				LCount:=LCount+1;
				CompanyCode:='';
				LocationFilter:='';
				RPeriod:=Loans.Installments;
				IF (Loans."Outstanding Balance" > 0) AND (Loans.Repayment > 0) THEN
				RPeriod:=Loans."Outstanding Balance"/Loans.Repayment;
				BatchL:='';
				IF Batches.GET(Loans."Batch No.") THEN BEGIN
				Batches.CALCFIELDS(Batches."Currect Location");
				BatchL:=Batches."Currect Location";
				END;
				IF Loans.GETFILTER(Loans."Location Filter") <> '' THEN  BEGIN
				ApprovalSetup.RESET;
				ApprovalSetup.SETRANGE(ApprovalSetup."Approval Type",ApprovalSetup."Approval Type"::"File Movement");
				ApprovalSetup.SETFILTER(ApprovalSetup.Stage,Loans.GETFILTER(Loans."Location Filter"));
				IF ApprovalSetup.FIND('-') THEN
				LocationFilter:=ApprovalSetup.Station;
				END;
				IF LocationFilter = '' THEN
				TotalApproved:=TotalApproved+Loans."Approved Amount"
				ELSE BEGIN
				IF LocationFilter = BatchL THEN
				TotalApproved:=TotalApproved+Loans."Approved Amount"
				END;
				//Get balance of BOSA Loans + super loans
				IF (Loans.Source=Loans.Source::BOSA) OR (Loans."Loan Product Type"='SUPER') THEN BEGIN
				cust.RESET;
				cust.SETRANGE(cust."No.",Loans."Client Code");
				cust.SETRANGE(cust."Customer Type",cust."Customer Type"::Member);
				IF cust.FIND('-') THEN BEGIN
				cust.CALCFIELDS(cust."Outstanding Balance",cust."Current Shares");
				BOSABal:=cust."Outstanding Balance";
				Deposits:=ABS(cust."Current Shares");
				CompanyCode:=cust."Employer Code";
				END ELSE BEGIN
				cust.RESET;
				cust.SETRANGE(cust."No.",Loans."BOSA No");
				cust.SETRANGE(cust."Customer Type",cust."Customer Type"::Member);
				IF cust.FIND('-') THEN BEGIN
				cust.CALCFIELDS(cust."Outstanding Balance",cust."Current Shares");
				BOSABal:=cust."Outstanding Balance";
				Deposits:=ABS(cust."Current Shares");
				CompanyCode:=cust."Employer Code";
				END;
				END;
				LAppl.RESET;
				LAppl.SETRANGE(LAppl."Client Code",Loans."Account No");
				LAppl.SETRANGE(LAppl."Loan Product Type",'SUPER');
				LAppl.SETFILTER(LAppl."Outstanding Balance",'>0');
				LAppl.SETRANGE(LAppl.Posted,TRUE);
				IF LAppl.FIND('-') THEN BEGIN
				REPEAT
				LAppl.CALCFIELDS(LAppl."Outstanding Balance");
				SuperBal:=SuperBal+LAppl."Outstanding Balance";
				UNTIL LAppl.NEXT=0;
				END;
				END;
				//Loans."Net Amount":=Loans."Approved Amount"-Loans."Top Up Amount";
				//Get The Loan Type
				*/
                CompanyCode := '';
                if cust.Get("Loans Register"."BOSA No") then
                    CompanyCode := cust."Employer Code";
                BRIGEDAMOUNT := 0;
                Netdisbursed := 0;
                JazaLevy := 0;
                BridgeLevy := 0;
                //TotalUpfronts:=0;
                //TotalNetPay:=0;
                LoanTopUp.Reset;
                LoanTopUp.SetRange(LoanTopUp."Loan No.", "Loans Register"."Loan  No.");
                LoanTopUp.SetRange(LoanTopUp."Client Code", "Loans Register"."Client Code");
                if LoanTopUp.Find('-') then begin
                    repeat
                        //BRIGEDAMOUNT:=BRIGEDAMOUNT+LoanTopUp."Principle Top Up";
                        BRIGEDAMOUNT := BRIGEDAMOUNT + LoanTopUp."Total Top Up";
                    until LoanTopUp.Next = 0;
                end;
                GenSetUp.Get();
                if LoanProdType.Get("Loan Product Type") then begin
                    JazaLevy := ROUND(("Jaza Deposits" * 0.15), 1, '>');
                    BridgeLevy := ROUND((BRIGEDAMOUNT * 0.06), 1, '>');
                    ;
                    if "Top Up Amount" > 0 then begin
                        if BridgeLevy < 500 then begin
                            BridgeLevy := 500;
                        end else begin
                            BridgeLevy := ROUND(BridgeLevy, 1, '>');
                        end;
                    end;
                    if "Mode of Disbursement" = "mode of disbursement"::Cheque then
                        Upfronts := BRIGEDAMOUNT + "Jaza Deposits" + "Deposit Reinstatement" + JazaLevy + BridgeLevy + GenSetUp."Loan Trasfer Fee-Cheque"
                    else
                        if "Mode of Disbursement" = "mode of disbursement"::EFT then
                            Upfronts := BRIGEDAMOUNT + "Jaza Deposits" + "Deposit Reinstatement" + JazaLevy + BridgeLevy + GenSetUp."Loan Trasfer Fee-EFT"
                        else
                            if "Mode of Disbursement" = "mode of disbursement"::"Bank Transfer" then
                                Upfronts := BRIGEDAMOUNT + "Jaza Deposits" + "Deposit Reinstatement" + JazaLevy + BridgeLevy + GenSetUp."Loan Trasfer Fee-FOSA";
                    Netdisbursed := "Approved Amount" - Upfronts;
                end;
                Netdisbursed := "Approved Amount" - Upfronts;
                TotalUpfronts := TotalUpfronts + Upfronts;
                TotalNetPay := TotalNetPay + Netdisbursed;
                LCount := LCount + 1;

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
        Company.Get();
        Company.CalcFields(Company.Picture);
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
        if "COMPY INFOR".Get then begin
            "COMPY INFOR".CalcFields("COMPY INFOR".Picture);
            Name := "COMPY INFOR".Name;
        end;
        ;
        ReportsForNavPre;
    end;

    var
        RPeriod: Decimal;
        BatchL: Code[100];
        Batches: Record "Loan Disburesment-Batching";
        ApprovalSetup: Record "Table Permission Buffer";
        LocationFilter: Code[20];
        TotalApproved: Decimal;
        cust: Record "Member Register";
        BOSABal: Decimal;
        SuperBal: Decimal;
        LAppl: Record "Loans Register";
        Deposits: Decimal;
        CompanyCode: Code[20];
        LoanType: Text[50];
        LoanProdType: Record "Loan Products Setup";
        LCount: Integer;
        RFilters: Text[250];
        DValue: Record "Dimension Value";
        VALREPAY: Record "Cust. Ledger Entry";
        Loans_RegisterCaptionLbl: label 'Approved Loans Report';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Client_No_CaptionLbl: label 'Client No.';
        Outstanding_LoanCaptionLbl: label 'Outstanding Loan';
        PeriodCaptionLbl: label 'Period';
        Approved_DateCaptionLbl: label 'Approved Date';
        Loan_TypeCaption_Control1102760043Lbl: label 'Loan Type';
        Verified_By__________________________________________________CaptionLbl: label 'Verified By..................................................';
        Confirmed_By__________________________________________________CaptionLbl: label 'Confirmed By..................................................';
        Sign________________________CaptionLbl: label 'Sign........................';
        Sign________________________Caption_Control1102755003Lbl: label 'Sign........................';
        Date________________________CaptionLbl: label 'Date........................';
        Date________________________Caption_Control1102755005Lbl: label 'Date........................';
        GenSetUp: Record "Sacco General Set-Up";
        LoanApp: Record "Loans Register";
        CustRec: Record "Member Register";
        CustRecord: Record "Member Register";
        TShares: Decimal;
        TLoans: Decimal;
        LoanShareRatio: Decimal;
        Eligibility: Decimal;
        TotalSec: Decimal;
        saccded: Decimal;
        saccded2: Decimal;
        grosspay: Decimal;
        Tdeduct: Decimal;
        Cshares: Decimal;
        "Cshares*3": Decimal;
        "Cshares*4": Decimal;
        QUALIFY_SHARES: Decimal;
        salary: Decimal;
        LoanG: Record "Loans Guarantee Details";
        GShares: Decimal;
        Recomm: Decimal;
        GShares1: Decimal;
        NETTAKEHOME: Decimal;
        Msalary: Decimal;
        RecPeriod: Integer;
        FOSARecomm: Decimal;
        FOSARecoPRD: Integer;
        "Asset Value": Decimal;
        InterestRate: Decimal;
        RepayPeriod: Decimal;
        LBalance: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        SecuredSal: Decimal;
        Linterest1: Integer;
        LOANBALANCE: Decimal;
        BRIDGEDLOANS: Record "Loan Offset Details";
        BRIDGEBAL: Decimal;
        LOANBALANCEFOSASEC: Decimal;
        TotalTopUp: Decimal;
        TotalIntPayable: Decimal;
        GTotals: Decimal;
        TempVal: Decimal;
        TempVal2: Decimal;
        "TempCshares*4": Decimal;
        "TempCshares*3": Decimal;
        InstallP: Decimal;
        RecomRemark: Text[150];
        InstallRecom: Decimal;
        TopUpComm: Decimal;
        TotalTopupComm: Decimal;
        LoanTopUp: Record "Loan Offset Details";
        "Interest Payable": Decimal;
        "general set-up": Record "Sacco General Set-Up";
        Days: Integer;
        EndMonthInt: Decimal;
        BRIDGEBAL2: Decimal;
        DefaultInfo: Text[80];
        TOTALBRIDGED: Decimal;
        DEpMultiplier: Decimal;
        MAXAvailable: Decimal;
        SalDetails: Record "Loan Appraisal Salary Details";
        Earnings: Decimal;
        Deductions: Decimal;
        BrTopUpCom: Decimal;
        LoanAmount: Decimal;
        Company: Record "Company Information";
        CompanyAddress: Code[20];
        CompanyEmail: Text[30];
        CompanyTel: Code[20];
        CurrentAsset: Decimal;
        CurrentLiability: Decimal;
        FixedAsset: Decimal;
        Equity: Decimal;
        Sales: Decimal;
        SalesOnCredit: Decimal;
        AppraiseDeposits: Boolean;
        AppraiseShares: Boolean;
        AppraiseSalary: Boolean;
        AppraiseGuarantors: Boolean;
        AppraiseBusiness: Boolean;
        TLoan: Decimal;
        LoanBal: Decimal;
        GuaranteedAmount: Decimal;
        RunBal: Decimal;
        TGuaranteedAmount: Decimal;
        GuarantorQualification: Boolean;
        TotalLoanBalance: Decimal;
        TGAmount: Decimal;
        NetSalary: Decimal;
        Riskamount: Decimal;
        WarnBridged: Text;
        WarnSalary: Text;
        WarnDeposits: Text;
        WarnGuarantor: Text;
        WarnShare: Text;
        RiskGshares: Decimal;
        RiskDeposits: Decimal;
        BasicEarnings: Decimal;
        DepX: Decimal;
        LoanPrincipal: Decimal;
        loanInterest: Decimal;
        AmountGuaranteed: Decimal;
        StatDeductions: Decimal;
        GuarOutstanding: Decimal;
        TwoThirds: Decimal;
        Bridged_AmountCaption: Integer;
        LNumber: Code[20];
        TotalLoanDeductions: Decimal;
        TotalRepayments: Decimal;
        Totalinterest: Decimal;
        Band: Decimal;
        TotalOutstanding: Decimal;
        BANDING: Record "Deposit Tier Setup";
        NtTakeHome: Decimal;
        ATHIRD: Decimal;
        Psalary: Decimal;
        LoanApss: Record "Loans Register";
        TotalLoanBal: Decimal;
        TotalBand: Decimal;
        LoanAp: Record "Loans Register";
        TotalRepay: Decimal;
        TotalInt: Decimal;
        LastFieldNo: Integer;
        TotLoans: Decimal;
        JazaLevy: Decimal;
        BridgeLevy: Decimal;
        Upfronts: Decimal;
        Netdisbursed: Decimal;
        TotalLRepayments: Decimal;
        BridgedRepayment: Decimal;
        OutstandingLrepay: Decimal;
        Loantop: Record "Loan Offset Details";
        BRIGEDAMOUNT: Decimal;
        TOTALBRIGEDAMOUNT: Decimal;
        FinalInst: Decimal;
        NonRec: Decimal;
        TotalUpfronts: Decimal;
        TotalNetPay: Decimal;
        NameCreditOff: label 'Name......................................';
        NameCreditDate: label 'Date........................................';
        NameCreditSign: label 'Signature..................................';
        NameCreditMNG: label 'Name......................................';
        NameCreditMNGDate: label 'Date.....................................';
        NameCreditMNGSign: label 'Signature..................................';
        NameCEO: label 'Name........................................';
        NameCEOSign: label 'Signature...................................';
        NameCEODate: label 'Date.....................................';
        CreditCom1: label 'Name........................................';
        CreditCom1Sign: label 'Signature...................................';
        CreditCom1Date: label 'Date.........................................';
        CreditCom2: label 'Name........................................';
        CreditCom2Sign: label 'Signature....................................';
        CreditCom2Date: label 'Date..........................................';
        CreditCom3: label 'Name.........................................';
        CreditComDate3: label 'Date..........................................';
        CreditComSign3: label 'Signature..................................';
        Comment: label '....................';
        "COMPY INFOR": Record "Company Information";
        Name: Text;
        PICTURE: Text;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516386_v6_3_0_2259;
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