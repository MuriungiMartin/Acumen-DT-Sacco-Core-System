#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport50025_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50025 "Update Loans v2"
{
	RDLCLayout = './Layouts/UpdateLoansv2.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Upload Loans 15Oct";"Upload Loans 15Oct")
		{
			column(ReportForNavId_1; 1) {} // Autogenerated by ForNav - Do not delete
			trigger OnAfterGetRecord();
			begin
				ObjLoans.Reset;
				ObjLoans.SetRange("Loan  No.","Upload Loans 15Oct"."Loan Number");
				if ObjLoans.Find('-') then
				  begin
				//ObjLoans.VALIDATE("Client Code");
				ObjLoans."Requested Amount":="Upload Loans 15Oct"."Applied Amount";
				ObjLoans."Recommended Amount":="Upload Loans 15Oct"."Recommended Amount";
				ObjLoans."Approved Amount":="Upload Loans 15Oct"."Approved Amount";
				ObjLoans."Amount Disbursed":="Upload Loans 15Oct"."Disbursed Amount";
				ObjLoans."Loan Disbursed Amount":="Upload Loans 15Oct"."Disbursed Amount";
				ObjLoans."Application Date":="Upload Loans 15Oct"."Application Date";
				ObjLoans."Loan Disbursement Date":="Upload Loans 15Oct"."Application Date";
				ObjLoans.Validate("Loan Disbursement Date");
				ObjLoans.Modify;
				end;
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
		;ReportsForNavPre;
	end;
	var
		ObjLoans: Record "Loans Register";

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport50025_v6_3_0_2259;
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