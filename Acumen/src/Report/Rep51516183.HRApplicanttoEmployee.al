#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 51516183 "HR Applicant to Employee"
{
    ProcessingOnly = true;
    UsageCategory = Tasks;
    UseRequestPage = false;

    dataset
    {
        dataitem("HR Job Applications";"HR Job Applications")
        {
            RequestFilterFields = "Application No",Qualified;
            column(ReportForNavId_3952; 3952)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(UserId;UserId)
            {
            }
            column(HR_Job_Applications__Application_No_;"Application No")
            {
            }
            column(HR_Job_Applications__FullName;FullName)
            {
            }
            column(HR_Job_Applications__Postal_Address_;"Postal Address")
            {
            }
            column(HR_Job_Applications_City;City)
            {
            }
            column(HR_Job_Applications__Post_Code_;"Post Code")
            {
            }
            column(HR_Job_ApplicationsCaption;HR_Job_ApplicationsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HR_Job_Applications__Application_No_Caption;FieldCaption("Application No"))
            {
            }
            column(NameCaption;NameCaptionLbl)
            {
            }
            column(HR_Job_Applications__Postal_Address_Caption;FieldCaption("Postal Address"))
            {
            }
            column(HR_Job_Applications_CityCaption;FieldCaption(City))
            {
            }
            column(HR_Job_Applications__Post_Code_Caption;FieldCaption("Post Code"))
            {
            }

            trigger OnPostDataItem()
            begin
                mLineNo:=0;

                if Find('-') then begin

                         if Confirm('Are you sure you want to upload qualified applicants information to the Employee card?',true)=false then exit;
                         begin
                            repeat
                                if "Employee No"='' then
                                HRSetup.Get;
                                HRSetup.TestField("Employee Nos.");

                                objEmReq.Reset;
                                objEmReq.SetRange(objEmReq."Requisition No.","Employee Requisition No");
                                if objEmReq.Find('-') then
                                 begin
                                  if Expatriate=false then begin
                                   objNoSeries.Reset;
                                   objNoSeries.SetRange(objNoSeries.Code,HRSetup."Employee Nos.");
                                 //  objNoSeries.SETRANGE(objNoSeries."Series Filter",objEmReq."Global Dimension 2 Code");
                                   if objNoSeries.Find('-') then begin
                                    NoSeriesMgt.InitSeries(objNoSeries."Series Code","No. Series",0D,"Employee No","No. Series");
                                   end
                                  else
                                  begin
                                    // NoSeriesMgt.InitSeries(objNoSeries."Series Code","HR Job Applications"."No. Series",0D,"Employee No","No. Series");
                                    NoSeriesMgt.InitSeries(HRSetup."Employee Nos.","No. Series",0D,"Employee No","No. Series");
                                    end
                                  end;

                                 end;

                                HREmp.Init;
                                HREmp."No.":="Employee No";
                                HREmp."First Name":="First Name";
                                HREmp."Middle Name":="Middle Name";
                                HREmp."Last Name":="Last Name";
                                HREmp."Search Name":="Search Name";
                                HREmp."Postal Address":="Postal Address";
                                HREmp."Residential Address":="Residential Address";
                                HREmp.City:=City;
                                HREmp."Post Code":="Post Code";
                                HREmp.County:=County;
                                HREmp."Home Phone Number":="Home Phone Number";
                                HREmp."Cell Phone Number":="Cell Phone Number";
                                HREmp."Work Phone Number":="Work Phone Number";
                                HREmp."Ext.":="Ext.";
                                HREmp."E-Mail":="E-Mail";
                                HREmp."ID Number":="ID Number";
                                HREmp.Gender:=Gender;
                                HREmp.Citizenship:="Country Code";
                                HREmp."Job Title":="HR Job Applications"."Job Applied For";
                                HREmp."Fax Number":="Fax Number";
                                HREmp."Marital Status":="Marital Status";
                                HREmp."Ethnic Origin":="Ethnic Origin";
                                HREmp."First Language (R/W/S)":="First Language (R/W/S)";
                                //HREmp."Has Driving Licence":=HREmp."Has Driving Licence"::"Driving Licence";
                                HREmp.Disabled:=Disabled;
                                //HREmp."Health Assesment?:="Health Assesment?";
                                HREmp."Health Assesment Date":="Health Assesment Date";
                                HREmp."Date Of Birth":="Date Of Birth";
                                HREmp.Age:=Age;
                                HREmp."Second Language (R/W/S)":="Second Language (R/W/S)";
                                HREmp."Additional Language":="Additional Language";
                               // HREmp."Postal Address 2":="Postal Address2";
                               // HREmp."Postal Address 3":="Postal Address3";
                               // HREmp."Residential Address 2":="Residential Address2";
                               // HREmp."Residential Address 3":="Residential Address3";
                               // HREmp."Post Code 2":="Post Code2";
                                HREmp.Citizenship:=Citizenship;
                                HREmp."Passport Number":="Passport Number";
                                HREmp."First Language Read":="First Language Read";
                                HREmp."First Language Write":="First Language Write";
                                HREmp."First Language Speak":="First Language Speak";
                                HREmp."Second Language Read":="Second Language Read";
                                HREmp."Second Language Write":="Second Language Write";
                                HREmp."Second Language Speak":="Second Language Speak";
                               // HREmp."PIN No.":=;
                                Modify;
                                HREmp.Insert;

                               //Fill the Qualifications************************************* HREmp."No."
                               EmpQualifications.Reset;
                               EmpQualifications.SetRange(EmpQualifications."Line No.");
                               if EmpQualifications.Find('+') then mLineNo:=EmpQualifications."Line No.";

                               mLineNo:=mLineNo+1;
                               AppQualification.Reset;
                               AppQualification.SetRange(AppQualification."Application No","Application No");
                               if AppQualification.Find('-') then repeat
                                EmpQualifications.Init;
                                EmpQualifications."Employee No.":= "Employee No";
                                EmpQualifications."From Date":=EmpQualifications."From Date";
                                EmpQualifications."To Date":=EmpQualifications."To Date";
                                EmpQualifications."Line No.":=mLineNo;
                                EmpQualifications.Type:=EmpQualifications.Type ;
                                EmpQualifications.Description  := EmpQualifications.Description;
                                EmpQualifications."Institution/Company":=EmpQualifications."Institution/Company";
                                EmpQualifications."Qualification Type":= AppQualification."Qualification Type";
                                EmpQualifications."Qualification Code":=AppQualification."Qualification Code";
                                EmpQualifications."Qualification Description":=AppQualification."Qualification Description";
                                EmpQualifications.Insert;
                                mLineNo:=mLineNo+1;
                               until AppQualification.Next=0;

                              until Next=0;


                              Message('Applicants Information successfully uploaded.');
                          end;

                end else begin
                Message('No qualified applicants were found');
                end;
            end;

            trigger OnPreDataItem()
            begin
                if JopAppNo='' then begin
                //UPLOAD ALL QUALIFIED APPLICANTS WHO HAVE NOT ALREADY BEEN EMPLOYED
                Reset;
                SetRange(Qualified,true);
                //"HR Job Applications".SETRANGE("HR Job Applications"."Employee No",'<>%1','');

                end else begin
                //UPLOAD THE SELECTED APPLICANT
                Reset;
                SetRange("Application No",JopAppNo);
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
                      JopAppNo:="HR Job Applications".GetFilter("HR Job Applications"."Application No");
    end;

    var
        HREmp: Record "HR Employees";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        JopAppNo: Code[10];
        HR_Job_ApplicationsCaptionLbl: label 'HR Job Applications';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        NameCaptionLbl: label 'Name';
        EmpQualifications: Record "HR Employee Qualifications";
        AppQualification: Record "HR Applicant Qualifications";
        mLineNo: Integer;
        objNoSeries: Record "No. Series Relationship";
        objEmReq: Record "HR Employee Requisitions";
}

