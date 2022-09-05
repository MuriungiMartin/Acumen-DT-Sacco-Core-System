#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 51516185 "HR Job App. Notify Applicants"
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("HR Job Applications"; "HR Job Applications")
        {
            RequestFilterFields = "Application No", Qualified;
            column(ReportForNavId_3952; 3952)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
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
            column(HR_Job_Applications__Application_No_; "Application No")
            {
            }
            column(HR_Job_Applications__FullName; FullName)
            {
            }
            column(HR_Job_Applications__Postal_Address_; "Postal Address")
            {
            }
            column(HR_Job_Applications_City; City)
            {
            }
            column(HR_Job_Applications__Post_Code_; "Post Code")
            {
            }
            column(HR_Job_ApplicationsCaption; HR_Job_ApplicationsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Job_Applicants_Notified_Via_E_mailCaption; Job_Applicants_Notified_Via_E_mailCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(HR_Job_Applications__Application_No_Caption; FieldCaption("Application No"))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(HR_Job_Applications__Postal_Address_Caption; FieldCaption("Postal Address"))
            {
            }
            column(HR_Job_Applications_CityCaption; FieldCaption(City))
            {
            }
            column(HR_Job_Applications__Post_Code_Caption; FieldCaption("Post Code"))
            {
            }

            trigger OnPostDataItem()
            var
                Recipient: list of [Text];
            begin

                if "HR Job Applications".Find('-') then begin

                    if Confirm('Do you want to notify all shorlisted candidates?', true) = false then exit;

                    if "Interview Invitation Sent" = true then begin
                        Name := "HR Job Applications"."First Name" + ' ' + "HR Job Applications"."Middle Name" + ' ' + "HR Job Applications"."Last Name";
                        if Confirm('Do you want to Re-Send an Interview invitation to this applicant?', true) = false then exit;
                    end;

                    //message('Please wait: Sending Interview Invitation Email');
                    //GET E-MAIL PARAMETERS FOR JOB APPLICATIONS
                    HREmailParameters.Reset;
                    HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."associate with"::"Vacancy Advertisements");
                    if HREmailParameters.Find('-') then begin

                        HREmailParameters.TestField(HREmailParameters."Sender Name");
                        HREmailParameters.TestField(HREmailParameters."Sender Address");
                        HREmailParameters.TestField(HREmailParameters.Subject);
                        HREmailParameters.TestField(HREmailParameters.Body);


                        repeat
                            "HR Job Applications".TestField("E-Mail");
                            Recipient.add("E-Mail");
                            SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", Recipient,
                            HREmailParameters.Subject, 'Dear' + ' ' + "First Name" + ' ' +
                            HREmailParameters.Body + ' ' + "Job Applied For" + ' ' + HREmailParameters."Body 2" + ' ' +
                            HREmailParameters."Body 3", true);
                            SMTP.Send();
                            "HR Job Applications"."Interview Invitation Sent" := true;
                            "HR Job Applications".Modify;
                        until Next = 0;
                    end else begin
                        Message('There were no qualified applicants');
                        Reset;
                        exit;
                    end;
                    Message('All Job Applicants have been notified via E-Mail');
                    Reset;
                end;
            end;

            trigger OnPreDataItem()
            begin
                if JopAppNo = '' then begin
                    //NOTIFY ALL QUALIFIED APPLICANTS WHO HAVE NOT ALREADY BEEN EMPLOYED
                    "HR Job Applications".Reset;
                    "HR Job Applications".SetRange("HR Job Applications".Qualified, true);
                    "HR Job Applications".SetRange("HR Job Applications"."Interview Invitation Sent", false);

                end else begin
                    //NOTIFY THE SELECTED APPLICANT
                    "HR Job Applications".Reset;
                    "HR Job Applications".SetRange("HR Job Applications"."Application No", JopAppNo);
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        JopAppNo := "HR Job Applications".GetFilter("HR Job Applications"."Application No");
    end;

    var
        HREmp: Record "HR Employees";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        JopAppNo: Code[10];
        SMTP: Codeunit "SMTP Mail";
        HREmailParameters: Record "HR E-Mail Parameters";
        CI: Record "Company Information";
        HR_Job_ApplicationsCaptionLbl: label 'HR Job Applications';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Job_Applicants_Notified_Via_E_mailCaptionLbl: label 'Job Applicants Notified Via E-mail';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        NameCaptionLbl: label 'Name';
        Name: Text;
        HRJobApplications: Record "HR Job Applications";
}

