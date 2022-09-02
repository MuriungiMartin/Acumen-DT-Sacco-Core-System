#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516201_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516201 "Close out Checklist"
{
	RDLCLayout = './Layouts/CloseoutChecklist.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem(UnknownTable53959;Table53959)
		{
			RequestFilterFields = Field9;
			column(ReportForNavId_1000000000; 1000000000) {} // Autogenerated by ForNav - Do not delete
			column(GrantNo_CloseOutCheckList; Table53959."Grant No")
			{
			}
			column(ComplianceCode_CloseOutCheckList; Table53959."Compliance Code")
			{
			}
			column(Description_CloseOutCheckList; Table53959.Description)
			{
			}
			column(Compliance_CloseOutCheckList; Table53959.Compliance)
			{
			}
			column(User_CloseOutCheckList; Table53959.User)
			{
			}
			column(Amount_CloseOutCheckList; Table53959.Amount)
			{
			}
			column(Comments_CloseOutCheckList; Table53959.Comments)
			{
			}
			column(Status_CloseOutCheckList; Table53959.Status)
			{
			}
			column(CloseoutNo_CloseOutCheckList; Table53959."Closeout No.")
			{
			}
			column(ResponsibilityCenter_CloseOutCheckList; Table53959."Responsibility Center")
			{
			}
			column(NoSeries_CloseOutCheckList; Table53959."No. Series")
			{
			}
			column(DonorSponsorCode_CloseOutCheckList; Table53959."Donor/Sponsor Code")
			{
			}
			column(Subcontractorno_CloseOutCheckList; Table53959."Subcontractor no")
			{
			}
			column(Date_CloseOutCheckList; Table53959.Date)
			{
			}
			column(Subcontractor_CloseOutCheckList; Table53959.Subcontractor)
			{
			}
			column(PI_CloseOutCheckList; Table53959.PI)
			{
			}
			column(PIName_CloseOutCheckList; Table53959."PI Name")
			{
			}
			dataitem(UnknownTable53960;Table53960)
			{
				DataItemLink = Field2=field(Field9);
				column(ReportForNavId_1000000018; 1000000018) {} // Autogenerated by ForNav - Do not delete
				column(LineNo_CloseoutChecklistLines; Table53960."Line No")
				{
				}
				column(CloseoutNos_CloseoutChecklistLines; Table53960."Closeout Nos")
				{
				}
				column(Sections_CloseoutChecklistLines; Table53960.Sections)
				{
				}
				column(Options_CloseoutChecklistLines; Table53960.Options)
				{
				}
				column(Amount_CloseoutChecklistLines; Table53960.Amount)
				{
				}
				column(Reason_CloseoutChecklistLines; Table53960.Reason)
				{
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
		;ReportsForNavPre;
	end;

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516201_v6_3_0_2259;
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