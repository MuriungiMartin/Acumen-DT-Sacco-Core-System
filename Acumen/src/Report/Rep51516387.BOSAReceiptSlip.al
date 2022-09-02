#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516387_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516387 "BOSA Receipt Slip"
{
	RDLCLayout = './Layouts/BOSAReceiptSlip.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Receipts & Payments";"Receipts & Payments")
		{
			RequestFilterFields = "Transaction No.","Account No.",Amount,"Cheque No.","Employer No.";
			column(ReportForNavId_1102755000; 1102755000) {} // Autogenerated by ForNav - Do not delete
			column(TransactionNo_ReceiptsPayments; "Receipts & Payments"."Transaction No.")
			{
			}
			column(NumberText_1_; NumberText[1])
			{
			}
			column(AccountNo_ReceiptsPayments; "Receipts & Payments"."Account No.")
			{
			}
			column(Name_ReceiptsPayments; "Receipts & Payments".Name)
			{
			}
			column(Amount_ReceiptsPayments; "Receipts & Payments".Amount)
			{
			}
			column(ChequeNo_ReceiptsPayments; "Receipts & Payments"."Cheque No.")
			{
			}
			column(ChequeDate_ReceiptsPayments; "Receipts & Payments"."Cheque Date")
			{
			}
			column(Posted_ReceiptsPayments; "Receipts & Payments".Posted)
			{
			}
			column(BankNo_ReceiptsPayments; "Receipts & Payments"."Employer No.")
			{
			}
			column(UserID_ReceiptsPayments; "Receipts & Payments"."User ID")
			{
			}
			column(AllocatedAmount_ReceiptsPayments; "Receipts & Payments"."Allocated Amount")
			{
			}
			column(TransactionDate_ReceiptsPayments; Format("Receipts & Payments"."Transaction Date"))
			{
			}
			column(TransactionTime_ReceiptsPayments; "Receipts & Payments"."Transaction Time")
			{
			}
			column(NoSeries_ReceiptsPayments; "Receipts & Payments"."No. Series")
			{
			}
			column(AccountType_ReceiptsPayments; "Receipts & Payments"."Account Type")
			{
			}
			column(TransactionSlipType_ReceiptsPayments; "Receipts & Payments"."Transaction Slip Type")
			{
			}
			column(BankName_ReceiptsPayments; "Receipts & Payments"."Bank Name")
			{
			}
			column(Insuarance_ReceiptsPayments; "Receipts & Payments".Insuarance)
			{
			}
			column(ReceiptMode; "Receipts & Payments"."Receipt Mode")
			{
			}
			column(id_no; Cust."ID No.")
			{
			}
			column(emp_no; Cust."Personal No")
			{
			}
			column(UnallocatedAmount_ReceiptsPayments; "Receipts & Payments"."Un allocated Amount")
			{
			}
			column(User; "Receipts & Payments"."User ID")
			{
			}
			column(Remarks_ReceiptsPayments; "Receipts & Payments".Remarks)
			{
			}
			column(CompanyName; companyInfo.Name)
			{
			}
			column(CompanyAddress; companyInfo.Address)
			{
			}
			column(CompanyCity; companyInfo.City)
			{
			}
			column(CompanyPhoneNo; companyInfo."Phone No.")
			{
			}
			column(CompanyPicture; companyInfo.Picture)
			{
			}
			dataitem("Receipt Allocation";"Receipt Allocation")
			{
				DataItemLink = "Document No"=field("Transaction No.");
				column(ReportForNavId_1102755001; 1102755001) {} // Autogenerated by ForNav - Do not delete
				column(DocumentNo_ReceiptAllocation; "Receipt Allocation"."Document No")
				{
				}
				column(MemberNo_ReceiptAllocation; "Receipt Allocation"."Member No")
				{
				}
				column(TransactionType_ReceiptAllocation; "Receipt Allocation"."Transaction Type")
				{
				}
				column(LoanNo_ReceiptAllocation; "Receipt Allocation"."Loan No.")
				{
				}
				column(Amount_ReceiptAllocation; "Receipt Allocation".Amount)
				{
				}
				column(InterestAmount_ReceiptAllocation; "Receipt Allocation"."Interest Amount")
				{
				}
				column(TotalAmount_ReceiptAllocation; "Receipt Allocation"."Total Amount")
				{
				}
				column(AmountBalance_ReceiptAllocation; "Receipt Allocation"."Amount Balance")
				{
				}
				column(InterestBalance_ReceiptAllocation; "Receipt Allocation"."Interest Balance")
				{
				}
				column(LoanID_ReceiptAllocation; "Receipt Allocation"."Loan ID")
				{
				}
				column(PrepaymentDate_ReceiptAllocation; "Receipt Allocation"."Prepayment Date")
				{
				}
				column(LoanInsurance_ReceiptAllocation; "Receipt Allocation"."Loan Insurance")
				{
				}
				column(AppliedAmount_ReceiptAllocation; "Receipt Allocation"."Applied Amount")
				{
				}
				column(Insurance_ReceiptAllocation; "Receipt Allocation".Insurance)
				{
				}
				column(UnAllocatedAmount_ReceiptAllocation; "Receipt Allocation"."Un Allocated Amount")
				{
				}
				column(GlobalDimension1Code_ReceiptAllocation; "Receipt Allocation"."Global Dimension 1 Code")
				{
				}
				column(GlobalDimension2Code_ReceiptAllocation; "Receipt Allocation"."Global Dimension 2 Code")
				{
				}
				column(LoanProduct; LoanProduct)
				{
				}
				trigger OnAfterGetRecord();
				begin
					LoanProduct:='';
					if "Receipt Allocation"."Loan No."<>'' then begin
					  if LoansRec.Get("Receipt Allocation"."Loan No.") then begin
						LoanProduct:=LoansRec."Loan Product Type Name";
					  end;
					end;
				end;
				
			}
			trigger OnPreDataItem();
			begin
				companyInfo.Get();
				companyInfo.CalcFields(companyInfo.Picture);
			end;
			
			trigger OnAfterGetRecord();
			begin
				if Cust.Get("Receipts & Payments"."Account No.") then
				Comms:=0;
				//IF CashPayType.GET("Receipts & Payments"."Cash Window Pay Type") THEN
				//Comms:=CashPayType.Description;
				CheckReport.InitTextVariable();
				CheckReport.FormatNoText(NumberText,Amount,' ');
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
		Cust: Record "Member Register";
		Comms: Decimal;
		CashPayType: Record "HR Leave Family Employees";
		companyInfo: Record "Company Information";
		NumberText: array [2] of Text[80];
		LastFieldNo: Integer;
		CheckReport: Report Check;
		LoanProduct: Code[20];
		LoansRec: Record "Loans Register";

	procedure CalAvailableBal()
	begin
	end;

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516387_v6_3_0_2259;
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
