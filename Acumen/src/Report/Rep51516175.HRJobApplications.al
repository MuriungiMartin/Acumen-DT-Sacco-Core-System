#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516175_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516175 "HR Job Applications"
{
	UsageCategory = ReportsAndAnalysis;
	RDLCLayout = './Layouts/HRJobApplications.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("HR Job Applications";"HR Job Applications")
		{
			PrintOnlyIfDetail = false;
			RequestFilterFields = "Application No";
			column(ReportForNavId_1102755000; 1102755000) {} // Autogenerated by ForNav - Do not delete
			column(SectionA; SectionA)
			{
			}
			column(ApplicationNo_HRJobApplications; "HR Job Applications"."Application No")
			{
				IncludeCaption = true;
			}
			column(FirstName_HRJobApplications; "HR Job Applications"."First Name")
			{
				IncludeCaption = true;
			}
			column(MiddleName_HRJobApplications; "HR Job Applications"."Middle Name")
			{
				IncludeCaption = true;
			}
			column(LastName_HRJobApplications; "HR Job Applications"."Last Name")
			{
				IncludeCaption = true;
			}
			column(JobAppliedFor_HRJobApplications; "HR Job Applications"."Job Applied For")
			{
				IncludeCaption = true;
			}
			column(City_HRJobApplications; "HR Job Applications".City)
			{
				IncludeCaption = true;
			}
			column(PostCode_HRJobApplications; "HR Job Applications"."Post Code")
			{
				IncludeCaption = true;
			}
			column(IDNumber_HRJobApplications; "HR Job Applications"."ID Number")
			{
				IncludeCaption = true;
			}
			column(Gender_HRJobApplications; "HR Job Applications".Gender)
			{
				IncludeCaption = true;
			}
			column(CountryCode_HRJobApplications; "HR Job Applications"."Country Code")
			{
				IncludeCaption = true;
			}
			column(SectionB; SectionB)
			{
			}
			column(HomePhoneNumber_HRJobApplications; "HR Job Applications"."Home Phone Number")
			{
				IncludeCaption = true;
			}
			column(CellPhoneNumber_HRJobApplications; "HR Job Applications"."Cell Phone Number")
			{
				IncludeCaption = true;
			}
			column(WorkPhoneNumber_HRJobApplications; "HR Job Applications"."Work Phone Number")
			{
				IncludeCaption = true;
			}
			column(EMail_HRJobApplications; "HR Job Applications"."E-Mail")
			{
				IncludeCaption = true;
			}
			column(PostalAddress_HRJobApplications; "HR Job Applications"."Postal Address")
			{
				IncludeCaption = true;
			}
			column(CI_Name; CI.Name)
			{
				IncludeCaption = true;
			}
			column(CI_Address; CI.Address)
			{
				IncludeCaption = true;
			}
			column(CI_Address2; CI."Address 2")
			{
				IncludeCaption = true;
			}
			column(CI_City; CI.City)
			{
				IncludeCaption = true;
			}
			column(CI_EMail; CI."E-Mail")
			{
				IncludeCaption = true;
			}
			column(CI_HomePage; CI."Home Page")
			{
				IncludeCaption = true;
			}
			column(CI_PhoneNo; CI."Phone No.")
			{
				IncludeCaption = true;
			}
			column(CI_Picture; CI.Picture)
			{
				IncludeCaption = true;
			}
			dataitem("HR Applicant Qualifications";"HR Applicant Qualifications")
			{
				DataItemLink = "Application No"=field("Application No");
				DataItemTableView = sorting("Application No","Qualification Type","Qualification Code") order(ascending);
				PrintOnlyIfDetail = false;
				column(ReportForNavId_1102755001; 1102755001) {} // Autogenerated by ForNav - Do not delete
				column(SectionC; SectionC)
				{
				}
				column(QualificationType_HRApplicantQualifications; "HR Applicant Qualifications"."Qualification Type")
				{
					IncludeCaption = true;
				}
				column(QualificationCode_HRApplicantQualifications; "HR Applicant Qualifications"."Qualification Code")
				{
					IncludeCaption = true;
				}
				column(QualificationDescription_HRApplicantQualifications; "HR Applicant Qualifications"."Qualification Description")
				{
					IncludeCaption = true;
				}
				column(InstitutionCompany_HRApplicantQualifications; "HR Applicant Qualifications"."Institution/Company")
				{
					IncludeCaption = true;
				}
				column(FromDate_HRApplicantQualifications; "HR Applicant Qualifications"."From Date")
				{
					IncludeCaption = true;
				}
				column(ToDate_HRApplicantQualifications; "HR Applicant Qualifications"."To Date")
				{
					IncludeCaption = true;
				}
			}
			dataitem("HR Applicant Referees";"HR Applicant Referees")
			{
				DataItemLink = "Job Application No"=field("Application No");
				DataItemTableView = sorting("Job Application No",Names) order(ascending);
				PrintOnlyIfDetail = false;
				column(ReportForNavId_1102755002; 1102755002) {} // Autogenerated by ForNav - Do not delete
				column(SectionD; SectionD)
				{
				}
				column(Names_HRApplicantReferees; "HR Applicant Referees".Names)
				{
					IncludeCaption = true;
				}
				column(Designation_HRApplicantReferees; "HR Applicant Referees".Designation)
				{
					IncludeCaption = true;
				}
				column(Institution_HRApplicantReferees; "HR Applicant Referees".Institution)
				{
					IncludeCaption = true;
				}
				column(Address_HRApplicantReferees; "HR Applicant Referees".Address)
				{
					IncludeCaption = true;
				}
				column(TelephoneNo_HRApplicantReferees; "HR Applicant Referees"."Telephone No")
				{
					IncludeCaption = true;
				}
				column(EMail_HRApplicantReferees; "HR Applicant Referees"."E-Mail")
				{
					IncludeCaption = true;
				}
			}
			dataitem("HR Applicant Hobbies";"HR Applicant Hobbies")
			{
				DataItemLink = "Job Application No"=field("Application No");
				DataItemTableView = sorting("Job Application No",Hobby) order(ascending);
				PrintOnlyIfDetail = false;
				column(ReportForNavId_1102755003; 1102755003) {} // Autogenerated by ForNav - Do not delete
				column(Hobby_HRApplicantHobbies; "HR Applicant Hobbies".Hobby)
				{
					IncludeCaption = true;
				}
			}
		}
	}

	requestpage
	{

  
		SaveValues = false;	  layout
		{
			area(content)
			{
				group(Options)
				{
					Caption = 'Options';
					field(ForNavOpenDesigner;ReportForNavOpenDesigner)
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
		;ReportsForNavInit;

	end;

	trigger OnPostReport()
	begin
		;ReportForNav.Post;
	end;

	trigger OnPreReport()
	begin
					CI.Get();
					CI.CalcFields(CI.Picture);
					//GET FILTER
					JobApplicationNo:="HR Job Applications".GetFilter("HR Job Applications"."Application No");
					if JobApplicationNo='' then
					begin
						Message('Please select a Job Application Number before printing a report');
						CurrReport.Quit;
					end;
		;ReportsForNavPre;
	end;
	var
		CI: Record "Company Information";
		SectionA: label 'Section A :: Personal Details';
		SectionB: label 'Section B :: Contact Details';
		SectionC: label 'Section C :: Academic and Qualification Information';
		SectionD: label 'Section D :: Applicant''s Refferees';
		JobApplicationNo: Text;

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516175_v6_3_0_2259;
		ReportForNavOpenDesigner : Boolean;
		[InDataSet]
		ReportForNavAllowDesign : Boolean;

	local procedure ReportsForNavInit();
	var
		ApplicationSystemConstants: Codeunit "Application System Constants";
		addInFileName : Text;
		tempAddInFileName : Text;
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
		ReportForNav.OpenDesigner:=ReportForNavOpenDesigner;
		if not ReportForNav.Pre() then CurrReport.Quit();
	end;

	// Reports ForNAV Autogenerated code - do not delete or modify -->
}
