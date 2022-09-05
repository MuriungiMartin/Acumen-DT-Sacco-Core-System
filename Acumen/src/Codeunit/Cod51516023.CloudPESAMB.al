#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516023 "CloudPESAMB"
{

    trigger OnRun()
    begin

        //RunPostings(1);
        //RunPostings(2);
        // RunPostings(3);
        // RunPostings(4);
        //MESSAGE(RegisteredMemberDetails('254710985344'));
        //MESSAGE(OutstandingLoansUSSD('254720401314'));
        //MESSAGE(GetBalanceEnquiry('BAL9550','254710985344',TODAY));
        //MESSAGE(Getministatement('BAL9561','254710985344',TODAY,3));
        //MESSAGE(WSSAccount('254710985344'));
        //MESSAGE(LoanGuarantors('LB13352'));
        //MESSAGE(MemberAccounts('254720401314'));
        //MESSAGE(AccountBalance('1250','171828282'));
        //MESSAGE(Guaranteefreeshares('+254723214181'));
        //MESSAGE(RegisteredMemberDetails('254716670020'));
        //MESSAGE(FORMAT(AccountBalanceDec('01-001-0859',2)));

        //PaybillSwitch();

        //ProcessWithdrawals();
        //MobileLoaneeSMS();
        //SMSMessage('555','BSE000756','0722898017','iAM GUARLABLE');
        //MESSAGE(OutstandingLoanName('0722898017'));
        //MESSAGE(UpdateSurePESARegistration('BES000004'));
        //MESSAGE(LoanGusarantorsUSSD('LB15205','0722898017','27897'));
        //MESSAGE(FundsTransferBOSA('01-001-1848','Deposit Contribution','00020T10985344A0021',20));
        //MESSAGE(MiniStatement('+254710238743', '88552525'));
        //MESSAGE(OutstandingLoansUSSD('0722898017'));
        //MESSAGE(HolidayAcc('0722898017'));
        //MESSAGE(PayBillToAcc('SDWTYRES','lMNSW345','BES000615','703000541',1s00,'MNBBB'));
        //MESSAGE(InsertTransaction('MSQDSDS601','LN0','LN01595','Ngosa','254722829525',5000,7000));
        //MESSAGE(GetMpesaDisbursment());
        //fnProcessNotification();
        //MESSAGE(PostNormalLoan('11001201201155','005276',5000,1));
        //FnsentSMS();
        //MESSAGE('%1',AdvanceEligibility('01-002-1740'));
        //SendSchedulesms();

        //MESSAGE(LoanRepayment('01-001-0658','BLN00423','00020211384055',100));

        //MESSAGE(PostMPESATrans('PBG7QFFR0J','01-002-0707',5000,TODAY,'4'));
        //MESSAGE(MemberAccounts('710985344'));
    end;

    var
        Vendor: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
        miniBalance: Decimal;
        accBalance: Decimal;
        minimunCount: Integer;
        VendorLedgEntry: Record "Vendor Ledger Entry";
        amount: Decimal;
        Loans: Integer;
        LoansRegister: Record "Loans Register";
        LoanProductsSetup: Record "Loan Products Setup";
        Members: Record Customer;
        dateExpression: Text[20];
        DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        dashboardDataFilter: Date;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        MemberLedgerEntry: Record "Cust. Ledger Entry";
        MemberLedgerEntry2: Record "Cust. Ledger Entry";
        LoansTable: Record "Loans Register";
        SurePESAApplications: Record "CloudPESA Applications";
        GenJournalLine: Record "Gen. Journal Line";
        GenBatches: Record "Gen. Journal Batch";
        LineNo: Integer;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        SurePESATrans: Record "CloudPESA Transactions";
        GenLedgerSetup: Record "General Ledger Setup";
        Charges: Record Charges;
        MobileCharges: Decimal;
        MobileChargesACC: Text[20];
        SurePESACommACC: Code[20];
        SurePESACharge: Decimal;
        ExcDuty: Decimal;
        TempBalance: Decimal;
        BOSATransSchedule: Record "BOSA TransferS Schedule";
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        msg: Text[1000];
        accountName1: Text[40];
        accountName2: Text[40];
        fosaAcc: Text[30];
        LoanGuaranteeDetails: Record "Loans Guarantee Details";
        bosaNo: Text[20];
        RanNo: Text[20];
        PaybillTrans: Record "CloudPESA MPESA Trans";
        PaybillRecon: Code[20];
        Rschedule: Record "Loan Repayment Schedule";
        ChargeAmount: Decimal;
        glamount: Decimal;
        LoanProducttype: Record "Loan Products Setup";
        varLoan: Text[500];
        CoopbankTran: Record "Change Request";
        loanamt: Decimal;
        description: Code[100];
        hlamount: Decimal;
        commision: Decimal;
        Mstatus: Code[10];
        SaccoGenSetup: Record "Sacco General Set-Up";
        MpesaAccount: Code[50];
        MpesaDisbus: Record "Mobile Loans";
        MPESACharge: Decimal;
        TariffDetails: Record "Tariff Details";
        GenSetUp: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        VarReceivableAccount: Code[20];
        SFactory: Codeunit "SURESTEP Factory.";
        ObjIprsLogs: Record "Cheque Truncation Buffer";
        LoanRepay: Record "Loan Repayment Schedule";
        Mrowcount: Integer;
        CloudPESACharge: Decimal;
        TotalCharges: Decimal;
        CloudPESATrans: Record "CloudPESA Transactions";
        CloudPESACommACC: Code[50];
        MPESARecon: Code[50];
        ExxcDuty: label '60545';
        LoanOut: Decimal;
        countTrans: Decimal;
        MobileLoans: Record "Mobile Loans";


    procedure AccountBalance(Acc: Code[30]; DocNumber: Code[20]) Bal: Text[500]
    begin

        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", Acc);
        //Vendor.SETFILTER(Vendor."Account Type",'%1|%2','100','200');
        if Vendor.Find('-') then begin
            Vendor.CalcFields(Vendor."Balance (LCY)", Vendor."ATM Transactions");
            Bal := Format(Vendor."Balance (LCY)" - (Vendor.SaccolinkPendingPostingAmount + (Vendor."Uncleared Cheques" - Vendor."Cheque Discounted Amount") + Vendor."ATM Transactions" + Vendor."EFT Transactions" + Vendor."Mobile Transactions") + Vendor."Cheque Discounted");
            //  W;
            ///"Balance (LCY)"-(("Uncleared Cheques"-"Cheque Discounted Amount")+"ATM Transactions"+"EFT Transactions"+MinBalance+"Mobile Transactions")+"Cheque Discounted"
        end;
    end;


    procedure GetBalanceEnquiry(referenceNumber: Code[20]; phoneNumber: Text[13]; transactionDate: Date; transactionTime: DateTime) response: Text[1024]
    var
        vendorTable: Record Vendor;
        vendorTableOther: Record Vendor;
        memberTable: Record Customer;
        chargesTable: Record Charges;
        loanRegisterTable: Record "Loans Register";
        exciseDutyAmount: Decimal;
        bookBalance: Decimal;
        availableBalance: Decimal;
    begin
        response := '2|FAILED|~|0';

        CloudPESATrans.Reset;
        CloudPESATrans.SetRange(CloudPESATrans."Document No", referenceNumber);
        if CloudPESATrans.Find('-') then begin
            response := '1|REFEXISTS|~|0';
        end else begin
            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;

            chargesTable.Reset;
            chargesTable.SetRange(chargesTable.Code, GenLedgerSetup."Mobile Balance Enquiry fee");
            if chargesTable.Find('-') then begin
                chargesTable.TestField(chargesTable."GL Account");
                MobileCharges := chargesTable."Sacco Amount";//."Charge Amount";
                MobileChargesACC := chargesTable."GL Account";
                CloudPESACharge := chargesTable."Charge Amount";
            end;

            CloudPESACommACC := GenLedgerSetup."CloudPESA Comm Acc";
            //CloudPESACharge:=0;

            SaccoGenSetup.Reset;
            SaccoGenSetup.Get;
            exciseDutyAmount := (SaccoGenSetup."Excise Duty(%)" / 100) * MobileCharges;

            TotalCharges := (MobileCharges + CloudPESACharge);
            //MESSAGE('toal charges ' +FORMAT(TotalCharges));
            vendorTable.Reset;
            vendorTable.SetRange("Mobile Phone No", phoneNumber);
            if vendorTable.Find('-') then begin

                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code, vendorTable."Account Type");
                if AccountTypes.Find('-') then begin
                    miniBalance := AccountTypes."Minimum Balance";
                end;
                vendorTable.CalcFields(vendorTable."Cheque Discounted Amount", vendorTable."Mobile Transactions", vendorTable."Balance (LCY)", vendorTable."ATM Transactions", vendorTable."Uncleared Cheques", vendorTable."EFT Transactions",
                vendorTable.SaccolinkPendingPostingAmount);
                TempBalance := vendorTable."Balance (LCY)" - (miniBalance + vendorTable."ATM Transactions" + (vendorTable."Uncleared Cheques" - vendorTable."Cheque Discounted Amount") + vendorTable."EFT Transactions" + vendorTable."Mobile Transactions" +
                vendorTable.SaccolinkPendingPostingAmount);

                //MESSAGE('temp balance ' +FORMAT(TempBalance));
                if (TempBalance >= (TotalCharges + exciseDutyAmount)) then begin

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'BALENQ');
                    GenJournalLine.DeleteAll;
                    //end of deletion

                    GenBatches.Reset;
                    GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                    GenBatches.SetRange(GenBatches.Name, 'BALENQ');
                    if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name" := 'GENERAL';
                        GenBatches.Name := 'BALENQ';
                        GenBatches.Description := 'Balance Enquiry';
                        GenBatches.Validate(GenBatches."Journal Template Name");
                        GenBatches.Validate(GenBatches.Name);
                        GenBatches.Insert;
                    end;


                    // ** post charges
                    //DR Customer Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'BALENQ';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := vendorTable."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := referenceNumber;
                    GenJournalLine."External Document No." := vendorTable."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Balance enquiry-' + vendorTable."Mobile Phone No";
                    GenJournalLine.Amount := TotalCharges;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;



                    //DR Excise Duty
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'BALENQ';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := vendorTable."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := referenceNumber;
                    GenJournalLine."External Document No." := vendorTable."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Balance enquiry Excise Duty';
                    GenJournalLine.Amount := exciseDutyAmount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //CR Excise Duty
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'BALENQ';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := SaccoGenSetup."Excise Duty Account";//GenLedgerSetupGenSetUp.FORMAT(ExxcDuty);
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := referenceNumber;
                    GenJournalLine."External Document No." := MobileChargesACC;
                    GenJournalLine."Source No." := vendorTable."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Balance enquiry Excise Duty';
                    GenJournalLine.Amount := exciseDutyAmount * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;



                    //CR Mobile Transactions Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'BALENQ';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := MobileChargesACC;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := referenceNumber;
                    GenJournalLine."External Document No." := MobileChargesACC;
                    GenJournalLine."Source No." := vendorTable."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Balance Enq Sacco Comm';
                    GenJournalLine.Amount := MobileCharges * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //CR Surestep Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'BALENQ';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := CloudPESACommACC;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := referenceNumber;
                    GenJournalLine."External Document No." := MobileChargesACC;
                    GenJournalLine."Source No." := vendorTable."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Balance Enq vendor Comm';
                    GenJournalLine.Amount := -CloudPESACharge;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Post

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'BALENQ');
                    if GenJournalLine.Find('-') then begin

                        repeat
                            GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'BALENQ');
                        GenJournalLine.DeleteAll;



                        // ** FETCH FOSA LINKED ACCOUNT BALANCE
                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, vendorTable."Account Type");
                        if AccountTypes.Find('-') then begin
                            miniBalance := AccountTypes."Minimum Balance";
                        end;
                        accBalance := TempBalance - (TotalCharges + exciseDutyAmount);//Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions"+miniBalance);
                        response := '0|OK|' + AccountTypes.Description + '|' + Format(accBalance) + ';';


                        // ** FETCH OTHER FOSA BALANCES
                        vendorTableOther.Reset;
                        vendorTableOther.SetRange("BOSA Account No", vendorTable."BOSA Account No");
                        vendorTableOther.SetFilter("No.", '<>%1', vendorTable."No.");
                        if vendorTableOther.Find('-') then begin
                            repeat
                                vendorTableOther.CalcFields(vendorTableOther."Balance (LCY)", vendorTableOther."ATM Transactions", vendorTableOther."Uncleared Cheques", vendorTableOther."EFT Transactions");
                                availableBalance := vendorTableOther."Balance (LCY)" - (vendorTableOther."ATM Transactions" + vendorTableOther."Uncleared Cheques" + vendorTableOther."EFT Transactions");
                                AccountTypes.Reset;
                                AccountTypes.SetRange(AccountTypes.Code, vendorTableOther."Account Type");
                                if AccountTypes.Find('-') then begin
                                    response += '0|OK|' + AccountTypes.Description + '|' + Format(availableBalance) + ';';
                                end;
                            until vendorTableOther.Next = 0;
                        end;

                        // ** FETCH BOSA BALANCES
                        memberTable.Reset;
                        memberTable.SetRange("No.", vendorTable."BOSA Account No");
                        if memberTable.Find('-') then begin

                            memberTable.CalcFields("Shares Retained", "Current Shares");

                            response += '0|OK|Share Capital|' + Format(memberTable."Shares Retained") + ';';
                            response += '0|OK|Deposit Contributions|' + Format(memberTable."Current Shares") + ';';
                        end;

                        // ** FETCH DEPOSIT CONTRIBUTIONS
                        loanRegisterTable.Reset;
                        loanRegisterTable.SetRange("Client Code", vendorTable."BOSA Account No");
                        if loanRegisterTable.Find('-') then begin
                            repeat
                                loanRegisterTable.CalcFields("Outstanding Balance", "Oustanding Interest");
                                if loanRegisterTable."Outstanding Balance" > 0 then begin
                                    response += '0|OK|' + loanRegisterTable."Loan Product Type" + '|' + Format(loanRegisterTable."Outstanding Balance") + ';';
                                end;
                            until loanRegisterTable.Next = 0;
                        end;

                        // ** MAKE AN ENTRY IN THE TRANSATIONS TABLE FOR POSTING
                        CloudPESATrans.Init;
                        CloudPESATrans."Document No" := referenceNumber;
                        CloudPESATrans.Description := 'Balance Enquiry';
                        CloudPESATrans."Document Date" := transactionDate;// TODAY;
                        CloudPESATrans."Transaction Time" := Dt2Time(transactionTime);
                        CloudPESATrans."Account No" := vendorTable."No.";
                        CloudPESATrans.Charge := MobileCharges + CloudPESACharge + exciseDutyAmount;// ** TotalCharges; //** exclude excise duty which will be recomputed when posting
                        CloudPESATrans."Account Name" := vendorTable.Name;
                        CloudPESATrans."Telephone Number" := vendorTable."Mobile Phone No";
                        CloudPESATrans."Account No2" := '';
                        CloudPESATrans.Amount := 0;//amount;
                        CloudPESATrans.Posted := true;//FALSE;
                                                      //CloudPESATrans."Posting Date":=TODAY;
                        CloudPESATrans.Status := CloudPESATrans.Status::Completed;//CloudPESATrans.Status::Pending;
                        CloudPESATrans.Comments := 'Success';
                        CloudPESATrans.Client := vendorTable."BOSA Account No";
                        CloudPESATrans."Transaction Type" := CloudPESATrans."transaction type"::Balance;
                        ////CloudPESATrans."Transaction Time":=TIME;
                        CloudPESATrans.Insert;

                    end;





                    // ** end post charges


                end else begin
                    response := '3|INSUFFICIENT|~|0;';
                end;

            end else begin
                response := '4|ACCNOTFOUND|~|0;';
            end;

        end;
    end;


    procedure GetMinistatement(referenceNumber: Code[50]; phoneNumber: Code[50]; transactionDate: Date; transactionTime: DateTime; noOfEntries: Integer) response: Text
    var
        vendorTable: Record Vendor;
        vendorLedgerEntries: Record "Vendor Ledger Entry";
        chargesTable: Record Charges;
        exciseDutyAmount: Decimal;
        endRepeat: Boolean;
    begin
        response += '2|FAILED|' + Format(Today) + '|~|0;';



        CloudPESATrans.Reset;
        CloudPESATrans.SetRange(CloudPESATrans."Document No", referenceNumber);
        if CloudPESATrans.Find('-') then begin
            response := '1|REFEXISTS|' + Format(Today) + '|~|0;';
        end else begin
            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;

            chargesTable.Reset;
            chargesTable.SetRange(chargesTable.Code, GenLedgerSetup."Mobile Ministatement fee");
            if chargesTable.Find('-') then begin
                chargesTable.TestField(chargesTable."GL Account");
                MobileCharges := chargesTable."Sacco Amount";//."Charge Amount";
                MobileChargesACC := chargesTable."GL Account";
                CloudPESACharge := chargesTable."Charge Amount";
            end;

            CloudPESACommACC := GenLedgerSetup."CloudPESA Comm Acc";

            SaccoGenSetup.Reset;
            SaccoGenSetup.Get;
            exciseDutyAmount := (SaccoGenSetup."Excise Duty(%)" / 100) * MobileCharges;

            TotalCharges := (MobileCharges + CloudPESACharge);

            vendorTable.Reset;
            vendorTable.SetRange(vendorTable."Mobile Phone No", phoneNumber);
            if vendorTable.Find('-') then begin

                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code, vendorTable."Account Type");
                if AccountTypes.Find('-') then begin
                    miniBalance := AccountTypes."Minimum Balance";
                end;

                vendorTable.CalcFields(vendorTable."Balance (LCY)", vendorTable."ATM Transactions", vendorTable."Uncleared Cheques", vendorTable."EFT Transactions");

                TempBalance := vendorTable."Balance (LCY)" - (miniBalance + vendorTable."ATM Transactions" + vendorTable."Uncleared Cheques" + vendorTable."EFT Transactions");
                if (TempBalance >= (TotalCharges + exciseDutyAmount)) then begin


                    vendorLedgerEntries.Reset;
                    vendorLedgerEntries.SetCurrentkey(vendorLedgerEntries."Entry No.");
                    vendorLedgerEntries.Ascending(false);
                    vendorLedgerEntries.SetFilter(vendorLedgerEntries.Description, '<>%1', '*Charges*');
                    vendorLedgerEntries.SetRange(vendorLedgerEntries."Vendor No.", vendorTable."No.");
                    //VendorLedgEntry.SETFILTER(VendorLedgEntry.Description,'<>*Excise duty*');
                    vendorLedgerEntries.SetRange(vendorLedgerEntries.Reversed, false);
                    if vendorLedgerEntries.FindSet then begin
                        response := '';
                        minimunCount := 0;
                        repeat
                            vendorLedgerEntries.CalcFields(vendorLedgerEntries.Amount);
                            amount := vendorLedgerEntries.Amount;
                            if amount < 1 then amount := amount * -1;
                            response += '0|OK|' + Format(vendorLedgerEntries."Posting Date") + '|' + CopyStr(vendorLedgerEntries.Description, 1, 25) + '|' + Format(amount) + ';';
                            minimunCount := minimunCount + 1;

                            if minimunCount >= noOfEntries then begin
                                endRepeat := true;
                            end else begin
                                endRepeat := vendorLedgerEntries.Next = 0;
                            end;

                        until endRepeat;
                    end;

                    // **** POST THE CHARGES

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'BALENQ');
                    GenJournalLine.DeleteAll;
                    //end of deletion

                    GenBatches.Reset;
                    GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                    GenBatches.SetRange(GenBatches.Name, 'BALENQ');
                    if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name" := 'GENERAL';
                        GenBatches.Name := 'BALENQ';
                        GenBatches.Description := 'Ministatement';
                        GenBatches.Validate(GenBatches."Journal Template Name");
                        GenBatches.Validate(GenBatches.Name);
                        GenBatches.Insert;
                    end;


                    // ** post charges
                    //DR Customer Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'BALENQ';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := vendorTable."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := referenceNumber;
                    GenJournalLine."External Document No." := vendorTable."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Ministatement-' + vendorTable."Mobile Phone No";
                    GenJournalLine.Amount := TotalCharges;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;



                    //DR Excise Duty
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'BALENQ';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := vendorTable."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := referenceNumber;
                    GenJournalLine."External Document No." := vendorTable."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Ministatement Excise Duty';
                    GenJournalLine.Amount := exciseDutyAmount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //CR Excise Duty
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'BALENQ';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := SaccoGenSetup."Excise Duty Account";//GenLedgerSetupGenSetUp.FORMAT(ExxcDuty);
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := referenceNumber;
                    GenJournalLine."External Document No." := MobileChargesACC;
                    GenJournalLine."Source No." := vendorTable."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Ministatement Excise Duty';
                    GenJournalLine.Amount := exciseDutyAmount * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;



                    //CR Mobile Transactions Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'BALENQ';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := MobileChargesACC;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := referenceNumber;
                    GenJournalLine."External Document No." := MobileChargesACC;
                    GenJournalLine."Source No." := vendorTable."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Ministatement Sacco Comm';
                    GenJournalLine.Amount := MobileCharges * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //CR Surestep Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'BALENQ';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := CloudPESACommACC;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := referenceNumber;
                    GenJournalLine."External Document No." := MobileChargesACC;
                    GenJournalLine."Source No." := vendorTable."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Ministatement vendor Comm';
                    GenJournalLine.Amount := -CloudPESACharge;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Post

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'BALENQ');
                    if GenJournalLine.Find('-') then begin

                        repeat
                            GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'BALENQ');
                        GenJournalLine.DeleteAll;
                        // **** POST THE CHARGES

                        // ** MAKE AN ENTRY IN THE TRANSACTIONS TABLE FOR POSTING
                        CloudPESATrans.Init;
                        CloudPESATrans."Document No" := referenceNumber;
                        CloudPESATrans.Description := 'Ministatement';
                        CloudPESATrans."Document Date" := transactionDate;// TODAY;
                        CloudPESATrans."Transaction Time" := Dt2Time(transactionTime);
                        CloudPESATrans."Account No" := vendorTable."No.";
                        CloudPESATrans.Charge := MobileCharges + CloudPESACharge + exciseDutyAmount;// ** TotalCharges; //** exclude excise duty which will be recomputed when posting
                        CloudPESATrans."Account Name" := vendorTable.Name;
                        CloudPESATrans."Telephone Number" := vendorTable."Mobile Phone No";
                        CloudPESATrans."Account No2" := '';
                        CloudPESATrans.Amount := 0;//amount;
                        CloudPESATrans.Posted := false;
                        //CloudPESATrans."Posting Date":=TODAY;
                        CloudPESATrans.Status := CloudPESATrans.Status::Completed;
                        CloudPESATrans.Comments := 'Completed';
                        CloudPESATrans.Client := vendorTable."BOSA Account No";
                        CloudPESATrans."Transaction Type" := CloudPESATrans."transaction type"::Ministatement;
                        //CloudPESATrans."Transaction Time":=TIME;
                        CloudPESATrans.Insert;
                    end;

                end else begin
                    response := '3|INSUFFICIENT|' + Format(Today) + '|~|0;';
                end;

            end else begin
                response += '1|ACCNOTFOUND|' + Format(Today) + '|~|0;';
            end;
        end;
    end;


    procedure WithdrawRequest(account: Text[30]; amount: Decimal; traceid: Text[30]; telephone: Text[30]; transactionDate: Date; transactionTime: DateTime) response: Text[1024]
    var
        BufferTable: Record "ATM Transactions";
    begin
        response := '2|ERROR'; // ** DEFAULT, INCASE NOT ERROR OCCURED

        BufferTable.SetRange(BufferTable."Trace ID", traceid);
        BufferTable.SetRange(BufferTable.Posted, false);
        if BufferTable.Find('-') then begin
            // ** IF IT EXISTS RETURN
            response := '1|EXISTS';
        end else begin
            BufferTable.Init;
            BufferTable."Trace ID" := traceid;
            BufferTable."Account No" := account;
            BufferTable."Posting Date" := Today;
            BufferTable.Description := 'Withdrawal - ' + telephone;
            BufferTable.Amount := amount;
            BufferTable."Unit ID" := 'MPESA';
            BufferTable."Transaction Type" := 'Withdrawal';
            BufferTable."Transaction Date" := transactionDate; //TODAY;
            BufferTable."Transaction Time" := Dt2Time(transactionTime);
            BufferTable.Source := BufferTable.Source::Mobile;

            BufferTable.Insert;
            response := '0|SUCCESS';
        end;
    end;


    procedure WithdrawDecline(traceid: Text[30]; transactionDate: Date) response: Text[1024]
    var
        BufferTable: Record "ATM Transactions";
    begin
        response := '1|ERROR|' + traceid; // ** DEFAULT, INCASE NOT ERROR OCCURED

        BufferTable.SetRange(BufferTable."Trace ID", traceid);
        BufferTable.SetRange(BufferTable.Posted, false);
        if BufferTable.Find('-') then begin
            BufferTable.Posted := true;
            BufferTable."Posting Date" := transactionDate;
            BufferTable.Modify;
            response := '0|SUCCESS|' + traceid;
        end else begin
            response := '2|TRANSNOTFOUND|' + traceid;
        end;
    end;


    procedure WithdrawCommit(documentNo: Text[20]; traceid: Text[30]; telephoneNo: Text[20]; account: Text[20]; amount: Decimal; corporatecharges: Decimal; charges: Decimal; transactionDate: Date; transactionTime: DateTime; appType: Code[100]; description: Text[100]; mpesanames: Text[200]) response: Text[1024]
    var
        BufferTable: Record "ATM Transactions";
        cloudpesaTransTable: Record "CloudPESA Transactions";
    begin
        response := '1|ERROR|' + traceid; // ** DEFAULT, INCASE NOT ERROR OCCURED

        cloudpesaTransTable.Reset;
        cloudpesaTransTable.SetRange(cloudpesaTransTable."Document No", documentNo);
        //CloudPESATrans.SETRANGE(CloudPESATrans.Description,Description);
        if cloudpesaTransTable.Find('-') then begin
            // ** IF IT EXISTS RETURN
            response := '1|EXISTS';
        end else begin
            cloudpesaTransTable.Init;
            cloudpesaTransTable."Document No" := documentNo;
            cloudpesaTransTable.traceid := traceid;
            cloudpesaTransTable.Description := description;
            cloudpesaTransTable."Telephone Number" := telephoneNo;
            cloudpesaTransTable."Account No" := account;
            cloudpesaTransTable.Amount := amount;
            cloudpesaTransTable.Charge := charges;
            cloudpesaTransTable."Transaction Type" := cloudpesaTransTable."transaction type"::Withdrawal;
            cloudpesaTransTable."Document Date" := transactionDate;
            cloudpesaTransTable."Transaction Time" := Dt2Time(transactionTime);
            cloudpesaTransTable."Account Name" := mpesanames;
            cloudpesaTransTable.Posted := false;
            cloudpesaTransTable.Insert;

            response := '0|SUCCESS';
        end;
    end;


    procedure ProcessWithdrawals()
    var
        cloudpesaTranTable: Record "CloudPESA Transactions";
    begin
        cloudpesaTranTable.Reset;
        cloudpesaTranTable.SetRange(Posted, false);
        cloudpesaTranTable.SetRange(cloudpesaTranTable.Status, cloudpesaTranTable.Status::Pending);
        cloudpesaTranTable.SetRange(cloudpesaTranTable."Transaction Type", cloudpesaTranTable."transaction type"::Withdrawal);
        //  cloudpesaTranTable.SETRANGE("Document No",'QBN9M2BTOB');
        if cloudpesaTranTable.Find('-') then begin
            repeat
                PostWithdrawalTransaction(cloudpesaTranTable."Document No"
                                          , cloudpesaTranTable."Account No"
                                          , cloudpesaTranTable."Telephone Number"
                                          , cloudpesaTranTable.Amount
                                          , cloudpesaTranTable."Document Date");
            until cloudpesaTranTable.Next = 0;
        end;
    end;

    local procedure PostWithdrawalTransaction(docNo: Text[20]; accountno: Code[20]; telephoneNo: Text[20]; amount: Decimal; transactionDate: Date) result: Text[30]
    var
        exciseDutyAmount: Decimal;
        bufferTable: Record "ATM Transactions";
    begin

        CloudPESATrans.Reset;
        CloudPESATrans.SetRange(CloudPESATrans."Document No", docNo);
        if CloudPESATrans.Find('-') then begin

            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;
            // GenLedgerSetup.TESTFIELD(GenLedgerSetup."Mobile Charge");
            GenLedgerSetup.TestField(GenLedgerSetup."MPESA Settl Acc");
            GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
            /*
            // GenLedgerSetup.TESTFIELD(GenLedgerSetup."CloudPESA Charge");
            Charges.RESET;
            Charges.SETRANGE(Charges.Code,GenLedgerSetup."Mobile Charge");
            IF Charges.FIND('-') THEN BEGIN
            Charges.TESTFIELD(Charges."GL Account");
            END;
            */
            MPESACharge := GetCharge(amount, 'MPESA');
            CloudPESACharge := GetCharge(amount, 'VENDWD');
            MobileCharges := GetCharge(amount, 'SACCOWD');

            CloudPESACommACC := GenLedgerSetup."CloudPESA Comm Acc";
            MPESARecon := GenLedgerSetup."MPESA Settl Acc";
            MobileChargesACC := '10321';//Charges."GL Account";

            SaccoGenSetup.Reset;
            SaccoGenSetup.Get;
            exciseDutyAmount := (SaccoGenSetup."Excise Duty(%)" / 100) * (MobileCharges);
            TotalCharges := CloudPESACharge + MobileCharges + MPESACharge;

            Vendor.Reset;
            Vendor.SetRange(Vendor."No.", accountno);
            if Vendor.Find('-') then begin
                Vendor.CalcFields(Vendor."Balance (LCY)");
                Vendor.CalcFields(Vendor."ATM Transactions");
                Vendor.CalcFields(Vendor."Uncleared Cheques");
                Vendor.CalcFields(Vendor."EFT Transactions");
                //  Vendor.CALCFIELDS(Vendor."Mobile Transactions");
                TempBalance := Vendor."Balance (LCY)";
                if (TempBalance > 0) then begin
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'MPESAWITHD');
                    GenJournalLine.DeleteAll;
                    //end of deletion
                    //c
                    GenBatches.Reset;
                    GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                    GenBatches.SetRange(GenBatches.Name, 'MPESAWITHD');

                    if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name" := 'GENERAL';
                        GenBatches.Name := 'MPESAWITHD';
                        GenBatches.Description := 'MPESA Withdrawal';
                        GenBatches.Validate(GenBatches."Journal Template Name");
                        GenBatches.Validate(GenBatches.Name);
                        GenBatches.Insert;
                    end;

                    //DR Customer Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := Vendor."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := Vendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'MPESA withdrawal to ' + Vendor."Mobile Phone No";
                    GenJournalLine.Amount := amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Dr Withdrawal Charges
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := Vendor."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := Vendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'MPESA withdrawal Charges';
                    GenJournalLine.Amount := TotalCharges;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Cr MPESA ACC
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := MPESARecon;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := Vendor."No.";
                    GenJournalLine."Source No." := Vendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'MPESA withdrawal ' + Vendor."No.";
                    GenJournalLine.Amount := (amount) * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Cr MPESA ACC charges
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := MPESARecon;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := Vendor."No.";
                    GenJournalLine."Source No." := Vendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'withdrawal charges ' + Vendor."No.";
                    GenJournalLine.Amount := (MPESACharge) * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //DR Excise Duty
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := Vendor."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := Vendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'MPESA withdawal Excise Duty';
                    GenJournalLine.Amount := exciseDutyAmount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //CR Excise Duty
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := SaccoGenSetup."Excise Duty Account";//FORMAT(ExxcDuty);
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := MobileChargesACC;
                    GenJournalLine."Source No." := Vendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'MPESA Withdrawal Excise Duty';
                    GenJournalLine.Amount := exciseDutyAmount * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //CR Mobile Transactions Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := MobileChargesACC;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := MobileChargesACC;
                    GenJournalLine."Source No." := Vendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Withdrawal Charges';
                    GenJournalLine.Amount := MobileCharges * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //CR Surestep Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := CloudPESACommACC;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := MobileChargesACC;
                    GenJournalLine."Source No." := Vendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Withdrawal vendor Charges';
                    GenJournalLine.Amount := -CloudPESACharge;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Post
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'MPESAWITHD');
                    if GenJournalLine.Find('-') then begin
                        repeat
                            GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'MPESAWITHD');
                        GenJournalLine.DeleteAll;

                        msg := 'You have withdrawn KES ' + Format(amount) + ' from Account ' + Vendor.Name +
                                ' .Thank you for using ACUMEN Sacco Mobile.';

                        CloudPESATrans."SMS Message" := msg;
                        CloudPESATrans.Status := CloudPESATrans.Status::Completed;
                        CloudPESATrans.Posted := true;
                        CloudPESATrans."Posting Date" := Today;
                        CloudPESATrans.Comments := 'OK';
                        CloudPESATrans.Modify;

                        bufferTable.Reset;
                        bufferTable.SetRange("Trace ID", CloudPESATrans.traceid);
                        if bufferTable.Find('-') then begin
                            bufferTable.Posted := true;
                            bufferTable."Posting Date" := Today;
                            bufferTable.Modify;
                        end;

                        result := 'OK';

                        SMSMessage(docNo, Members."No.", Vendor."Mobile Phone No", msg, '');
                    end;

                end else begin
                    result := 'INSUFFICIENT';
                    CloudPESATrans.Status := CloudPESATrans.Status::Failed;
                    CloudPESATrans.Posted := false;
                    CloudPESATrans."Posting Date" := Today;
                    CloudPESATrans.Comments := 'Failed,Insufficient Funds';
                    CloudPESATrans."Transaction Time" := Time;
                    CloudPESATrans.Modify;
                end;
            end else begin
                result := 'ACCINEXISTENT';
                CloudPESATrans.Status := CloudPESATrans.Status::Failed;
                CloudPESATrans.Posted := false;
                CloudPESATrans."Posting Date" := Today;
                CloudPESATrans.Comments := 'Failed,Invalid Account';
                CloudPESATrans.Modify;
            end;
        end else begin
            result := 'DOCNUMNOTFOUND';
            CloudPESATrans.Status := CloudPESATrans.Status::Failed;
            CloudPESATrans.Posted := false;
            CloudPESATrans."Posting Date" := Today;
            CloudPESATrans.Comments := 'Failed,Doc Num';
            CloudPESATrans.Modify;
        end;

    end;


    procedure RunPostings(idx: Integer) response: Text[50]
    begin
        //EXIT;
        if (idx = 1) then begin
            ProcessWithdrawals();
        end else
            if (idx = 2) then begin
                //PaybillSwitch();
            end else begin
                ProcessWithdrawals();
            end;

    end;


    procedure MiniStatement(Phone: Code[50]; refno: Code[50]) MiniStmt: Text
    begin

        minimunCount := 1;
        Vendor.Reset;
        Vendor.SetRange(Vendor."Mobile Phone No", Phone);//Vendor.SETRANGE(Vendor."BOSA Account No",FnGetMemberNo(Phone));
        if Vendor.Find('-') then begin
            Vendor.CalcFields(Vendor."Balance (LCY)");
            Vendor.CalcFields(Vendor.Balance);
            VendorLedgEntry.Reset;
            VendorLedgEntry.SetCurrentkey(VendorLedgEntry."Entry No.");
            VendorLedgEntry.Ascending(false);
            VendorLedgEntry.SetFilter(VendorLedgEntry.Description, '<>%1', '*Charges*');
            VendorLedgEntry.SetRange(VendorLedgEntry."Vendor No.", Vendor."No.");
            //VendorLedgEntry.SETFILTER(VendorLedgEntry.Description,'<>*Excise duty*');
            VendorLedgEntry.SetRange(VendorLedgEntry.Reversed, false);
            if VendorLedgEntry.FindSet then begin
                MiniStmt := '';
                repeat
                    VendorLedgEntry.CalcFields(VendorLedgEntry.Amount);
                    amount := VendorLedgEntry.Amount;
                    if amount < 1 then amount := amount * -1;
                    MiniStmt := MiniStmt + Format(VendorLedgEntry."Posting Date") + ':::' + CopyStr(VendorLedgEntry.Description, 1, 25) + ':::' + Format(amount) + '::::';
                    minimunCount := minimunCount + 1;
                    if minimunCount > 5 then exit
                until VendorLedgEntry.Next = 0;
            end;
        end;
    end;


    procedure MiniStatementAPP(Account: Text[20]; SessionID: Text[20]; Phone: Code[20]; MaxNumberOfRows: Integer; AccountType: Code[20]; DateFrom: Date; DateTo: Date) Status: Text
    var
        BosaNUMBER: Code[30];
        AccounType: Code[10];
        msgcount: Text[1000];
    begin

        Vendor.Reset;
        Vendor.SetRange(Vendor."Mobile Phone No", Phone);
        if Vendor.Find('-') then begin

            if Vendor."Account Type" = 'ORDINARY' then begin
                Status := 'SUCCESS';//GenericCharges(Vendor."BOSA Account No",DocNumber,'CPSTMT','Mini Statement',SurePESATrans."Transaction Type"::Ministatement);
            end else begin
                BosaNUMBER := '';//BOSAAccountACC(Vendor."No.");
                Status := 'SUCCESS';//GenericCharges(BosaNUMBER,DocNumber,'CPSTMT','Mini Statement',SurePESATrans."Transaction Type"::Ministatement);
            end;
            if (Status = 'REFEXISTS') or (Status = 'INSUFFICIENT') or (Status = 'ACCNOTFOUND') then begin
                Status := '<Response>';
                Status += '<Status>ERROR</Status>';
                Status += '<StatusDescription>An error occured please try again later</StatusDescription>';
                Status += '<Reference>' + SessionID + '</Reference>';
                Status += '</Response>';
            end
            else begin
                minimunCount := 0;
                if AccountType = 'ACCOUNTS' then begin
                    VendorLedgEntry.Reset;
                    VendorLedgEntry.SetCurrentkey(VendorLedgEntry."Entry No.");
                    VendorLedgEntry.Ascending(false);
                    //VendorLedgEntry.SETFILTER(VendorLedgEntry.Description,'<>%1','*Charges*');
                    VendorLedgEntry.SetRange(VendorLedgEntry."Vendor No.", Account);
                    VendorLedgEntry.SetRange(VendorLedgEntry.Reversed, false);
                    VendorLedgEntry.SetFilter(VendorLedgEntry."Date Filter", Format(DateFrom) + '..' + Format(DateTo));
                    Mrowcount := VendorLedgEntry.Count;
                    if VendorLedgEntry.FindSet then begin
                        Status := '<Response>';
                        repeat
                            VendorLedgEntry.CalcFields(VendorLedgEntry.Amount);
                            amount := VendorLedgEntry.Amount;
                            if amount < 1 then amount := amount * -1;
                            if VendorLedgEntry."Debit Amount" = 0 then AccounType := 'C';
                            if VendorLedgEntry."Credit Amount" = 0 then AccounType := 'D';

                            msgcount := msg + Format(VendorLedgEntry."Posting Date") + ': ' + VendorLedgEntry.Description + ': KES ' + Format(amount) + ', ';

                            Status += '<Transaction>';
                            Status += '<Date>' + Format(VendorLedgEntry."Posting Date") + '</Date>';
                            Status += '<Desc>' + VendorLedgEntry.Description + '</Desc>';
                            Status += '<Amount>' + Format(VendorLedgEntry.Amount * -1) + '</Amount>';
                            Status += '<Reference>' + Format(VendorLedgEntry."Entry No.") + '</Reference>';
                            Status += '<RunningBalance>' + Format(FnGetaccountbal(Account) - amount) + '</RunningBalance>';
                            Status += '</Transaction>';

                            if StrLen(msgcount) <= 250 then begin
                                msg := msgcount;
                            end else begin
                                minimunCount := MaxNumberOfRows;
                            end;
                            minimunCount := minimunCount + 1;
                            if (Mrowcount <= MaxNumberOfRows) and (minimunCount = Mrowcount) then begin
                                Status += '</Response>';
                                exit;
                            end;
                            if minimunCount > MaxNumberOfRows then begin
                                Status += '</Response>';
                                exit;
                            end;
                        until VendorLedgEntry.Next = 0;
                        Status += '</Response>';
                    end;

                end;
                if AccountType = 'ACCOUNTS' then begin
                    minimunCount := 0;
                    msg := '';
                    Status := '<Response>';
                    MemberLedgerEntry.Reset;
                    MemberLedgerEntry.SetCurrentkey(MemberLedgerEntry."Entry No.");
                    MemberLedgerEntry.Ascending(false);
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Account);
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Deposit Contribution");
                    MemberLedgerEntry.SetFilter(MemberLedgerEntry."Date Filter", Format(DateFrom) + '..' + Format(DateTo));
                    Mrowcount := MemberLedgerEntry.Count;
                    if MemberLedgerEntry.Find('-') then begin

                        repeat
                            amount := MemberLedgerEntry.Amount;
                            msgcount := msg + Format(MemberLedgerEntry."Posting Date") + ': ' + MemberLedgerEntry.Description + ': KES ' + Format(amount) + ', ';
                            Status += '<Transaction>';
                            Status += '<Date>' + Format(MemberLedgerEntry."Posting Date") + '</Date>';
                            Status += '<Desc>' + MemberLedgerEntry.Description + '</Desc>';
                            Status += '<Amount>' + Format(MemberLedgerEntry.Amount * -1) + '</Amount>';
                            Status += '<Reference>' + Format(MemberLedgerEntry."Entry No.") + '</Reference>';
                            Status += '<RunningBalance>' + Format(FnGetaccountbal(Account) - amount) + '</RunningBalance>';
                            Status += '</Transaction>';
                            if StrLen(msgcount) <= 250 then begin
                                msg := msgcount;
                            end
                            else begin
                                minimunCount := MaxNumberOfRows;
                            end;
                            minimunCount := minimunCount + 1;
                            if (Mrowcount <= MaxNumberOfRows) and (minimunCount = Mrowcount) then begin
                                Status += '</Response>';
                                exit;
                            end;
                            if minimunCount > MaxNumberOfRows then begin
                                Status += '</Response>';
                                exit;
                            end;

                        until MemberLedgerEntry.Next = 0;
                        //SMSMessage(SessionID,Vendor."No.",Phone,COPYSTR(msg,1,250));
                    end;
                    Status += '</Response>';
                end;
                if AccountType = 'LOANS' then begin
                    Status := '<Response>';
                    minimunCount := 0;
                    MemberLedgerEntry.Reset;
                    MemberLedgerEntry.SetCurrentkey(MemberLedgerEntry."Entry No.");
                    MemberLedgerEntry.Ascending(false);
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No", Account);
                    MemberLedgerEntry.SetFilter(MemberLedgerEntry."Date Filter", Format(DateFrom) + '..' + Format(DateTo));
                    Mrowcount := MemberLedgerEntry.Count;
                    if MemberLedgerEntry.Find('-') then begin
                        repeat

                            LoansRegister.Reset;
                            LoansRegister.Get(Account);
                            LoansRegister.SetRange(LoansRegister."Date filter", 0D, MemberLedgerEntry."Posting Date");
                            LoansRegister.CalcFields(LoansRegister."Oustanding Interest", LoansRegister."Outstanding Balance");
                            amount := MemberLedgerEntry.Amount;
                            msgcount := msg + Format(MemberLedgerEntry."Posting Date") + ': ' + MemberLedgerEntry.Description + ': KES ' + Format(amount) + ', ';
                            Status += '<Transaction>';
                            Status += '<Date>' + Format(MemberLedgerEntry."Posting Date") + '</Date>';
                            Status += '<Desc>' + MemberLedgerEntry.Description + '</Desc>';
                            Status += '<Amount>' + Format(MemberLedgerEntry.Amount * -1) + '</Amount>';
                            Status += '<Reference>' + Format(MemberLedgerEntry."Entry No.") + '</Reference>';
                            Status += '<Balance>' + Format(LoansRegister."Oustanding Interest" + LoansRegister."Outstanding Balance") + '</Balance>';
                            Status += '</Transaction>';
                            if StrLen(msgcount) <= 250 then begin
                                msg := msgcount;
                            end
                            else begin
                                minimunCount := MaxNumberOfRows;
                            end;
                            minimunCount := minimunCount + 1;
                            if (Mrowcount <= MaxNumberOfRows) and (minimunCount = Mrowcount) then begin
                                Status += '</Response>';
                                exit;
                            end;
                            if minimunCount > MaxNumberOfRows then begin
                                Status += '</Response>';
                                exit;
                            end;

                        until MemberLedgerEntry.Next = 0;
                    end;
                    Status += '</Response>';
                end;


            end;
        end;
    end;


    procedure MiniStatementUSSD(Account: Text[20]; SessionID: Text[20]; Phone: Code[20]; MaxNumberOfRows: Integer; AccountType: Code[20]) Status: Code[20]
    var
        BosaNUMBER: Code[30];
        AccounType: Code[10];
        msgcount: Text[1000];
    begin
        Vendor.Reset;
        Vendor.SetRange("Mobile Phone No", Phone);
        if Vendor.Find('-') then begin
            Members.Reset;
            Members.SetRange(Members."No.", Vendor."BOSA Account No");//Members.SETRANGE(Members."No.",FnGetMemberNo(Phone));
            if Members.Find('-') then begin

                if Members.Blocked = Members.Blocked::" " then begin
                    Status := 'True';//GenericCharges(Vendor."BOSA Account No",DocNumber,'CPSTMT','Mini Statement',SurePESATrans."Transaction Type"::Ministatement);
                end else begin
                    Status := 'True';//GenericCharges(BosaNUMBER,DocNumber,'CPSTMT','Mini Statement',SurePESATrans."Transaction Type"::Ministatement);
                end;

                if (Status = 'REFEXISTS') or (Status = 'INSUFFICIENT') or (Status = 'ACCNOTFOUND') then begin
                    Status := Status;
                end else begin
                    minimunCount := 0;
                    if AccountType = 'FOSA' then begin
                        Vendor.Reset;
                        Vendor.SetRange(Vendor."No.", Account);
                        //  Vendor.SETRANGE(Vendor."Account Type",'M-WALLET');
                        if Vendor.Find('-') then begin

                        end;

                        VendorLedgEntry.Reset;
                        VendorLedgEntry.SetCurrentkey(VendorLedgEntry."Entry No.");
                        VendorLedgEntry.Ascending(false);
                        //VendorLedgEntry.SETFILTER(VendorLedgEntry.Description,'<>%1','*Charges*');
                        VendorLedgEntry.SetRange(VendorLedgEntry."Vendor No.", Vendor."No.");
                        VendorLedgEntry.SetRange(VendorLedgEntry.Reversed, false);
                        Mrowcount := VendorLedgEntry.Count;
                        if VendorLedgEntry.FindSet then begin
                            Status := '';
                            repeat
                                VendorLedgEntry.CalcFields(VendorLedgEntry.Amount);
                                amount := VendorLedgEntry.Amount;
                                if amount < 1 then
                                    amount := amount * -1;
                                if VendorLedgEntry."Debit Amount" = 0 then
                                    AccounType := 'C';
                                if VendorLedgEntry."Credit Amount" = 0 then
                                    AccounType := 'D';

                                msgcount := msg + Format(VendorLedgEntry."Posting Date") + ': ' + VendorLedgEntry.Description + ': KES ' + Format(amount) + ', ';
                                if StrLen(msgcount) <= 250 then begin
                                    msg := msgcount;
                                end
                                else begin
                                    minimunCount := MaxNumberOfRows;
                                end;
                                minimunCount := minimunCount + 1;
                                if (Mrowcount <= MaxNumberOfRows) and (minimunCount = Mrowcount) then begin
                                    SMSMessage(SessionID, Vendor."No.", Phone, CopyStr(msg, 1, 250), '');
                                    exit;
                                end;
                                if minimunCount > MaxNumberOfRows then begin
                                    SMSMessage(SessionID, Vendor."No.", Phone, CopyStr(msg, 1, 250), '');
                                    exit;
                                end;
                            until VendorLedgEntry.Next = 0;
                        end;
                    end;

                    if AccountType = 'DEPOSIT' then begin
                        minimunCount := 0;
                        msg := '';
                        MemberLedgerEntry.Reset;
                        MemberLedgerEntry.SetCurrentkey(MemberLedgerEntry."Entry No.");
                        MemberLedgerEntry.Ascending(false);
                        MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Account);
                        MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Deposit Contribution");
                        Mrowcount := MemberLedgerEntry.Count;
                        if MemberLedgerEntry.Find('-') then begin
                            repeat
                                amount := MemberLedgerEntry.Amount;
                                msgcount := msg + Format(MemberLedgerEntry."Posting Date") + ': ' + MemberLedgerEntry.Description + ': KES ' + Format(amount) + ', ';
                                if StrLen(msgcount) <= 250 then begin
                                    msg := msgcount;
                                end else begin
                                    minimunCount := MaxNumberOfRows;
                                end;
                                minimunCount := minimunCount + 1;
                                if (Mrowcount <= MaxNumberOfRows) and (minimunCount = Mrowcount) then begin
                                    SMSMessage(SessionID, Members."No.", Phone, CopyStr(msg, 1, 250), '');
                                    exit;
                                end;
                                if minimunCount > MaxNumberOfRows then begin
                                    SMSMessage(SessionID, Members."No.", Phone, CopyStr(msg, 1, 250), '');
                                    exit;
                                end;

                            until MemberLedgerEntry.Next = 0;
                            //SMSMessage(SessionID,Vendor."No.",Phone,COPYSTR(msg,1,250));
                        end;
                    end;
                    if AccountType = 'SHARES' then begin
                        minimunCount := 0;
                        msg := '';
                        MemberLedgerEntry.Reset;
                        MemberLedgerEntry.SetCurrentkey(MemberLedgerEntry."Entry No.");
                        MemberLedgerEntry.Ascending(false);
                        MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Account);
                        MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Share Capital");
                        Mrowcount := MemberLedgerEntry.Count;
                        if MemberLedgerEntry.Find('-') then begin
                            repeat
                                amount := MemberLedgerEntry.Amount;
                                msgcount := msg + Format(MemberLedgerEntry."Posting Date") + ': ' + MemberLedgerEntry.Description + ': KES ' + Format(amount) + ', ';
                                if StrLen(msgcount) <= 250 then begin
                                    msg := msgcount;
                                end else begin
                                    minimunCount := MaxNumberOfRows;
                                end;
                                minimunCount := minimunCount + 1;
                                if (Mrowcount <= MaxNumberOfRows) and (minimunCount = Mrowcount) then begin
                                    SMSMessage(SessionID, Members."No.", Phone, CopyStr(msg, 1, 250), '');
                                    exit;
                                end;
                                if minimunCount > MaxNumberOfRows then begin
                                    SMSMessage(SessionID, Members."No.", Phone, CopyStr(msg, 1, 250), '');
                                    exit;
                                end;

                            until MemberLedgerEntry.Next = 0;
                            //SMSMessage(SessionID,Vendor."No.",Phone,COPYSTR(msg,1,250));
                        end;
                    end;
                    if AccountType = 'LOAN' then begin
                        minimunCount := 0;
                        MemberLedgerEntry.Reset;
                        MemberLedgerEntry.SetCurrentkey(MemberLedgerEntry."Entry No.");
                        MemberLedgerEntry.Ascending(false);
                        MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No", Account);
                        Mrowcount := MemberLedgerEntry.Count;
                        if MemberLedgerEntry.Find('-') then begin
                            repeat
                                amount := MemberLedgerEntry.Amount;
                                msgcount := msg + Format(MemberLedgerEntry."Posting Date") + ': ' + MemberLedgerEntry.Description + ': KES ' + Format(amount) + ', ';

                                if StrLen(msgcount) <= 250 then begin
                                    msg := msgcount;
                                end
                                else begin
                                    minimunCount := MaxNumberOfRows;
                                end;
                                minimunCount := minimunCount + 1;
                                if (Mrowcount <= MaxNumberOfRows) and (minimunCount = Mrowcount) then begin
                                    SMSMessage(SessionID, Vendor."No.", Phone, CopyStr(msg, 1, 250), '');
                                    exit;
                                end;
                                if minimunCount > MaxNumberOfRows then begin
                                    SMSMessage(SessionID, Vendor."No.", Phone, CopyStr(msg, 1, 250), '');
                                    exit;
                                end;

                            until MemberLedgerEntry.Next = 0;
                        end;
                    end;


                end;
            end;
        end;
    end;


    procedure LoanProducts() LoanTypes: Text[150]
    begin

        LoanProductsSetup.Reset;
        LoanProductsSetup.SetRange(LoanProductsSetup.Source, LoanProductsSetup.Source::FOSA);
        if LoanProductsSetup.Find('-') then begin
            repeat
                LoanTypes := LoanTypes + ':::' + LoanProductsSetup."Product Description";
            until LoanProductsSetup.Next = 0;
        end
    end;


    procedure BOSAAccount(Phone: Text[20]) bosaAcc: Text[20]
    begin

        Vendor.Reset;
        Vendor.SetRange(Vendor."Mobile Phone No", Phone);
        if Vendor.Find('-') then begin
            bosaAcc := Vendor."BOSA Account No";
        end;
    end;


    procedure MemberAccountNumbers(phone: Text[20]) accounts: Text[250]
    var
        vend: Record Vendor;
    begin
        vend.Reset;
        vend.SetRange(vend."Mobile Phone No", phone);
        if vend.Find('-') then begin
            Vendor.Reset;
            Vendor.SetRange(Vendor."BOSA Account No", vend."BOSA Account No");
            if Vendor.Find('-') then begin
                accounts := '';
                repeat
                    accounts := accounts + '::::' + Vendor."No.";
                until Vendor.Next = 0;
            end else begin
                accounts := accounts + '::::' + 'NA';
            end;
        end;
    end;


    procedure RegisteredMemberDetails(Phone: Text[20]) reginfo: Text[250]
    begin
        Vendor.Reset;
        Vendor.SetRange("Mobile Phone No", Phone);
        if Vendor.Find('-') then begin
            Members.Reset;
            Members.SetRange(Members."No.", Vendor."BOSA Account No");
            if Members.Find('-') then begin
                reginfo := Members."No." + ':::' + Members.Name + ':::' + Format(Members."ID No.") + ':::' + Format(Members."Personal No") + ':::' + Members."E-Mail";
            end else begin
                reginfo := '';
            end;
        end;
    end;


    procedure DetailedStatement(Phone: Text[20]; lastEntry: Integer) detailedstatement: Text[1023]
    begin

        dateExpression := '<CD-1M>'; // Current date less 3 months
        dashboardDataFilter := CalcDate(dateExpression, Today);

        detailedstatement := '';
        Vendor.Reset;
        Vendor.SetRange(Vendor."Phone No.", Phone);
        if Vendor.FindSet then begin
            repeat
                minimunCount := 1;
                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                if AccountTypes.FindSet then begin
                    repeat
                        DetailedVendorLedgerEntry.Reset;
                        DetailedVendorLedgerEntry.SetRange(DetailedVendorLedgerEntry."Vendor No.", Vendor."No.");
                        DetailedVendorLedgerEntry.SetFilter(DetailedVendorLedgerEntry."Entry No.", '>%1', lastEntry);
                        DetailedVendorLedgerEntry.SetFilter(DetailedVendorLedgerEntry."Posting Date", '>%1', dashboardDataFilter);
                        if DetailedVendorLedgerEntry.FindSet then begin
                            repeat
                                VendorLedgerEntry.Reset;
                                VendorLedgerEntry.SetRange(VendorLedgerEntry."Entry No.", DetailedVendorLedgerEntry."Vendor Ledger Entry No.");
                                if VendorLedgerEntry.FindSet then begin
                                    if detailedstatement = '' then begin
                                        detailedstatement := Format(DetailedVendorLedgerEntry."Entry No.") + ':::' +
                                        Format(AccountTypes.Description) + ':::' +
                                        Format(DetailedVendorLedgerEntry."Posting Date") + ':::' +
                                        Format((DetailedVendorLedgerEntry."Posting Date"), 0, '<Month Text>') + ':::' +
                                        Format(Date2dmy((DetailedVendorLedgerEntry."Posting Date"), 3)) + ':::' +
                                        Format((DetailedVendorLedgerEntry."Credit Amount"), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
                                        Format((DetailedVendorLedgerEntry."Debit Amount"), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
                                        Format((DetailedVendorLedgerEntry.Amount), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
                                        Format(DetailedVendorLedgerEntry."Journal Batch Name") + ':::' +
                                        Format(DetailedVendorLedgerEntry."Initial Entry Global Dim. 1") + ':::' +
                                        Format(VendorLedgerEntry.Description);
                                    end else begin
                                        repeat
                                            detailedstatement := detailedstatement + '::::' +
                                                                Format(DetailedVendorLedgerEntry."Entry No.") + ':::' +
                                                                Format(AccountTypes.Description) + ':::' +
                                                                Format(DetailedVendorLedgerEntry."Posting Date") + ':::' +
                                                                Format((DetailedVendorLedgerEntry."Posting Date"), 0, '<Month Text>') + ':::' +
                                                                Format(Date2dmy((DetailedVendorLedgerEntry."Posting Date"), 3)) + ':::' +
                                                                Format((DetailedVendorLedgerEntry."Credit Amount"), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
                                                                Format((DetailedVendorLedgerEntry."Debit Amount"), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
                                                                Format((DetailedVendorLedgerEntry.Amount), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
                                                                Format(DetailedVendorLedgerEntry."Journal Batch Name") + ':::' +
                                                                Format(DetailedVendorLedgerEntry."Initial Entry Global Dim. 1") + ':::' +
                                                                Format(VendorLedgerEntry.Description);
                                            if minimunCount > 20 then exit;
                                        until VendorLedgerEntry.Next = 0;
                                    end;
                                end;
                            until DetailedVendorLedgerEntry.Next = 0;
                        end;
                    until AccountTypes.Next = 0;
                end;
            until Vendor.Next = 0;
        end;
    end;


    procedure MemberAccountNames(phone: Text[20]) accounts: Text[250]
    begin
        Vendor.Reset;
        Vendor.SetRange("Mobile Phone No", phone);
        if Vendor.Find('-') then begin
            //    Members.RESET;
            //    Members.SETRANGE(Members."No.",FnGetMemberNo(phone));
            //    Members.SETRANGE(Members.Status, Members.Status::Active);
            //    IF Members.FIND('-') THEN BEGIN
            //      accounts:='';
            //      REPEAT
            //        accounts:=accounts+'::::Mobile Wallet';
            //      UNTIL Members.NEXT =0;
            //    END  ELSE  BEGIN
            //      accounts:='';
            //    END;


            accounts := '';
            repeat
                accounts := Vendor.Name + accounts;
            until Vendor.Next = 0;

        end else begin
            accounts := '';
        end;
    end;


    procedure LoanBalances(phone: Text[20]; Ref: Text; AppType: Code[50]) loanbalances: Text[700]
    begin

        Vendor.Reset;
        Vendor.SetRange(Vendor."Mobile Phone No", phone);
        Vendor.SetRange(Vendor.Status, Vendor.Status::Active);
        if Vendor.Find('-') then begin

            LoansTable.Reset;
            LoansTable.SetRange(LoansTable."Client Code", Vendor."BOSA Account No");
            if LoansTable.Find('-') then begin
                repeat
                    LoansTable.CalcFields(LoansTable."Outstanding Balance", LoansTable."Oustanding Interest", LoansTable."Interest to be paid", LoansTable."Interest Paid");
                    if (LoansTable."Outstanding Balance" > 0) then begin
                        loanbalances := loanbalances
                              + '::::' + LoansTable."Loan  No."
                              + ':::' + Format(LoansTable."Loan Product Type Name")
                              + ':::' + Format(LoansTable."Outstanding Balance")
                              + ':::' + Format(LoansTable."Oustanding Interest");
                        msg := msg + Format(LoansTable."Loan  No.")
                                      + ': ' + Format(LoansTable."Loan Product Type Name")
                                      + ': KES ' + Format(LoansTable."Oustanding Interest" + LoansTable."Outstanding Balance") + ', ';
                    end;
                until LoansTable.Next = 0;

                //IF AppType='USSD' THEN BEGIN
                SMSMessage(Ref, Vendor."BOSA Account No", phone, CopyStr(msg, 1, 250), '');
                //END;

            end;
        end;

    end;


    procedure MemberAccounts(phone: Text[20]) accounts: Text[250]
    begin

        //  Members.RESET;
        //  Members.SETRANGE(Members."No.",FnGetMemberNo(phone));
        //  Members.SETRANGE(Members.Status, Members.Status::Active);
        //  Members.SETRANGE(Members.Blocked, Members.Blocked::" ");
        //  IF Members.FIND('-') THEN BEGIN

        Vendor.Reset;
        Vendor.SetRange(Vendor."Mobile Phone No", phone);//Vendor.SETRANGE(Vendor."BOSA Account No", Members."No.");
        Vendor.SetRange(Vendor.Status, Vendor.Status::Active);
        if Vendor.Find('-') then begin
            repeat
                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                if AccountTypes.Find('-') then begin
                    if ((Vendor."Account Type" = '100')
                      or (Vendor."Account Type" = '200')) then begin
                        accounts := accounts + Vendor."No." + ':::' + AccountTypes.Description + ':::4::::';
                    end;
                end;
            until Vendor.Next = 0;

        end else begin
            accounts := '';
        end;


        //  END  ELSE  BEGIN
        //     accounts:='';
        //  END;
    end;


    procedure SurePESARegistration() memberdetails: Text[1000]
    begin
        memberdetails := '2|ERROR|~|~|~|1;';
        SurePESAApplications.Reset;
        SurePESAApplications.SetRange(SurePESAApplications.SentToServer, false);
        SurePESAApplications.SetRange(SurePESAApplications."PIN Requested", true);
        if SurePESAApplications.Find('-') then begin
            memberdetails := '';
            repeat
                //memberdetails:=memberdetails+SurePESAApplications."Account No"+':::'+SurePESAApplications.Telephone+':::'+SurePESAApplications."ID No"+':::1::::';
                memberdetails := memberdetails + '0|OK|' + SurePESAApplications."Account No" + '|' + SurePESAApplications.Telephone + '|' + SurePESAApplications."ID No" + '|1;';
            until SurePESAApplications.Next = 0;
        end else begin
            memberdetails := '1|NODATA|~|~|~|1;';
        end;
    end;


    procedure UpdateSurePESARegistration(accountNo: Text[30]) result: Text[10]
    begin

        SurePESAApplications.Reset;
        SurePESAApplications.SetRange(SurePESAApplications.SentToServer, false);
        SurePESAApplications.SetRange(SurePESAApplications."Account No", accountNo);
        if SurePESAApplications.Find('-') then begin
            SurePESAApplications.SentToServer := true;
            SurePESAApplications."PIN Requested" := false;
            SurePESAApplications.Modify;
            result := 'Modified';
        end else begin
            result := 'Failed';
        end;
    end;


    procedure FundsTransferFOSA(accFrom: Text[20]; accTo: Text[20]; DocNumber: Text[30]; amount: Decimal) result: Text[30]
    var
        exciseDutyAccount: Text[50];
        exciseDutyAmount: Decimal;
    begin

        SurePESATrans.Reset;
        SurePESATrans.SetRange(SurePESATrans."Document No", DocNumber);
        if SurePESATrans.Find('-') then begin
            result := 'REFEXISTS';
        end else begin

            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;
            GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");
            GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
            GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

            Charges.Reset;
            Charges.SetRange(Charges.Code, GenLedgerSetup."Mobile FOSA transfer fee");
            if Charges.Find('-') then begin
                Charges.TestField(Charges."GL Account");
                MobileCharges := Charges."Charge Amount";
                MobileChargesACC := Charges."GL Account";
            end;

            SaccoGenSetup.Reset;
            SaccoGenSetup.Get;

            SurePESACommACC := GenLedgerSetup."CloudPESA Comm Acc";
            SurePESACharge := GenLedgerSetup."CloudPESA Charge";

            exciseDutyAccount := SaccoGenSetup."Excise Duty Account";
            exciseDutyAmount := (SaccoGenSetup."Excise Duty(%)" / 100) * MobileCharges;

            Vendor.Reset;
            Vendor.SetRange(Vendor."No.", accFrom);
            if Vendor.Find('-') then begin
                Vendor.CalcFields(Vendor."Balance (LCY)");
                TempBalance := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions");

                if Vendor.Get(accTo) then begin

                    if (TempBalance > amount + MobileCharges + SurePESACharge + exciseDutyAmount) then begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                        GenJournalLine.DeleteAll;
                        //end of deletion

                        GenBatches.Reset;
                        GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                        GenBatches.SetRange(GenBatches.Name, 'MOBILETRAN');

                        if GenBatches.Find('-') = false then begin
                            GenBatches.Init;
                            GenBatches."Journal Template Name" := 'GENERAL';
                            GenBatches.Name := 'MOBILETRAN';
                            GenBatches.Description := 'SUREPESA Tranfers';
                            GenBatches.Validate(GenBatches."Journal Template Name");
                            GenBatches.Validate(GenBatches.Name);
                            GenBatches.Insert;
                        end;

                        //DR ACC 1
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := accFrom;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := accFrom;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Mobile Transfer';
                        GenJournalLine.Amount := amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //Dr Transfer Charges
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := accFrom;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := accFrom;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Mobile Transfer Charges';
                        GenJournalLine.Amount := (MobileCharges) + SurePESACharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;


                        //DR Excise Duty
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := accFrom;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := accFrom;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Excise duty-Mobile Transfer';
                        GenJournalLine.Amount := exciseDutyAmount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := exciseDutyAccount;//FORMAT('200-000-3016');
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := MobileChargesACC;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Excise duty-Mobile Transfer';
                        GenJournalLine.Amount := exciseDutyAmount * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //CR Mobile Transactions Acc
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := MobileChargesACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := MobileChargesACC;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Mobile Transfer Charges';
                        GenJournalLine.Amount := (MobileCharges) * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //CR Commission
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := SurePESACommACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := MobileChargesACC;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Mobile Transfer Charges';
                        GenJournalLine.Amount := -SurePESACharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //CR ACC2
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := accTo;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := accTo;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Mobile Transfer from ' + accFrom;
                        GenJournalLine.Amount := -amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                        if GenJournalLine.Find('-') then begin
                            repeat
                                GLPosting.Run(GenJournalLine);
                            until GenJournalLine.Next = 0;
                        end;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                        GenJournalLine.DeleteAll;

                        SurePESATrans.Init;
                        SurePESATrans."Document No" := DocNumber;
                        SurePESATrans."Telephone Number" := Vendor."Mobile Phone No";
                        SurePESATrans.Description := 'Mobile Transfer';
                        SurePESATrans."Document Date" := Today;
                        SurePESATrans."Account No" := accFrom;
                        SurePESATrans."Account No2" := accTo;
                        SurePESATrans.Amount := amount;
                        SurePESATrans.Posted := true;
                        SurePESATrans."Posting Date" := Today;
                        SurePESATrans.Status := SurePESATrans.Status::Completed;
                        SurePESATrans.Comments := 'Success';
                        SurePESATrans.Client := Vendor."BOSA Account No";
                        SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::"Transfer to Fosa";
                        SurePESATrans."Transaction Time" := Time;
                        SurePESATrans.Insert;
                        result := 'TRUE';
                        accountName1 := Vendor.Name;
                        Vendor.Reset();
                        Vendor.SetRange(Vendor."No.", accTo);
                        if Vendor.Find('-') then begin
                            accountName2 := Vendor.Name;
                        end;


                        msg := 'You have transfered KES ' + Format(amount) + ' from Account ' + accountName1 + ' to ' + accountName2 +
                                  ' .Thank you for using ACUMEN SACCO Mobile.';
                        SMSMessage(DocNumber, accFrom, Vendor."Mobile Phone No", msg, '');

                    end else begin
                        result := 'INSUFFICIENT';
                        msg := 'You have insufficient funds in your savings Account to use this service.' +
                                  ' .Thank you for using ACUMEN SACCO Mobile.';
                        SMSMessage(DocNumber, accFrom, Vendor."Mobile Phone No", msg, '');
                    end;

                end else begin
                    result := 'ACC2INEXISTENT';
                    msg := 'Your request has failed because the recipient account does not exist.' +
                                ' .Thank you for using ACUMEN SACCO Mobile.';
                    SMSMessage(DocNumber, accFrom, Vendor."Mobile Phone No", msg, '');
                end;
            end else begin
                result := 'ACCINEXISTENT';
                msg := 'Your request has failed because the recipient account does not exist.' +
                            ' .Thank you for using ACUMEN SACCO Mobile.';
                SMSMessage(DocNumber, accFrom, Vendor."Mobile Phone No", msg, '');
            end;
        end;
    end;


    procedure FundsTransferBOSA(accFrom: Text[20]; accTo: Text[20]; DocNumber: Text[30]; amount: Decimal) result: Text[30]
    var
        exciseDutyAmount: Decimal;
        exciseDutyAccount: Text[50];
    begin

        SurePESATrans.Reset;
        SurePESATrans.SetRange(SurePESATrans."Document No", DocNumber);
        if SurePESATrans.Find('-') then begin
            result := 'REFEXISTS';
        end else begin

            Vendor.Reset;
            Vendor.SetRange(Vendor."No.", accFrom);
            if Vendor.Find('-') then begin


                GenLedgerSetup.Reset;
                GenLedgerSetup.Get;
                //  GenLedgerSetup.TESTFIELD(GenLedgerSetup."Mobile Charge");
                //  GenLedgerSetup.TESTFIELD(GenLedgerSetup."CloudPESA Comm Acc");
                //  GenLedgerSetup.TESTFIELD(GenLedgerSetup."CloudPESA Charge");

                Charges.Reset;
                Charges.SetRange(Charges.Code, GenLedgerSetup."Mobile FOSA-BOSA transfer fee");
                if Charges.Find('-') then begin
                    Charges.TestField(Charges."GL Account");
                    MobileCharges := Charges."Charge Amount";
                    MobileChargesACC := Charges."GL Account";
                end;

                SurePESACommACC := GenLedgerSetup."CloudPESA Comm Acc";
                SurePESACharge := GenLedgerSetup."CloudPESA Charge";

                SaccoGenSetup.Reset;
                SaccoGenSetup.Get;
                exciseDutyAccount := SaccoGenSetup."Excise Duty Account";
                exciseDutyAmount := (SaccoGenSetup."Excise Duty(%)" / 100) * MobileCharges;


                Vendor.CalcFields(Vendor."Balance (LCY)");
                TempBalance := Vendor."Balance (LCY)";



                if (accTo = 'Shares Capital') or (accTo = 'Deposit Contribution') or (accTo = 'Benevolent Fund') then begin
                    if (TempBalance > (amount + MobileCharges + SurePESACharge + exciseDutyAmount)) then begin

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                        GenJournalLine.DeleteAll;
                        //end of deletion

                        GenBatches.Reset;
                        GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                        GenBatches.SetRange(GenBatches.Name, 'MOBILETRAN');

                        if GenBatches.Find('-') = false then begin
                            GenBatches.Init;
                            GenBatches."Journal Template Name" := 'GENERAL';
                            GenBatches.Name := 'MOBILETRAN';
                            GenBatches.Description := 'SUREPESA Tranfers';
                            GenBatches.Validate(GenBatches."Journal Template Name");
                            GenBatches.Validate(GenBatches.Name);
                            GenBatches.Insert;
                        end;

                        //DR ACC 1
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := accFrom;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := accFrom;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Mobile Transfer to ' + accTo;
                        GenJournalLine.Amount := amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //Dr Transfer Charges
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := accFrom;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := accFrom;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Mobile Transfer Charges';
                        GenJournalLine.Amount := (MobileCharges) + SurePESACharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;


                        //DR Excise Duty
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := accFrom;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := accFrom;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Excise duty-Mobile Transfer';
                        GenJournalLine.Amount := exciseDutyAmount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := exciseDutyAccount;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := MobileChargesACC;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Excise duty-Mobile Transfer';
                        GenJournalLine.Amount := exciseDutyAmount * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //CR Mobile Transactions Acc
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := MobileChargesACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := MobileChargesACC;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Mobile Transfer Charges';
                        GenJournalLine.Amount := (MobileCharges) * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //CR Commission
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := SurePESACommACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := MobileChargesACC;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Mobile Transfer Charges';
                        GenJournalLine.Amount := -SurePESACharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //CR ACC2
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                        GenJournalLine."Account No." := Vendor."BOSA Account No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := Vendor."No.";
                        GenJournalLine."Posting Date" := Today;

                        if (accTo = 'Deposit Contribution') or (accTo = '') then begin
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                        end;
                        if accTo = 'Shares Capital' then begin
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                        end;
                        if accTo = 'Benevolent Fund' then begin
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Benevolent Fund";

                            GenJournalLine.Description := 'Mobile Transfer from ' + accFrom;
                        end;
                        //          GenJournalLine."Shortcut Dimension 1 Code":='RONGAI';
                        //          GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine.Amount := -amount;
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                        if GenJournalLine.Find('-') then begin
                            repeat
                                GLPosting.Run(GenJournalLine);
                            until GenJournalLine.Next = 0;
                        end;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                        GenJournalLine.DeleteAll;

                        SurePESATrans.Init;
                        SurePESATrans."Document No" := DocNumber;
                        SurePESATrans.Description := 'Mobile Transfer';
                        SurePESATrans."Telephone Number" := Vendor."Mobile Phone No";
                        SurePESATrans."Document Date" := Today;
                        SurePESATrans."Account No" := accFrom;
                        SurePESATrans."Account Name" := Vendor.Name;
                        SurePESATrans."Account No2" := accTo;
                        SurePESATrans.Amount := amount;
                        SurePESATrans.Posted := true;
                        SurePESATrans."Posting Date" := Today;
                        SurePESATrans.Status := SurePESATrans.Status::Completed;
                        SurePESATrans.Comments := 'Success';
                        SurePESATrans.Client := Vendor."BOSA Account No";
                        SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::"Transfer to Fosa";
                        SurePESATrans."Transaction Time" := Time;
                        SurePESATrans.Insert;

                        result := 'TRUE';

                        msg := 'You have transfered KES ' + Format(amount) + ' from Account Name ' + Vendor.Name + ': A/C No: ' + Vendor."No." + ' to ' + accTo +
                                    ' .Thank you for ACUMEN Sacco Mobile.';
                        SMSMessage(DocNumber, accFrom, Vendor."Mobile Phone No", msg, '');

                    end else begin
                        result := 'INSUFFICIENT';
                        msg := 'You have insufficient funds in your savings Account to use this service.' +
                                    '. Thank you for using ACUMEN Sacco Mobile.';
                        SMSMessage(DocNumber, accFrom, Vendor."Mobile Phone No", msg, '');
                    end;

                end else begin
                    result := 'ACCINEXISTENT';
                    msg := 'Your request has failed because the recipent account does not exist.' +
                                '. Thank you for using ACUMEN Sacco  Mobile.';
                    SMSMessage(DocNumber, accFrom, Vendor."Mobile Phone No", msg, '');
                end;

            end else begin
                result := 'MEMBERINEXISTENT';
                msg := 'Your request has failed because the recipent account does not exist.' +
                          '. Thank you for using ACUMEN Sacco Mobile.';
                SMSMessage(DocNumber, accFrom, Vendor."Mobile Phone No", msg, '');
            end;

        end;
    end;


    procedure WSSAccount(phone: Text[20]) accounts: Text[250]
    begin

        Vendor.Reset;
        Vendor.SetRange(Vendor."Mobile Phone No", phone);//Vendor.SETRANGE(Vendor."BOSA Account No", Members."No.");
        Vendor.SetRange(Vendor.Status, Vendor.Status::Active);
        if Vendor.Find('-') then begin
            repeat
                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                if AccountTypes.Find('-') then begin
                    if ((Vendor."Account Type" = '100')
                      or (Vendor."Account Type" = '200')) then begin
                        accounts := accounts + Vendor."No." + ':::' + AccountTypes.Description + ':::4::::';
                    end;
                end;
            until Vendor.Next = 0;
        end else begin
            accounts := '';
        end;
    end;


    procedure SMSMessagetest(documentNo: Text[30]; accfrom: Text[30]; phone: Text[20]; message: Text[250]; addition: Text[250])
    begin
        iEntryNo := 0;
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Batch No" := documentNo;
        SMSMessages."Document No" := documentNo;
        SMSMessages."Account No" := accfrom;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'TESTAUTO';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := message;
        //SMSMessages."Additional sms":=addition;
        SMSMessages."Telephone No" := phone;
        if SMSMessages."Telephone No" <> '' then
            SMSMessages.Insert;
    end;


    procedure SMSMessage(documentNo: Text[30]; accfrom: Text[30]; phone: Text[20]; message: Text[250]; addition: Text[250])
    begin
        iEntryNo := 0;
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end else begin
            iEntryNo := 1;
        end;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Batch No" := documentNo;
        SMSMessages."Document No" := documentNo;
        SMSMessages."Account No" := accfrom;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'MOBILETRAN';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := message;
        ///SMSMessages."Additional sms":=addition;
        SMSMessages."Telephone No" := phone;
        if SMSMessages."Telephone No" <> '' then
            SMSMessages.Insert;
    end;


    procedure LoanRepayment(accFrom: Text[20]; loanNo: Text[20]; DocNumber: Text[30]; amount: Decimal) result: Text[30]
    var
        exciseDutyAccount: Text[20];
        exciseDutyAmount: Decimal;
        amountPaid: Decimal;
    begin

        SurePESATrans.Reset;
        SurePESATrans.SetRange(SurePESATrans."Document No", DocNumber);
        if SurePESATrans.Find('-') then begin
            result := 'REFEXISTS';
        end else begin
            amountPaid := amount;

            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;
            //GenLedgerSetup.TESTFIELD(GenLedgerSetup."Sacco Charge Account");
            GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
            GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");


            Charges.Reset;
            Charges.SetRange(Charges.Code, GenLedgerSetup."Mobile Loanrepayment fee");
            if Charges.Find('-') then begin
                Charges.TestField(Charges."GL Account");
                MobileCharges := Charges."Sacco Amount";
                MobileChargesACC := Charges."GL Account";
            end;


            //MobileCharges:=0;//=Charges."Charge Amount";
            //MobileChargesACC:=(GenLedgerSetup."Sacco Charge Account");//Charges."GL Account";


            SurePESACommACC := GenLedgerSetup."CloudPESA Comm Acc";
            SurePESACharge := GenLedgerSetup."CloudPESA Charge";

            SaccoGenSetup.Reset;
            SaccoGenSetup.Get;
            exciseDutyAccount := SaccoGenSetup."Excise Duty Account";
            exciseDutyAmount := (SaccoGenSetup."Excise Duty(%)" / 100) * MobileCharges;


            Vendor.Reset;
            Vendor.SetRange(Vendor."No.", accFrom);
            if Vendor.Find('-') then begin

                Vendor.CalcFields(Vendor."Balance (LCY)", Vendor."ATM Transactions");
                TempBalance := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions");

                LoansRegister.Reset;
                LoansRegister.SetRange(LoansRegister."Loan  No.", loanNo);
                //    LoansRegister.SETRANGE(LoansRegister."Client Code",Members."No.");
                if LoansRegister.Find('-') then begin

                    LoansRegister.CalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
                    if (TempBalance > amount + MobileCharges + SurePESACharge + exciseDutyAmount) then begin

                        if LoansRegister."Outstanding Balance" > 0 then begin
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                            GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                            GenJournalLine.DeleteAll;
                            //end of deletion

                            GenBatches.Reset;
                            GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                            GenBatches.SetRange(GenBatches.Name, 'MOBILETRAN');

                            if GenBatches.Find('-') = false then begin
                                GenBatches.Init;
                                GenBatches."Journal Template Name" := 'GENERAL';
                                GenBatches.Name := 'MOBILETRAN';
                                GenBatches.Description := 'Mobile Loan Repayment';
                                GenBatches.Validate(GenBatches."Journal Template Name");
                                GenBatches.Validate(GenBatches.Name);
                                GenBatches.Insert;
                            end;

                            //DR ACC 1
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := accFrom;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := DocNumber;
                            GenJournalLine."External Document No." := accFrom;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Mobile Loan Repayment-' + loanNo;
                            GenJournalLine.Amount := amount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //Dr Transfer Charges
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := accFrom;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := DocNumber;
                            GenJournalLine."External Document No." := accFrom;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Mobile Charges-' + loanNo;
                            GenJournalLine.Amount := (MobileCharges) + SurePESACharge;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;


                            //DR Excise Duty
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := accFrom;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := DocNumber;
                            GenJournalLine."External Document No." := accFrom;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Excise duty-Mobile Charges-' + loanNo;
                            GenJournalLine.Amount := exciseDutyAmount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := exciseDutyAccount;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := DocNumber;
                            GenJournalLine."External Document No." := MobileChargesACC;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Excise duty-Mobile Charges-' + loanNo;
                            GenJournalLine.Amount := exciseDutyAmount * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //CR Mobile Transactions Acc
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := MobileChargesACC;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := DocNumber;
                            GenJournalLine."External Document No." := MobileChargesACC;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Mobile Charges-' + loanNo;
                            GenJournalLine.Amount := (MobileCharges) * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //CR Commission
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := SurePESACommACC;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := DocNumber;
                            GenJournalLine."External Document No." := MobileChargesACC;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Mobile Charges-' + loanNo;
                            GenJournalLine.Amount := -SurePESACharge;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            if LoansRegister."Oustanding Interest" > 0 then begin
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := LoansRegister."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := DocNumber;
                                GenJournalLine."External Document No." := '';
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Loan Interest Payment-' + loanNo;


                                if amount > LoansRegister."Oustanding Interest" then
                                    GenJournalLine.Amount := -LoansRegister."Oustanding Interest"
                                else
                                    GenJournalLine.Amount := -amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";

                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                amount := amount + GenJournalLine.Amount;
                            end;


                            if amount > 0 then begin
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := LoansRegister."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := DocNumber;
                                GenJournalLine."External Document No." := '';
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Loan repayment-' + loanNo;
                                GenJournalLine.Amount := -amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                            end;


                            //Post
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                            GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                            if GenJournalLine.Find('-') then begin
                                repeat
                                    GLPosting.Run(GenJournalLine);
                                until GenJournalLine.Next = 0;
                            end;
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                            GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                            GenJournalLine.DeleteAll;

                            SurePESATrans.Init;
                            SurePESATrans."Document No" := DocNumber;
                            SurePESATrans.Description := 'Loan repayment-' + loanNo;
                            SurePESATrans."Document Date" := Today;
                            SurePESATrans."Telephone Number" := Vendor."Mobile Phone No";
                            SurePESATrans."Account No" := accFrom;
                            SurePESATrans."Account No2" := loanNo;
                            SurePESATrans."Account Name" := Vendor.Name;
                            SurePESATrans.Amount := amountPaid;
                            SurePESATrans.Posted := true;
                            SurePESATrans."Posting Date" := Today;
                            SurePESATrans.Status := SurePESATrans.Status::Completed;
                            SurePESATrans.Comments := 'Success';
                            SurePESATrans.Client := Vendor."BOSA Account No";
                            SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::"Transfer to Fosa";
                            SurePESATrans."Transaction Time" := Time;
                            SurePESATrans.Insert;

                            result := 'TRUE';

                            msg := 'You have transfered KES ' + Format(amountPaid) + ' from Account ' + Vendor.Name + ' to ' + loanNo +
                              '. Thank you for using ACUMEN SACCO Mobile.';
                            SMSMessage(DocNumber, accFrom, Vendor."Mobile Phone No", msg, '');
                        end;
                    end else begin
                        result := 'INSUFFICIENT';
                        msg := 'You have insufficient funds in your savings Account to use this service.' +
                              '. Thank you for using ACUMEN SACCO Mobile.';
                        SMSMessage(DocNumber, accFrom, Vendor."Mobile Phone No", msg, '');
                    end;
                end else begin
                    result := 'ACC2INEXISTENT';
                    msg := 'Your request has failed because you do not have any outstanding balance.' +
                              '. Thank you for using ACUMEN SACCO Mobile.';
                    SMSMessage(DocNumber, accFrom, Vendor."Mobile Phone No", msg, '');
                end;
            end else begin
                result := 'ACCINEXISTENT';
                msg := 'Your request has failed.Please make sure you are registered for mobile banking.' +
                        '. Thank you for using ACUMEN SACCO Mobile.';
                SMSMessage(DocNumber, accFrom, Vendor."Mobile Phone No", msg, '');
            end;
        end;
    end;


    procedure OutstandingLoans(phone: Text[20]) loannos: Text[200]
    var
        vendorTable: Record Vendor;
    begin

        vendorTable.Reset;
        vendorTable.SetRange(vendorTable."Mobile Phone No", phone);

        if vendorTable.Find('-') then begin
            LoansTable.Reset;
            LoansTable.SetRange(LoansTable."Client Code", vendorTable."BOSA Account No");
            if LoansTable.Find('-') then begin
                repeat
                    LoansTable.CalcFields(LoansTable."Outstanding Balance");
                    if (LoansTable."Outstanding Balance" > 0) then
                        loannos := loannos + ':::' + LoansTable."Loan  No.";
                until LoansTable.Next = 0;
            end;
        end;
    end;


    procedure LoanGuarantors(loanNo: Text[20]) guarantors: Text
    begin
        begin
            LoanGuaranteeDetails.Reset;
            LoanGuaranteeDetails.SetRange(LoanGuaranteeDetails."Loan No", loanNo);
            if LoanGuaranteeDetails.Find('-') then begin
                repeat
                    guarantors := guarantors + '::::' + LoanGuaranteeDetails.Name + ':::' + Format(LoanGuaranteeDetails."Amont Guaranteed");
                until LoanGuaranteeDetails.Next = 0;
            end;
        end;
    end;


    procedure LoansGuaranteed(phone: Text[20]) guarantors: Text[1000]
    var
        vendortable: Record Vendor;
    begin

        vendortable.Reset;
        vendortable.SetRange(vendortable."Mobile Phone No", phone);
        if vendortable.Find('-') then begin

            LoanGuaranteeDetails.Reset;
            LoanGuaranteeDetails.SetRange(LoanGuaranteeDetails."Member No", vendortable."BOSA Account No");
            //LoanGuaranteeDetails.SETRANGE(LoanGuaranteeDetails."Loan Balance",'>%1',0);
            if LoanGuaranteeDetails.Find('-') then begin
                repeat
                    guarantors := guarantors + '::::' + LoanGuaranteeDetails."Loan No" + ':::' + Format(LoanGuaranteeDetails."Amont Guaranteed");
                until LoanGuaranteeDetails.Next = 0;
            end;

        end;
    end;


    procedure ClientCodes(loanNo: Text[20]) codes: Text[20]
    begin

        LoansTable.Reset;
        LoansTable.SetRange(LoansTable."Loan  No.", loanNo);
        if LoansTable.Find('-') then begin
            codes := LoansTable."Client Code";
        end;
    end;


    procedure ClientNames(ccode: Text[20]) names: Text[100]
    begin

        LoansTable.Reset;
        LoansTable.SetRange(LoansTable."Client Code", ccode);
        if LoansTable.Find('-') then begin
            Members.Reset;
            Members.SetRange(Members."No.", ccode);
            if Members.Find('-') then begin
                names := Members.Name;
            end;
        end;
    end;


    procedure ChargesGuarantorInfo(Phone: Text[20]; DocNumber: Text[20]) result: Text[250]
    begin
        begin
            SurePESATrans.Reset;
            SurePESATrans.SetRange(SurePESATrans."Document No", DocNumber);
            if SurePESATrans.Find('-') then begin
                result := 'REFEXISTS';
            end else begin
                result := '';
                GenLedgerSetup.Reset;
                GenLedgerSetup.Get;
                GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");
                GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
                GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

                Charges.Reset;
                Charges.SetRange(Charges.Code, GenLedgerSetup."Mobile Charge");
                if Charges.Find('-') then begin
                    Charges.TestField(Charges."GL Account");
                    MobileChargesACC := Charges."GL Account";
                end;

                SurePESACommACC := GenLedgerSetup."CloudPESA Comm Acc";
                SurePESACharge := GenLedgerSetup."CloudPESA Charge";

                Vendor.Reset;
                Vendor.SetRange(Vendor."Phone No.", Phone);
                if Vendor.Find('-') then begin
                    Vendor.CalcFields(Vendor."Balance (LCY)");
                    TempBalance := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions");
                    fosaAcc := Vendor."No.";

                    if (TempBalance > SurePESACharge) then begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                        GenJournalLine.DeleteAll;
                        //end of deletion

                        GenBatches.Reset;
                        GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                        GenBatches.SetRange(GenBatches.Name, 'MOBILETRAN');

                        if GenBatches.Find('-') = false then begin
                            GenBatches.Init;
                            GenBatches."Journal Template Name" := 'GENERAL';
                            GenBatches.Name := 'MOBILETRAN';
                            GenBatches.Description := 'Loan Guarantors Info';
                            GenBatches.Validate(GenBatches."Journal Template Name");
                            GenBatches.Validate(GenBatches.Name);
                            GenBatches.Insert;
                        end;

                        //Dr Mobile Charges
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := fosaAcc;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := fosaAcc;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Loan Guarantors Info Charges';
                        GenJournalLine.Amount := SurePESACharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //CR Commission
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := SurePESACommACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := MobileChargesACC;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Loan Guarantors Info Charges';
                        GenJournalLine.Amount := -SurePESACharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                        if GenJournalLine.Find('-') then begin
                            repeat
                                GLPosting.Run(GenJournalLine);
                            until GenJournalLine.Next = 0;
                        end;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                        GenJournalLine.DeleteAll;

                        SurePESATrans.Init;
                        SurePESATrans."Document No" := DocNumber;
                        SurePESATrans.Description := 'Loan Guarantors Info';
                        SurePESATrans."Document Date" := Today;
                        SurePESATrans."Account No" := Vendor."No.";
                        SurePESATrans."Account No2" := '';
                        SurePESATrans.Amount := amount;
                        SurePESATrans.Posted := true;
                        SurePESATrans."Posting Date" := Today;
                        SurePESATrans.Status := SurePESATrans.Status::Completed;
                        SurePESATrans.Comments := 'Success';
                        SurePESATrans.Client := Vendor."BOSA Account No";
                        SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::Ministatement;
                        SurePESATrans."Transaction Time" := Time;
                        SurePESATrans.Insert;
                        result := 'TRUE';
                    end
                    else begin
                        result := 'INSUFFICIENT';
                    end;
                end
                else begin
                    result := 'ACCNOTFOUND';
                end;
            end;
        end;
    end;


    procedure RegisteredMemberDetailsUSSD(Phone: Text[20]; docNo: Text[30]) reginfo: Text[250]
    begin
        begin
            RanNo := Format(Random(10000));
            Members.Reset;
            Members.SetRange(Members."Mobile Phone No", Phone);
            if Members.Find('-') then begin
                reginfo := 'Member No: ' + Members."No." + ',  Name: ' + Members.Name + ',  ID No: ' + Format(Members."ID No.") + ',  Payroll No: ' + Members."No." + ',  Email :' + Members."E-Mail";
                SMSMessage(RanNo + Members."No.", Members."No.", Phone, reginfo, '');
            end
            else begin
                reginfo := '';
            end
        end;
    end;


    procedure LoansGuaranteedUSSD(phone: Text[20]; docNo: Text[30]) guarantors: Text[1000]
    var
        Ran2: Text[20];
        newtext: Text[500];
    begin
        begin
            RanNo := Format(Random(10000));
            Ran2 := Format(Random(10000));
            Members.Reset;
            Members.SetRange(Members."Mobile Phone No", phone);
            if Members.Find('-') then begin
            end;
            LoanGuaranteeDetails.Reset;
            LoanGuaranteeDetails.SetRange(LoanGuaranteeDetails."Member No", Members."No.");
            //LoanGuaranteeDetails.SETRANGE(LoanGuaranteeDetails."Loan Balance",'>%1',0);
            if LoanGuaranteeDetails.Find('-') then begin
                repeat
                    guarantors := guarantors + LoanGuaranteeDetails."Loanees  Name" + '-(' + Format(LoanGuaranteeDetails."Amont Guaranteed") + '), ';
                until LoanGuaranteeDetails.Next = 0;
                newtext := guarantors;
                if StrLen(guarantors) > 220 then begin
                    guarantors := CopyStr(guarantors, 1, 220);
                    SMSMessage(RanNo + Members."No.", Members."No.", phone, 'LOANS GUARANTEED  ' + CopyStr(guarantors, 1, 220), '');
                    SMSMessage(Ran2 + Members."No.", Members."No.", phone, CopyStr(newtext, 221, StrLen(newtext)), '');
                end
                else begin
                    SMSMessage(RanNo + Members."No.", Members."No.", phone, 'LOANS GUARANTEED  ' + guarantors, '');
                end;
                guarantors := CopyStr(guarantors, 1, StrLen(guarantors) - 2);
            end;
        end;
    end;


    procedure LoanGuarantorsUSSD(loanNo: Text[20]; Phone: Text[20]; docNo: Text[30]) guarantors: Text[1000]
    var
        loantype: Text[30];
    begin
        begin
            LoansTable.Reset;
            LoansTable.SetRange(LoansTable."Loan  No.", loanNo);
            if LoansTable.Find('-') then begin
                loantype := LoansTable."Loan Product Type";
            end;

            RanNo := Format(Random(10000));
            LoanGuaranteeDetails.Reset;
            LoanGuaranteeDetails.SetRange(LoanGuaranteeDetails."Loan No", loanNo);
            if LoanGuaranteeDetails.Find('-') then begin
                repeat
                    guarantors := guarantors + '::' + LoanGuaranteeDetails.Name + '(' + Format(LoanGuaranteeDetails."Amont Guaranteed") + ')';
                until LoanGuaranteeDetails.Next = 0;
                SMSMessage(RanNo + loanNo, Members."No.", Phone, 'GUARANTORS' + '(' + loantype + ')' + guarantors, '');
            end;
        end;
    end;


    procedure AccountBalanceUSSD(Phone: Code[30]; DocNumber: Code[20]) Bal: Text[50]
    begin

        //  Members.RESET;
        //  Members.SETRANGE(Members."Mobile Phone No",Phone);
        //  IF Members.FIND('-') THEN BEGIN
        //      MemberLedgerEntry.RESET;
        //      MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Customer No.",Members."No.");
        //      MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."Transaction Type"::"Share Capital");
        //      IF MemberLedgerEntry.FIND('-') THEN BEGIN
        //        REPEAT
        //          amount:=amount+MemberLedgerEntry.Amount;
        //          Bal:= FORMAT(amount,0,'<Precision,2:2><Integer><Decimals>');
        //        UNTIL MemberLedgerEntry.NEXT =0;
        //      END;
        //      SMSMessage(DocNumber,Members."No.",Phone,' Your Account balance is Kshs: '+Bal+' Thank you for using ACUMEN SACCO Mobile','');
        //  END;

        Vendor.Reset;
        Vendor.SetRange("Mobile Phone No", Phone);
        Vendor.SetFilter("Account Type", '%1|%2', '100', '200');
        if Vendor.Find('-') then begin
            AccountTypes.Reset;
            AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
            // AccountTypes.SETFILTER(AccountTypes."Last Account No Used(HQ)",'=%1',FALSE);  //Restrict account types
            if AccountTypes.Find('-') then begin
                miniBalance := AccountTypes."Minimum Balance";
            end;
            Vendor.CalcFields(Vendor."Balance (LCY)");
            Vendor.CalcFields(Vendor."ATM Transactions");
            Vendor.CalcFields(Vendor."Uncleared Cheques");
            Vendor.CalcFields(Vendor."EFT Transactions");
            accBalance := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions" + miniBalance);
            //Bal:=FORMAT(accBalance);
            Bal := Format(accBalance, 0, '<Precision,2:2><Integer><Decimals>');

        end;
    end;


    procedure Accounts(phone: Text[20]; docNo: Text[30]) accounts: Text[1000]
    var
        sharecap: Text[50];
        deposit: Text[50];
        holiday: Text[50];
        property: Text[50];
        junior: Text[50];
        benevolent: Text[50];
    begin

        sharecap := ShareCapital(phone);
        if sharecap <> 'NULL' then begin
            sharecap := 'Share Capital= KES ' + sharecap;
            accounts := accounts + sharecap + ' , ';
        end;

        deposit := DepositContribution(phone);
        if deposit <> 'NULL' then begin
            deposit := 'Deposit Contribution= KES ' + deposit + ' , ';
            accounts := accounts + deposit;
        end;


        accounts := CopyStr(accounts, 1, StrLen(accounts) - 3);
        SMSMessage(docNo, Members."No.", phone, 'Bosa balance: ' + accounts, '');
        accounts := 'true';
    end;


    procedure HolidayAcc(phone: Text[20]) shares: Text[1000]
    var
        hlamount: Decimal;
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."Mobile Phone No", phone);
            if Members.Find('-') then begin
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Members."No.");
                // MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."Transaction Type"::Housing);
                if MemberLedgerEntry.Find('-') then begin
                    repeat
                        hlamount := hlamount + MemberLedgerEntry.Amount;
                        shares := Format(hlamount, 0, '<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next = 0;
                end
                else begin
                    shares := '0';
                end;

            end;
        end;
    end;


    procedure PropertyAcc(phone: Text[20]) shares: Text[1000]
    var
        pptamount: Decimal;
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."Mobile Phone No", phone);
            if Members.Find('-') then begin
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Members."No.");
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::Dividend);
                if MemberLedgerEntry.Find('-') then begin
                    repeat
                        pptamount := pptamount + MemberLedgerEntry.Amount;
                        shares := Format(pptamount, 0, '<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next = 0;
                end
                else begin
                    shares := 'NULL';
                end;
            end;
        end;
    end;


    procedure JuniorAcc(phone: Text[20]) bal: Text[1000]
    var
        jramount: Decimal;
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."Mobile Phone No", phone);
            if Members.Find('-') then begin
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Members."No.");
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::Dividend);
                if MemberLedgerEntry.Find('-') then begin
                    repeat
                        jramount := jramount + MemberLedgerEntry.Amount;
                        bal := Format(jramount, 0, '<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next = 0;
                end
                else begin
                    bal := 'NULL';
                end;
            end;
        end;
    end;


    procedure BenevolentFund(phone: Text[20]) bal: Text[1000]
    var
        bvamount: Decimal;
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Members."No.");
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Benevolent Fund");
                if MemberLedgerEntry.Find('-') then begin
                    repeat
                        bvamount := bvamount + MemberLedgerEntry.Amount;
                        bal := Format(bvamount, 0, '<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next = 0;
                end
                else begin
                    bal := 'NULL';
                end;
            end;
        end;
    end;


    procedure DepositContribution(phone: Text[20]) bal: Text[250]
    var
        dcmount: Decimal;
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Members."No.");
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Deposit Contribution");
                if MemberLedgerEntry.Find('-') then begin
                    repeat
                        dcmount := dcmount + MemberLedgerEntry.Amount;
                        bal := Format(dcmount, 0, '<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next = 0;
                end
                else begin
                    bal := 'NULL';
                end;
            end;
        end;
    end;


    procedure ShareCapital(phone: Text[20]) bal: Text[1000]
    var
        samount: Decimal;
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Members."No.");
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Share Capital");
                if MemberLedgerEntry.Find('-') then begin
                    repeat
                        samount := samount + MemberLedgerEntry.Amount;
                        bal := Format(samount, 0, '<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next = 0;
                end
                else begin
                    bal := '0';
                end;
            end;
        end;
    end;


    procedure watotoSavings(phone: Text[20]) bal: Text[1000]
    var
        samount: Decimal;
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Members."No.");
                // MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."Transaction Type"::"Watoto Savings");
                if MemberLedgerEntry.Find('-') then begin
                    repeat
                        samount := samount + MemberLedgerEntry.Amount;
                        bal := Format(samount, 0, '<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next = 0;
                end
                else begin
                    bal := '0';
                end;
            end;
        end;
    end;


    procedure withdrawalDeposits(phone: Text[20]) bal: Text[1000]
    var
        samount: Decimal;
    begin

        Members.Reset;
        Members.SetRange(Members."No.", FnGetMemberNo(phone));
        if Members.Find('-') then begin
            MemberLedgerEntry.Reset;
            MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Members."No.");
            // MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."Transaction Type"::"Withdrawable Savings");
            if MemberLedgerEntry.Find('-') then begin
                repeat
                    samount := samount + MemberLedgerEntry.Amount;
                    bal := Format(samount, 0, '<Precision,2:2><Integer><Decimals>');
                until MemberLedgerEntry.Next = 0;
            end
            else begin
                bal := '0';
            end;
        end;
    end;


    procedure dividendWithdrawal(phone: Text[20]) bal: Text[1000]
    var
        samount: Decimal;
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Members."No.");
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::Dividend);
                if MemberLedgerEntry.Find('-') then begin
                    repeat
                        samount := samount + MemberLedgerEntry.Amount;
                        bal := Format(samount, 0, '<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next = 0;
                end
                else begin
                    bal := '0';
                end;
            end;
        end;
    end;


    procedure SharesRetained(phone: Text[20]) bal: Text[1000]
    var
        samount: Decimal;
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Members."No.");
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Share Capital");
                if MemberLedgerEntry.Find('-') then begin
                    repeat
                        samount := samount + MemberLedgerEntry.Amount;
                        bal := Format(samount, 0, '<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next = 0;
                end
                else begin
                    bal := 'NULL';
                end;
            end;
        end;
    end;


    procedure CurrentShares(phone: Text[20]) bal: Text[1000]
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Members."No.");
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Deposit Contribution");
                if MemberLedgerEntry.Find('-') then begin
                    repeat
                        amount := amount + MemberLedgerEntry.Amount;
                        bal := Format(amount, 0, '<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next = 0;
                end
                else begin
                    bal := 'NULL';
                end;
            end;
        end;
    end;


    procedure OutstandingLoanName(phone: Text[20]) loannos: Text[200]
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                LoansTable.Reset;
                LoansTable.SetRange(LoansTable."Client Code", Members."No.");
                if LoansTable.Find('-') then begin
                    repeat
                        LoansTable.CalcFields(LoansTable."Outstanding Balance", LoansTable."Interest Due", LoansTable."Interest to be paid", LoansTable."Interest Paid");
                        if (LoansTable."Outstanding Balance" > 0) then
                            loannos := loannos + ':::' + LoansTable."Loan  No.";
                    until LoansTable.Next = 0;
                end;
            end
        end;
    end;


    procedure MemberName(memNo: Text[20]) name: Text[200]
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", memNo);
            if Members.Find('-') then begin
                name := Members.Name;
            end
        end;
    end;


    procedure InsertTransaction("Document No": Code[30]; Keyword: Code[30]; "Account No": Code[30]; "Account Name": Text[100]; Telephone: Code[20]; Amount: Decimal; "Sacco Bal": Decimal; TransactionDate: Date; transactionTime: DateTime) Result: Code[20]
    begin

        Result := '2|ERROR'; // ** DEFAULT, INCASE NOT ERROR OCCURED

        PaybillTrans.Reset;
        PaybillTrans.SetRange(PaybillTrans."Document No", "Document No");
        if PaybillTrans.Find('-') then begin
            // ** IF IT EXISTS RETURN
            Result := '1|EXISTS';

        end else begin

            // ** DOES NOT EXIST, CREATE ENTRY
            PaybillTrans.Init;
            PaybillTrans."Document No" := "Document No";
            PaybillTrans."Key Word" := Keyword;
            PaybillTrans."Account No" := CopyStr("Account No", 1, 20);
            PaybillTrans."Account Name" := "Account Name";
            PaybillTrans."Transaction Date" := TransactionDate;
            PaybillTrans."Transaction Time" := Dt2Time(transactionTime);
            PaybillTrans."Captured By" := UserId;
            PaybillTrans.Description := 'PayBill Deposit';
            PaybillTrans.Telephone := Telephone;
            PaybillTrans.Amount := Amount;
            PaybillTrans."Paybill Acc Balance" := "Sacco Bal";
            PaybillTrans.Posted := false;
            PaybillTrans.Insert;

            Result := '0|SUCCESS';

        end;
    end;


    procedure InsertDepositTransaction("Document No": Code[30]; Keyword: Code[30]; "Account No": Code[30]; "Account Name": Text[100]; Telephone: Code[20]; Amount: Decimal; "Sacco Bal": Decimal; TransactionDate: Date; TransactionTime: DateTime) Result: Code[20]
    begin

        Result := '2|ERROR'; // ** DEFAULT, INCASE NOT ERROR OCCURED

        PaybillTrans.Reset;
        PaybillTrans.SetRange(PaybillTrans."Document No", "Document No");
        if PaybillTrans.Find('-') then begin
            // ** IF IT EXISTS RETURN
            Result := '1|EXISTS';

        end else begin

            // ** DOES NOT EXIST, CREATE ENTRY
            PaybillTrans.Init;
            PaybillTrans."Document No" := "Document No";
            PaybillTrans."Key Word" := Keyword;
            PaybillTrans."Account No" := CopyStr("Account No", 1, 20);
            PaybillTrans."Account Name" := "Account Name";
            PaybillTrans."Transaction Date" := TransactionDate;
            PaybillTrans."Transaction Time" := Dt2Time(TransactionTime);
            PaybillTrans."Captured By" := UserId;
            PaybillTrans.Description := 'Paybill Deposit';
            PaybillTrans.Telephone := Telephone;
            PaybillTrans.Amount := Amount;
            PaybillTrans."Paybill Acc Balance" := "Sacco Bal";
            PaybillTrans.Posted := false;
            PaybillTrans.Insert;

            Result := '0|SUCCESS';

        end;
    end;


    procedure PaybillSwitch() Result: Code[20]
    begin

        //  exit;
        PaybillTrans.Reset;
        PaybillTrans.Ascending(false);
        PaybillTrans.SetRange(PaybillTrans.Posted, false);
        PaybillTrans.SetRange(PaybillTrans."Needs Manual Posting", false);
        PaybillTrans.SetRange(PaybillTrans."Transaction Date", Today);
        //PaybillTrans.SETRANGE("Document No" , 'QD63X3FFHP');
        if PaybillTrans.Find('-') then begin
            //MESSAGE('found');
            repeat

                //MESSAGE(PaybillTrans."Document No");

                // ** if account is fosa account then push to fosa
                Vendor.Reset;
                Vendor.SetRange(Vendor."No.", PaybillTrans."Account No");
                if Vendor.Find('-') then begin
                    Result := PayBillToAcc('PAYBILL', PaybillTrans."Document No", PaybillTrans."Account No", PaybillTrans."Account No", PaybillTrans.Amount, '');
                end else begin
                    // -- check if it is I.D number instead
                    Vendor.Reset;
                    Vendor.SetRange(Vendor."ID No.", PaybillTrans."Account No");
                    if Vendor.Find('-') then begin
                        Result := PayBillToAcc('PAYBILL', PaybillTrans."Document No", Vendor."No.", Vendor."No.", PaybillTrans.Amount, '');
                    end;
                end;


                // ** else if account is loan number then pay loan
                LoansRegister.Reset;
                LoansRegister.SetRange(LoansRegister."Loan  No.", CopyStr(PaybillTrans."Account No", 1, 20));
                if LoansRegister.Find('-') then begin
                    Result := PaybillToLoanAPI('PAYBILL', PaybillTrans."Document No", PaybillTrans."Account No", PaybillTrans."Account No", PaybillTrans.Amount, 'ADVANCE');
                end else begin

                    case PaybillTrans."Key Word" of

                        'DEP':
                            Result := PayBillToBOSA('PAYBILL', PaybillTrans."Document No", PaybillTrans."Account No", PaybillTrans."Account No", PaybillTrans.Amount, PaybillTrans."Key Word", 'PayBill to Deposit Contribution');
                        'SHA':
                            Result := PayBillToBOSA('PAYBILL', PaybillTrans."Document No", PaybillTrans."Account No", PaybillTrans."Account No", PaybillTrans.Amount, PaybillTrans."Key Word", 'PayBill to Share Capital');
                        'INS':
                            Result := PayBillToBOSA('PAYBILL', PaybillTrans."Document No", CopyStr(PaybillTrans."Account No", 1, 20), CopyStr(PaybillTrans."Account No", 1, 20), PaybillTrans.Amount, PaybillTrans."Key Word", 'PAYBILL TO INSURANCE');
                        'BEN':
                            Result := PayBillToBOSA('PAYBILL', PaybillTrans."Document No", CopyStr(PaybillTrans."Account No", 1, 20), CopyStr(PaybillTrans."Account No", 1, 20), PaybillTrans.Amount, PaybillTrans."Key Word", 'PAYBILL TO INSURANCE');
                        'WAT':
                            Result := PayBillToBOSA('PAYBILL', PaybillTrans."Document No", CopyStr(PaybillTrans."Account No", 1, 20), CopyStr(PaybillTrans."Account No", 1, 20), PaybillTrans.Amount, PaybillTrans."Key Word", 'PAYBILL TO INSURANCE');
                        'WIT':
                            Result := PayBillToBOSA('PAYBILL', PaybillTrans."Document No", CopyStr(PaybillTrans."Account No", 1, 20), CopyStr(PaybillTrans."Account No", 1, 20), PaybillTrans.Amount, PaybillTrans."Key Word", 'PayBill to Insurance');

                        else

                            // ** else the deposits destination needs manual intervention
                            if Result = '' then begin
                                PaybillTrans."Needs Manual Posting" := true;
                                //            PaybillTrans.Description:='Failed';
                                PaybillTrans.Modify;
                            end;

                    end;

                end;

                if Result = '' then begin

                    PaybillTrans."Needs Manual Posting" := true;
                    //        PaybillTrans.Description:='Failed';
                    PaybillTrans.Modify;

                end;

            until PaybillTrans.Next = 0;
        end else begin
            //MESSAGE('not found');
        end;

    end;

    local procedure PayBillToAcc(batch: Code[20]; docNo: Code[20]; accNo: Code[20]; memberNo: Code[20]; Amount: Decimal; accountType: Code[10]) res: Code[10]
    begin

        GenLedgerSetup.Reset;
        GenLedgerSetup.Get;
        GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
        GenLedgerSetup.TestField(GenLedgerSetup."PayBill Settl Acc");
        PaybillRecon := GenLedgerSetup."PayBill Settl Acc";

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", batch);
        GenJournalLine.DeleteAll;
        //end of deletion

        GenBatches.Reset;
        GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
        GenBatches.SetRange(GenBatches.Name, batch);

        if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name" := 'GENERAL';
            GenBatches.Name := batch;
            GenBatches.Description := 'Paybill Deposit';
            GenBatches.Validate(GenBatches."Journal Template Name");
            GenBatches.Validate(GenBatches.Name);
            GenBatches.Insert;
        end;//General Jnr Batches

        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", accNo);
        if Vendor.Find('-') then begin
            /*
            Vendor.RESET;
            Vendor.SETRANGE(Vendor."BOSA Account No", accNo);
            Vendor.SETRANGE(Vendor."Account Type", accountType);
            IF Vendor.FINDFIRST THEN BEGIN
            */
            //Dr MPESA PAybill ACC
            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := batch;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No." := PaybillRecon;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Document No." := docNo;
            GenJournalLine."External Document No." := docNo;
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := 'Paybill Deposit';
            GenJournalLine.Amount := Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            //Cr Customer
            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := batch;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := Vendor."No.";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Document No." := docNo;
            GenJournalLine."External Document No." := docNo;
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := 'Paybill -' + PaybillTrans.Telephone + '-' + PaybillTrans."Account Name";
            GenJournalLine.Amount := -1 * Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
            //Post
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
            GenJournalLine.SetRange("Journal Batch Name", batch);

            if GenJournalLine.Find('-') then begin
                repeat
                    GLPosting.Run(GenJournalLine);
                until GenJournalLine.Next = 0;


                PaybillTrans.Posted := true;
                PaybillTrans."Transaction Date" := Today;
                //      PaybillTrans.Description:='Posted';
                PaybillTrans.Modify;

                res := 'TRUE';

                msg := 'Dear ' + PaybillTrans."Account Name"
                            + ' ACC: ' + PaybillTrans."Account No" + ' KES.' + Format(Amount) + '. Has been received';

                SMSMessage(PaybillTrans."Document No", PaybillTrans."Account No", '+' + PaybillTrans.Telephone, msg, '');

                msg := 'Dear ' + Vendor.Name
                            + ' ACC: ' + PaybillTrans."Account No" + ' has been credited with KES.' + Format(Amount)
                            + ' From ' + PaybillTrans."Account Name" + ' . MPESA REF : ' + docNo;

                SMSMessage(PaybillTrans."Document No", PaybillTrans."Account No", Vendor."Mobile Phone No", msg, '');

            end else begin
                PaybillTrans."Transaction Date" := Today;
                PaybillTrans."Needs Manual Posting" := true;
                //      PaybillTrans.Description:='Failed';
                PaybillTrans.Modify;
                res := 'FALSE';
            end;
            //END;//Vendor
        end;//Member

    end;

    local procedure PayBillToBOSA(batch: Code[20]; docNo: Code[20]; accNo: Code[100]; memberNo: Code[100]; amount: Decimal; type: Code[100]; descr: Text[100]) res: Code[10]
    var
        InsuranceAmount: Decimal;
        MToday: Integer;
        MPayDate: Integer;
        MInsuranceBal: Decimal;
    begin


        SaccoGenSetup.Reset;
        SaccoGenSetup.Get;

        GenLedgerSetup.Reset;
        GenLedgerSetup.Get;
        GenLedgerSetup.TestField(GenLedgerSetup."PayBill Settl Acc");

        //SaccoGenSetup.TESTFIELD(SaccoGenSetup.PaybillAcc);
        PaybillRecon := GenLedgerSetup."PayBill Settl Acc";

        ExcDuty := (SaccoGenSetup."Excise Duty(%)" / 100) * SurePESACharge;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", batch);
        GenJournalLine.DeleteAll;
        //end of deletion

        GenBatches.Reset;
        GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
        GenBatches.SetRange(GenBatches.Name, batch);

        if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name" := 'GENERAL';
            GenBatches.Name := batch;
            GenBatches.Description := descr;
            GenBatches.Validate(GenBatches."Journal Template Name");
            GenBatches.Validate(GenBatches.Name);
            GenBatches.Insert;
        end;//General Jnr Batches

        Vendor.Reset;
        Vendor.SetRange("Mobile Phone No", PaybillTrans.Telephone);
        if Vendor.Find('-') then begin
            Members.Reset;
            Members.SetRange(Members."No.", Vendor."BOSA Account No");
            if Members.Find('-') then begin
                // Members.CALCFIELDS(Members."Insurance Fund");

                MInsuranceBal := 0;//(MToday-MPayDate)*100;

                //Dr MPESA PAybill ACC
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := batch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := PaybillRecon;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := docNo;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := descr;
                GenJournalLine.Amount := amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;


                if amount > 0 then begin
                    //Cr Customer
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := batch;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                    GenJournalLine."Account No." := Members."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := docNo;
                    GenJournalLine."Posting Date" := Today;
                    case PaybillTrans."Key Word" of
                        'DEP':
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                    end;
                    case PaybillTrans."Key Word" of
                        'SHA':
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                    end;
                    /* CASE PaybillTrans."Key Word" OF 'INS':
                      GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::Insurance;
                    END;
                                  CASE PaybillTrans."Key Word" OF 'WAT':
                      GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Watoto Savings"
                    END;  */
                    case PaybillTrans."Key Word" of
                        'BEN':
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Benevolent Fund";
                    end;
                    /* CASE PaybillTrans."Key Word" OF 'WIT':
                      GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Withdrawable Savings";
                      END;    */

                    /*
                    GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                    */

                    GenJournalLine.Description := 'Paybill from - ' + PaybillTrans.Telephone;
                    GenJournalLine.Amount := (amount - SurePESACharge - ExcDuty) * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                end;

                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", batch);
                if GenJournalLine.Find('-') then begin
                    repeat
                        GLPosting.Run(GenJournalLine);
                    until GenJournalLine.Next = 0;

                    PaybillTrans.Posted := true;
                    PaybillTrans."Date Posted" := Today;
                    //        PaybillTrans.Description:='Posted';
                    PaybillTrans.Modify;
                    res := 'TRUE';

                    if PaybillTrans."Key Word" = 'DEP' then description := 'Deposit Contribution';
                    if PaybillTrans."Key Word" = 'SHA' then description := 'Share Capital';
                    if PaybillTrans."Key Word" = 'INS' then description := 'Insurance';
                    if PaybillTrans."Key Word" = 'BEN' then description := 'Benevolent Fund';
                    if PaybillTrans."Key Word" = 'WIT' then description := 'Withdrawable Savings';
                    if PaybillTrans."Key Word" = 'WAT' then description := 'Watoto Savings';

                    msg := 'Dear ' + Members.Name + ' your: ' + description + ' has been credited with Ksh' + Format(amount) + '. Thank you for using Our Mobile Services';
                    SMSMessage(docNo, Members."No.", Members."Mobile Phone No", msg, '');

                end else begin

                    PaybillTrans."Date Posted" := Today;
                    PaybillTrans."Needs Manual Posting" := true;
                    //        PaybillTrans.Description:='Failed';
                    PaybillTrans.Modify;
                    res := 'FALSE';

                end;

                //  END;//Vendor
            end;//Member
        end else begin
            // -- vendor not found
        end;

    end;

    local procedure LoanRepaymentSchedule(varLoanNo: Integer; varPrincipalRepayment: Integer; varInterestRepayment: Integer; varTotalRepayment: Integer)
    begin
    end;


    procedure Guaranteefreeshares(phone: Text[20]) shares: Text[500]
    var
        LoanGuard: Record "Loans Guarantee Details";
        GenSetup: Record "Sacco General Set-Up";
        FreeShares: Decimal;
    begin
        begin
            GenSetup.Get();
            FreeShares := 0;
            glamount := 0;
            Members.Reset;
            Members.SetRange(Members."Mobile Phone No", phone);
            if Members.Find('-') then begin
                Members.CalcFields("Current Shares");
                LoanGuard.Reset;
                LoanGuard.SetRange(LoanGuard."Member No", Members."No.");
                LoanGuard.SetRange(LoanGuard.Substituted, false);
                if LoanGuard.Find('-') then begin
                    repeat
                        glamount := glamount + LoanGuard."Amont Guaranteed";
                    //MESSAGE('Member No %1 Account no %2',Members."No.",glamount);
                    until LoanGuard.Next = 0;
                end;
                //FreeShares:=(Members."Current Shares"*GenSetup."Free Share Multiplier")-glamount;
                shares := Format(FreeShares, 0, '<Precision,2:2><Integer><Decimals>');
            end;
        end;
    end;


    procedure Loancalculator(Loansetup: Text[500]) calcdetails: Text
    var
        Loanproducts: Text[500];
    begin
        begin
            LoanProducttype.Reset;
            //LoanProducttype.GET();
            LoanProducttype.SetFilter(LoanProducttype."Max. Loan Amount", '<>%1', 0);
            if LoanProducttype.Find('-') then begin
                //  LoanProducttype.CALCFIELDS(LoanProducttype."Interest rate",LoanProducttype."Max. Loan Amount",LoanProducttype."Min. Loan Amount");

                repeat

                    calcdetails := calcdetails + '::::' + Format(LoanProducttype."Product Description") + ':::' + Format(LoanProducttype."Interest rate") + ':::' + Format(LoanProducttype."No of Installment") + ':::' + Format(LoanProducttype."Max. Loan Amount")
                    + ':::' + Format(LoanProducttype."Repayment Method");
                until LoanProducttype.Next = 0;
                //MESSAGE('Loan Balance %1',loanbalances);
                // calcdetails:=varLoan;

            end;
        end;
    end;


    procedure OutstandingLoansUSSD(phone: Code[20]) loanbalances: Text[1024]
    begin
        begin
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                LoansRegister.Reset;
                LoansRegister.SetRange(LoansRegister."Client Code", Members."No.");
                if LoansRegister.Find('-') then begin
                    repeat
                        LoansRegister.CalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest", LoansRegister."Interest to be paid", LoansRegister."Interest Paid");
                        if (LoansRegister."Outstanding Balance" > 0) then
                            loanbalances := loanbalances
                                    + '::::' + LoansRegister."Loan  No."
                                    + ':::' + LoansRegister."Loan Product Type Name"
                                    + ':::' + Format(LoansRegister."Outstanding Balance")
                                    + ':::' + Format(LoansRegister."Oustanding Interest");
                    until LoansRegister.Next = 0;
                end;
                //  LoansRegister.SETRANGE(LoansRegister."Client Code",Vendor."No.");
            end;
        end;
    end;


    procedure InsertCoopTran(memberno: Code[250]; totalamt: Decimal; addinfo: Code[250]; accNo: Code[250]; accName: Code[250]; InstCode: Code[250]; instName: Code[250]; refernceCode: Code[250]; messageID: Code[250]) resut: Code[50]
    var
        batch: Code[20];
        docNo: Code[50];
        SharesAmount: Decimal;
        DepositAmount: Decimal;
        RegfeeAmount: Decimal;
        InsuranceAmount: Decimal;
        SaccoGenSetUp: Record "HR Leave Planner Lines";
        OutstInsuranceAmount: Decimal;
        Totalshares: Decimal;
        TotalRegFee: Decimal;
        RemainedShares: Decimal;
        RemainedRegistration: Decimal;
        LastPaydate: Date;
        PayDateDiff: Date;
        MPayDate: Decimal;
        MToday: Decimal;
        MInsuranceBal: Decimal;
    begin
        /*CoopbankTran.RESET;
         IF CoopbankTran.FIND('+') THEN BEGIN
            iEntryNo:=CoopbankTran.TranID;
            iEntryNo:=iEntryNo+1;
            END
            ELSE BEGIN
            iEntryNo:=1;
            END;
            amount:=totalamt;
            CoopbankTran.INIT;
            CoopbankTran."Reference Code":=refernceCode;
            CoopbankTran."Account Name":=instName;
            CoopbankTran."Account No":=accNo;
            CoopbankTran."Additional info":=addinfo;
            CoopbankTran.Currency:=CoopbankTran.Currency::KES;
            CoopbankTran.TranID:=iEntryNo;
            CoopbankTran."Member No":=memberno;
            CoopbankTran."Transaction Date":=TODAY;
            CoopbankTran."Total Amount":=totalamt;
            CoopbankTran."Institution Code":=InstCode;
            CoopbankTran."Institution Name":='´┐¢MOJA SACCO';
            CoopbankTran.MessageID:=messageID;
            CoopbankTran."Bank Reference code":=messageID;
            CoopbankTran."Transaction Time":=CURRENTDATETIME;
            CoopbankTran.Comments:='LIVE';
            CoopbankTran.INSERT;
        */

    end;

    local procedure PayBillToLoan(batch: Code[20]; docNo: Code[20]; accNo: Code[20]; memberNo: Code[20]; amount: Decimal; type: Code[30]) res: Code[10]
    var
        InterestAmount: Decimal;
        InsuranceAmount: Decimal;
        MToday: Integer;
        MPayDate: Integer;
        MInsuranceBal: Decimal;
    begin
        GenLedgerSetup.Reset;
        GenLedgerSetup.Get;

        GenLedgerSetup.TestField(GenLedgerSetup."PayBill Settl Acc");
        PaybillRecon := GenLedgerSetup."PayBill Settl Acc";
        loanamt := amount;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", batch);
        GenJournalLine.DeleteAll;
        //end of deletion

        GenBatches.Reset;
        GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
        GenBatches.SetRange(GenBatches.Name, batch);

        if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name" := 'GENERAL';
            GenBatches.Name := batch;
            GenBatches.Description := 'Paybill Loan Repayment';
            GenBatches.Validate(GenBatches."Journal Template Name");
            GenBatches.Validate(GenBatches.Name);
            GenBatches.Insert;
        end;//General Jnr Batches


        LoansRegister.Reset;
        LoansRegister.SetRange(LoansRegister."Loan  No.", PaybillTrans."Account No");
        // LoansRegister.SETRANGE(LoansRegister."Client Code",memberNo);

        if LoansRegister.Find('-') then begin
            Members.Reset;
            Members.SetRange(Members."No.", LoansRegister."Client Code");
            if Members.Find('-') then begin

                LoansRegister.CalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
                if LoansRegister."Outstanding Balance" > 0 then begin

                    //Dr MPESA PAybill ACC
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := batch;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := PaybillRecon;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := docNo;
                    GenJournalLine."Source No." := Vendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Paybill Loan Repayment';
                    GenJournalLine.Amount := amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    if amount > 0 then begin
                        if LoansRegister."Oustanding Interest" > 0 then begin
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := batch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                            GenJournalLine."Account No." := LoansRegister."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := docNo;
                            GenJournalLine."External Document No." := docNo;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Loan Interest Payment';


                            if amount > LoansRegister."Oustanding Interest" then
                                InterestAmount := -LoansRegister."Oustanding Interest"
                            else
                                InterestAmount := -amount;
                            GenJournalLine.Amount := InterestAmount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";

                            if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");

                                GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                            end;

                            /*  GenSetUp.RESET;
                              GenSetUp.GET;
                              LoanProductsSetup.RESET;

                              IF LoanProductsSetup.GET(LoansRegister."Loan Product Type") THEN BEGIN
                                  VarReceivableAccount:=LoanProductsSetup."Receivable Interest Account";
                             //------------------------------------1. DEBIT INTEREST RECEIVABLE CONTROL A/C---------------------------------------------------------------------------------------------
                              LineNo:=LineNo+10000;
                              SFactory.FnCreateGnlJournalLine('GENERAL',batch,docNo,LineNo,GenJournalLine."Transaction Type"::" ",
                              GenJournalLine."Account Type"::"G/L Account",GenSetUp."A/c Interest Receivable",TODAY,InterestAmount,'BOSA',LoansRegister."Loan  No.",
                              'Interest Paid- '+'-'+LoansRegister."Loan  No.",LoansRegister."Loan  No.");
                              //--------------------------------(Debit Member Loan Account)---------------------------------------------

                              //------------------------------------2. CREDIT MEMBER INTEREST RECEIVABLE A/C---------------------------------------------------------------------------------------------
                              LineNo:=LineNo+10000;
                              SFactory.FnCreateGnlJournalLine('GENERAL',batch,docNo,LineNo,GenJournalLine."Transaction Type"::"Interest Due",
                              GenJournalLine."Account Type"::"G/L Account",VarReceivableAccount,TODAY,InterestAmount*-1,'BOSA',LoansRegister."Loan  No.",
                              'Interest Paid- '+'-'+LoansRegister."Loan  No.",LoansRegister."Loan  No.");
                              //----------------------------------(CREDIT MEMBER INTEREST RECEIVABLE A/C-)------------------------------------------------

                              END;
                              */
                            amount := amount + GenJournalLine.Amount;
                        end;
                    end;

                    if amount > 0 then begin
                        if LoansRegister."Outstanding Balance" > 0 then begin
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := batch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                            GenJournalLine."Account No." := LoansRegister."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := docNo;
                            GenJournalLine."External Document No." := '';
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Paybill Loan Repayment';

                            if amount >= LoansRegister."Outstanding Balance" then
                                GenJournalLine.Amount := -LoansRegister."Outstanding Balance"
                            else
                                GenJournalLine.Amount := -amount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
                            if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            end;
                            GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                            if GenJournalLine.Amount <> 0 then begin
                                GenJournalLine.Insert;

                                amount := amount + GenJournalLine.Amount;
                            end;//gen journal
                        end;  //loan balance
                    end;//amount

                    //======================================Deposit contribution
                    if amount > 0 then begin
                        //Cr Customer
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := batch;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                        GenJournalLine."Account No." := Members."No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := docNo;
                        GenJournalLine."External Document No." := docNo;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Description := Format(GenJournalLine."transaction type"::"Deposit Contribution");
                        GenJournalLine.Amount := (amount) * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        amount := amount + GenJournalLine.Amount;
                    end;

                    //Post
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", batch);
                    if GenJournalLine.Find('-') then begin
                        repeat
                            GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;

                        msg := 'Dear ' + Members.Name + ' your  ' + LoansRegister."Loan Product Type Name" + ' has been credited with Ksh. ' + Format(loanamt) + ' on ' + Format(PaybillTrans."Transaction Date") + '. Thank you for using Our Mobile Services';
                        SMSMessage('PAYBILLTRANS', Vendor."No.", Members."Phone No.", msg, '');

                        PaybillTrans.Posted := true;
                        PaybillTrans."Date Posted" := Today;
                        PaybillTrans.Description := 'Posted';
                        PaybillTrans.Modify;
                        res := 'TRUE';

                    end else begin
                        PaybillTrans."Date Posted" := Today;
                        PaybillTrans."Needs Manual Posting" := true;
                        PaybillTrans.Description := 'Failed';
                        PaybillTrans.Modify;
                        res := 'FALSE';
                    end;

                end//Outstanding Balance
            end//Loan Register
               // END;//Vendor
        end;//Member

    end;


    procedure GetTranaccDetails() result: Code[250]
    begin
        /*CoopbankTran.RESET;
        CoopbankTran.SETRANGE(CoopbankTran.posted,FALSE);
        IF CoopbankTran.FIND('-') THEN BEGIN
          result:=CoopbankTran."Reference Code"+':::'+CoopbankTran."Account No";
          END;
          */

    end;


    procedure getAccountDetails(AccountNo: Code[50]) result: Code[250]
    begin
        Members.Reset;
        Members.SetRange(Members."No.", AccountNo);
        if Members.Find('-') then begin

            result := Members.Name;
        end;
    end;


    procedure getAccountNameD(aCCNO: Code[250]) result: Code[1000]
    begin
        Members.Reset;
        Members.SetRange(Members."No.", aCCNO);
        if Members.Find('-') then begin

            result := Members.Name;
        end;
    end;


    procedure GetMessageID(MessageID: Code[50]) Result: Code[50]
    var
        CoopbankTran: Record "Meetings Schedule";
    begin
        /*CoopbankTran.RESET;
        CoopbankTran.SETRANGE(CoopbankTran.MessageID,MessageID);
        IF CoopbankTran.FIND('-') THEN BEGIN
          Result:='TRUE';
          END ELSE BEGIN
             Result:='FALSE';
            END;
        */

    end;


    procedure POSTCoopTran() resut: Code[50]
    var
        batch: Code[20];
        docNo: Code[50];
        SharesAmount: Decimal;
        DepositAmount: Decimal;
        RegfeeAmount: Decimal;
        InsuranceAmount: Decimal;
        SaccoGenSetUp: Record "HR Leave Planner Lines";
        OutstInsuranceAmount: Decimal;
        Totalshares: Decimal;
        TotalRegFee: Decimal;
        RemainedShares: Decimal;
        RemainedRegistration: Decimal;
        LastPaydate: Date;
        PayDateDiff: Date;
        MPayDate: Decimal;
        MToday: Decimal;
        MInsuranceBal: Decimal;
        DocNoLength: Decimal;
        BankRefCode: Code[100];
        TotalAmount: Decimal;
        TransactionLoanAmt: Decimal;
        TransactionLoanDiff: Decimal;
        RepayedLoanAmt: Decimal;
        DateRegistered: Date;
        MtodayYear: Decimal;
        RegYear: Decimal;
        MtodayDiff: Decimal;
        MRegdate: Decimal;
        LoanRepaymentS: Record "HR Leave Family Employees";
        PrincipalAmount: Decimal;
        PY: Decimal;
        PM: Decimal;
        PD: Decimal;
        Fulldate: Date;
        LastRepayDate: Date;
        InterestAmount: Decimal;
        YearDiff: Integer;
        MonthCounter: Integer;
        MonthyContribution: Decimal;
        Monthycontributionbal: Decimal;
        Totalprinciple: Decimal;
    begin
        /*CoopbankTran.RESET;
        CoopbankTran.SETRANGE(CoopbankTran.posted,FALSE);
        CoopbankTran.SETRANGE(CoopbankTran."Needs Manual Posting",FALSE);
        IF CoopbankTran.FIND('-') THEN BEGIN
        
            Members.RESET;
            Members.SETRANGE(Members."No.", CoopbankTran."Account No");
            Members.SETFILTER(Members.Blocked,'<>%1', Members.Blocked::" ");
            IF Members.FIND('-') THEN BEGIN
              CoopbankTran."Needs Manual Posting":=TRUE;
              CoopbankTran.MODIFY;
              EXIT;
              END;
        
        
          SaccoGenSetUp.RESET;
          SaccoGenSetUp.GET;
          amount:=CoopbankTran."Total Amount";
          TotalAmount:=CoopbankTran."Total Amount";
          SaccoGenSetUp.TESTFIELD(SaccoGenSetUp."COOP ACC");
          PaybillRecon:=SaccoGenSetUp."COOP ACC";//'100857';
        SaccoGenSetUp.RESET;
        SaccoGenSetUp.GET;
        SaccoGenSetUp.TESTFIELD("Insurance Payable A/c");
        SaccoGenSetUp.TESTFIELD("Retained Shares");
        SaccoGenSetUp.TESTFIELD("Registration Fee");
        
        Totalshares:=SaccoGenSetUp."Retained Shares";
        TotalRegFee:=SaccoGenSetUp."Registration Fee";
        
          batch:='COOPDEPOST';
          docNo:=CoopbankTran."Bank Reference code";
          BankRefCode:=CoopbankTran."Bank Reference code";
        
          DocNoLength:=STRLEN(docNo); //get length of doc number
          IF DocNoLength>20 THEN BEGIN
            docNo:=COPYSTR(BankRefCode,1,12);
        
          END ELSE BEGIN
             docNo:=BankRefCode;
          END;
        
           GenSetUp.RESET;
                GenSetUp.GET;
        
          GenJournalLine.RESET;
          GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
          GenJournalLine.SETRANGE("Journal Batch Name",batch);
          GenJournalLine.DELETEALL;
          //end of deletion
        
          LoanPayment.RESET;
          LoanPayment.DELETEALL;
        
        
          GenBatches.RESET;
          GenBatches.SETRANGE(GenBatches."Journal Template Name",'GENERAL');
          GenBatches.SETRANGE(GenBatches.Name,batch);
        
          IF GenBatches.FIND('-') = FALSE THEN BEGIN
            GenBatches.INIT;
            GenBatches."Journal Template Name":='GENERAL';
            GenBatches.Name:=batch;
            GenBatches.Description:='Coop deposits';
            GenBatches.VALIDATE(GenBatches."Journal Template Name");
            GenBatches.VALIDATE(GenBatches.Name);
            GenBatches.INSERT;
          END;//General Jnr Batches
        
        //========================share capital
        Members.RESET;
        Members.SETRANGE(Members."No.",CoopbankTran."Member No");
          IF Members.FIND('-') THEN BEGIN
              MemberLedgerEntry.RESET;
              MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Customer No.",Members."No.");
              MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."Transaction Type"::"Share Capital");
              MemberLedgerEntry.CALCSUMS(MemberLedgerEntry.Amount);
              SharesAmount:=MemberLedgerEntry.Amount;
           END;
        
        //========================registration
        Members.RESET;
        Members.SETRANGE(Members."No.",CoopbankTran."Member No");
          IF Members.FIND('-') THEN BEGIN
              MemberLedgerEntry.RESET;
              MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Customer No.",Members."No.");
              MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."Transaction Type"::"Registration Fee");
              MemberLedgerEntry.CALCSUMS(MemberLedgerEntry.Amount);
              RegfeeAmount:=MemberLedgerEntry.Amount;
           END;
        
        //========================insurance contribution arrears
        Members.RESET;
        Members.SETRANGE(Members."No.",CoopbankTran."Member No");
          IF Members.FIND('-') THEN BEGIN
             Members.CALCFIELDS(Members."Insurance Fund");
              InsuranceAmount:=Members."Insurance Fund";
             // MInsuranceBal:=Members."Insurance Monthly contribution";
           END;
        
        MInsuranceBal:=0;
        
        Members.RESET;
        Members.SETRANGE(Members."No.",CoopbankTran."Member No");
        IF Members.FIND('-') THEN BEGIN
          DateRegistered:=Members."Registration Date";
        END;
        
        IF DateRegistered <>0D THEN BEGIN
        
        RegYear := DATE2DMY(DateRegistered, 3);
        MRegdate := DATE2DMY(DateRegistered, 2);
        
        
        MtodayYear := DATE2DMY(TODAY, 3);
        MToday := DATE2DMY(TODAY, 2);
        
        IF RegYear=MtodayYear THEN BEGIN
        
          // MPayDate:=MToday-MRegdate;
            MPayDate:=(ABS( InsuranceAmount))/100;
          MInsuranceBal:=((MToday-MRegdate)-MPayDate)*100;
          END ELSE BEGIN
        
             MPayDate:=(ABS( InsuranceAmount))/100;
             MInsuranceBal:=(MToday-MPayDate)*100;
        
          END;
        
        END;
        
        //===================minimum monthy contribution
        
        
        Members.RESET;
        Members.SETRANGE(Members."No.",CoopbankTran."Member No");
          IF Members.FIND('-') THEN BEGIN
        
            Monthycontributionbal:=0;
        
             MonthyContribution:=Members."Monthly Contribution";
            IF MonthyContribution=0 THEN BEGIN
              MonthyContribution:=GenSetUp."Min. Contribution";
            END;
        
              MemberLedgerEntry.RESET;
              MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Customer No.",Members."No.");
              MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."Transaction Type"::"Deposit Contribution");
              MemberLedgerEntry.SETFILTER(MemberLedgerEntry."Posting Date", FORMAT(CALCDATE('CM + 1D - 1M',TODAY))+'..'+FORMAT(CALCDATE('CM',TODAY)));
              MemberLedgerEntry.CALCSUMS(MemberLedgerEntry."Credit Amount");
              Monthycontributionbal:=MonthyContribution- ABS(MemberLedgerEntry."Credit Amount");
           END;
        
        
        
        IF (RegfeeAmount*-1)>=TotalRegFee THEN BEGIN
          RemainedRegistration:=0;
        END ELSE BEGIN
          RemainedRegistration:=0;//TotalRegFee-(RegfeeAmount*-1);
        
        END;
        
        
        
        IF (SharesAmount*-1)>=Totalshares THEN BEGIN
          RemainedShares:=0;
        END ELSE BEGIN
          RemainedShares:=Totalshares-(SharesAmount*-1);
        END;
        Members.LOCKTABLE;
            Members.RESET;
            Members.SETRANGE(Members."No.", CoopbankTran."Account No");
            Members.SETRANGE(Members.Blocked, Members.Blocked::" ");
            IF Members.FIND('-') THEN BEGIN
        
        //================================================================Dr COOP settlement ACC
                LineNo:=LineNo+10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name":='GENERAL';
                GenJournalLine."Journal Batch Name":=batch;
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Account Type":=GenJournalLine."Account Type"::"Bank Account";
                GenJournalLine."Account No.":=PaybillRecon;
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No.":=docNo;
                GenJournalLine."External Document No.":=docNo;
                 GenJournalLine."Source No.":=Vendor."No.";
                GenJournalLine."Posting Date":=TODAY;
                GenJournalLine.Description:='Coop Deposits' ;
                GenJournalLine.Amount:=amount;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                IF GenJournalLine.Amount<>0 THEN
                GenJournalLine.INSERT;
        
        //===================================Registration fees
        IF amount>0 THEN BEGIN
              //Cr Customer
                      LineNo:=LineNo+10000;
                      GenJournalLine.INIT;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":=batch;
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                      GenJournalLine."Account No.":=Members."No.";
                      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                      GenJournalLine."Document No.":=docNo;
                      GenJournalLine."External Document No.":=docNo;
                      GenJournalLine."Posting Date":=TODAY;
                      GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Registration Fee";
                      GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Description:=FORMAT(GenJournalLine."Transaction Type"::"Registration Fee");
                      IF amount >= RemainedRegistration THEN
                      GenJournalLine.Amount:=-RemainedRegistration
                      ELSE
                      GenJournalLine.Amount:=-amount;
                      GenJournalLine.VALIDATE(GenJournalLine.Amount);
                      IF GenJournalLine.Amount<>0 THEN
                      GenJournalLine.INSERT;
                      amount:=amount+GenJournalLine.Amount;
          END;
        
        //===================================Share Capital
        IF RemainedShares>0 THEN BEGIN
        IF amount>0 THEN BEGIN
              //Cr Customer
                      LineNo:=LineNo+10000;
                      GenJournalLine.INIT;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":=batch;
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                      GenJournalLine."Account No.":=Members."No.";
                      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                      GenJournalLine."Document No.":=docNo;
                      GenJournalLine."External Document No.":=docNo;
                      GenJournalLine."Posting Date":=TODAY;
                      GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Share Capital";
                      GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Description:=FORMAT(GenJournalLine."Transaction Type"::"Share Capital");
                      IF amount >= RemainedShares THEN
                      GenJournalLine.Amount:=-RemainedShares
                      ELSE
                      GenJournalLine.Amount:=-amount;
                      GenJournalLine.VALIDATE(GenJournalLine.Amount);
                      IF GenJournalLine.Amount<>0 THEN
                      GenJournalLine.INSERT;
                      amount:=amount+GenJournalLine.Amount;
          END;
        END;
        
        
        //================================insurance
        IF MInsuranceBal>0 THEN BEGIN
        IF amount>0 THEN BEGIN
              //Cr Customer
                      LineNo:=LineNo+10000;
                      GenJournalLine.INIT;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":=batch;
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                      GenJournalLine."Account No.":=Members."No.";
                      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                      GenJournalLine."Document No.":=docNo;
                      GenJournalLine."External Document No.":=docNo;
                      GenJournalLine."Posting Date":=TODAY;
                      GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Insurance Contribution";
                      GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Description:=FORMAT(GenJournalLine."Transaction Type"::"Insurance Contribution");
                      IF amount > MInsuranceBal THEN
                      GenJournalLine.Amount:=-MInsuranceBal
                      ELSE
                      GenJournalLine.Amount:=-amount;
                      GenJournalLine.VALIDATE(GenJournalLine.Amount);
                      IF GenJournalLine.Amount<>0 THEN
                      GenJournalLine.INSERT;
                      amount:=amount+GenJournalLine.Amount;
          END;
        END;
        
        
        //================================check minimum contribution monthly
        IF Monthycontributionbal>0 THEN BEGIN
        IF amount>0 THEN BEGIN
              //Cr Customer
                      LineNo:=LineNo+10000;
                      GenJournalLine.INIT;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":=batch;
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                      GenJournalLine."Account No.":=Members."No.";
                      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                      GenJournalLine."Document No.":=docNo;
                      GenJournalLine."External Document No.":=docNo;
                      GenJournalLine."Posting Date":=TODAY;
                      GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Deposit Contribution";
                      GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Description:=FORMAT(GenJournalLine."Transaction Type"::"Deposit Contribution");
                      IF amount >= Monthycontributionbal THEN
                      GenJournalLine.Amount:=-Monthycontributionbal
                      ELSE
                      GenJournalLine.Amount:=-amount;
                      GenJournalLine.VALIDATE(GenJournalLine.Amount);
                      IF GenJournalLine.Amount<>0 THEN
                      GenJournalLine.INSERT;
                      amount:=amount+GenJournalLine.Amount;
          END;
        END;
        
        //===============================================================check any outstanding loan
        
                LoansRegister.RESET;
                LoansRegister.SETRANGE(LoansRegister."Client Code",Members."No.");
                IF LoansRegister.FIND('-') THEN BEGIN
        
               REPEAT
                 PrincipalAmount:=0;
                 TransactionLoanDiff:=0;
                  LoansRegister.CALCFIELDS(LoansRegister."Oustanding Interest",LoansRegister."Outstanding Balance");
               IF  (LoansRegister."Outstanding Balance">0)  THEN BEGIN
        
                LoanRepaymentS.RESET;
                LoanRepaymentS.SETRANGE(LoanRepaymentS."Loan No.",LoansRegister."Loan  No.");
                IF LoanRepaymentS.FIND('-') THEN BEGIN
                  REPEAT
        
                       Fulldate:= DMY2DATE(DATE2DMY(20110528D,1),DATE2DMY(TODAY,2),DATE2DMY(TODAY,3));
                       LastRepayDate:= DMY2DATE(DATE2DMY(20110528D,1),DATE2DMY(LoanRepaymentS."Repayment Date",2),DATE2DMY(LoanRepaymentS."Repayment Date",3));
        
                     IF Fulldate>=LastRepayDate THEN BEGIN
                       PrincipalAmount:= PrincipalAmount+LoanRepaymentS."Principal Repayment";
                       END;
                     //  EXIT
                   UNTIL LoanRepaymentS.NEXT=0;
                END;
        
        
                MemberLedgerEntry.RESET;
                MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Loan No",LoansRegister."Loan  No.");
                MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."Transaction Type"::Repayment);
                MemberLedgerEntry.CALCSUMS(MemberLedgerEntry."Credit Amount (LCY)");
                TransactionLoanAmt:=MemberLedgerEntry."Credit Amount (LCY)";
        
                MESSAGE(FORMAT(TransactionLoanAmt));
                 MESSAGE(FORMAT(PrincipalAmount));
        
                TransactionLoanDiff:=PrincipalAmount-TransactionLoanAmt;
        
                IF TransactionLoanDiff>0 THEN BEGIN
                  RepayedLoanAmt:=TransactionLoanDiff;
                  END ELSE BEGIN
                   RepayedLoanAmt:=0;
                END;
        
          //==========================interest
        
                IF LoansRegister."Oustanding Interest">0 THEN BEGIN
        
                 IF amount>0 THEN BEGIN
                LineNo:=LineNo+10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name":='GENERAL';
                GenJournalLine."Journal Batch Name":=batch;
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                GenJournalLine."Account No.":=LoansRegister."Client Code";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No.":=docNo;
                GenJournalLine."External Document No.":=docNo;
                GenJournalLine."Posting Date":=TODAY;
                GenJournalLine.Description:='Loan Interest Payment';
        
                IF amount > LoansRegister."Oustanding Interest" THEN
                 InterestAmount:=-LoansRegister."Oustanding Interest"
                ELSE
                InterestAmount:=-amount;
        
                GenJournalLine.Amount:=InterestAmount;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Interest Paid";
        
                IF GenJournalLine."Shortcut Dimension 1 Code" = '' THEN BEGIN
                GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                END;
                GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                IF GenJournalLine.Amount<>0 THEN
                GenJournalLine.INSERT;
                amount:=amount+GenJournalLine.Amount;
        
        
                LoanProductsSetup.RESET;
        
                IF LoanProductsSetup.GET(LoansRegister."Loan Product Type") THEN BEGIN
                    VarReceivableAccount:=LoanProductsSetup."Receivable Interest Account";
               //------------------------------------1. DEBIT INTEREST RECEIVABLE CONTROL A/C---------------------------------------------------------------------------------------------
                LineNo:=LineNo+10000;
                SFactory.FnCreateGnlJournalLine('GENERAL',batch,docNo,LineNo,GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"G/L Account",GenSetUp."A/c Interest Receivable",TODAY,InterestAmount*-1,'BOSA',LoansRegister."Loan  No.",
                'Interest Paid- '+'-'+LoansRegister."Loan  No.",LoansRegister."Loan  No.");
                //--------------------------------(Debit Member Loan Account)---------------------------------------------
        
                //------------------------------------2. CREDIT MEMBER INTEREST RECEIVABLE A/C---------------------------------------------------------------------------------------------
                LineNo:=LineNo+10000;
                SFactory.FnCreateGnlJournalLine('GENERAL',batch,docNo,LineNo,GenJournalLine."Transaction Type"::"Interest Due",
                GenJournalLine."Account Type"::"G/L Account",VarReceivableAccount,TODAY,InterestAmount,'BOSA',LoansRegister."Loan  No.",
                'Interest Paid- '+'-'+LoansRegister."Loan  No.",LoansRegister."Loan  No.");
                //----------------------------------(CREDIT MEMBER INTEREST RECEIVABLE A/C-)------------------------------------------------
        
        
                END;//loan product type
                END;// amount
                END;// outstanding interest
        
        //==========================principal
        IF LoansRegister."Outstanding Balance">0 THEN BEGIN
        
                IF amount>0 THEN BEGIN
        
                LineNo:=LineNo+10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name":='GENERAL';
                GenJournalLine."Journal Batch Name":=batch;
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                GenJournalLine."Account No.":=LoansRegister."Client Code";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No.":=docNo;
                GenJournalLine."External Document No.":=docNo;
                GenJournalLine."Posting Date":=TODAY;
                GenJournalLine.Description:='Loan Repayment';
                 IF amount >= RepayedLoanAmt THEN BEGIN
                GenJournalLine.Amount:=-RepayedLoanAmt;
                   Totalprinciple:=RepayedLoanAmt;
                 END ELSE BEGIN
                  GenJournalLine.Amount:=-amount;
                  Totalprinciple:=-amount;
                 END;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Repayment;
                IF GenJournalLine."Shortcut Dimension 1 Code" = '' THEN BEGIN
                GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                END;
                GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                IF GenJournalLine.Amount<>0 THEN BEGIN
                GenJournalLine.INSERT;
                amount:=amount+ GenJournalLine.Amount;
        
                END;
                 LoanPayment.RESET;
                 IF LoanPayment.FIND('+') THEN BEGIN
                iEntryNo:=LoanPayment."Entry no";
                iEntryNo:=iEntryNo+1;
                END
                ELSE BEGIN
                iEntryNo:=1;
                END;
                LoanPayment.INIT;
                LoanPayment."Entry no":=iEntryNo;
                LoanPayment.Member:=Members."No.";
                LoanPayment."Loan No":=LoansRegister."Loan  No.";
                LoanPayment."Outstanding bal":=LoansRegister."Outstanding Balance";
                LoanPayment.OutPaid:=Totalprinciple;
                LoanPayment."Remaining bal":=ABS(LoansRegister."Outstanding Balance")-ABS(Totalprinciple);
                LoanPayment.INSERT;
                END;
            END;
        
        END;
        UNTIL LoansRegister.NEXT=0;
        END;
        
        
        //===============================================================pay all loans outstanding
        
                LoanPayment.RESET;
                LoanPayment.SETASCENDING(LoanPayment."Entry no", TRUE);
                LoanPayment.SETRANGE(LoanPayment.Member,Members."No.");
                IF LoanPayment.FIND('-') THEN BEGIN
        
               REPEAT
                //  LoansRegister.CALCFIELDS(LoansRegister."Oustanding Interest",LoansRegister."Outstanding Balance");
               IF  (LoanPayment."Remaining bal">0)  THEN BEGIN
        
                IF amount>0 THEN BEGIN
                LineNo:=LineNo+10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name":='GENERAL';
                GenJournalLine."Journal Batch Name":=batch;
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                GenJournalLine."Account No.":=Members."No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No.":=docNo;
                GenJournalLine."External Document No.":=docNo;
                GenJournalLine."Posting Date":=TODAY;
                GenJournalLine.Description:='Loan Repayment';
                 IF amount >= LoanPayment."Remaining bal" THEN
                GenJournalLine.Amount:=-LoanPayment."Remaining bal"
                ELSE
                GenJournalLine.Amount:=-amount;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Repayment;
                IF GenJournalLine."Shortcut Dimension 1 Code" = '' THEN BEGIN
                GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                END;
                GenJournalLine."Loan No":=LoanPayment."Loan No";
                IF GenJournalLine.Amount<>0 THEN BEGIN
                GenJournalLine.INSERT;
                amount:=amount+ GenJournalLine.Amount;
                END;
                END;
                END;
                UNTIL LoansRegister.NEXT=0;
        END;
        
        
        
        
        
        //======================================Deposit contribution
        IF amount>0 THEN BEGIN
              //Cr Customer
                      LineNo:=LineNo+10000;
                      GenJournalLine.INIT;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":=batch;
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                      GenJournalLine."Account No.":=Members."No.";
                      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                      GenJournalLine."Document No.":=docNo;
                      GenJournalLine."External Document No.":=docNo;
                      GenJournalLine."Posting Date":=TODAY;
                      GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Deposit Contribution";
                      GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Description:=FORMAT(GenJournalLine."Transaction Type"::"Deposit Contribution");
                      GenJournalLine.Amount:=(amount)*-1;
                      GenJournalLine.VALIDATE(GenJournalLine.Amount);
                      IF GenJournalLine.Amount<>0 THEN
                      GenJournalLine.INSERT;
                      amount:=amount+GenJournalLine.Amount;
          END;
        
        
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                    GenJournalLine.SETRANGE("Journal Batch Name",batch);
                    IF GenJournalLine.FIND('-') THEN BEGIN
                    REPEAT
                     GLPosting.RUN(GenJournalLine);
                    UNTIL GenJournalLine.NEXT = 0;
                      msg:='Dear ' +SplitString(Members.Name,' ')+', your deposit of Ksh. '+ FORMAT(TotalAmount) +' at '+FORMAT(CURRENTDATETIME)+' Reference No. '+docNo+
                      ' from Coop Bank have been credited to your account. Check your online statement for more details';
                      SMSMessage(batch,Members."No.",Members."Phone No.",msg,'');
                      CoopbankTran."Bank Reference code":=docNo;
                      CoopbankTran.posted:=TRUE;
                      CoopbankTran."Date Posted":=TODAY;
                      CoopbankTran.MODIFY;
                      resut:='TRUE';
        
                    END
                    ELSE BEGIN
                      CoopbankTran."Date Posted":=TODAY;
                      CoopbankTran."Needs Manual Posting":=TRUE;
                      CoopbankTran.MODIFY;
                     resut:='FALSE';
                    END;
        
        
        END;
        END;
        */

    end;


    procedure SplitString(sText: Text; separator: Text) Token: Text
    var
        Pos: Integer;
        Tokenq: Text;
    begin
        Pos := StrPos(sText, separator);
        if Pos > 0 then begin
            Token := CopyStr(sText, 1, Pos - 1);
            if Pos + 1 <= StrLen(sText) then
                sText := CopyStr(sText, Pos + 1)
            else
                sText := '';
        end else begin
            Token := sText;
            sText := '';
        end;
    end;

    local procedure FnsentSMS()
    var
        SharesAmount: Decimal;
        Totalshares: Decimal;
        RemainedShares: Decimal;
    begin
        /*Members.RESET;
        Members.SETRANGE(Members."Certificate No",'');
        IF Members.FIND('-') THEN BEGIN
          REPEAT
            IF (Members.Status=Members.Status::Active) OR  (Members.Status=Members.Status::Dormant) THEN BEGIN
               IF Members."Mobile Phone No" <>'' THEN BEGIN
             msg:='Dear '+SplitString(Members.Name, ' ')+', Our online payment service Digipesa App and USSD *850# and Web-portal are now up and running well . We apologize for the inconvience caused.';
             SMSMessage('BULKSMS',Members."No.",Members."Mobile Phone No",COPYSTR(msg,1,250),COPYSTR(msg,251,500));
             END;
              END;
          UNTIL Members.NEXT=0;
          MESSAGE('DONE');
        END;
        */
        //========================share capital

    end;


    procedure AdvanceEligibility(account: Text[50]) Res: Text
    var
        StoDedAmount: Decimal;
        STO: Record "Standing Orders";
        FOSALoanRepayAmount: Decimal;
        CumulativeNet: Decimal;
        LastSalaryDate: Date;
        FirstSalaryDate: Date;
        AvarageNetPay: Decimal;
        AdvQualificationAmount: Decimal;
        CumulativeNet2: Decimal;
        finalAmount: Decimal;
        interestAMT: Decimal;
        MaxLoanAmt: Decimal;
        LastPaydate: Date;
        MPayDate: Decimal;
        MToday: Decimal;
        DateRegistered: Date;
        MtodayYear: Decimal;
        RegYear: Decimal;
        MtodayDiff: Decimal;
        MRegdate: Decimal;
        ComittedShares: Decimal;
        LoanGuarantors: Record "Loans Guarantee Details";
        FreeShares: Decimal;
        TotalAmount: Decimal;
        TransactionLoanAmt: Decimal;
        TransactionLoanDiff: Decimal;
        RepayedLoanAmt: Decimal;
        LoanRepaymentS: Record "Loan Repayment Schedule";
        Fulldate: Date;
        LastRepayDate: Date;
        PrincipalAmount: Decimal;
    begin

        amount := 0;
        Res := Format(amount) + '::::' + 'Service Not available::::false';
        //  EXIT;

        //=================================================must be member for 6 months

        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", account);
        // Vendor.SETRANGE( Vendor."Account Type",'CURRENT');
        Vendor.SetRange(Vendor.Status, Vendor.Status::Active);

        if Vendor.Find('-') then begin
            // --
        end else begin
            Res := Format(amount) + '::::' + 'You do not qualify for eloan Account not found::::false';
            exit;
        end;


        Members.Reset;
        Members.SetRange(Members."No.", Vendor."BOSA Account No");
        if Members.Find('-') then begin
            DateRegistered := Members."Registration Date";

            if Members.ELoanApplicationNotAllowed = true then begin
                Res := Format(amount) + '::::' + 'You do not qualify for eloan, contact customer care to be assisted::::false';
                exit;
            end;
        end;

        if Members.Status <> Members.Status::Active then begin
            Res := Format(amount) + '::::' + 'You do not qualify for eloan because your account has not been active::::false';
            exit;
        end;


        if DateRegistered <> 0D then begin
            MtodayYear := Date2dmy(Today, 3);
            RegYear := Date2dmy(DateRegistered, 3);
            MRegdate := Date2dmy(DateRegistered, 2);

            MToday := Date2dmy(Today, 2) + MRegdate;

            if CalcDate('6M', DateRegistered) > Today then begin
                amount := 1;
                Res := Format(amount) + '::::' + 'You do not qualify for eloan because your account has not been active for last six months::::false';
            end;
        end else begin
            amount := 1;
            Res := Format(amount) + '::::' + 'You do not qualify for eloan because your account has not been active for last six months::::false';
        end;



        if amount <> 1 then begin
            LoanOut := 0;
            LoansRegister.Reset;
            LoansRegister.SetRange(LoansRegister."Client Code", Members."No.");
            LoansRegister.SetRange(LoansRegister.Posted, true);
            //  LoansRegister.SETRANGE(LoansRegister."Loan Product Type",'E-LOAN');
            if LoansRegister.Find('-') then begin
                repeat
                    LoansRegister.CalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
                    if (LoansRegister."Outstanding Balance" > 0) then begin

                        // =================================== Check if member has an outstanding E-LOAN

                        if (LoansRegister."Loan Product Type" = 'E-LOAN') then begin
                            amount := 2;
                            Res := Format(amount) + '::::' + 'You do not qualify for eloan because you have outstanding E-loan ::::false';

                            exit;
                        end;

                        if (LoansRegister."Loan Product Type" = 'JSORT LOAN') then begin
                            amount := 2;
                            Res := Format(amount) + '::::' + 'You do not qualify for eloan because you have outstanding jsort loan ::::false';

                            exit;
                        end;

                        if (LoansRegister."Loans Category-SASRA" <> LoansRegister."loans category"::Perfoming) then begin
                            amount := 4;
                            Res := Format(amount) + '::::' + 'You do not qualify for eloan because you have a loan that is under performing ::::false';

                            exit;
                        end;

                        if (LoansRegister."Loan Product Type" = 'MORGAGE') then begin
                            LoanOut := LoanOut + (LoansRegister."Outstanding Balance") + LoansRegister."Oustanding Interest";
                        end;

                        if (LoansRegister."Loan Product Type" = 'CARLON') then begin
                            LoanOut := LoanOut + (LoansRegister."Outstanding Balance") + LoansRegister."Oustanding Interest";
                        end;

                    end;
                until LoansRegister.Next = 0;
            end;

            //=============================================Get penalty
            MpesaDisbus.Reset;
            MpesaDisbus.SetCurrentkey(MpesaDisbus."Entry No");
            MpesaDisbus.Ascending(false);
            MpesaDisbus.SetRange(MpesaDisbus."Member No", account);
            if MpesaDisbus.Find('-') then begin
                if MpesaDisbus."Penalty Date" <> 0D then begin
                    if (Today <= CalcDate('1Y', MpesaDisbus."Penalty Date")) then begin
                        amount := 4;
                        Res := Format(amount) + '::::' + 'You do not qualify for eloan because you have been penalized for late Payment ::::false';
                        exit;
                    end;
                end;
            end;


            //=========================================== last 6 months deposit contribution

            countTrans := 0;
            MemberLedgerEntry.Reset;
            MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Format(Members."No."));
            MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Deposit Contribution");
            MemberLedgerEntry.SetFilter(MemberLedgerEntry."Posting Date", Format(CalcDate('CM+1D-7M', Today)) + '..' + Format(CalcDate('CM', Today)));
            MemberLedgerEntry.SetFilter(MemberLedgerEntry.Description, '<>%1', 'Opening Balance');
            MemberLedgerEntry.SetCurrentkey(MemberLedgerEntry."Posting Date");
            MemberLedgerEntry.Ascending(false);
            MemberLedgerEntry.SetFilter(MemberLedgerEntry."Credit Amount", '>%1', 0);
            if MemberLedgerEntry.Find('-') then begin
                repeat
                    //    IF ABS(MemberLedgerEntry."Credit Amount")>0 THEN BEGIN
                    MemberLedgerEntry2.Reset;
                    MemberLedgerEntry2.SetRange(MemberLedgerEntry2."Customer No.", Format(Members."No."));
                    MemberLedgerEntry2.SetRange(MemberLedgerEntry2."Transaction Type", MemberLedgerEntry."transaction type"::"Deposit Contribution");
                    MemberLedgerEntry2.SetRange(MemberLedgerEntry2."Posting Date", MemberLedgerEntry."Posting Date");
                    MemberLedgerEntry2.SetFilter(MemberLedgerEntry2.Description, '<>%1', 'Opening Balance');
                    MemberLedgerEntry2.SetFilter(MemberLedgerEntry2."Credit Amount", '>%1', 0);
                    if MemberLedgerEntry2.FindLast then begin
                        countTrans := countTrans + 1;
                    end;
                //   END;
                until MemberLedgerEntry.Next = 0;
            end;


            if countTrans <> 0 then begin
                //      IF countTrans<6 THEN BEGIN
                //        amount:=6;
                //      END;
                if countTrans < 3 then begin
                    amount := 6;
                end;
            end else begin
                amount := 6;
            end;

            if amount = 6 then begin
                // ** condition to be reinstated after 6 months - from feb 2022
                Res := '0::::You do not qualify for this loan because you NOT consistency saved your contribution for last 6 Months::::False';
                exit;
            end;


            if amount <> 2 then begin
                if amount <> 3 then begin
                    //IF amount<>4 THEN BEGIN
                    // =========================================================Get Free Shares
                    /* ComittedShares:=0;
                     LoanGuarantors.RESET;
                     LoanGuarantors.SETRANGE(LoanGuarantors."Member No",Members."No.");
                     LoanGuarantors.SETRANGE(LoanGuarantors.Substituted,FALSE);
                     IF LoanGuarantors.FIND('-') THEN BEGIN
                     REPEAT
                     IF LoansRegister.GET(LoanGuarantors."Loan No") THEN BEGIN
                     LoansRegister.CALCFIELDS(LoansRegister."Outstanding Balance");
                     IF LoansRegister."Outstanding Balance" > 0 THEN BEGIN
                     ComittedShares:=ComittedShares+LoanGuarantors."Amont Guaranteed";
                     END;
                     END;
                     UNTIL LoanGuarantors.NEXT = 0;
                     END;
                     */
                    // IF

                    Members.CalcFields(Members."Current Shares", Members."Outstanding Balance", Members."Outstanding Interest", Members."Shares Retained");

                    if Members."Shares Retained" < 5000 then begin
                        amount := 4;
                        Res := Format(amount) + '::::' + 'You do not qualify for eloan because your share capital is below required amount of Ksh. 5,000 ::::false';
                        exit;
                    end;
                    Message('AMOUNT %1', LoanOut);

                    FreeShares := (Members."Current Shares" * 3) - (Members."Outstanding Balance" + Members."Outstanding Interest" - LoanOut);

                    // ** get 1/3 of the member deposits

                    if (FreeShares > (Members."Current Shares" * 0.3)) then begin
                        amount := Members."Current Shares" * 0.3;
                    end else begin
                        amount := FreeShares;//amount:=FreeShares*0.3;
                    end;

                    //==================================================Get maximum loan amount
                    LoanProductsSetup.Reset;
                    LoanProductsSetup.SetRange(LoanProductsSetup.Code, 'E-LOAN');
                    if LoanProductsSetup.Find('-') then begin
                        interestAMT := LoanProductsSetup."Interest rate";
                        MaxLoanAmt := LoanProductsSetup."Max. Loan Amount";
                    end;

                    if amount > MaxLoanAmt then begin
                        amount := MaxLoanAmt;
                        Res := Format(amount) + '::::' + 'You Qualify for eloan upto Ksh. ' + Format(amount) + ' Do you want to apply  ::::false';
                    end else begin
                        // amount:=MaxLoanAmt;
                        Res := Format(amount) + '::::' + 'You Qualify for eloan upto Ksh. ' + Format(amount) + ' Do you want to apply  ::::false';
                    end;

                    if amount < 0 then begin
                        Res := Format(amount) + '::::' + 'You do not qualify for eloan Because your deposits have been used to Guarantee other loans::::false';
                    end;

                end;
            end;
        end;

    end;


    procedure PostNormalLoan(docNo: Code[20]; AccountNo: Code[50]; amount: Decimal; Period: Decimal) result: Code[30]
    var
        LoanAcc: Code[30];
        InterestAcc: Code[30];
        InterestAmount: Decimal;
        AmountToCredit: Decimal;
        loanNo: Text[20];
        advSMS: Decimal;
        advFee: Decimal;
        advApp: Decimal;
        advSMSAcc: Code[20];
        advFEEAcc: Code[20];
        advAppAcc: Code[20];
        advSMSDesc: Text[100];
        advFeeDesc: Text[100];
        advAppDesc: Text[100];
        LoanProdCharges: Record "Loan Product Charges";
        SaccoNoSeries: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LoanRepSchedule: Record "Loan Repayment Schedule";
        loanType: Code[50];
        InsuranceAcc: Code[10];
        ObjLoanPurpose: Record "Loans Purpose";
        SaccoNo: Record "No. Series";
        AmountDispursed: Decimal;
        insurancefee: Decimal;
    begin
        //loanType:='322';
        SurePESATrans.Reset;
        SurePESATrans.SetRange(SurePESATrans."Document No", docNo);
        if SurePESATrans.Find('-') then begin
            result := 'REFEXISTS';
            exit(result);
        end else begin

            GenSetUp.Reset;
            GenSetUp.Get();
            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;

            //............INSURANCE
            LoanProductsSetup.Reset;
            LoanProductsSetup.SetRange(LoanProductsSetup.Code, 'E-LOAN');
            if LoanProductsSetup.FindFirst() then begin
                LoanAcc := LoanProductsSetup."Loan Account";
                InterestAcc := LoanProductsSetup."Loan Interest Account";
                InsuranceAcc := LoanProductsSetup."Loan Insurance Accounts";
            end;
            //loan charges
            LoanProdCharges.Reset;
            LoanProdCharges.SetRange(LoanProdCharges."Product Code", 'E-LOAN');
            LoanProdCharges.SetRange(LoanProdCharges.Code, loanType);
            if LoanProdCharges.FindFirst() then begin
                advApp := LoanProdCharges.Amount;
                advAppAcc := LoanProdCharges."G/L Account";
                advAppDesc := LoanProdCharges.Description;
            end;

            //sms charge
            LoanProdCharges.Reset;
            LoanProdCharges.SetRange(LoanProdCharges.Code, 'E-LOAN');
            LoanProdCharges.SetRange(LoanProdCharges."Product Code", 'INSCHARGE');
            if LoanProdCharges.FindFirst() then begin
                insurancefee := 0;
                insurancefee := ROUND((((5.03 * 1 + 3.03) * amount / 6000) * 0.5), 0.05, '>');
                if insurancefee > 1000 then
                    insurancefee := 1000;

                advSMS := insurancefee;//(LoanProdCharges.Amount);
                advSMSAcc := LoanProdCharges."G/L Account";
                advSMSDesc := LoanProdCharges.Description;

            end;

            //loan proccessing fee
            LoanProdCharges.Reset;
            LoanProdCharges.SetRange(LoanProdCharges."Product Code", 'LPFEE');
            LoanProdCharges.SetRange(LoanProdCharges.Code, 'E-LOAN');
            if LoanProdCharges.FindFirst() then begin
                advFee := (LoanProdCharges.Amount) * amount;
                advFEEAcc := LoanProdCharges."G/L Account";
                advFeeDesc := LoanProdCharges.Description;
            end;
            SaccoGenSetup.Reset;
            SaccoGenSetup.Get;
            //   SaccoGenSetup.TESTFIELD("MPESA Acc");
            //  MpesaAccount:=0;//SaccoGenSetup."MPESA Acc";
            MPESACharge := 0;//GetCharge(amount,'MPESA');

            CloudPESACharge := 10;//GenLedgerSetup."CloudPESA Charge";
            CloudPESACommACC := GenLedgerSetup."CloudPESA Comm Acc";
            InterestAmount := (LoanProductsSetup."Interest rate" / 100) * amount;
            AmountToCredit := amount + InterestAmount + MPESACharge;
            //ExcDuty:=(10/100)*(MobileCharges+SurePESACharge);
            TotalCharges := CloudPESACharge + advSMS + advFee;
            CloudPESACharge := CloudPESACharge;
            ;
            AmountDispursed := amount;
            //  Members.RESET;
            //   Members.SETRANGE(Members."No.", AccountNo);
            //   IF Members.FIND('-') THEN BEGIN



            Vendor.Reset;
            Vendor.SetRange(Vendor."No.", AccountNo);
            //    Vendor.SETRANGE( Vendor."Account Type",'CURRENT');
            Vendor.SetRange(Vendor.Status, Vendor.Status::Active);
            //
            if Vendor.Find('-') then begin

                Members.Reset;
                Members.SetRange(Members."No.", Vendor."BOSA Account No");
                if Members.Find('-') then begin

                end;

                //*******Create Loan *********//
                SaccoNoSeries.Reset;
                SaccoNoSeries.Get;
                SaccoNoSeries.TestField(SaccoNoSeries."BOSA Loans Nos");
                NoSeriesMgt.InitSeries(SaccoNoSeries."BOSA Loans Nos", LoansRegister."No. Series", 0D, LoansRegister."Loan  No.", LoansRegister."No. Series");
                loanNo := LoansRegister."Loan  No.";

                LoansRegister.Init;
                LoansRegister."Approved Amount" := amount;
                LoansRegister.Interest := LoanProductsSetup."Interest rate";
                LoansRegister."Instalment Period" := LoanProductsSetup."Instalment Period";
                LoansRegister.Repayment := amount + InterestAmount + MPESACharge;
                LoansRegister."Expected Date of Completion" := CalcDate('1M', Today);
                LoansRegister.Posted := true;
                Members.CalcFields(Members."Current Shares", Members."Outstanding Balance", Members."Current Loan");
                LoansRegister."Shares Balance" := Members."Current Shares";
                LoansRegister."Amount Disbursed" := amount;
                LoansRegister.Savings := Members."Current Shares";
                LoansRegister."Interest Paid" := 0;
                LoansRegister."Issued Date" := Today;
                LoansRegister.Source := LoanProductsSetup.Source;
                LoansRegister."Loan Disbursed Amount" := amount;
                //  LoansRegister."Scheduled Principal to Date":=AmountDispursed;
                LoansRegister."Current Interest Paid" := 0;
                LoansRegister."Loan Disbursement Date" := Today;
                LoansRegister."Client Code" := Members."No.";
                LoansRegister."Client Name" := Members.Name;
                LoansRegister."Outstanding Balance to Date" := AmountDispursed;
                LoansRegister."Existing Loan" := Members."Outstanding Balance";
                //LoansRegister."Staff No":=Members."Payroll/Staff No";
                LoansRegister.Gender := Members.Gender;
                LoansRegister."BOSA No" := Members."No.";
                // LoansRegister."Branch Code":=Vendor."Global Dimension 2 Code";
                LoansRegister."Requested Amount" := amount;
                LoansRegister."ID NO" := Members."ID No.";
                if LoansRegister."Branch Code" = '' then
                    LoansRegister."Branch Code" := Members."Global Dimension 2 Code";
                LoansRegister."Loan  No." := loanNo;
                LoansRegister."No. Series" := SaccoNoSeries."BOSA Loans Nos";
                LoansRegister."Doc No Used" := docNo;
                LoansRegister."Loan Interest Repayment" := InterestAmount;
                LoansRegister."Loan Principle Repayment" := AmountDispursed;
                LoansRegister."Loan Repayment" := amount + InterestAmount;
                LoansRegister."Employer Code" := Members."Employer Code";
                LoansRegister."Approval Status" := LoansRegister."approval status"::Approved;
                LoansRegister."Account No" := Members."No.";
                LoansRegister."Application Date" := Today;
                LoansRegister."Loan Product Type" := LoanProductsSetup.Code;
                LoansRegister."Loan Product Type Name" := LoanProductsSetup."Product Description";
                LoansRegister."Loan Disbursement Date" := Today;
                LoansRegister."Repayment Start Date" := Today;
                LoansRegister."Recovery Mode" := LoansRegister."recovery mode"::Checkoff;
                //  LoansRegister."Disburesment Type":=LoansRegister."Disburesment Type"::"Full/Single disbursement";
                LoansRegister."Requested Amount" := amount;
                LoansRegister."Approved Amount" := AmountDispursed;
                LoansRegister.Installments := 1;
                LoansRegister."Loan Amount" := AmountDispursed;
                LoansRegister."Issued Date" := Today;
                LoansRegister."Outstanding Balance" := 0;//Update
                LoansRegister."Repayment Frequency" := LoansRegister."repayment frequency"::Monthly;
                LoansRegister."Mode of Disbursement" := LoansRegister."mode of disbursement"::EFT;
                LoansRegister.Insert(true);

                // InterestAmount:=0;

                //**********Process Loan*******************//

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MOBILELOAN');
                GenJournalLine.DeleteAll;
                //end of deletion

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                GenBatches.SetRange(GenBatches.Name, 'MOBILELOAN');

                if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name" := 'GENERAL';
                    GenBatches.Name := 'MOBILELOAN';
                    GenBatches.Description := 'Normal Loan';
                    GenBatches.Validate(GenBatches."Journal Template Name");
                    GenBatches.Validate(GenBatches.Name);
                    GenBatches.Insert;
                end;



                //Post Loan
                LoansRegister.Reset;
                LoansRegister.SetRange(LoansRegister."Loan  No.", loanNo);
                if LoansRegister.Find('-') then begin

                    //Dr loan Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                    GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                    GenJournalLine."Account No." := Members."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := Members."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'MBanking Loan Disbursment -' + LoansRegister."Loan  No.";
                    GenJournalLine.Amount := AmountDispursed;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;



                    //Cr Interest Eloan
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                    GenJournalLine."Account No." := Members."No.";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Due";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := docNo + ' ' + 'Interest charged';
                    GenJournalLine.Amount := ROUND(InterestAmount, 1, '>');
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if LoanProductsSetup.Get(LoansRegister."Loan Product Type") then begin
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := LoanProductsSetup."Loan Interest Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    end;
                    if LoansRegister.Source = LoansRegister.Source::BOSA then begin
                        GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                    end;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //interest paid

                    //DR Customer Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := Vendor."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := Vendor."No.";
                    GenJournalLine.Description := 'MBanking Loan Disbursment -' + LoansRegister."Loan  No.";
                    GenJournalLine.Amount := AmountDispursed * -1;
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Dr Withdrawal Charges
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := Vendor."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := Vendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'MBanking loan disbursment' + ' ' + 'Charges';
                    GenJournalLine.Amount := TotalCharges;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //CR Excise Duty
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := Format(ExxcDuty);
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := Vendor."No.";
                    GenJournalLine."Source No." := Vendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Balance Inquiry' + ' Excise Duty';
                    GenJournalLine.Amount := ExcDuty * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //CR Insurance Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := advSMSAcc;//Adv
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := Vendor."No.";
                    GenJournalLine."Source No." := Vendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'E-LOAN Insurance ' + Vendor.Name;
                    GenJournalLine.Amount := advSMS * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //CR application Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := advFEEAcc;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := Vendor."No.";
                    GenJournalLine."Source No." := Vendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'E-LOAN Application fee ' + Vendor.Name;
                    GenJournalLine.Amount := advFee * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;



                    //CR Surestep Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := CloudPESACommACC;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := MobileChargesACC;
                    GenJournalLine."Source No." := Vendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Eloan disbursment ' + ' Charges';
                    GenJournalLine.Amount := -CloudPESACharge;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Post
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'MOBILELOAN');
                    if GenJournalLine.Find('-') then begin
                        repeat
                            GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;

                        //***************Update Loan Status************//
                        LoansRegister."Loan Status" := LoansRegister."loan status"::Issued;
                        LoansRegister."Amount Disbursed" := AmountToCredit;
                        LoansRegister.Posted := true;
                        // LoansRegister."Interest Upfront Amount":=InterestAmount;
                        LoansRegister."Outstanding Balance" := amount;
                        LoansRegister.Modify;

                        //=====================insert to Mpesa mobile disbursment
                        MpesaDisbus.Reset;
                        MpesaDisbus.SetRange(MpesaDisbus."Document No", docNo);
                        if MpesaDisbus.Find('-') = false then begin

                            MpesaDisbus."Account No" := Members."No.";
                            MpesaDisbus."Document Date" := Today;
                            MpesaDisbus."Loan Amount" := (AmountDispursed - MPESACharge);
                            MpesaDisbus."Document No" := docNo;
                            MpesaDisbus."Batch No" := 'MOBILE';
                            MpesaDisbus."Date Entered" := Today;
                            MpesaDisbus."Time Entered" := Time;
                            MpesaDisbus."Entered By" := UserId;
                            MpesaDisbus."Member No" := Members."No.";
                            MpesaDisbus."Telephone No" := Members."Mobile Phone No";
                            MpesaDisbus."Corporate No" := 'FOSA';
                            MpesaDisbus."Delivery Center" := 'MPESA';
                            MpesaDisbus."Customer Name" := Members.Name;
                            MpesaDisbus.Status := MpesaDisbus.Status::Pending;
                            MpesaDisbus.Purpose := 'Emergency';
                            MpesaDisbus.Insert;

                        end;


                    end;


                    SurePESATrans.Init;
                    SurePESATrans."Document No" := docNo;
                    SurePESATrans.Description := 'Mobile Loan';
                    SurePESATrans."Document Date" := Today;
                    SurePESATrans."Account No" := Members."No.";
                    SurePESATrans."Account No2" := '';
                    SurePESATrans.Amount := amount;
                    SurePESATrans.Status := SurePESATrans.Status::Completed;
                    SurePESATrans.Posted := true;
                    SurePESATrans."Posting Date" := Today;
                    SurePESATrans.Comments := 'Success';
                    SurePESATrans.Client := Members."No.";
                    SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::"Loan Application";
                    SurePESATrans."Transaction Time" := Time;
                    SurePESATrans.Insert;

                    result := 'TRUE';
                    msg := 'Dear ' + SplitString(Members.Name, ' ') + ', Your E-LOAN No ' + loanNo + ' of Ksh ' + Format((AmountDispursed)) + ' has been approved and disbursed to FOSA A/C.' +
                    Vendor."No." + ' Less Charges of Ksh. ' + Format(TotalCharges) + '. Your loan of KShs ' + Format(AmountToCredit) + ' is due on ' + Format(CalcDate('+1M', Today));

                    SMSMessage(docNo, Members."No.", Members."Mobile Phone No", msg, '');
                end;//Loans Register
                    //END
            end else begin
                result := 'ACCINEXISTENT';
                SurePESATrans.Init;
                SurePESATrans."Document No" := docNo;
                SurePESATrans.Description := 'Mobile Loan';
                SurePESATrans."Document Date" := Today;
                SurePESATrans."Account No" := Vendor."No.";
                SurePESATrans."Account No2" := '';
                SurePESATrans.Amount := amount;
                SurePESATrans.Status := SurePESATrans.Status::Completed;
                SurePESATrans.Posted := true;
                SurePESATrans."Posting Date" := Today;
                SurePESATrans.Comments := 'Failed.Invalid Account';
                SurePESATrans.Client := Members."No.";
                SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::"Loan Application";
                SurePESATrans."Transaction Time" := Time;
                SurePESATrans.Insert;
            end;
        end;
    end;


    procedure GetMpesaDisbursment() result: Text
    begin
        MpesaDisbus.Reset;
        MpesaDisbus.SetRange(MpesaDisbus."Sent To Server", MpesaDisbus."sent to server"::No);
        MpesaDisbus.SetRange(MpesaDisbus.Status, MpesaDisbus.Status::Pending);
        if MpesaDisbus.Find('-') then begin
            result := MpesaDisbus."Document No" + ':::' + MpesaDisbus."Telephone No" + ':::' + Format(MpesaDisbus."Loan Amount") + ':::' + MpesaDisbus."Account No" + ':::' + MpesaDisbus."Customer Name";
        end;
    end;


    procedure UpdateMpesaDisbursment(ImprestNo: Code[30]; MpesaNo: Code[30]; Phone: Code[30]; ResultCode: Code[10]; Comments: Text) result: Code[10]
    var
        BankLedger: Record "Bank Account Ledger Entry";
    begin
        MpesaDisbus.Reset;
        MpesaDisbus.SetRange(MpesaDisbus."Document No", ImprestNo);
        //Mkahawa.SETRANGE(Mkahawa."Telephone No",Phone);
        if MpesaDisbus.Find('-') then begin
            if ResultCode = '0' then begin
                MpesaDisbus."Sent To Server" := MpesaDisbus."sent to server"::Yes;
                MpesaDisbus.Status := MpesaDisbus.Status::Completed;
                BankLedger.Reset;
                BankLedger.SetRange(BankLedger."External Document No.", ImprestNo);
                // BankLedger.SETRANGE(
                if BankLedger.Find('-') then begin
                    BankLedger."External Document No." := MpesaNo;
                    BankLedger.Modify;
                end;
            end else begin
                MpesaDisbus."Sent To Server" := MpesaDisbus."sent to server"::Yes;
                MpesaDisbus.Status := MpesaDisbus.Status::Failed;
            end;
            MpesaDisbus.Comments := Comments;
            MpesaDisbus."Date Sent To Server" := Today;
            MpesaDisbus."Time Sent To Server" := Time;
            MpesaDisbus."MPESA Doc No." := MpesaNo;
            MpesaDisbus.Modify;
            result := 'TRUE';
        end;
    end;


    procedure UpdateMpesaPending(Doc: Code[50])
    begin
        MpesaDisbus.Reset;
        MpesaDisbus.SetRange(MpesaDisbus."Document No", Doc);
        MpesaDisbus.SetRange(MpesaDisbus."Sent To Server", MpesaDisbus."sent to server"::No);
        MpesaDisbus.SetRange(MpesaDisbus.Status, MpesaDisbus.Status::Pending);
        if MpesaDisbus.Find('-') then begin
            MpesaDisbus.Status := MpesaDisbus.Status::Waiting;
            MpesaDisbus.Modify;
        end;
    end;


    procedure fnProcessNotification()
    var
        VarIssuedDate: Date;
        VarExpectedCompletion: Date;
        batch: Code[50];
        SaccoNoSeries: Record "Sacco No. Series";
        docNo: Code[50];
        NotificationDate: Date;
        EloanAmt: Decimal;
        ObjMember: Record Customer;
        varMemberNo: Code[50];
        daysToExpectedCompletion: Integer;
        rollOverInterestAmount: Decimal;
        loanBalance: Decimal;
        loanInterestAccount: Code[30];
    begin

        GenSetUp.Reset;
        GenSetUp.Get;
        GenLedgerSetup.Reset;
        GenLedgerSetup.Get;

        LoanProductsSetup.Reset;
        LoanProductsSetup.SetRange(LoanProductsSetup.Code, 'E-LOAN');
        if LoanProductsSetup.FindFirst() then begin

        end;

        LoansRegister.Reset;
        LoansRegister.SetRange(LoansRegister."Loan Product Type", 'E-LOAN');
        LoansRegister.SetRange(LoansRegister.Posted, true);
        if LoansRegister.Find('-') then begin
            //............
            repeat
                LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest");

                if LoansRegister."Outstanding Balance" > 0 then begin

                    VarIssuedDate := LoansRegister."Application Date";
                    VarExpectedCompletion := LoansRegister."Expected Date of Completion";

                    daysToExpectedCompletion := Today - VarExpectedCompletion;

                    Members.Reset;
                    Members.SetRange(Members."No.", LoansRegister."Client Code");
                    if Members.Find('-') then begin

                        // *** 10 days to but more than 5 days
                        if (daysToExpectedCompletion > 5)
                          and (daysToExpectedCompletion <= 10) then begin
                            MpesaDisbus.Reset;
                            MpesaDisbus.SetRange(MpesaDisbus."Member No", Members."No.");
                            MpesaDisbus.SetRange(MpesaDisbus."Ist Notification", false);
                            if MpesaDisbus.Find('-') then begin
                                msg := 'Dear ' + SplitString(Members.Name, ' ') +
                                    ', Your ' + LoansRegister."Loan Product Type Name" +
                                    ' of amount Ksh. ' + Format(LoansRegister."Outstanding Balance" + LoansRegister."Oustanding Interest") +
                                    ' is due on ' + Format(LoansRegister."Expected Date of Completion");//,0,'<Day> <MonthText> <Year>');

                                SMSMessagewithTime(LoansRegister."Doc No Used", LoansRegister."Client Code", Members."Mobile Phone No", msg, '');
                                MpesaDisbus."Ist Notification" := true;
                                MpesaDisbus.Modify;
                            end;
                        end;

                        // *** 5 days to but more than 0 days
                        if (daysToExpectedCompletion > 0)
                          and (daysToExpectedCompletion <= 5) then begin
                            MpesaDisbus.Reset;
                            MpesaDisbus.SetRange(MpesaDisbus."Member No", Members."No.");
                            MpesaDisbus.SetRange(MpesaDisbus."2nd Notification", false);
                            if MpesaDisbus.Find('-') then begin
                                msg := 'Dear ' + SplitString(Members.Name, ' ') +
                                    ', Your ' + LoansRegister."Loan Product Type Name" +
                                    ' of amount Ksh. ' + Format(LoansRegister."Outstanding Balance" + LoansRegister."Oustanding Interest") +
                                    ' is due on ' + Format(LoansRegister."Expected Date of Completion");//,0,'<Day> <MonthText> <Year>');

                                SMSMessagewithTime(LoansRegister."Doc No Used", LoansRegister."Client Code", Members."Mobile Phone No", msg, '');
                                MpesaDisbus."2nd Notification" := true;
                                MpesaDisbus.Modify;
                            end;
                        end;


                        // *** 0 to 3 days past
                        if (daysToExpectedCompletion > -3)
                          and (daysToExpectedCompletion <= 0) then begin
                            MpesaDisbus.Reset;
                            MpesaDisbus.SetRange(MpesaDisbus."Member No", Members."No.");
                            MpesaDisbus.SetRange(MpesaDisbus."3rd Notification", false);
                            if MpesaDisbus.Find('-') then begin

                                // *******************************
                                //  apply rollover charges

                                LoanProductsSetup.Reset;
                                LoanProductsSetup.SetRange(LoanProductsSetup.Code, 'E-LOAN');
                                if LoanProductsSetup.FindFirst() then begin
                                    //LoanAcc:=LoanProductsSetup."Loan Account";
                                    loanInterestAccount := LoanProductsSetup."Loan Interest Account";
                                    rollOverInterestAmount := (LoanProductsSetup."Interest rate" / 100) * LoansRegister."Outstanding Balance";
                                end;

                                batch := 'MOBILELOAN';
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", batch);
                                GenJournalLine.DeleteAll;
                                //end of deletion

                                GenBatches.Reset;
                                GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                                GenBatches.SetRange(GenBatches.Name, batch);
                                if GenBatches.Find('-') = false then begin
                                    GenBatches.Init;
                                    GenBatches."Journal Template Name" := 'GENERAL';
                                    GenBatches.Name := batch;
                                    GenBatches.Description := 'Interest Rollover';
                                    GenBatches.Validate(GenBatches."Journal Template Name");
                                    GenBatches.Validate(GenBatches.Name);
                                    GenBatches.Insert;
                                end;//General Jnr Batches

                                docNo := 'ROL-' + LoansRegister."Loan  No.";
                                //Cr Rollover Interest Eloan
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := Members."No.";
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Due";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := docNo;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := MpesaDisbus."Document No" + ' Rollover Interest';
                                GenJournalLine.Amount := ROUND(rollOverInterestAmount, 1, '>');
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if LoanProductsSetup.Get(LoansRegister."Loan Product Type") then begin
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := loanInterestAccount;
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                end;
                                if LoansRegister.Source = LoansRegister.Source::BOSA then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                                end;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                //interest paid

                                // *******************************

                                msg := 'Dear ' + SplitString(Members.Name, ' ') +
                                    ', a rollover charge of Ksh. ' + Format(rollOverInterestAmount) +
                                    ' has been applied to your ' + LoansRegister."Loan Product Type Name" +
                                    ' loan.';//,0,'<Day> <MonthText> <Year>');

                                SMSMessagewithTime(LoansRegister."Doc No Used", LoansRegister."Client Code", Members."Mobile Phone No", msg, '');
                                MpesaDisbus."3rd Notification" := true;
                                MpesaDisbus.Modify;
                            end;
                        end;



                        // *** > 30 days past
                        if (daysToExpectedCompletion > 30) then begin
                            MpesaDisbus.Reset;
                            MpesaDisbus.SetRange(MpesaDisbus."Member No", Members."No.");
                            MpesaDisbus.SetRange(MpesaDisbus."4th Notification", false);
                            if MpesaDisbus.Find('-') then begin

                                // *******************************
                                // recover from deposits and bar member from product
                                batch := 'MOBILELOAN';
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", batch);
                                GenJournalLine.DeleteAll;
                                //end of deletion

                                GenBatches.Reset;
                                GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                                GenBatches.SetRange(GenBatches.Name, batch);

                                if GenBatches.Find('-') = false then begin
                                    GenBatches.Init;
                                    GenBatches."Journal Template Name" := 'GENERAL';
                                    GenBatches.Name := batch;
                                    GenBatches.Description := 'E-Loan recovery';
                                    GenBatches.Validate(GenBatches."Journal Template Name");
                                    GenBatches.Validate(GenBatches.Name);
                                    GenBatches.Insert;
                                end;//General Jnr Batches

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := batch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := Members."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := docNo;
                                GenJournalLine."External Document No." := docNo;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Description := Format(GenJournalLine."transaction type"::"Deposit Contribution") + ' Loan Recovery';
                                GenJournalLine.Amount := (LoansRegister."Outstanding Balance" + LoansRegister."Oustanding Interest");
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := batch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := LoansRegister."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := docNo;
                                GenJournalLine."External Document No." := docNo;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Loan Interest Payment';
                                GenJournalLine.Amount := -LoansRegister."Oustanding Interest";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := batch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := LoansRegister."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := docNo;
                                GenJournalLine."External Document No." := docNo;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Loan Repayment';
                                GenJournalLine.Amount := -LoansRegister."Outstanding Balance";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", batch);
                                if GenJournalLine.Find('-') then begin
                                    repeat
                                        GLPosting.Run(GenJournalLine);
                                    until GenJournalLine.Next = 0;

                                    MpesaDisbus."Penalty Date" := Today;
                                    MpesaDisbus."4th Notification" := true;
                                    MpesaDisbus.Modify;

                                    Members.ELoanApplicationNotAllowed := true;
                                    Members.Modify;

                                    msg := 'Dear ' + SplitString(Members.Name, ' ') +
                                        ', Your ' + LoansRegister."Loan Product Type Name" +
                                        ' of amount Ksh. ' + Format(LoansRegister."Outstanding Balance" + LoansRegister."Oustanding Interest") +
                                        ' has been recovered from Deposits, you will not be able to access ELoan';//,0,'<Day> <MonthText> <Year>');
                                    SMSMessagewithTime(LoansRegister."Doc No Used", LoansRegister."Client Code", Members."Mobile Phone No", msg, '');

                                end;
                                // ************************

                            end;
                        end;

                    end;
                end;
            until LoansRegister.Next = 0;
        end;
        //==================================send e loan notification  to members

    end;


    procedure "fnProcessNotification-bkp"()
    var
        VarIssuedDate: Date;
        VarExpectedCompletion: Date;
        batch: Code[50];
        SaccoNoSeries: Record "Sacco No. Series";
        docNo: Code[50];
        NotificationDate: Date;
        EloanAmt: Decimal;
        ObjMember: Record Customer;
        varMemberNo: Code[50];
        daysToExpectedCompletion: Integer;
        rollOverInterestAmount: Decimal;
        loanBalance: Decimal;
        loanInterestAccount: Code[30];
    begin

        GenSetUp.Reset;
        GenSetUp.Get;
        GenLedgerSetup.Reset;
        GenLedgerSetup.Get;

        LoanProductsSetup.Reset;
        LoanProductsSetup.SetRange(LoanProductsSetup.Code, 'E-LOAN');
        if LoanProductsSetup.FindFirst() then begin

        end;

        LoansRegister.Reset;
        LoansRegister.SetRange(LoansRegister."Loan Product Type", 'E-LOAN');
        LoansRegister.SetRange(LoansRegister.Posted, true);
        if LoansRegister.Find('-') then begin
            //............
            repeat
                LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest");

                if LoansRegister."Outstanding Balance" > 0 then begin

                    VarIssuedDate := LoansRegister."Application Date";
                    VarExpectedCompletion := LoansRegister."Expected Date of Completion";

                    daysToExpectedCompletion := Today - VarExpectedCompletion;

                    Members.Reset;
                    Members.SetRange(Members."No.", LoansRegister."Client Code");
                    if Members.Find('-') then begin

                        // *** 10 days to but more than 5 days
                        if (daysToExpectedCompletion > 5)
                          and (daysToExpectedCompletion <= 10) then begin
                            MpesaDisbus.Reset;
                            MpesaDisbus.SetRange(MpesaDisbus."Member No", Members."No.");
                            MpesaDisbus.SetRange(MpesaDisbus."Ist Notification", false);
                            if MpesaDisbus.Find('-') then begin
                                msg := 'Dear ' + SplitString(Members.Name, ' ') +
                                    ', Your ' + LoansRegister."Loan Product Type Name" +
                                    ' of amount Ksh. ' + Format(LoansRegister."Outstanding Balance" + LoansRegister."Oustanding Interest") +
                                    ' is due on ' + Format(LoansRegister."Expected Date of Completion");//,0,'<Day> <MonthText> <Year>');

                                SMSMessagewithTime(LoansRegister."Doc No Used", LoansRegister."Client Code", Members."Mobile Phone No", msg, '');
                                MpesaDisbus."Ist Notification" := true;
                                MpesaDisbus.Modify;
                            end;
                        end;

                        // *** 5 days to but more than 0 days
                        if (daysToExpectedCompletion > 0)
                          and (daysToExpectedCompletion <= 5) then begin
                            MpesaDisbus.Reset;
                            MpesaDisbus.SetRange(MpesaDisbus."Member No", Members."No.");
                            MpesaDisbus.SetRange(MpesaDisbus."2nd Notification", false);
                            if MpesaDisbus.Find('-') then begin
                                msg := 'Dear ' + SplitString(Members.Name, ' ') +
                                    ', Your ' + LoansRegister."Loan Product Type Name" +
                                    ' of amount Ksh. ' + Format(LoansRegister."Outstanding Balance" + LoansRegister."Oustanding Interest") +
                                    ' is due on ' + Format(LoansRegister."Expected Date of Completion");//,0,'<Day> <MonthText> <Year>');

                                SMSMessagewithTime(LoansRegister."Doc No Used", LoansRegister."Client Code", Members."Mobile Phone No", msg, '');
                                MpesaDisbus."2nd Notification" := true;
                                MpesaDisbus.Modify;
                            end;
                        end;


                        // *** 0 to 3 days past
                        if (daysToExpectedCompletion > -3)
                          and (daysToExpectedCompletion <= 0) then begin
                            MpesaDisbus.Reset;
                            MpesaDisbus.SetRange(MpesaDisbus."Member No", Members."No.");
                            MpesaDisbus.SetRange(MpesaDisbus."3rd Notification", false);
                            if MpesaDisbus.Find('-') then begin

                                // *******************************
                                //  apply rollover charges

                                LoanProductsSetup.Reset;
                                LoanProductsSetup.SetRange(LoanProductsSetup.Code, 'E-LOAN');
                                if LoanProductsSetup.FindFirst() then begin
                                    //LoanAcc:=LoanProductsSetup."Loan Account";
                                    loanInterestAccount := LoanProductsSetup."Loan Interest Account";
                                    rollOverInterestAmount := (LoanProductsSetup."Interest rate" / 100) * LoansRegister."Outstanding Balance";
                                end;

                                batch := 'MOBILELOAN';
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", batch);
                                GenJournalLine.DeleteAll;
                                //end of deletion

                                GenBatches.Reset;
                                GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                                GenBatches.SetRange(GenBatches.Name, batch);
                                if GenBatches.Find('-') = false then begin
                                    GenBatches.Init;
                                    GenBatches."Journal Template Name" := 'GENERAL';
                                    GenBatches.Name := batch;
                                    GenBatches.Description := 'Interest Rollover';
                                    GenBatches.Validate(GenBatches."Journal Template Name");
                                    GenBatches.Validate(GenBatches.Name);
                                    GenBatches.Insert;
                                end;//General Jnr Batches

                                //Cr Rollover Interest Eloan
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := Members."No.";
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Due";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := MpesaDisbus."Document No";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := MpesaDisbus."Document No" + ' Rollover Interest';
                                GenJournalLine.Amount := ROUND(rollOverInterestAmount, 1, '>');
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if LoanProductsSetup.Get(LoansRegister."Loan Product Type") then begin
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := loanInterestAccount;
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                end;
                                if LoansRegister.Source = LoansRegister.Source::BOSA then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                                end;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                //interest paid

                                // *******************************

                                msg := 'Dear ' + SplitString(Members.Name, ' ') +
                                    ', a rollover charge of Ksh. ' + Format(rollOverInterestAmount) +
                                    ' has been applied to your ' + LoansRegister."Loan Product Type Name" +
                                    ' loan.';//,0,'<Day> <MonthText> <Year>');

                                SMSMessagewithTime(LoansRegister."Doc No Used", LoansRegister."Client Code", Members."Mobile Phone No", msg, '');
                                MpesaDisbus."3rd Notification" := true;
                                MpesaDisbus.Modify;
                            end;
                        end;



                        // *** > 30 days past
                        if (daysToExpectedCompletion > 30) then begin
                            MpesaDisbus.Reset;
                            MpesaDisbus.SetRange(MpesaDisbus."Member No", Members."No.");
                            MpesaDisbus.SetRange(MpesaDisbus."4th Notification", false);
                            if MpesaDisbus.Find('-') then begin

                                // *******************************
                                // recover from deposits and bar member from product
                                batch := 'MOBILELOAN';
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", batch);
                                GenJournalLine.DeleteAll;
                                //end of deletion

                                GenBatches.Reset;
                                GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                                GenBatches.SetRange(GenBatches.Name, batch);

                                if GenBatches.Find('-') = false then begin
                                    GenBatches.Init;
                                    GenBatches."Journal Template Name" := 'GENERAL';
                                    GenBatches.Name := batch;
                                    GenBatches.Description := 'E-Loan recovery';
                                    GenBatches.Validate(GenBatches."Journal Template Name");
                                    GenBatches.Validate(GenBatches.Name);
                                    GenBatches.Insert;
                                end;//General Jnr Batches

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := batch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := Members."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := docNo;
                                GenJournalLine."External Document No." := docNo;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Description := Format(GenJournalLine."transaction type"::"Deposit Contribution") + ' Loan Recovery';
                                GenJournalLine.Amount := (LoansRegister."Outstanding Balance" + LoansRegister."Oustanding Interest");
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := batch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := LoansRegister."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := docNo;
                                GenJournalLine."External Document No." := docNo;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Loan Interest Payment';
                                GenJournalLine.Amount := -LoansRegister."Oustanding Interest";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := batch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := LoansRegister."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := docNo;
                                GenJournalLine."External Document No." := docNo;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Loan Repayment';
                                GenJournalLine.Amount := -LoansRegister."Outstanding Balance";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;



                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", batch);
                                if GenJournalLine.Find('-') then begin
                                    repeat
                                        GLPosting.Run(GenJournalLine);
                                    until GenJournalLine.Next = 0;

                                    MpesaDisbus."Penalty Date" := Today;
                                    MpesaDisbus."4th Notification" := true;
                                    MpesaDisbus.Modify;

                                    Members.ELoanApplicationNotAllowed := true;
                                    Members.Modify;

                                    msg := 'Dear ' + SplitString(Members.Name, ' ') +
                                        ', Your ' + LoansRegister."Loan Product Type Name" +
                                        ' of amount Ksh. ' + Format(LoansRegister."Outstanding Balance" + LoansRegister."Oustanding Interest") +
                                        ' has been recovered from Deposits, you will not be able to access ELoan';//,0,'<Day> <MonthText> <Year>');
                                    SMSMessagewithTime(LoansRegister."Doc No Used", LoansRegister."Client Code", Members."Mobile Phone No", msg, '');

                                end;
                                // ************************

                            end;
                        end;





                        if Today >= CalcDate('2W', VarIssuedDate) then begin //SEND SMS 4TH WEEK

                            MpesaDisbus.Reset;
                            MpesaDisbus.SetRange(MpesaDisbus."Member No", Members."No.");
                            MpesaDisbus.SetRange(MpesaDisbus."2nd Notification", false);
                            if MpesaDisbus.Find('-') then begin
                                msg := 'Dear ' + SplitString(Members.Name, ' ') + ', Your ' + LoansRegister."Loan Product Type Name" + ' of amount Ksh. ' + Format(LoansRegister."Outstanding Balance" + LoansRegister."Oustanding Interest") + ' is due on '
                                + Format(LoansRegister."Expected Date of Completion") + ' kindly pay the amount or it will be deducted from deposits with 10% penalty';
                                SMSMessagewithTime(LoansRegister."Doc No Used", LoansRegister."Client Code", Members."Mobile Phone No", msg, '');
                                MpesaDisbus."2nd Notification" := true;
                                MpesaDisbus.Modify;
                            end;
                        end;


                        if Today >= CalcDate('5W', VarIssuedDate) then begin // recover from deposit

                            docNo := 'REC-' + LoansRegister."Loan  No.";
                            MpesaDisbus.Reset;
                            MpesaDisbus.SetRange(MpesaDisbus."Member No", Members."No.");
                            MpesaDisbus.SetRange(MpesaDisbus."Document No", LoansRegister."Doc No Used");
                            MpesaDisbus.SetRange(MpesaDisbus."3rd Notification", false);
                            if MpesaDisbus.Find('-') then begin

                                batch := 'MOBILELOAN';
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", batch);
                                GenJournalLine.DeleteAll;
                                //end of deletion

                                GenBatches.Reset;
                                GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                                GenBatches.SetRange(GenBatches.Name, batch);

                                if GenBatches.Find('-') = false then begin
                                    GenBatches.Init;
                                    GenBatches."Journal Template Name" := 'GENERAL';
                                    GenBatches.Name := batch;
                                    GenBatches.Description := 'mobile recovery';
                                    GenBatches.Validate(GenBatches."Journal Template Name");
                                    GenBatches.Validate(GenBatches.Name);
                                    GenBatches.Insert;
                                end;//General Jnr Batches

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := batch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := Members."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := docNo;
                                GenJournalLine."External Document No." := docNo;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Description := Format(GenJournalLine."transaction type"::"Deposit Contribution") + ' Loan Recovery';
                                GenJournalLine.Amount := (LoansRegister."Outstanding Balance" + LoansRegister."Oustanding Interest" + (0.1 * LoansRegister."Outstanding Balance"));
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := batch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := LoansRegister."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := docNo;
                                GenJournalLine."External Document No." := docNo;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Loan Interest Payment';
                                GenJournalLine.Amount := -LoansRegister."Oustanding Interest";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                if GenJournalLine.Amount <> 0 then
                                    /* GenJournalLine.INSERT;
                                     GenSetUp.RESET;
                                     GenSetUp.GET;
                                     LoanProductsSetup.RESET;

                                     IF LoanProductsSetup.GET(LoansRegister."Loan Product Type") THEN BEGIN
                                         VarReceivableAccount:=LoanProductsSetup."Receivable Interest Account";

                                     //------------------------------------1. DEBIT INTEREST RECEIVABLE CONTROL A/C---------------------------------------------------------------------------------------------
                                     LineNo:=LineNo+10000;
                                     SFactory.FnCreateGnlJournalLine('GENERAL',batch,docNo,LineNo,GenJournalLine."Transaction Type"::" ",
                                     GenJournalLine."Account Type"::"G/L Account",GenSetUp."A/c Interest Receivable",TODAY,LoansRegister."Oustanding Interest",'BOSA',LoansRegister."Loan  No.",
                                     'Interest Paid- '+'-'+LoansRegister."Loan  No.",LoansRegister."Loan  No.");
                                     //--------------------------------(Debit Member Loan Account)---------------------------------------------

                                     //------------------------------------2. CREDIT MEMBER INTEREST RECEIVABLE A/C---------------------------------------------------------------------------------------------
                                     LineNo:=LineNo+10000;
                                     SFactory.FnCreateGnlJournalLine('GENERAL',batch,docNo,LineNo,GenJournalLine."Transaction Type"::"Interest Due",
                                     GenJournalLine."Account Type"::"G/L Account",VarReceivableAccount,TODAY,LoansRegister."Oustanding Interest"*-1,'BOSA',LoansRegister."Loan  No.",
                                     'Interest Paid- '+'-'+LoansRegister."Loan  No.",LoansRegister."Loan  No.");
                                     //----------------------------------(CREDIT MEMBER INTEREST RECEIVABLE A/C-)------------------------------------------------

                                     END;
                                     */
                      LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := batch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := LoansRegister."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := docNo;
                                GenJournalLine."External Document No." := docNo;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Loan Repayment';
                                GenJournalLine.Amount := -LoansRegister."Outstanding Balance";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                /*LineNo:=LineNo+10000;
                                GenJournalLine.INIT;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":=batch;
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                                GenJournalLine."Account No.":=LoansRegister."Client Code";
                                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=docNo;
                                GenJournalLine."External Document No.":=docNo;
                                GenJournalLine."Posting Date":=TODAY;
                                GenJournalLine.Description:='Loan penalty';
                                GenJournalLine.Amount:=-(0.1* LoansRegister."Outstanding Balance");
                                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::pe
                                IF GenJournalLine."Shortcut Dimension 1 Code" = '' THEN BEGIN
                                GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                                GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                END;
                                GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                                IF GenJournalLine.Amount<>0 THEN
                                GenJournalLine.INSERT;
                                */

                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", batch);
                                if GenJournalLine.Find('-') then begin
                                    repeat
                                        GLPosting.Run(GenJournalLine);
                                    until GenJournalLine.Next = 0;

                                    MpesaDisbus."Penalty Date" := Today;
                                    MpesaDisbus."3rd Notification" := true;
                                    MpesaDisbus.Modify;

                                    msg := 'Dear ' + SplitString(Members.Name, ' ') +
                                        ', Your ' + LoansRegister."Loan Product Type Name" +
                                        ' of amount Ksh. ' + Format(LoansRegister."Outstanding Balance") +
                                        ' has been recovered from Deposits';
                                    SMSMessagewithTime(LoansRegister."Doc No Used", LoansRegister."Client Code", Members."Mobile Phone No", msg, '');

                                end;
                            end;
                        end;   // recover from deposit
                    end;
                end;
            until LoansRegister.Next = 0;
        end;
        //==================================send e loan notification  to members
        /*       ObjMember.RESET;
             //   Members.SETFILTER(Members."No.",'<>%1','');
                ObjMember.SETRANGE(ObjMember.Status,ObjMember.Status::Active);
                //ObjMember.SETFILTER(ObjMember."E loan Notification Date",'>=%1', ObjMember.Blocked::" ");
                IF ObjMember.FINDSET THEN BEGIN
                  REPEAT
                  varMemberNo:=ObjMember."No.";
                  EloanAmt:=0;
                  NotificationDate:=ObjMember."E loan Notification Date";
                  EloanAmt:=AdvanceEligibility(varMemberNo);
                  IF NotificationDate=0D THEN BEGIN
                    IF (EloanAmt>6) THEN BEGIN
                      msg:='Dear '+SplitString(ObjMember.Name,' ')+',Do you know you qualify for ELOAN  of Ksh. '+FORMAT(EloanAmt)
                       +' Dial *850# or use Digipesa app to apply now. ';
                        SMSMessagewithTime(ObjMember."No.",ObjMember."No.",ObjMember."Mobile Phone No",msg,'');
                      ObjMember."E loan Notification Date":=CALCDATE('1M',TODAY);
                      ObjMember.MODIFY;
                    END;
                    END ELSE IF (NotificationDate<>0D) THEN BEGIN
                      IF (TODAY>=NotificationDate) THEN BEGIN
                         IF (EloanAmt>6) THEN BEGIN
                           msg:='Dear '+SplitString(ObjMember.Name,' ')+',Do you know you qualify for E-LOAN  of Ksh. '+FORMAT(EloanAmt)
                         +' Dial *850# or use Digipesa app to apply now. ';
                          SMSMessagewithTime(ObjMember."No.",ObjMember."No.",ObjMember."Mobile Phone No",msg,'');
                            ObjMember."E loan Notification Date":=CALCDATE('1M',TODAY);
                            ObjMember.MODIFY;
                        END;

                     END;
                    END;
                   UNTIL ObjMember.NEXT=0;
                 END;
      BEGIN
      SendSchedulesms();
      END;
      */

    end;

    local procedure GetCharge(amount: Decimal; "Code": Code[50]) charge: Decimal
    var
        TariffDetails: Record "Tariff Details";
    begin
        TariffDetails.Reset;
        TariffDetails.SetRange(TariffDetails.Code, Code);
        TariffDetails.SetFilter(TariffDetails."Lower Limit", '<=%1', amount);
        TariffDetails.SetFilter(TariffDetails."Upper Limit", '>=%1', amount);
        if TariffDetails.Find('-') then begin
            charge := TariffDetails."Charge Amount";
        end
    end;

    local procedure PostJournals(batch: Code[50]) result: Boolean
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", batch);
        if GenJournalLine.Find('-') then begin
            repeat
                GLPosting.Run(GenJournalLine);
            until GenJournalLine.Next = 0;
            result := true;
        end;
    end;

    local procedure SendSchedulesms()
    var
        PrincipalAmount: Decimal;
        TransactionLoanDiff: Decimal;
        LoanRepaymentS: Record "HR Leave Family Employees";
        Fulldate: Date;
        LastRepayDate: Date;
        TransactionLoanAmt: Decimal;
        RepayedLoanAmt: Decimal;
        LoanSMSNotice: Record "prPeriod Transactions..";
        loanNotificationDate: Date;
        amtsecondnotice: Decimal;
        amtcompare: Decimal;
        memb: Record Customer;
        Loanbal: Decimal;
        repayamt: Decimal;
        amtloan: Decimal;
    begin
        //===============================================================loans
        /*LoansRegister.RESET;
        LoansRegister.SETRANGE(LoansRegister.Posted,TRUE);
        LoansRegister.SETFILTER(LoansRegister."Loan Product Type",'<>%1','E-LOAN');
        LoansRegister.CALCFIELDS(LoansRegister."Oustanding Interest",LoansRegister."Outstanding Balance");
        LoansRegister.SETFILTER(LoansRegister."Outstanding Balance", '>%1',0);
        IF LoansRegister.FIND('-') THEN BEGIN
           REPEAT
         PrincipalAmount:=0;
         TransactionLoanDiff:=0;
          LoansRegister.CALCFIELDS(LoansRegister."Oustanding Interest",LoansRegister."Outstanding Balance");

        LoanSMSNotice.RESET;
        LoanSMSNotice.SETRANGE(LoanSMSNotice."Loan No",LoansRegister."Loan  No.");
        IF LoanSMSNotice.FIND('-') =FALSE THEN BEGIN
          LoanSMSNotice.RESET;
         IF LoanSMSNotice.FIND('+') THEN BEGIN
        iEntryNo:=LoanSMSNotice."Entry No";
        iEntryNo:=iEntryNo+1;
        END
        ELSE BEGIN
        iEntryNo:=1;
        END;
          LoanSMSNotice.INIT;
          LoanSMSNotice."Entry No":=iEntryNo;
          LoanSMSNotice."Loan No":=LoansRegister."Loan  No.";
          LoanSMSNotice.INSERT;
         END;

        LoanSMSNotice.RESET;
        LoanSMSNotice.SETRANGE(LoanSMSNotice."Loan No",LoansRegister."Loan  No.");
         IF LoanSMSNotice.FIND('-')  THEN BEGIN

// ============ifNot has arreas
        loanNotificationDate:=TODAY;
        TransactionLoanDiff:=LoansRegister."Outstanding Balance"+LoansRegister."Oustanding Interest";

          Members.RESET;
          Members.GET(LoansRegister."Client Code");
        IF TransactionLoanDiff>0 THEN BEGIN

//========== send if due date is today
          LoanRepay.RESET;
          LoanRepay.SETRANGE(LoanRepay."Loan No.",LoansRegister."Loan  No.");
          LoanRepay.SETRANGE(LoanRepay."Repayment Date",TODAY);
          IF LoanRepay.FIND('-') THEN BEGIN

               IF (LoanSMSNotice."SMS Due Date today"=0D) OR (LoanSMSNotice."SMS Due Date today"=TODAY) THEN BEGIN
                  LoanSMSNotice."SMS Due Date today":=CALCDATE('1M',TODAY);
                  LoanSMSNotice.MODIFY;
                  IF (TransactionLoanDiff<=LoanRepay."Monthly Repayment") THEN
                    amtloan:=TransactionLoanDiff
                  ELSE
                    amtloan:=LoanRepay."Monthly Repayment";
                   msg:='Dear '+SplitString(Members.Name,' ')+', Your monthly loan repayment for '+LoansRegister."Loan Product Type Name"+' of amount Ksh. '
                   +FORMAT(amtloan,0,'<Precision,2><sign><Integer Thousand><Decimals,3>')
                   +' is due today'+' kindly make the repayment to avoid attracting extra penalties';
                  SMSMessagewithTime(LoansRegister."Doc No Used",LoansRegister."Client Code",Members."Mobile Phone No",msg,'');

         END;
      END;

//========== send if due date is  7 Day
        LoanRepay.RESET;
        LoanRepay.SETRANGE(LoanRepay."Loan No.",LoansRegister."Loan  No.");
        LoanRepay.SETRANGE(LoanRepay."Repayment Date",CALCDATE('7D',TODAY));
        IF LoanRepay.FIND('-') THEN BEGIN

             IF (LoanSMSNotice."SMS 7 Day"=0D) OR (LoanSMSNotice."SMS 7 Day"=CALCDATE('7D',TODAY)) THEN BEGIN
                LoanSMSNotice."SMS 7 Day":=CALCDATE('1M',CALCDATE('7D',TODAY));
                LoanSMSNotice.MODIFY;

                IF (TransactionLoanDiff<=LoanRepay."Monthly Repayment") THEN
                    amtloan:=TransactionLoanDiff
                  ELSE
                    amtloan:=LoanRepay."Monthly Repayment";
                 msg:='Dear '+SplitString(Members.Name,' ')+', Your monthly loan repayment for '+LoansRegister."Loan Product Type Name"+' of amount Ksh. '
                 +FORMAT(amtloan,0,'<Precision,2><sign><Integer Thousand><Decimals,3>')
                 +' is due within next 7 days'
                +' kindly make the repayment to avoid attracting extra penalties';
                SMSMessagewithTime(LoansRegister."Doc No Used",LoansRegister."Client Code",Members."Mobile Phone No",msg,'');

       END;
        END;
        //MESSAGE(LoansRegister."Loan  No.");
        LoanRepay.RESET;
        LoanRepay.SETRANGE( LoanRepay."Loan No.",LoansRegister."Loan  No.");
        LoanRepay.SETFILTER(LoanRepay."Repayment Date", '..'+FORMAT(CALCDATE('CM+1D-2M', TODAY)));
        LoanRepay.CALCSUMS(LoanRepay."Monthly Repayment");
        loanamt:=LoanRepay."Monthly Repayment"/4;
        amtsecondnotice:=FnGetOutstandingBal(LoansRegister."Loan  No.")/4;
        repayamt:=LoansRegister.Repayment*4;
        Loanbal:=loanamt-amtsecondnotice;
        IF (Loanbal>repayamt) THEN BEGIN

          IF (LoanSMSNotice."Notice SMS 1"=0D) OR (LoanSMSNotice."Notice SMS 1"<=TODAY) THEN BEGIN
            LoanSMSNotice."Notice SMS 1":=CALCDATE('1M',TODAY);
            LoanSMSNotice.MODIFY;


            msg:='Dear '+SplitString(Members.Name,' ')+', Your loan repayment for '+LoansRegister."Loan Product Type Name"+' of amount Ksh. '+FORMAT(TransactionLoanDiff,0,'<Precision,2><sign><Integer Thousand><Decimals,3>')
            +' is due on Arrears for 4 Months';
            SMSMessagewithTime(LoansRegister."Doc No Used",LoansRegister."Client Code",Members."Mobile Phone No",msg,'');

              LoanGuaranteeDetails.RESET;
              LoanGuaranteeDetails.SETRANGE(LoanGuaranteeDetails."Loan No",LoanSMSNotice."Loan No");
              LoanGuaranteeDetails.SETRANGE(LoanGuaranteeDetails."Self Guarantee",FALSE);
              IF LoanGuaranteeDetails.FIND('-') THEN BEGIN
                REPEAT
                  memb.RESET;
                  memb.SETRANGE(memb."No.",LoanGuaranteeDetails."Member No");
                  IF memb.FIND('-') THEN BEGIN
                     msg:='Dear '+SplitString(memb.Name,' ')+',Your Guarantee '+ Members.Name +' has defaulted loan amount Ksh. '+FORMAT(TransactionLoanDiff,0,'<Precision,2><sign><Integer Thousand><Decimals,3>')
                +' for 4 Months';
                SMSMessagewithTime(LoansRegister."Doc No Used",LoansRegister."Client Code",memb."Mobile Phone No",msg,'');
                  END;
                UNTIL LoanGuaranteeDetails.NEXT =0;

              END;
            END;

          END;

// Second Notice
        LoanRepay.RESET;
        LoanRepay.SETRANGE( LoanRepay."Loan No.",LoansRegister."Loan  No.");
        LoanRepay.SETFILTER(LoanRepay."Repayment Date",'..'+FORMAT(CALCDATE('CM+1D-2M', TODAY)));//FORMAT(CALCDATE('CM+1D-3M', TODAY))+'..'+FORMAT(CALCDATE('CM',TODAY)));
        LoanRepay.CALCSUMS(LoanRepay."Monthly Repayment");
        loanamt:=LoanRepay."Monthly Repayment"/5;
        amtsecondnotice:=FnGetOutstandingBal(LoansRegister."Loan  No.")/5;
        repayamt:=LoansRegister.Repayment*5;
        Loanbal:=loanamt-amtsecondnotice;
        IF (Loanbal>repayamt) THEN BEGIN

          IF (LoanSMSNotice."Notice SMS 2"=0D) OR (LoanSMSNotice."Notice SMS 2"<=TODAY) THEN BEGIN
            LoanSMSNotice."Notice SMS 2":=CALCDATE('1M',TODAY);
            LoanSMSNotice.MODIFY;
            msg:='Dear '+SplitString(Members.Name,' ')+', Your loan repayment for '+LoansRegister."Loan Product Type Name"+' of amount Ksh. '+FORMAT(TransactionLoanDiff,0,'<Precision,2><sign><Integer Thousand><Decimals,3>')
            +' is due on Arrears for 5 Months';
            SMSMessagewithTime(LoansRegister."Doc No Used",LoansRegister."Client Code",Members."Mobile Phone No",msg,'');

              LoanGuaranteeDetails.RESET;
              LoanGuaranteeDetails.SETRANGE(LoanGuaranteeDetails."Loan No",LoanSMSNotice."Loan No");
              LoanGuaranteeDetails.SETRANGE(LoanGuaranteeDetails."Self Guarantee",FALSE);
              IF LoanGuaranteeDetails.FIND('-') THEN BEGIN
                REPEAT
                  memb.RESET;
                  memb.SETRANGE(memb."No.",LoanGuaranteeDetails."Member No");
                  IF memb.FIND('-') THEN BEGIN
                     msg:='Dear '+SplitString(memb.Name,' ')+', Your Guarantee '+ Members.Name +' has defaulted loan amount Ksh. '+FORMAT(TransactionLoanDiff,0,'<Precision,2><sign><Integer Thousand><Decimals,3>')
                +' for period of 5 Months';
                SMSMessagewithTime(LoansRegister."Doc No Used",LoansRegister."Client Code",memb."Mobile Phone No",msg,'');
                  END;
                UNTIL LoanGuaranteeDetails.NEXT =0;

              END;
            END;

          END;

// Third Notice
        LoanRepay.RESET;
        LoanRepay.SETRANGE( LoanRepay."Loan No.",LoansRegister."Loan  No.");
        LoanRepay.SETFILTER(LoanRepay."Repayment Date",'..'+FORMAT(CALCDATE('CM+1D-2M', TODAY)));
        LoanRepay.CALCSUMS(LoanRepay."Monthly Repayment",LoanRepay."Monthly Interest");
         loanamt:=LoanRepay."Monthly Repayment"/6;
        amtsecondnotice:=FnGetOutstandingBal(LoansRegister."Loan  No.")/6;

        repayamt:=LoansRegister.Repayment*6;
        Loanbal:=loanamt-amtsecondnotice;
        IF (Loanbal>repayamt) THEN BEGIN

          IF (LoanSMSNotice."Notice SMS 3"=0D) OR (LoanSMSNotice."Notice SMS 3"<=TODAY) THEN BEGIN
            LoanSMSNotice."Notice SMS 3":=CALCDATE('1M',TODAY);
            LoanSMSNotice.MODIFY;
            msg:='Dear '+SplitString(Members.Name,' ')+', Your loan repayment for '+LoansRegister."Loan Product Type Name"+' of amount Ksh. '+FORMAT(TransactionLoanDiff,0,'<Precision,2><sign><Integer Thousand><Decimals,3>')
            +' is due on Arrears for 6 Months';
            SMSMessage(LoansRegister."Doc No Used",LoansRegister."Client Code",Members."Mobile Phone No",msg,'');

              LoanGuaranteeDetails.RESET;
              LoanGuaranteeDetails.SETRANGE(LoanGuaranteeDetails."Loan No",LoanSMSNotice."Loan No");
              LoanGuaranteeDetails.SETRANGE(LoanGuaranteeDetails."Self Guarantee",FALSE);
              IF LoanGuaranteeDetails.FIND('-') THEN BEGIN
                REPEAT
                  memb.RESET;
                  memb.SETRANGE(memb."No.",LoanGuaranteeDetails."Member No");
                  IF memb.FIND('-') THEN BEGIN
                     msg:='Dear '+SplitString(memb.Name,' ')+', Your Guarantee '+ Members.Name +' has defaulted loan amount Ksh. '+FORMAT(TransactionLoanDiff,0,'<Precision,2><sign><Integer Thousand><Decimals,3>')
                +' for period of 6 Months';
                SMSMessagewithTime(LoansRegister."Doc No Used",LoansRegister."Client Code",memb."Mobile Phone No",msg,'');
                  END;
                UNTIL LoanGuaranteeDetails.NEXT =0;

              END;
            END;

          END;


          END ELSE BEGIN

          END;
        END;

      //  END;//LOAN NOTICE TBL
        //END;



        UNTIL LoansRegister.NEXT=0;
END;
*/

    end;


    procedure FnGetOutstandingBal(LoanNo: Code[50]) amout: Decimal
    begin
        amout := 0;
        MemberLedgerEntry.Reset;
        MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No", LoanNo);
        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type", '=%1|=%2', MemberLedgerEntry."transaction type"::"Interest Paid", MemberLedgerEntry."transaction type"::"Loan Repayment");
        MemberLedgerEntry.CalcSums(MemberLedgerEntry."Credit Amount (LCY)");
        amout := MemberLedgerEntry."Credit Amount (LCY)";
    end;


    procedure SMSMessagewithTime(documentNo: Text[30]; accfrom: Text[30]; phone: Text[20]; message: Text[250]; addition: Text[250])
    begin
        iEntryNo := 0;
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Batch No" := documentNo;
        SMSMessages."Document No" := documentNo;
        SMSMessages."Account No" := accfrom;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'MOBILETRAN';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := message;
        //  SMSMessages."Additional sms":=addition;
        SMSMessages."Telephone No" := phone;
        // SMSMessages.ScheduleTime:=CREATEDATETIME(TODAY,070000T);
        if SMSMessages."Telephone No" <> '' then
            SMSMessages.Insert;
    end;

    local procedure FnGetaccountbal(account: Code[50]) accbal: Decimal
    begin
        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", account);
        //  Vendor.SETRANGE(Vendor."Subscribed for SMS", TRUE);
        if Vendor.Find('-') then begin

            // REPEAT
            Vendor.CalcFields(Vendor."Balance (LCY)");
            Vendor.CalcFields(Vendor."ATM Transactions");
            Vendor.CalcFields(Vendor."Uncleared Cheques");
            Vendor.CalcFields(Vendor."EFT Transactions");
            //  Vendor.CALCFIELDS(Vendor."Mobile Transactions");
            AccountTypes.Reset;
            AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
            if AccountTypes.Find('-') then begin
                miniBalance := AccountTypes."Minimum Balance";
            end;//fosa balances is returning zero// this function is for shortcode. yes this is what is returning zerof for fosa blances
            accBalance := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions" + miniBalance);
            accbal := accBalance;
        end;
    end;


    procedure AccountBalanceDec(Acc: Code[30]; amt: Decimal) Bal: Decimal
    begin

        Bal := 0;
        Members.Reset;
        Members.SetRange(Members."No.", Acc);
        Members.SetRange(Members.Blocked, Members.Blocked::" ");
        if Members.Find('-') then begin
            /* IF amt=1 THEN BEGIN
            // Members.CALCFIELDS(Members."Watoto Savings");
            Bal:=Members."Watoto Savings";
            END;
            IF amt=2 THEN BEGIN
            Members.CALCFIELDS(Members."Member withdrawable Deposits");
            Bal:=Members."Member withdrawable Deposits";
            END;
            IF amt=3 THEN BEGIN
            Members.CALCFIELDS(Members."Dividend Amount");
            Bal:=Members."Dividend Amount";
            END;   */
            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;
            // GenLedgerSetup.TESTFIELD(GenLedgerSetup."Mobile Charge");
            GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
            GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

            /*Charges.RESET;
            Charges.SETRANGE(Charges.Code,GenLedgerSetup."Mobile Charge");
            IF Charges.FIND('-') THEN BEGIN
            Charges.TESTFIELD(Charges."GL Account");
            */

            //  END;

            MPESACharge := GetCharge(amt, 'MPESA');
            CloudPESACharge := GetCharge(amt, 'VENDWD');
            MobileCharges := GetCharge(amt, 'SACCOWD');

            ExcDuty := (20 / 100) * (MobileCharges);
            TotalCharges := CloudPESACharge + MobileCharges + ExcDuty + MPESACharge;
            Bal := Bal - TotalCharges;

        end else begin

            Vendor.Reset;
            Vendor.SetRange(Vendor."No.", Acc);
            // Vendor.SETRANGE(Vendor."Account Type",'M-WALLET');
            if Vendor.Find('-') then begin
                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                if AccountTypes.Find('-') then begin
                    TempBalance := AccountTypes."Minimum Balance";
                end;

                Vendor.CalcFields("Balance (LCY)", "ATM Transactions");

                GenLedgerSetup.Reset;
                GenLedgerSetup.Get;
                GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
                GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

                Bal := Vendor."Balance (LCY)";
                MPESACharge := GetCharge(amt, 'MPESA');
                CloudPESACharge := GetCharge(amt, 'VENDWD');
                MobileCharges := GetCharge(amt, 'SACCOWD');

                ExcDuty := (20 / 100) * (MobileCharges);
                TotalCharges := CloudPESACharge + MobileCharges + ExcDuty + MPESACharge;
                Bal := Bal - TotalCharges - TempBalance - Vendor."ATM Transactions";

            end;

        end;


    end;

    local procedure FnGetMemberNo(phoneNo: Code[100]) Acount: Code[100]
    begin

        Members.Reset;
        Members.SetRange(Members."Mobile Phone No", phoneNo);
        if Members.Find('-') then begin
            Acount := Members."No.";
            exit;
        end;

        Members.Reset;
        Members.SetRange(Members."Phone No.", phoneNo);
        if Members.Find('-') then begin
            Acount := Members."No.";
            exit;
        end;

        Members.Reset;
        Members.SetRange(Members."Mobile Phone No", '0' + CopyStr(phoneNo, 4, 15));
        if Members.Find('-') then begin
            Acount := Members."No.";
            exit;
        end;

        Members.Reset;
        Members.SetRange(Members."Phone No.", '0' + CopyStr(phoneNo, 4, 15));
        if Members.Find('-') then begin
            Acount := Members."No.";
            exit;
        end;
    end;

    local procedure PaybillToLoanAPI(batch: Code[20]; docNo: Code[20]; accNo: Code[20]; memberNo: Code[20]; amount: Decimal; type: Code[20]) res: Code[10]
    var
        origAmount: Decimal;
        postedamount: Decimal;
    begin


        SaccoGenSetup.Reset;
        SaccoGenSetup.Get;

        GenLedgerSetup.Reset;
        GenLedgerSetup.Get;
        GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
        GenLedgerSetup.TestField(GenLedgerSetup."PayBill Settl Acc");

        //GenLedgerSetup.TESTFIELD(GenLedgerSetup."Sacco Charge Account");

        origAmount := amount;

        SurePESACommACC := GenLedgerSetup."CloudPESA Comm Acc";
        SurePESACharge := GetCharge(PaybillTrans.Amount, 'CLOUDPESA');
        PaybillRecon := GenLedgerSetup."PayBill Settl Acc";
        ChargeAmount := GetCharge(PaybillTrans.Amount, 'SACCO');
        MobileChargesACC := '10321';//GenLedgerSetup."Sacco Charge Account";

        postedamount := amount - (SurePESACharge + ChargeAmount);
        ExcDuty := (SaccoGenSetup."Excise Duty(%)" / 100) * SurePESACharge;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", batch);
        GenJournalLine.DeleteAll;
        //end of deletion

        GenBatches.Reset;
        GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
        GenBatches.SetRange(GenBatches.Name, batch);

        if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name" := 'GENERAL';
            GenBatches.Name := batch;
            GenBatches.Description := 'Paybill Loan Repayment';
            GenBatches.Validate(GenBatches."Journal Template Name");
            GenBatches.Validate(GenBatches.Name);
            GenBatches.Insert;
        end;//General Jnr Batches

        // Members.RESET;
        //  Members.SETRANGE(Members."ID No.", accNo);
        //  IF Members.FIND('-') THEN BEGIN
        //  MESSAGE(Members."No.");
        // Vendor.RESET;
        // Vendor.SETRANGE(Vendor."No.", Members."FOSA Account No.");
        // Vendor.SETRANGE(Vendor."Account Type", fosaConst);

        //  IF Vendor.FIND('-') THEN BEGIN

        LoansRegister.Reset;
        // LoansRegister.SETRANGE(LoansRegister."Client Code",Members."No.");
        LoansRegister.SetRange(LoansRegister."Loan  No.", accNo);


        if LoansRegister.Find('-') then begin
            LoansRegister.CalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
            if LoansRegister."Outstanding Balance" > 0 then begin
                //MESSAGE(LoansRegister."Loan  No.");
                //Dr MPESA PAybill ACC
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := batch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := PaybillRecon;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := docNo;
                GenJournalLine."Posting Date" := PaybillTrans."Transaction Date";
                GenJournalLine.Description := 'Paybill Loan Repayment';
                GenJournalLine.Amount := amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                if LoansRegister."Oustanding Interest" > 0 then begin
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := batch;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                    GenJournalLine."Account No." := LoansRegister."Client Code";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := docNo;
                    GenJournalLine."Posting Date" := PaybillTrans."Transaction Date";
                    GenJournalLine.Description := 'Loan Interest Payment';

                    if amount > LoansRegister."Oustanding Interest" then
                        GenJournalLine.Amount := -LoansRegister."Oustanding Interest"
                    else
                        GenJournalLine.Amount := -amount;

                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";

                    if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                        GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    end;

                    GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    amount := amount + GenJournalLine.Amount;
                end;

                if amount > 0 then begin
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := batch;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                    GenJournalLine."Account No." := LoansRegister."Client Code";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := '';
                    GenJournalLine."Posting Date" := PaybillTrans."Transaction Date";
                    GenJournalLine.Description := 'Paybill Loan Repayment';
                    GenJournalLine.Amount := -amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";

                    if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                        GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    end;

                    GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                end;


                //CR sacco account
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := batch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                GenJournalLine."Account No." := MobileChargesACC;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := docNo;
                GenJournalLine."Posting Date" := PaybillTrans."Transaction Date";
                GenJournalLine.Description := 'Paybill Loan Repayment Charges';
                GenJournalLine.Amount := ChargeAmount * -1;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //CR Surestep Acc
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := batch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                GenJournalLine."Account No." := SurePESACommACC;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := docNo;
                GenJournalLine."Posting Date" := PaybillTrans."Transaction Date";
                GenJournalLine.Description := 'Paybill Loan Repayment Charges';
                GenJournalLine.Amount := -SurePESACharge;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

            end;//Outstanding Balance
        end;//Loan Register
            //  END;//Vendor
            //  END;//Member

        //Post
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", batch);
        if GenJournalLine.Find('-') then begin
            repeat
                GLPosting.Run(GenJournalLine);
            until GenJournalLine.Next = 0;

            res := 'TRUE';
            PaybillTrans.Posted := true;
            PaybillTrans."Date Posted" := Today;
            //      PaybillTrans.Description:='Posted';
            PaybillTrans.Modify;

            // msg:='Dear ' +Members.Name+' your Loan: '+LoansRegister."Loan Product Type"+' has been credited with Ksh'+ FORMAT(origAmount) +' Thank you for using Acumen Mobile';
            msg := 'Dear ' + PaybillTrans."Account Name" + 'KSH' + Format(amount) + ' has been credited to' + LoansRegister."Loan Product Type" + ', Ksh' + Format(origAmount - amount) + ' to interest. Thank you for using Acumen Mobile';
            SMSMessage(docNo, Members."No.", Members."Mobile Phone No", msg, '');

            res := 'TRUE';

        end else begin
            PaybillTrans."Date Posted" := PaybillTrans."Transaction Date";
            PaybillTrans."Needs Manual Posting" := true;
            //      PaybillTrans.Description:='Failed';
            PaybillTrans.Modify;
            res := 'FALSE';
        end;
    end;


    procedure PostFosaAccounts(docNo: Text[20]; telephoneNo: Text[20]; amount: Decimal; transactionDate: Date; AppType: Code[100]; AccountNo: Code[50]) result: Text[30]
    begin

        CloudPESATrans.Reset;
        CloudPESATrans.SetRange(CloudPESATrans."Document No", docNo);
        if CloudPESATrans.Find('-') then begin
            result := 'REFEXISTS';
        end
        else begin

            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;
            // GenLedgerSetup.TESTFIELD(GenLedgerSetup."Mobile Charge");
            // GenLedgerSetup.TESTFIELD(GenLedgerSetup."MPESA Settl Acc");
            GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
            /* // GenLedgerSetup.TESTFIELD(GenLedgerSetup."CloudPESA Charge");

              Charges.RESET;
              Charges.SETRANGE(Charges.Code,GenLedgerSetup."Mobile Charge");
              IF Charges.FIND('-') THEN BEGIN
                Charges.TESTFIELD(Charges."GL Account");


              END;
              */
            MPESACharge := 0;//GetCharge(amount,'MPESA');
            CloudPESACharge := GetCharge(amount, 'VENDWD');
            MobileCharges := GetCharge(amount, 'BALANCEIN');

            CloudPESACommACC := GenLedgerSetup."CloudPESA Comm Acc";
            MPESARecon := GenLedgerSetup."MPESA Settl Acc";
            MobileChargesACC := '10321';

            ExcDuty := (20 / 100) * (MobileCharges);
            TotalCharges := CloudPESACharge + MobileCharges + MPESACharge;
            Vendor.Reset;
            Vendor.SetRange(Vendor."No.", AccountNo);
            //   Vendor.SETRANGE(Vendor."Account Type", 'M-WALLET');

            if Vendor.Find('-') then begin
                Vendor.CalcFields(Vendor."Balance (LCY)");
                Vendor.CalcFields(Vendor."ATM Transactions");
                Vendor.CalcFields(Vendor."Uncleared Cheques");
                Vendor.CalcFields(Vendor."EFT Transactions");
                //  Vendor.CALCFIELDS(Vendor."Mobile Transactions");



                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                if AccountTypes.Find('-') then begin
                end;
                TempBalance := Vendor."Balance (LCY)" - AccountTypes."Minimum Balance";


                if (TempBalance > 0) then begin
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'MPESAWITHD');
                    GenJournalLine.DeleteAll;
                    //end of deletion      f
                    //c
                    GenBatches.Reset;
                    GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                    GenBatches.SetRange(GenBatches.Name, 'MPESAWITHD');

                    if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name" := 'GENERAL';
                        GenBatches.Name := 'MPESAWITHD';
                        GenBatches.Description := 'MPESA Withdrawal';
                        GenBatches.Validate(GenBatches."Journal Template Name");
                        GenBatches.Validate(GenBatches.Name);
                        GenBatches.Insert;
                    end;

                    //DR Customer Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := Vendor."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := Vendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Balance Inquiry ' + Vendor."Mobile Phone No";
                    GenJournalLine.Amount := TotalCharges;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Dr Withdrawal Charges
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := Vendor."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := Vendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Balance Inquiry Exc Duty' + ' ' + 'Charges';
                    GenJournalLine.Amount := ExcDuty;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //CR Excise Duty
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := Format(ExxcDuty);
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := MobileChargesACC;
                    GenJournalLine."Source No." := Vendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Balance Inquiry' + ' Excise Duty';
                    GenJournalLine.Amount := ExcDuty * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //CR Mobile Transactions Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := MobileChargesACC;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := MobileChargesACC;
                    GenJournalLine."Source No." := Vendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Balance Inquiry' + ' Charges';
                    GenJournalLine.Amount := MobileCharges * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //CR Surestep Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := CloudPESACommACC;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := MobileChargesACC;
                    GenJournalLine."Source No." := Vendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Balance Inquiry ' + ' Charges';
                    GenJournalLine.Amount := -CloudPESACharge;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Post
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'MPESAWITHD');
                    if GenJournalLine.Find('-') then begin
                        repeat
                            GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;
                    end;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'MPESAWITHD');
                    GenJournalLine.DeleteAll;
                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                    if AccountTypes.Find('-') then begin

                    end;
                    Vendor.CalcFields(Vendor."Balance (LCY)");


                    msg := 'Dear ' + Vendor.Name + ', A/C Balance for ' + AccountTypes.Description + ' A/C No. ' + Vendor."No." + ' is Ksh. ' + Format(Vendor."Balance (LCY)") +
                  ' .Thank you for using ACUMEN Sacco Mobile.';

                    SMSMessage(docNo, Members."No.", Vendor."Mobile Phone No", msg, '');


                    CloudPESATrans.Init;
                    CloudPESATrans."Document No" := docNo;
                    CloudPESATrans.Description := 'Balance Inquiry - ' + Vendor.Name;
                    CloudPESATrans."Document Date" := Today;
                    CloudPESATrans."Account No" := Vendor."No.";
                    // CloudPESATrans."Account No2" :=MPESARecon;
                    TotalCharges := ExcDuty + MobileCharges + CloudPESACharge;
                    CloudPESATrans.Charge := TotalCharges;
                    CloudPESATrans."Account Name" := Vendor.Name;
                    CloudPESATrans."Telephone Number" := telephoneNo;
                    CloudPESATrans."SMS Message" := msg;
                    CloudPESATrans.Amount := amount;
                    CloudPESATrans.Status := CloudPESATrans.Status::Completed;
                    CloudPESATrans.Posted := true;
                    CloudPESATrans."Posting Date" := Today;
                    CloudPESATrans.Comments := 'Success';
                    CloudPESATrans.Client := Vendor."BOSA Account No";
                    CloudPESATrans."Transaction Type" := CloudPESATrans."transaction type"::Balance;
                    CloudPESATrans."Transaction Time" := Time;
                    CloudPESATrans.Insert;
                    result := 'TRUE';



                end
                else begin
                    result := 'INSUFFICIENT';
                    msg := 'You have insufficient funds in your savings Account to use this service.' +
                   ' .Thank you for using ACUMEN Sacco Mobile.';
                    SMSMessage(docNo, Vendor."No.", Vendor."Phone No.", msg, '');
                    CloudPESATrans.Init;
                    CloudPESATrans."Document No" := docNo;
                    CloudPESATrans.Description := 'Balance Inquiry';
                    CloudPESATrans."Document Date" := Today;
                    CloudPESATrans."Account No" := Vendor."No.";
                    CloudPESATrans."Account No2" := MPESARecon;
                    TotalCharges := ExcDuty + MobileCharges + CloudPESACharge;
                    CloudPESATrans.Charge := TotalCharges;
                    CloudPESATrans."Account Name" := Vendor.Name;
                    CloudPESATrans."Telephone Number" := telephoneNo;
                    CloudPESATrans.Amount := amount;
                    CloudPESATrans.Status := CloudPESATrans.Status::Failed;
                    CloudPESATrans.Posted := false;
                    CloudPESATrans."Posting Date" := Today;
                    CloudPESATrans.Comments := 'Failed,Insufficient Funds';
                    CloudPESATrans.Client := Vendor."BOSA Account No";
                    CloudPESATrans."Transaction Type" := CloudPESATrans."transaction type"::Balance;
                    CloudPESATrans."Transaction Time" := Time;
                    CloudPESATrans.Insert;
                end;
            end
            else begin
                result := 'ACCINEXISTENT';
                /* msg:='Your request has failed because account does not exist.'+
                 ' .Thank you for using KENCREAM Sacco Mobile.';
                 SMSMessage(docNo,Vendor."No.",Vendor."Phone No.",msg);*/
                CloudPESATrans.Init;
                CloudPESATrans."Document No" := docNo;
                CloudPESATrans.Description := 'MPESA Withdrawal';
                CloudPESATrans."Document Date" := Today;
                CloudPESATrans."Account No" := '';
                CloudPESATrans."Account No2" := MPESARecon;
                CloudPESATrans.Amount := amount;
                CloudPESATrans.Posted := false;
                CloudPESATrans."Posting Date" := Today;
                CloudPESATrans.Comments := 'Failed,Invalid Account';
                CloudPESATrans.Client := '';
                CloudPESATrans."Transaction Type" := CloudPESATrans."transaction type"::Withdrawal;
                CloudPESATrans."Transaction Time" := Time;
                CloudPESATrans.Insert;
            end;
        end;

    end;


    procedure MobileLoaneeSMS() Response: Boolean
    var
        InterestAmount: Decimal;
    begin
        /*BEGIN
        Response:=FALSE;
        
         //GenSetUp.RESET;
        //GenSetUp.GET();
         GenLedgerSetup.RESET;
         GenLedgerSetup.GET;
        
                  GenJournalLine.RESET;
                  GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                  GenJournalLine.SETRANGE("Journal Batch Name",'MOBILELOAN');
                  GenJournalLine.DELETEALL;
                  //end of deletion
        
                  GenBatches.RESET;
                  GenBatches.SETRANGE(GenBatches."Journal Template Name",'GENERAL');
                  GenBatches.SETRANGE(GenBatches.Name,'MOBILELOAN');
        
                  IF GenBatches.FIND('-') = FALSE THEN BEGIN
                  GenBatches.INIT;
                  GenBatches."Journal Template Name":='GENERAL';
                  GenBatches.Name:='MOBILELOAN';
                  GenBatches.Description:='E-Loan';
                  GenBatches.VALIDATE(GenBatches."Journal Template Name");
                  GenBatches.VALIDATE(GenBatches.Name);
                  GenBatches.INSERT;
                  END;
        
                  //First reminder on 25th day
                  LoansTable.RESET;
                  LoansTable.SETRANGE(LoansTable."Loan Product Type",'E-LOAN');
                  LoansTable.SETRANGE(LoansTable."Application Date",CALCDATE('-25D',TODAY));
                  IF LoansTable.FIND('-') THEN BEGIN
                  REPEAT
                    LoansTable.CALCFIELDS(LoansTable."Outstanding Balance",LoansTable."Interest Due",LoansTable."Interest to be paid",LoansTable."Oustanding Interest");
                          IF (LoansTable."Outstanding Balance">0  ) OR (LoansTable."Oustanding Interest">0) THEN BEGIN
                            IF(LoansTable."Loan Days"<>25) THEN BEGIN
                            Members.RESET;
                            Members.SETRANGE(Members."No.",LoansTable."Client Code")   ;
                            IF Members.FIND('-') THEN BEGIN
                             msg:='Dear '+Members.Name+', please note your '+LoansTable."Loan Product Type" +' of KES '+ FORMAT(LoansTable."Outstanding Balance")+
                             ' is due on '+ FORMAT(CALCDATE('30D',LoansTable."Application Date"))+'. Dial *850# and select option 5 to pay' ;
                              SMSMessage(LoansTable."Loan  No.",Members."No.",Members."Mobile Phone No",COPYSTR(msg,1,250),'');
                              LoansTable."Loan Days":=25;
                              LoansTable.MODIFY;
                              END;
                            END;
                           END;
                  UNTIL LoansTable.NEXT = 0;
                  //MESSAGE(msg);
                  Response:=TRUE;
                  END;
        
                  //Second reminder on due date
                  LoansTable.RESET;
                  LoansTable.SETRANGE(LoansTable."Loan Product Type",'E-LOAN');
                  LoansTable.SETRANGE(LoansTable."Application Date",CALCDATE('-30D',TODAY));
                  IF LoansTable.FIND('-') THEN BEGIN
                  REPEAT
                    LoansTable.CALCFIELDS(LoansTable."Outstanding Balance",LoansTable."Interest Due",LoansTable."Interest to be paid",LoansTable."Oustanding Interest");
                          IF (LoansTable."Outstanding Balance">0  ) OR (LoansTable."Oustanding Interest">0) THEN BEGIN
                            IF(LoansTable."Loan Days"<>30) THEN BEGIN
                            Members.RESET;
                            Members.SETRANGE(Members."No.",LoansTable."Client Code")   ;
                            IF Members.FIND('-') THEN BEGIN
                            msg:='Dear '+Members.Name+', please note your '+LoansTable."Loan Product Type" +' of KES '+ FORMAT(LoansTable."Outstanding Balance")+
                             ' is due today. To avoid further charges dial *850# and select option 5 to pay' ;
                              //SMSMessage('',Members."No.",Members."Mobile Phone No",msg);
                              SMSMessage(LoansTable."Loan  No.",Members."No.",Members."Mobile Phone No",COPYSTR(msg,1,250),'');
                              LoansTable."Loan Days":=30;
                              LoansTable.MODIFY;
                              END;
                            END;
                          END;
                  UNTIL LoansTable.NEXT = 0;
                  //MESSAGE(msg);
                  Response:=TRUE;
                    END;
        
                  //Charge penalty on the 33rd day
                  LoansTable.RESET;
                  LoansTable.SETRANGE(LoansTable."Loan Product Type",'E-LOAN');
                  LoansTable.SETRANGE(LoansTable."Application Date",CALCDATE('-33D',TODAY));
                  IF LoansTable.FIND('-') THEN BEGIN
                  REPEAT
                    LoansTable.CALCFIELDS(LoansTable."Outstanding Balance",LoansTable."Interest Due",LoansTable."Interest to be paid",LoansTable."Oustanding Interest");
                          IF (LoansTable."Outstanding Balance">0  ) OR (LoansTable."Oustanding Interest">0) THEN BEGIN
                            IF(LoansTable."Loan Days"<>33) THEN BEGIN
                            Members.RESET;
                            Members.SETRANGE(Members."No.",LoansTable."Client Code")   ;
                            IF Members.FIND('-') THEN BEGIN
                             LoanProductsSetup.GET(LoansTable."Loan Product Type");
                         InterestAmount:=0;
                         InterestAmount:=ROUND((LoansTable."Outstanding Balance" * (LoanProductsSetup."Interest rate" * 0.01)),1,'>');
                    //Cr Interest Eloan
                    LineNo:=LineNo+10000;
                    GenJournalLine.INIT;
                    GenJournalLine."Journal Template Name":='GENERAL';
                    GenJournalLine."Journal Batch Name":='MOBILELOAN';
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                    GenJournalLine."Account No.":= LoanProductsSetup."Receivable Interest Account";
                    GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Interest Due";
                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                    GenJournalLine."Document No.":=LoansTable."Loan  No."+'-PENALTY';
                    GenJournalLine."Posting Date":=TODAY;
                    GenJournalLine.Description:=LoansTable."Loan  No."+'-PENALTY'+' '+'Penalty charged';
                    GenJournalLine.Amount:=InterestAmount;
                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                    GenJournalLine."Bal. Account No.":=LoanProductsSetup."Loan Interest Account";
                    GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                    IF  LoansTable.Source= LoansTable.Source::BOSA THEN BEGIN
                    GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                    GenJournalLine."Shortcut Dimension 2 Code":=Members."Global Dimension 2 Code";
                    END;
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine."Loan No":= LoansTable."Loan  No.";
                    IF GenJournalLine.Amount<>0 THEN
                    GenJournalLine.INSERT;
        
        //interest paid
        
                //DR Customer Acc
                        LineNo:=LineNo+10000;
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILELOAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                        GenJournalLine."Account No.":=LoanProductsSetup."Loan Interest Account";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=LoansTable."Loan  No."+'-PENALTY';
                        GenJournalLine."External Document No.":=Members."FOSA Account";
                        GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Interest Due";
                        GenJournalLine.Description:='E-Loan Penalty Charge -'+LoansTable."Loan  No.";
                        GenJournalLine.Amount:=InterestAmount*-1;
                        GenJournalLine."Posting Date":=TODAY;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                    IF LoanProductsSetup.GET(LoansTable."Loan Product Type") THEN BEGIN
                    GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Member;
                    GenJournalLine."Bal. Account No.":= Members."No.";
                    GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                    END;
                    IF  LoansTable.Source= LoansTable.Source::BOSA THEN BEGIN
                    GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                    GenJournalLine."Shortcut Dimension 2 Code":=Members."Global Dimension 2 Code";
                    END;
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine."Loan No":= LoansTable."Loan  No.";
        
                        IF GenJournalLine.Amount<>0 THEN
                        GenJournalLine.INSERT;
        
                  //Post
                  GenJournalLine.RESET;
                  GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                  GenJournalLine.SETRANGE("Journal Batch Name",'MOBILELOAN');
                  IF GenJournalLine.FIND('-') THEN BEGIN
                  REPEAT
                  GLPosting.RUN(GenJournalLine);
                  UNTIL GenJournalLine.NEXT = 0;
                        //MESSAGE('Yei');
                              LoansTable.CALCFIELDS(LoansTable."Outstanding Balance",LoansTable."Interest Due",LoansTable."Interest to be paid",LoansTable."Oustanding Interest");
                            msg:='Dear '+Members.Name+', Your '+LoansTable."Loan Product Type"+' is 3 days in arrears and KES '+ FORMAT(InterestAmount) +' has been charged. Current loan balance is KES '+
                             FORMAT(LoansTable."Outstanding Balance"+LoansTable."Oustanding Interest")+ ' To avoid further charges dial *850# and select option 5 to pay' ;
                             //SMSMessage('',Members."No.",Members."Mobile Phone No",msg);
                             SMSMessage(LoansTable."Loan  No.",Members."No.",Members."Mobile Phone No",COPYSTR(msg,1,250),'');
                             LoansTable."Loan Days":=33;
                              LoansTable.MODIFY;
                              END;
                              END;
                            END;
                          END;
                  UNTIL LoansTable.NEXT = 0;
                  //MESSAGE(msg);
                  Response:=TRUE;
                    END;
        
        
                  //Recover from Deposits on the 60th day
                  LoansTable.RESET;
                  LoansTable.SETRANGE(LoansTable."Loan Product Type",'E-LOAN');
                  //LoansTable.SETRANGE(LoansTable."Application Date",CALCDATE('-60D',TODAY));
                  LoansTable.SETRANGE(LoansTable."Loan  No.",'LN2830');
                  IF LoansTable.FIND('-') THEN BEGIN
                  REPEAT
                    LoansTable.CALCFIELDS(LoansTable."Outstanding Balance",LoansTable."Interest Due",LoansTable."Interest to be paid",LoansTable."Oustanding Interest");
                          IF (LoansTable."Outstanding Balance">0  ) OR (LoansTable."Oustanding Interest">0) THEN BEGIN
                            IF(LoansTable."Loan Days"<>61) THEN BEGIN
                            Members.RESET;
                            Members.SETRANGE(Members."No.",LoansTable."Client Code")   ;
                            IF Members.FIND('-') THEN BEGIN
                             LoanProductsSetup.GET(LoansTable."Loan Product Type");
                         InterestAmount:=0;
                         InterestAmount:=ROUND((LoansTable."Outstanding Balance" * (LoanProductsSetup."Interest rate" * 0.01)),1,'>');
        
                    IF (LoansTable."Oustanding Interest">0) THEN BEGIN
                      //Dr Deposits
                      LineNo:=LineNo+10000;
                      GenJournalLine.INIT;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":='MOBILELOAN';
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                      GenJournalLine."Account No.":=Members."No.";
                      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                      GenJournalLine."Document No.":=LoansTable."Loan  No."+'RECOVERY';
                      GenJournalLine."External Document No.":=LoansTable."Loan  No."+'RECOVERY';
                      GenJournalLine."Posting Date":=TODAY;
                      GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Deposit Contribution";
                      GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Description:='E-Loan recovered from deposits';
                      GenJournalLine.Amount:=LoansTable."Oustanding Interest";
                      GenJournalLine.VALIDATE(GenJournalLine.Amount);
                      GenJournalLine."Loan No":= LoansTable."Loan  No.";
                      IF GenJournalLine.Amount<>0 THEN
                      GenJournalLine.INSERT;
        
                    //Cr  E-loan
                    LineNo:=LineNo+10000;
                    GenJournalLine.INIT;
                    GenJournalLine."Journal Template Name":='GENERAL';
                    GenJournalLine."Journal Batch Name":='MOBILELOAN';
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."Bal. Account Type"::Member;
                    GenJournalLine."Account No.":= Members."No.";
                    GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Interest Paid";
                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                    GenJournalLine."Document No.":=LoansTable."Loan  No."+'RECOVERY';
                    GenJournalLine."Posting Date":=TODAY;
                    GenJournalLine.Description:=LoansTable."Loan  No."+'- recovered from deposits';
                    GenJournalLine.Amount:=LoansTable."Oustanding Interest"*-1;
                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                    IF  LoansTable.Source= LoansTable.Source::BOSA THEN BEGIN
                    GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                    GenJournalLine."Shortcut Dimension 2 Code":=Members."Global Dimension 2 Code";
                    END;
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine."Loan No":= LoansTable."Loan  No.";
                    IF GenJournalLine.Amount<>0 THEN
                    GenJournalLine.INSERT;
        
                    END;
        
                    IF (LoansTable."Outstanding Balance">0) THEN BEGIN
                      //Dr Deposits
                      LineNo:=LineNo+10000;
                      GenJournalLine.INIT;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":='MOBILELOAN';
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                      GenJournalLine."Account No.":=Members."No.";
                      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                      GenJournalLine."Document No.":=LoansTable."Loan  No."+'RECOVERY';
                      GenJournalLine."External Document No.":=LoansTable."Loan  No."+'RECOVERY';
                      GenJournalLine."Posting Date":=TODAY;
                      GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Deposit Contribution";
                      GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Description:='E-Loan recovered from deposits';
                      GenJournalLine.Amount:=LoansTable."Outstanding Balance";
                      GenJournalLine.VALIDATE(GenJournalLine.Amount);
                      GenJournalLine."Loan No":= LoansTable."Loan  No.";
                      IF GenJournalLine.Amount<>0 THEN
                      GenJournalLine.INSERT;
        
                    //Cr  E-loan
                    LineNo:=LineNo+10000;
                    GenJournalLine.INIT;
                    GenJournalLine."Journal Template Name":='GENERAL';
                    GenJournalLine."Journal Batch Name":='MOBILELOAN';
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."Bal. Account Type"::Member;
                    GenJournalLine."Account No.":= Members."No.";
                    GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Repayment;
                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                    GenJournalLine."Document No.":=LoansTable."Loan  No."+'RECOVERY';
                    GenJournalLine."Posting Date":=TODAY;
                    GenJournalLine.Description:=LoansTable."Loan  No."+'- recovered from deposits';
                    GenJournalLine.Amount:=LoansTable."Outstanding Balance"*-1;
                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                    IF  LoansTable.Source= LoansTable.Source::BOSA THEN BEGIN
                    GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                    GenJournalLine."Shortcut Dimension 2 Code":=Members."Global Dimension 2 Code";
                    END;
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine."Loan No":= LoansTable."Loan  No.";
                    IF GenJournalLine.Amount<>0 THEN
                    GenJournalLine.INSERT;
        
                    END;
        
        
                  //Post
                  GenJournalLine.RESET;
                  GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                  GenJournalLine.SETRANGE("Journal Batch Name",'MOBILELOAN');
                  IF GenJournalLine.FIND('-') THEN BEGIN
                  REPEAT
                  GLPosting.RUN(GenJournalLine);
                  UNTIL GenJournalLine.NEXT = 0;
                            msg:='Dear '+Members.Name+', Your '+LoansTable."Loan Product Type"+' of KES '+FORMAT(LoansTable."Outstanding Balance"+LoansTable."Oustanding Interest") +
                            ' has been recovered from your savings. For clarification Call 0713805770' ;
                            // SMSMessage('',Members."No.",Members."Mobile Phone No",msg);
                            //SMSMessage(LoansTable."Loan  No.",Members."No.",Members."Mobile Phone No",COPYSTR(msg,1,250),'');
                             LoansTable."Loan Days":=60;
                              LoansTable.MODIFY;
                              UpdatePenaltyDate(LoansTable."Doc No Used");
                              END;
                              END;
                            END;
                          END;
                  UNTIL LoansTable.NEXT = 0;
                  //MESSAGE(msg);
                  Response:=TRUE;
                    END;
        
        
        
                 END;
        */

    end;

    local procedure UpdatePenaltyDate(DocumentNo: Code[20]) Response: Boolean
    begin
        Response := false;
        MobileLoans.Reset;
        MobileLoans.SetRange(MobileLoans."Document No", DocumentNo);
        if MobileLoans.Find('-') then begin
            MobileLoans."Penalty Date" := Today;
            MobileLoans.Modify;
            Response := true;
        end;
    end;
}

