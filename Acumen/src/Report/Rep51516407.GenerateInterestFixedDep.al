#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516407_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516407 "Generate Interest-Fixed Dep."
{
	UsageCategory = Tasks;
	RDLCLayout = './Layouts/GenerateInterest-FixedDep..rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem(Vendor;Vendor)
		{
			DataItemTableView = where("Account Type"=filter('FIXED'),Balance=filter(<>0),"Fixed Deposit Start Date"=filter(<>''));
			RequestFilterFields = "No.","Expected Maturity Date";
			column(ReportForNavId_1102755000; 1102755000) {} // Autogenerated by ForNav - Do not delete
			trigger OnPreDataItem();
			begin
				GenJournalLine.Reset;
				GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
				GenJournalLine.SetRange("Journal Batch Name",'INTCALC');
				GenJournalLine.DeleteAll;
				DocNo := 'INT EARNED';
				if PDate = 0D then
				PDate := Today;
				InterestBuffer.Reset;
				if InterestBuffer.Find('+') then
				IntBufferNo:=InterestBuffer.No;
			end;
			
			trigger OnAfterGetRecord();
			begin
				IntRate:=0;
				AccruedInt:=0;
				MidMonthFactor:=1;
				MinBal:=false;
				RIntDays:=IntDays;
				AsAt:=PostStart;
				//Account."Not Qualify for Interest":=FALSE;
				//Account.MODIFY;
				//IF Vendor."FD Maturity Date"=TODAY THEN BEGIN
				if "FD Maturity Date"<Today then begin
				RIntDays:="Fixed Deposit Start Date"-"FD Maturity Date"
				end else
				RIntDays:="Fixed Deposit Start Date"-Today;
				if  AccountType.Get(Vendor."Account Type") then begin
				FXDCODE:=AccountType.Code;
				//MESSAGE('THE FXD CODE IS %1',AccountType.Code);
				if AccountType."Earns Interest" = true then begin
				Account.Reset;
				Account.SetRange(Account."No.",Vendor."No.");
				//Account.SETFILTER(Account."Date Filter",DFilter);
				if Account.Find('-') then begin
				if (Account."Account Type"='FIXED') or (Account."Account Type"='FIXED')  then begin
				Account.CalcFields(Account."Balance (LCY)");
				Bal:=Account."Balance (LCY)";
				DBALANCE:=ROUND(((3/1200)*Bal)*1,0.05,'=');
				//MESSAGE('THE Bal IS %1',Bal);
				end;
				Message('RIntDays IS %1',RIntDays);
				if "FD Maturity Date"<Today then begin
				PDate:="FD Maturity Date"
				end else
				PDate:=Today;
				/*
				FixedDtype.RESET;
				FixedDtype.SETRANGE(FixedDtype.Code,Vendor."Fixed Deposit Type");
				IF FixedDtype.FIND('-') THEN BEGIN
				 REPEAT
				FXDCODE:=FixedDtype.Code;
				//MESSAGE('THE FXD CODE IS %1',FixedDtype.Code);
				FDInterestCalc.RESET;
				FDInterestCalc.SETRANGE(FDInterestCalc.Code,Vendor."Fixed Deposit Type");
				IF FDInterestCalc.FIND('-') THEN BEGIN
				REPEAT
				//IF (Bal>=FDInterestCalc."Minimum Amount") AND (Bal<=FDInterestCalc."Maximum Amount") THEN BEGIN
				Rate:="Interest rate";
				MESSAGE('the rate is %1',Rate);
				DURATION:=Vendor."FD Duration";
				//FXDINterest:=ROUND(((Bal*Rate/100)/12)*DURATION,1);
				FXDINterest:=ROUND(((Bal*Rate/100)/365),1);
				MESSAGE('THE DURATION IS %1',DURATION);
				MESSAGE('the comp interest is %1',FXDINterest);
				UNTIL FDInterestCalc.NEXT=0;
				END;
				UNTIL FixedDtype.NEXT=0;
				END;
				*/
				Rate:="Interest rate";
				//MESSAGE('the rate is %1',Rate);
				DURATION:=Vendor."FD Duration";
				//FXDINterest:=ROUND(((Bal*Rate/100)/12)*DURATION,1);
				FXDINterest:=ROUND(((Bal*Rate/100)/365)*RIntDays,1);
				//MESSAGE('THE DURATION IS %1',DURATION);
				//MESSAGE('the comp interest is %1',FXDINterest);
				AccruedInt:=FXDINterest;
				//IF (AccruedInt>0)  THEN BEGIN
				LineNo:=LineNo+10000;
				GenJournalLine.Init;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Journal Batch Name":='INTCALC';
				GenJournalLine."Document No.":=DocNo;
				GenJournalLine."External Document No.":=Vendor."No.";
				GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
				GenJournalLine."Account No.":=AccountType."Interest Expense Account";
				GenJournalLine.Validate(GenJournalLine."Account No.");
				if "FD Maturity Date"<Today then begin
				GenJournalLine."Posting Date":="FD Maturity Date"
				end else
				GenJournalLine."Posting Date":=PDate;
				GenJournalLine.Description:=Vendor.Name;
				GenJournalLine.Validate(GenJournalLine."Currency Code");
				//IF AccountType."Fixed Deposit" = TRUE THEN
				//GenJournalLine.Amount:=AccruedInt
				//ELSE
				//AccruedInt:=AccruedInt+ROUND(((IntRate/1200)*Bal)*MidMonthFactor,0.05,'>');
				GenJournalLine.Amount:=AccruedInt;
				GenJournalLine.Validate(GenJournalLine.Amount);
				GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
				GenJournalLine."Bal. Account No.":=AccountType."Interest Payable Account";
				GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
				GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
				GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
				GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
				GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
				//IF GenJournalLine.Amount<>0 THEN
				GenJournalLine.Insert;
				/*//POST WITHHOLDING TAX
				GenSetUp.GET();
				LineNo:=LineNo+10000;
				GenJournalLine.INIT;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Journal Batch Name":='INTCALC';
				GenJournalLine."Document No.":=DocNo;
				GenJournalLine."External Document No.":=Vendor."No.";
				GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
				GenJournalLine."Account No.":=GenSetUp."WithHolding Tax Account";
				GenJournalLine.VALIDATE(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PDate;
				GenJournalLine.Description:='Witholding Tax on Int';
				GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
				//IF AccountType."Fixed Deposit" = TRUE THEN
				GenJournalLine.Amount:=-AccruedInt*0.15;
				//ELSE
				//GenJournalLine.Amount:=ROUND(((IntRate/1200)*Vendor."Balance (LCY)")*MidMonthFactor*0.15,0.05,'>');
				GenJournalLine.VALIDATE(GenJournalLine.Amount);
				//enJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
				//GenJournalLine."Bal. Account No.":=;
				//GenJournalLine."Bal. Account No.":=AccountType."Interest Payable Account";
				GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
				GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
				GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
				GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
				GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
				//IF GenJournalLine.Amount<>0 THEN
				GenJournalLine.INSERT;
				*/
				/*
				//POST FXD TO ACCOUNT
				LineNo:=LineNo+10000;
				GenJournalLine.INIT;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Journal Batch Name":='INTCALC';
				GenJournalLine."Document No.":=DocNo;
				GenJournalLine."External Document No.":=Vendor."No.";
				GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
				GenJournalLine."Account No.":=Vendor."No.";
				GenJournalLine."Account No.":=Vendor."No.";
				GenJournalLine.VALIDATE(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PDate;
				GenJournalLine.Description:='FXD Interest';
				GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=-(AccruedInt-(AccruedInt*0.15));
				GenJournalLine.VALIDATE(GenJournalLine.Amount);
				GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
				GenJournalLine."Bal. Account No.":=AccountType."Interest Payable Account";
				GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
				IF GenJournalLine.Amount<>0 THEN
				GenJournalLine.INSERT;
				*/
				 //INTEREST BUFFER
				/*
				//Post
				GenJournalLine.RESET;
				GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
				GenJournalLine.SETRANGE("Journal Batch Name",'INTCALC');
				IF GenJournalLine.FIND('-') THEN BEGIN
				REPEAT
				GLPosting.RUN(GenJournalLine);
				UNTIL GenJournalLine.NEXT = 0;
				END;
				GenJournalLine.RESET;
				GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
				GenJournalLine.SETRANGE("Journal Batch Name",'INTCALC');
				GenJournalLine.DELETEALL;
				//Post
					  */
				 //INTEREST BUFFER
				IntBufferNo:=IntBufferNo+1;
				InterestBuffer.Init;
				InterestBuffer.No:=IntBufferNo;
				InterestBuffer."Account No":=Vendor."No.";
				InterestBuffer."Account Type":=Vendor."Account Type";
				InterestBuffer."Interest Date":=PDate;
				//IF AccountType."Fixed Deposit" = TRUE THEN
				InterestBuffer."Interest Amount":=AccruedInt*-1;
				//ELSE
				//InterestBuffer."Interest Amount":=ROUND(((IntRate/1200)*Vendor."Balance (LCY)")*MidMonthFactor,0.05,'>');
				InterestBuffer."User ID":=UserId;
				if InterestBuffer."Interest Amount" <> 0 then
				InterestBuffer.Insert(true);
				//END;
				end;
				end;
				end;
				//END;
			
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
		GenJournalLine: Record "Gen. Journal Line";
		GLPosting: Codeunit "Gen. Jnl.-Post Line";
		Account: Record Vendor;
		AccountType: Record "Account Types-Saving Products";
		LineNo: Integer;
		ChequeType: Record "Cheque Types";
		FDInterestCalc: Record "FD Interest Calculation Crite";
		InterestBuffer: Record "Interest Buffer";
		IntRate: Decimal;
		DocNo: Code[10];
		PDate: Date;
		IntBufferNo: Integer;
		MidMonthFactor: Decimal;
		DaysInMonth: Integer;
		StartDate: Date;
		IntDays: Integer;
		AsAt: Date;
		MinBal: Boolean;
		AccruedInt: Decimal;
		RIntDays: Integer;
		Bal: Decimal;
		DFilter: Text[50];
		FixedDtype: Record "Fixed Deposit Type";
		DURATION: Integer;
		Dfilter2: Date;
		Dfilter3: Text[30];
		PostStart: Date;
		PostEnd: Date;
		DBALANCE: Decimal;
		FXDCODE: Code[20];
		Rate: Decimal;
		FXDINterest: Decimal;
		FXD: Record "Fixed Deposit Type";
		FDDURATION: DateFormula;
		FDINTEREST: Decimal;
		FXDLINE: Record "FD Interest Calculation Crite";
		DURATION2: Decimal;
		"Maturity Status": Option "Roll Back","Close Account","Transfer Interest";
		GnlJnlline: Record "Gen. Journal Line";
		GenSetUp: Record "Sacco General Set-Up";

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516407_v6_3_0_2259;
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
