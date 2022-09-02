#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516008 "SUREAutomation"
{

    trigger OnRun()
    begin
    end;

    var
        objVendor: Record Vendor;
        objTransactions: Record Transactions;
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        GenSetup: Record "Sacco General Set-Up";
        Stos: Record "Standing Orders";
        DocNo: Code[10];
        PDate: Date;
        Transfer: Boolean;
        objFDProcess: Record "FD Processing";
        AccountType: Record "Account Types-Saving Products";
        SFactory: Codeunit "SURESTEP FactoryMobile";
        InterestBuffer: Record "Interest Buffer";
        Cust: Record "Member Register";
        Loans: Record "Loans Register";


    procedure FnRunStandingOrders()
    begin
        Stos.Reset;
        if Stos.Find('-') then begin
          Report.Run(51516461,false,false,Stos);
          end;
    end;


    procedure FnRunFixedDeposits(VendorNo: Code[100])
    begin
        objVendor.Reset;
        objVendor.SetRange(objVendor."No.",VendorNo);
        objVendor.SetRange(objVendor."Account Type",'FIXED');
        if objVendor.Find('-') then begin
         Report.Run(51516407,false,false,objVendor);//old FDS
        end;

        objFDProcess.Reset;
        objFDProcess.SetRange(objFDProcess."Destination Account",VendorNo);
        objFDProcess.SetRange(objFDProcess."Account Type",'FIXED');
        if objFDProcess.Find('-') then begin
          Report.Run(51516531,false,false,objFDProcess);//new FDS
        end;

        objFDProcess.Reset;
        objFDProcess.SetRange(objFDProcess."Destination Account",VendorNo);
        objFDProcess.SetRange(objFDProcess."Account Type",'CALL');
        if objFDProcess.Find('-') then begin
          Report.Run(51516541,false,false,objFDProcess);//CALL INT
        end;

        objVendor.Reset;
        objVendor.SetRange(objVendor."No.",VendorNo);
        objVendor.SetRange(objVendor."Account Type",'SMART');
        if objVendor.Find('-') then begin
          Report.Run(51516280,false,false,objVendor);//nSMART INT
        end;
    end;


    procedure FnChequeClearing()
    var
        Account: Record Vendor;
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name",'CHQCL');
        GenJournalLine.DeleteAll;

        objTransactions.Reset;
        objTransactions.SetRange(objTransactions."Transaction Type",'CHQDEPCURR');
        objTransactions.SetRange(objTransactions.Posted,true);
        objTransactions.SetRange(objTransactions."Cheque Processed",false);
        objTransactions.SetFilter(objTransactions."Expected Maturity Date",'..'+Format(Today));
        if objTransactions.Find('-') then
        begin
            repeat
            if Account.Get(objTransactions."Account No") then
              begin
                if Account."Cheque Discounted"<>0 then
                  begin
                    LineNo:=LineNo+10000;
                    GenSetup.Get();
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":='PURCHASES';
                    GenJournalLine."Journal Batch Name":='CHQCL';
                    GenJournalLine."Document No.":=objTransactions.No;
                    GenJournalLine."External Document No.":=objTransactions."Cheque No";
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No.":=objTransactions."Account No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date":=Today;
                    GenJournalLine.Description:='Cheque Discounting Charge';
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount:=Account."Comission On Cheque Discount";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No.":=GenSetup."Cheque Discounting Fee Account";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine."Shortcut Dimension 2 Code":=objTransactions."Transacting Branch";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;

                    Account."Cheque Discounted":=0;
                    Account."Comission On Cheque Discount" := 0;
                    Account.Modify;
                  end;
              end;
            objTransactions."Cheque Processed":=true;
            objTransactions."Date Cleared":=Today;
            objTransactions.Modify;
            until objTransactions.Next=0;
         end;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name",'CHQCL');
        if GenJournalLine.Find('-') then begin
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco",GenJournalLine);
        end;
    end;


    procedure FnInterestTransfer(VendorNo: Code[100])
    var
        BATCH_TEMPLATE: Code[100];
        BATCH_NAME: Code[100];
        DOCUMENT_NO: Code[100];
        PostingDate: Date;
        AmountToTransfer: Decimal;
        AmountToRollBack: Decimal;
    begin
        objVendor.Reset;
        objVendor.SetRange(objVendor."No.",VendorNo);
        objVendor.SetRange(objVendor."Account Type",'FIXED');
        objVendor.SetRange(objVendor."Fixed Deposit Status",objVendor."fixed deposit status"::Active);
        if objVendor.Find('-') then begin
          Report.Run(51516465,false,false,objVendor);
          end;


        BATCH_TEMPLATE:='PURCHASES';
        BATCH_NAME:='INTCALC-F';
        DOCUMENT_NO:='INT EARNED';
        PostingDate:=Today;
        GenSetup.Get();

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name",BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name",BATCH_NAME);
        GenJournalLine.DeleteAll;


        objFDProcess.Reset;
        objFDProcess.SetRange(objFDProcess."Destination Account",VendorNo);
        objFDProcess.SetFilter(objFDProcess."FD Maturity Date",'<=%1',Today);
        objFDProcess.SetFilter(objFDProcess."Untranfered Interest",'>%1',0);
        objFDProcess.SetFilter(objFDProcess."Fixed Deposit Status",'=%1',objFDProcess."fixed deposit status"::Active);
        if objFDProcess.Find('-') then
        begin
        repeat
          objFDProcess.CalcFields(objFDProcess."Untranfered Interest");
          DOCUMENT_NO:=objFDProcess."Document No.";
          if objFDProcess."FD Maturity Date"<=Today then
          begin
            if objFDProcess."Untranfered Interest" > 0 then
              begin
                if AccountType.Get(objFDProcess."Account Type") then
                begin
                  if AccountType."Fixed Deposit" = true then
                  begin
                    if objFDProcess."FD Maturity Date" <= PostingDate then
                    begin
                      objFDProcess."FD Marked for Closure":=true;
                      Transfer:=true;
                    end
                    else
                      Transfer:=false;
                  end
                  else
                    Transfer:=true;
                  end;
                  if Transfer=true then begin
                  PostingDate:=Today;
                  if objFDProcess."FD Maturity Date"<=Today then begin
                    PostingDate:=objFDProcess."FD Maturity Date";
                    //1-------------------------EARN INTEREST(Reduce Interest Payable)---------------------------------------------------------------------------------
                    LineNo:=LineNo+10000;
                    SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor,objFDProcess."Destination Account",PostingDate,objFDProcess."Untranfered Interest"*-1,'FOSA',objFDProcess."Destination Account",
                    'Interest Earned','',GenJournalLine."account type"::"G/L Account",AccountType."Interest Payable Account");

                   //2-------------------------WITHOLDING TAX-------------------------------------------------------------------------------
                    LineNo:=LineNo+10000;
                    SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor,objFDProcess."Destination Account",PostingDate,objFDProcess."Untranfered Interest"*0.15,'FOSA',objFDProcess."Destination Account",
                    'Witholding Tax on Int','',GenJournalLine."account type"::"G/L Account",GenSetup."WithHolding Tax Account");


                    case objFDProcess."On Term Deposit Maturity" of
                      objFDProcess."on term deposit maturity"::"Pay to Current_ Principle+Interest":
                          begin
                            AmountToTransfer:=(objFDProcess."Untranfered Interest"+objFDProcess."Amount to Transfer")-objFDProcess."Untranfered Interest"*0.15;
                            AmountToRollBack:=0;
                          end;
                      objFDProcess."on term deposit maturity"::"Roll Over Principle Only ":
                          begin
                            AmountToTransfer:=(objFDProcess."Untranfered Interest"+objFDProcess."Amount to Transfer")-objFDProcess."Untranfered Interest"*0.15;
                            AmountToRollBack:=objFDProcess."Amount to Transfer";
                          end;
                      objFDProcess."on term deposit maturity"::"Roll Over Principle+Interest":
                          begin
                            AmountToTransfer:=(objFDProcess."Untranfered Interest"+objFDProcess."Amount to Transfer")-objFDProcess."Untranfered Interest"*0.15;;
                            AmountToRollBack:=(objFDProcess."Untranfered Interest"+objFDProcess."Amount to Transfer")-objFDProcess."Untranfered Interest"*0.15;
                          end;
                    end;


                    if AmountToTransfer > 0 then
                    begin
                      //A.-------------------DEBIT FD A/C---------------------------------------------------------
                      LineNo:=LineNo+10000;
                      SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."transaction type"::" ",
                      GenJournalLine."account type"::Vendor,objFDProcess."Destination Account",PostingDate,AmountToTransfer,'FOSA',objFDProcess."Destination Account",
                      'Transferred to FOSA','');
                      //A.-------------------CREDIT FOSA A/C-------------------------------------------------------
                      LineNo:=LineNo+10000;
                      SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."transaction type"::" ",
                      GenJournalLine."account type"::Vendor,objFDProcess."Savings Account No.",PostingDate,AmountToTransfer*-1,'FOSA',objFDProcess."Destination Account",
                      'Transferred From FD-'+objFDProcess."Document No.",'');
                      //4---------------------UPDATE BUFFER---------------------------------------------------------
                      InterestBuffer.Reset;
                      InterestBuffer.SetRange(InterestBuffer."Account No",objFDProcess."Destination Account");
                      InterestBuffer.SetRange(InterestBuffer."Document No.",objFDProcess."Document No.");
                      if InterestBuffer.Find('-') then
                      InterestBuffer.ModifyAll(InterestBuffer.Transferred,true);
                      objFDProcess."Fixed Deposit Status":=objFDProcess."fixed deposit status"::Matured;
                      objFDProcess."FDR Deposit Status Type":=objFDProcess."fdr deposit status type"::Terminated;
                      objFDProcess.Modify;
                    end;
                    if AmountToRollBack > 0 then
                    begin
                      //A.-------------------DEBIT FOSA A/C---------------------------------------------------------
                      LineNo:=LineNo+10000;
                      SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."transaction type"::" ",
                      GenJournalLine."account type"::Vendor,objFDProcess."Savings Account No.",PostingDate,AmountToRollBack,'FOSA',objFDProcess."Destination Account",
                      'Rollback to FD-'+objFDProcess."Document No.",'');
                      //A.-------------------CREDIT FD A/C-------------------------------------------------------
                      LineNo:=LineNo+10000;
                      SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."transaction type"::" ",
                      GenJournalLine."account type"::Vendor,objFDProcess."Destination Account",PostingDate,AmountToRollBack*-1,'FOSA',objFDProcess."Destination Account",
                      'Rollback From Savings-'+objFDProcess."Document No.",'');
                      FnGenerateNewSavingsTransaction(objFDProcess,AmountToRollBack,PostingDate);
                    end;

                  end;
                end;
              end;
            end;
            FnPostEntry();
          until objFDProcess.Next=0;
        end;
    end;


    procedure FnPostEntries()
    begin
    end;

    local procedure FnGenerateNewSavingsTransaction(ObjFD: Record "FD Processing";RollBackAmount: Decimal;PreviousPostingDate: Date)
    var
        ObjNewFD: Record "FD Processing";
    begin
        ObjNewFD.Init;
        ObjNewFD."Account Category":=ObjFD."Account Category";
        ObjNewFD."Account Type":=ObjFD."Account Type";
        ObjNewFD."Address 2":=ObjFD."Address 2";
        ObjNewFD.Address:=ObjFD.Address;
        ObjNewFD."Savings Account No.":=ObjFD."Savings Account No.";
        ObjNewFD.Validate(ObjNewFD."Savings Account No.");
        ObjNewFD."Application Date":=PreviousPostingDate;
        ObjNewFD."Call Deposit":=ObjFD."Call Deposit";
        ObjNewFD.City:=ObjFD.City;
        ObjNewFD.Contact:=ObjFD.Contact;
        ObjNewFD."Current Account Balance":=ObjFD."Current Account Balance";
        ObjNewFD."Date Posted":=PreviousPostingDate;
        ObjNewFD."Destination Account":=ObjFD."Destination Account";
        ObjNewFD."Don't Transfer to Savings":=ObjNewFD."Don't Transfer to Savings";
        ObjNewFD."E-Mail (Personal)":=ObjFD."E-Mail (Personal)";
        ObjNewFD."Employer Code":=ObjFD."Employer Code";
        ObjNewFD."FD Duration":=ObjFD."FD Duration";
        ObjNewFD."FDR Deposit Status Type":=ObjNewFD."fdr deposit status type"::Running;
        ObjNewFD."Fixed Deposit Nos":=ObjFD."Fixed Deposit Nos";
        ObjNewFD."Fixed Deposit Start Date":=Today;
        ObjNewFD."Fixed Deposit Status":=ObjNewFD."fixed deposit status"::Active;
        ObjNewFD."Fixed Deposit Type":=ObjFD."Fixed Deposit Type";
        ObjNewFD."Fixed Duration":=ObjFD."Fixed Duration";
        ObjNewFD."Interest rate":=ObjFD."Interest rate";
        ObjNewFD."Amount to Transfer":=RollBackAmount;
        ObjNewFD.Validate(ObjNewFD."Amount to Transfer");
        ObjNewFD.Validate(ObjNewFD."Fixed Duration");
        ObjNewFD.Validate(ObjNewFD."FD Duration");
        ObjNewFD."Global Dimension 1 Code":=ObjFD."Global Dimension 1 Code";
        ObjNewFD."Name 2":=ObjFD."Name 2";
        ObjNewFD."Neg. Interest Rate":=ObjFD."Neg. Interest Rate";
        ObjNewFD."On Term Deposit Maturity":=ObjNewFD."On Term Deposit Maturity";
        ObjNewFD."Phone No.":=ObjFD."Phone No.";
        ObjNewFD.Posted:=true;
        ObjNewFD."Prevous Expected Int On FD":=ObjFD."Expected Interest On Term Dep";
        ObjNewFD."Prevous FD Deposit Status Type":=ObjFD."Prevous FD Deposit Status Type";
        ObjNewFD."Prevous FD Start Date":=ObjFD."Fixed Deposit Start Date";
        ObjNewFD."Prevous Fixed Duration":=ObjFD."Fixed Duration";
        ObjNewFD."Prevous Interest Rate FD":=ObjFD."Interest rate";
        ObjNewFD."Search Name":=ObjFD."Search Name";
        ObjNewFD.Signature:=ObjFD.Signature;
        ObjNewFD."S-Mobile No":=ObjFD."S-Mobile No";
        ObjNewFD.Status:=ObjFD.Status;
        ObjNewFD."Transfer Amount to Savings":=ObjFD."Transfer Amount to Savings"; //TODO
        ObjNewFD."User ID":=UserId;
        ObjNewFD.Insert(true);
    end;


    procedure FnPostEntry()
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name",'INTCALC-F');
        if GenJournalLine.Find('-') then begin
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch",GenJournalLine);
        end;
    end;


    procedure FnAdhoc()
    begin
        Cust.Reset;
        Cust.SetRange(Cust."Global Dimension 1 Code",'BOSA');
        if Cust.Find('-') then begin
          repeat
            Report.Run(51516419,false,false,Cust); //DORMANCY

            Loans.Reset;
            Loans.SetRange(Loans."BOSA No",Cust."No.");
            Loans.SetRange(Loans.Posted,true);
            if Loans.Find('-') then begin
              repeat
                Report.Run(51516234,false,false,Loans); //LOAN AGEING
                Report.Run(51516456,false,false,Loans); //RELEASE COLLATERAL
              until Loans.Next = 0;
            end;

            objVendor.Reset;
            objVendor.SetRange(objVendor."BOSA Account No",Cust."No.");
            if objVendor.Find('-') then
              begin
                Report.Run(51516460,false,false,objVendor);
                end;
          until Cust.Next = 0;
        end;
    end;
}

