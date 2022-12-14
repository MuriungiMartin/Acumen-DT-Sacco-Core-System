#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport50001_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50001 "Update Accounts"
{
    RDLCLayout = './Layouts/UpdateAccounts.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            trigger OnAfterGetRecord();
            begin
                /*
				ObjCust.RESET;
				ObjCust.SETRANGE(ObjCust."No.",Vendor."BOSA Account No");
				IF ObjCust.FIND('-') THEN
				BEGIN
				 ObjCust."FOSA Account":=Vendor."No.";
				 ObjCust."FOSA Account No.":=Vendor."No.";
				 ObjCust."Employment Info":=ObjCust."Employment Info"::Employed;
				 ObjCust.VALIDATE("Employer Code");
				 ObjCust.VALIDATE(ObjCust.Department);
				 ObjCust.MODIFY;
				END;
				*/
                ObjCust.Reset;
                ObjCust.SetRange(ObjCust."No.", "BOSA Account No");
                if ObjCust.FindSet then begin
                    /* Vendor."ID No.":=ObjCust."ID No.";
                     Vendor."Mobile Phone No":=ObjCust."Mobile Phone No";
                    Vendor."E-Mail":=ObjCust."E-Mail";
                     ObjCust."Employment Info":=ObjCust."Employment Info"::Employed;
                     ObjCust."Employer Code":=Vendor."Employer Code";*/
                    Vendor.CalcFields("Picture 2", "Signature  2");
                    ObjCust.CalcFields("Picture 2", "Signature  2");
                    Vendor."Picture 2" := ObjCust."Picture 2";
                    Vendor."Signature  2" := ObjCust."Signature  2";
                    Vendor.Modify;
                end;
                /*
				ObjAccountTypes.RESET;
				ObjAccountTypes.SETRANGE(ObjAccountTypes.Code,"Account Type");
				IF ObjAccountTypes.FINDSET THEN
				BEGIN
				Vendor."Vendor Posting Group":=ObjAccountTypes."Posting Group";
				Vendor."Mobile Phone No":=Vendor."Phone No.";
				Vendor.VALIDATE("Vendor Posting Group");
				Vendor.VALIDATE("VAT Bus. Posting Group");
				Vendor.VALIDATE("VAT Registration No.");
				Vendor.MODIFY;
				END;
				*/

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
        ObjAccountTypes: Record "Buffer 2016-b";
        ObjCust: Record Customer;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport50001_v6_3_0_2259;
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
