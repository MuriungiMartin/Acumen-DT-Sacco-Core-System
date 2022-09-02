#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516421_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516421 "Generate Dividend FlatRate"
{
	RDLCLayout = './Layouts/GenerateDividendFlatRate.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem(Customer;"Member Register")
		{
			DataItemTableView = sorting("No.");
			RequestFilterFields = "No.","Date Filter","Employer Code";
			column(ReportForNavId_4645; 4645) {} // Autogenerated by ForNav - Do not delete
			column(FORMAT_TODAY_0_4_; Format(Today,0,4))
			{
			}
			column(COMPANYNAME; COMPANYNAME)
			{
			}
			column(Company_Address; Company.Address)
			{
			}
			column(Company_Address2; Company."Address 2")
			{
			}
			column(Company_PhoneNo; Company."Phone No.")
			{
			}
			column(Company_Email; Company."E-Mail")
			{
			}
			column(Company_Picture; Company.Picture)
			{
			}
			column(CurrReport_PAGENO; Format(ReportForNav.PageNo))
			{
			}
			column(UserId; UserId)
			{
			}
			column(S_No; SN)
			{
			}
			column(No; Customer."No.")
			{
			}
			column(Name; Customer.Name)
			{
			}
			column(Shares_Retained; Customer."Shares Retained")
			{
			}
			trigger OnPreDataItem();
			begin
				//LastFieldNo := FIELDNO("");
			end;
			
			trigger OnAfterGetRecord();
			begin
				DivTotal:=0;
				Tax:=0;
				GenSetUp.Get(0);
				CalcFields("Current Shares");
				if Customer."Dividend Amount"<0 then
				//IF "Dividend Amount" < 0 THEN
				DivTotal:=DivTotal+((GenSetUp."Dividend (%)"/100)*Abs("Dividend Amount"));
				Tax:=Tax+((GenSetUp."Withholding Tax (%)"/100)*Abs(DivTotal));
				Customer."Dividend Amount":=DivTotal;
				Customer."Dividend Amount":=Tax;
				Customer.Modify;
				DivTotal:=0;
				DivTotal2:=0;
				Tax:=0;
				GenSetUp.Get(0);
				CalcFields("Current Shares","Shares Retained");
				//IF "Dividend Amount" < 0 THEN
				DivTotal:=DivTotal+((GenSetUp."Dividend (%)"/100)*Abs("Shares Retained"));
				DivTotal2:=DivTotal2+((GenSetUp."Dividend (%)"/100)*Abs("Shares Retained"));
				//DivTotal2:=DivTotal2+(GenSetUp."Dividend (%)"/100)*ABS("Shares Retained"));
				TotalDiv:=DivTotal+DivTotal2;
				Tax:=Tax+((GenSetUp."Withholding Tax (%)"/100)*Abs(TotalDiv));
				"Shares Variance":="Current Shares"+"Shares Retained";
				//Customer."Dividend Amount":=Tax;
				"Net Dividend Payable":=TotalDiv-Tax;
				"Tax on Dividend":=Tax;
				"Div Amount":=TotalDiv;
				"Qualifying Shares":=Abs("Shares Retained");
				Modify;
				if Customer."FOSA Account No."<>'' then  begin
				if Customer.Defaulter=true then begin
				LineNo:=LineNo+10000;
				GenJournalLine.Init;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Journal Batch Name":='SHARESDIV';
				GenJournalLine."Document No.":='DIVIDEND';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Account Type":=GenJournalLine."account type"::Customer;
				/*
				IF Customer."FOSA Account"<>'' THEN
				GenJournalLine."Account No.":=Customer."FOSA Account"
				ELSE
				*/
				GenJournalLine."Account No.":=Customer."No.";
				GenJournalLine.Validate(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PostingDate;
				GenJournalLine.Description:='Dividends';
				GenJournalLine.Validate(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=-(TotalDiv);
				GenJournalLine.Validate(GenJournalLine.Amount);
				GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
				GenJournalLine."Bal. Account No.":='20945';
				GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Additional Shares";
				GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
				GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
				if GenJournalLine.Amount<>0 then
				GenJournalLine.Insert;
				//WITHHOLDING
				LineNo:=LineNo+10000;
				GenJournalLine.Init;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Journal Batch Name":='SHARESDIV';
				GenJournalLine."Document No.":='DIVIDEND';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Account Type":=GenJournalLine."account type"::Customer;
				/*
				IF Customer."FOSA Account"<>'' THEN
				GenJournalLine."Account No.":=Customer."FOSA Account"
				ELSE
				*/
				GenJournalLine."Account No.":=Customer."No.";
				GenJournalLine.Validate(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PostingDate;
				GenJournalLine.Description:='Dividends Withholding Tax';
				GenJournalLine.Validate(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=Tax;
				GenJournalLine.Validate(GenJournalLine.Amount);
				GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
				GenJournalLine."Bal. Account No.":='20360';
				GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Additional Shares";
				GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
				GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
				if GenJournalLine.Amount<>0 then
				GenJournalLine.Insert;
				//until loans.next=0;
				end else if Customer.Defaulter=false then begin
				LineNo:=LineNo+10000;
				GenJournalLine.Init;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Journal Batch Name":='SHARESDIV';
				GenJournalLine."Document No.":='DIVIDEND';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Account Type":=GenJournalLine."account type"::Customer;
				/*
				IF Customer."FOSA Account"<>'' THEN
				GenJournalLine."Account No.":=Customer."FOSA Account"
				ELSE
				*/
				GenJournalLine."Account No.":=Customer."No.";
				GenJournalLine.Validate(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PostingDate;
				GenJournalLine.Description:='Dividends';
				GenJournalLine.Validate(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=-(TotalDiv);
				GenJournalLine.Validate(GenJournalLine.Amount);
				GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
				GenJournalLine."Bal. Account No.":='20945';
				GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Additional Shares";
				GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
				GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
				if GenJournalLine.Amount<>0 then
				GenJournalLine.Insert;
				//WITHHOLDING
				LineNo:=LineNo+10000;
				GenJournalLine.Init;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Journal Batch Name":='SHARESDIV';
				GenJournalLine."Document No.":='DIVIDEND';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Account Type":=GenJournalLine."account type"::Customer;
				/*
				IF Customer."FOSA Account"<>'' THEN
				GenJournalLine."Account No.":=Customer."FOSA Account"
				ELSE
				*/
				GenJournalLine."Account No.":=Customer."No.";
				GenJournalLine.Validate(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PostingDate;
				GenJournalLine.Description:='Dividends Withholding Tax';
				GenJournalLine.Validate(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=Tax;
				GenJournalLine.Validate(GenJournalLine.Amount);
				GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
				GenJournalLine."Bal. Account No.":='20360';
				GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Additional Shares";
				GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
				GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
				if GenJournalLine.Amount<>0 then
				GenJournalLine.Insert;
				//Transfer to Vendor
				LineNo:=LineNo+10000;
				GenJournalLine.Init;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Journal Batch Name":='SHARESDIV';
				GenJournalLine."Document No.":='DIVIDEND';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
				//IF Customer."FOSA Account"<>'' THEN
				GenJournalLine."Account No.":=Customer."FOSA Account No.";
				//ELSE
				//GenJournalLine."Account No.":='1991-1-504-';
				GenJournalLine.Validate(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PostingDate;
				GenJournalLine.Description:='Dividends';
				GenJournalLine.Validate(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=-(TotalDiv);
				GenJournalLine.Validate(GenJournalLine.Amount);
				GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Additional Shares";
				GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
				GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
				GenJournalLine."Dividend SMS" := true;
				if GenJournalLine.Amount<>0 then
				GenJournalLine.Insert;
				LineNo:=LineNo+10000;
				GenJournalLine.Init;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Journal Batch Name":='SHARESDIV';
				GenJournalLine."Document No.":='DIVIDEND';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Account Type":=GenJournalLine."account type"::Customer;
				/*
				IF Customer."FOSA Account"<>'' THEN
				GenJournalLine."Account No.":=Customer."FOSA Account"
				ELSE
				*/
				GenJournalLine."Account No.":=Customer."No.";
				GenJournalLine.Validate(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PostingDate;
				GenJournalLine.Description:='Dividends';
				GenJournalLine.Validate(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=(TotalDiv);
				GenJournalLine.Validate(GenJournalLine.Amount);
				GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Additional Shares";
				GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
				GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
				if GenJournalLine.Amount<>0 then
				GenJournalLine.Insert;
				//WITHHOLDING
				LineNo:=LineNo+10000;
				GenJournalLine.Init;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Journal Batch Name":='SHARESDIV';
				GenJournalLine."Document No.":='DIVIDEND';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
				//IF Customer."FOSA Account"<>'' THEN
				GenJournalLine."Account No.":=Customer."FOSA Account No.";
				//ELSE
				//GenJournalLine."Account No.":='1991-1-504-';
				GenJournalLine.Validate(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PostingDate;
				GenJournalLine.Description:='Dividends Withholding Tax';
				GenJournalLine.Validate(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=Tax;
				GenJournalLine.Validate(GenJournalLine.Amount);
				GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Additional Shares";
				GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
				GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
				if GenJournalLine.Amount<>0 then
				GenJournalLine.Insert;
				LineNo:=LineNo+10000;
				GenJournalLine.Init;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Journal Batch Name":='SHARESDIV';
				GenJournalLine."Document No.":='DIVIDEND';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Account Type":=GenJournalLine."account type"::Customer;
				GenJournalLine."Account No.":=Customer."No.";
				GenJournalLine.Validate(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PostingDate;
				GenJournalLine.Description:='Dividends Withholding Tax';
				GenJournalLine.Validate(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=-Tax;
				GenJournalLine.Validate(GenJournalLine.Amount);
				GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Additional Shares";
				GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
				GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
				if GenJournalLine.Amount<>0 then
				GenJournalLine.Insert;
				/*
				//Div Processing Fee
				IF TotalDiv >=100 THEN BEGIN
				LineNo:=LineNo+10000;
				GenJournalLine.INIT;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Journal Batch Name":='SHARESDIV';
				GenJournalLine."Document No.":='DIVIDEND';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
				//IF Customer."FOSA Account"<>'' THEN
				GenJournalLine."Account No.":=Customer."FOSA Account";
				///ELSE
				//GenJournalLine."Account No.":='1991-1-504-';
				GenJournalLine.VALIDATE(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PostingDate;
				GenJournalLine.Description:='Dividends Processing Fee';
				GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=100;
				GenJournalLine.VALIDATE(GenJournalLine.Amount);
				GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
				GenJournalLine."Bal. Account No.":='30164';
				GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Dividend;
				GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
				GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
				IF GenJournalLine.Amount<>0 THEN
				GenJournalLine.INSERT;
				//Excise Duty on Fee
				LineNo:=LineNo+10000;
				GenJournalLine.INIT;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Journal Batch Name":='SHARESDIV';
				GenJournalLine."Document No.":='DIVIDEND';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
				//IF Customer."FOSA Account"<>'' THEN
				GenJournalLine."Account No.":=Customer."FOSA Account";
				//ELSE
				//GenJournalLine."Account No.":='1991-1-504-';
				GenJournalLine.VALIDATE(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PostingDate;
				GenJournalLine.Description:='Excise on DivProcessing Fee';
				GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=10;
				GenJournalLine.VALIDATE(GenJournalLine.Amount);
				GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
				GenJournalLine."Bal. Account No.":='20355';
				GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Dividend;
				GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
				GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
				IF GenJournalLine.Amount<>0 THEN
				GenJournalLine.INSERT;
				END;  */
				end;
				//END;
				end else
				if Customer."FOSA Account No."='' then  begin
				LineNo:=LineNo+10000;
				GenJournalLine.Init;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Journal Batch Name":='SHARESDIV';
				GenJournalLine."Document No.":='DIVIDEND';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Account Type":=GenJournalLine."account type"::Customer;
				/*
				IF Customer."FOSA Account"<>'' THEN
				GenJournalLine."Account No.":=Customer."FOSA Account"
				ELSE
				*/
				GenJournalLine."Account No.":=Customer."No.";
				GenJournalLine.Validate(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PostingDate;
				GenJournalLine.Description:='Dividends';
				GenJournalLine.Validate(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=-(TotalDiv);
				GenJournalLine.Validate(GenJournalLine.Amount);
				GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
				GenJournalLine."Bal. Account No.":='20945';
				GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Additional Shares";
				GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
				GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
				if GenJournalLine.Amount<>0 then
				GenJournalLine.Insert;
				//WITHHOLDING
				LineNo:=LineNo+10000;
				GenJournalLine.Init;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Journal Batch Name":='SHARESDIV';
				GenJournalLine."Document No.":='DIVIDEND';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Account Type":=GenJournalLine."account type"::Customer;
				/*
				IF Customer."FOSA Account"<>'' THEN
				GenJournalLine."Account No.":=Customer."FOSA Account"
				ELSE
				*/
				GenJournalLine."Account No.":=Customer."No.";
				GenJournalLine.Validate(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PostingDate;
				GenJournalLine.Description:='Dividends Withholding Tax';
				GenJournalLine.Validate(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=Tax;
				GenJournalLine.Validate(GenJournalLine.Amount);
				GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
				GenJournalLine."Bal. Account No.":='20360';
				GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Additional Shares";
				GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
				GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
				if GenJournalLine.Amount<>0 then
				GenJournalLine.Insert;
				//until loans.next=0;
				end;
				//Beginn Comment***********
				/*{
				IF Customer."FOSA Account"<>'' THEN  BEGIN
				IF Customer.Defaulter=TRUE THEN BEGIN
				LineNo:=LineNo+10000;
				GenJournalLine.INIT;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Journal Batch Name":='SHARESDIV';
				GenJournalLine."Document No.":='DIVIDEND';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Account Type":=GenJournalLine."Account Type"::Customer;
				{
				IF Customer."FOSA Account"<>'' THEN
				GenJournalLine."Account No.":=Customer."FOSA Account"
				ELSE
				}
				GenJournalLine."Account No.":=Customer."No.";
				GenJournalLine.VALIDATE(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PostingDate;
				GenJournalLine.Description:='Dividends';
				GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=-TotalDiv;
				GenJournalLine.VALIDATE(GenJournalLine.Amount);
				GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
				GenJournalLine."Bal. Account No.":='20360';
				GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Dividend;
				GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
				GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
				IF GenJournalLine.Amount<>0 THEN
				GenJournalLine.INSERT;
				//WITHHOLDING
				LineNo:=LineNo+10000;
				GenJournalLine.INIT;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Journal Batch Name":='SHARESDIV';
				GenJournalLine."Document No.":='DIVIDEND';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Account Type":=GenJournalLine."Account Type"::Customer;
				{
				IF Customer."FOSA Account"<>'' THEN
				GenJournalLine."Account No.":=Customer."FOSA Account"
				ELSE
				}
				GenJournalLine."Account No.":=Customer."No.";
				GenJournalLine.VALIDATE(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PostingDate;
				GenJournalLine.Description:='Withholding Tax';
				GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=Tax;
				GenJournalLine.VALIDATE(GenJournalLine.Amount);
				GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
				GenJournalLine."Bal. Account No.":='20360';
				GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Dividend;
				GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
				GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
				IF GenJournalLine.Amount<>0 THEN
				GenJournalLine.INSERT;
				//until loans.next=0;
				END ELSE IF Customer.Defaulter=FALSE THEN BEGIN
				LineNo:=LineNo+10000;
				GenJournalLine.INIT;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Journal Batch Name":='SHARESDIV';
				GenJournalLine."Document No.":='SHARES 2013';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
				//IF Customer."FOSA Account"<>'' THEN
				GenJournalLine."Account No.":=Customer."FOSA Account";
				//ELSE
				//GenJournalLine."Account No.":='1991-1-504-';
				GenJournalLine.VALIDATE(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PostingDate;
				GenJournalLine.Description:='Dividend Recovery';
				GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=-DivTotal;
				GenJournalLine.VALIDATE(GenJournalLine.Amount);
				GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
				GenJournalLine."Bal. Account No.":='20360';
				GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Dividend;
				IF GenJournalLine.Amount<>0 THEN
				GenJournalLine.INSERT;
				//Share Capital Divident
				LineNo:=LineNo+10000;
				GenJournalLine.INIT;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Journal Batch Name":='SHARESDIV';
				GenJournalLine."Document No.":='SHARES 2013';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
				//IF Customer."FOSA Account"<>'' THEN
				GenJournalLine."Account No.":=Customer."FOSA Account";
				//ELSE
				//GenJournalLine."Account No.":='1991-1-504-';
				GenJournalLine.VALIDATE(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PostingDate;
				GenJournalLine.Description:='Share Dividend';
				GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=-DivTotal2;
				GenJournalLine.VALIDATE(GenJournalLine.Amount);
				GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
				GenJournalLine."Bal. Account No.":='20945';
				GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Dividend;
				GenJournalLine."Dividend SMS" := TRUE;
				IF GenJournalLine.Amount<>0 THEN
				GenJournalLine.INSERT;
				LineNo:=LineNo+10000;
				GenJournalLine.INIT;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Journal Batch Name":='SHARESDIV';
				GenJournalLine."Document No.":='SHARESDIV';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
				//IF Customer."FOSA Account"<>'' THEN
				GenJournalLine."Account No.":=Customer."FOSA Account";
				//ELSE
				//GenJournalLine."Account No.":='1991-1-504-';
				GenJournalLine.VALIDATE(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PostingDate;
				GenJournalLine.Description:='Withholding Tax';
				GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=Tax;
				GenJournalLine.VALIDATE(GenJournalLine.Amount);
				GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
				GenJournalLine."Bal. Account No.":='20360';
				GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Dividend;
				IF GenJournalLine.Amount<>0 THEN
				GenJournalLine.INSERT;
				END;// else
				END ELSE
				IF Customer."FOSA Account"='' THEN BEGIN
				LineNo:=LineNo+10000;
				GenJournalLine.INIT;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Journal Batch Name":='SHARESDIV';
				GenJournalLine."Document No.":='DIVIDEND';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Account Type":=GenJournalLine."Account Type"::Customer;
				{
				IF Customer."FOSA Account"<>'' THEN
				GenJournalLine."Account No.":=Customer."FOSA Account"
				ELSE
				}
				GenJournalLine."Account No.":=Customer."No.";
				GenJournalLine.VALIDATE(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PostingDate;
				GenJournalLine.Description:='Dividends';
				GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=-TotalDiv;
				GenJournalLine.VALIDATE(GenJournalLine.Amount);
				GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
				GenJournalLine."Bal. Account No.":='20360';
				GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Dividend;
				GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
				GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
				IF GenJournalLine.Amount<>0 THEN
				GenJournalLine.INSERT;
				//WITHHOLDING
				LineNo:=LineNo+10000;
				GenJournalLine.INIT;
				GenJournalLine."Journal Template Name":='PURCHASES';
				GenJournalLine."Journal Batch Name":='SHARESDIV';
				GenJournalLine."Document No.":='DIVIDEND';
				GenJournalLine."Line No.":=LineNo;
				GenJournalLine."Account Type":=GenJournalLine."Account Type"::Customer;
				{
				IF Customer."FOSA Account"<>'' THEN
				GenJournalLine."Account No.":=Customer."FOSA Account"
				ELSE
				}
				GenJournalLine."Account No.":=Customer."No.";
				GenJournalLine.VALIDATE(GenJournalLine."Account No.");
				GenJournalLine."Posting Date":=PostingDate;
				GenJournalLine.Description:='Withholding Tax';
				GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
				GenJournalLine.Amount:=Tax;
				GenJournalLine.VALIDATE(GenJournalLine.Amount);
				GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
				GenJournalLine."Bal. Account No.":='20360';
				GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Dividend;
				GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
				GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
				IF GenJournalLine.Amount<>0 THEN
				GenJournalLine.INSERT;
				//until loans.next=0;
				END;
				}*/
				//END OF COMMEENT **************
			
			end;
			
		}
	}

	requestpage
	{

  
		SaveValues = false;	  layout
		{
			area(content)
			{
				field(Start_Date;StartDate)
				{
					ApplicationArea = Basic;
				}
				field(Posting_Date;PostingDate)
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
				Company.Get();
				Company.CalcFields(Company.Picture);
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
		Loans_RegisterCaptionLbl: label 'Approved Loans Report';
		CurrReport_PAGENOCaptionLbl: label 'Page';
		Loan_TypeCaptionLbl: label 'Loan Type';
		Client_No_CaptionLbl: label 'Client No.';
		Outstanding_LoanCaptionLbl: label 'Outstanding Loan';
		PeriodCaptionLbl: label 'Period';
		Approved_DateCaptionLbl: label 'Approved Date';
		Loan_TypeCaption_Control1102760043Lbl: label 'Loan Type';
		Verified_By__________________________________________________CaptionLbl: label 'Verified By..................................................';
		Confirmed_By__________________________________________________CaptionLbl: label 'Confirmed By..................................................';
		Sign________________________CaptionLbl: label 'Sign........................';
		Sign________________________Caption_Control1102755003Lbl: label 'Sign........................';
		Date________________________CaptionLbl: label 'Date........................';
		Date________________________Caption_Control1102755005Lbl: label 'Date........................';
		NameCreditOff: label 'Name......................................';
		NameCreditDate: label 'Date........................................';
		NameCreditSign: label 'Signature..................................';
		NameCreditMNG: label 'Name......................................';
		NameCreditMNGDate: label 'Date.....................................';
		NameCreditMNGSign: label 'Signature..................................';
		NameCEO: label 'Name........................................';
		NameCEOSign: label 'Signature...................................';
		NameCEODate: label 'Date.....................................';
		CreditCom1: label 'Name........................................';
		CreditCom1Sign: label 'Signature...................................';
		CreditCom1Date: label 'Date.........................................';
		CreditCom2: label 'Name........................................';
		CreditCom2Sign: label 'Signature....................................';
		CreditCom2Date: label 'Date..........................................';
		CreditCom3: label 'Name.........................................';
		CreditComDate3: label 'Date..........................................';
		CreditComSign3: label 'Signature..................................';
		Comment: label '....................';
		SN: Integer;
		Company: Record "Company Information";
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

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516421_v6_3_0_2259;
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
