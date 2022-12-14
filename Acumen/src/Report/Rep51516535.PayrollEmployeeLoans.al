#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516535_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516535 "Payroll Employee Loans"
{
	RDLCLayout = './Layouts/PayrollEmployeeLoans.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Payroll Employee Transactions.";"Payroll Employee Transactions.")
		{
			column(ReportForNavId_1000000000; 1000000000) {} // Autogenerated by ForNav - Do not delete
			trigger OnPreDataItem();
			begin
				//LoanType:='';
			end;
			
			trigger OnAfterGetRecord();
			begin
				 Loans.Reset;
				 Loans.SetRange(Loans."Client Code","Payroll Employee Transactions."."No.");
				 if Loans.Find('-') then begin
				 repeat
				  //IF Loans.Deductible=TRUE THEN  BEGIN
				   Loans.CalcFields(Loans."Outstanding Balance");
				   if Loans."Outstanding Balance">0 then begin
				   LoanType:=Loans."Loan Product Type";
				   // IF "Payroll Employee Transactions."."Loan Number"<>Loans."Loan  No." THEN
					Transaction.Reset;
					 Transaction.SetRange(Transaction."Transaction Type",Transaction."transaction type"::Deduction);
					 Transaction.SetRange(Transaction."Formula for Management Prov",LoanType);
					 if Transaction.Find('-') then begin
					  TCode:=Transaction."Transaction Code";
					  Tname:=Transaction."Transaction Name";
					  TType:=Transaction."Transaction Type";
				   "Payroll Employee Transactions.".Init;
				   "Payroll Employee Transactions."."No.":=Loans."Client Code";
				   "Payroll Employee Transactions."."Sacco Membership No.":=Loans."Client Code";
				   "Payroll Employee Transactions."."Transaction Code":=TCode;
				   "Payroll Employee Transactions."."Transaction Name":=Tname;
				   "Payroll Employee Transactions."."Transaction Type":=TType;
				   "Payroll Employee Transactions."."Loan Number":=Loans."Loan  No.";
				   "Payroll Employee Transactions."."Period Month":=10;
				   "Payroll Employee Transactions."."Period Year":=2016;
				   "Payroll Employee Transactions.".Insert;
				   end;
				   end;
				until Loans.Next=0;
				//END;
				end;
				//ELSE
				//CurrReport.SKIP;
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
		Loans: Record "Loans Register";
		Transaction: Record "Payroll Transaction Code.";
		LoanType: Code[30];
		TCode: Code[30];
		Tname: Text;
		TType: Option Income,Deduction;
		LoanSetup: Record "Loan Products Setup";
		Deductable: Boolean;

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516535_v6_3_0_2259;
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
