#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516485_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516485 "Loans Batch Schedule"
{
    RDLCLayout = './Layouts/LoansBatchSchedule.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loan Disburesment-Batching"; "Loan Disburesment-Batching")
        {
            RequestFilterFields = "Batch No.";
            column(ReportForNavId_1157; 1157) { } // Autogenerated by ForNav - Do not delete
            column(UserId; UserId)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; Format(ReportForNav.PageNo))
            {
            }
            column(Address; CompInfo.Address)
            {
            }
            column(Phoneno; CompInfo."Phone No.")
            {
            }
            column(EmailAddress; CompInfo."E-Mail")
            {
            }
            column(HomePage; CompInfo."Home Page")
            {
            }
            column(Company_Name; CompInfo.Name)
            {
            }
            column(PostCode; CompInfo."Post Code")
            {
            }
            column(City; CompInfo.City)
            {
            }
            column(Batches__Document_No__; "Loan Disburesment-Batching"."Document No.")
            {
            }
            column(Batches__Batch_No__; "Loan Disburesment-Batching"."Batch No.")
            {
            }
            column(Batches__Description_Remarks_; "Loan Disburesment-Batching"."Description/Remarks")
            {
            }
            column(Batches__Mode_Of_Disbursement_; "Loan Disburesment-Batching"."Mode Of Disbursement")
            {
            }
            column(Batches__Cheque_No__; "Loan Disburesment-Batching"."Cheque No.")
            {
            }
            column(Batches__BOSA_Bank_Account_; "Loan Disburesment-Batching"."BOSA Bank Account")
            {
            }
            column(Batches_Batches__Batch_Type_; "Loan Disburesment-Batching"."Batch Type")
            {
            }
            column(Batches__No_of_Loans_; "Loan Disburesment-Batching"."No of Loans")
            {
            }
            column(TApprovedAmount; TApprovedAmount)
            {
            }
            column(Loans__Special_Loan_Amount_; "Loans Register"."Special Loan Amount")
            {
            }
            column(Loans__Requested_Amount_; "Loans Register"."Requested Amount")
            {
            }
            column(Loans__Other_Commitments_Clearance_; "Loans Register"."Other Commitments Clearance")
            {
            }
            column(Loans__Discounted_Amount_; "Loans Register"."Discounted Amount")
            {
            }
            column(Loans_ScheduleCaption; Loans_ScheduleCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Batches__Document_No__Caption; FieldCaption("Document No."))
            {
            }
            column(Batches__Batch_No__Caption; FieldCaption("Batch No."))
            {
            }
            column(Batches__Mode_Of_Disbursement_Caption; FieldCaption("Mode Of Disbursement"))
            {
            }
            column(Batches__Cheque_No__Caption; FieldCaption("Cheque No."))
            {
            }
            column(Batches__BOSA_Bank_Account_Caption; FieldCaption("BOSA Bank Account"))
            {
            }
            column(Batch_TypeCaption; Batch_TypeCaptionLbl)
            {
            }
            column(Batches__No_of_Loans_Caption; FieldCaption("No of Loans"))
            {
            }
            column(APPROVED_BY______________________________________________Caption; APPROVED_BY______________________________________________CaptionLbl)
            {
            }
            column(Grand_TotalsCaption; Grand_TotalsCaptionLbl)
            {
            }
            column(CHECKED_BY______________________________________________Caption; CHECKED_BY______________________________________________CaptionLbl)
            {
            }
            column(AUTHORISED_BY______________________________________________Caption; AUTHORISED_BY______________________________________________CaptionLbl)
            {
            }
            column(V1st__SignatoryCaption; V1st__SignatoryCaptionLbl)
            {
            }
            column(V2nd_SignatoryCaption; V2nd_SignatoryCaptionLbl)
            {
            }
            column(V3rd_SignatoryCaption; V3rd_SignatoryCaptionLbl)
            {
            }
            dataitem("Loans Register"; "Loans Register")
            {
                DataItemLink = "Batch No." = field("Batch No.");
                column(ReportForNavId_4645; 4645) { } // Autogenerated by ForNav - Do not delete
                column(Loans__Loan__No__; "Loans Register"."Loan  No.")
                {
                }
                column(Loans__Loan_Product_Type_; "Loans Register"."Loan Product Type")
                {
                }
                column(Loans__Client_Code_; "Loans Register"."Client Code")
                {
                }
                column(Loans__Client_Name_; "Loans Register"."Client Name")
                {
                }
                column(Loans__Staff_No_; "Loans Register"."Staff No")
                {
                }
                column(Loans__Approved_Amount_; "Loans Register"."Approved Amount")
                {
                }
                column(Upfronts; "Loans Register".Upfronts)
                {
                }
                column(Netdisbursed; Netdisbursed)
                {
                }
                column(BRIGEDAMOUNT; BRIGEDAMOUNT)
                {
                }
                column(Loans_Installments; "Loans Register".Installments)
                {
                }
                column(Loans__Special_Loan_Amount__Control1102760003; "Loans Register"."Special Loan Amount")
                {
                }
                column(Loans__Other_Commitments_Clearance__Control1102760015; "Loans Register"."Other Commitments Clearance")
                {
                }
                column(Loans__Requested_Amount__Control1102760014; "Loans Register"."Requested Amount")
                {
                }
                column(InsuranceCom; InsuranceCom)
                {
                }
                column(TopUpCommission; TopUpCom)
                {
                }
                column(PrincipleTopUp; "Loans Register"."Top Up Amount")
                {
                }
                column(InterestTopUp; LoanTopup."Interest Top Up")
                {
                }
                column(LCharges; LCharges)
                {
                }
                column(TotalDeductions; TotalDeductions)
                {
                }
                column(EmployerCode; "Loans Register"."Employer Code")
                {
                }
                column(LegalFees; LFees)
                {
                }
                column(NetAmount; NetAmount)
                {
                }
                column(EarlyRelaese; EarlyRelease)
                {
                }
                column(Loans__Cheque_No__; "Loans Register"."Cheque No.")
                {
                }
                column(Loans__Discounted_Amount__Control1102760030; "Loans Register"."Discounted Amount")
                {
                }
                column(Loans__Loan__No__Caption; FieldCaption("Loan  No."))
                {
                }
                column(Loan_TypeCaption; Loan_TypeCaptionLbl)
                {
                }
                column(PeriodCaption; PeriodCaptionLbl)
                {
                }
                column(Member_No_Caption; Member_No_CaptionLbl)
                {
                }
                column(NameCaption; NameCaptionLbl)
                {
                }
                column(Staff_No_Caption; Staff_No_CaptionLbl)
                {
                }
                column(Approved_AmountCaption; Approved_AmountCaptionLbl)
                {
                }
                column(Loans__Special_Loan_Amount__Control1102760003Caption; FieldCaption("Special Loan Amount"))
                {
                }
                column(Bridged_Commitements_Caption; Bridged_Commitements_CaptionLbl)
                {
                }
                column(Requested_AmountCaption; Requested_AmountCaptionLbl)
                {
                }
                column(AcknowledgementCaption; AcknowledgementCaptionLbl)
                {
                }
                column(Loans__Cheque_No__Caption; FieldCaption("Cheque No."))
                {
                }
                column(Loans__Discounted_Amount__Control1102760030Caption; FieldCaption("Discounted Amount"))
                {
                }
                column(SchCharge; SchCharge)
                {
                }
                column(NetLoanAmount; NetLoan)
                {
                }
                column(TotalTopUpCommission; "Loans Register"."Total TopUp Commission")
                {
                }
                column(ShareCharge; ShareCharge)
                {
                }
                column(MemDeposit; MemDeposit)
                {
                }
                column(DepositDeduct; DepositDeduct)
                {
                }
                column(Loans_Batch_No_; "Loans Register"."Batch No.")
                {
                }
                trigger OnAfterGetRecord();
                begin
                    BRIGEDAMOUNT := 0;
                    Netdisbursed := 0;
                    JazaLevy := 0;
                    BridgeLevy := 0;
                    TotalUpfronts := 0;
                    //TotalNetPay:=0;
                    Upfronts := 0;
                    TBridgeLevy := 0;
                    LoanTopup.Reset;
                    LoanTopup.SetRange(LoanTopup."Loan No.", "Loans Register"."Loan  No.");
                    LoanTopup.SetRange(LoanTopup."Client Code", "Loans Register"."Client Code");
                    if LoanTopup.Find('-') then begin
                        repeat
                            //BRIGEDAMOUNT:=BRIGEDAMOUNT+LoanTopup."Principle Top Up";
                            BRIGEDAMOUNT := BRIGEDAMOUNT + LoanTopup."Total Top Up";
                            BridgeLevy := ROUND((BRIGEDAMOUNT * 0.06), 1, '>');
                            /*IF  BridgeLevy < 500 THEN
                            BridgeLevy:=500
                            ELSE
                            BridgeLevy:=BridgeLevy;*/
                            BridgeLevy := LoanTopup.Commision;
                            TBridgeLevy := TBridgeLevy + BridgeLevy;
                        until LoanTopup.Next = 0;
                    end;
                    //MESSAGE('BridgeLevy is %1',TBridgeLevy);
                    InstInterest := 0;
                    if LoanType.Get(LoanApp."Loan Product Type") then begin
                        if LoanApp."Loan Product Type" = 'INST' then begin
                            InstInterest := LoanApp."Approved Amount" * LoanType."Interest rate" / 100;
                        end;
                    end;
                    JazaLevy := "Jaza Deposits" * 0.15;
                    GenSetUp.Get();
                    if LoanProdType.Get("Loan Product Type") then begin
                        if "Mode of Disbursement" = "mode of disbursement"::Cheque then
                            Upfronts := BRIGEDAMOUNT + "Loan Insurance" + "Hisa Allocation" + "Hisa Boosting Commission" + "Hisa Commission" + TBridgeLevy + GenSetUp."Loan Trasfer Fee-Cheque" +
                            "Interest In Arrears" + "Loan SMS Fee";
                        if "Mode of Disbursement" = "mode of disbursement"::EFT then
                            Upfronts := BRIGEDAMOUNT + "Loan Insurance" + "Hisa Allocation" + "Hisa Boosting Commission" + "Hisa Commission" + TBridgeLevy + GenSetUp."Loan Trasfer Fee-EFT" +
                            "Interest In Arrears" + "Loan SMS Fee";
                        if "Mode of Disbursement" = "mode of disbursement"::"Bank Transfer" then
                            Upfronts := 0; /*BRIGEDAMOUNT+"Loan Insurance"+"Hisa Allocation"+"Hisa Boosting Commission"+"Hisa Commission"+TBridgeLevy + GenSetUp."Loan Trasfer Fee-FOSA"+
					"Interest In Arrears"+"Loan SMS Fee";*/
                        if "Mode of Disbursement" = "mode of disbursement"::RTGS then
                            Upfronts := BRIGEDAMOUNT + "Loan Insurance" + "Hisa Allocation" + "Hisa Boosting Commission" + "Hisa Commission" + TBridgeLevy + GenSetUp."Loan Trasfer Fee-RTGS" +
                            "Interest In Arrears" + "Loan SMS Fee";
                        Netdisbursed := "Approved Amount" - Upfronts;
                    end;
                    Netdisbursed := "Approved Amount" - Upfronts;
                    TotalUpfronts := TotalUpfronts + Upfronts;
                    TotalNetPay := TotalNetPay + Netdisbursed;

                end;

            }
            trigger OnPreDataItem();
            begin
                CompInfo.Get;
                CompInfo.CalcFields(CompInfo.Picture);
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
                group(Options)
                {
                    Caption = 'Options';
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
        TRequestedAmount: Decimal;
        TApprovedAmount: Decimal;
        LoanApp: Record "Loans Register";
        Cust: Record Customer;
        Stations: Record Stations;
        StationDesc: Text[150];
        Employer: Record "Sacco Employers";
        EmployerDesc: Text[200];
        Loans_ScheduleCaptionLbl: label 'Loans Schedule';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Batch_TypeCaptionLbl: label 'Batch Type';
        APPROVED_BY______________________________________________CaptionLbl: label 'APPROVED BY:...............................................................................................';
        Grand_TotalsCaptionLbl: label 'Grand Totals';
        CHECKED_BY______________________________________________CaptionLbl: label 'CHECKED BY:...............................................................................................';
        AUTHORISED_BY______________________________________________CaptionLbl: label 'AUTHORISED BY:...............................................................................................';
        V1st__SignatoryCaptionLbl: label '1st  Signatory';
        V2nd_SignatoryCaptionLbl: label '2nd Signatory';
        V3rd_SignatoryCaptionLbl: label '3rd Signatory';
        Loan_TypeCaptionLbl: label 'Loan Type';
        PeriodCaptionLbl: label 'Period';
        Member_No_CaptionLbl: label 'Member No.';
        NameCaptionLbl: label 'Name';
        Staff_No_CaptionLbl: label 'Staff No.';
        Approved_AmountCaptionLbl: label 'Approved Amount';
        Bridged_Commitements_CaptionLbl: label 'Bridged Commitements ';
        Requested_AmountCaptionLbl: label 'Requested Amount';
        AcknowledgementCaptionLbl: label 'Acknowledgement';
        Commision: Decimal;
        LoanTopup: Record "Loan Offset Details";
        TotalRefinance: Decimal;
        TotalDeductions: Decimal;
        NetAmount: Decimal;
        InterestTopUp: Decimal;
        TotalDed: Decimal;
        TotalNetAmount: Decimal;
        TotalDedAmount: Decimal;
        TotalIntAmount: Decimal;
        TotalRefAmount: Decimal;
        "Total 6%": Decimal;
        "Total 2.5%": Decimal;
        TotalReq: Decimal;
        CompInfo: Record "Company Information";
        PCharges: Record "Loan Product Charges";
        Upcomm: Decimal;
        EarlyRelease: Decimal;
        InsuranceCom: Decimal;
        LCharges: Decimal;
        TopUpCom: Decimal;
        PrincipleTopUp: Decimal;
        LFees: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        SchCharge: Decimal;
        ShareCharge: Decimal;
        NetLoan: Decimal;
        DepositDeduct: Decimal;
        TotalTopUp: Decimal;
        MemDeposit: Decimal;
        LoanType: Record "Loan Products Setup";
        GenSetUpS: Record "Sacco General Set-Up";
        Upfronts: Decimal;
        JazaLevy: Decimal;
        Reistement: Decimal;
        BRIGEDAMOUNT: Decimal;
        Netdisbursed: Decimal;
        BridgeLevy: Decimal;
        LoanProdType: Record "Loan Products Setup";
        TotalUpfronts: Decimal;
        TotalNetPay: Decimal;
        TBridgeLevy: Decimal;
        InstInterest: Decimal;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516485_v6_3_0_2259;
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
