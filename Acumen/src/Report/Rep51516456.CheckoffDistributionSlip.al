#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516456_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516456 "Checkoff Distribution Slip"
{
    RDLCLayout = './Layouts/CheckoffDistributionSlip.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            CalcFields = Picture;
            column(ReportForNavId_15; 15) { } // Autogenerated by ForNav - Do not delete
            column(Name_CompanyInformation; "Company Information".Name)
            {
            }
            column(Name2_CompanyInformation; "Company Information"."Name 2")
            {
            }
            column(Address_CompanyInformation; "Company Information".Address)
            {
            }
            column(City_CompanyInformation; "Company Information".City)
            {
            }
            column(PhoneNo_CompanyInformation; "Company Information"."Phone No.")
            {
            }
            column(Picture_CompanyInformation; "Company Information".Picture)
            {
            }
            dataitem(Customer; Customer)
            {
                RequestFilterFields = "No.";
                column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
                column(No_MembersRegister; Customer."No.")
                {
                }
                column(Name_MembersRegister; Customer.Name)
                {
                }
                dataitem("Checkoff Processing Details(B)"; "Checkoff Processing Details(B)")
                {
                    DataItemLink = "Member No" = field("No.");
                    RequestFilterFields = "Check Off No";
                    column(ReportForNavId_4; 4) { } // Autogenerated by ForNav - Do not delete
                    column(CheckOffNo_CheckoffProcessingDetailsB; "Checkoff Processing Details(B)"."Check Off No")
                    {
                    }
                    column(CheckOffAdviceNo_CheckoffProcessingDetailsB; "Checkoff Processing Details(B)"."Check Off Advice No")
                    {
                    }
                    column(CheckOffDate_CheckoffProcessingDetailsB; "Checkoff Processing Details(B)"."Check Off Date")
                    {
                    }
                    column(MemberNo_CheckoffProcessingDetailsB; "Checkoff Processing Details(B)"."Member No")
                    {
                    }
                    column(TransactionType_CheckoffProcessingDetailsB; "Checkoff Processing Details(B)"."Transaction Type")
                    {
                    }
                    column(LoanProduct_CheckoffProcessingDetailsB; "Checkoff Processing Details(B)"."Loan Product")
                    {
                    }
                    column(LoanNo_CheckoffProcessingDetailsB; "Checkoff Processing Details(B)"."Loan No")
                    {
                    }
                    column(Amount_CheckoffProcessingDetailsB; "Checkoff Processing Details(B)".Amount)
                    {
                    }
                    column(OutstandingBalance_CheckoffProcessingDetailsB; "Checkoff Processing Details(B)"."Outstanding Balance")
                    {
                    }
                    column(OutstandingInterest_CheckoffProcessingDetailsB; "Checkoff Processing Details(B)"."Outstanding Interest")
                    {
                    }
                }
            }
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

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516456_v6_3_0_2259;
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
