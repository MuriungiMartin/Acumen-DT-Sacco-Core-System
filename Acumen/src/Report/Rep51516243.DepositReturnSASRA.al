#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516243_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516243 "Deposit Return-SASRA"
{
	UsageCategory = ReportsAndAnalysis;
	RDLCLayout = './Layouts/DepositReturn-SASRA.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem(Members;"Member Register")
		{
			column(ReportForNavId_7301; 7301) {} // Autogenerated by ForNav - Do not delete
			column(ASAT; ASAT)
			{
			}
			column(CompanyInfo__E_Mail_; CompanyInfo."E-Mail")
			{
			}
			column(COMPANYNAME; COMPANYNAME)
			{
			}
			column(CompanyInfo_Address; CompanyInfo.Address)
			{
			}
			column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
			{
			}
			column(CompanyInfo__Fax_No__; CompanyInfo."Fax No.")
			{
			}
			column(BAL1; BAL1)
			{
			}
			column(BAL2; BAL2)
			{
			}
			column(BAL3; BAL3)
			{
			}
			column(BAL4; BAL4)
			{
			}
			column(BAL5; BAL5)
			{
			}
			column(COUNT1; COUNT1)
			{
			}
			column(COUNT2; COUNT2)
			{
			}
			column(COUNT3; COUNT3)
			{
			}
			column(COUNT4; COUNT4)
			{
			}
			column(COUNT5; COUNT5)
			{
			}
			column(ACOUNT1; ACOUNT1)
			{
			}
			column(ABAL1; ABAL1)
			{
			}
			column(ACOUNT2; ACOUNT2)
			{
			}
			column(ABAL2; ABAL2)
			{
			}
			column(ACOUNT3; ACOUNT3)
			{
			}
			column(ABAL3; ABAL3)
			{
			}
			column(ACOUNT4; ACOUNT4)
			{
			}
			column(ABAL4; ABAL4)
			{
			}
			column(ACOUNT5; ACOUNT5)
			{
			}
			column(ABAL5; ABAL5)
			{
			}
			column(FACOUNT1; FACOUNT1)
			{
			}
			column(FABAL1; FABAL1)
			{
			}
			column(FACOUNT2; FACOUNT2)
			{
			}
			column(FABAL2; FABAL2)
			{
			}
			column(FACOUNT3; FACOUNT3)
			{
			}
			column(FABAL3; FABAL3)
			{
			}
			column(FACOUNT4; FACOUNT4)
			{
			}
			column(FABAL4; FABAL4)
			{
			}
			column(FACOUNT5; FACOUNT5)
			{
			}
			column(FABAL5; FABAL5)
			{
			}
			column(GRANDCOUNT; GRANDCOUNT)
			{
			}
			column(GrandTotal; GrandTotal)
			{
			}
			column(No_Caption; No_CaptionLbl)
			{
			}
			column(RangeCaption; RangeCaptionLbl)
			{
			}
			column(Type_of_DepositCaption; Type_of_DepositCaptionLbl)
			{
			}
			column(Amount_Kshs__000_Caption; Amount_Kshs__000_CaptionLbl)
			{
			}
			column(No__of_A_CsCaption; No__of_A_CsCaptionLbl)
			{
			}
			column(FORM_3Caption; FORM_3CaptionLbl)
			{
			}
			column(SASRA_2_003Caption; SASRA_2_003CaptionLbl)
			{
			}
			column(STATEMENT_OF_DEPOSIT_RETURNCaption; STATEMENT_OF_DEPOSIT_RETURNCaptionLbl)
			{
			}
			column(CS_2375Caption; CS_2375CaptionLbl)
			{
			}
			column(Date_Caption; Date_CaptionLbl)
			{
			}
			column(R__24_Caption; R__24_CaptionLbl)
			{
			}
			column(V1Caption; V1CaptionLbl)
			{
			}
			column(V4Caption; V4CaptionLbl)
			{
			}
			column(V2Caption; V2CaptionLbl)
			{
			}
			column(V3Caption; V3CaptionLbl)
			{
			}
			column(V5Caption; V5CaptionLbl)
			{
			}
			column(Less_than_50_000Caption; Less_than_50_000CaptionLbl)
			{
			}
			column(V50_000_to_100_000Caption; V50_000_to_100_000CaptionLbl)
			{
			}
			column(V100_000_to_300_000Caption; V100_000_to_300_000CaptionLbl)
			{
			}
			column(V300_000_to_1_000_000Caption; V300_000_to_1_000_000CaptionLbl)
			{
			}
			column(Over_1_000_000Caption; Over_1_000_000CaptionLbl)
			{
			}
			column(Non_WithdrawableCaption; Non_WithdrawableCaptionLbl)
			{
			}
			column(SavingsCaption; SavingsCaptionLbl)
			{
			}
			column(TermCaption; TermCaptionLbl)
			{
			}
			column(TermCaption_Control1102756014; TermCaption_Control1102756014Lbl)
			{
			}
			column(SavingsCaption_Control1102756015; SavingsCaption_Control1102756015Lbl)
			{
			}
			column(Non_WithdrawableCaption_Control1102756016; Non_WithdrawableCaption_Control1102756016Lbl)
			{
			}
			column(TermCaption_Control1102756017; TermCaption_Control1102756017Lbl)
			{
			}
			column(SavingsCaption_Control1102756018; SavingsCaption_Control1102756018Lbl)
			{
			}
			column(Non_WithdrawableCaption_Control1102756019; Non_WithdrawableCaption_Control1102756019Lbl)
			{
			}
			column(TermCaption_Control1102756020; TermCaption_Control1102756020Lbl)
			{
			}
			column(SavingsCaption_Control1102756021; SavingsCaption_Control1102756021Lbl)
			{
			}
			column(Non_WithdrawableCaption_Control1102756022; Non_WithdrawableCaption_Control1102756022Lbl)
			{
			}
			column(TermCaption_Control1102756023; TermCaption_Control1102756023Lbl)
			{
			}
			column(SavingsCaption_Control1102756024; SavingsCaption_Control1102756024Lbl)
			{
			}
			column(Non_WithdrawableCaption_Control1102756025; Non_WithdrawableCaption_Control1102756025Lbl)
			{
			}
			column(Note__Monthly_return_to_be_received_on_or_before_the_fifteenth_of_the_following_month_Caption; Note__Monthly_return_to_be_received_on_or_before_the_fifteenth_of_the_following_month_CaptionLbl)
			{
			}
			column(To_include_accrued_interest_any_form_of_depositCaption; To_include_accrued_interest_any_form_of_depositCaptionLbl)
			{
			}
			column(AUTHORIZATIONCaption; AUTHORIZATIONCaptionLbl)
			{
			}
			column(We_declare_that_this_return__to_the_best_of_our_knowledge_and_belief_is_correct_Caption; We_declare_that_this_return__to_the_best_of_our_knowledge_and_belief_is_correct_CaptionLbl)
			{
			}
			column(Sign__________________________________________________Date_____________________________Caption; Sign__________________________________________________Date_____________________________CaptionLbl)
			{
			}
			column(Name_of_Authorizing_OfficerCaption; Name_of_Authorizing_OfficerCaptionLbl)
			{
			}
			column(Name_of_Counter_Signing_OfficerCaption; Name_of_Counter_Signing_OfficerCaptionLbl)
			{
			}
			column(Sign__________________________________________________Date_____________________________Caption_Control1102756072; Sign__________________________________________________Date_____________________________Caption_Control1102756072Lbl)
			{
			}
			column(Grand_TotalCaption; Grand_TotalCaptionLbl)
			{
			}
			column(Members_No_; Members."No.")
			{
			}
			trigger OnAfterGetRecord();
			begin
				SHARES:=0;
				Fbalance:=0;
				GrandTotal:=0;
				BAL1:=0;
				BAL2:=0;
				BAL3:=0;
				BAL4:=0;
				BAL5:=0;
				COUNT1:=0;
				COUNT2:=0;
				COUNT3:=0;
				COUNT4:=0;
				COUNT5:=0;
				DFilter:='01/01/05..'+Format(ASAT);
				cust.Reset;
				cust.SetRange(cust."No.","No.");
				cust.SetFilter(cust."Date Filter",DFilter);
				if cust.Find('-') then begin
				  cust.CalcFields(cust."Current Shares");
				  SHARES:=cust."Current Shares";
					repeat
					  if SHARES<=50000 then begin
						BAL1:=BAL1+ SHARES;
						COUNT1:=COUNT1+1;
						end else if (SHARES>50001) and (SHARES<=100000) then begin
						BAL2:=BAL2+ SHARES;
						COUNT2:=COUNT2+1;
						end else if (SHARES>100001) and (SHARES<=300000) then begin
						BAL3:=BAL3+ SHARES;
						COUNT3:=COUNT3+1;
						end else if (SHARES>300001) and (SHARES<=1000000) then begin
						BAL4:=BAL4+ SHARES;
						COUNT4:=COUNT4+1;
						end else if SHARES>1000000 then begin
						BAL5:=BAL5+ SHARES;
						COUNT5:=COUNT5+1;
					  end;
					until cust.Next=0;
				end;
				Balance:=0;
				ABAL1:=0;
				ABAL2:=0;
				ABAL3:=0;
				ABAL4:=0;
				ABAL5:=0;
				ACOUNT1:=0;
				ACOUNT2:=0;
				ACOUNT3:=0;
				ACOUNT4:=0;
				ACOUNT5:=0;
				Account.Reset;
				Account.SetRange(Account."BOSA Account No","No.");
				//Account.SETRANGE(Account."Creditor Type",Account."Creditor Type"::Account);
				Account.SetFilter(Account."Date Filter",DFilter);
				if Account.Find('-') then begin
				  repeat
						Account.CalcFields(Account.Balance);
						Balance:=Account.Balance;
						if Account."Account Type"<>'FIXED' then begin
						  if Balance<=50000 then begin
							ABAL1:=ABAL1+ Balance;
							ACOUNT1:=ACOUNT1+1;
							end else if (Balance>50001) and (Balance<=100000) then begin
							ABAL2:=ABAL2+ Balance;
							ACOUNT2:=ACOUNT2+1;
							end else if (Balance>100001) and (Balance<=300000) then begin
							ABAL3:=ABAL3+ Balance;
							ACOUNT3:=ACOUNT3+1;
							end else if (Balance>300001) and (Balance<=1000000) then begin
							ABAL4:=ABAL4+ Balance;
							ACOUNT4:=ACOUNT4+1;
							end else if Balance>1000001 then begin
							ABAL5:=ABAL5+ Balance;
							ACOUNT5:=ACOUNT5+1;
						  end;
						end;
				  until Account.Next=0;
				end;
				FABAL1:=0;
				FABAL2:=0;
				FABAL3:=0;
				FABAL4:=0;
				FABAL5:=0;
				FACOUNT1:=0;
				FACOUNT2:=0;
				FACOUNT3:=0;
				FACOUNT4:=0;
				FACOUNT5:=0;
				Account.Reset;
				Account.SetRange(Account."Personal No.",Members."Personal No");
				//Account.SETRANGE(Account."Account Type",'FIXED DEPOSIT');
				if Account.Find('-') then begin
				 repeat
				  Account.CalcFields(Account.Balance);
				  Fbalance:=Account.Balance;
				   if Account."Account Type"='FIXED' then begin
					if (Fbalance>0) and (Fbalance<=50000) then begin
					 FABAL1:=FABAL1+ Fbalance;
					 FACOUNT1:=FACOUNT1+1;
					end else if (Fbalance>50001) and (Fbalance<=100000) then begin
					 FABAL2:=FABAL2+ Fbalance;
					 FACOUNT2:=FACOUNT2+1;
					end else if (Fbalance>100001) and (Fbalance<=300000) then begin
					 FABAL3:=FABAL3+ Fbalance;
					 FACOUNT3:=FACOUNT3+1;
					end else if (Fbalance>300001) and (Fbalance<=1000000) then begin
					 FABAL4:=FABAL4+ Fbalance;
					 FACOUNT4:=FACOUNT4+1;
					end else if Fbalance>1000000 then begin
					 FABAL5:=FABAL5+ Fbalance;
					 FACOUNT5:=FACOUNT5+1;
					end;
				 end;
				 until Account.Next=0;
				end;
				/*
				Account.RESET;
				Account.SETRANGE(Account."BOSA Account No","No.");
				//Account.SETRANGE(Account."Creditor Type",Account."Creditor Type"::Account);
				Account.SETFILTER(Account."Date Filter",DFilter);
				//Account.SETRANGE(Account."Account Type",'FIXED');
				IF Account.FIND('-') THEN BEGIN
				 REPEAT
				  Account.CALCFIELDS(Account."Balance (LCY)");
				  Fbalance:=Account."Balance (LCY)";
				   IF Account."Account Type"<>'FIXED DEPOSIT' THEN BEGIN
					IF  Fbalance>0 THEN BEGIN
					 IF Fbalance<=50000 THEN BEGIN
					  FABAL1:=FABAL1+ Fbalance;
					  FACOUNT1:=FACOUNT1+1;
					  END ELSE IF (Fbalance>50001) AND (Fbalance<=100000) THEN BEGIN
					  FABAL2:=FABAL2+ Fbalance;
					  FACOUNT2:=FACOUNT2+1;
					  END ELSE IF (Fbalance>100001) AND (Fbalance<=300000) THEN BEGIN
					  FABAL3:=FABAL3+ Fbalance;
					  FACOUNT3:=FACOUNT3+1;
					  END ELSE IF (Fbalance>300001) AND (Fbalance<=1000000) THEN BEGIN
					  FABAL4:=FABAL4+ Fbalance;
					  FACOUNT4:=FACOUNT4+1;
					  END ELSE IF Fbalance>1000001 THEN BEGIN
					  FABAL5:=FABAL5+ Fbalance;
					  FACOUNT5:=FACOUNT5+1;
					  END;
					  END;
					END;
				 UNTIL Account.NEXT=0;
				END;
				 */
				GrandTotal:=BAL1+BAL2+BAL3+BAL4+BAL5+ABAL1+ABAL2+ABAL3+ABAL4+ABAL5+FABAL1+FABAL2+FABAL3+FABAL4+FABAL5;
				GRANDCOUNT:=COUNT1+COUNT2+COUNT3+COUNT4+COUNT5+ACOUNT1+ACOUNT2+ACOUNT3+ACOUNT4+ACOUNT5+FACOUNT1+FACOUNT2+FACOUNT3+FACOUNT4+
				FACOUNT5;
				CompanyInfo.Get;
			
			end;
			
			trigger OnPostDataItem();
			begin
				/*
				cust.RESET;
				cust.SETRANGE(cust."No.",Customer."No.");
				IF cust.FIND('-') THEN BEGIN
				cust.CALCFIELDS(cust."Current Shares");
				 SHARES:=cust."Current Shares"*-1;
				REPEAT
				IF SHARES<=50000 THEN BEGIN
				BAL1:=BAL1+ SHARES;
				COUNT1:=COUNT1+1;
				END ELSE IF (SHARES>50001) AND (SHARES<=100000) THEN BEGIN
				BAL2:=BAL2+ SHARES;
				COUNT2:=COUNT2+1;
				END ELSE IF (SHARES>100001) AND (SHARES<=300000) THEN BEGIN
				BAL3:=BAL3+ SHARES;
				COUNT3:=COUNT3+1;
				END ELSE IF (SHARES>300001) AND (SHARES<=1000000) THEN BEGIN
				BAL4:=BAL4+ SHARES;
				COUNT4:=COUNT4+1;
				END ELSE IF SHARES>1000000 THEN BEGIN
				BAL5:=BAL5+ SHARES;
				COUNT5:=COUNT5+1;
				END;
				UNTIL cust.NEXT=0;
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
				field(ASAT;ASAT)
				{
					ApplicationArea = Basic;
					Caption = 'As At';
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
		Less50000: Decimal;
		"50000 to 10000": Decimal;
		"10000 t0 300000": Decimal;
		"300000 to 100000": Decimal;
		"over 1000000": Decimal;
		Account: Record Vendor;
		"Less50000-a/c": Decimal;
		"50000 to 10000-a/c": Decimal;
		"10000 t0 300000-a/c": Decimal;
		"300000 to 100000-a/c": Decimal;
		"over 1000000-a/c": Decimal;
		cust: Record "Member Register";
		SHARES: Decimal;
		BAL1: Decimal;
		BAL2: Decimal;
		BAL3: Decimal;
		BAL4: Decimal;
		BAL5: Decimal;
		COUNT1: Integer;
		COUNT2: Integer;
		COUNT3: Integer;
		COUNT4: Integer;
		COUNT5: Integer;
		ABAL1: Decimal;
		ABAL2: Decimal;
		ABAL3: Decimal;
		ABAL4: Decimal;
		ABAL5: Decimal;
		ACOUNT1: Integer;
		ACOUNT2: Integer;
		ACOUNT3: Integer;
		ACOUNT4: Integer;
		ACOUNT5: Integer;
		Balance: Decimal;
		FABAL1: Decimal;
		FABAL2: Decimal;
		FABAL3: Decimal;
		FABAL4: Decimal;
		FABAL5: Decimal;
		FACOUNT1: Integer;
		FACOUNT2: Integer;
		FACOUNT3: Integer;
		FACOUNT4: Integer;
		FACOUNT5: Integer;
		Fbalance: Decimal;
		GrandTotal: Decimal;
		GRANDCOUNT: Integer;
		DFilter: Text[50];
		ASAT: Date;
		Vend: Record Vendor;
		CompanyInfo: Record "Company Information";
		No_CaptionLbl: label 'No.';
		RangeCaptionLbl: label 'Range';
		Type_of_DepositCaptionLbl: label '*Type of Deposit';
		Amount_Kshs__000_CaptionLbl: label 'Amount Kshs.''000''';
		No__of_A_CsCaptionLbl: label 'No. of A/Cs';
		FORM_3CaptionLbl: label 'FORM 3';
		SASRA_2_003CaptionLbl: label 'SASRA 2/003';
		STATEMENT_OF_DEPOSIT_RETURNCaptionLbl: label 'STATEMENT OF DEPOSIT RETURN';
		CS_2375CaptionLbl: label 'CS/11671';
		Date_CaptionLbl: label 'Date:';
		R__24_CaptionLbl: label 'R.(24)';
		V1CaptionLbl: label '1';
		V4CaptionLbl: label '4';
		V2CaptionLbl: label '2';
		V3CaptionLbl: label '3';
		V5CaptionLbl: label '5';
		Less_than_50_000CaptionLbl: label 'Less than 50,000';
		V50_000_to_100_000CaptionLbl: label ' 50,000 to 100,000';
		V100_000_to_300_000CaptionLbl: label '100,000 to 300,000';
		V300_000_to_1_000_000CaptionLbl: label '300,000 to 1,000,000';
		Over_1_000_000CaptionLbl: label 'Over 1,000,000';
		Non_WithdrawableCaptionLbl: label 'Non-Withdrawable';
		SavingsCaptionLbl: label 'Savings';
		TermCaptionLbl: label 'Term';
		TermCaption_Control1102756014Lbl: label 'Term';
		SavingsCaption_Control1102756015Lbl: label 'Savings';
		Non_WithdrawableCaption_Control1102756016Lbl: label 'Non-Withdrawable';
		TermCaption_Control1102756017Lbl: label 'Term';
		SavingsCaption_Control1102756018Lbl: label 'Savings';
		Non_WithdrawableCaption_Control1102756019Lbl: label 'Non-Withdrawable';
		TermCaption_Control1102756020Lbl: label 'Term';
		SavingsCaption_Control1102756021Lbl: label 'Savings';
		Non_WithdrawableCaption_Control1102756022Lbl: label 'Non-Withdrawable';
		TermCaption_Control1102756023Lbl: label 'Term';
		SavingsCaption_Control1102756024Lbl: label 'Savings';
		Non_WithdrawableCaption_Control1102756025Lbl: label 'Non-Withdrawable';
		Note__Monthly_return_to_be_received_on_or_before_the_fifteenth_of_the_following_month_CaptionLbl: label 'Note: Monthly return to be received on or before the fifteenth of the following month.';
		To_include_accrued_interest_any_form_of_depositCaptionLbl: label '* To include accrued interest any form of deposit';
		AUTHORIZATIONCaptionLbl: label 'AUTHORIZATION';
		We_declare_that_this_return__to_the_best_of_our_knowledge_and_belief_is_correct_CaptionLbl: label 'We declare that this return, to the best of our knowledge and belief is correct.';
		Sign__________________________________________________Date_____________________________CaptionLbl: label '................................................Sign..................................................Date.............................';
		Name_of_Authorizing_OfficerCaptionLbl: label 'Name of Authorizing Officer';
		Name_of_Counter_Signing_OfficerCaptionLbl: label 'Name of Counter Signing Officer';
		Sign__________________________________________________Date_____________________________Caption_Control1102756072Lbl: label '................................................Sign..................................................Date.............................';
		Grand_TotalCaptionLbl: label 'Grand Total';

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516243_v6_3_0_2259;
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
