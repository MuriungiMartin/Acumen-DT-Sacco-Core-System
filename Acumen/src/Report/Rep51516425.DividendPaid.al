#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516425_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516425 "Dividend Paid"
{
	RDLCLayout = './Layouts/DividendPaid.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem(Vend;Vendor)
		{
			DataItemTableView = where("Global Dimension 1 Code"=const('FOSA'));
			PrintOnlyIfDetail = false;
			RequestFilterFields = "No.","Date Filter","Employer Code";
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
			column(No; Vend."No.")
			{
			}
			column(Name; Vend.Name)
			{
			}
			column(ID_No; Vend."ID No.")
			{
			}
			column(Employer; Vend."E-Mail (Personal)")
			{
			}
			column(Gross_Dividend; GrossDiv)
			{
			}
			column(ProcessingFee; ExciseDuty+ProcesinFee)
			{
			}
			column(W_Tax; "W/Tax")
			{
			}
			column(Net_Dividend; NetDiv)
			{
			}
			dataitem(VendLedgEntr;"Vendor Ledger Entry")
			{
				DataItemLink = "Vendor No."=field("No."),"Posting Date"=field("Date Filter");
				DataItemTableView = sorting("Vendor No.") where(Description=filter('Dividends'|'Dividends Withholding Tax'|'Dividends Processing Fee'|'Excise on DivProcessing Fee'));
				column(ReportForNavId_1000000010; 1000000010) {} // Autogenerated by ForNav - Do not delete
				column(FOSA_No; VendLedgEntr."Vendor No.")
				{
				}
				column(TGrossDiv; TGrossDiv)
				{
				}
				column(TW_Tax; "TW/Tax")
				{
				}
				column(TProcesinFee; TExciseDuty+TProcesinFee)
				{
				}
				column(TNetDiv; TNetDiv)
				{
				}
				column(LCount; LCount)
				{
				}
				column(Gross_Dividend2; GrossDiv)
				{
				}
				column(ProcessingFee2; ExciseDuty+ProcesinFee)
				{
				}
				column(W_Tax2; "W/Tax")
				{
				}
				column(Net_Dividend2; NetDiv)
				{
				}
				trigger OnAfterGetRecord();
				begin
					if VendLedgEntr.Description = 'Dividends' then begin
					 GrossDiv:=-VendLedgEntr.Amount;
					 TGrossDiv+=GrossDiv;
					end;
					if VendLedgEntr.Description = 'Dividends Withholding Tax' then begin
					 "W/Tax":=VendLedgEntr.Amount;
					 "TW/Tax"+="W/Tax";
					end;
					if VendLedgEntr.Description = 'Dividends Processing Fee' then begin
					 ProcesinFee:=VendLedgEntr.Amount;
					 TProcesinFee+=ProcesinFee;
					end;
					if VendLedgEntr.Description = 'Excise on DivProcessing Fee' then begin
					 ExciseDuty:=VendLedgEntr.Amount;
					 TExciseDuty+=ExciseDuty;
					end;
					NetDiv:=  GrossDiv - ("W/Tax"+ProcesinFee+ExciseDuty);
					TNetDiv:= TGrossDiv - ("TW/Tax"+TProcesinFee+TExciseDuty);
				end;
				
			}
			trigger OnAfterGetRecord();
			begin
				VendLedgEntr.Reset;
				VendLedgEntr.SetRange(VendLedgEntr."Vendor No.",Vend."No.");
				if VendLedgEntr.Find('-') = false then
				 CurrReport.Skip;
				Cust.Reset;
				//>Cust.SETRANGE(Cust."Application No.",Vend."BOSA Account No");
				Cust.SetFilter(Cust."Customer Posting Group",'BOSA');
				Cust.SetRange(Cust."FOSA Account No.",Vend."No.");
				if Cust.Find('-') then
				 MNo:=Cust."No.";
				LCount:=Vend.Count;
			end;
			
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
		Company: Record "Company Information";
		GrossDiv: Decimal;
		"W/Tax": Decimal;
		ProcesinFee: Decimal;
		ExciseDuty: Decimal;
		NetDiv: Decimal;
		PeriodFiltr: Date;
		TGrossDiv: Decimal;
		"TW/Tax": Decimal;
		TProcesinFee: Decimal;
		TExciseDuty: Decimal;
		TNetDiv: Decimal;
		Cust: Record "Member Register";
		MNo: Code[40];
		LCount: Integer;

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516425_v6_3_0_2259;
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