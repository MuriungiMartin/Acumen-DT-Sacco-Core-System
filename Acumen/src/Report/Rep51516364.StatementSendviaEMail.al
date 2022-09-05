#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516364_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516364 "Statement Send via E-Mail"
{
    UseSystemPrinter = true;
    RDLCLayout = './Layouts/StatementSendviaE-Mail.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.") where("Customer Posting Group" = const('MEMBER'), Status = const(Active));
            RequestFilterFields = "No.", "Outstanding Balance", "Date Filter";
            column(ReportForNavId_7301; 7301) { } // Autogenerated by ForNav - Do not delete
            column(Members__No__; Customer."No.")
            {
            }
            column(Members_Name; Customer.Name)
            {
            }
            trigger OnPreDataItem();
            begin
                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            var
                Recipient: list of [Text];
            begin
                //This report should print to Adobe Printer[The customer Statment]
                //Adobe printer setup should print without opening report
                //Set the Printer properties accordingly on Adobe printer
                //Use the Printer setup in navision to ensure that for the user allowed
                //to send the mail the report is redirected to print in the PDF printer.
                Customer.TestField("E-Mail");
                UserSetup.Get(UserId);
                UserSetup.TestField("E-Mail");
                CUST.Reset;
                CUST.SetRange(CUST."No.", Customer."No.");
                CUST.SetFilter(CUST."Date Filter", Customer.GetFilter("Date Filter"));
                if CUST.Find('-') then
                    Report.Run(51516223, false, false, CUST);
                //Create Delay because sometimes the PDF printer could be slow
                ElapsedTime := 0;
                Time1 := Time;
                repeat
                    Time2 := Time;
                    ElapsedTime := Time2 - Time1;
                until ElapsedTime > 40 * 1000;
                Recipient.Add(Customer."E-Mail");
                //Create the Message Here
                //Email Address used is the one on UserSetup for Sender and Customer Card Email for Receipient
                SMTP.CreateMessage(COMPANYNAME, UserSetup."E-Mail", Recipient, Text001, Text000, false);
                //Add the attachment Here
                //Note the path is predefined in the pdf Printer so the path and report name should be
                //entered as below or use a setup. for this case the pdf printer saves using the name of the report C:\Users\Franc\Documents\Member Statement.pdf
                //SMTP.AddAttachment('C:\Member Statement.pdf');
                //SMTP.AddAttachment('C:\Users\administrator\Documents\Member Statement.pdf');
                // C:\Users\rwaweru\Documents\Member Statement.pdf
                //Call the Send function
                SMTP.Send;
                Message('Email sent Successful');
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
        OpeningBal: Decimal;
        ClosingBal: Decimal;
        FirstRec: Boolean;
        PrevBal: Integer;
        CompanyInfo: Record "Company Information";
        "1Month": Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        AsAt: Date;
        LastDueDate: Date;
        DFormula: DateFormula;
        Arrears: Decimal;
        T1Month: Decimal;
        T2Month: Decimal;
        T3Month: Decimal;
        T4Month: Decimal;
        "GEN-SET UP": Record "Sacco General Set-Up";
        CUST: Record Customer;
        ElapsedTime: Integer;
        Time1: Time;
        Time2: Time;
        SMTP: Codeunit "SMTP Mail";
        UserSetup: Record "User Setup";
        Text000: label 'Please find Attached your Statement from  Kencream Sacco.';
        Text001: label 'Your Statement';

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516364_v6_3_0_2259;
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
