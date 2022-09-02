#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516537_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516537 "Insert to Emp Transactions"
{
	RDLCLayout = './Layouts/InserttoEmpTransactions.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Loans Register";"Loans Register")
		{
			column(ReportForNavId_1000000000; 1000000000) {} // Autogenerated by ForNav - Do not delete
			column(LoanNo; "Loans Register"."Loan  No.")
			{
			}
			column(ProductType; "Loans Register"."Loan Product Type")
			{
			}
			trigger OnAfterGetRecord();
			begin
				"Loans Register".Reset;
				if "Loans Register".Deductible=true then begin
				Transaction.Reset;
				Transaction.SetRange(Transaction."Formula for Management Prov","Loans Register"."Loan Product Type");
				if Transaction.Find('-') then
				  TCode:=Transaction."Transaction Code";
				  Tname:=Transaction."Transaction Name";
				  TType:=Transaction."Transaction Type";
				  //EmpTrans.SETRANGE(EmpTrans."No.",Employees."No.");
				Employees.Reset;
				if not Employees.Get("Loans Register"."Client Code") then CurrReport.Skip;
				repeat
				EmpTrans.Init;
				EmpTrans."Transaction Code":=TCode;
				EmpTrans."No.":="Loans Register"."Client Code";
				EmpTrans.Insert;
				until EmpTrans.Next=0;
				EmpTrans.Reset;
				EmpTrans.SetRange(EmpTrans."No.","Loans Register"."Client Code");
				if EmpTrans.Find('-') then begin
				EmpTrans."Loan Number":="Loans Register"."Loan  No.";
				EmpTrans.Modify;
				end;
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
		EmpTrans: Record "Payroll Employee Transactions.";
		Employees: Record "Payroll Employee.";

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516537_v6_3_0_2259;
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
