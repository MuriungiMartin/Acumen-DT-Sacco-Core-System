#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516961_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516961 "Changes in Equity"
{
	RDLCLayout = './Layouts/ChangesinEquity.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Company Information";"Company Information")
		{
			column(ReportForNavId_1; 1) {} // Autogenerated by ForNav - Do not delete
			column(Asat; Asat)
			{
			}
			column(ShareCapital; ShareCapital)
			{
			}
			column(StatutoryReserve; StatutoryReserve)
			{
			}
			column(GeneralReserve; GeneralReserve)
			{
			}
			column(RevaluationReserve; RevaluationReserve)
			{
			}
			column(RetainedEarnings; RetainedEarnings)
			{
			}
			column(Totals; Totals)
			{
			}
			column(ShareCapitalOpening; ShareCapitalOpening)
			{
			}
			column(ShareCapitalCurrent; ShareCapitalCurrent)
			{
			}
			column(ShareCapitalOpeningCurrent; ShareCapitalOpeningCurrent)
			{
			}
			column(AsAtCurr; AsAtCurr)
			{
			}
			column(AsAtLast; AsAtLast)
			{
			}
			column(Currentyearint; Currentyearint)
			{
			}
			column(Lastyearinterger; Lastyearinterger)
			{
			}
			column(AsAtCurrEnd; AsAtCurrEnd)
			{
			}
			column(AsAtLasteND; AsAtLasteND)
			{
			}
			trigger OnPreDataItem();
			begin
				LastyearFilter:=Format(CalcDate('-CY-1Y',Asat))+'..'+Format(CalcDate('-CY-1D',Asat));
				CurrentYearfilter:=Format(CalcDate('-CY',Asat))+'..'+Format(Asat);
				AsAtCurr:=(CalcDate('-CY',Asat));
				AsAtCurrEnd:=(CalcDate('CY',Asat));
				AsAtLast:=(CalcDate('-CY-1Y',Asat));
				AsAtLasteND:=(CalcDate('-CY-1D',Asat));
				Lastyearinterger:=Date2dmy(CalcDate('-CY-1Y',Asat),3);
				Currentyearint:=Date2dmy(CalcDate('-CY',Asat),3);
			end;
			
			trigger OnAfterGetRecord();
			begin
				GLAccount.Reset;
				GLAccount.SetFilter(GLAccount.ChangesInEquity,'%1',GLAccount.Changesinequity::Sharecapital);
				if GLAccount.FindSet then begin
				  repeat
					GLEntry.Reset;
					GLEntry.SetFilter(GLEntry."Posting Date",LastyearFilter);
					GLEntry.SetRange(GLEntry."G/L Account No.",GLAccount."No.");
					if GLEntry.FindSet then begin
					  GLEntry.CalcSums(Amount);
					  ShareCapital+=GLEntry.Amount*-1;
					  end
					  until GLAccount.Next = 0 ;
				end;
				GLAccount.Reset;
				GLAccount.SetFilter(GLAccount.ChangesInEquity,'%1',GLAccount.Changesinequity::Sharecapital);
				if GLAccount.FindSet then begin
				  repeat
					GLEntry.Reset;
					GLEntry.SetFilter(GLEntry."Posting Date",'<=%1',(CalcDate('-CY-1Y')));
					GLEntry.SetRange(GLEntry."G/L Account No.",GLAccount."No.");
					if GLEntry.FindSet then begin
					  GLEntry.CalcSums(Amount);
					  ShareCapitalOpening+=GLEntry.Amount*-1;
					  end
					  until GLAccount.Next = 0 ;
				end;
				GLAccount.Reset;
				GLAccount.SetFilter(GLAccount.ChangesInEquity,'%1',GLAccount.Changesinequity::Sharecapital);
				if GLAccount.FindSet then begin
				  repeat
					GLEntry.Reset;
					GLEntry.SetFilter(GLEntry."Posting Date",CurrentYearfilter);
					GLEntry.SetRange(GLEntry."G/L Account No.",GLAccount."No.");
					if GLEntry.FindSet then begin
					  GLEntry.CalcSums(Amount);
					  ShareCapitalCurrent+=GLEntry.Amount*-1;
					  end
					  until GLAccount.Next = 0 ;
				end;
				GLAccount.Reset;
				GLAccount.SetFilter(GLAccount.ChangesInEquity,'%1',GLAccount.Changesinequity::Sharecapital);
				if GLAccount.FindSet then begin
				  repeat
					GLEntry.Reset;
					GLEntry.SetFilter(GLEntry."Posting Date",'<=%1',Asat);
					GLEntry.SetRange(GLEntry."G/L Account No.",GLAccount."No.");
					if GLEntry.FindSet then begin
					  GLEntry.CalcSums(Amount);
					  ShareCapitalOpeningCurrent+=GLEntry.Amount*-1;
					  end
					  until GLAccount.Next = 0 ;
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
				field(Asat;Asat)
				{
					ApplicationArea = Basic;
					Caption = 'AsAt';
				}
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
		Asat: Date;
		ShareCapital: Decimal;
		StatutoryReserve: Decimal;
		GeneralReserve: Decimal;
		RevaluationReserve: Decimal;
		RetainedEarnings: Decimal;
		Totals: Decimal;
		LastyearFilter: Text;
		GLEntry: Record "G/L Entry";
		GLAccount: Record "G/L Account";
		ShareCapitalOpening: Decimal;
		CurrentYearfilter: Text;
		ShareCapitalCurrent: Decimal;
		ShareCapitalOpeningCurrent: Decimal;
		AsAtCurr: Date;
		AsAtLast: Date;
		Lastyearinterger: Integer;
		Currentyearint: Integer;
		AsAtCurrEnd: Date;
		AsAtLasteND: Date;

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516961_v6_3_0_2259;
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
