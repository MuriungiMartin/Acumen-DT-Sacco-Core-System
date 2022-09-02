#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516366_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516366 "Recover Defaulted Loans-Share"
{
	UsageCategory = Tasks;
	RDLCLayout = './Layouts/RecoverDefaultedLoans-Share.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Member Register";"Member Register")
		{
			column(ReportForNavId_1000000000; 1000000000) {} // Autogenerated by ForNav - Do not delete
			trigger OnAfterGetRecord();
			begin
				GenLedgerSetup.Get;
				"Loan&int":=0;
				////////
				Loanapp.Reset;
				Loanapp.SetRange(Loanapp."Client Code","Member Register"."No.");
				if Loanapp.Find('-') then begin
				  repeat
				  Loanapp.CalcFields(Loanapp."Outstanding Balance");
					if Loanapp."Outstanding Balance">200 then begin
					appotbal:=SHARES+instlnclr;
					  if (Loanapp."Outstanding Balance")>0 then begin
					  TOTALLOANS:=SHARES
					  end else
					  TOTALLOANS:=(Loanapp."Outstanding Balance");
						if Loanapp."Loan Product Type"='DIVADV' then begin
				//////
				if Cust.Get("Member Register"."No.") then begin
				  Cust.SetRange(Cust."No.",Loanapp."Client Code");
				  Cust.CalcFields(Cust."Current Shares",Cust."Outstanding Balance");
				  //TOTALLOANS:=Cust."Outstanding Balance";
				 // SHARES:=TOTALLOANS;
				  Message('CUSTOMER %1',SHARES);
				  Message('LOAN BAL %1',TOTALLOANS);
				  RunBal:=Cust."Dividend Amount"*-1;
					Gnljnline.Init;
					Gnljnline."Journal Template Name":='GENERAL';
					Gnljnline."Journal Batch Name":='DAF';
					Gnljnline."Line No.":=LineN+450;
					Gnljnline."Account Type":=Gnljnline."account type"::Vendor;
					Gnljnline."Account No.":=Cust."FOSA Account";
					Gnljnline.Validate(Gnljnline."Account No.");
					Gnljnline."Document No.":='DIVAD';
					Gnljnline."Posting Date":=Today;
					Gnljnline.Description:='Dividend-Loan Offset';
					Gnljnline.Amount:=SHARES;
					Gnljnline.Validate(Gnljnline.Amount);
					Gnljnline."Transaction Type":=Gnljnline."transaction type"::Dividend;
					Gnljnline."Loan No":=Loanapp."Loan  No.";
					if Gnljnline.Amount<>0 then
					//Gnljnline.INSERT;
				//END;
				//IF Loanapp."Loan Product Type"<>'INTARR' THEN BEGIN
							//NETSHARES:=SHARES-instlnclr;
							  if (Loanapp."Outstanding Balance")>0 then begin
								 Message('runbal %1',TOTALLOANS);
								  Gnljnline.Init;
								  Gnljnline."Journal Template Name":='GENERAL';
								  Gnljnline."Journal Batch Name":='DAF';
								  Gnljnline."Line No.":=LineN;
								  Gnljnline."Account Type":=Gnljnline."account type"::Vendor;
								  Gnljnline."Account No.":=Cust."FOSA Account";
								  Gnljnline.Validate(Gnljnline."Account No.");
								  Gnljnline."Document No.":='DIVAD';
								  Gnljnline."Posting Date":=Today;
								  Gnljnline.Description:='Loan Repayment';
								  Gnljnline.Amount:=TOTALLOANS*-1;
								  //Gnljnline."External Document No.":=GenBatches."Slip/Rcpt No";
								  Gnljnline.Validate(Gnljnline.Amount);
								  Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Loan Repayment";
								  Gnljnline."Loan No":=Loanapp."Loan  No.";
									  if Gnljnline.Amount<>0 then
								  Gnljnline.Insert;
								 LineN:=LineN+300;
								end;
						  end;
						end;
					//END;
				  ////
				end;
				/*
				LineN:=LineN+10000;
				IF instlnclr<> 0 THEN BEGIN
					Gnljnline.INIT;
					Gnljnline."Journal Template Name":='GENERAL';
					Gnljnline."Journal Batch Name":='DAF';
					Gnljnline."Line No.":=LineN;
					Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::Employee;
					Gnljnline."Account No.":=Cust."No.";
					Gnljnline.VALIDATE(Gnljnline."Account No.");
					Gnljnline."Document No.":='120';
					Gnljnline."Posting Date":=TODAY;
					Gnljnline.Description:='Loan Repayment';
					  IF SHARES>instlnclr THEN BEGIN
						Gnljnline.Amount:=instlnclr*-1;
						END ELSE
						  IF SHARES<instlnclr THEN
							Gnljnline.Amount:=SHARES*-1;
							Gnljnline.VALIDATE(Gnljnline.Amount);
							Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Interest Paid";
							Gnljnline."Loan No":=Loanapp."Loan  No.";
							  IF Gnljnline.Amount<>0 THEN
								Gnljnline.INSERT;
								LineN:=LineN+300;
								LineN:=LineN+10000;*/
				//END;
				until Loanapp.Next=0;
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
		LastFieldNo: Integer;
		FooterPrinted: Boolean;
		PDate: Date;
		Interest: Decimal;
		GenSetUp: Record "Sacco General Set-Up";
		TextDateFormula2: Text[30];
		TextDateFormula1: Text[30];
		DateFormula2: DateFormula;
		DateFormula1: DateFormula;
		Vend: Record Vendor;
		LoanGuar: Record "Loans Guarantee Details";
		Lbal: Decimal;
		Cust: Record "Member Register";
		GenJournalLine: Record "Gen. Journal Line";
		GenLedgerSetup: Record "General Ledger Setup";
		Hesabu: Integer;
		Loanapp: Record "Loans Register";
		"Loan&int": Decimal;
		TotDed: Decimal;
		LoanType: Record "Loan Products Setup";
		Available: Decimal;
		Distributed: Decimal;
		WINDOW: Dialog;
		PostingCode: Codeunit "Gen. Jnl.-Post Line";
		SHARES: Decimal;
		TOTALLOANS: Decimal;
		Gnljnline: Record "Gen. Journal Line";
		LineN: Integer;
		instlnclr: Decimal;
		appotbal: Decimal;
		LOANAMOUNT: Decimal;
		PRODATA: Decimal;
		LOANAMOUNT2: Decimal;
		TOTALLOANSB: Decimal;
		NETSHARES: Decimal;
		Tinst: Decimal;
		Finst: Decimal;
		Floans: Decimal;
		RunBal: Decimal;
		NEWRUNBAL: Decimal;

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516366_v6_3_0_2259;
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