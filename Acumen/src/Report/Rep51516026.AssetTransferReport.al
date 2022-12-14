#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516026_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516026 "Asset Transfer Report"
{
	UsageCategory = ReportsAndAnalysis;
	RDLCLayout = './Layouts/AssetTransferReport.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("HR Asset Transfer Header";"HR Asset Transfer Header")
		{
			column(ReportForNavId_1; 1) {} // Autogenerated by ForNav - Do not delete
			column(No_HRAssetTransferHeader; "HR Asset Transfer Header"."No.")
			{
			}
			column(DocumentDate_HRAssetTransferHeader; "HR Asset Transfer Header"."Document Date")
			{
			}
			column(DateTransfered_HRAssetTransferHeader; "HR Asset Transfer Header"."Date Transfered")
			{
			}
			column(TransferedBy_HRAssetTransferHeader; "HR Asset Transfer Header"."Transfered By")
			{
			}
			dataitem("HR Asset Transfer Lines";"HR Asset Transfer Lines")
			{
				DataItemLink = "No."=field("No.");
				column(ReportForNavId_6; 6) {} // Autogenerated by ForNav - Do not delete
				column(NewGlobalDimension3Code_HRAssetTransferLines; "HR Asset Transfer Lines"."New Global Dimension 3 Code")
				{
				}
				column(AssetNo_HRAssetTransferLines; "HR Asset Transfer Lines"."Asset No.")
				{
				}
				column(AssetBarCode_HRAssetTransferLines; "HR Asset Transfer Lines"."Asset Bar Code")
				{
				}
				column(FALocation_HRAssetTransferLines; "HR Asset Transfer Lines"."FA Location")
				{
				}
				column(ResponsibleEmployeeCode_HRAssetTransferLines; "HR Asset Transfer Lines"."Responsible Employee Code")
				{
				}
				column(AssetSerialNo_HRAssetTransferLines; "HR Asset Transfer Lines"."Asset Serial No")
				{
				}
				column(EmployeeName_HRAssetTransferLines; "HR Asset Transfer Lines"."Employee Name")
				{
				}
				column(NewResponsibleEmployeeCode_HRAssetTransferLines; "HR Asset Transfer Lines"."New Responsible Employee Code")
				{
				}
				column(NewEmployeeName_HRAssetTransferLines; "HR Asset Transfer Lines"."New Employee Name")
				{
				}
				column(GlobalDimension1Code_HRAssetTransferLines; "HR Asset Transfer Lines"."Global Dimension 1 Code")
				{
				}
				column(NewGlobalDimension1Code_HRAssetTransferLines; "HR Asset Transfer Lines"."New Global Dimension 1 Code")
				{
				}
				column(GlobalDimension2Code_HRAssetTransferLines; "HR Asset Transfer Lines"."Global Dimension 2 Code")
				{
				}
				column(NewGlobalDimension2Code_HRAssetTransferLines; "HR Asset Transfer Lines"."New Global Dimension 2 Code")
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
		ReportForNav : DotNet ForNavReport51516026_v6_3_0_2259;
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
