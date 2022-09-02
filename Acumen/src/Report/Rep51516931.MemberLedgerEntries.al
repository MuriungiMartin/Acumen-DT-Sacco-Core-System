#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516931_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516931 "Member Ledger Entries"
{
    PreviewMode = PrintLayout;
    RDLCLayout = './Layouts/MemberLedgerEntries.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            column(Amount_MemberLedgerEntry; "Cust. Ledger Entry".Amount)
            {
            }
            column(UserID_MemberLedgerEntry; "Cust. Ledger Entry"."User ID")
            {
            }
            column(TransactionType_MemberLedgerEntry; "Cust. Ledger Entry"."Transaction Type")
            {
            }
            column(LoanNo_MemberLedgerEntry; "Cust. Ledger Entry"."Loan No")
            {
            }
            column(EntryNo_MemberLedgerEntry; "Cust. Ledger Entry"."Entry No.")
            {
            }
            column(CustomerNo_MemberLedgerEntry; "Cust. Ledger Entry"."Customer No.")
            {
            }
            column(PostingDate_MemberLedgerEntry; "Cust. Ledger Entry"."Posting Date")
            {
            }
            column(DocumentType_MemberLedgerEntry; "Cust. Ledger Entry"."Document Type")
            {
            }
            column(DocumentNo_MemberLedgerEntry; "Cust. Ledger Entry"."Document No.")
            {
            }
            column(Description_MemberLedgerEntry; "Cust. Ledger Entry".Description)
            {
            }
            column(Reversed_MemberLedgerEntry; "Cust. Ledger Entry".Reversed)
            {
            }
            column(DebitAmount_MemberLedgerEntry; "Cust. Ledger Entry"."Debit Amount")
            {
            }
            column(CreditAmount_MemberLedgerEntry; "Cust. Ledger Entry"."Credit Amount")
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
        MeetingsMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Meeting Notification</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that you have a scheduled meeting with %2  on  %3  at %4,</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%5</p><p><b>KINGDOM SACCO LTD</b></p>';
        Memb: Record "Membership Applications";
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        ObjMeetings: Record "Meetings Schedule";
        VarNoticeDate: Date;
        ObjHouseGroups: Record "Member House Groups";
        VarGroupName: Code[80];
        Company: Record "Company Information";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516931_v6_3_0_2259;
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
