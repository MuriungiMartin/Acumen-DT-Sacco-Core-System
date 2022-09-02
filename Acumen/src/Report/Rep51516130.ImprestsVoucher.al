#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516130_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516130 "Imprests Voucher"
{
	RDLCLayout = './Layouts/ImprestsVoucher.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Imprest Header";"Imprest Header")
		{
			column(ReportForNavId_1; 1) {} // Autogenerated by ForNav - Do not delete
			column(No_ImprestHeader; "Imprest Header"."No.")
			{
			}
			column(Date_ImprestHeader; "Imprest Header".Date)
			{
			}
			column(Payee_ImprestHeader; "Imprest Header".Payee)
			{
			}
			column(OnBehalfOf_ImprestHeader; "Imprest Header"."On Behalf Of")
			{
			}
			column(TotalPaymentAmount_ImprestHeader; "Imprest Header"."Total Payment Amount")
			{
			}
			column(PayingBankAccount_ImprestHeader; "Imprest Header"."Paying Bank Account")
			{
			}
			column(BudgetCenterName_ImprestHeader; "Imprest Header"."Budget Center Name")
			{
			}
			column(BankName_ImprestHeader; "Imprest Header"."Bank Name")
			{
			}
			column(ChequeNo_ImprestHeader; "Imprest Header"."Cheque No.")
			{
			}
			column(PayMode_ImprestHeader; "Imprest Header"."Pay Mode")
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
			column(CI_City; CI.City)
			{
				IncludeCaption = true;
			}
			dataitem("Imprest Lines";"Imprest Lines")
			{
				DataItemLink = No=field("No.");
				column(ReportForNavId_6; 6) {} // Autogenerated by ForNav - Do not delete
				column(AccountNo_ImprestLines; "Imprest Lines"."Account No:")
				{
				}
				column(AccountName_ImprestLines; "Imprest Lines"."Account Name")
				{
				}
				column(Amount_ImprestLines; "Imprest Lines".Amount)
				{
				}
				column(DueDate_ImprestLines; "Imprest Lines"."Due Date")
				{
				}
				column(ImprestHolder_ImprestLines; "Imprest Lines"."Imprest Holder")
				{
				}
				column(SurrenderDate_ImprestLines; "Imprest Lines"."Surrender Date")
				{
				}
				column(Purpose_ImprestLines; "Imprest Lines".Purpose)
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
		CI.Get();
		CI.CalcFields(CI.Picture);
		;ReportsForNavPre;
	end;
	var
		CompanyInfo: Record "Company Information";
		CI: Record "Company Information";

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516130_v6_3_0_2259;
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
