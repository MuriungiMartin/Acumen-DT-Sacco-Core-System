#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516422_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516422 "Process Dividends"
{
	UsageCategory = ReportsAndAnalysis;
	RDLCLayout = './Layouts/ProcessDividends.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Dividends Paid";"Dividends Paid")
		{
			column(ReportForNavId_1000000000; 1000000000) {} // Autogenerated by ForNav - Do not delete
			trigger OnAfterGetRecord();
			begin
				/*//SMS MESSAGE
				SMSMessage.RESET;
				IF SMSMessage.FIND('+') THEN BEGIN
				iEntryNo:=SMSMessage."Entry No";
				iEntryNo:=iEntryNo+1;
				END
				ELSE BEGIN
				iEntryNo:=1;
				END;
				SMSMessage.INIT;
				SMSMessage."Entry No":=iEntryNo;
				SMSMessage."Batch No":='GENERAL';
				SMSMessage."Document No":='SHARES2016';
				SMSMessage."Account No":="Account No.";
				SMSMessage."Date Entered":=TODAY;
				SMSMessage."Time Entered":=TIME;
				SMSMessage.Source:='DIVIDENDS';
				SMSMessage."Entered By":=USERID;
				SMSMessage."System Created Entry":=TRUE;
				SMSMessage."Sent To Server":=SMSMessage."Sent To Server"::No;
				SMSMessage."SMS Message":="Dividends Paid".Message;
				Vend.RESET;
				Vend.SETRANGE(Vend."No.","Dividends Paid"."Account No.");
				IF Vend.FIND('-') THEN
				  BEGIN
					IF Vend."Mobile Phone No"<> '' THEN
					  BEGIN
						SMSMessage."Telephone No":=Vend."Mobile Phone No";
					  END ELSE
					  BEGIN
						SMSMessage."Telephone No":=Vend."Phone No.";
					  END;
				  MessageFailed:=FALSE;
				  StrTel:=COPYSTR(SMSMessage."Telephone No",1,3);
				  IF StrTel<>'254' THEN
					BEGIN
					  MessageFailed:=TRUE;
					END;
				  IF STRLEN(SMSMessage."Telephone No")<>12 THEN
					BEGIN
					  MessageFailed:=TRUE;
					END;
				  IF MessageFailed=TRUE THEN
					BEGIN
					  SMSMessage."Sent To Server":=SMSMessage."Sent To Server"::Failed;
					END;
					SMSMessage.INSERT;
				"Dividends Paid"."Message Sent":=TRUE;
				IF "Dividends Paid".Amount <>0 THEN
				"Dividends Paid".MODIFY;
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
		/*Gnljnline.RESET;
		Gnljnline.SETRANGE("Journal Template Name",'GENERAL');
		Gnljnline.SETRANGE("Journal Batch Name",'SHARES2016');
		IF Gnljnline.FIND('-') THEN BEGIN
		CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch",Gnljnline);
		END;
		*/
		;ReportsForNavPre;

	end;
	var
		SMSMessage: Record "SMS Messages";
		StrTel: Text[100];
		MessageFailed: Boolean;
		iEntryNo: Integer;
		Vend: Record Vendor;
		Gnljnline: Record "Gen. Journal Line";

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516422_v6_3_0_2259;
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
