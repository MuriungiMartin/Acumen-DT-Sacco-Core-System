#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516501_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516501 "Interest Due Period."
{
	RDLCLayout = './Layouts/InterestDuePeriod..rdlc'; DefaultLayout = RDLC;

	requestpage
	{

  
		SaveValues = false;	  layout
		{
			area(content)
			{
				field("Int Due Year Start Date";FiscalYearStartDate)
				{
					ApplicationArea = Basic;
				}
				field("No Of Periods";NoOfPeriods)
				{
					ApplicationArea = Basic;
				}
				field("Period Length";PeriodLength)
				{
					ApplicationArea = Basic;
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
		AccountingPeriod."Interest Due Date" := FiscalYearStartDate;
		AccountingPeriod.TestField("Interest Due Date");
		if AccountingPeriod.Find('-') then begin
		  FirstPeriodStartDate := AccountingPeriod."Interest Due Date";
		  FirstPeriodLocked := AccountingPeriod."Date Locked";
		  if (FiscalYearStartDate < FirstPeriodStartDate) and FirstPeriodLocked then
			if not
			   Confirm(
				 Text000 +
				 Text001)
			then
			  exit;
		  if AccountingPeriod.Find('+') then
			LastPeriodStartDate := AccountingPeriod."Interest Due Date";
		end else
		  if not
			 Confirm(
			   Text002 +
			   Text003)
		  then
			exit;
		FiscalYearStartDate2 := FiscalYearStartDate;
		for i := 1 to NoOfPeriods + 1 do begin
		  if (FiscalYearStartDate <= FirstPeriodStartDate) and (i = NoOfPeriods + 1) then
			exit;
		  if (FirstPeriodStartDate <> 0D) then
			if (FiscalYearStartDate >= FirstPeriodStartDate) and (FiscalYearStartDate < LastPeriodStartDate) then
			  Error(Text004);
		  AccountingPeriod.Init;
		  AccountingPeriod."Interest Due Date" := FiscalYearStartDate;
		  //AccountingPeriod."Interest Calcuation Date":=CALCDATE('1M-1D',FiscalYearStartDate);
		  AccountingPeriod."Interest Calcuation Date":=FiscalYearStartDate;
		  AccountingPeriod.Validate("Interest Due Date");
		  if (i = 1) or (i = NoOfPeriods + 1) then begin
			AccountingPeriod."New Fiscal Year" := true;
			InvtSetup.Get;
			AccountingPeriod."Average Cost Calc. Type" := InvtSetup."Average Cost Calc. Type";
			AccountingPeriod."Average Cost Period" := InvtSetup."Average Cost Period";
		  end;
		  if (FirstPeriodStartDate = 0D) and (i = 1) then
			AccountingPeriod."Date Locked" := true;
		  if (AccountingPeriod."Interest Due Date" < FirstPeriodStartDate) and FirstPeriodLocked then begin
			AccountingPeriod.Closed := true;
			//AccountingPeriod."Date Locked" := TRUE;
		  end;
		  if not AccountingPeriod.Find('=') then
			AccountingPeriod.Insert;
		  FiscalYearStartDate := CalcDate(PeriodLength,FiscalYearStartDate);
		  //MESSAGE('FiscalYearStartDate %1',FiscalYearStartDate);
		end;
		AccountingPeriod.Get(FiscalYearStartDate2);
		AccountingPeriod.UpdateAvgItems(0);
		;ReportsForNavPre;
	end;
	var
		AccountingPeriod: Record "Interest Due Period";
		InvtSetup: Record "Inventory Setup";
		NoOfPeriods: Integer;
		PeriodLength: DateFormula;
		FiscalYearStartDate: Date;
		FiscalYearStartDate2: Date;
		FirstPeriodStartDate: Date;
		LastPeriodStartDate: Date;
		FirstPeriodLocked: Boolean;
		i: Integer;
		Text000: label 'The new Interest period begins before an existing interest period, so the new year will be closed automatically.\\';
		Text001: label 'Do you want to create and close the interest period?';
		Text002: label 'Once you create the new interest period you cannot change its starting date.\\';
		Text003: label 'Do you want to create the interest period?';
		Text004: label 'It is only possible to create new interest period before or after the existing ones.';

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516501_v6_3_0_2259;
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
