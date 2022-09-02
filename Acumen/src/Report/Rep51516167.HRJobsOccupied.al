#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516167_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516167 "HR Jobs (Occupied)"
{
	UsageCategory = ReportsAndAnalysis;
	RDLCLayout = './Layouts/HRJobs(Occupied).rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("HR Jobss";"HR Jobss")
		{
			DataItemTableView = where("Occupied Positions"=filter((>0));
			RequestFilterFields = "Job ID";
			column(ReportForNavId_9002; 9002) {} // Autogenerated by ForNav - Do not delete
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
			column(CI_PhoneNo; CI."Phone No.")
			{
				IncludeCaption = true;
			}
			column(CI_Picture; CI.Picture)
			{
				IncludeCaption = true;
			}
			column(NoofPosts_HRJobs; "HR Jobss"."No of Posts")
			{
				IncludeCaption = true;
			}
			column(OccupiedPositions_HRJobs; "HR Jobss"."Occupied Positions")
			{
				IncludeCaption = true;
			}
			column(JobID_HRJobs; "HR Jobss"."Job ID")
			{
				IncludeCaption = true;
			}
			column(JobDescription_HRJobs; "HR Jobss"."Job Description")
			{
				IncludeCaption = true;
			}
			column(CI_City; CI.City)
			{
				IncludeCaption = true;
			}
			dataitem("HR Employees";"HR Employees")
			{
				DataItemLink = "Job Specification"=field("Job ID");
				DataItemTableView = where(Status=const(Active));
				column(ReportForNavId_1000000001; 1000000001) {} // Autogenerated by ForNav - Do not delete
				column(No_HREmployees; "HR Employees"."No.")
				{
					IncludeCaption = true;
				}
				column(FirstName_HREmployees; "HR Employees"."First Name")
				{
					IncludeCaption = true;
				}
				column(MiddleName_HREmployees; "HR Employees"."Middle Name")
				{
					IncludeCaption = true;
				}
				column(LastName_HREmployees; "HR Employees"."Last Name")
				{
					IncludeCaption = true;
				}
				column(JobTitle_HREmployees; "HR Employees"."Job Title")
				{
					IncludeCaption = true;
				}
				column(UserID_HREmployees; "HR Employees"."User ID")
				{
					IncludeCaption = true;
				}
			}
			trigger OnAfterGetRecord();
			begin
								 Validate("Vacant Positions");
			end;
			
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
		;ReportsForNavPre;
	end;
	var
		CI: Record "Company Information";
		HR_JobsCaptionLbl: label 'HR Jobs';
		CurrReport_PAGENOCaptionLbl: label 'Page';
		Jobs_with_OccupantsCaptionLbl: label 'Jobs with Occupants';
		P_O__BoxCaptionLbl: label 'P.O. Box';

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516167_v6_3_0_2259;
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
