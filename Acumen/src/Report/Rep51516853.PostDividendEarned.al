#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516853_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516853 "Post Dividend Earned"
{
	RDLCLayout = './Layouts/PostDividendEarned.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Member Register";"Member Register")
		{
			DataItemTableView = sorting("No.");
			RequestFilterFields = "No.",Status,"Customer Type";
			column(ReportForNavId_7301; 7301) {} // Autogenerated by ForNav - Do not delete
			column(FORMAT_TODAY_0_4_; Format(Today,0,4))
			{
			}
			column(COMPANYNAME; COMPANYNAME)
			{
			}
			column(CurrReport_PAGENO; Format(ReportForNav.PageNo))
			{
			}
			column(UserId; UserId)
			{
			}
			column(Members__No__; "Member Register"."No.")
			{
			}
			column(Members_Name; "Member Register".Name)
			{
			}
			column(Members__Current_Shares_; "Member Register"."Current Shares")
			{
			}
			column(CustomerCaption; CustomerCaptionLbl)
			{
			}
			column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
			{
			}
			column(Members__No__Caption; FieldCaption("No."))
			{
			}
			column(Members_NameCaption; FieldCaption(Name))
			{
			}
			column(Members__Current_Shares_Caption; FieldCaption("Current Shares"))
			{
			}
			trigger OnPreDataItem();
			begin
				LastFieldNo := FieldNo("No.");
			end;
			
			trigger OnAfterGetRecord();
			var
				ObjMembers: Record "Member Register";
				DivOnRetainedShares: Decimal;
			begin
			end;
			
		}
	}

	requestpage
	{

  
		SaveValues = false;	  layout
		{
			area(content)
			{
				field(StartDate;StartDate)
				{
					ApplicationArea = Basic;
				}
				field(EndDate;EndDate)
				{
					ApplicationArea = Basic;
				}
				field(PostingDate;PostingDate)
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
	var
		ObjMembers: Record "Member Register";
		DivOnRetainedShares: Decimal;
		GrossLessCommisionAndTax: Decimal;
		DividedendCapitalized: Decimal;
		DividendNetPayable: Decimal;
	begin
		//Delete journal
		Gnljnline.Reset;
		Gnljnline.SetRange("Journal Template Name",'GENERAL');
		Gnljnline.SetRange("Journal Batch Name",'SHARES2016');
		if Gnljnline.Find('-') then
		Gnljnline.DeleteAll;
		SDATE:='..'+Format(EndDate);
		ObjMembers.Reset;
		ObjMembers.SetFilter(ObjMembers."Date Filter",SDATE);
		if ObjMembers.Find('-') then begin
		  repeat
		DivTotal:=0;
		Tax:=0;
		GenSetUp.Get(0);
		RunBal:=0;
		DivTotal:=0;
		DivTotal2:=0;
		DivOnRetainedShares:=0;
		GrossLessCommisionAndTax:=0;
		Tax:=0;
		GenSetUp.Get(0);
		ObjMembers.CalcFields(ObjMembers."Current Shares",ObjMembers."Shares Retained");
		DivOnRetainedShares:=DivTotal+((GenSetUp."Dividend (%)"/100)*Abs(ObjMembers."Shares Retained"));
		DivTotal:=DivTotal+((GenSetUp."Dividend (%)"/100)*Abs(ObjMembers."Shares Retained"));
		DivTotal2:=DivTotal2+((GenSetUp."Interest on Deposits (%)"/100)*Abs(ObjMembers."Current Shares"));
		TotalDiv:=DivTotal+DivTotal2;
		Tax:=Tax+((GenSetUp."Withholding Tax (%)"/100)*Abs(TotalDiv));
		ObjMembers."Shares Variance":=ObjMembers."Current Shares"+ObjMembers."Shares Retained";
		ObjMembers."Tax on Dividend":=Tax;
		ObjMembers."Div Amount":=TotalDiv;
		ObjMembers."Qualifying Shares":=Abs(ObjMembers."Shares Retained");
		ObjMembers."Current Shares":=Abs(ObjMembers."Current Shares");
		ObjMembers."Dividend Withholding Tax":=Tax;
		ObjMembers."Gross Dividend Amount Payable":=TotalDiv;
		GrossLessCommisionAndTax:=TotalDiv-(Tax+GenSetUp."Dividend Processing Fee");
		if(Abs(ObjMembers."Shares Retained") < GenSetUp."Retained Shares") and (GrossLessCommisionAndTax >0) then begin
		DividedendCapitalized:=  FnCaptalizeDividend(GrossLessCommisionAndTax,ObjMembers."Shares Retained",GenSetUp."Retained Shares"-ObjMembers."Shares Retained");
		ObjMembers."Dividend Capitalized":=DividedendCapitalized;
		end;
		if (GrossLessCommisionAndTax-DividedendCapitalized) >= 0 then begin
		  DividendNetPayable:=GrossLessCommisionAndTax-DividedendCapitalized;
		ObjMembers."Net Dividend Payable":=DividendNetPayable;
		  end;
		//ObjMembers.MODIFY;
			if GrossLessCommisionAndTax > 0 then begin
			 /* RunBal:=ObjMembers."Net Dividend Payable";
			  FnInsertMemberDividendsOrDepositInterest(ObjMembers,DivOnRetainedShares,'Dividend awarded',GenSetUp."Dividend Payable Account");
			  FnInsertMemberDividendsOrDepositInterest(ObjMembers,DivTotal2,'Interest on Deposist','100593');
			  FnTransferGrossDividendsToFOSA(ObjMembers);
			  FnRecoverCapitalizedAmount(ObjMembers);
			  FnRecoverTaxWithHeldBySACCO(ObjMembers);
			  FnRecoverSaccoCommission(ObjMembers);
			  RunBal:=FnRunOutstandingLoanBalance(ObjMembers."No.",RunBal,ObjMembers."FOSA Account No.");
			  */
			  FnSaveDividendAwarded(ObjMembers);
			 end;
			  until ObjMembers.Next=0;
		end;
		;ReportsForNavPre;

	end;
	var
		CustomerCaptionLbl: label 'Customer';
		CurrReport_PAGENOCaptionLbl: label 'Page';
		LastFieldNo: Integer;
		FooterPrinted: Boolean;
		Cust: Record "Member Register";
		StartDate: Date;
		DateFilter: Text[100];
		FromDate: Date;
		ToDate: Date;
		FromDateS: Text[100];
		ToDateS: Text[100];
		DivTotal: Decimal;
		GenSetUp: Record "Sacco General Set-Up";
		CDeposits: Decimal;
		CustDiv: Record "Member Register";
		DivProg: Record "Dividends Progression";
		CDiv: Decimal;
		BDate: Date;
		Tax: Decimal;
		TotalDiv: Decimal;
		GenJournalLine: Record "Gen. Journal Line";
		DivTotal2: Decimal;
		LineNo: Integer;
		Vend: Record Vendor;
		PostingDate: Date;
		RunBal: Decimal;
		LoanApp: Record "Loans Register";
		Gnljnline: Record "Gen. Journal Line";
		SaccoCommisionCharged: Decimal;
		SDATE: Text;
		EndDate: Date;

	local procedure FnCaptalizeDividend(GrossDividend: Decimal;CurrentSharesRetained: Decimal;DifferencePayable: Decimal): Decimal
	var
		CaptalizedAmount: Decimal;
	begin
		CaptalizedAmount:=2000;
		if GrossDividend < DifferencePayable then begin
		if GrossDividend > 2000 then begin
		  CaptalizedAmount:=2000;
		  end
		  else
		  begin
			CaptalizedAmount:=GrossDividend;
			end;
		  end
		  else
		  begin
			if DifferencePayable >2000 then begin
			  CaptalizedAmount:=2000;
			  end
			  else
			  begin
				CaptalizedAmount:=DifferencePayable;
				end;
			end;
		exit(CaptalizedAmount);
	end;

	local procedure FnRunOutstandingLoanBalance(MemberNo: Code[50];RunningBalance: Decimal;FosaAcc: Code[50]) NewRunningBalance: Decimal
	var
		varTotalRepay: Decimal;
		varMultipleLoan: Decimal;
		varLRepayment: Decimal;
	begin
		if RunningBalance > 0 then begin
		varTotalRepay:=0;
		varMultipleLoan:=0;
		LoanApp.Reset;
		LoanApp.SetCurrentkey(Source,"Issued Date","Loan Product Type","Client Code","Staff No","Employer Code");
		LoanApp.SetRange(LoanApp."Client Code",MemberNo);
		LoanApp.SetFilter(LoanApp."Loan Product Type",'%1|%2','FL354','FL364');
		if LoanApp.Find('-') then begin
		  repeat
			if  RunningBalance > 0 then
			  begin
				LoanApp.CalcFields(LoanApp."Outstanding Balance");
				if LoanApp."Outstanding Balance" > 0 then
				  begin
					varLRepayment:=0;
					varLRepayment:=LoanApp."Outstanding Balance";
					if varLRepayment >0 then
					  begin
						if varLRepayment>LoanApp."Outstanding Balance" then
						   varLRepayment:=LoanApp."Outstanding Balance";
						  LineNo:=LineNo+1;
						  Gnljnline.Init;
						  Gnljnline."Journal Template Name":='GENERAL';
						  Gnljnline."Journal Batch Name":='SHARES2016';
						  Gnljnline."Document No.":='DIVIDEND';
						  Gnljnline."Line No.":=LineNo;
						  Gnljnline."Account Type":=Gnljnline."account type"::Employee;
						  Gnljnline."Account No.":=LoanApp."Client Code";
						  Gnljnline.Validate(Gnljnline."Account No.");
						  Gnljnline."Posting Date":=PostingDate;
						  Gnljnline.Description:=LoanApp."Loan Product Type"+'-Loan Repayment-from dividend';
						if RunningBalance > 0 then
						  begin
							if RunningBalance > varLRepayment then
							  begin
								  Gnljnline.Amount:=varLRepayment*-1;
								end
							else
								 Gnljnline.Amount:=RunningBalance*-1;
							end;
						Gnljnline.Validate(Gnljnline.Amount);
						Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Interest Paid";
						Gnljnline."Loan No":=LoanApp."Loan  No.";
						Gnljnline."Shortcut Dimension 1 Code":='BOSA';
						Gnljnline."Shortcut Dimension 2 Code":=FnGetMemberBranch(LoanApp."Client Code");
						Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
						Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
						if Gnljnline.Amount<>0 then
						Gnljnline.Insert;
						LineNo:=LineNo+1;
						  Gnljnline.Init;
						  Gnljnline."Journal Template Name":='GENERAL';
						  Gnljnline."Journal Batch Name":='SHARES2016';
						  Gnljnline."Document No.":='DIVIDEND';
						  Gnljnline."Line No.":=LineNo;
						  Gnljnline."Account Type":=Gnljnline."account type"::Vendor;
						  Gnljnline."Account No.":=FosaAcc;
						  Gnljnline.Validate(Gnljnline."Account No.");
						  Gnljnline."Posting Date":=PostingDate;
						  Gnljnline.Description:=LoanApp."Loan Product Type"+'-Loan Repayment-from dividend';
						if RunningBalance > 0 then
						  begin
							if RunningBalance > varLRepayment then
							  begin
								  Gnljnline.Amount:=varLRepayment;
								  RunningBalance:=RunningBalance-Abs(varLRepayment);
								end
							else
							begin
								 Gnljnline.Amount:=RunningBalance;
								RunningBalance:=RunningBalance-Abs(RunningBalance);
							end;
							end;
						Gnljnline.Validate(Gnljnline.Amount);
						Gnljnline."Shortcut Dimension 1 Code":='FOSA';
						Gnljnline."Shortcut Dimension 2 Code":=FnGetMemberBranch(LoanApp."Client Code");
						Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
						Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
						if Gnljnline.Amount<>0 then
						Gnljnline.Insert;
					  end;
				 end;
			end;
		until LoanApp.Next = 0;
		end;
		exit(RunningBalance);
		end;
	end;

	local procedure FnGetMemberBranch(MemberNo: Code[50]): Code[100]
	var
		MemberBranch: Code[100];
	begin
		Cust.Reset;
		Cust.SetRange(Cust."No.",MemberNo);
		if Cust.Find('-') then begin
		  MemberBranch:=Cust."Global Dimension 2 Code";
		  end;
		exit(MemberBranch);
	end;

	local procedure FnGetFosaAccountNo(MNO: Code[50]) FosaAcc: Code[50]
	var
		ObjVendor: Record Vendor;
	begin
		ObjVendor.Reset;
		ObjVendor.SetRange(ObjVendor."BOSA Account No",MNO);
		ObjVendor.SetFilter(ObjVendor."Account Type",'ORDINARY');
		if ObjVendor.Find() then begin
		  FosaAcc:=ObjVendor."No.";
		  end;
		  exit(FosaAcc);
	end;

	local procedure FnInsertMemberDividendsOrDepositInterest(ObjMember: Record "Member Register";TotalDividendsOnSharecapital: Decimal;Narrative: Text;BalAccount: Code[50])
	begin
		LineNo:=LineNo+1;
		GenJournalLine.Init;
		GenJournalLine."Journal Template Name":='GENERAL';
		GenJournalLine."Journal Batch Name":='SHARES2016';
		GenJournalLine."Document No.":='DIVIDEND';
		GenJournalLine."Line No.":=LineNo;
		GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
		GenJournalLine."Account No.":=ObjMember."No.";
		GenJournalLine.Validate(GenJournalLine."Account No.");
		GenJournalLine."Posting Date":=PostingDate;
		GenJournalLine.Description:=Narrative;
		GenJournalLine.Validate(GenJournalLine."Currency Code");
		GenJournalLine.Amount:=-TotalDividendsOnSharecapital;
		GenJournalLine.Validate(GenJournalLine.Amount);
		GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
		GenJournalLine."Bal. Account No.":=BalAccount;
		GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
		GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Additional Shares";
		GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
		GenJournalLine."Shortcut Dimension 2 Code":=ObjMember."Global Dimension 2 Code";
		GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
		if GenJournalLine.Amount<>0 then
		GenJournalLine.Insert;
	end;

	local procedure FnTransferGrossDividendsToFOSA(ObjMember: Record "Member Register")
	begin
		//CREDIT FOSA WITH GROSS DIVIDENDS
		LineNo:=LineNo+1;
		GenJournalLine.Init;
		GenJournalLine."Journal Template Name":='GENERAL';
		GenJournalLine."Journal Batch Name":='SHARES2016';
		GenJournalLine."Document No.":='DIVIDEND';
		GenJournalLine."Line No.":=LineNo;
		GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
		GenJournalLine."Account No.":=ObjMember."FOSA Account No.";
		GenJournalLine.Validate(GenJournalLine."Account No.");
		GenJournalLine."Posting Date":=PostingDate;
		GenJournalLine.Description:='Gross Dividends transfered from Member A/c';
		GenJournalLine.Validate(GenJournalLine."Currency Code");
		GenJournalLine.Amount:=-(ObjMember."Gross Dividend Amount Payable");
		GenJournalLine.Validate(GenJournalLine.Amount);
		GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
		GenJournalLine."Shortcut Dimension 2 Code":=ObjMember."Global Dimension 2 Code";
		GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
		if GenJournalLine.Amount<>0 then
		GenJournalLine.Insert;
		//DEBIT MEMBER WITH GROSS DIVIDEND
		LineNo:=LineNo+1;
		GenJournalLine.Init;
		GenJournalLine."Journal Template Name":='GENERAL';
		GenJournalLine."Journal Batch Name":='SHARES2016';
		GenJournalLine."Document No.":='DIVIDEND';
		GenJournalLine."Line No.":=LineNo;
		GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
		GenJournalLine."Account No.":=ObjMember."No.";
		GenJournalLine.Validate(GenJournalLine."Account No.");
		GenJournalLine."Posting Date":=PostingDate;
		GenJournalLine.Description:='Gross Dividends transfered to FOSA A/c';
		GenJournalLine.Validate(GenJournalLine."Currency Code");
		GenJournalLine.Amount:=(ObjMember."Gross Dividend Amount Payable");
		GenJournalLine.Validate(GenJournalLine.Amount);
		GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Additional Shares";
		GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
		GenJournalLine."Shortcut Dimension 2 Code":=ObjMember."Global Dimension 2 Code";
		GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
		if GenJournalLine.Amount<>0 then
		GenJournalLine.Insert;
	end;

	local procedure FnRecoverCapitalizedAmount(ObjMember: Record "Member Register")
	begin
		//CREDIT MEMBER SHARECAPITAL FROM FOSA
		LineNo:=LineNo+1;
		GenJournalLine.Init;
		GenJournalLine."Journal Template Name":='GENERAL';
		GenJournalLine."Journal Batch Name":='SHARES2016';
		GenJournalLine."Document No.":='DIVIDEND';
		GenJournalLine."Line No.":=LineNo;
		GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
		GenJournalLine."Account No.":=ObjMember."No.";
		GenJournalLine.Validate(GenJournalLine."Account No.");
		GenJournalLine."Posting Date":=PostingDate;
		GenJournalLine.Description:='Share Capital Recovered from Dividend';
		GenJournalLine.Validate(GenJournalLine."Currency Code");
		GenJournalLine.Amount:=-(ObjMember."Dividend Capitalized");
		GenJournalLine.Validate(GenJournalLine.Amount);
		GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Recovery Account";
		GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
		GenJournalLine."Shortcut Dimension 2 Code":=ObjMember."Global Dimension 2 Code";
		GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
		if GenJournalLine.Amount<>0 then
		GenJournalLine.Insert;
		//DEBIT FOSA WITH RECOVERED SHARECAPITAL
		LineNo:=LineNo+1;
		GenJournalLine.Init;
		GenJournalLine."Journal Template Name":='GENERAL';
		GenJournalLine."Journal Batch Name":='SHARES2016';
		GenJournalLine."Document No.":='DIVIDEND';
		GenJournalLine."Line No.":=LineNo;
		GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
		GenJournalLine."Account No.":=ObjMember."FOSA Account No.";
		GenJournalLine.Validate(GenJournalLine."Account No.");
		GenJournalLine."Posting Date":=PostingDate;
		GenJournalLine.Description:='Captalized Share Capital';
		GenJournalLine.Validate(GenJournalLine."Currency Code");
		GenJournalLine.Amount:=(ObjMember."Dividend Capitalized");
		GenJournalLine.Validate(GenJournalLine.Amount);
		GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
		GenJournalLine."Shortcut Dimension 2 Code":=ObjMember."Global Dimension 2 Code";
		GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
		if GenJournalLine.Amount<>0 then
		GenJournalLine.Insert;
	end;

	local procedure FnRecoverTaxWithHeldBySACCO(ObjMember: Record "Member Register")
	begin
		LineNo:=LineNo+1;
		GenJournalLine.Init;
		GenJournalLine."Journal Template Name":='GENERAL';
		GenJournalLine."Journal Batch Name":='SHARES2016';
		GenJournalLine."Document No.":='DIVIDEND';
		GenJournalLine."Line No.":=LineNo;
		GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
		GenJournalLine."Account No.":=ObjMember."FOSA Account No.";
		GenJournalLine.Validate(GenJournalLine."Account No.");
		GenJournalLine."Posting Date":=PostingDate;
		GenJournalLine.Description:='Dividends Withholding Tax';
		GenJournalLine.Validate(GenJournalLine."Currency Code");
		GenJournalLine.Amount:=Tax;
		GenJournalLine.Validate(GenJournalLine.Amount);
		GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
		GenJournalLine."Bal. Account No.":=GenSetUp."WithHolding Tax Account";
		GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
		GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
		GenJournalLine."Shortcut Dimension 2 Code":=ObjMember."Global Dimension 2 Code";
		GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
		if GenJournalLine.Amount<>0 then
		GenJournalLine.Insert;
	end;

	local procedure FnRecoverSaccoCommission(ObjMember: Record "Member Register")
	begin
		LineNo:=LineNo+1;
		GenJournalLine.Init;
		GenJournalLine."Journal Template Name":='GENERAL';
		GenJournalLine."Journal Batch Name":='SHARES2016';
		GenJournalLine."Document No.":='DIVIDEND';
		GenJournalLine."Line No.":=LineNo;
		GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
		GenJournalLine."Account No.":=ObjMember."FOSA Account No.";
		GenJournalLine.Validate(GenJournalLine."Account No.");
		GenJournalLine."Posting Date":=PostingDate;
		GenJournalLine.Description:='Commision Charged on Dividend Processing';
		GenJournalLine.Validate(GenJournalLine."Currency Code");
		GenJournalLine.Amount:=GenSetUp."Dividend Processing Fee"*(1-0.1);
		GenJournalLine.Validate(GenJournalLine.Amount);
		GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
		GenJournalLine."Bal. Account No.":=GenSetUp."Dividend Process Fee Account";
		GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
		GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
		GenJournalLine."Shortcut Dimension 2 Code":=ObjMember."Global Dimension 2 Code";
		GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
		if GenJournalLine.Amount<>0 then
		GenJournalLine.Insert;
		//RECOVER 10% EXCISE DUTY COMMISION
		LineNo:=LineNo+1;
		GenJournalLine.Init;
		GenJournalLine."Journal Template Name":='GENERAL';
		GenJournalLine."Journal Batch Name":='SHARES2016';
		GenJournalLine."Document No.":='DIVIDEND';
		GenJournalLine."Line No.":=LineNo;
		GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
		GenJournalLine."Account No.":=ObjMember."FOSA Account No.";
		GenJournalLine.Validate(GenJournalLine."Account No.");
		GenJournalLine."Posting Date":=PostingDate;
		GenJournalLine.Description:='10% Excise Duty on Commision Charged';
		GenJournalLine.Validate(GenJournalLine."Currency Code");
		GenJournalLine.Amount:=0.1*GenSetUp."Dividend Processing Fee";
		GenJournalLine.Validate(GenJournalLine.Amount);
		GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
		GenJournalLine."Bal. Account No.":=GenSetUp."Excise Duty Account";
		GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
		GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
		GenJournalLine."Shortcut Dimension 2 Code":=ObjMember."Global Dimension 2 Code";
		GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
		if GenJournalLine.Amount<>0 then
		GenJournalLine.Insert;
	end;

	local procedure FnSaveDividendAwarded(ObjMember: Record "Member Register")
	var
		ObjDividendAwarded: Record "Dividends Paid";
	begin
		ObjDividendAwarded.Reset;
		ObjDividendAwarded.SetRange(ObjDividendAwarded."Member No",ObjMember."No.");
		ObjDividendAwarded.SetRange(ObjDividendAwarded."Dividend year",'2016');
		if ObjDividendAwarded.Find('-') then
		  ObjDividendAwarded.DeleteAll;
		/*ObjDividendAwarded.INIT;
		ObjDividendAwarded."Member No":=ObjMember."No.";
		ObjDividendAwarded."Dividend year":='2016';
		ObjDividendAwarded."Member Name":=ObjMember.Name;
		ObjDividendAwarded.Amount:=ObjMember."Net Dividend Payable";
		ObjDividendAwarded."Account No.":=ObjMember."FOSA Account No.";
		ObjDividendAwarded.Message:='Dear '+ObjMember.Name+', KES '+FORMAT(ROUND(ObjMember."Net Dividend Payable",0.05,'>'))+' has been credited to your FOSA a/c as dividend.Together we Prosper. OLLIN SACCO LTD';
		ObjDividendAwarded.INSERT;*/

	end;

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516853_v6_3_0_2259;
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
