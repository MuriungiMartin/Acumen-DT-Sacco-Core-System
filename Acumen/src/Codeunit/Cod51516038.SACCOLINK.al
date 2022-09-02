#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516038 "SACCOLINK"
{
    // GetChargesTotalAmount(TransType : Code[20];Amnt : Decimal;RecSource : 'ATM,POS,VISA,BRANCH') : Decimal


    trigger OnRun()
    begin

        //MESSAGE(FORMAT( GetMemberStatus('4299337600182891')));
        //MESSAGE(GetATMlinkedAccount('4299337600182891'));
        //MESSAGE(FORMAT( GetBookBalance('4299337600182891')));
        //MESSAGE(FORMAT( GetAccountBalance('4299337600182891')));
        //MESSAGE(GetMnstatement('4299337600182891',10));
        //MESSAGE(FORMAT(GetChargesTotalAmount('16',0,1)));
        //MESSAGE('CHARGES : '+FORMAT(GetTotalCharges('POSMR','0014',0)));
        //MESSAGE(GetATMlinkedAccount('4299337600182891'));

        Message(ProcessTransactions(1));
    end;

    var
        StringList: Text[1024];
        SA: Record Vendor;
        SavLedger: Record "Vendor Ledger Entry";
        ProdType: Record "Account Types-Saving Products";
        ATMTransList: Record ATMTransCompleted;
        ATMCharges: Record "ATM Charges";
        ATMPOS: Record "POS Commissions";
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LineNo: Integer;
        GenBatches: Record "Gen. Journal Batch";
        SaccoCharge: Decimal;
        BankCharge: Decimal;
        BankGL: Code[20];
        SaccoGL: Code[20];
        GenSetup: Record "Sacco General Set-Up";
        TotCharge: Decimal;
        ATMCompleted: Record ATMTransCompleted;
        ATMPost: Boolean;
        ATMSetUp: Record UnknownRecord51516074;


    procedure GetATMlinkedAccount(CardNumber: Code[20]): Code[20]
    var
        SA: Record Vendor;
        AccNo: Code[20];
    begin

          AccNo:='';
          SA.Reset;
          SA.SetRange("ATM No.",CardNumber);
          if SA.Find('-') then AccNo:=SA."No.";

          exit(AccNo);
    end;


    procedure CheckMessageIdExists(CardNumber: Code[20];MessageID: Text[100]): Boolean
    var
        SA: Record Vendor;
        Found: Boolean;
    begin
          Found:=false;

          SA.Reset;
          SA.SetRange("ATM No.",CardNumber);
          if SA.Find('-') then begin
            ATMTransList.Reset;
            ATMTransList.SetRange(ATMTransList.PostingDebitAccount,CardNumber);
            ATMTransList.SetRange(ATMTransList.SavingsAccountNumber,SA."No.");
            ATMTransList.SetRange(ATMTransList.messageID,MessageID);
            if ATMTransList.Find('-') then Found:=true;
          end;

          exit(Found);
    end;


    procedure GetMember(CardNumber: Code[20]): Text
    var
        SA: Record Vendor;
        AccNo: Text;
    begin
          SA.Reset;
          SA.SetRange("ATM No.",CardNumber);
          if SA.Find('-') then
            AccNo:=SA."No.";

          exit(AccNo);
    end;


    procedure GetMembername(CardNumber: Code[20]): Text
    var
        SA: Record Vendor;
        AccName: Text;
    begin
          SA.Reset;
          SA.SetRange("ATM No.",CardNumber);
          if SA.Find('-') then
            AccName:=SA.Name;

          exit(AccName);
    end;


    procedure GetMemberStatus(CardNumber: Code[20]): Integer
    var
        SA: Record Vendor;
        AStatus: Option " ","Non-Active",Active,Dormant,Blocked,"Withdrawal Application",Withdrawal,Deceased,Defaulter,Closed;
        TxSt: Integer;
    begin
        
          //Active,Frozen,Closed,Archived,New,Dormant,Deceased,Retired
          AStatus:= Astatus::Closed;// AStatus::" ";
          SA.Reset;
          SA.SetRange("ATM No.",CardNumber);
          if not SA.Find('-') then  begin
            TxSt:=0;
          end else begin
            if SA.Status = SA.Status::Active then TxSt:=1 else TxSt:=2; /*anything other than 1 is invalid*/
        //     IF SA.Status = SA.Status::Active THEN TxSt:=1 ELSE
        //     IF SA.Status = SA.Status::Blocked THEN TxSt:=2 ELSE
        //     IF SA.Status = SA.Status::Closed THEN TxSt:=3 ELSE
        //     IF SA.Status = SA.Status::Deceased THEN TxSt:=4 ELSE
        //     IF SA.Status = SA.Status::Defaulter THEN TxSt:=5 ELSE
        //     IF SA.Status = SA.Status::Dormant THEN TxSt:=6 ELSE
        //     IF SA.Status = SA.Status::"Non-Active" THEN TxSt:=7 ELSE {not active or not found}
          end;
        
        
          exit(TxSt);

    end;


    procedure GetChargesTotalAmount(TransType: Code[20];Amnt: Decimal;RecSource: Option ATM,POS,VISA,BRANCH,MERCHANT): Decimal
    var
        SA: Record Vendor;
        saccoCharge: Decimal;
        bankCharge: Decimal;
        vendorCharge: Decimal;
        totalCharge: Decimal;
        intTransType: Integer;
    begin

          totalCharge:=0;
          saccoCharge:=0;
          bankCharge:=0;

          GenSetup.Get;

          Evaluate(intTransType,TransType);

          ATMCharges.Reset;
          ATMCharges.SetRange(ATMCharges."Transaction Type",intTransType);
          ATMCharges.SetRange(Source,RecSource);
          if ATMCharges.Find('-') then begin
            Message(Format(ATMCharges."Transaction Type"));
            if ATMCharges."Transaction Type" <> ATMCharges."transaction type"::"POS - Cash Deposit" then begin
              saccoCharge:=ATMCharges."Sacco Amount";
              bankCharge:=ATMCharges."Bank Amount";//."Atm Income A/c";

              totalCharge:=(saccoCharge+bankCharge);
            end else begin

              ATMPOS.Reset;
              if ATMPOS.Find('-') then begin
                repeat
                  if (Amnt >= ATMPOS."Lower Limit") and (Amnt <= ATMPOS."Upper Limit") then begin
                    saccoCharge:=ATMPOS."Sacco charge";
                    bankCharge:=ATMPOS."Bank charge";

                    totalCharge:=(saccoCharge+bankCharge);
                  end;
                until ATMPOS.Next = 0;
              end;
            end;
          end;

          exit(totalCharge);
    end;


    procedure GetTotalCharges(transChannel: Text[30];transTypeCode: Text[30];transAmount: Decimal) transTotalCharge: Decimal
    var
        SA: Record Vendor;
        saccoCharge: Decimal;
        bankCharge: Decimal;
        vendorCharge: Decimal;
        intTransType: Integer;
        SaccoLinkChargesTable: Record SaccoLinkCharges;
    begin

          transTotalCharge:=0;

          SaccoLinkChargesTable.Reset;
          SaccoLinkChargesTable.SetRange(SaccoLinkChargesTable.Channel,transChannel); // **
          SaccoLinkChargesTable.SetRange(SaccoLinkChargesTable.TransactionTypeCode,transTypeCode);
          SaccoLinkChargesTable.SetFilter(SaccoLinkChargesTable.MinAmount,'<=%1',transAmount) ;
          SaccoLinkChargesTable.SetFilter(SaccoLinkChargesTable.MaxAmount,'>=%1',transAmount) ;
          if SaccoLinkChargesTable.Find('-') then begin
            //MESSAGE('OK OK ' +FORMAT(SaccoLinkChargesTable.TotalCharges));
            transTotalCharge:=SaccoLinkChargesTable.TotalCharges;
          end;
    end;


    procedure GetBookBalance(CardNumber: Code[20]): Decimal
    var
        SA: Record Vendor;
        MinBalance: Decimal;
        AvailableBalance: Decimal;
        BookBalance: Decimal;
    begin
          MinBalance:=0;
          BookBalance:=0;

          SA.Reset;
          SA.SetRange("ATM No.",CardNumber);
          if SA.Find('-') then begin
            SA.CalcFields(SA."Balance (LCY)",SA."Uncleared Cheques",SA."ATM Transactions",SA."Member class");
            ProdType.Reset;
            ProdType.SetRange(ProdType.Code,SA."Account Type");
            if ProdType.Find('-') then begin
              MinBalance:=ProdType."Minimum Balance";
              BookBalance:=(SA."Balance (LCY)"+0);
            end;
          end;

          exit(BookBalance);
    end;


    procedure GetAccountBalance(CardNumber: Code[20]): Decimal
    var
        SA: Record Vendor;
        MinBalance: Decimal;
        AvailableBalance: Decimal;
        BookBalance: Decimal;
    begin
          MinBalance:=0;
          AvailableBalance:=0;

          SA.Reset;
          SA.SetRange("ATM No.",CardNumber);
          if SA.Find('-') then begin
            SA.CalcFields(SA."Balance (LCY)",SA.Balance,SA."Uncleared Cheques",SA."ATM Transactions",SA."Member class");
            ProdType.Reset;
            ProdType.SetRange(ProdType.Code,SA."Account Type");
            if ProdType.Find('-') then begin
              MinBalance:=ProdType."Minimum Balance";
              //MESSAGE('bal ' +FORMAT(SA.Balance)+'   bal LCY ' +FORMAT(SA."Balance (LCY)")+ ' uncleared '+format(SA."Uncleared Cheques"));
              AvailableBalance:=(SA."Balance (LCY)"+0) - (MinBalance+SA."Uncleared Cheques"+0+SA."ATM Transactions"+SA."Member class");
            end;
          end;

          exit(AvailableBalance);
    end;


    procedure GetMnstatement(CardNumber: Code[20];NoofEntries: Integer): Text
    var
        SA: Record Vendor;
        SavLedger: Record "Vendor Ledger Entry";
    begin
          StringList:='';

          SA.Reset;
          SA.SetRange("ATM No.",CardNumber);
          if SA.Find('-') then begin
            SavLedger.Reset;
            SavLedger.SetRange("Vendor No.",SA."No.");
            SavLedger.SetCurrentkey("Entry No.");
            SavLedger.SetAscending("Entry No.",false);
            if SavLedger.FindFirst then begin
              repeat
                if NoofEntries>0 then begin
                  StringList:=StringList+Format(SavLedger."Document No.")
                                  +'|'+Format(SavLedger."Posting Date")
                                  +'|'+SavLedger.Description
                                  +'|'+Format(ROUND(SavLedger.Amount,1))
                                  +'|'+SavLedger."Vendor No."+';';
                  NoofEntries:=NoofEntries-1;
                end;
              until SavLedger.Next=0
            end;
          end;

          exit(StringList);
    end;


    procedure PostTransactions(ServName: Text;MessID: Text[100];OPTransDate: DateTime;OPTermID: Text;OPChan: Text[30];OPTransType: Text;OPOrigMess: Text[100];CardNumber: Code[20];Amnt: Decimal;Currency: Text;PostNar: Text;PostNar1: Text;PostNar2: Text;InstitCode: Text;InstitName: Text;RecSource: Option ATM,POS,VISA,BRANCH,MERCHANT;FieldLocation: Text[120];TransactionDescription: Text[120]): Boolean
    var
        intTransType: Integer;
        atmSettlementAccount: Code[30];
        visaSettlementAccount: Code[30];
        saccoRevenueAccount: Code[30];
        bankRevenueAccount: Code[30];
    begin
        
          SA.Reset;
          SA.SetRange("ATM No.",CardNumber);
          if SA.Find('-') then begin
            // **************************
        
        //     IF ((ServName='MINISTATEMENT') AND (OPChan='POS')) THEN  OPTransType:= '16';
        //     IF ((ServName='BALANCE') AND (OPChan='POS')) THEN  OPTransType:= '15';
        
        //     //FOR NON POSTING
        //     ATMCharges.RESET;
        //     ATMCharges.SETRANGE(ATMCharges."Transaction Type",intTransType);// OPTransType);
        //     ATMCharges.SETRANGE(ATMCharges.Source,RecSource);
        //     ATMCharges.SETFILTER(ATMCharges."Transaction Type",'=%1|=%2|=%3|=%4|=%5|=%6',
        //                       ATMCharges."Transaction Type"::"Balance Enquiry",
        //                       ATMCharges."Transaction Type"::"Mini Statement",
        //                       ATMCharges."Transaction Type"::"Utility Payment",
        //                       ATMCharges."Transaction Type"::"POS - Normal Purchase",
        //                       ATMCharges."Transaction Type"::"Airtime Purchase",
        //                       ATMCharges."Transaction Type"::"POS - M Banking");
        //     IF ATMCharges.FIND('-') THEN
        //       ATMPost:=TRUE;
        
            //FOR NON POSTING
            ATMCompleted.Init;
            ATMCompleted.serviceName:=ServName;
            ATMCompleted.messageID:=MessID;
            ATMCompleted.DocumentNumber:=CopyStr(MessID,1,12); // ** first 12 xters are unique to every transaction
            ATMCompleted.OPTransactionDate:=Dt2Date(OPTransDate);
            ATMCompleted.OPTerminalID:=OPTermID;
            ATMCompleted.OPChannel:=OPChan;
            ATMCompleted.OPTransactionType:=OPTransType;
            ATMCompleted.OPOriginalMessageID:=OPOrigMess;
            ATMCompleted.PostingDebitAccount:=CardNumber;
            ATMCompleted.PostingTotalAmount:=Amnt;
            ATMCompleted.Amount:=Amnt;
            ATMCompleted.PostingChargeAmount:=TotCharge;
            ATMCompleted.PostingCurrency:=Currency;
            ATMCompleted.PostingChargeCurrency:=Currency;
            ATMCompleted.PostingNarrative:=PostNar;
            ATMCompleted.PostingNarrative1:=PostNar1;
            ATMCompleted.PostingNarrative2:=PostNar2;
            ATMCompleted.InstitutionInstitutionCode:=InstitCode;
            ATMCompleted.InstitutionInstitutionName:=InstitName;
            ATMCompleted.SavingsAccountNumber:=SA."No.";
            ATMCompleted.RecSource:=RecSource;
            if ATMPost = true then
              ATMCompleted.PostedStatus:=ATMCompleted.Postedstatus::"1"
            else
              ATMCompleted.PostedStatus:=ATMCompleted.Postedstatus::"2";
            ATMCompleted."Field Location":=FieldLocation;
            ATMCompleted.TransactionDescription:=TransactionDescription;
            ATMCompleted.Insert;
        
        //EXIT(ATMpost);
        exit(true);
        
        
        
        
            // **********************
        
        
        
            //delete journal line
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name",'GENERAL');
            GenJournalLine.SetRange("Journal Batch Name",'ATMTRANS');
            GenJournalLine.DeleteAll;
            //end of deletion
        
            GenBatches.Reset;
            GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
            GenBatches.SetRange(GenBatches.Name,'ATMTRANS');
            if GenBatches.Find('-') = false then begin
              GenBatches.Init;
              GenBatches."Journal Template Name":='GENERAL';
              GenBatches.Name:='ATMTRANS';
              GenBatches.Description:='ATM Transactions';
              GenBatches.Validate(GenBatches."Journal Template Name");
              GenBatches.Validate(GenBatches.Name);
              GenBatches.Insert;
            end;
        
            ATMSetUp.Reset;
            ATMSetUp.SetRange(ATMSetUp.ID,1);
        
        
            Evaluate(intTransType,OPTransType);
        
            //Fosa Account
            LineNo:=LineNo+10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name":='GENERAL';
            GenJournalLine."Journal Batch Name":='ATMTRANS';
            GenJournalLine."Line No.":=LineNo;
            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No.":=SA."No.";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Document No.":=MessID;
            GenJournalLine."Posting Date":=Today;
        
            ATMCharges.Reset;
            ATMCharges.SetRange(ATMCharges."Transaction Type",intTransType);// OPTransType);
            ATMCharges.SetRange(Source,RecSource);
            if ATMCharges.Find('-') then begin
        //       atmSettlementAccount:=ATMCharges."Atm Bank Settlement A/C";
        //       saccoRevenueAccount:=ATMCharges."Atm Income A/c";
        //       bankRevenueAccount:=ATMCharges."Bank Commission A/C";
        
              GenJournalLine.Description:=Format(ATMCharges."Transaction Type")+'('+(Format(ATMCharges.Source))+')';
        
              if (ATMCharges."Transaction Type" = ATMCharges."transaction type"::"Utility Payment") then
                GenJournalLine.Amount:=-Amnt
              else
                GenJournalLine.Amount:=Amnt;
        
            end;
        
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code":=SA."Global Dimension 1 Code";
            GenJournalLine."Shortcut Dimension 2 Code":=SA."Global Dimension 2 Code";
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount<>0 then
            GenJournalLine.Insert;
        
        
        
            //Bank Account
            LineNo:=LineNo+10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name":='GENERAL';
            GenJournalLine."Journal Batch Name":='ATMTRANS';
            GenJournalLine."Line No.":=LineNo;
            GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No.":=ATMSetUp."ATM Bank";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Document No.":=MessID;
            GenJournalLine."Posting Date":=Today;
        
            ATMCharges.Reset;
            ATMCharges.SetRange(ATMCharges."Transaction Type",intTransType);// OPTransType);
            ATMCharges.SetRange(Source,RecSource);
            if ATMCharges.Find('-') then begin
              GenJournalLine.Description:=Format(ATMCharges."Transaction Type")+'-'+CardNumber+'('+(Format(ATMCharges.Source))+')';
              if (ATMCharges."Transaction Type" = ATMCharges."transaction type"::"Utility Payment") then
                GenJournalLine.Amount:=Amnt
              else
                GenJournalLine.Amount:=-Amnt;
            end;
        
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code":=SA."Global Dimension 1 Code";
            GenJournalLine."Shortcut Dimension 2 Code":=SA."Global Dimension 2 Code";
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount<>0 then
            GenJournalLine.Insert;
        
            //CHARGES
            TotCharge:=0;
            SaccoCharge:=0;
            BankCharge:=0;
        
            BankGL:=ATMSetUp.BankChargeAccount;
            SaccoGL:=ATMSetUp.SaccoChargeAccount;
        
            GenSetup.Get;
        
            ATMCharges.Reset;
            ATMCharges.SetRange(ATMCharges."Transaction Type",intTransType);// OPTransType);
            ATMCharges.SetRange(ATMCharges.Source,RecSource);
            //  ATMCharges.SETFILTER(ATMCharges."Transaction Type",'<>%1|<>%2|<>%3|<>%4|<>%5|<>%6',
            //                        ATMCharges."Transaction Type"::"Balance Enquiry",ATMCharges."Transaction Type"::Ministatement,ATMCharges."Transaction Type"::Reversal,
            //                        ATMCharges."Transaction Type"::"POS - Purchase With Cash Back",ATMCharges."Transaction Type"::"POS - Cash Deposit",
            //                        ATMCharges."Transaction Type"::"VISA Balance Inquiry");
            if ATMCharges.Find('-') then begin
        
              if ATMCharges."Transaction Type" <> ATMCharges."transaction type"::"POS - Cash Deposit" then begin
                SaccoCharge:=ATMCharges."Sacco Amount";
                BankCharge:=ATMCharges."Bank Amount";//."Atm Income A/c";
        
                TotCharge:=(SaccoCharge+BankCharge+0);//+((ATMCharges."Total Amount")*GenSetup."Excise Duty (%)"/100);
        
              end else begin
        
                ATMPOS.Reset;
                if ATMPOS.Find('-') then begin
                  repeat
                    if (Amnt >= ATMPOS."Lower Limit") and (Amnt <= ATMPOS."Upper Limit") then begin
                      SaccoCharge:=ATMPOS."Sacco charge";
                      BankCharge:=ATMPOS."Bank charge";
        
                      TotCharge:=(SaccoCharge+BankCharge+0);//+((ATMCharges."Total Amount")*GenSetup."Excise Duty (%)"/100);
                    end;
                  until ATMPOS.Next = 0;
                end;
              end;
        
              //Sacco Charge
              LineNo:=LineNo+10000;
              GenJournalLine.Init;
              GenJournalLine."Journal Template Name":='GENERAL';
              GenJournalLine."Journal Batch Name":='ATMTRANS';
              GenJournalLine."Line No.":=LineNo;
              GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
              GenJournalLine."Account No.":=SaccoGL;
              GenJournalLine.Validate(GenJournalLine."Account No.");
              GenJournalLine."Document No.":=MessID;
              GenJournalLine."Posting Date":=Today;
              GenJournalLine.Description:=Format(ATMCharges."Transaction Type")+'-Charges('+(Format(ATMCharges.Source))+')';
              GenJournalLine.Amount:=-SaccoCharge;
              GenJournalLine.Validate(GenJournalLine.Amount);
              GenJournalLine."Shortcut Dimension 1 Code":=SA."Global Dimension 1 Code";
              GenJournalLine."Shortcut Dimension 2 Code":=SA."Global Dimension 2 Code";
              GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
              GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
              if GenJournalLine.Amount<>0 then
                GenJournalLine.Insert;
        
              //Bank Charge
              LineNo:=LineNo+10000;
              GenJournalLine.Init;
              GenJournalLine."Journal Template Name":='GENERAL';
              GenJournalLine."Journal Batch Name":='ATMTRANS';
              GenJournalLine."Line No.":=LineNo;
              GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
              GenJournalLine."Account No.":=BankGL;
              GenJournalLine.Validate(GenJournalLine."Account No.");
              GenJournalLine."Document No.":=MessID;
              GenJournalLine."Posting Date":=Today;
              GenJournalLine.Description:=Format(ATMCharges."Transaction Type")+'-Charges('+(Format(ATMCharges.Source))+')';
              GenJournalLine.Amount:=-BankCharge;
              GenJournalLine.Validate(GenJournalLine.Amount);
              GenJournalLine."Shortcut Dimension 1 Code":=SA."Global Dimension 1 Code";
              GenJournalLine."Shortcut Dimension 2 Code":=SA."Global Dimension 2 Code";
              GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
              GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
              if GenJournalLine.Amount<>0 then
                GenJournalLine.Insert;
        
              //vendor Charge
              /*
              LineNo:=LineNo+10000;
              GenJournalLine.INIT;
              GenJournalLine."Journal Template Name":='GENERAL';
              GenJournalLine."Journal Batch Name":='ATMTRANS';
              GenJournalLine."Line No.":=LineNo;
              GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
              GenJournalLine."Account No.":=vendorGL;
              GenJournalLine.VALIDATE(GenJournalLine."Account No.");
              GenJournalLine."Document No.":=MessID;
              GenJournalLine."Posting Date":=TODAY;
              GenJournalLine.Description:=FORMAT(ATMCharges."Transaction Type")+'-Charges('+(FORMAT(ATMCharges.Source))+')';
              GenJournalLine.Amount:=-vendorCharge;
              GenJournalLine.VALIDATE(GenJournalLine.Amount);
              GenJournalLine."Shortcut Dimension 1 Code":=SA."Global Dimension 1 Code";
              GenJournalLine."Shortcut Dimension 2 Code":=SA."Global Dimension 2 Code";
              GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
              GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
              IF GenJournalLine.Amount<>0 THEN
                GenJournalLine.INSERT;
              */
        
              /*
              //Excise
              LineNo:=LineNo+10000;
              GenJournalLine.INIT;
              GenJournalLine."Journal Template Name":='GENERAL';
              GenJournalLine."Journal Batch Name":='ATMTRANS';
              GenJournalLine."Line No.":=LineNo;
              GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
              GenJournalLine."Account No.":=GenSetup."Excise Duty G/L";
              GenJournalLine.VALIDATE(GenJournalLine."Account No.");
              GenJournalLine."Document No.":=MessID;
              GenJournalLine."External Document No.":=SA."No.";
              GenJournalLine."Posting Date":=TODAY;
              GenJournalLine.Description:=SA."ATM No."+'-Excise Duty';
              GenJournalLine.Amount:=-(ATMCharges."Total Amount")*(GenSetup."Excise Duty (%)"/100);
              GenJournalLine.VALIDATE(GenJournalLine.Amount);
              GenJournalLine."Shortcut Dimension 1 Code":=SA."Global Dimension 1 Code";
              GenJournalLine."Shortcut Dimension 2 Code":=SA."Global Dimension 2 Code";
              GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
              GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
              IF GenJournalLine.Amount<>0 THEN
                GenJournalLine.INSERT;
              */
        
              //Charges Balance
              LineNo:=LineNo+10000;
              GenJournalLine.Init;
              GenJournalLine."Journal Template Name":='GENERAL';
              GenJournalLine."Journal Batch Name":='ATMTRANS';
              GenJournalLine."Line No.":=LineNo;
              GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
              GenJournalLine."Account No.":=SA."No.";
              GenJournalLine.Validate(GenJournalLine."Account No.");
              GenJournalLine."Document No.":=MessID;
              GenJournalLine."Posting Date":=Today;
              GenJournalLine.Description:='ATM Charges';
              GenJournalLine.Amount:=TotCharge;
              GenJournalLine.Validate(GenJournalLine.Amount);
              GenJournalLine."Shortcut Dimension 1 Code":=SA."Global Dimension 1 Code";
              GenJournalLine."Shortcut Dimension 2 Code":=SA."Global Dimension 2 Code";
              GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
              GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
              if GenJournalLine.Amount<>0 then
                GenJournalLine.Insert;
            end;
        
            //Post - start
            ATMPost:=false;
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name",'GENERAL');
            GenJournalLine.SetRange("Journal Batch Name",'ATMTRANS');
            if GenJournalLine.Find('-') then begin
              Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch",GenJournalLine);
              ATMPost:=true;
              //GLPosting.RUN(GenJournalLine);
            end;
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name",'GENERAL');
            GenJournalLine.SetRange("Journal Batch Name",'ATMTRANS');
            GenJournalLine.DeleteAll;
            //Post - end
        
            //FOR NON POSTING
            ATMCharges.Reset;
            ATMCharges.SetRange(ATMCharges."Transaction Type",intTransType);// OPTransType);
            ATMCharges.SetRange(ATMCharges.Source,RecSource);
            ATMCharges.SetFilter(ATMCharges."Transaction Type",'=%1|=%2|=%3|=%4|=%5|=%6',
                              ATMCharges."transaction type"::"Balance Enquiry",
                              ATMCharges."transaction type"::"Mini Statement",
                              ATMCharges."transaction type"::"Utility Payment",
                              ATMCharges."transaction type"::"POS - Normal Purchase",
                              ATMCharges."transaction type"::"Airtime Purchase",
                              ATMCharges."transaction type"::"POS - M Banking");
            if ATMCharges.Find('-') then
              ATMPost:=true;
        
            //FOR NON POSTING
            ATMCompleted.Init;
            ATMCompleted.serviceName:=ServName;
            ATMCompleted.messageID:=MessID;
            ATMCompleted.OPTransactionDate:=Dt2Date(OPTransDate);
            ATMCompleted.OPTerminalID:=OPTermID;
            ATMCompleted.OPChannel:=OPChan;
            ATMCompleted.OPTransactionType:=OPTransType;
            ATMCompleted.OPOriginalMessageID:=OPOrigMess;
            ATMCompleted.PostingDebitAccount:=CardNumber;
            ATMCompleted.PostingTotalAmount:=Amnt;
            ATMCompleted.PostingChargeAmount:=TotCharge;
            ATMCompleted.PostingCurrency:=Currency;
            ATMCompleted.PostingChargeCurrency:=Currency;
            ATMCompleted.PostingNarrative:=PostNar;
            ATMCompleted.PostingNarrative1:=PostNar1;
            ATMCompleted.PostingNarrative2:=PostNar2;
            ATMCompleted.InstitutionInstitutionCode:=InstitCode;
            ATMCompleted.InstitutionInstitutionName:=InstitName;
            ATMCompleted.SavingsAccountNumber:=SA."No.";
            ATMCompleted.RecSource:=RecSource;
            if ATMPost = true then
              ATMCompleted.PostedStatus:=ATMCompleted.Postedstatus::"1"
            else
              ATMCompleted.PostedStatus:=ATMCompleted.Postedstatus::"2";
            ATMCompleted."Field Location":=FieldLocation;
            ATMCompleted.Insert;
        
          end;
        
          exit(ATMPost)

    end;


    procedure ProcessTransactions(intEntries: Integer) results: Text
    var
        cnt: Integer;
        atmSettlementAccount: Code[30];
        visaSettlementAccount: Code[30];
        saccoRevenueAccount: Code[30];
        bankRevenueAccount: Code[30];
    begin


          // ***************************************************************************************** //
          if intEntries=0 then intEntries:=3;

          results:='NOTRANSACTION';
          ATMCompleted.Reset;
          ATMCompleted.SetRange(ATMCompleted.Status,ATMCompleted.Status::Pending);
          ATMCompleted.SetRange(ATMCompleted.Id,8);
          if ATMCompleted.Find('-') then begin

            results :='';
            cnt:=0;
            repeat
              //results :=results+';'+ PostTransactionItem(ATMCompleted.Id,ATMCompleted.DocumentNumber);
              results :=results+';'+ PostTransaction(ATMCompleted.Id,ATMCompleted.DocumentNumber);
              cnt+=1;
            until (cnt=intEntries) or (ATMCompleted.Next=0);
          end;
    end;


    procedure PostTransactionItem(idx: Integer;documentNum: Text[20]) result: Text
    var
        transactionAmount: Decimal;
        transactionDescription: Text[50];
        isReversal: Boolean;
        reverseMessID: Text[50];
        optrantype: Text[30];
        thisOptrantype: Text[30];
        opchannel: Text[30];
        thisOpchannel: Text[30];
        atmSettlementAccount: Code[30];
        visaSettlementAccount: Code[30];
        thisSettlementAccount: Code[30];
        saccoRevenueAccount: Code[30];
        bankRevenueAccount: Code[30];
        totalChargesDueAmount: Decimal;
        saccoRevenueAmount: Decimal;
        bankRevenueAmount: Decimal;
        bankTotalRevenueAmount: Decimal;
        saccoExciseDutyAmount: Decimal;
        bankExciseDutyAmount: Decimal;
        AtmTransCompletedTable: Record ATMTransCompleted;
        AtmTransCompletedReversalTable: Record ATMTransCompleted;
        AtmSetupTable: Record "ATM SETUP";
        SaccolinkChargesTable: Record SaccoLinkCharges;
    begin

          // ***************************************************************************************** //

          result:='FAIL';

          AtmTransCompletedTable.Reset;
          //AtmTransCompletedTable.SETRANGE(AtmTransCompletedTable.Status,AtmTransCompletedTable.Status::Pending);
          AtmTransCompletedTable.SetRange(AtmTransCompletedTable.Id,idx );
          //AtmTransCompletedTable.SETRANGE(AtmTransCompletedTable.messageID,messID);
          AtmTransCompletedTable.SetRange(AtmTransCompletedTable.DocumentNumber,documentNum);
          if AtmTransCompletedTable.Find('-') then  begin

            isReversal:=false;
            // -- initialize the transaction amount, charges and accounts
            transactionAmount:=0;
            transactionDescription:='';
            atmSettlementAccount:='';
            visaSettlementAccount:='';
            saccoRevenueAccount:='';
            bankRevenueAccount:='';

            totalChargesDueAmount:=0;
            saccoRevenueAmount:=0;
            bankRevenueAmount:=0;
            bankTotalRevenueAmount:=0;
            saccoExciseDutyAmount:=0;
            bankExciseDutyAmount:=0;

            // -- get the atm accounts
            AtmSetupTable.Reset;
            AtmSetupTable.SetRange(AtmSetupTable.ID,1); // -- using GET was throwing an error
            if not AtmSetupTable.Find('-') then begin
              result:='MISSINGSETUPS';
              exit;

            end else begin

              atmSettlementAccount:=AtmSetupTable.AtmSettlementAccount;
              thisSettlementAccount:=atmSettlementAccount; // -- this is the default settlement account
              visaSettlementAccount:=AtmSetupTable.VisaSettlementAccount;
              saccoRevenueAccount:=AtmSetupTable.SaccoChargeAccount;
              bankRevenueAccount:=AtmSetupTable.BankChargeAccount;

              totalChargesDueAmount:=0;
              saccoExciseDutyAmount:=0;
              bankExciseDutyAmount:=0;

              thisOptrantype:=AtmTransCompletedTable.OPTransactionType;
              opchannel:=AtmTransCompletedTable.OPChannel;
              transactionAmount:=AtmTransCompletedTable.PostingTotalAmount;



              case AtmTransCompletedTable.RecSource of
                AtmTransCompletedTable.Recsource::ATM:
                    begin
                      thisOpchannel:='ATM';
                    end;
                AtmTransCompletedTable.Recsource::VISA:
                    begin
                      thisOpchannel:='VISA';
                    end;
                AtmTransCompletedTable.Recsource::POS:
                    begin
                      thisOpchannel:='POS';
                    end;
                AtmTransCompletedTable.Recsource::BRANCH:
                    begin
                      thisOpchannel:='POSBR';//'BRANCH';
                    end;
                AtmTransCompletedTable.Recsource::MERCHANT:
                    begin
                      thisOpchannel:='POSMR';//'MERCHANT';
                    end;
              end;

        // --- if is reversal ----------
              if thisOptrantype='1420' then begin
                AtmTransCompletedReversalTable.Reset;
                AtmTransCompletedReversalTable.SetRange(AtmTransCompletedReversalTable.messageID,AtmTransCompletedTable.OPOriginalMessageID);
                if not AtmTransCompletedReversalTable.Find('-') then begin
                  // -- transaction not found - do not proceed
                  AtmTransCompletedTable.Status:=AtmTransCompletedTable.Status::Failed;
                  result:='REVERSEIDNOTFOUND-'+AtmTransCompletedTable.OPOriginalMessageID;
                  exit;
                end else begin
                  isReversal:=true;
                  transactionAmount:=AtmTransCompletedReversalTable.PostingTotalAmount;
                  optrantype:=AtmTransCompletedReversalTable.OPTransactionType;
                end;
              end;
        // --- end if is reversal ------


        // MESSAGE ('opchannel- ' +opchannel+' thisOpchannel- '+thisOpchannel
        // +' ; optranstype -' +optrantype
        // +' ; thisoptranstype -' +thisOptrantype
        // );

              // -- get this transaction charges
              SaccolinkChargesTable.Reset;
              //SaccolinkChargesTable.SETRANGE(SaccolinkChargesTable.Channel, thisOpchannel); // ** it seems not relevant

              if AtmTransCompletedTable.serviceName='FT' then begin
                SaccolinkChargesTable.SetRange(SaccolinkChargesTable.TransactionTypeCode,thisOptrantype);// -- NOTE: ONLY FT comes with transaction type
              end else begin
                // --  balance and ministatement
                // ((AtmTransCompletedTable.serviceName='BALANCE') OR (AtmTransCompletedTable.serviceName='MINISTATEMENT')) THEN BEGIN
                //SaccoLinkChargesTable.SETRANGE(SaccoLinkChargesTable.Channel, opchannel);
              end;

              if thisOptrantype='0010' then begin
                // ** for deposit we have to reverse the sign
                SaccolinkChargesTable.SetFilter(SaccolinkChargesTable.MinAmount,'<=%1',(transactionAmount*-1)) ;
                SaccolinkChargesTable.SetFilter(SaccolinkChargesTable.MaxAmount,'>=%1',(transactionAmount*-1)) ;
              end else begin
                SaccolinkChargesTable.SetFilter(SaccolinkChargesTable.MinAmount,'<=%1',transactionAmount) ;
                SaccolinkChargesTable.SetFilter(SaccolinkChargesTable.MaxAmount,'>=%1',transactionAmount) ;
              end;

              if SaccolinkChargesTable.Find('-') then begin

                case SaccolinkChargesTable.Channel of
                  'POSAG':
                      begin
                        transactionDescription:='POS Agent';
                      end;
                  'POSBR':
                      begin
                        transactionDescription:='POS Branch';
                      end;
                  'POSMR':
                      begin
                        transactionDescription:='POS Merchant';
                      end;
                  'VISA':
                      begin
                        transactionDescription:='VISA';
                        thisSettlementAccount:=visaSettlementAccount;
                      end;
                  'ATM':
                      begin
                        transactionDescription:='ATM';
                      end;
                else
                  //--

                end;

                case thisOptrantype of
                  '0010':
                      begin
                        transactionDescription:=transactionDescription+' Cash deposit';
                      end;
                  '0011':
                      begin
                        transactionDescription:=transactionDescription+' Cash Withdrawal';
                      end;
                  '0012':
                      begin
                        transactionDescription:=transactionDescription+' Cardless ATM withdrawal';
                      end;
                  '0013':
                      begin
                        transactionDescription:=transactionDescription+' Safaricom C2B';
                      end;
                  '0014':
                      begin
                        transactionDescription:=transactionDescription+' Ministatement Sacco direct';
                      end;
                  '0015':
                      begin
                        transactionDescription:=transactionDescription+' Airtel Airtime purchase';
                      end;
                  '0016':
                      begin
                        transactionDescription:=transactionDescription+' Balance Enquiry_Sacco_Direct';
                      end;
                  '0017':
                      begin
                        transactionDescription:=transactionDescription+' Nairobi water bill payment';
                      end;
                  '0018':
                      begin
                        transactionDescription:=transactionDescription+' Bank Account to sacco account';
                      end;
                  '0019':
                      begin
                        transactionDescription:=transactionDescription+' Sacco account to bank account';
                      end;
                  '0020':
                      begin
                        transactionDescription:=transactionDescription+' Airtel B2C';
                      end;
                  '0021':
                      begin
                        transactionDescription:=transactionDescription+' TELKOM B2C';
                      end;
                  '0022':
                      begin
                        transactionDescription:=transactionDescription+' Sacco account to Virtual Card';
                      end;
                  '0023':
                      begin
                        transactionDescription:=transactionDescription+' Virtual card to SACCO';
                      end;
                  '0024':
                      begin
                        transactionDescription:=transactionDescription+' Sacco to other Sacco';
                      end;
                  '0025':
                      begin
                        transactionDescription:=transactionDescription+' Other sacco to Sacco';
                      end;
                  '0026':
                      begin
                        transactionDescription:=transactionDescription+' Telkom C2B';
                      end;
                  '0027':
                      begin
                        transactionDescription:=transactionDescription+' VISA purchases';
                      end;
                  '1420':
                      begin
                        transactionDescription:=AtmTransCompletedReversalTable.OPOriginalMessageID+' Reversal';// (Request should have same messageID as original transaction)';
                      end;
                else

                  if(UpperCase(AtmTransCompletedTable.serviceName)='BALANCE') then begin
                    if StrPos( UpperCase(AtmTransCompletedTable.OPChannel),'POSAG')>0 then begin
                      transactionDescription:='POS Agent Balance';
                    end;
                    if StrPos( UpperCase(AtmTransCompletedTable.OPChannel),'POSMR')>0 then begin
                      transactionDescription:='POS Balance';
                    end;
                  end;
                  if(UpperCase(AtmTransCompletedTable.serviceName)='MINISTATEMENT') then begin
                    if StrPos( UpperCase(AtmTransCompletedTable.OPChannel),'POSAG')>0 then begin
                      transactionDescription:='POS Agent Ministatement';
                    end;
                    if StrPos( UpperCase(AtmTransCompletedTable.OPChannel),'POSMR')>0 then begin
                      transactionDescription:='POS Ministatement';
                    end;
                  end;

                end;


                totalChargesDueAmount:=SaccolinkChargesTable.TotalCharges;

                saccoRevenueAmount:=SaccolinkChargesTable.SaccoCharge;
                bankRevenueAmount:=SaccolinkChargesTable.BankCharge;

                saccoExciseDutyAmount:=SaccolinkChargesTable.SaccoExciseDuty;
                bankExciseDutyAmount:=SaccolinkChargesTable.BankExciseDuty;

                bankTotalRevenueAmount:=bankRevenueAmount+bankExciseDutyAmount;

                if AtmTransCompletedTable.OPTransactionType='1420' then begin

                  transactionAmount:=transactionAmount*-1;

                  // -- if its reversal then all charges should be reversed
                  totalChargesDueAmount:=totalChargesDueAmount*-1;
                  saccoRevenueAmount:=saccoRevenueAmount*-1;
                  bankRevenueAmount :=bankRevenueAmount*-1;

                  bankTotalRevenueAmount:=bankTotalRevenueAmount*-1;

                  saccoExciseDutyAmount:=saccoExciseDutyAmount*-1;
                  bankExciseDutyAmount:=bankExciseDutyAmount*-1;
                end;


                Message('AT CHARGE > '
                            +' idx='+Format(idx)
                            +' , AMOUNT='+Format(transactionAmount)
                            +' , TOTALCHARGES='+Format(totalChargesDueAmount)
                            +' , SaccoCharge='+Format(saccoRevenueAmount)
                            +' , BankCharge='+Format(bankTotalRevenueAmount)
                            +' , saccoExciseDutyAmount='+Format(saccoExciseDutyAmount)
                            +' , bankExciseDutyAmount='+Format(bankExciseDutyAmount)
                            +' , TRANTYPE='+thisOptrantype
                            +' , CHANNEL: orig= '+opchannel
                            +' , formated='+thisOpchannel
                            +' , TRANSDESC='+transactionDescription
                            );

        //MESSAGE('card '+AtmTransCompletedTable.AccountDebitAccount+' acc '+AtmTransCompletedTable.SavingsAccountNumber);

                // -- post the transaction
                SA.Reset;
                //SA.SETRANGE("ATM No.",AtmTransCompletedTable.AccountDebitAccount);
                SA.SetRange(SA."No.",AtmTransCompletedTable.SavingsAccountNumber);
                if not SA.Find('-') then begin
                  result:='ACCOUNTNOTFOUND';
                  exit;

                end else begin

                  Message('vendor number '+SA."No.");
                  // ---
                  //delete journal line
                  GenJournalLine.Reset;
                  GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                  GenJournalLine.SetRange("Journal Batch Name",'ATMTRANS');
                  GenJournalLine.DeleteAll;
                  //end of deletion

                  GenBatches.Reset;
                  GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                  GenBatches.SetRange(GenBatches.Name,'ATMTRANS');
                  if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name":='GENERAL';
                    GenBatches.Name:='ATMTRANS';
                    GenBatches.Description:='ATM Transactions';
                    GenBatches.Validate(GenBatches."Journal Template Name");
                    GenBatches.Validate(GenBatches.Name);
                    GenBatches.Insert;
                  end;

                  GenSetup.Get;

                  //DR Fosa Account
                  LineNo:=LineNo+10000;
                  GenJournalLine.Init;
                  GenJournalLine."Journal Template Name":='GENERAL';
                  GenJournalLine."Journal Batch Name":='ATMTRANS';
                  GenJournalLine."Line No.":=LineNo;
                  GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                  GenJournalLine."Account No.":=SA."No.";
                  GenJournalLine.Validate(GenJournalLine."Account No.");
                  GenJournalLine."Document No.":=AtmTransCompletedTable.DocumentNumber;//AtmTransCompletedTable.messageID;
                  GenJournalLine."Posting Date":=Today;
                  GenJournalLine.Description:=transactionDescription;
                  GenJournalLine.Amount:=transactionAmount;
                  GenJournalLine.Validate(GenJournalLine.Amount);
                  GenJournalLine."Shortcut Dimension 1 Code":=SA."Global Dimension 1 Code";
                  GenJournalLine."Shortcut Dimension 2 Code":=SA."Global Dimension 2 Code";
                  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                  if GenJournalLine.Amount<>0 then
                  GenJournalLine.Insert;


                  //DR Total Charges
                  LineNo:=LineNo+10000;
                  GenJournalLine.Init;
                  GenJournalLine."Journal Template Name":='GENERAL';
                  GenJournalLine."Journal Batch Name":='ATMTRANS';
                  GenJournalLine."Line No.":=LineNo;
                  GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                  GenJournalLine."Account No.":=SA."No.";
                  GenJournalLine.Validate(GenJournalLine."Account No.");
                  GenJournalLine."Document No.":=AtmTransCompletedTable.DocumentNumber;//AtmTransCompletedTable.messageID;
                  GenJournalLine."Posting Date":=Today;
                  GenJournalLine.Description:=transactionDescription +' Charges';
                  GenJournalLine.Amount:=totalChargesDueAmount;
                  GenJournalLine.Validate(GenJournalLine.Amount);
                  GenJournalLine."Shortcut Dimension 1 Code":=SA."Global Dimension 1 Code";
                  GenJournalLine."Shortcut Dimension 2 Code":=SA."Global Dimension 2 Code";
                  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                  if GenJournalLine.Amount<>0 then
                  GenJournalLine.Insert;


                  //CR settlement account
                  LineNo:=LineNo+10000;
                  GenJournalLine.Init;
                  GenJournalLine."Journal Template Name":='GENERAL';
                  GenJournalLine."Journal Batch Name":='ATMTRANS';
                  GenJournalLine."Line No.":=LineNo;
                  GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
                  GenJournalLine."Account No.":=thisSettlementAccount;
                  GenJournalLine.Validate(GenJournalLine."Account No.");
                  GenJournalLine."Document No.":=AtmTransCompletedTable.DocumentNumber;//AtmTransCompletedTable.messageID;
                  GenJournalLine."Posting Date":=Today;
                  GenJournalLine.Description:=transactionDescription;
                  GenJournalLine.Amount:=transactionAmount*-1;
                  GenJournalLine.Validate(GenJournalLine.Amount);
                  GenJournalLine."Shortcut Dimension 1 Code":=SA."Global Dimension 1 Code";
                  GenJournalLine."Shortcut Dimension 2 Code":=SA."Global Dimension 2 Code";
                  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                  if GenJournalLine.Amount<>0 then
                  GenJournalLine.Insert;

                  //CR Sacco Charge
                  LineNo:=LineNo+10000;
                  GenJournalLine.Init;
                  GenJournalLine."Journal Template Name":='GENERAL';
                  GenJournalLine."Journal Batch Name":='ATMTRANS';
                  GenJournalLine."Line No.":=LineNo;
                  GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                  GenJournalLine."Account No.":=saccoRevenueAccount;
                  GenJournalLine.Validate(GenJournalLine."Account No.");
                  GenJournalLine."Document No.":=AtmTransCompletedTable.DocumentNumber;//AtmTransCompletedTable.messageID;
                  GenJournalLine."Posting Date":=Today;
                  GenJournalLine.Description:=transactionDescription+'-Charges';
                  GenJournalLine.Amount:=saccoRevenueAmount*-1;
                  GenJournalLine.Validate(GenJournalLine.Amount);
                  GenJournalLine."Shortcut Dimension 1 Code":=SA."Global Dimension 1 Code";
                  GenJournalLine."Shortcut Dimension 2 Code":=SA."Global Dimension 2 Code";
                  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                  if GenJournalLine.Amount<>0 then
                  GenJournalLine.Insert;

                  //CR Bank Charge
                  LineNo:=LineNo+10000;
                  GenJournalLine.Init;
                  GenJournalLine."Journal Template Name":='GENERAL';
                  GenJournalLine."Journal Batch Name":='ATMTRANS';
                  GenJournalLine."Line No.":=LineNo;
                  GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                  GenJournalLine."Account No.":=bankRevenueAccount;
                  GenJournalLine.Validate(GenJournalLine."Account No.");
                  GenJournalLine."Document No.":=AtmTransCompletedTable.DocumentNumber;//AtmTransCompletedTable.messageID;
                  GenJournalLine."Posting Date":=Today;
                  GenJournalLine.Description:=transactionDescription+'-Charges';//FORMAT(ATMCharges."Transaction Type")+'-Charges('+(FORMAT(ATMCharges.Source))+')';
                  GenJournalLine.Amount:=(bankTotalRevenueAmount)*-1;
                  GenJournalLine.Validate(GenJournalLine.Amount);
                  GenJournalLine."Shortcut Dimension 1 Code":=SA."Global Dimension 1 Code";
                  GenJournalLine."Shortcut Dimension 2 Code":=SA."Global Dimension 2 Code";
                  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                  if GenJournalLine.Amount<>0 then
                  GenJournalLine.Insert;

                  //CR Excise Duty
                  LineNo:=LineNo+10000;
                  GenJournalLine.Init;
                  GenJournalLine."Journal Template Name":='GENERAL';
                  GenJournalLine."Journal Batch Name":='ATMTRANS';
                  GenJournalLine."Line No.":=LineNo;
                  GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                  GenJournalLine."Account No.":= GenSetup."Excise Duty Account";
                  GenJournalLine.Validate(GenJournalLine."Account No.");
                  GenJournalLine."Document No.":=AtmTransCompletedTable.DocumentNumber;//AtmTransCompletedTable.messageID;
                  GenJournalLine."External Document No.":=SA."No.";
                  GenJournalLine."Posting Date":=Today;
                  GenJournalLine.Description:=transactionDescription+'-Excise Duty';
                  GenJournalLine.Amount:=saccoExciseDutyAmount*-1;// -(ATMCharges."Total Amount")*(GenSetup."Excise Duty (%)"/100);
                  GenJournalLine.Validate(GenJournalLine.Amount);
                  GenJournalLine."Shortcut Dimension 1 Code":=SA."Global Dimension 1 Code";
                  GenJournalLine."Shortcut Dimension 2 Code":=SA."Global Dimension 2 Code";
                  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                  if GenJournalLine.Amount<>0 then
                  GenJournalLine.Insert;


        //EXIT;

                  //Post - start
                  GenJournalLine.Reset;
                  GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                  GenJournalLine.SetRange("Journal Batch Name",'ATMTRANS');
                  if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch",GenJournalLine);
                    GLPosting.Run(GenJournalLine);
                  end;
                  GenJournalLine.Reset;
                  GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                  GenJournalLine.SetRange("Journal Batch Name",'ATMTRANS');
                  GenJournalLine.DeleteAll;
                  //Post - end


                  AtmTransCompletedTable.Status:=AtmTransCompletedTable.Status::Posted;
                  AtmTransCompletedTable.Modify;

                  if isReversal then begin
                    AtmTransCompletedReversalTable.Status:=AtmTransCompletedReversalTable.Status::Reversed;
                    AtmTransCompletedReversalTable.Modify;
                  end;
                  result:='OK-'+AtmTransCompletedTable.messageID;
                  // ---
                end;

              end;

            end;

          end else begin
            // -- TRANSACTION NOT FOUND
            result:='NOTFOUND';
          end;
    end;


    procedure PostTransaction(idx: Integer;documentNum: Text[20]) result: Text
    var
        templateName: Text;
        batchName: Text;
        batchDescription: Text;
        transactionAmount: Decimal;
        transactionDescription: Text[50];
        isReversal: Boolean;
        reverseMessID: Text[50];
        serviceName: Text[20];
        optrantype: Text[30];
        thisOptrantype: Text[30];
        useIdx: Integer;
        opchannel: Text[30];
        thisOpchannel: Text[30];
        atmSettlementAccount: Code[30];
        visaSettlementAccount: Code[30];
        thisSettlementAccount: Code[30];
        saccoRevenueAccount: Code[30];
        bankRevenueAccount: Code[30];
        totalChargesDueAmount: Decimal;
        saccoRevenueAmount: Decimal;
        bankRevenueAmount: Decimal;
        bankTotalRevenueAmount: Decimal;
        saccoExciseDutyAmount: Decimal;
        bankExciseDutyAmount: Decimal;
        AtmTransCompletedTable: Record ATMTransCompleted;
        AtmTransCompletedReversalTable: Record ATMTransCompleted;
        AtmSetupTable: Record "ATM SETUP";
        SaccolinkChargesTable: Record SaccoLinkCharges;
    begin
        
          // ***************************************************************************************** //
        
          result:='FAIL';
        
          AtmTransCompletedTable.Reset;
          //AtmTransCompletedTable.SETRANGE(AtmTransCompletedTable.Status,AtmTransCompletedTable.Status::Pending);
          AtmTransCompletedTable.SetRange(AtmTransCompletedTable.Id,idx );
          AtmTransCompletedTable.SetRange(AtmTransCompletedTable.DocumentNumber,documentNum);
          if AtmTransCompletedTable.Find('-') then  begin
        
            useIdx:=idx;
        
            isReversal:=false;
            // -- initialize the transaction amount, charges and accounts
            transactionAmount:=0;
            transactionDescription:='';
            atmSettlementAccount:='';
            visaSettlementAccount:='';
            saccoRevenueAccount:='';
            bankRevenueAccount:='';
        
            totalChargesDueAmount:=0;
            saccoRevenueAmount:=0;
            bankRevenueAmount:=0;
            bankTotalRevenueAmount:=0;
            saccoExciseDutyAmount:=0;
            bankExciseDutyAmount:=0;
        
            // -- get the atm accounts
            AtmSetupTable.Reset;
            AtmSetupTable.SetRange(AtmSetupTable.ID,1); // -- using GET was throwing an error
            if not AtmSetupTable.Find('-') then begin
              result:='MISSINGSETUPS';
              exit;
        
            end else begin
        
              atmSettlementAccount:=AtmSetupTable.AtmSettlementAccount;
              thisSettlementAccount:=atmSettlementAccount; // -- this is the default settlement account
              visaSettlementAccount:=AtmSetupTable.VisaSettlementAccount;
              saccoRevenueAccount:=AtmSetupTable.SaccoChargeAccount;
              bankRevenueAccount:=AtmSetupTable.BankChargeAccount;
        
              totalChargesDueAmount:=0;
              saccoExciseDutyAmount:=0;
              bankExciseDutyAmount:=0;
        
              serviceName:=UpperCase(AtmTransCompletedTable.serviceName);
        
              if AtmTransCompletedTable.RecSource=AtmTransCompletedTable.Recsource::POS then begin
                transactionDescription:='POS Agent ';
                opchannel:='POSAG';
              end else if AtmTransCompletedTable.RecSource=AtmTransCompletedTable.Recsource::MERCHANT then begin
                transactionDescription:='POS Merchant ';
                opchannel:='POSMR';
              end else if AtmTransCompletedTable.RecSource=AtmTransCompletedTable.Recsource::MERCHANT then begin
                transactionDescription:='POS Branch ';
                opchannel:='POSBR';
              end else if AtmTransCompletedTable.RecSource=AtmTransCompletedTable.Recsource::VISA then begin
                transactionDescription:='VISA ';
                opchannel:='VISA';
              end else begin
                transactionDescription:='ATM ';
                opchannel:='ATM';
              end;
        
        // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
              if not (serviceName='FT') then begin
        
                if (serviceName='BALANCE') then begin
                  // BALANCE ENQUIRY
                   optrantype:='0016';
                end else if (serviceName='MINISTATEMENT') then begin
                  // MINISTATEMENT ENQUIRY
                   optrantype:='0014';
                end;
        
        
        
                transactionDescription:=transactionDescription +AtmTransCompletedTable.TransactionDescription;
        
                /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
                SaccolinkChargesTable.Reset;
                SaccolinkChargesTable.SetRange(SaccolinkChargesTable.Channel,opchannel);
                SaccolinkChargesTable.SetRange(SaccolinkChargesTable.TransactionTypeCode,optrantype);
                SaccolinkChargesTable.SetFilter(SaccolinkChargesTable.MinAmount,'<=%1',transactionAmount) ;
                SaccolinkChargesTable.SetFilter(SaccolinkChargesTable.MaxAmount,'>=%1',transactionAmount) ;
                if SaccolinkChargesTable.Find('-') then begin
        
                  // ** get the transaction charges
                  totalChargesDueAmount:=SaccolinkChargesTable.TotalCharges;
                  saccoRevenueAmount:=SaccolinkChargesTable.SaccoCharge;
                  bankRevenueAmount:=SaccolinkChargesTable.BankCharge;
                  saccoExciseDutyAmount:=SaccolinkChargesTable.SaccoExciseDuty;
                  bankExciseDutyAmount:=SaccolinkChargesTable.BankExciseDuty;
                  bankTotalRevenueAmount:=bankRevenueAmount+bankExciseDutyAmount;
                  // ** end get the transaction charges
        
                   // post from here
                  SA.Reset;
                  SA.SetRange(SA."No.",AtmTransCompletedTable.SavingsAccountNumber);
                  if not SA.Find('-') then begin
                    result:='ACCOUNTNOTFOUND';
                    exit;
                  end else begin
        
                    // ** prepare journal
                    templateName:='GENERAL';
                    batchName:='ATMTRANS';
                    batchDescription:='ATM Transactions';
        
                    PrepareGeneralJournal(templateName,batchName,batchDescription);
                    // ** end prepare journal
        
                    GenSetup.Get;
                    ComposeGeneralJournal(AtmTransCompletedTable.DocumentNumber
                                  ,SA."No."
                                  ,thisSettlementAccount,saccoRevenueAccount,bankRevenueAccount,GenSetup."Excise Duty Account"
                                  ,transactionAmount,totalChargesDueAmount
                                  ,saccoRevenueAmount,bankTotalRevenueAmount,saccoExciseDutyAmount
                                  ,transactionDescription
                                  ,AtmTransCompletedTable.OPTransactionDate
                                  ,templateName,batchName,SA."Global Dimension 1 Code",SA."Global Dimension 2 Code");
        
          //EXIT;
                    // ** Post - start
                    CommitPostGeneralJournal(templateName,batchName);
                    ClearGeneralJournal(templateName,batchName);
                    // ** Post - end
        
                    AtmTransCompletedTable.Status:=AtmTransCompletedTable.Status::Posted;
                    AtmTransCompletedTable.Modify;
        
                    result:='OK-'+AtmTransCompletedTable.messageID;
                    // ---
                  end;
                  // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                end;
                /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
        
              end else begin /* (serviceName='FT') */
        
                thisOptrantype:=AtmTransCompletedTable.OPTransactionType;
                optrantype:=thisOptrantype;
        
                transactionAmount:=AtmTransCompletedTable.PostingTotalAmount;
                transactionDescription:=AtmTransCompletedTable.TransactionDescription;
        
                if (thisOptrantype='1420') or (thisOptrantype='1421') then begin
        
                  AtmTransCompletedReversalTable.Reset;
                  AtmTransCompletedReversalTable.SetRange(AtmTransCompletedReversalTable.messageID,AtmTransCompletedTable.OPOriginalMessageID);
                  AtmTransCompletedReversalTable.SetFilter(AtmTransCompletedReversalTable.Id,'<>%1',idx);
                  if not AtmTransCompletedReversalTable.Find('-') then begin
                    // -- transaction not found - do not proceed
                    AtmTransCompletedTable.Status:=AtmTransCompletedTable.Status::Failed;
                    result:='REVERSEIDNOTFOUND-'+AtmTransCompletedTable.OPOriginalMessageID;
                    exit;
                  end else begin
                    isReversal:=true;
                    useIdx:=AtmTransCompletedReversalTable.Id;
                    optrantype:=AtmTransCompletedReversalTable.OPTransactionType;
                    transactionDescription:=AtmTransCompletedReversalTable.TransactionDescription+' Reversal';
        
                    if AtmTransCompletedReversalTable.RecSource=AtmTransCompletedReversalTable.Recsource::POS then begin
                      opchannel:='POSAG';
                    end else if AtmTransCompletedReversalTable.RecSource=AtmTransCompletedReversalTable.Recsource::MERCHANT then begin
                      opchannel:='POSMR';
                    end else if AtmTransCompletedReversalTable.RecSource=AtmTransCompletedReversalTable.Recsource::MERCHANT then begin
                      opchannel:='POSBR';
                    end else if AtmTransCompletedReversalTable.RecSource=AtmTransCompletedReversalTable.Recsource::VISA then begin
                      opchannel:='VISA';
                    end else begin
                      opchannel:='ATM';
                    end;
        
                  end;
        
                end;
        
        
        
                // -- get this transaction charges
                SaccolinkChargesTable.Reset;
                SaccolinkChargesTable.SetRange(SaccolinkChargesTable.Channel,opchannel);
                SaccolinkChargesTable.SetRange(SaccolinkChargesTable.TransactionTypeCode,optrantype);
                if optrantype='0010' then begin
                  // ** for deposit we have to reverse the sign
                  SaccolinkChargesTable.SetFilter(SaccolinkChargesTable.MinAmount,'<=%1',(transactionAmount*-1)) ;
                  SaccolinkChargesTable.SetFilter(SaccolinkChargesTable.MaxAmount,'>=%1',(transactionAmount*-1)) ;
                end else begin
                  SaccolinkChargesTable.SetFilter(SaccolinkChargesTable.MinAmount,'<=%1',transactionAmount) ;
                  SaccolinkChargesTable.SetFilter(SaccolinkChargesTable.MaxAmount,'>=%1',transactionAmount) ;
                end;
                if SaccolinkChargesTable.Find('-') then begin
        
                  // ** get the transaction charges
                  totalChargesDueAmount:=SaccolinkChargesTable.TotalCharges;
                  saccoRevenueAmount:=SaccolinkChargesTable.SaccoCharge;
                  bankRevenueAmount:=SaccolinkChargesTable.BankCharge;
                  saccoExciseDutyAmount:=SaccolinkChargesTable.SaccoExciseDuty;
                  bankExciseDutyAmount:=SaccolinkChargesTable.BankExciseDuty;
                  bankTotalRevenueAmount:=bankRevenueAmount+bankExciseDutyAmount;
                  // ** end get the transaction charges
        
        
                  // --- if it is reversal ----------
                  if (thisOptrantype='1420') or (thisOptrantype='1421') then begin
        
                    // ** reverse transaction amounts
                    totalChargesDueAmount:=totalChargesDueAmount*-1;
                    saccoRevenueAmount:=saccoRevenueAmount*-1;
                    bankRevenueAmount:=bankRevenueAmount*-1;
                    saccoExciseDutyAmount:=saccoExciseDutyAmount*-1;
                    bankExciseDutyAmount:=bankExciseDutyAmount*-1;
                    bankTotalRevenueAmount:=bankTotalRevenueAmount*-1;
                    transactionAmount:=transactionAmount*-1;
                    // ** end reverse transaction amounts
        
                  end;
                  // --- end if is reversal ------
        
                  if (optrantype='0027') then begin
        
                    if SaccolinkChargesTable.Channel='VISA' then thisSettlementAccount:=visaSettlementAccount;
        
                  end;
        
                  // VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV
                  // post from here
                  SA.Reset;
                  SA.SetRange(SA."No.",AtmTransCompletedTable.SavingsAccountNumber);
                  if not SA.Find('-') then begin
                    result:='ACCOUNTNOTFOUND';
                    exit;
                  end else begin
        
                    // ** prepare journal
                    templateName:='GENERAL';
                    batchName:='ATMTRANS';
                    batchDescription:='ATM Transactions';
        
                    PrepareGeneralJournal(templateName,batchName,batchDescription);
                    // ** end prepare journal
        
                    GenSetup.Get;
                    ComposeGeneralJournal(AtmTransCompletedTable.DocumentNumber
                                  ,SA."No."
                                  ,thisSettlementAccount,saccoRevenueAccount,bankRevenueAccount,GenSetup."Excise Duty Account"
                                  ,transactionAmount,totalChargesDueAmount
                                  ,saccoRevenueAmount,bankTotalRevenueAmount,saccoExciseDutyAmount
                                  ,transactionDescription
                                  ,AtmTransCompletedTable.OPTransactionDate
                                  ,templateName,batchName,SA."Global Dimension 1 Code",SA."Global Dimension 2 Code");
        
         // EXIT;
                    // ** Post - start
                    CommitPostGeneralJournal(templateName,batchName);
                    ClearGeneralJournal(templateName,batchName);
                    // ** Post - end
        
                    AtmTransCompletedTable.Status:=AtmTransCompletedTable.Status::Posted;
                    AtmTransCompletedTable.Modify;
        
                    if isReversal then begin
                      AtmTransCompletedReversalTable.Reset;
                      AtmTransCompletedReversalTable.SetRange(AtmTransCompletedReversalTable.Id,useIdx);
                      AtmTransCompletedReversalTable.SetRange(AtmTransCompletedReversalTable.messageID,AtmTransCompletedTable.OPOriginalMessageID);
                      if AtmTransCompletedReversalTable.Find('-') then begin
                        AtmTransCompletedReversalTable.Status:=AtmTransCompletedReversalTable.Status::Reversed;
                        AtmTransCompletedReversalTable.Modify;
                      end;
                    end;
        
                    result:='OK-'+AtmTransCompletedTable.messageID;
                    // ---
                  end;
                  // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        
        
                end; // END saccolinkcharges FIND
        
        
              end;
        
        
        
        
        // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        
        
        
            end;
        
          end else begin
            // -- TRANSACTION NOT FOUND
            result:='NOTFOUND';
          end;

    end;


    procedure ComposeGeneralJournal(documentNumber: Text[20];fosaAccount: Text;settlementAccount: Text;saccoRevAccount: Text;bankRevAccount: Text;exciseDutyAccount: Text;transactionAmount: Decimal;transactionTotalChargesAmount: Decimal;saccoRevAmount: Decimal;bankRevAmount: Decimal;exciseDutyAmount: Decimal;transactionDescription: Text;transactionDate: Date;templateName: Text;batchName: Text;dimCode1: Text;dimCode2: Text) result: Text
    begin

                  // DR FOSA Account
                  LineNo:=LineNo+10000;
                  CreateGeneralJournalLine(LineNo,templateName,batchName,documentNumber
                                ,GenJournalLine."account type"::Vendor
                                ,fosaAccount
                                ,transactionAmount
                                ,transactionDescription
                                ,'',transactionDate,dimCode1,dimCode2);

                  // DR Total Charges
                  LineNo:=LineNo+10000;
                  CreateGeneralJournalLine(LineNo,templateName,batchName,documentNumber
                                ,GenJournalLine."account type"::Vendor
                                ,fosaAccount
                                ,transactionTotalChargesAmount
                                ,transactionDescription +' Total Charges'
                                ,'',transactionDate,dimCode1,dimCode2);

                  // CR settlement account
                  LineNo:=LineNo+10000;
                  CreateGeneralJournalLine(LineNo,templateName,batchName,documentNumber
                                ,GenJournalLine."account type"::"Bank Account"
                                ,settlementAccount
                                ,transactionAmount*-1
                                ,transactionDescription
                                ,'',transactionDate,dimCode1,dimCode2);

                  // CR Sacco Charge
                  LineNo:=LineNo+10000;
                  CreateGeneralJournalLine(LineNo,templateName,batchName,documentNumber
                                ,GenJournalLine."account type"::"G/L Account"
                                ,saccoRevAccount
                                ,saccoRevAmount*-1
                                ,transactionDescription+' SACCO Charge'
                                ,'',transactionDate,dimCode1,dimCode2);

                  // CR Bank Charge
                  LineNo:=LineNo+10000;
                  CreateGeneralJournalLine(LineNo,templateName,batchName,documentNumber
                                ,GenJournalLine."account type"::"G/L Account"
                                ,bankRevAccount
                                ,bankRevAmount*-1
                                ,transactionDescription+' Bank Charge'
                                ,'',transactionDate,dimCode1,dimCode2);

                  // CR Excise Duty
                  LineNo:=LineNo+10000;
                  CreateGeneralJournalLine(LineNo,templateName,batchName,documentNumber
                                ,GenJournalLine."account type"::"G/L Account"
                                ,exciseDutyAccount
                                ,exciseDutyAmount*-1
                                ,transactionDescription+' SACCO Excise Duty'
                                ,'',transactionDate,dimCode1,dimCode2);
    end;


    procedure ClearGeneralJournal(templateName: Text;batchName: Text)
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin

          //delete journal line
          GenJournalLine.Reset;
          GenJournalLine.SetRange("Journal Template Name",templateName);
          GenJournalLine.SetRange("Journal Batch Name",batchName);
          GenJournalLine.DeleteAll;
          //end of deletion

    end;


    procedure PrepareGeneralJournal(templateName: Text;batchName: Text;batchDescription: Text)
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin

        // ** prepare journal

          ClearGeneralJournal(templateName,batchName);//clear previous journal lines

          GenBatches.Reset;
          GenBatches.SetRange(GenBatches."Journal Template Name",templateName);
          GenBatches.SetRange(GenBatches.Name,batchName);
          if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name":=templateName;
            GenBatches.Name:=batchName;
            GenBatches.Description:=batchDescription;//'ATM Transactions';
            GenBatches.Validate(GenBatches."Journal Template Name");
            GenBatches.Validate(GenBatches.Name);
            GenBatches.Insert;
          end;

        // ** end prepare journal
    end;


    procedure CreateGeneralJournalLine(LineNo: Integer;templateName: Text;batchName: Text;documentNo: Code[30];accountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor;accountNo: Code[50];transactionAmount: Decimal;transactionDescription: Text;externalDocumentNo: Code[50];transactionDate: Date;dim1: Code[40];dim2: Code[40])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin

          GenJournalLine.Init;
          GenJournalLine."Line No.":=LineNo;
          GenJournalLine."Journal Template Name":=templateName; //'GENERAL';
          GenJournalLine."Journal Batch Name":=batchName;       //'ATMTRANS';
          GenJournalLine."Account Type":=accountType;           // GenJournalLine."Account Type"::Vendor;
          GenJournalLine."Account No.":=accountNo;              // SA."No.";
          GenJournalLine.Validate(GenJournalLine."Account No.");
          GenJournalLine."Document No.":=documentNo;            // AtmTransCompletedTable.DocumentNumber;//AtmTransCompletedTable.messageID;
          GenJournalLine."Posting Date":=transactionDate;       //TODAY;
          GenJournalLine.Description:=transactionDescription;
          GenJournalLine.Amount:=transactionAmount;
          GenJournalLine.Validate(GenJournalLine.Amount);
          GenJournalLine."Shortcut Dimension 1 Code":=dim1;// SA."Global Dimension 1 Code";
          GenJournalLine."Shortcut Dimension 2 Code":=dim2;//SA."Global Dimension 2 Code";
          GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
          GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
          if GenJournalLine.Amount<>0 then
          GenJournalLine.Insert;
    end;


    procedure CommitPostGeneralJournal(templateName: Text;batchName: Text)
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
          GenJournalLine.Reset;
          GenJournalLine.SetRange(GenJournalLine."Journal Template Name",templateName);
          GenJournalLine.SetRange(GenJournalLine."Journal Batch Name",batchName);
          if GenJournalLine.FindSet then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch",GenJournalLine);
          end;
    end;
}

