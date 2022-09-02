#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport50023_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50023 "Update Loans"
{
	RDLCLayout = './Layouts/UpdateLoans.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Loans Register";"Loans Register")
		{
			RequestFilterFields = "Loan  No.";
			column(ReportForNavId_1; 1) {} // Autogenerated by ForNav - Do not delete
			trigger OnAfterGetRecord();
			begin
				/*
				IF ObjProducts.GET("Loans Register"."Loan Product Type") THEN
				  BEGIN
					"Loans Register".VALIDATE("Loans Register"."Loan Product Type");
					"Loans Register".VALIDATE("Loans Register"."Client Code");
					"Loans Register".Source:=ObjProducts.Source;
				   IF ObjProducts."Recovery Mode"=ObjProducts."Recovery Mode"::Checkoff THEN
				  "Loans Register"."Recovery Mode":="Loans Register"."Recovery Mode"::Checkoff;
					IF ObjProducts."Recovery Mode"=ObjProducts."Recovery Mode"::Salary THEN
				   "Loans Register"."Recovery Mode":="Loans Register"."Recovery Mode"::Salary;
					"Loans Register".MODIFY;
				  END
				  */
				// //  "Loans Register"."Disburesment Type":="Loans Register"."Disburesment Type"::"Full/Single disbursement";
				// //
				// //  IF (("Loans Register"."Amount Disbursed" < "Loans Register"."Approved Amount") AND ("Loans Register".Posted)) THEN
				// //  BEGIN
				// //  "Loans Register"."Disburesment Type":="Loans Register"."Disburesment Type"::"Tranche/Multiple Disbursement";
				// //  END;CALCDATE(FORMAT(Installments)+'M',"Loan Disbursement Date"
				// //  "Loans Register".MODIFY;
				//IF "Loans Register"."Loan Product Type" = 'JSORT LOAN' THEN BEGIN
				if "Loans Register"."Loan Disbursement Date" = 0D then
				CurrReport.Skip;
				"Loans Register"."Repayment Start Date":=CalcDate ('+1M',"Loans Register"."Loan Disbursement Date");
				"Loans Register"."Expected Date of Completion":=CalcDate (Format ("Loans Register".Installments)+ 'M',"Loans Register"."Loan Disbursement Date");
				"Loans Register".Modify;
				//END;
			
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
		ObjProducts: Record "Loan Products Setup";

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport50023_v6_3_0_2259;
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