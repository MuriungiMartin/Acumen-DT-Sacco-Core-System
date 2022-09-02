#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516874_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516874 "Checkoff Reconcilliation"
{
	RDLCLayout = './Layouts/CheckoffReconcilliation.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Checkoff Lines-Distributed";"Checkoff Lines-Distributed")
		{
			DataItemTableView = sorting("Receipt Header No","Entry No");
			RequestFilterFields = "Staff/Payroll No","Receipt Header No";
			column(ReportForNavId_1; 1) {} // Autogenerated by ForNav - Do not delete
			column(StaffPayrollNo_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Staff/Payroll No")
			{
			}
			column(Amount_CheckoffLinesDistributed; "Checkoff Lines-Distributed".Amount)
			{
			}
			column(NoRepayment_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."No Repayment")
			{
			}
			column(StaffNotFound_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Staff Not Found")
			{
			}
			column(DateFilter_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Date Filter")
			{
			}
			column(TransactionDate_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Transaction Date")
			{
			}
			column(EntryNo_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Entry No")
			{
			}
			column(Generated_CheckoffLinesDistributed; "Checkoff Lines-Distributed".Generated)
			{
			}
			column(PaymentNo_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Payment No")
			{
			}
			column(Posted_CheckoffLinesDistributed; "Checkoff Lines-Distributed".Posted)
			{
			}
			column(MultipleReceipts_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Multiple Receipts")
			{
			}
			column(Name_CheckoffLinesDistributed; "Checkoff Lines-Distributed".Name)
			{
			}
			column(EarlyRemitances_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Early Remitances")
			{
			}
			column(EarlyRemitanceAmount_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Early Remitance Amount")
			{
			}
			column(LoanNo_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Loan No.")
			{
			}
			column(MemberNo_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Member No.")
			{
			}
			column(Interest_CheckoffLinesDistributed; "Checkoff Lines-Distributed".Interest)
			{
			}
			column(LoanType_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Loan Type")
			{
			}
			column(DEPT_CheckoffLinesDistributed; "Checkoff Lines-Distributed".DEPT)
			{
			}
			column(ExpectedAmount_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Expected Amount")
			{
			}
			column(FOSAAccount_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."FOSA Account")
			{
			}
			column(TransType_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Trans Type")
			{
			}
			column(TransactionType_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Transaction Type")
			{
			}
			column(SpecialCode_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Special Code")
			{
			}
			column(Accounttype_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Account type")
			{
			}
			column(Variance_CheckoffLinesDistributed; "Checkoff Lines-Distributed".Variance)
			{
			}
			column(EmployerCode_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Employer Code")
			{
			}
			column(GPersonalNo_CheckoffLinesDistributed; "Checkoff Lines-Distributed".GPersonalNo)
			{
			}
			column(Gnames_CheckoffLinesDistributed; "Checkoff Lines-Distributed".Gnames)
			{
			}
			column(Gnumber_CheckoffLinesDistributed; "Checkoff Lines-Distributed".Gnumber)
			{
			}
			column(Userid1_CheckoffLinesDistributed; "Checkoff Lines-Distributed".Userid1)
			{
			}
			column(LoansNotfound_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Loans Not found")
			{
			}
			column(ReceiptHeaderNo_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Receipt Header No")
			{
			}
			column(Source_CheckoffLinesDistributed; "Checkoff Lines-Distributed".Source)
			{
			}
			column(AdvisedAmount; AdvisedAmount)
			{
			}
			trigger OnAfterGetRecord();
			begin
				// DataSheetLinesDist.RESET;
				// DataSheetLinesDist.SETRANGE(DataSheetLinesDist."Payroll No","Checkoff Lines-Distributed"."Staff/Payroll No");
				// IF DataSheetLinesDist.FIND('-') THEN BEGIN
				//  AdvisedAmount:=DataSheetLinesDist.Amount;
				//  END;
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
		DataSheetLinesDist: Record "Data Sheet Lines-Dist";
		AdvisedAmount: Decimal;

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516874_v6_3_0_2259;
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
