#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516177_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516177 "HR Exit Interview"
{
    RDLCLayout = './Layouts/HRExitInterview.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("HR Employee Exit Interviews"; "HR Employee Exit Interviews")
        {
            RequestFilterFields = "Exit Interview No";
            column(ReportForNavId_6075; 6075) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; Format(ReportForNav.PageNo))
            {
            }
            column(UserId; UserId)
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(HR_Employee_Exit_Interviews__Employee_No__; "HR Employee Exit Interviews"."Employee No.")
            {
            }
            column(HR_Employee_Exit_Interviews__Date_Of_Interview_; "HR Employee Exit Interviews"."Date Of Interview")
            {
            }
            column(HR_Employee_Exit_Interviews__Interview_Done_By_; "HR Employee Exit Interviews"."Interview Done By")
            {
            }
            column(HR_Employee_Exit_Interviews__Date_Of_Leaving_; "HR Employee Exit Interviews"."Date Of Leaving")
            {
            }
            column(HR_Employee_Exit_Interviews__Reason_For_Leaving_; "HR Employee Exit Interviews"."Reason For Leaving")
            {
            }
            column(HR_Employee_Exit_Interviews__Reason_For_Leaving__Other__; "Reason For Leaving (Other)")
            {
            }
            column(HR_Employee_Exit_Interviews__Exit_Interview_No_; "HR Employee Exit Interviews"."Exit Interview No")
            {
            }
            column(HR_Employee_Exit_InterviewsCaption; HR_Employee_Exit_InterviewsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Exit_Interview_ChecklistCaption; Exit_Interview_ChecklistCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(HR_Employee_Exit_Interviews__Employee_No__Caption; FieldCaption("Employee No."))
            {
            }
            column(HR_Employee_Exit_Interviews__Date_Of_Interview_Caption; FieldCaption("Date Of Interview"))
            {
            }
            column(HR_Employee_Exit_Interviews__Exit_Interview_No_Caption; FieldCaption("Exit Interview No"))
            {
            }
            column(HR_Employee_Exit_Interviews__Interview_Done_By_Caption; FieldCaption("Interview Done By"))
            {
            }
            column(HR_Employee_Exit_Interviews__Date_Of_Leaving_Caption; FieldCaption("Date Of Leaving"))
            {
            }
            column(HR_Employee_Exit_Interviews__Reason_For_Leaving_Caption; FieldCaption("Reason For Leaving"))
            {
            }
            column(HR_Employee_Exit_Interviews__Reason_For_Leaving__Other__Caption; FieldCaption("Reason For Leaving (Other)"))
            {
            }
            dataitem("Misc. Article Information"; "Misc. Article Information")
            {
                DataItemLink = "Employee No." = field("Employee No.");
                DataItemTableView = sorting("Employee No.", "Misc. Article Code", "Line No.");
                column(ReportForNavId_4668; 4668) { } // Autogenerated by ForNav - Do not delete
                column(Misc__Article_Information__Misc__Article_Code_; "Misc. Article Information"."Misc. Article Code")
                {
                }
                column(Misc__Article_Information_Description; "Misc. Article Information".Description)
                {
                }
                // column(Misc__Article_Information_Returned; Returned)
                // {
                // }
                // column(Misc__Article_Information__Date_Returned_; "Date Returned")
                // {
                // }
                // column(Misc__Article_Information__Status_On_Return_; "Status On Return")
                // {
                // }
                // column(Misc__Article_Information_Recommendations; Recommendations)
                // {
                // }
                // column(Misc__Article_Information__Received_By_; "Received By")
                // {
                // }
                column(Misc__Article_Information__Misc__Article_Code_Caption; FieldCaption("Misc. Article Code"))
                {
                }
                column(Misc__Article_Information_DescriptionCaption; FieldCaption(Description))
                {
                }
                // column(Misc__Article_Information_ReturnedCaption; FieldCaption(Returned))
                // {
                // }
                // column(Misc__Article_Information__Status_On_Return_Caption; FieldCaption("Status On Return"))
                // {
                // }
                // column(Misc__Article_Information__Date_Returned_Caption; FieldCaption("Date Returned"))
                // {
                // }
                // column(Misc__Article_Information_RecommendationsCaption; FieldCaption(Recommendations))
                // {
                // }
                column(Misc__Articles_Clearance_Caption; Misc__Articles_Clearance_CaptionLbl)
                {
                }
                // column(Misc__Article_Information__Received_By_Caption; FieldCaption("Received By"))
                // {
                // }
                column(Misc__Article_Information_Employee_No_; "Misc. Article Information"."Employee No.")
                {
                }
                column(Misc__Article_Information_Line_No_; "Misc. Article Information"."Line No.")
                {
                }
            }
            dataitem("HR Exit Interview Checklist"; "HR Exit Interview Checklist")
            {
                DataItemLink = "Employee No" = field("Employee No.");
                DataItemTableView = sorting("Exit Interview No", "Line No");
                column(ReportForNavId_9118; 9118) { } // Autogenerated by ForNav - Do not delete
                column(HR_Exit_Interview_Checklist__Clearance_Date_; "HR Exit Interview Checklist"."Clearance Date")
                {
                }
                column(HR_Exit_Interview_Checklist__CheckList_Item_; "HR Exit Interview Checklist"."CheckList Item")
                {
                }
                column(HR_Exit_Interview_Checklist_Cleared; "HR Exit Interview Checklist".Cleared)
                {
                }
                column(HR_Exit_Interview_Checklist__Cleared_By_; "HR Exit Interview Checklist"."Cleared By")
                {
                }
                column(HR_Exit_Interview_Checklist__Clearance_Date_Caption; FieldCaption("Clearance Date"))
                {
                }
                column(HR_Exit_Interview_Checklist__CheckList_Item_Caption; FieldCaption("CheckList Item"))
                {
                }
                column(HR_Exit_Interview_Checklist_ClearedCaption; FieldCaption(Cleared))
                {
                }
                column(Departmental_Clearance_Caption; Departmental_Clearance_CaptionLbl)
                {
                }
                column(HR_Exit_Interview_Checklist__Cleared_By_Caption; FieldCaption("Cleared By"))
                {
                }
                column(HR_Exit_Interview_Checklist_Exit_Interview_No; "HR Exit Interview Checklist"."Exit Interview No")
                {
                }
                column(HR_Exit_Interview_Checklist_Line_No; "HR Exit Interview Checklist"."Line No")
                {
                }
                column(HR_Exit_Interview_Checklist_Employee_No; "HR Exit Interview Checklist"."Employee No")
                {
                }
                dataitem("User Setup"; "User Setup")
                {
                    DataItemLink = "User ID" = field("Cleared By");
                    DataItemTableView = sorting("User ID");
                    column(ReportForNavId_7968; 7968) { } // Autogenerated by ForNav - Do not delete
                    column(SignatureCaption; SignatureCaptionLbl)
                    {
                    }
                    column(User_Setup_User_ID; "User Setup"."User ID")
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
        CI.Get();
        CI.CalcFields(CI.Picture);
        ;
        ReportsForNavPre;
    end;

    var
        CI: Record "Company Information";
        HR_Employee_Exit_InterviewsCaptionLbl: label 'HR Employee Exit Interviews';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Exit_Interview_ChecklistCaptionLbl: label 'Exit Interview Checklist';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        Misc__Articles_Clearance_CaptionLbl: label 'Misc. Articles Clearance:';
        Departmental_Clearance_CaptionLbl: label 'Departmental Clearance:';
        SignatureCaptionLbl: label 'Signature';

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516177_v6_3_0_2259;
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
