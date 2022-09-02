#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516288_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516288 "monthly saving update"
{
	RDLCLayout = './Layouts/monthlysavingupdate.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem(Loans;"Loans Register")
		{
			RequestFilterFields = "Loan  No.";
			column(ReportForNavId_1; 1) {} // Autogenerated by ForNav - Do not delete
			trigger OnAfterGetRecord();
			begin
				// Monthlysavingsetup.RESET;
				// Monthlysavingsetup.SETRANGE(Monthlysavingsetup.code,'1');
				// IF Monthlysavingsetup.
				//Loans."Approved Amount":=0;
				//MESSAGE (FORMAT(Loans."Approved Amount"));
				 if ( Loans."Approved Amount" >= 10000) and ( Loans."Approved Amount" < 500000)  then begin
				   Saving1:=2000;
				 end else
				  if ( Loans."Approved Amount" > 500001) and ( Loans."Approved Amount" <= 1000000)  then begin
				   Saving1:=5000;
				 end else
				 if ( Loans."Approved Amount" > 1000001) and ( Loans."Approved Amount" <= 2000000)  then begin
				   Saving1:=7500;
				 end else
				 if ( Loans."Approved Amount" > 2000001) and ( Loans."Approved Amount" <= 4000000)  then begin
				   Saving1:=10000;
				 end else
				 if ( Loans."Approved Amount" > 4000001) and ( Loans."Approved Amount" <= 6000000)  then begin
				   Saving1:=15000;
				 end else
				 if ( Loans."Approved Amount" > 6000001) and ( Loans."Approved Amount" < 50000000)  then begin
				   Saving1:=20000;
				 end ;
				//MESSAGE('saving is %1',Saving1);
				Loans."Monthly Contribution":=Saving1;
				Loans.Modify;
				/*
				Monthlysavingsetup.GET();
				IF Monthlysavingsetup.code = '1' THEN
				  BEGIN
				 IF ( Loans."Approved Amount" > Monthlysavingsetup."Min saving") OR ( Loans."Approved Amount" < Monthlysavingsetup."Max saving")  THEN
				   Saving1:=Monthlysavingsetup."Monthly Saving Amount";
				 END ELSE
				IF Monthlysavingsetup.code = '2' THEN
				  BEGIN
				 IF ( Loans."Approved Amount" > Monthlysavingsetup."Min saving") OR ( Loans."Approved Amount" < Monthlysavingsetup."Max saving")  THEN
				   Saving1:=Monthlysavingsetup."Monthly Saving Amount";
				 END ELSE
				IF Monthlysavingsetup.code = '3' THEN
				  BEGIN
				 IF ( Loans."Approved Amount" > Monthlysavingsetup."Min saving") OR ( Loans."Approved Amount" < Monthlysavingsetup."Max saving")  THEN
				   Saving1:=Monthlysavingsetup."Monthly Saving Amount";
				 END ELSE
				IF Monthlysavingsetup.code = '4' THEN
				  BEGIN
				 IF ( Loans."Approved Amount" > Monthlysavingsetup."Min saving") OR ( Loans."Approved Amount" < Monthlysavingsetup."Max saving")  THEN
				   Saving1:=Monthlysavingsetup."Monthly Saving Amount";
				 END ELSE
				IF Monthlysavingsetup.code = '5' THEN
				  BEGIN
				 IF ( Loans."Approved Amount" > Monthlysavingsetup."Min saving") OR ( Loans."Approved Amount" < Monthlysavingsetup."Max saving")  THEN
				   Saving1:=Monthlysavingsetup."Monthly Saving Amount";
				 END ELSE
				IF Monthlysavingsetup.code = '6' THEN
				  BEGIN
				 IF ( Loans."Approved Amount" > Monthlysavingsetup."Min saving") OR ( Loans."Approved Amount" < Monthlysavingsetup."Max saving")  THEN
				   Saving1:=Monthlysavingsetup."Monthly Saving Amount";
				 END;
				 */
			
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
		saving6: Decimal;
		saving5: Decimal;
		saving4: Decimal;
		Saving3: Decimal;
		saving2: Decimal;
		Saving1: Decimal;
		Monthlysavingsetup: Record "Monthly  saving setup";

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516288_v6_3_0_2259;
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
