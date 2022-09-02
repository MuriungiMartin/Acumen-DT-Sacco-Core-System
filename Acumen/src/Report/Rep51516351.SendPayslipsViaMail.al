#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516351_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516351 "Send Payslips Via Mail"
{
	UsageCategory = Tasks;
	RDLCLayout = './Layouts/SendPayslipsViaMail.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Payroll Employee.";"Payroll Employee.")
		{
			column(ReportForNavId_1102755000; 1102755000) {} // Autogenerated by ForNav - Do not delete
			column(No; "Payroll Employee."."No.")
			{
			}
			trigger OnPreDataItem();
			begin
				//HrEmps.SETRANGE(HrEmps."Contract Type",Contracttype);
			end;
			
			trigger OnAfterGetRecord();
			begin
				SMTPSetup.Get;
				Emps.Reset;
				Emps.SetRange(Emps."No.","Payroll Employee."."No.");
				//Emps.SETRANGE(Emps."Contract Type",Emps."Contract Type"::Contract);
				Emps.SetRange(Emps.Status,Emps.Status::Active);
				if Emps.Find('-') then begin
				//IF Emps."E-Mail"='' THEN ERROR ('Please insert the email in employee no.' +' '+ Emps."No.");
				if Emps."Employee Email"<> '' then
				repeat
				 //EmpEmail:=HrEmps."E-Mail";
				//END;
				SalCard.Reset;
				SalCard.SetRange(SalCard."No.",Emps."No.");
				//hazina SalCard.SETRANGE(SalCard."Period Filter",SelectedPeriod);
				if SalCard.Find('-') then begin
				//IF EXISTS(Filename) THEN
				//ERASE(Filename);
				Filename:='';
				Filename:= SMTPSetup."Path to Save Report"+'Payslips.pdf';
				Report.SaveAsPdf(Report::"Payroll Payslip Sacco",Filename,SalCard);
				SMTPMail.CreateMessage(SMTPSetup."Email Sender Name",SMTPSetup."Email Sender Address",Emps."Employee Email",'Payslips','',true);
				//SMTPMail.AppendBody('************DO NOT REPLY*************');
				//SMTPMail.AppendBody('<br><br>');
				SMTPMail.AppendBody('Dear Staff,');
				SMTPMail.AppendBody('<br><br>');
				SMTPMail.AppendBody('Please find attached your Payslip');// for the month of January 2014');
				SMTPMail.AppendBody('<br><br>');
				SMTPMail.AppendBody('Enjoy.');
				SMTPMail.AppendBody('<br><br>');
				SMTPMail.AppendBody('Regards');
				//SMTPMail.AppendBody('Safaricom Investment Coop');
				SMTPMail.AppendBody('<br><br>');
				SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
				SMTPMail.AppendBody('<br><br>');
				SMTPMail.AppendBody('<HR>');
				//SMTPMail.AppendBody('blaaaPlease find attached your payslip');
				//SMTPMail.AppendBody('<br><br>');
				//SMTPMail.AppendBody('This is a system generated mail. Please do not reply to this email ID.');
				SMTPMail.AddAttachment(Filename,Attachment);
				SMTPMail.Send;
				//IF EXISTS(Filename) THEN
				//ERASE(Filename);
				end;
				//END;
				until Emps.Next=0;
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
				field(SelectedPeriod;SelectedPeriod)
				{
					ApplicationArea = Basic;
					Caption = 'Period Filter';
					TableRelation = "Payroll Calender."."Date Opened";
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
		Filename: Text[100];
		SMTPSetup: Record "SMTP Mail Setup";
		SMTPMail: Codeunit "SMTP Mail";
		SalCard: Record "Payroll Employee.";
		Attachment: Text[250];
		EmpEmail: Text;
		HrEmps: Record "Salary Processing Header";
		objPeriod: Record "Payroll Calender.";
		SelectedPeriod: Date;
		Contracttype: Option Contract;
		Emps: Record "Payroll Employee.";

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516351_v6_3_0_2259;
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
