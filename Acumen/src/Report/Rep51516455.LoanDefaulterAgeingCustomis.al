#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516455_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516455 "Loan Defaulter Ageing Customis"
{
    RDLCLayout = './Layouts/LoanDefaulterAgeingCustomis.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where(Posted = filter(true), "Outstanding Balance" = filter(<> 0));
            column(ReportForNavId_1000000000; 1000000000) { } // Autogenerated by ForNav - Do not delete
            column(CompanyName; ObjCompany.Name)
            {
            }
            column(CompanyPicture; ObjCompany.Picture)
            {
            }
            column(CompanyEmail; ObjCompany."E-Mail")
            {
            }
            column(CompanyWebsite; ObjCompany."Home Page")
            {
            }
            column(CompanyAddress; ObjCompany.Address)
            {
            }
            column(CompanyPhoneNumber; ObjCompany."Phone No.")
            {
            }
            column(LoanNo_LoansRegister; "Loans Register"."Loan  No.")
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Client Code")
            {
            }
            column(ClientName_LoansRegister; "Loans Register"."Client Name")
            {
            }
            column(IssuedDate_LoansRegister; "Loans Register"."Issued Date")
            {
            }
            column(Installments_LoansRegister; "Loans Register".Installments)
            {
            }
            column(LoanProductType_LoansRegister; "Loans Register"."Loan Product Type")
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(PrevMonthDate; PrevMonthDate)
            {
            }
            column(ScheduledBalance; ScheduledBalance)
            {
            }
            column(LoanBalance; LoanBalance)
            {
            }
            column(LoanArrears; LoanArrears)
            {
            }
            column(PeriodArrears; PeriodArrears)
            {
            }
            column(Class; Class)
            {
            }
            column(Performing; "Loans Register".Performing)
            {
            }
            column(Watch; "Loans Register".Watch)
            {
            }
            column(Substandard; "Loans Register".Substandard)
            {
            }
            column(doubtful; doubtful)
            {
            }
            column(Loss; "Loans Register".Loss)
            {
            }
            trigger OnAfterGetRecord();
            begin
                // PrevMonthDate := CUSurefactory.FnGetPreviousMonthLastDate("Loans Register"."Loan  No.", AsAt);
                // ScheduledBalance := CUSurefactory.FnGetScheduledExpectedBalance("Loans Register"."Loan  No.", PrevMonthDate);
                // LoanBalance := CUSurefactory.FnGetLoanBalance("Loans Register"."Loan  No.", PrevMonthDate);
                // LoanArrears := CUSurefactory.FnCalculateLoanArrears(ScheduledBalance, LoanBalance, AsAt, "Loans Register"."Expected Date of Completion");
                // PeriodArrears := CUSurefactory.FnCalculatePeriodInArrears(LoanArrears, "Loans Register".Repayment, AsAt, "Loans Register"."Expected Date of Completion");
                // Class := CUSurefactory.FnClassifyLoans("Loans Register"."Loan  No.", PeriodArrears, LoanArrears);
                // Performing := 0;
                // Watch := 0;
                // Substandard := 0;
                // doubtful := 0;
                // Loss := 0;
                // case Class of
                //     Class::"1":
                //         Performing := LoanBalance;
                //     Class::"2":
                //         Watch := LoanBalance;
                //     Class::"3":
                //         Substandard := LoanBalance;
                //     Class::"4":
                //         doubtful := LoanBalance;
                //     Class::"5":
                //         Loss := LoanBalance;
                // end;
                // if (Performing = 0) and (Watch = 0) and (Substandard = 0) and (doubtful = 0) and (Loss = 0) then
                //     CurrReport.Skip;
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
        ObjCompany.Get;
        ObjCompany.CalcFields(ObjCompany.Picture);
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
        CUSurefactory: Codeunit "SURESTEP Factory.";
        AsAt: Date;
        PrevMonthDate: Date;
        ScheduledBalance: Decimal;
        LoanBalance: Decimal;
        LoanArrears: Decimal;
        PeriodArrears: Decimal;
        Class: Integer;
        Category: Code[15];
        Performing: Decimal;
        Watch: Decimal;
        Substandard: Decimal;
        doubtful: Decimal;
        Loss: Decimal;
        ObjCompany: Record "Company Information";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516455_v6_3_0_2259;
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
