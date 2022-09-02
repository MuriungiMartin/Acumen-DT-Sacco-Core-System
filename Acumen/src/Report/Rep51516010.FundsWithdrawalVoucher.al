#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516010_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516010 "Funds Withdrawal Voucher"
{
	RDLCLayout = './Layouts/FundsWithdrawalVoucher.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Receipts and Payment Types";"Receipts and Payment Types")
		{
			column(ReportForNavId_1; 1) {} // Autogenerated by ForNav - Do not delete
			column(No; "Receipts and Payment Types"."G/L Account")
			{
			}
			column(Dated; "Receipts and Payment Types"."Bank Account")
			{
			}
			column(ChequeNo; "Receipts and Payment Types"."Cheque/Doc. No")
			{
			}
			column(PayingAcc; "Receipts and Payment Types"."Transation Remarks")
			{
			}
			column(AccName; "Receipts and Payment Types"."Payment Reference")
			{
			}
			column(CName; CompanyInfo.Name)
			{
			}
			column(CAddress; CompanyInfo.Address)
			{
			}
			column(CPic; CompanyInfo.Picture)
			{
			}
			dataitem("Funds Transfer Line";"Funds Transfer Line")
			{
				DataItemLink = "Document No"=field("G/L Account");
				column(ReportForNavId_6; 6) {} // Autogenerated by ForNav - Do not delete
				column(RecAcc; "Funds Transfer Line"."Receiving Bank Account")
				{
				}
				column(RecAccName; "Funds Transfer Line"."Bank Name")
				{
				}
				column(AmountReceived; "Funds Transfer Line"."Amount to Receive")
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
		   CompanyInfo.Get;
		   CompanyInfo.CalcFields(CompanyInfo.Picture);
		;ReportsForNavPre;
	end;
	var
		CompanyInfo: Record "Company Information";

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516010_v6_3_0_2259;
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
