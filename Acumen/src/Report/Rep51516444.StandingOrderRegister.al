#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516444_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516444 "Standing Order Register"
{
	RDLCLayout = './Layouts/StandingOrderRegister.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Standing Order Register";"Standing Order Register")
		{
			DataItemTableView = sorting("Register No.");
			RequestFilterFields = "Register No.",Amount,"Destination Account Type";
			column(ReportForNavId_4645; 4645) {} // Autogenerated by ForNav - Do not delete
			column(FORMAT_TODAY_0_4_; Format(Today,0,4))
			{
			}
			column(COMPANYNAME; COMPANYNAME)
			{
			}
			column(Company_Address; Company.Address)
			{
			}
			column(Company_Address2; Company."Address 2")
			{
			}
			column(Company_PhoneNo; Company."Phone No.")
			{
			}
			column(Company_Email; Company."E-Mail")
			{
			}
			column(Company_Picture; Company.Picture)
			{
			}
			column(CurrReport_PAGENO; Format(ReportForNav.PageNo))
			{
			}
			column(UserId; UserId)
			{
			}
			column(Register_No; "Standing Order Register"."Register No.")
			{
			}
			column(Source_Account_No; "Standing Order Register"."Source Account No.")
			{
			}
			column(Account_Name; "Standing Order Register"."Account Name")
			{
			}
			column(Dest_Account_Type; "Standing Order Register"."Destination Account Type")
			{
			}
			column(Dest_Account_No; "Standing Order Register"."Destination Account No.")
			{
			}
			column(Dest_Account_Name; "Standing Order Register"."Destination Account Name")
			{
			}
			column(Amount; "Standing Order Register".Amount)
			{
			}
			column(Amount_deducted; "Standing Order Register"."Amount Deducted")
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
				Company.Get();
				Company.CalcFields(Company.Picture);
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
		Loans_RegisterCaptionLbl: label 'Approved Loans Report';
		CurrReport_PAGENOCaptionLbl: label 'Page';
		Loan_TypeCaptionLbl: label 'Loan Type';
		Client_No_CaptionLbl: label 'Client No.';
		Outstanding_LoanCaptionLbl: label 'Outstanding Loan';
		PeriodCaptionLbl: label 'Period';
		Approved_DateCaptionLbl: label 'Approved Date';
		Loan_TypeCaption_Control1102760043Lbl: label 'Loan Type';
		Verified_By__________________________________________________CaptionLbl: label 'Verified By..................................................';
		Confirmed_By__________________________________________________CaptionLbl: label 'Confirmed By..................................................';
		Sign________________________CaptionLbl: label 'Sign........................';
		Sign________________________Caption_Control1102755003Lbl: label 'Sign........................';
		Date________________________CaptionLbl: label 'Date........................';
		Date________________________Caption_Control1102755005Lbl: label 'Date........................';
		NameCreditOff: label 'Name......................................';
		NameCreditDate: label 'Date........................................';
		NameCreditSign: label 'Signature..................................';
		NameCreditMNG: label 'Name......................................';
		NameCreditMNGDate: label 'Date.....................................';
		NameCreditMNGSign: label 'Signature..................................';
		NameCEO: label 'Name........................................';
		NameCEOSign: label 'Signature...................................';
		NameCEODate: label 'Date.....................................';
		CreditCom1: label 'Name........................................';
		CreditCom1Sign: label 'Signature...................................';
		CreditCom1Date: label 'Date.........................................';
		CreditCom2: label 'Name........................................';
		CreditCom2Sign: label 'Signature....................................';
		CreditCom2Date: label 'Date..........................................';
		CreditCom3: label 'Name.........................................';
		CreditComDate3: label 'Date..........................................';
		CreditComSign3: label 'Signature..................................';
		Comment: label '....................';
		Company: Record "Company Information";

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516444_v6_3_0_2259;
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
