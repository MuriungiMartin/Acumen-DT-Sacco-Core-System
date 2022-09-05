#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516424_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516424 "Registration Fee Transfer"
{
    RDLCLayout = './Layouts/RegistrationFeeTransfer.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Customer Posting Group" = const('BOSA'));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", "Date Filter";
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
            column(UserId; UserId)
            {
            }
            trigger OnPreDataItem();
            begin
                /*
				PvApp.RESET;
				PvApp.SETRANGE(PvApp."User ID",USERID);
				PvApp.SETFILTER(PvApp.Status,'Deposit Trans');
				IF PvApp.FIND('-')= FALSE THEN BEGIN
				ERROR('You Are Not Allowed To Carry Out This Process');
				END;
				*/
                //delete journal line
                Gnljnline.Reset;
                Gnljnline.SetRange("Journal Template Name", 'General');
                Gnljnline.SetRange("Journal Batch Name", 'Entrance');
                Gnljnline.DeleteAll;
                //end of deletion
                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name", 'General');
                GenBatches.SetRange(GenBatches.Name, 'Entrance');
                if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name" := 'General';
                    GenBatches.Name := 'Entrance';
                    GenBatches.Description := 'Transfer of Registration Fee from member account';
                    GenBatches.Validate(GenBatches."Journal Template Name");
                    GenBatches.Validate(GenBatches.Name);
                    GenBatches.Insert;
                end;

            end;

            trigger OnAfterGetRecord();
            begin
                RunBal := 0;
                //EVALUATE(PDate,'T');
                Cust.Reset;
                Cust.SetRange(Cust."No.", Customer."No.");
                if Cust.Find('-') then begin
                    Cust.CalcFields(Cust."Registration Fee");
                    RunBal := Abs(Cust."Registration Fee");
                    if (RunBal > 0) then begin
                        LineN := LineN + 10000;
                        Gnljnline.Init;
                        Gnljnline."Journal Template Name" := 'General';
                        Gnljnline."Journal Batch Name" := 'Entrance';
                        Gnljnline."Line No." := LineN;
                        Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                        Gnljnline."Account No." := Cust."No.";
                        Gnljnline.Validate(Gnljnline."Account No.");
                        Gnljnline."Document No." := 'ENTFEE';
                        Gnljnline."Posting Date" := PDate;
                        Gnljnline.Description := 'Transfer Entfee to Income Account';
                        Gnljnline.Amount := RunBal;
                        Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                        Gnljnline.Validate(Gnljnline.Amount);
                        Gnljnline.Status := Gnljnline.Status::Approved;
                        Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Registration Fee";
                        if Gnljnline.Amount <> 0 then
                            Gnljnline.Insert;
                        LineN := LineN + 10000;
                        Gnljnline.Init;
                        Gnljnline."Journal Template Name" := 'General';
                        Gnljnline."Journal Batch Name" := 'Entrance';
                        Gnljnline."Line No." := LineN;
                        Gnljnline."Account Type" := Gnljnline."bal. account type"::"G/L Account";
                        Gnljnline."Account No." := GAccount;
                        Gnljnline.Validate(Gnljnline."Account No.");
                        Gnljnline."Document No." := 'ENTFEE';
                        Gnljnline."Posting Date" := PDate;
                        Gnljnline.Amount := -RunBal;
                        Gnljnline.Description := 'Transfer Entfee to Income Account';
                        Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                        Gnljnline.Validate(Gnljnline.Amount);
                        Gnljnline.Status := Gnljnline.Status::Approved;
                        if Gnljnline.Amount <> 0 then
                            Gnljnline.Insert;
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
                field(Posting_Date; PDate)
                {
                    ApplicationArea = Basic;
                }
                field(Income_Account; GAccount)
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
        Gnljnline: Record "Gen. Journal Line";
        GenBatches: Record "Gen. Journal Batch";
        GenSetUp: Record "Dividends Progression";
        PDate: Date;
        LoanType: Record "Loan Products Setup";
        PostDate: Date;
        Cust: Record Customer;
        datefilter: Date;
        RunBal: Decimal;
        LineN: Integer;
        RunBal2: Decimal;
        DocNo: Text[60];
        GAccount: Code[20];

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516424_v6_3_0_2259;
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
