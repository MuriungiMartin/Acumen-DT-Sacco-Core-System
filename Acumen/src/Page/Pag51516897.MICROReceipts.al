#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516897 "MICRO Receipts"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "HR Rewards Header";
    SourceTableView = where(Posted=const(No),"Activity Code"=const(MICRO),"Application Type"=filter(MICRO));

    layout
    {
        area(content)
        {
            group(Transaction)
            {
                Caption = 'Transaction';
                field("Transaction No.";"Transaction No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                    OptionCaption = 'Member,Debtor,G/L Account,FOSA Loan,Customer,Bank Account,Vendor';

                    trigger OnValidate()
                    begin
                        if "Account Type"<>"account type"::Member then
                        Error(Text002,"Account Type");
                    end;
                }
                field(Source;Source)
                {
                    ApplicationArea = Basic;
                }
                field("Account No.";"Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("FOSA Account No.";"FOSA Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Account Bal";"FOSA Account Bal")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Allocated Amount";"Allocated Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No.";"Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Date";"Cheque Date")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Time";"Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Activity Code";"Activity Code")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code";"Branch Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Suggest)
            {
                Caption = 'Suggest';
                action("Cash/Cheque Clearance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cash/Cheque Clearance';
                    Ellipsis = true;
                    Image = CancelLine;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin

                        Cheque := false;
                        SuggestBOSAEntries();
                    end;
                }
                separator(Action1102760032)
                {
                }
                action("Generate Distribution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Generate Distribution';
                    Image = ReceiptLines;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = true;

                    trigger OnAction()
                    begin
                        TestField(Posted,false);
                        TestField("Account No.");
                        
                        ReceiptAllocations.Reset;
                        ReceiptAllocations.SetRange(ReceiptAllocations."Document No","Transaction No.");
                        ReceiptAllocations.DeleteAll;
                        
                        //Members
                        
                        if "Account Type"<>"account type"::Debtor then begin
                        if Cust.Get("Account No.") then begin
                        ReceiptAllocations.Init;
                        ReceiptAllocations."Document No":="Transaction No.";
                        ReceiptAllocations."Member No":="Account No.";
                        ReceiptAllocations."Transaction Type":=ReceiptAllocations."transaction type"::"Deposit Contribution";
                        ReceiptAllocations.Amount:=ROUND(Cust."Monthly Contribution",0.01);
                        ReceiptAllocations."Interest Amount":=Loans."Interest Due";
                        ReceiptAllocations."Total Amount":=ReceiptAllocations.Amount+ReceiptAllocations."Interest Amount";
                        ReceiptAllocations.Insert;
                        
                        if Cust."Investment Monthly Cont" > 0 then begin
                        ReceiptAllocations.Init;
                        ReceiptAllocations."Document No":="Transaction No.";
                        ReceiptAllocations."Member No":="Account No.";
                        ReceiptAllocations."Transaction Type":=ReceiptAllocations."transaction type"::"Shares Capital";
                        ReceiptAllocations.Amount:=ROUND(Cust."Investment Monthly Cont",0.01);
                        ReceiptAllocations."Interest Amount":=Loans."Interest Due";
                        ReceiptAllocations."Total Amount":=ReceiptAllocations.Amount+ReceiptAllocations."Interest Amount";
                        ReceiptAllocations.Insert;
                        end;
                        
                        Loans.Reset;
                        Loans.SetCurrentkey(Loans.Source,Loans."Client Code");
                        Loans.SetRange(Loans."Client Code","Account No.");
                        Loans.SetRange(Loans.Source,Loans.Source::MICRO);
                        if Loans.Find('-') then begin
                        repeat
                        Loans.CalcFields(Loans."Outstanding Balance",Loans."Interest Due",Loans."Oustanding Interest");
                        
                        if (Loans."Outstanding Balance") > 0 then begin
                        LOustanding:=0;
                        
                        ReceiptAllocations.Init;
                        ReceiptAllocations."Document No":="Transaction No.";
                        ReceiptAllocations."Member No":="Account No.";
                        ReceiptAllocations."Transaction Type":=ReceiptAllocations."transaction type"::Repayment;
                        ReceiptAllocations."Loan No.":=Loans."Loan  No.";
                        ReceiptAllocations.Amount:=ROUND(Loans."Loan Principle Repayment",0.01);
                        ReceiptAllocations."Interest Amount":=ROUND(Loans."Oustanding Interest",0.01);
                        ReceiptAllocations."Total Amount":=ReceiptAllocations.Amount+ReceiptAllocations."Interest Amount";
                        ReceiptAllocations.Insert;
                        end;
                        until Loans.Next = 0;
                        end;
                        end;
                        end;
                        
                        //Staff Loans
                        /*
                        IF "Account Type"="Account Type"::Debtor THEN BEGIN
                        IF Cust2.GET("Account No.") THEN BEGIN
                        Loans2.RESET;
                        //Loans2.SETCURRENTKEY(Loans.Source,Loans."Client Code");
                        Loans2.SETRANGE(Loans2."Emp No.","Account No.");
                        //Loans2.SETRANGE(Loans.Source,Loans.Source::BOSA);
                        IF Loans2.FIND('-') THEN BEGIN
                        REPEAT
                        Loans2.CALCFIELDS(Loans2.Balance,Loans2."Outstanding Interest");
                        
                        IF (Loans2.Balance) > 0 THEN BEGIN
                        LOustanding:=0;
                        
                        
                        ReceiptAllocations.INIT;
                        ReceiptAllocations."Document No":="Transaction No.";
                        ReceiptAllocations."Member No":="Account No.";
                        ReceiptAllocations."Transaction Type":=ReceiptAllocations."Transaction Type"::Repayment;
                        ReceiptAllocations."Loan No.":=Loans2."Loan No.";
                        ReceiptAllocations.Amount:=ROUND(Loans2.Repayment-Loans2."Outstanding Interest",0.01);
                        ReceiptAllocations."Interest Amount":=ROUND(Loans2."Outstanding Interest",0.01);
                        ReceiptAllocations."Total Amount":=ReceiptAllocations.Amount+ReceiptAllocations."Interest Amount";
                        ReceiptAllocations.INSERT;
                        
                        
                        END;
                        UNTIL Loans2.NEXT = 0;
                        END;
                        
                        
                        END
                        END
                        */

                    end;
                }
            }
        }
        area(processing)
        {
            action("Post (F11)")
            {
                ApplicationArea = Basic;
                Caption = 'Post (F11)';
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin

                    TestField(Posted,false);
                    if "FOSA Account Bal"=0 then
                    Error(Text003);
                    CalcFields("Allocated Amount");
                    if Amount<>"Allocated Amount" then
                    Error(Text004,Amount,"Allocated Amount");

                    if "Account Type"="account type"::Member then begin
                    PostMicroEntries();
                    end;
                end;
            }
            separator(Action1000000000)
            {
            }
            action("Reprint Receipt")
            {
                ApplicationArea = Basic;
                Caption = 'Reprint Receipt';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    TestField(Posted);

                    BOSARcpt.Reset;
                    BOSARcpt.SetRange(BOSARcpt."Transaction No.","Transaction No.");
                    if BOSARcpt.Find('-') then
                    Report.Run(39003958,true,true,BOSARcpt)
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        /*Rcpt.RESET;
        Rcpt.SETRANGE(Rcpt.Posted,FALSE);
        Rcpt.SETRANGE(Rcpt."User ID",USERID);
        IF Rcpt.COUNT >0 THEN BEGIN
        ERROR(Text001);
        END;*/

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Application Type":="Application Type"::MICRO;
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("User ID",USERID);
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        InterestPaid: Decimal;
        PaymentAmount: Decimal;
        RunBal: Decimal;
        Recover: Boolean;
        Cheque: Boolean;
        ReceiptAllocations: Record "HR Appraisal Assignment";
        Loans: Record test;
        Commision: Decimal;
        LOustanding: Decimal;
        TotalCommision: Decimal;
        TotalOustanding: Decimal;
        Cust: Record UnknownRecord51516223;
        BOSABank: Code[20];
        LineNo: Integer;
        BOSARcpt: Record "HR Rewards Header";
        TellerTill: Record "Bank Account";
        CurrentTellerAmount: Decimal;
        TransType: Text[30];
        Cust2: Record Customer;
        RecAlloc: Record "HR Appraisal Assignment";
        Rcpt: Record "HR Rewards Header";
        Text001: label 'There are still some unposted Micro receipts. Please utilise them first';
        Text002: label 'Account type must be equal to Member. The current value is %1';
        Text003: label 'FOSA Account Bal. must have a value. It cannot be zero.';
        Text004: label 'Amount value of Kshs %1 must be equal to Allocated Amount value of Kshs %2';
        Text005: label 'Transactions Posted successfully';
        Temp: Record "Funds User Setup";
        Jtemplate: Code[30];
        JBatch: Code[30];
        Text006: label 'Receipt Journal Template must have a value for %1 in cash office user template. It cannot be Null.';
        Text007: label 'Receipt Journal Batch must have a value for %1 in cash office user template. It cannot be Null.';
        SMSMessages: Record "Payroll NHIF Setup.";
        iEntryNo: Integer;
        MembCustz: Record UnknownRecord51516223;
        GenBatch: Record "Gen. Journal Batch";


    procedure SuggestBOSAEntries()
    begin
        TestField(Posted,false);
        TestField("Account No.");
        TestField(Amount);
        //TESTFIELD("Cheque No.");
        //TESTFIELD("Cheque Date");
        //TESTFIELD("Bank No.");

        ReceiptAllocations.Reset;
        ReceiptAllocations.SetRange(ReceiptAllocations."Document No","Transaction No.");
        ReceiptAllocations.DeleteAll;

        PaymentAmount:=Amount;
        RunBal:=PaymentAmount;

        Loans.Reset;
        Loans.SetCurrentkey(Loans.Source,Loans."Client Code");
        Loans.SetRange(Loans."Client Code","Account No.");
        Loans.SetRange(Loans.Source,Loans.Source::MICRO);
        if Loans.Find('-') then begin
        repeat
        Loans.CalcFields(Loans."Outstanding Balance",Loans."Interest Due");
        Recover := true;

        if (Loans."Outstanding Balance") > 0 then begin
        if ((Loans."Outstanding Balance"-Loans."Loan Principle Repayment") <= 0) and (Cheque = false)  then
        Recover:=false;

        if Recover = true then begin


        if Cheque = true then begin
        LOustanding:=Loans."Outstanding Balance";
        if Loans."Interest Due" > 0 then
        InterestPaid:=Loans."Interest Due";
        end else begin
        LOustanding:=(Loans."Outstanding Balance"-Loans."Loan Principle Repayment");
        if LOustanding < 0 then
        LOustanding:=0;
        if Loans."Interest Due" > 0 then
        InterestPaid:=Loans."Interest Due";
        end;
        end;

        if PaymentAmount > 0 then begin
        if RunBal < (LOustanding+InterestPaid) then begin
        if RunBal < InterestPaid then
        InterestPaid:=RunBal;
        //Commision:=(RunBal-InterestPaid)*0.1;
        LOustanding:=(RunBal-InterestPaid)

        end;
        end;



        TotalOustanding:=TotalOustanding+LOustanding+InterestPaid;

        RunBal:=RunBal-(LOustanding+InterestPaid);

        if (LOustanding + InterestPaid) > 0 then begin
        ReceiptAllocations.Init;
        ReceiptAllocations."Document No":="Transaction No.";
        ReceiptAllocations."Member No":="Account No.";
        ReceiptAllocations."Transaction Type":=ReceiptAllocations."transaction type"::Repayment;
        ReceiptAllocations."Loan No.":=Loans."Loan  No.";
        ReceiptAllocations.Amount:=ROUND(LOustanding,0.01);
        ReceiptAllocations."Interest Amount":=ROUND(InterestPaid,0.01);
        ReceiptAllocations."Total Amount":=ReceiptAllocations.Amount+ReceiptAllocations."Interest Amount";
        ReceiptAllocations.Insert;
        end;


        end;


        until Loans.Next = 0;
        end;

        if RunBal > 0 then begin
        ReceiptAllocations.Init;
        ReceiptAllocations."Document No":="Transaction No.";
        ReceiptAllocations."Member No":="Account No.";
        ReceiptAllocations."Transaction Type":=ReceiptAllocations."transaction type"::Investment;
        ReceiptAllocations."Loan No.":='';
        ReceiptAllocations.Amount:=RunBal;
        ReceiptAllocations."Interest Amount":=0;
        ReceiptAllocations."Total Amount":=ReceiptAllocations.Amount+ReceiptAllocations."Interest Amount";
        ReceiptAllocations.Insert;

        end;
    end;


    procedure PostBOSAEntries()
    var
        ReceiptAllocation: Record "HR Appraisal Assignment";
    begin
        
        TestField("Account No.");
        TestField(Amount);
        //TESTFIELD("Bank No.");
        
        if ("Account Type" = "account type"::"G/L Account") or
           ("Account Type" = "account type"::Debtor) then
        TransType := 'Withdrawal'
        else
        TransType := 'Deposit';
        
        BOSABank:="Bank No.";
        if ("Account Type" = "account type"::Member) or ("Account Type" = "account type"::"FOSA Loan") then begin
        if Amount <> "Allocated Amount" then
        Error('Receipt amount must be equal to the allocated amount.');
        end;
        
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name",'BTRANS');
        GenJournalLine.DeleteAll;
        
        
        LineNo:=LineNo+10000;
        
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='GENERAL';
        GenJournalLine."Journal Batch Name":='BTRANS';
        GenJournalLine."Document No.":="Transaction No.";
        GenJournalLine."External Document No.":="Cheque No.";
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No.":=BOSABank;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:='BT-'+Name;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        if TransType = 'Withdrawal' then
        GenJournalLine.Amount:=-Amount
        else
        GenJournalLine.Amount:=Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        if ("Account Type" <> "account type"::Member) and ("Account Type" <> "account type"::"FOSA Loan") then begin
        LineNo:=LineNo+10000;
        
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='GENERAL';
        GenJournalLine."Journal Batch Name":='BTRANS';
        GenJournalLine."Document No.":="Transaction No.";
        GenJournalLine."External Document No.":="Cheque No.";
        GenJournalLine."Line No.":=LineNo;
        if "Account Type" = "account type"::"G/L Account" then
        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account"
        else if "Account Type" = "account type"::Debtor then
        GenJournalLine."Account Type":=GenJournalLine."account type"::Member
        else if "Account Type" = "account type"::Member then
        GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
        GenJournalLine."Account No.":="Account No.";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:=Name;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        if TransType = 'Withdrawal' then
        GenJournalLine.Amount:=Amount
        else
        GenJournalLine.Amount:=-Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        end;
        
        
        if ("Account Type" = "account type"::Member) or ("Account Type" = "account type"::"FOSA Loan") then begin
        ReceiptAllocations.Reset;
        ReceiptAllocations.SetRange(ReceiptAllocations."Document No","Transaction No.");
        if ReceiptAllocations.Find('-') then begin
        repeat
        
        LineNo:=LineNo+10000;
        
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='GENERAL';
        GenJournalLine."Journal Batch Name":='BTRANS';
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Document No.":="Transaction No.";
        GenJournalLine."External Document No.":="Cheque No.";
        GenJournalLine."Posting Date":="Transaction Date";
        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Fanikisha then begin
        GenJournalLine."Account Type":=GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Account No.":='1-11-000108';
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description:=Name;
        GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        end else begin
        GenJournalLine."Account Type":=GenJournalLine."bal. account type"::Member;
        GenJournalLine."Account No.":=ReceiptAllocations."Member No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description:=Format(ReceiptAllocations."Transaction Type");
        end;
        
        GenJournalLine."Prepayment date":=ReceiptAllocation."Prepayment Date";
        GenJournalLine.Amount:=-ReceiptAllocations.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Insurance Contribution" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Insurance Contribution"
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Deposit Contribution" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Deposit Contribution"
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Benevolent Fund" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Benevolent Fund"
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Repayment then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::Repayment
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Registration Fee"
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Shares Capital" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Shares Capital";
        GenJournalLine."Loan No":=ReceiptAllocations."Loan No.";
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Repayment) and
           (ReceiptAllocations."Interest Amount" > 0) then begin
        LineNo:=LineNo+10000;
        
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='GENERAL';
        GenJournalLine."Journal Batch Name":='BTRANS';
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Document No.":="Transaction No.";
        GenJournalLine."External Document No.":="Cheque No.";
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine."Account Type":=GenJournalLine."bal. account type"::Member;
        GenJournalLine."Account No.":=ReceiptAllocations."Member No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description:='Interest Paid';
        GenJournalLine.Amount:=-ReceiptAllocations."Interest Amount";
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Interest Paid";
        GenJournalLine."Loan No":=ReceiptAllocations."Loan No.";
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        end;
        until ReceiptAllocations.Next = 0;
        end;
        
        end;
        
        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name",'BTRANS');
        if GenJournalLine.Find('-') then begin
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post",GenJournalLine);
        end;
        //Post New
        Posted:=true;
        Modify;
        Message('Transactions Posted successfully');
        
        
        
        Commit;
        Reset;
        SetFilter("Transaction No.","Transaction No.");
        Report.Run(39003958,true,true,Rec);
        Reset;
        
        /*
        BOSARcpt.RESET;
        BOSARcpt.SETRANGE(BOSARcpt."Transaction No.","Transaction No.");
        IF BOSARcpt.FIND('-') THEN
        REPORT.RUN(39003958,TRUE,TRUE,BOSARcpt)
        */

    end;

    local procedure AllocatedAmountOnDeactivate()
    begin
        CurrPage.Update:=true;
    end;


    procedure PostSTAFFLoan()
    var
        ReceiptAllocation: Record "HR Appraisal Assignment";
    begin
        
        TestField("Account No.");
        TestField(Amount);
        TestField("Bank No.");
        //TESTFIELD("Cheque No.");
        //TESTFIELD("Cheque Date");
        
        if ("Account Type" = "account type"::"G/L Account") or
           ("Account Type" = "account type"::Debtor) then
        TransType := 'Deposit';
        
        BOSABank:="Bank No.";
        if ("Account Type" = "account type"::Debtor) then begin
        if Amount <> "Allocated Amount" then
        Error('Receipt amount must be equal to the allocated amount.');
        end;
        
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
        GenJournalLine.DeleteAll;
        
        
        LineNo:=LineNo+10000;
        
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='GENERAL';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":="Transaction No.";
        GenJournalLine."External Document No.":="Cheque No.";
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No.":=BOSABank;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:='BT-'+Name;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        if TransType = 'Withdrawal' then
        GenJournalLine.Amount:=-Amount
        else
        GenJournalLine.Amount:=Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        /*IF ("Account Type" <> "Account Type"::Member) AND ("Account Type" <> "Account Type"::"FOSA Loan") THEN BEGIN
        LineNo:=LineNo+10000;
        
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name":='GENERAL';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":="Transaction No.";
        GenJournalLine."External Document No.":="Cheque No.";
        GenJournalLine."Line No.":=LineNo;
        IF "Account Type" = "Account Type"::"G/L Account" THEN
        GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account"
        ELSE IF "Account Type" = "Account Type"::Debtor THEN
        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Customer
        ELSE IF "Account Type" = "Account Type"::Member THEN
        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
        GenJournalLine."Account No.":="Account No.";
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:=Name;
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
        IF TransType = 'Withdrawal' THEN
        GenJournalLine.Amount:=Amount
        ELSE
        GenJournalLine.Amount:=-Amount;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        IF GenJournalLine.Amount<>0 THEN
        GenJournalLine.INSERT;
        
        END;*/
        
        
        if ("Account Type" = "account type"::Debtor) or ("Account Type" = "account type"::"FOSA Loan") then begin
        
        ReceiptAllocations.Reset;
        ReceiptAllocations.SetRange(ReceiptAllocations."Document No","Transaction No.");
        if ReceiptAllocations.Find('-') then begin
        repeat
        
        LineNo:=LineNo+10000;
        
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='GENERAL';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Document No.":="Transaction No.";
        GenJournalLine."External Document No.":="Cheque No.";
        GenJournalLine."Posting Date":="Transaction Date";
        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Fanikisha then begin
        GenJournalLine."Account Type":=GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Account No.":='1-11-000108';
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description:=Name;
        GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        end else begin
        GenJournalLine."Account Type":=GenJournalLine."bal. account type"::Customer;
        GenJournalLine."Account No.":=ReceiptAllocations."Member No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description:=Format(ReceiptAllocations."Transaction Type");
        end;
        //PKK
        /*
        IF (ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::"Insurance Contribution") AND
           (ReceiptAllocations.Amount = 100) THEN
        GenJournalLine.Amount:=-75
        ELSE
        */
        //PKK
        GenJournalLine."Prepayment date":=ReceiptAllocation."Prepayment Date";
        GenJournalLine.Amount:=-ReceiptAllocations.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Insurance Contribution" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Insurance Contribution"
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Deposit Contribution" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Deposit Contribution"
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Investment then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Unallocated Funds"
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Repayment then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::Repayment
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Registration Fee"
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Shares Capital" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Shares Capital";
        GenJournalLine."Loan No":=ReceiptAllocations."Loan No.";
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Repayment) and
           (ReceiptAllocations."Interest Amount" > 0) then begin
        LineNo:=LineNo+10000;
        
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='GENERAL';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Document No.":="Transaction No.";
        GenJournalLine."External Document No.":="Cheque No.";
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine."Account Type":=GenJournalLine."bal. account type"::Customer;
        GenJournalLine."Account No.":=ReceiptAllocations."Member No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description:='Interest Paid';
        GenJournalLine.Amount:=-ReceiptAllocations."Interest Amount";
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Interest Paid";
        GenJournalLine."Loan No":=ReceiptAllocations."Loan No.";
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        end;
        until ReceiptAllocations.Next = 0;
        end;
        
        end;
        
        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
        if GenJournalLine.Find('-') then begin
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post",GenJournalLine);
        end;
        
        //Post New
        
        Posted:=true;
        Modify;
        
        Commit;
        Reset;
        SetFilter("Transaction No.","Transaction No.");
        Report.Run(39003958,true,true,Rec);
        Reset;

    end;


    procedure PostMicroEntries()
    begin

        TestField("Account No.");
        TestField(Amount);

        BOSABank:="Bank No.";
        if ("Account Type" = "account type"::Member) or ("Account Type" = "account type"::"FOSA Loan") then begin
        if Amount <> "Allocated Amount" then
        Error(Text004);
        end;

        Temp.Get(UserId);
        Jtemplate:=Temp."Receipt Journal Template";
        JBatch:=Temp."Receipt Journal Batch";

        if Jtemplate = '' then begin
        Error(Text006,UserId)
        end;
        if JBatch = '' then begin
        Error(Text007,UserId)
        end;


        //Generate and Post Approved Loan Amount
        if not GenBatch.Get(Jtemplate,JBatch) then
        begin
        GenBatch.Init;
        GenBatch."Journal Template Name":=Jtemplate;
        GenBatch.Name:=JBatch;
        GenBatch.Insert;
        end;


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name",Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name",JBatch);
        GenJournalLine.DeleteAll;

        LineNo:=LineNo+10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":=Jtemplate;
        GenJournalLine."Journal Batch Name":=JBatch;
        GenJournalLine."Document No.":="Transaction No.";
        GenJournalLine."External Document No.":="Cheque No.";
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No.":="FOSA Account No.";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:='BT-'+Name;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=Amount;
        GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
        GenJournalLine."Shortcut Dimension 2 Code":="Branch Code";
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");

        GenJournalLine.Validate(GenJournalLine.Amount);
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;

        if ("Account Type" <> "account type"::Member) and ("Account Type" <> "account type"::"FOSA Loan") then begin

        LineNo:=LineNo+10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":=Jtemplate;
        GenJournalLine."Journal Batch Name":=JBatch;
        GenJournalLine."Document No.":="Transaction No.";
        GenJournalLine."External Document No.":="Cheque No.";
        GenJournalLine."Line No.":=LineNo;
        if "Account Type" = "account type"::"G/L Account" then
        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account"
        else if "Account Type" = "account type"::Debtor then
        GenJournalLine."Account Type":=GenJournalLine."account type"::Member
        else if "Account Type" = "account type"::Member then
        GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
        GenJournalLine."Account No.":="Account No.";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:=Name;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=-Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code":="Activity Code";
        GenJournalLine."Shortcut Dimension 2 Code":="Branch Code";
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;

        end;

        if ("Account Type" = "account type"::Member) or ("Account Type" = "account type"::"FOSA Loan") then begin

        ReceiptAllocations.Reset;
        ReceiptAllocations.SetRange(ReceiptAllocations."Document No","Transaction No.");
        if ReceiptAllocations.Find('-') then begin
        repeat

        LineNo:=LineNo+10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":=Jtemplate;
        GenJournalLine."Journal Batch Name":=JBatch;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Document No.":="Transaction No.";
        GenJournalLine."External Document No.":="Cheque No.";
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine."Account Type":=GenJournalLine."bal. account type"::Member;
        GenJournalLine."Account No.":=ReceiptAllocations."Member No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description:=Format(ReceiptAllocations."Transaction Type");
        GenJournalLine."Prepayment date":=ReceiptAllocations."Prepayment Date";
        GenJournalLine.Amount:=-ReceiptAllocations.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Insurance Contribution" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Insurance Contribution"
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Deposit Contribution" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Deposit Contribution"
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Benevolent Fund" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Benevolent Fund"
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Repayment then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::Repayment
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Registration Fee"
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Shares Capital" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Shares Capital";
        GenJournalLine."Loan No":=ReceiptAllocations."Loan No.";
        GenJournalLine."Shortcut Dimension 1 Code":="Activity Code";
        GenJournalLine."Shortcut Dimension 2 Code":="Branch Code";
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");

        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;

        if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Repayment) and
           (ReceiptAllocations."Interest Amount" > 0) then begin

        LineNo:=LineNo+10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":=Jtemplate;
        GenJournalLine."Journal Batch Name":=JBatch;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Document No.":="Transaction No.";
        GenJournalLine."External Document No.":="Cheque No.";
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine."Account Type":=GenJournalLine."bal. account type"::Member;
        GenJournalLine."Account No.":=ReceiptAllocations."Member No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description:='Interest Paid';
        GenJournalLine.Amount:=-ReceiptAllocations."Interest Amount";
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Interest Paid";
        GenJournalLine."Loan No":=ReceiptAllocations."Loan No.";
        GenJournalLine."Shortcut Dimension 1 Code":="Activity Code";
        GenJournalLine."Shortcut Dimension 2 Code":="Branch Code";
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;

        end;
        until ReceiptAllocations.Next = 0;
        end;

        end;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name",Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name",JBatch);
        if GenJournalLine.Find('-') then begin
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post",GenJournalLine);
        end;
        Posted:=true;
        "Posted By":=UserId;
        "Date Posted":=Today;
        "Time Posted":=Time;
        Modify;
        SendSMS();
        Message(Text005);

        Commit;
        Reset;
        SetFilter("Transaction No.","Transaction No.");
        Report.Run(39003958,true,true,Rec);
        Reset;
    end;


    procedure SendSMS()
    begin


        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
        iEntryNo:=SMSMessages."Entry No";
        iEntryNo:=iEntryNo+1;
        end else begin
        iEntryNo:=1;
        end;

        if MembCustz.Get("Account No.") then begin

        SMSMessages.Init;
        SMSMessages."Entry No":=iEntryNo;
        SMSMessages."Account No":="Account No.";
        SMSMessages."Date Entered":=Today;
        SMSMessages."Time Entered":=Time;
        SMSMessages.Source:='Micro Receipts';
        SMSMessages."Entered By":=UserId;
        SMSMessages."System Created Entry":=true;
        SMSMessages."Document No":="Transaction No.";
        SMSMessages."Sent To Server":=SMSMessages."sent to server"::No;
        SMSMessages."SMS Message":='Dear Sir/Madam,' +Name+ 'Amount of Kshs'+Format(Amount)+ ' has been Debited to your FOSA account for repayment of your Loan.MWALIMU NATIONAL SACCCO. 0709898000.';
        if MembCustz."Phone No."<> '' then begin
        SMSMessages."Telephone No":=MembCustz."Phone No.";
        end else begin
        SMSMessages."Telephone No":=MembCustz."Phone No.";
        end;
        SMSMessages.Insert;
        end;
    end;
}

