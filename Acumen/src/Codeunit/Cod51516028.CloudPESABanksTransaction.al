#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516028 "CloudPESA Banks Transaction"
{

    trigger OnRun()
    begin
        //MESSAGE(PostTransactionsFB('2246423'));
        Message(GnSendIdDetails());
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
        Members: Record "Member Register";
        dateExpression: Text[20];
        DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        dashboardDataFilter: Date;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        MemberLedgerEntry: Record "Cust. Ledger Entry";
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
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        msg: Text[250];
        accountName1: Text[40];
        accountName2: Text[40];
        fosaAcc: Text[30];
        LoanGuaranteeDetails: Record "Loans Guarantee Details";
        bosaNo: Text[20];
        MPESARecon: Text[20];
        TariffDetails: Record "Tariff Details";
        MPESACharge: Decimal;
        TotalCharges: Decimal;
        ExxcDuty: label '01-1-0275';
        PaybillTrans: Record "CloudPESA MPESA Trans";
        PaybillRecon: Code[30];
        fosaConst: label 'SAVINGS';
        accountsFOSA: Text[1023];
        interestRate: Integer;
        LoanAmt: Decimal;
        Dimension: Record "Dimension Value";
        DimensionFOSA: label 'FOSA';
        DimensionBRANCH: label 'NAIROBI';
        DimensionBOSA: label 'BOSA';
        FamilyBankacc: Code[50];
        equityAccount: Code[50];
        coopacc: Code[50];
        AccountLength: Integer;
        fosaAccNo: Code[50];
        MembApp: Record "Membership Applications";
        Idtype: Code[50];
        IDLength: Integer;
        ImportFile: File;


    procedure SMSMessage(documentNo: Text[30]; accfrom: Text[30]; phone: Text[20]; message: Text[250])
    begin

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
        SMSMessages."Telephone No" := phone;
        if SMSMessages."Telephone No" <> '' then
            SMSMessages.Insert;
    end;


    procedure InsertFBCashDeposit(tranNo: Code[100]; Status: Code[50]; reference: Code[50]; AccountNo: Code[50]; Amount: Decimal; "Date Received": Date; "inst Account": Code[50]; Msisdn: Code[20]; narration: Code[100]; "inst name": Code[200]; "flex tran serial no": Text[500]; "fetch date": Date; Channel: Code[50]) result: Code[50]
    var
        FbCashDeositTb: Record "FB Cash Deposit";
    begin
        FbCashDeositTb.Reset;
        FbCashDeositTb.SetRange(FbCashDeositTb."Transaction No", tranNo);
        if FbCashDeositTb.Find('-') then begin

            result := 'REFEXIST';

        end
        else begin
            FbCashDeositTb.Init;
            FbCashDeositTb."Transaction No" := tranNo;
            FbCashDeositTb.Status := Status;
            FbCashDeositTb.Reference := reference;
            FbCashDeositTb."Account No" := AccountNo;
            FbCashDeositTb.Amount := Amount;
            FbCashDeositTb."Date Received" := Today;
            FbCashDeositTb."Inst Account" := "inst Account";
            FbCashDeositTb.Msisdn := Msisdn;
            FbCashDeositTb.Narration := narration;
            FbCashDeositTb."Inst Name" := "inst name";
            FbCashDeositTb."Flex Trans Serial No" := "flex tran serial no";
            FbCashDeositTb."Fetch Date" := Today;
            FbCashDeositTb.Channel := Channel;
            FbCashDeositTb.Insert;

            FbCashDeositTb.Reset;
            FbCashDeositTb.SetRange(FbCashDeositTb."Transaction No", tranNo);
            if FbCashDeositTb.Find('-') then begin
                result := PostTransactionsFB(FbCashDeositTb."Transaction No");

            end
            else begin
                result := 'FALSE';
            end;


        end;
    end;


    procedure PostTransactionsFB(TranNo: Code[100]) result: Code[50]
    var
        FbCashDeositTb: Record "FB Cash Deposit";
    begin

        GenLedgerSetup.Reset;
        GenLedgerSetup.Get;

        GenLedgerSetup.TestField(GenLedgerSetup."family account bank");
        GenLedgerSetup.TestField(GenLedgerSetup."equity bank acc");
        GenLedgerSetup.TestField(GenLedgerSetup."coop bank acc");

        FamilyBankacc := GenLedgerSetup."family account bank";

        FbCashDeositTb.Reset;
        FbCashDeositTb.SetRange(FbCashDeositTb.Posted, false);
        FbCashDeositTb.SetRange(FbCashDeositTb."Transaction No", TranNo);

        if FbCashDeositTb.Find('-') then begin

            AccountLength := StrLen(FbCashDeositTb."Account No");


            if AccountLength > 13 then begin

                fosaAccNo := CopyStr(FbCashDeositTb."Account No", StrLen(FbCashDeositTb."Account No") - 11, 12);

            end
            else begin
                fosaAccNo := FbCashDeositTb."Account No";
                // MESSAGE(fosaAccNo)
            end;
            Vendor.Reset;
            Vendor.SetRange(Vendor."No.", fosaAccNo);

            if Vendor.Find('-') then begin

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
                    GenBatches.Description := 'FB Cash deposit';
                    GenBatches.Validate(GenBatches."Journal Template Name");
                    GenBatches.Validate(GenBatches.Name);
                    GenBatches.Insert;
                end;

                //CR ACC 1
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Vendor."No.";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := FbCashDeositTb.Reference;
                GenJournalLine."External Document No." := Vendor."No.";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := FbCashDeositTb.Narration;
                GenJournalLine.Amount := -FbCashDeositTb.Amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //DR BANK
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := FamilyBankacc;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := FbCashDeositTb.Reference;
                GenJournalLine."External Document No." := Vendor."No.";
                ;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := FbCashDeositTb.Narration;
                GenJournalLine.Amount := FbCashDeositTb.Amount;
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



                FbCashDeositTb.Posted := true;
                FbCashDeositTb.Status := '00';
                FbCashDeositTb.Modify;
                result := 'TRUE';

            end;//vendor

        end;
    end;


    procedure PostTransactionsEquity() result: Code[50]
    var
        FbCashDeositTb: Record "FB Cash Deposit";
    begin

        GenLedgerSetup.Reset;
        GenLedgerSetup.Get;

        GenLedgerSetup.TestField(GenLedgerSetup."family account bank");
        GenLedgerSetup.TestField(GenLedgerSetup."equity bank acc");
        GenLedgerSetup.TestField(GenLedgerSetup."coop bank acc");

        equityAccount := GenLedgerSetup."equity bank acc";
        FbCashDeositTb.Reset;
        FbCashDeositTb.SetRange(FbCashDeositTb.Posted, false);

        if FbCashDeositTb.Find('-') then begin
        end
        else begin

            Vendor.Reset;
            Vendor.SetRange("No.", FbCashDeositTb."Account No");

            if Vendor.Find('-') then begin

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

                //CR ACC 1
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Vendor."No.";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := FbCashDeositTb.Reference;
                GenJournalLine."External Document No." := Vendor."No.";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := FbCashDeositTb.Narration;
                GenJournalLine.Amount := -amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //DR BANK
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := FamilyBankacc;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := FbCashDeositTb.Reference;
                GenJournalLine."External Document No." := Vendor."No.";
                ;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := FbCashDeositTb.Narration;
                GenJournalLine.Amount := amount;
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

                result := 'TRUE';

                FbCashDeositTb.Posted := true;
                FbCashDeositTb.Status := '00';
                FbCashDeositTb.Modify;

            end;//vendor

        end;
    end;


    procedure InsertCashdepositCOOP("Transaction Id": Code[50]; "account No": Code[50]; "Transtion Date": Date; "Transaction Amount": Decimal; "Transaction currency": Code[50]; "Transaction type": Option; "Transaction particular": Code[20]; "Depositor Name": Text[200]; "Depositor Mobile": Code[20]; "Date Posted": Date; "Date Processed": Code[50]; "BrTransaction ID": Code[100]; Processed: Code[50]) result: Code[50]
    var
        CoopCashDeposit: Record "Coop Transfer";
    begin
        CoopCashDeposit.Reset;
        CoopCashDeposit.SetRange(Processed, '1');
        if CoopCashDeposit.Find('-') then begin
            CoopCashDeposit.Reset;
            if CoopCashDeposit.Find('+') then begin
                iEntryNo := CoopCashDeposit.Id;
                iEntryNo := iEntryNo + 1;
            end
            else begin
                iEntryNo := 1;
            end;

            CoopCashDeposit.Init;
            CoopCashDeposit.Id := iEntryNo;
            CoopCashDeposit."Transaction Id" := "Transaction Id";
            CoopCashDeposit."Account No" := "account No";
            CoopCashDeposit."Transaction Date" := "Transtion Date";
            CoopCashDeposit."Transaction Amount" := "Transaction Amount";
            CoopCashDeposit."Transaction Currency" := "Transaction currency";
            CoopCashDeposit."Transaction Type" := CoopCashDeposit."transaction type"::Deposits;
            CoopCashDeposit."Transaction Particular" := "Transaction particular";
            CoopCashDeposit."Depositor Name" := "Depositor Name";
            CoopCashDeposit."BrTransaction ID" := "BrTransaction ID";
            CoopCashDeposit."Date Processed" := Today;
            CoopCashDeposit.Insert;

            CoopCashDeposit.Reset;
            CoopCashDeposit.SetRange(CoopCashDeposit."Transaction Id", "Transaction Id");
            if CoopCashDeposit.Find('-') then begin
                result := PostTransactionsCOOP(CoopCashDeposit."Transaction Id");

            end
            else begin
                result := 'FALSE';
            end;

            result := 'TRUE';
        end;
    end;


    procedure PostTransactionsCOOP(TranNo: Code[100]) result: Code[50]
    var
        COOPCashDeositTb: Record "Coop Transfer";
    begin

        GenLedgerSetup.Reset;
        GenLedgerSetup.Get;

        GenLedgerSetup.TestField(GenLedgerSetup."family account bank");
        GenLedgerSetup.TestField(GenLedgerSetup."equity bank acc");
        GenLedgerSetup.TestField(GenLedgerSetup."coop bank acc");

        FamilyBankacc := GenLedgerSetup."family account bank";

        //FbCashDeositTb.RESET;
        COOPCashDeositTb.SetRange(COOPCashDeositTb.Processed, '1');
        COOPCashDeositTb.SetRange(COOPCashDeositTb."Transaction Id", TranNo);

        if COOPCashDeositTb.Find('-') then begin

            fosaAccNo := COOPCashDeositTb."Account No";

            Vendor.Reset;
            Vendor.SetRange(Vendor."No.", fosaAccNo);

            if Vendor.Find('-') then begin

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
                    GenBatches.Description := 'FB Cash deposit';
                    GenBatches.Validate(GenBatches."Journal Template Name");
                    GenBatches.Validate(GenBatches.Name);
                    GenBatches.Insert;
                end;

                //CR ACC 1
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Vendor."No.";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := COOPCashDeositTb."Transaction Id";
                GenJournalLine."External Document No." := Vendor."No.";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := COOPCashDeositTb."Transaction Particular";
                GenJournalLine.Amount := -amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //DR BANK
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := FamilyBankacc;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := COOPCashDeositTb."Transaction Id";
                GenJournalLine."External Document No." := Vendor."No.";
                ;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := COOPCashDeositTb."Transaction Particular";
                GenJournalLine.Amount := amount;
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
                // GenJournalLine.DELETEALL;




                COOPCashDeositTb.Processed := '1';
                COOPCashDeositTb.Modify;
                result := 'TRUE';

            end;//vendor

        end;
    end;


    procedure fnSetMemberPhoto()
    var
        MemberApp: Record "Member Register";
    begin
        MembApp.Get(MembApp."No.");
        MembApp.Picture.ImportFile('E:\IPRS\PHotos\' + MembApp."ID No." + '.jpg', 'Demo image for item ');
        MembApp.Signature.ImportFile('E:\IPRS\PHotos\signature\' + MembApp."ID No." + '.jpg', 'Demo image for item ');
        MembApp.Modify;
        //PicItem.READ('/9j/4AAQSkZJRgABAAEA/gD+AAD//gAcQ3JlYXRlZCBieSBBY2N1U29mdCBDb3JwLgD/wAALCAFIASABAREA/9sAhAAKBwgJCAYKCQgJCwsKDA8ZEA8ODg8eFhcSGSQfJSUjHyIiJyw4MCcqNSoiIjFCMTU6PD8/PyYvRUpEPUk4Pj88AQsLCw8NDx0QEB08KCIoKDw8PDw8PDw8PDw8PDw8PDw8PDw8PDw8PDw8
    end;


    procedure FnGetIprsDetails(dateOfBirth: Date; firstName: Code[250]; otherName: Code[250]; surname: Code[250]; gender: Code[250]; idNumber: Code[250])
    begin

        MembApp.Reset;
        MembApp.SetRange("ID No.", idNumber);
        if MembApp.Find('-') then begin
            if firstName = '' then begin
            end
            else begin
                MembApp."Date of Birth" := dateOfBirth;
                MembApp."First Name" := firstName;
                MembApp."Middle Name" := otherName + ' ' + surname;
                if gender = 'M' then begin
                    MembApp.Gender := MembApp.Gender::Male;
                end
                else begin
                    MembApp.Gender := MembApp.Gender::Female;
                end;
                MembApp."Member House Group" := 'TRUE';
                MembApp."Send E-Statements" := true;
                // ImportFile.

                MembApp.Picture.ImportFile('E:\IPRS\PHotos\' + MembApp."ID No." + '.jpg', 'PHOTO ');
                MembApp.Signature.ImportFile('E:\IPRS\PHotos\signature\' + MembApp."ID No." + '.jpg', 'SIGNATURE ');

                MembApp.Modify;
                // fnSetMemberPhoto();

            end;
        end;
    end;


    procedure GnSendIdDetails() Result: Code[250]
    begin
        MembApp.Reset;
        MembApp.SetRange(MembApp."Send E-Statements", false);
        if MembApp.Find('-') then begin
            if MembApp."Application Category" = MembApp."application category"::"New Application" then begin

                if MembApp."Identification Document" = MembApp."identification document"::"0" then begin
                    Idtype := 'NATIONAL_ID';
                end;
                if MembApp."Identification Document" = MembApp."identification document"::"1" then begin
                    Idtype := 'NATIONAL_ID';
                end;
                IDLength := StrLen(MembApp."ID No.");


                if IDLength > 6 then begin
                    Result := Idtype + ':::' + 'ID' + ':::' + Format(MembApp."ID No.");
                end;

            end;
        end;
    end;


    procedure GetErrorCodes(errocode: Code[50]; IdNumber: Code[50]; errorDescription: Text[100])
    begin
        MembApp.Reset;
        MembApp.SetRange(MembApp."ID No.", IdNumber);
        if MembApp.Find('-') then begin
            MembApp."Member House Group" := errocode;
            MembApp."Send E-Statements" := true;
            MembApp.Modify;
        end;
    end;
}

