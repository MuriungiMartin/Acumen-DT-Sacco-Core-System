#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516475_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516475 "CheckOff Advice"
{
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/CheckOffAdvice.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(ReportForNavId_1000000000; 1000000000) { } // Autogenerated by ForNav - Do not delete
            trigger OnAfterGetRecord();
            begin
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Client Code", Customer."No.");
                LoansRec.SetRange(LoansRec."Loan Product Type", 'NORMAL');
                if LoansRec.Find('-') then begin
                    if LoansRec."Outstanding Balance" > 0 then begin
                        NormPr := LoansRec."Loan Principle Repayment";
                        NormInt := LoansRec."Loan Interest Repayment";
                    end;
                end;
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Client Code", Customer."No.");
                LoansRec.SetRange(LoansRec."Loan Product Type", 'EMERGENCY');
                if LoansRec.Find('-') then begin
                    if LoansRec."Outstanding Balance" > 0 then begin
                        EmerPr := LoansRec."Loan Principle Repayment";
                        EmerInt := LoansRec."Loan Interest Repayment";
                    end;
                end;
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Client Code", Customer."No.");
                LoansRec.SetRange(LoansRec."Loan Product Type", 'COLLEGE');
                if LoansRec.Find('-') then begin
                    if LoansRec."Outstanding Balance" > 0 then begin
                        CollegePr := LoansRec."Loan Principle Repayment";
                        CollegeInt := LoansRec."Loan Interest Repayment";
                    end;
                end;
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Client Code", Customer."No.");
                LoansRec.SetRange(LoansRec."Loan Product Type", 'TOP - UP');
                if LoansRec.Find('-') then begin
                    if LoansRec."Outstanding Balance" > 0 then begin
                        TopupPr := LoansRec."Loan Principle Repayment";
                        Topupint := LoansRec."Loan Interest Repayment";
                    end;
                end;
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Client Code", Customer."No.");
                LoansRec.SetRange(LoansRec."Loan Product Type", 'School');
                if LoansRec.Find('-') then begin
                    if LoansRec."Outstanding Balance" > 0 then begin
                        SchoolPr := LoansRec."Loan Principle Repayment";
                        SchoolInt := LoansRec."Loan Interest Repayment";
                    end;
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
        LoansRec: Record "Loans Register";
        NormPr: Decimal;
        NormInt: Decimal;
        EmerPr: Decimal;
        EmerInt: Decimal;
        SchoolPr: Decimal;
        SchoolInt: Decimal;
        TopupPr: Decimal;
        Topupint: Decimal;
        CollegePr: Decimal;
        CollegeInt: Decimal;
        DefaulterPr: Decimal;
        DefaulterInt: Decimal;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516475_v6_3_0_2259;
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
