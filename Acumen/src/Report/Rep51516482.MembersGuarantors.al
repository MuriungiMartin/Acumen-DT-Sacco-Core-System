#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516482_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516482 "Members Guarantors"
{
    RDLCLayout = './Layouts/MembersGuarantors.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", Name;
            column(ReportForNavId_1000000000; 1000000000) { } // Autogenerated by ForNav - Do not delete
            column(No_Members; Customer."No.")
            {
            }
            column(Name_Members; Customer.Name)
            {
            }
            column(PhoneNo_Members; Customer."Phone No.")
            {
            }
            column(OutstandingBalance_Members; Customer."Outstanding Balance")
            {
            }
            column(FNo; FNo)
            {
            }
            dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
            {
                DataItemLink = "Loanees  No" = field("No.");
                DataItemTableView = where("Outstanding Balance" = filter(<> 0), Substituted = filter(false));
                RequestFilterFields = "Member No", "Loan No";
                column(ReportForNavId_1000000001; 1000000001) { } // Autogenerated by ForNav - Do not delete
                column(AmontGuaranteed_LoanGuarantors; "Loans Guarantee Details"."Amont Guaranteed")
                {
                }
                column(NoOfLoansGuaranteed_LoanGuarantors; "Loans Guarantee Details"."No Of Loans Guaranteed")
                {
                }
                column(Name_LoanGuarantors; "Loans Guarantee Details".Name)
                {
                }
                column(MemberNo_LoanGuarantors; "Loans Guarantee Details"."Member No")
                {
                }
                column(LoanNo_LoanGuarantors; "Loans Guarantee Details"."Loan No")
                {
                }
                column(No; no)
                {
                }
                column(OutStandingBal; "Loans Guarantee Details"."Outstanding Balance")
                {
                }
                column(TotalOutstandingBal; TotalOutstandingBal)
                {
                }
                column(EmployerCode; EmployerCode)
                {
                }
                trigger OnAfterGetRecord();
                begin
                    //Loan.GET();
                    Loansr.Reset;
                    Loansr.SetRange(Loansr."Loan  No.", "Loan No");
                    if Loansr.Find('-') then //BEGIN
                        MemberNo := Loansr."Client Code";
                    MemberName := Loansr."Client Name";
                    EmployerCode := Loansr."Employer Code"
                    //END;
                end;

            }
            trigger OnPreDataItem();
            begin
                LastFieldNo := FieldNo("No.");
            end;

            trigger OnAfterGetRecord();
            begin
                //Members.CALCFIELDS(Members."Outstanding Balance",Members."Current Shares",Members."Loans Guaranteed");
                //AvailableSH:=Members."Current Shares"-Members."Loans Guaranteed";
                FNo := FNo + 1;
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        AvailableSH: Decimal;
        MemberNo: Text;
        MemberName: Text;
        EmployerCode: Text;
        Loansr: Record "Loans Register";
        no: Integer;
        TotalOutstandingBal: Decimal;
        OutStandingBal: Decimal;
        FNo: Integer;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516482_v6_3_0_2259;
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
