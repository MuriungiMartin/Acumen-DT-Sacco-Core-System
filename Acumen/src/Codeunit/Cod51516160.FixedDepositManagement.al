#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516160 "FixedDepositManagement"
{
    TableNo = "FD Processing";

    trigger OnRun()
    begin
    end;

    var
        AccountTypes: Record "Account Types-Saving Products";
        FDType: Record "Fixed Deposit Type";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        InterestBuffer: Record "Interest Buffer";
        Vend: Record Vendor;
        GLEntries: Record "G/L Entry";
        FDInterestCalc: Record "FD Interest Calculation Crite";
        FAccountType: Record "Account Types-Saving Products";
        IntRate: Decimal;
        WhichDay: Integer;
        InterestAmount: Decimal;
        FixedDepType: Record "Fixed Deposit Type";
        FDDays: Integer;
        IntBufferNo: Integer;
        StatusPermission: Record "Status Change Permision";
        EAccount: Code[10];
        EAMount: Decimal;
        i: Integer;
        Tsci: Integer;
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        UsersID: Record User;
        TotalTopupComm: Decimal;
        Banks: Record "Bank Account";
        WithdrawalFee: Decimal;
        NetPayable: Decimal;
        NetRefund: Decimal;
        FWithdrawal: Decimal;
        OutstandingInt: Decimal;
        TSC: Decimal;
        NegFee: Decimal;
        DValue: Record "Dimension Value";
        ChBank: Code[20];
        SMSMessage: Record "SMS Messages";
        GenSetUp: Record "Sacco General Set-Up";
        iEntryNo: Decimal;
        CompanyInfo: Record "Company Information";


    procedure RollOver(DocNo: Code[10];RunDate: Date)
    var
        ShortMessage: Record "SMS Messages";
        Account: Record "FD Processing";
    begin

        if Account.Get(DocNo)then
          begin
            if AccountTypes.Get(Account."Account Type") then
              begin
              if AccountTypes."Fixed Deposit" = true then
                begin
              if AccountTypes."Earns Interest" = true then
                Account.TestField(Account."FD Maturity Date");
                if Account."FD Maturity Date" <=RunDate then
                  begin
                     RunDate:=Account."FD Maturity Date";
                    FDType.Reset;
                    FDType.SetRange(FDType.Code,Account."Fixed Deposit Type");
                    if FDType.Find('-')then
                      begin
                      //CalculateFDInterest(Account,RunDate);

                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code,Account."Account Type");
                    if AccountTypes.Find('-') then
                      begin

                      LineNo:=LineNo+10000;
                      Account.CalcFields("Untranfered Interest");

                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='PURCHASES';
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Journal Batch Name":='FXDEP';
                      GenJournalLine."Document No.":=DocNo;
                      GenJournalLine."External Document No.":=DocNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                      GenJournalLine."Account No.":=Account."Destination Account";
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":=RunDate;
                      GenJournalLine.Description:='FD Interest - '+Format(Account."FD Maturity Date",0,' <Day,2>-<Month Text,3>-<Year4> ');
                      GenJournalLine.Description:=UpperCase(GenJournalLine.Description);
                      GenJournalLine.Amount:=-Account."Untranfered Interest";
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                      GenJournalLine."Bal. Account No.":=AccountTypes."Interest Payable Account";
                      GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                      GenJournalLine."Shortcut Dimension 1 Code":=Account."Global Dimension 1 Code";
                      GenJournalLine."Shortcut Dimension 2 Code":=Account."Global Dimension 2 Code";
                      //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                      if GenJournalLine.Amount<>0 then
                      GenJournalLine.Insert;


                      LineNo:=LineNo+10000;

                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='PURCHASES';
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Journal Batch Name":='FXDEP';
                      GenJournalLine."Document No.":=DocNo;
                      GenJournalLine."External Document No.":=DocNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                      GenJournalLine."Account No.":=Account."Destination Account";
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":=RunDate;
                      GenJournalLine.Description:='Withholding Tax';
                      GenJournalLine.Description:=UpperCase(GenJournalLine.Description);
                      GenJournalLine.Amount:=Account."Untranfered Interest"*(AccountTypes."Tax On Interest"/100);
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                      GenJournalLine."Bal. Account No.":=AccountTypes."Interest Tax Account";
                      GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                      GenJournalLine."Shortcut Dimension 1 Code":=Account."Global Dimension 1 Code";
                      GenJournalLine."Shortcut Dimension 2 Code":=Account."Global Dimension 2 Code";
                      //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                      if GenJournalLine.Amount<>0 then
                      GenJournalLine.Insert;




                      LineNo:=LineNo+10000;
                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='PURCHASES';
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Journal Batch Name":='FXDEP';
                      GenJournalLine."Document No.":=DocNo;
                      GenJournalLine."External Document No.":=DocNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                      GenJournalLine."Account No.":=Account."Destination Account";
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":=RunDate;
                      GenJournalLine.Description:='Principle Amount';
                      GenJournalLine.Description:=UpperCase(GenJournalLine.Description);
                      GenJournalLine.Amount:=(Account."Amount to Transfer"+Account."Untranfered Interest")-(Account."Untranfered Interest"*(AccountTypes."Tax On Interest"/100));
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      GenJournalLine."Shortcut Dimension 1 Code":=Account."Global Dimension 1 Code";
                      GenJournalLine."Shortcut Dimension 2 Code":=Account."Global Dimension 2 Code";
                      //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                      if GenJournalLine.Amount<>0 then
                      GenJournalLine.Insert;


                      LineNo:=LineNo+10000;
                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='PURCHASES';
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Journal Batch Name":='FXDEP';
                      GenJournalLine."Document No.":=DocNo;
                      GenJournalLine."External Document No.":=DocNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                      GenJournalLine."Account No.":=Account."Savings Account No.";
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":=RunDate;
                      GenJournalLine.Description:='Transfer from Fixed';
                      GenJournalLine.Description:=UpperCase(GenJournalLine.Description);
                      GenJournalLine.Amount:=((Account."Amount to Transfer"+Account."Untranfered Interest")-(Account."Untranfered Interest"*(AccountTypes."Tax On Interest"/100)))*-1;
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      GenJournalLine."Shortcut Dimension 1 Code":=Account."Global Dimension 1 Code";
                      GenJournalLine."Shortcut Dimension 2 Code":=Account."Global Dimension 2 Code";
                      //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                      if GenJournalLine.Amount<>0 then
                      GenJournalLine.Insert;


        //               GenJournalLine.RESET;
        //               GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
        //               GenJournalLine.SETRANGE("Journal Batch Name",'FXDEP');
        //               IF GenJournalLine.FIND('-') THEN BEGIN
        //                 CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJournalLine);
        //               END;

                      InterestBuffer.Reset;
                      InterestBuffer.SetRange(InterestBuffer."Account No",Account."Destination Account");
                      if InterestBuffer.Find('-') then
                      InterestBuffer.ModifyAll(InterestBuffer.Transferred,true);
                      //Account."FD Maturity Date":=CALCDATE(FDType.Duration,Account."FD Maturity Date");
                      Account."Fixed Deposit Status":=Account."fixed deposit status"::Matured;
                      Account."FDR Deposit Status Type":=Account."fdr deposit status type"::Terminated;
                      Account."Amount to Transfer":=0;
                      Account."Expected Interest On Term Dep":=0;
                      Account.Modify;

                      if GenSetUp."Send ATM Withdrawal SMS"=true then begin

                      iEntryNo:=iEntryNo+1;

                      CompanyInfo.Get();
                      ShortMessage.Reset;
                      if ShortMessage.Find('+') then begin

                      ShortMessage.Init;
                      ShortMessage."Entry No":=iEntryNo+ShortMessage."Entry No";
                      ShortMessage."Batch No":='';
                      ShortMessage."Document No":='';
                      ShortMessage."Telephone No":=Account."Phone No.";
                      ShortMessage."Account No":=Account."Destination Account";
                      ShortMessage."Date Entered":=Today;
                      ShortMessage."Time Entered":=Time;
                      ShortMessage.Source:='Fixed Deposit';
                      ShortMessage."SMS Message":='Dear Member-'+Account.Name+'-Your Fixed Deposit Has matured and transferred to Savings.'+CompanyInfo.Name;
                      ShortMessage."Entered By":=UserId;
                      ShortMessage."Sent To Server":=ShortMessage."sent to server"::No;
                      if Account."Phone No."<> '' then begin
                      ShortMessage."Telephone No":=Account."Phone No.";
                      end else begin
                      ShortMessage."Telephone No":=Account."Mobile Phone No";
                      end;
                      if ShortMessage."Telephone No"<>'' then
                      ShortMessage.Insert;
                      end;
                      end;





                    end;
                  end;
                end;
              end;
            end;

            end;


        //END;
    end;


    procedure Renew(DocNo: Code[10];RunDate: Date)
    var
        ShortMessage: Record "SMS Messages";
        Account: Record "FD Processing";
        StartDate: Date;
    begin

        if Account.Get(DocNo) then
          begin
            if AccountTypes.Get(Account."Account Type") then begin
              if AccountTypes."Fixed Deposit" = true then begin
              if AccountTypes."Earns Interest" = true then
                Account.TestField("FD Maturity Date");
                if Account."FD Maturity Date" <= RunDate then begin
                  RunDate:=Account."FD Maturity Date";
                  FDType.Reset;
                  FDType.SetRange(FDType.Code,Account."Fixed Deposit Type");
                  if FDType.Find('-') then
                    begin
                  //IF FDType.GET(Account."Fixed Deposit Type") THEN BEGIN
                    //CalculateFDInterest(Account,RunDate);
                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code,Account."Account Type");
                    if AccountTypes.Find('-') then  begin

                      Account.TestField("Savings Account No.");


                        LineNo:=LineNo+10000;
                      Account.CalcFields("Untranfered Interest");

                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='PURCHASES';
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Journal Batch Name":='FXDEP';
                      GenJournalLine."Document No.":=DocNo;
                      GenJournalLine."External Document No.":=DocNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                      GenJournalLine."Account No.":=Account."Destination Account";

                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":=RunDate;
                      GenJournalLine.Description:='FD Interest - '+Format(Account."FD Maturity Date",0,' <Day,2>-<Month Text,3>-<Year4> ');
                      GenJournalLine.Description:=UpperCase(GenJournalLine.Description);
                      GenJournalLine.Amount:=-Account."Untranfered Interest";
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                      GenJournalLine."Bal. Account No.":=AccountTypes."Interest Expense Account";
                      GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                      GenJournalLine."Shortcut Dimension 1 Code":=Account."Global Dimension 1 Code";
                      GenJournalLine."Shortcut Dimension 2 Code":=Account."Global Dimension 2 Code";
                      //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                      if GenJournalLine.Amount<>0 then
                      GenJournalLine.Insert;


                      //Withholding tax
                      LineNo:=LineNo+10000;
                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='PURCHASES';
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Journal Batch Name":='FXDEP';
                      GenJournalLine."Document No.":=DocNo;
                      GenJournalLine."External Document No.":=DocNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                      GenJournalLine."Account No.":=Account."Destination Account";
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":=RunDate;
                      GenJournalLine.Description:='Withholding Tax';
                      GenJournalLine.Description:=UpperCase(GenJournalLine.Description);
                      GenJournalLine.Amount:=Account."Untranfered Interest"*(AccountTypes."Tax On Interest"/100);
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                      GenJournalLine."Bal. Account No.":=AccountTypes."Interest Tax Account";
                      GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                      GenJournalLine."Shortcut Dimension 1 Code":=Account."Global Dimension 1 Code";
                      GenJournalLine."Shortcut Dimension 2 Code":=Account."Global Dimension 2 Code";
                      //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                     // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                      if GenJournalLine.Amount<>0 then
                      GenJournalLine.Insert;

                      //Withholding tax

                      //Transfer to savings
                      LineNo:=LineNo+10000;
                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='PURCHASES';
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Journal Batch Name":='FXDEP';
                      GenJournalLine."Document No.":=DocNo;
                      GenJournalLine."External Document No.":=DocNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                      GenJournalLine."Account No.":=Account."Destination Account";
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":=RunDate;
                      GenJournalLine.Description:='Transfered Interest '+DocNo;
                      GenJournalLine.Description:=UpperCase(GenJournalLine.Description);
                      GenJournalLine.Amount:=Account."Untranfered Interest"-(Account."Untranfered Interest"*(AccountTypes."Tax On Interest"/100));
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      GenJournalLine."Shortcut Dimension 1 Code":=Account."Global Dimension 1 Code";
                      GenJournalLine."Shortcut Dimension 2 Code":=Account."Global Dimension 2 Code";
                      //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                      if GenJournalLine.Amount<>0 then
                      GenJournalLine.Insert;


                      LineNo:=LineNo+10000;
                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='PURCHASES';
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Journal Batch Name":='FXDEP';
                      GenJournalLine."Document No.":=DocNo;
                      GenJournalLine."External Document No.":=DocNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                      GenJournalLine."Account No.":=Account."Savings Account No.";
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":=RunDate;
                      GenJournalLine.Description:='Transfer from Fixed';
                      GenJournalLine.Description:=UpperCase(GenJournalLine.Description);
                      GenJournalLine.Amount:=(Account."Untranfered Interest"-(Account."Untranfered Interest"*(AccountTypes."Tax On Interest"/100)))*-1;
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      GenJournalLine."Shortcut Dimension 1 Code":=Account."Global Dimension 1 Code";
                      GenJournalLine."Shortcut Dimension 2 Code":=Account."Global Dimension 2 Code";
                      //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                      if GenJournalLine.Amount<>0 then
                      GenJournalLine.Insert;





        //               GenJournalLine.RESET;
        //               GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
        //               GenJournalLine.SETRANGE("Journal Batch Name",'FXDEP');
        //               IF GenJournalLine.FIND('-') THEN BEGIN
        //                 CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJournalLine);
        //               END;


                      InterestBuffer.Reset;
                      InterestBuffer.SetRange(InterestBuffer."Account No",Account."Destination Account");
                      if InterestBuffer.Find('-') then
                      InterestBuffer.ModifyAll(InterestBuffer.Transferred,true);

                      StartDate:=Account."FD Maturity Date";
                      Account."Fixed Deposit Start Date":=Account."FD Maturity Date";
                      Account."FD Maturity Date":=CalcDate(Account."Fixed Duration",StartDate);
                      Account.Modify;

                      if GenSetUp."Send ATM Withdrawal SMS"=true then begin

                      iEntryNo:=iEntryNo+1;

                      CompanyInfo.Get();
                      ShortMessage.Reset;
                      if ShortMessage.Find('+') then begin

                      ShortMessage.Init;
                      ShortMessage."Entry No":=iEntryNo+ShortMessage."Entry No";
                      ShortMessage."Batch No":='';
                      ShortMessage."Document No":='';
                      ShortMessage."Telephone No":=Account."Phone No.";
                      ShortMessage."Account No":=Account."Destination Account";
                      ShortMessage."Date Entered":=Today;
                      ShortMessage."Time Entered":=Time;
                      ShortMessage.Source:='Fixed Deposit';
                      ShortMessage."SMS Message":='Dear Member-'+Account.Name+'-Your Fixed Deposit Has matured and Interest Transferred to Savings and Renewed.'+CompanyInfo.Name;
                      ShortMessage."Entered By":=UserId;
                      ShortMessage."Sent To Server":=ShortMessage."sent to server"::No;
                      if Account."Phone No."<> '' then begin
                      ShortMessage."Telephone No":=Account."Phone No.";
                      end else begin
                      ShortMessage."Telephone No":=Account."Mobile Phone No";
                      end;
                      if Account."Phone No."<>'' then
                      ShortMessage.Insert;
                      end;
                      end;

                    end;
                  end;
                end;
              end;
            end;
        end;
    end;


    procedure CloseNonRenewable(DocNo: Code[10];RunDate: Date)
    var
        ShortMessage: Record "SMS Messages";
        Account: Record "FD Processing";
        StartDate: Date;
    begin

        if Account.Get(DocNo) then
          begin
            if AccountTypes.Get(Account."Account Type") then begin
              if AccountTypes."Fixed Deposit" = true then begin
              if AccountTypes."Earns Interest" = true then
                Account.TestField("FD Maturity Date");
                if Account."FD Maturity Date" <= RunDate then begin
                   RunDate:=Account."FD Maturity Date";
                  FDType.Reset;
                  FDType.SetRange(FDType.Code,Account."Fixed Deposit Type");
                  if FDType.Find('-') then
                    begin
                    //CalculateFDInterest(Account,RunDate);

                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code,Account."Account Type");
                    if AccountTypes.Find('-') then  begin
                      Account.TestField("Savings Account No.");

                      LineNo:=LineNo+10000;
                      Account.CalcFields("Untranfered Interest");

                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='PURCHASES';
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Journal Batch Name":='FXDEP';
                      GenJournalLine."Document No.":=DocNo;
                      GenJournalLine."External Document No.":=DocNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                      GenJournalLine."Account No.":=Account."Destination Account";

                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":=RunDate;
                      GenJournalLine.Description:='FD Interest - '+Format(Account."FD Maturity Date",0,' <Day,2>-<Month Text,3>-<Year4> ');
                      GenJournalLine.Description:=UpperCase(GenJournalLine.Description);
                      GenJournalLine.Amount:=-Account."Untranfered Interest";
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                      GenJournalLine."Bal. Account No.":=AccountTypes."Interest Expense Account";
                      GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                      GenJournalLine."Shortcut Dimension 1 Code":=Account."Global Dimension 1 Code";
                      GenJournalLine."Shortcut Dimension 2 Code":=Account."Global Dimension 2 Code";
                      //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                      if GenJournalLine.Amount<>0 then
                      GenJournalLine.Insert;



                      LineNo:=LineNo+10000;
                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='PURCHASES';
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Journal Batch Name":='FXDEP';
                      GenJournalLine."Document No.":=DocNo;
                      GenJournalLine."External Document No.":=DocNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                      GenJournalLine."Account No.":=Account."Destination Account";
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":=RunDate;
                      GenJournalLine.Description:='Withholding Tax';
                      GenJournalLine.Description:=UpperCase(GenJournalLine.Description);
                      GenJournalLine.Amount:=Account."Untranfered Interest"*(AccountTypes."Tax On Interest"/100);
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                      GenJournalLine."Bal. Account No.":=AccountTypes."Interest Tax Account";
                      GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                      GenJournalLine."Shortcut Dimension 1 Code":=Account."Global Dimension 1 Code";
                      GenJournalLine."Shortcut Dimension 2 Code":=Account."Global Dimension 2 Code";
                      //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                      if GenJournalLine.Amount<>0 then
                      GenJournalLine.Insert;


        //               GenJournalLine.RESET;
        //               GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
        //               GenJournalLine.SETRANGE("Journal Batch Name",'FXDEP');
        //               IF GenJournalLine.FIND('-') THEN BEGIN
        //                 CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJournalLine);
        //               END;

                      InterestBuffer.Reset;
                      InterestBuffer.SetRange(InterestBuffer."Account No",Account."Destination Account");
                      if InterestBuffer.Find('-') then
                      InterestBuffer.ModifyAll(InterestBuffer.Transferred,true);

                      StartDate:=Account."FD Maturity Date";

                      Account."Fixed Deposit Start Date":=Account."FD Maturity Date";
                      Account."Amount to Transfer":=(Account."Amount to Transfer"+(Account."Untranfered Interest"-(Account."Untranfered Interest"*(AccountTypes."Tax On Interest"/100))));
                      Account."FD Maturity Date":=CalcDate(Account."Fixed Duration",StartDate);
                      Account.Modify;


                      if GenSetUp."Send ATM Withdrawal SMS"=true then begin

                      iEntryNo:=iEntryNo+1;

                      CompanyInfo.Get();
                      ShortMessage.Reset;
                      if ShortMessage.Find('+') then begin

                      ShortMessage.Init;
                      ShortMessage."Entry No":=iEntryNo+ShortMessage."Entry No";
                      ShortMessage."Batch No":='';
                      ShortMessage."Document No":='';
                      ShortMessage."Telephone No":=Account."Phone No.";
                      ShortMessage."Account No":=Account."Destination Account";
                      ShortMessage."Date Entered":=Today;
                      ShortMessage."Time Entered":=Time;
                      ShortMessage.Source:='Fixed Deposit';
                      ShortMessage."SMS Message":='Dear Member-'+Account.Name+'-Your Fixed Deposit Has matured and Renewed.'+CompanyInfo.Name;
                      ShortMessage."Entered By":=UserId;
                      ShortMessage."Sent To Server":=ShortMessage."sent to server"::No;
                      if Account."Phone No."<> '' then begin
                      ShortMessage."Telephone No":=Account."Phone No.";
                      end else begin
                      ShortMessage."Telephone No":=Account."Mobile Phone No";
                      end;
                      if Account."Phone No."<>'' then
                      ShortMessage.Insert;
                      end;
                      end;


                    end;
                  end;
                end;
              end;
            end;
          end;
    end;


    procedure CalculateFDInterest(Account: Record "FD Processing";RunDate: Date)
    begin
        
        InterestAmount:=0;
        
        InterestBuffer.Reset;
        IntRate:=Account."Neg. Interest Rate";
        
        if InterestBuffer.Find('+') then
        IntBufferNo:=InterestBuffer.No;
        
        
        if AccountTypes.Get(Account."Account Type") then begin
          if AccountTypes."Fixed Deposit" = true then begin
            FixedDepType.Reset;
            FixedDepType.SetRange(FixedDepType.Code,Account."Fixed Deposit Type");
            if FixedDepType.Find('-')then
              begin
                FDInterestCalc.Reset;
                FDInterestCalc.SetRange(FDInterestCalc.Code,Account."Fixed Deposit Type");
                if FDInterestCalc.Find('-') then begin
                  repeat
                    /*IF (FDInterestCalc."Minimum Amount" <= Account."Balance (LCY)") AND
                    (Account."Balance (LCY)" <= FDInterestCalc."Maximum Amount") THEN
                      IntRate:=FDInterestCalc."Interest Rate";*/
        
                  until FDInterestCalc.Next = 0;
                end;
        
                FDDays := CalcDate(FixedDepType.Duration,RunDate)-RunDate;
                InterestAmount := Account."Amount to Transfer"*IntRate*0.01*(FDDays/365);
                InterestAmount := ROUND(InterestAmount,1.0,'<');
        
        
        
                IntBufferNo:=IntBufferNo+1;
        
                InterestBuffer.Init;
                InterestBuffer."Account No":=Account."Destination Account";
                InterestBuffer.No:= IntBufferNo;
                InterestBuffer."Account Type":=Account."Account Type";
                InterestBuffer."Interest Date":=RunDate;
                InterestBuffer."Interest Amount":=InterestAmount;
                //InterestBuffer."Interest Earning Balance" := Account."Balance (LCY)";
                InterestBuffer.Description:='FD INT - '+Format(Account."FD Maturity Date",0,' <Day,2>-<Month Text,3>-<Year4> ');
                InterestBuffer.Description:=UpperCase(InterestBuffer.Description);
                InterestBuffer."User ID":=UserId;
                if InterestBuffer."Interest Amount" <> 0 then
                InterestBuffer.Insert(true);
             end;
          end;
        end;

    end;
}

