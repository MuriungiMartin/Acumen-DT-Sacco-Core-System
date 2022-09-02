#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516140_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516140 "Paybill Transactions rep"
{
	RDLCLayout = './Layouts/PaybillTransactionsrep.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("File Movement Header";"File Movement Header")
		{
			column(ReportForNavId_1000000000; 1000000000) {} // Autogenerated by ForNav - Do not delete
			column(CI_Name; CI.Name)
			{
				IncludeCaption = true;
			}
			column(CI_Address; CI.Address)
			{
				IncludeCaption = true;
			}
			column(CI_Address2; CI."Address 2")
			{
				IncludeCaption = true;
			}
			column(CI_PhoneNo; CI."Phone No.")
			{
				IncludeCaption = true;
			}
			column(CI_Picture; CI.Picture)
			{
				IncludeCaption = true;
			}
			column(CI_City; CI.City)
			{
				IncludeCaption = true;
			}
			column(DOCNAME; DOCNAME)
			{
			}
			column(No_SaccoTransfers; "File Movement Header"."No.")
			{
			}
			column(TransactionDate_SaccoTransfers; Format("File Movement Header"."File Number"))
			{
			}
			column(ScheduleTotal_SaccoTransfers; "File Movement Header"."File Name")
			{
			}
			column(Approved_SaccoTransfers; "File Movement Header"."Account No.")
			{
			}
			column(ApprovedBy_SaccoTransfers; "File Movement Header"."Account Name")
			{
			}
			column(Posted_SaccoTransfers; "File Movement Header"."Date Requested")
			{
			}
			column(NoSeries_SaccoTransfers; "File Movement Header"."Requested By")
			{
			}
			column(ResponsibilityCenter_SaccoTransfers; "File Movement Header"."Date Retrieved")
			{
			}
			column(Remarks_SaccoTransfers; "File Movement Header"."Responsiblity Center")
			{
			}
			column(SourceAccountType_SaccoTransfers; "File Movement Header"."Expected Return Date")
			{
			}
			column(SourceAccountNo_SaccoTransfers; "File Movement Header"."Duration Requested")
			{
			}
			column(SourceTransactionType_SaccoTransfers; "File Movement Header"."Date Returned")
			{
			}
			column(SourceAccountName_SaccoTransfers; "File Movement Header"."File Location")
			{
			}
			column(SourceLoanNo_SaccoTransfers; "File Movement Header"."Current File Location")
			{
			}
			column(CreatedBy_SaccoTransfers; "File Movement Header"."Retrieved By")
			{
			}
			column(Debit_SaccoTransfers; "File Movement Header"."Returned By")
			{
			}
			column(Refund_SaccoTransfers; "File Movement Header"."Global Dimension 1 Code")
			{
			}
			column(GuarantorRecovery_SaccoTransfers; "File Movement Header"."Global Dimension 2 Code")
			{
			}
			column(PayrolNo_SaccoTransfers; "File Movement Header".Status)
			{
			}
			column(GlobalDimension1Code_SaccoTransfers; "File Movement Header"."User ID")
			{
			}
			column(GlobalDimension2Code_SaccoTransfers; "File Movement Header"."Issuing File Location")
			{
			}
			column(BosaNumber_SaccoTransfers; "File Movement Header"."No. Series")
			{
			}
			column(Status_SaccoTransfers; "File Movement Header".Status)
			{
			}
			column(NumberText_1_; NumberText[1])
			{
			}
			dataitem("File Movement Line";"File Movement Line")
			{
				DataItemLink = "Document No."=field("No.");
				column(ReportForNavId_1000000001; 1000000001) {} // Autogenerated by ForNav - Do not delete
				column(No_SaccoTransfersSchedule; "File Movement Line"."Document No.")
				{
				}
				column(DestinationAccountNo_SaccoTransfersSchedule; "File Movement Line"."File Type")
				{
				}
				column(DestinationAccountName_SaccoTransfersSchedule; "File Movement Line"."Account Type")
				{
				}
				column(DestinationAccountType_SaccoTransfersSchedule; "File Movement Line"."Account No.")
				{
				}
				column(DestinationType_SaccoTransfersSchedule; "File Movement Line"."Purpose/Description")
				{
				}
				column(DestinationLoan_SaccoTransfersSchedule; "File Movement Line"."Global Dimension 1 Code")
				{
				}
				column(Amount_SaccoTransfersSchedule; "File Movement Line"."Global Dimension 2 Code")
				{
				}
				column(Description_SaccoTransfersSchedule; "File Movement Line"."Account Name")
				{
				}
				column(CreatedBy_SaccoTransfersSchedule; "File Movement Line"."File Number")
				{
				}
				column(CummulativeTotalPaymentLoan_SaccoTransfersSchedule; "File Movement Line"."Line No.")
				{
				}
				column(Credit_SaccoTransfersSchedule; "File Movement Line"."Destination File Location")
				{
				}
				column(GlobalDimension1Code_SaccoTransfersSchedule; "File Movement Line"."Global Dimension 1 Code")
				{
				}
				column(GlobalDimension2Code_SaccoTransfersSchedule; "File Movement Line"."Global Dimension 2 Code")
				{
				}
			}
			trigger OnPreDataItem();
			begin
				CI.Get();
				CI.CalcFields(CI.Picture);
			end;
			
			trigger OnAfterGetRecord();
			begin
				"File Movement Header".CalcFields("File Movement Header"."File Name");
				CheckReport.InitTextVariable();
				CheckReport.FormatNoText(NumberText,"File Movement Header"."File Name",' ');
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
		CI.Get();
		CI.CalcFields(CI.Picture);
		;ReportsForNavPre;
	end;
	var
		StrCopyText: Text[30];
		LastFieldNo: Integer;
		FooterPrinted: Boolean;
		DimVal: Record "Dimension Value";
		DimValName: Text[30];
		TTotal: Decimal;
		CheckReport: Report Check;
		NumberText: array [2] of Text[80];
		STotal: Decimal;
		InvoiceCurrCode: Code[10];
		CurrCode: Code[10];
		GLSetup: Record "General Ledger Setup";
		DOCNAME: Text[30];
		VATCaptionLbl: label 'VAT';
		PAYMENT_DETAILSCaptionLbl: label 'PAYMENT DETAILS';
		AMOUNTCaptionLbl: label 'AMOUNT';
		NET_AMOUNTCaptionLbl: label 'AMOUNT';
		W_TAXCaptionLbl: label 'W/TAX';
		Document_No___CaptionLbl: label 'Document No. :';
		Currency_CaptionLbl: label 'Currency:';
		Payment_To_CaptionLbl: label 'Payment To:';
		Document_Date_CaptionLbl: label 'Document Date:';
		Cheque_No__CaptionLbl: label 'Cheque No.:';
		R_CENTERCaptionLbl: label 'R.CENTER CODE';
		PROJECTCaptionLbl: label 'PROJECT CODE';
		TotalCaptionLbl: label 'Total';
		Printed_By_CaptionLbl: label 'Printed By:';
		Amount_in_wordsCaptionLbl: label 'Amount in words';
		EmptyStringCaptionLbl: label '================================================================================================================================================================================================';
		EmptyStringCaption_Control1102755013Lbl: label '================================================================================================================================================================================================';
		Amount_in_wordsCaption_Control1102755021Lbl: label 'Amount in words';
		Printed_By_Caption_Control1102755026Lbl: label 'Printed By:';
		TotalCaption_Control1102755033Lbl: label 'Total';
		Signature_CaptionLbl: label 'Signature:';
		Date_CaptionLbl: label 'Date:';
		Name_CaptionLbl: label 'Name:';
		RecipientCaptionLbl: label 'Recipient';
		CompanyInfo: Record "Company Information";
		BudgetLbl: label 'Budget';
		CreationDoc: Boolean;
		DtldVendEntry: Record "Detailed Vendor Ledg. Entry";
		InvNo: Code[20];
		InvAmt: Decimal;
		ApplyEnt: Record "Vendor Ledger Entry";
		VendEnrty: Record "Vendor Ledger Entry";
		CI: Record "Company Information";

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516140_v6_3_0_2259;
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