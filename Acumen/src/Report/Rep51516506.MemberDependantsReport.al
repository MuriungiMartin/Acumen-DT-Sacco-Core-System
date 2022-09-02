#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516506_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516506 "Member Dependants Report"
{
	UsageCategory = ReportsAndAnalysis;
	RDLCLayout = './Layouts/MemberDependantsReport.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Company Information";"Company Information")
		{
			column(ReportForNavId_7; 7) {} // Autogenerated by ForNav - Do not delete
			column(Name_CompanyInformation; "Company Information".Name)
			{
			}
			column(Picture_CompanyInformation; "Company Information".Picture)
			{
			}
		}
		dataitem("Members Nominee";"Members Nominee")
		{
			RequestFilterFields = "Account No";
			column(ReportForNavId_1; 1) {} // Autogenerated by ForNav - Do not delete
			column(Name_MembersNominee; "Members Nominee".Name)
			{
			}
			column(AccountNo_MembersNominee; "Members Nominee"."Account No")
			{
			}
			column(Relationship_MembersNominee; "Members Nominee".Relationship)
			{
			}
			column(Beneficiary_MembersNominee; "Members Nominee".Beneficiary)
			{
			}
			column(DateofBirth_MembersNominee; "Members Nominee"."Date of Birth")
			{
			}
			column(Address_MembersNominee; "Members Nominee".Address)
			{
			}
			column(IDNo_MembersNominee; "Members Nominee"."ID No.")
			{
			}
			column(Allocation_MembersNominee; "Members Nominee"."%Allocation")
			{
			}
			column(TotalAllocation_MembersNominee; "Members Nominee"."Total Allocation")
			{
			}
			column(EntryNo_MembersNominee; "Members Nominee"."Entry No")
			{
			}
			column(Description_MembersNominee; "Members Nominee".Description)
			{
			}
			column(NextOfKinType_MembersNominee; "Members Nominee"."Next Of Kin Type")
			{
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
		;ReportsForNavPre;
	end;

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516506_v6_3_0_2259;
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
