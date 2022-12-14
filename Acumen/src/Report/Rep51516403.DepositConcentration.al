#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516403_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516403 "Deposit Concentration"
{
    RDLCLayout = './Layouts/DepositConcentration.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loan Products Setup"; "Loan Products Setup")
        {
            column(ReportForNavId_1000000000; 1000000000) { } // Autogenerated by ForNav - Do not delete
            column(LessTenthousand; LessTenthousand)
            {
            }
            column(LessTenthousandCount; LessTenthousandCount)
            {
            }
            column(Less20thousand; Less20thousand)
            {
            }
            column(Less20thousandCount; Less20thousandCount)
            {
            }
            column(Less50thousand; Less50thousand)
            {
            }
            column(Less50thousandCount; Less50thousandCount)
            {
            }
            column(Less100thousand; Less100thousand)
            {
            }
            column(Less100thousandCount; Less100thousandCount)
            {
            }
            column(Greaterthousand; Greaterthousand)
            {
            }
            column(GreaterthousandCount; GreaterthousandCount)
            {
            }
            column(int_10; "10perInt")
            {
            }
            column(Int_20; "20perInt")
            {
            }
            column(int_50; "50perInt")
            {
            }
            column(int_100; "100perInt")
            {
            }
            column(GreaterperInt; GreaterperInt)
            {
            }
            column(dec_10; "10perDec")
            {
            }
            column(dec_20; "20perDec")
            {
            }
            column(dec_50; "50perDec")
            {
            }
            column(dec_100; "100perDec")
            {
            }
            column(GreaterperDec; GreaterperDec)
            {
            }
            column(TotalInt; TotalInt)
            {
            }
            column(TotalDec; TotalDec)
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
            column(UserId; UserId)
            {
            }
            trigger OnAfterGetRecord();
            begin
                LessTenthousand := 0;
                LessTenthousandCount := 0;
                Less20thousand := 0;
                Less20thousandCount := 0;
                Less50thousand := 0;
                Less50thousandCount := 0;
                Less100thousand := 0;
                Less100thousandCount := 0;
                Greaterthousand := 0;
                GreaterthousandCount := 0;
                "10perInt" := 0;
                "20perInt" := 0;
                "50perInt" := 0;
                "100perInt" := 0;
                GreaterperInt := 0;
                "10perDec" := 0;
                "20perDec" := 0;
                "50perDec" := 0;
                "100perDec" := 0;
                GreaterperDec := 0;
                TotalInt := 0;
                TotalDec := 0;
                PerTotalInt := 0;
                PertotalDec := 0;
                LoanBal := 0;
                Cust.Reset;
                Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                if Cust.Find('-') then begin
                    repeat
                        Cust.CalcFields(Cust."Current Shares");
                        LoanBal := Cust."Current Shares" * -1;
                        if LoanBal > 0 then begin
                            if LoanBal <= 250000 then begin
                                LessTenthousandCount := LessTenthousandCount + 1;
                                LessTenthousand := LessTenthousand + LoanBal;
                            end;
                            if (LoanBal > 250001) and (LoanBal <= 500000) then begin
                                Less20thousandCount := Less20thousandCount + 1;
                                Less20thousand := Less20thousand + LoanBal;
                            end;
                            if (LoanBal > 500001) and (LoanBal <= 750000) then begin
                                Less50thousandCount := Less50thousandCount + 1;
                                Less50thousand := Less50thousand + LoanBal;
                            end;
                            if (LoanBal > 750001) and (LoanBal <= 1000000) then begin
                                Less100thousandCount := Less100thousandCount + 1;
                                Less100thousand := Less100thousand + LoanBal;
                            end;
                            if LoanBal > 1000000 then begin
                                GreaterthousandCount := GreaterthousandCount + 1;
                                Greaterthousand := Greaterthousand + LoanBal;
                            end;
                        end;
                    until Cust.Next = 0;
                end;
                TotalDec := TotalDec + LessTenthousand + Less20thousand + Less50thousand + Less100thousand + Greaterthousand;
                TotalInt := GreaterperInt + LessTenthousandCount + Less20thousandCount + Less50thousandCount + Less100thousandCount +
                               GreaterthousandCount;
                if TotalDec <> 0 then begin
                    "10perDec" := ROUND((LessTenthousand / TotalDec) * 100, 1);
                    "20perDec" := ROUND((Less20thousand / TotalDec) * 100, 1);
                    "50perDec" := ROUND((Less50thousand / TotalDec) * 100, 1);
                    "100perDec" := ROUND((Less100thousand / TotalDec) * 100, 1);
                    GreaterperDec := ROUND((Greaterthousand / TotalDec) * 100, 1);
                end;
                if TotalInt <> 0 then begin
                    "10perInt" := ROUND((LessTenthousandCount / TotalInt) * 100, 1);
                    "20perInt" := ROUND((Less20thousandCount / TotalInt) * 100, 1);
                    "50perInt" := ROUND((Less50thousandCount / TotalInt) * 100, 1);
                    "100perInt" := ROUND((Less100thousandCount / TotalInt) * 100, 1);
                    GreaterperInt := ROUND((GreaterthousandCount / TotalInt) * 100, 1);
                end;
                PerTotalInt := "10perInt" + "20perInt" + "50perInt" + "100perInt" + GreaterperInt;
                PertotalDec := "10perDec" + "20perDec" + "50perDec" + "100perDec" + GreaterperDec;
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
        ;
        ReportsForNavPre;
    end;

    var
        Company: Record "Company Information";
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        LessTenthousand: Decimal;
        LessTenthousandCount: Integer;
        Less20thousand: Decimal;
        Less20thousandCount: Integer;
        Less50thousand: Decimal;
        Less50thousandCount: Integer;
        Less100thousand: Decimal;
        Less100thousandCount: Integer;
        Greaterthousand: Decimal;
        GreaterthousandCount: Integer;
        Cust: Record Customer;
        FromDate: Date;
        ToDate: Date;
        "10perInt": Integer;
        "20perInt": Integer;
        "50perInt": Integer;
        "100perInt": Integer;
        GreaterperInt: Integer;
        "10perDec": Decimal;
        "20perDec": Decimal;
        "50perDec": Decimal;
        "100perDec": Decimal;
        GreaterperDec: Decimal;
        TotalInt: Integer;
        TotalDec: Decimal;
        PerTotalInt: Integer;
        PertotalDec: Integer;
        LoanBal: Decimal;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516403_v6_3_0_2259;
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
