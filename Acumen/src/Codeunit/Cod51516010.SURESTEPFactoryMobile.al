#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516010 "SURESTEP FactoryMobile"
{

    trigger OnRun()
    begin
        //MESSAGE(FORMAT(FnGetFosaAccountBalance('0804-019444-00')));
        //MESSAGE(FORMAT(FnGetCashierTransactionBudding('CASHWD-S',1000)));
        //MESSAGE(FORMAT(FnGetMinimumAllowedBalance('CURRENT')));
        //FnSendSMS('Cashwi','my message','Fosaaccount');
        //MESSAGE(FnGetMpesaAccount());
        //FnUpdateMonthlyContributions();
        //FnReturnRetirementDate('006987');
        //ObjGenSetUp.GET();
        //MESSAGE('%1 %2',CALCDATE(1+'-CM'+1,CALCDATE('-CM',TODAY));
        //MESSAGE('%1 %2 %3',CALCDATE('-CM+'+FORMAT(ObjGenSetUp."Days for Checkoff")), FORMAT(CALCDATE('<CM>+19D')),FORMAT(TODAY>CALCDATE(ObjGenSetUp."Days for Checkoff")));

        /*
        ObjLoans.RESET;
        ObjLoans.SETRANGE("Loan  No.",'LNN7665');
        ObjLoans.SETFILTER("Date filter",'..'+FORMAT(TODAY));
        IF ObjLoans.FIND('-') THEN BEGIN
         // IF TODAY >15 THEN
        MESSAGE('%1',FnGetInterestVarianceDueTodateWithFilter(ObjLoans,'..'+FORMAT(TODAY)));
        END
        */

        //MESSAGE(FnGetSavingsProductAccount('06550','GOLDSAVE'));


        /*
        MESSAGE('xxxxxx %1',FnCalculatePaye(50020.85));
        MESSAGE('40,000 %1',FnCalculatePaye(40000));
        MESSAGE('100,000 %1',FnCalculatePaye(100000));
        MESSAGE('150,000 %1',FnCalculatePaye(150000));
        MESSAGE('500,000 %1',FnCalculatePaye(500000));
        */
        //MESSAGE(FORMAT(FnGetDate(FORMAT(20170920D)+'..'+FORMAT(TODAY))));

    end;

    var
        ObjTransCharges: Record "Transaction Charges";
        UserSetup: Record "User Setup";
        ObjVendor: Record Vendor;
        ObjProducts: Record "Account Types-Saving Products";
        ObjMemberLedgerEntry: Record "Cust. Ledger Entry";
        ObjLoans: Record "Loans Register";
        ObjBanks: Record "Bank Account";
        ObjLoanProductSetup: Record "Loan Products Setup";
        ObjProductCharges: Record "Loan Product Charges";
        ObjMembers: Record Customer;
        ObjMembers2: Record Customer;
        ObjGenSetUp: Record "Sacco General Set-Up";
        ObjCompInfo: Record "Company Information";
        BAND1: Decimal;
        BAND2: Decimal;
        BAND3: Decimal;
        BAND4: Decimal;
        BAND5: Decimal;
        NLInterest: Decimal;


    procedure FnGetCashierTransactionBudding(TransactionType: Code[100]; TransAmount: Decimal) TCharge: Decimal
    begin
        ObjTransCharges.Reset;
        ObjTransCharges.SetRange(ObjTransCharges."Transaction Type", TransactionType);
        ObjTransCharges.SetFilter(ObjTransCharges."Minimum Amount", '<=%1', TransAmount);
        ObjTransCharges.SetFilter(ObjTransCharges."Maximum Amount", '>=%1', TransAmount);
        TCharge := 0;
        if ObjTransCharges.FindSet then begin
            repeat
                TCharge := TCharge + ObjTransCharges."Charge Amount" + ObjTransCharges."Charge Amount" * 0.1;
            until ObjTransCharges.Next = 0;
        end;
    end;


    procedure FnGetUserBranch() branchCode: Code[20]
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then begin
            branchCode := UserSetup."Branch Code";
        end;
        exit(branchCode);
    end;


    procedure FnSendSMS(SMSSource: Text; SMSBody: Text[500]; CurrentAccountNo: Text; MobileNumber: Text)
    var
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
    begin
        ObjGenSetUp.Get;
        ObjCompInfo.Get;

        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := CurrentAccountNo;
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := CurrentAccountNo;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := SMSSource;
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := SMSBody + '.' + ObjCompInfo.Name + ' ' + ObjGenSetUp."Customer Care No";
        SMSMessage."Telephone No" := MobileNumber;
        if ((MobileNumber <> '') and (SMSBody <> '')) then
            SMSMessage.Insert;
    end;


    procedure FnCreateGnlJournalLine(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnGetFosaAccountBalance(Acc: Code[30]) Bal: Decimal
    begin
        if ObjVendor.Get(Acc) then begin
            ObjVendor.CalcFields(ObjVendor."Balance (LCY)", ObjVendor."ATM Transactions", ObjVendor."Mobile Transactions", ObjVendor."Uncleared Cheques");
            Bal := ObjVendor."Balance (LCY)" - (ObjVendor."ATM Transactions" + ObjVendor."Mobile Transactions" + FnGetMinimumAllowedBalance(ObjVendor."Account Type"));
        end
    end;

    local procedure FnGetMinimumAllowedBalance(ProductCode: Code[60]) MinimumBalance: Decimal
    begin
        ObjProducts.Reset;
        ObjProducts.SetRange(ObjProducts.Code, ProductCode);
        if ObjProducts.Find('-') then
            MinimumBalance := ObjProducts."Minimum Balance";
    end;

    local procedure FnGetMemberLoanBalance(LoanNo: Code[50]; DateFilter: Date; TotalBalance: Decimal)
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", LoanNo);
        ObjLoans.SetFilter(ObjLoans."Date filter", '..%1', DateFilter);
        if ObjMemberLedgerEntry.FindSet then begin
            TotalBalance := TotalBalance + ObjMemberLedgerEntry."Amount (LCY)";
        end;
    end;


    procedure FnGetTellerTillNo() TellerTillNo: Code[40]
    begin
        ObjBanks.Reset;
        ObjBanks.SetRange(ObjBanks."Account Type", ObjBanks."account type"::Cashier);
        ObjBanks.SetRange(ObjBanks.CashierID, UserId);
        if ObjBanks.Find('-') then begin
            TellerTillNo := ObjBanks."No.";
        end;
        exit(TellerTillNo);
    end;


    procedure FnGetMpesaAccount() TellerTillNo: Code[40]
    begin
        ObjBanks.Reset;
        ObjBanks.SetRange(ObjBanks."Account Type", ObjBanks."account type"::PayBill);
        ObjBanks.SetRange(ObjBanks."Bank Account Branch", FnGetUserBranch());
        if ObjBanks.Find('-') then begin
            TellerTillNo := ObjBanks."No.";
        end;
        exit(TellerTillNo);
    end;


    procedure FnGetChargeFee(ProductCode: Code[50]; MemberCategory: Option Single,Joint,Corporate,Group,Parish,Church,"Church Department",Staff; InsuredAmount: Decimal; ChargeType: Code[100]) FCharged: Decimal
    begin
        if ObjLoanProductSetup.Get(ProductCode) then begin
            ObjProductCharges.Reset;
            ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
            ObjProductCharges.SetRange(ObjProductCharges.Code, ChargeType);
            if ObjProductCharges.Find('-') then begin
                if ObjProductCharges."Use Perc" = true then begin
                    FCharged := InsuredAmount * (ObjProductCharges.Percentage / 100);
                end
                else
                    FCharged := ObjProductCharges.Amount;
            end;
        end;
        exit(FCharged);
    end;


    procedure FnGetChargeAccount(ProductCode: Code[50]; MemberCategory: Option Single,Joint,Corporate,Group,Parish,Church,"Church Department",Staff; ChargeType: Code[100]) ChargeGLAccount: Code[50]
    begin
        if ObjLoanProductSetup.Get(ProductCode) then begin
            ObjProductCharges.Reset;
            ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
            ObjProductCharges.SetRange(ObjProductCharges.Code, ChargeType);
            if ObjProductCharges.Find('-') then begin
                ChargeGLAccount := ObjProductCharges."G/L Account";
            end;
        end;
        exit(ChargeGLAccount);
    end;

    local procedure FnUpdateMonthlyContributions()
    begin
        ObjMembers.Reset;
        ObjMembers.SetCurrentkey(ObjMembers."No.");
        ObjMembers.SetRange(ObjMembers."Monthly Contribution", 0.0);
        if ObjMembers.FindSet then begin
            repeat
                ObjMembers2."Monthly Contribution" := 500;
                ObjMembers2.Modify;
            until ObjMembers.Next = 0;
            Message('Succesfully done');
        end;
    end;


    procedure FnGetUserBranchB(varUserId: Code[100]) branchCode: Code[20]
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", varUserId);
        if UserSetup.Find('-') then begin
            branchCode := UserSetup."Branch Code";
        end;
        exit(branchCode);
    end;


    procedure FnGetMemberBranch(MemberNo: Code[100]) MemberBranch: Code[100]
    var
        ObjMemberLocal: Record Customer;
    begin
        ObjMemberLocal.Reset;
        ObjMemberLocal.SetRange(ObjMemberLocal."No.", MemberNo);
        if ObjMemberLocal.Find('-') then begin
            MemberBranch := ObjMemberLocal."Global Dimension 2 Code";
        end;
        exit(MemberBranch);
    end;

    local procedure FnReturnRetirementDate(MemberNo: Code[50]): Date
    var
        ObjMembers: Record Customer;
    begin
        ObjGenSetUp.Get();
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.Find('-') then
            Message(Format(CalcDate(ObjGenSetUp."Retirement Age", ObjMembers."Date of Birth")));
        exit(CalcDate(ObjGenSetUp."Retirement Age", ObjMembers."Date of Birth"));
    end;


    procedure FnGetTransferFee(DisbursementMode: Option " ",Cheque,"Bank Transfer",EFT,RTGS,"Cheque NonMember"): Decimal
    var
        TransferFee: Decimal;
    begin
        ObjGenSetUp.Get();
        case DisbursementMode of
            Disbursementmode::"Bank Transfer":
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-FOSA";

            Disbursementmode::Cheque:
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-Cheque";

            Disbursementmode::"Cheque NonMember":
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-EFT";

            Disbursementmode::EFT:
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-RTGS";
        end;
        exit(TransferFee);
    end;


    procedure FnGetFosaAccount(MemberNo: Code[50]) FosaAccount: Code[50]
    var
        ObjMembers: Record Customer;
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.Find('-') then begin
            FosaAccount := ObjMembers."FOSA Account No.";
        end;
        exit(FosaAccount);
    end;


    procedure FnCreateGnlJournalLineBalanced(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; BalancingAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member; BalancingAccountNo: Code[40])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnChargeExcise(ChargeCode: Code[100]): Boolean
    var
        ObjProductCharges: Record "Loan Charges";
    begin
        ObjProductCharges.Reset;
        ObjProductCharges.SetRange(Code, ChargeCode);
        if ObjProductCharges.Find('-') then
            exit(ObjProductCharges."Charge Excise");
    end;


    procedure FnGetInterestDueTodate(ObjLoans: Record "Loans Register"): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", '..' + Format(Today));
        ObjLoans.CalcFields("Schedule Interest to Date", "Outstanding Balance");
        exit(ObjLoans."Schedule Interest to Date");
    end;


    procedure FnGetPhoneNumber(ObjLoans: Record "Loans Register"): Code[50]
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange("No.", ObjLoans."BOSA No");
        if ObjMembers.Find('-') then
            exit(ObjMembers."Phone No.");
    end;

    local procedure FnBoosterLoansDisbursement(ObjLoanDetails: Record "Loans Register"): Code[40]
    var
        GenJournalLine: Record "Gen. Journal Line";
        CUNoSeriesManagement: Codeunit NoSeriesManagement;
        DocNumber: Code[100];
        loanTypes: Record "Loan Products Setup";
        ObjLoanX: Record "Loans Register";
        LoansRec: Record "Loans Register";
        Cust: Record Customer;
    begin
        loanTypes.Reset;
        loanTypes.SetRange(loanTypes.Code, 'BLOAN');
        if loanTypes.Find('-') then begin
            DocNumber := CUNoSeriesManagement.GetNextNo('LOANSB', 0D, true);
            LoansRec.Init;
            LoansRec."Loan  No." := DocNumber;
            // LoansRec.INSERT;

            if LoansRec.Get('BLN_00041') then begin
                LoansRec."Client Code" := ObjLoanDetails."Client Code";
                LoansRec.Validate(LoansRec."Client Code");
                LoansRec."Loan Product Type" := 'BLOAN';
                LoansRec.Validate(LoansRec."Loan Product Type");
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Loan Status" := LoansRec."loan status"::Issued;
                LoansRec."Application Date" := ObjLoanDetails."Application Date";
                LoansRec."Issued Date" := ObjLoanDetails."Posting Date";
                LoansRec."Loan Disbursement Date" := ObjLoanDetails."Loan Disbursement Date";
                LoansRec.Validate(LoansRec."Loan Disbursement Date");
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"Bank Transfer";
                LoansRec."Repayment Start Date" := ObjLoanDetails."Repayment Start Date";
                LoansRec."Global Dimension 1 Code" := 'BOSA';
                LoansRec."Global Dimension 2 Code" := FnGetUserBranch();
                LoansRec.Source := ObjLoanDetails.Source;
                LoansRec."Approval Status" := ObjLoanDetails."Approval Status";
                LoansRec.Repayment := ObjLoanDetails."Boosted Amount";
                LoansRec."Requested Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec."Approved Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"Bank Transfer";
                LoansRec.Posted := true;
                LoansRec."Advice Date" := Today;
                LoansRec.Modify;
            end;
        end;
        exit(DocNumber);
    end;


    procedure FnGenerateRepaymentSchedule(LoanNumber: Code[50])
    var
        LoansRec: Record "Loans Register";
        RSchedule: Record "Loan Repayment Schedule";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        GrPrinciple: Integer;
        GrInterest: Integer;
        RepayCode: Code[10];
        WhichDay: Integer;
        InterestVarianceOnlyNafaka: Decimal;
    begin
        LoansRec.Reset;
        LoansRec.SetRange(LoansRec."Loan  No.", LoanNumber);
        LoansRec.SetFilter(LoansRec."Approved Amount", '>%1', 0);
        LoansRec.SetFilter(LoansRec.Posted, '=%1', true);
        if LoansRec.Find('-') then begin
            if (LoansRec."Loan Product Type" <> 'GUR') and (LoansRec."Issued Date" <> 0D) and (LoansRec."Repayment Start Date" <> 0D) then begin
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansRec."Loan  No.");
                RSchedule.DeleteAll;

                LoanAmount := LoansRec."Approved Amount";
                InterestRate := LoansRec.Interest;
                RepayPeriod := LoansRec.Installments;
                InitialInstal := LoansRec.Installments + LoansRec."Grace Period - Principle (M)";
                LBalance := LoansRec."Approved Amount";
                RunDate := LoansRec."Repayment Start Date";
                InstalNo := 0;

                //Repayment Frequency
                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                    RunDate := CalcDate('-1D', RunDate)
                else
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                        RunDate := CalcDate('-1W', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                            RunDate := CalcDate('-1M', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                RunDate := CalcDate('-1Q', RunDate);
                //Repayment Frequency


                repeat
                    InstalNo := InstalNo + 1;
                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                                RunDate := CalcDate('1M', RunDate)
                            else
                                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                    RunDate := CalcDate('1Q', RunDate);

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                        //LoansRec.TESTFIELD(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Straight Line" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Reducing Balance" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Constants then begin
                        LoansRec.TestField(LoansRec.Repayment);
                        if LBalance < LoansRec.Repayment then
                            LPrincipal := LBalance
                        else
                            LPrincipal := LoansRec.Repayment;
                        LInterest := LoansRec.Interest;
                    end;

                    //Grace Period
                    if GrPrinciple > 0 then begin
                        LPrincipal := 0
                    end else begin
                        LBalance := LBalance - LPrincipal;

                    end;

                    //IF GrInterest > 0 THEN
                    //LInterest:=0;
                    NLInterest := ROUND(LoansRec."Approved Amount" * LoansRec.Interest / 12 * (RepayPeriod + 1) / (200 * RepayPeriod), 1, '>'); //For Nafaka Only
                    InterestVarianceOnlyNafaka := LInterest - NLInterest;
                    GrPrinciple := GrPrinciple - 1;
                    GrInterest := GrInterest - 1;
                    Evaluate(RepayCode, Format(InstalNo));


                    RSchedule.Init;
                    RSchedule."Repayment Code" := RepayCode;
                    RSchedule."Interest Rate" := InterestRate;
                    RSchedule."Loan No." := LoansRec."Loan  No.";
                    RSchedule."Loan Amount" := LoanAmount;
                    RSchedule."Instalment No" := InstalNo;
                    RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                    RSchedule."Member No." := LoansRec."Client Code";
                    RSchedule."Loan Category" := LoansRec."Loan Product Type";
                    RSchedule."Monthly Repayment" := NLInterest + LPrincipal;
                    RSchedule."Monthly Interest" := NLInterest;
                    RSchedule."Monthly Insurance" := ROUND(LInterest, 1, '>');
                    //RSchedule."Interest Variance":=InterestVarianceOnlyNafaka;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule.Insert;
                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                until LBalance < 1

            end;
        end;

        Commit;
    end;


    procedure FnGetInterestDueFiltered(ObjLoans: Record "Loans Register"; DateFilter: Text): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", DateFilter);
        ObjLoans.CalcFields("Schedule Interest to Date", "Outstanding Balance");
        exit(ObjLoans."Schedule Interest to Date");
    end;


    procedure FnGetPAYEBudCharge(ChargeCode: Code[10]): Decimal
    var
        ObjpayeCharges: Record "PAYE Brackets Credit";
    begin
        ObjpayeCharges.Reset;
        ObjpayeCharges.SetRange("Tax Band", ChargeCode);
        if ObjpayeCharges.FindFirst then
            exit(ObjpayeCharges."Taxable Amount" * ObjpayeCharges.Percentage / 100);
    end;


    procedure FnPayeRate(ChargeCode: Code[10]): Decimal
    var
        ObjpayeCharges: Record "PAYE Brackets Credit";
    begin
        ObjpayeCharges.Reset;
        ObjpayeCharges.SetRange("Tax Band", ChargeCode);
        if ObjpayeCharges.FindFirst then
            exit(ObjpayeCharges.Percentage / 100);
    end;


    procedure FnCalculatePaye(Chargeable: Decimal) PAYE: Decimal
    var
        TAXABLEPAY: Record "PAYE Brackets Credit";
        Taxrelief: Decimal;
        OTrelief: Decimal;
        InsurannceRelief: Decimal;
        LoansRegister: Record "Loans Register";
    begin

        PAYE := 0;
        if TAXABLEPAY.Find('-') then begin
            repeat
                if Chargeable > 0 then begin
                    case TAXABLEPAY."Tax Band" of
                        '01':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND1 := FnGetPAYEBudCharge('01');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND1 := FnGetPAYEBudCharge('01');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND1 := Chargeable * FnPayeRate('01');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '02':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND2 := FnGetPAYEBudCharge('02');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND2 := FnGetPAYEBudCharge('02');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND2 := Chargeable * FnPayeRate('02');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '03':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND3 := FnGetPAYEBudCharge('03');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND3 := FnGetPAYEBudCharge('03');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND3 := Chargeable * FnPayeRate('03');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '04':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND4 := FnGetPAYEBudCharge('04');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND4 := FnGetPAYEBudCharge('04');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND4 := Chargeable * FnPayeRate('04');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '05':
                            begin
                                BAND5 := Chargeable * FnPayeRate('05');
                            end;
                    end;
                end;
            until TAXABLEPAY.Next = 0;
        end;
        //MESSAGE('We are heading %1',InsurannceRelief);
        exit(BAND1 + BAND2 + BAND3 + BAND4 + BAND5 - (1408));//Engineer Added to cater for Insurance Relief
    end;


    procedure FnGetUpfrontsTotal(ProductCode: Code[50]; InsuredAmount: Decimal) FCharged: Decimal
    var
        ObjLoanCharges: Record "Loan Charges";
    begin
        ObjProductCharges.Reset;
        ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
        if ObjProductCharges.Find('-') then begin
            repeat
                if ObjProductCharges."Use Perc" = true then begin
                    FCharged := InsuredAmount * (ObjProductCharges.Percentage / 100) + FCharged;
                    if ObjLoanCharges.Get(ObjProductCharges.Code) then begin
                        if ObjLoanCharges."Charge Excise" = true then
                            FCharged := FCharged + (InsuredAmount * (ObjProductCharges.Percentage / 100)) * 0.1;
                    end
                end
                else begin
                    FCharged := ObjProductCharges.Amount + FCharged;
                    if ObjLoanCharges.Get(ObjProductCharges.Code) then begin
                        if ObjLoanCharges."Charge Excise" = true then
                            FCharged := FCharged + ObjProductCharges.Amount * 0.1;
                    end
                end

            until ObjProductCharges.Next = 0;
        end;

        exit(FCharged);
    end;


    procedure FnGetPrincipalDueFiltered(ObjLoans: Record "Loans Register"; DateFilter: Text): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", DateFilter);
        ObjLoans.CalcFields("Scheduled Principal to Date", "Outstanding Balance");
        exit(ObjLoans."Scheduled Principal to Date");
    end;

    local procedure FnGetDate(DFilter: Text): Date
    var
        strDate1: Text;
        date1: Date;
        convString: Text;
    begin
        Evaluate(date1, CopyStr(DFilter, 1, 10));
        exit(date1);
    end;


    procedure FnLoanOpeningBalance(ObjLoans: Record "Loans Register"; DFilter: Text) LoanBalance: Decimal
    var
        ObjLoansRegister: Record "Loans Register";
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Loan  No.", ObjLoans."Loan  No.");
        ObjLoansRegister.SetFilter("Date filter", DFilter);
        if ObjLoansRegister.Find('-') then begin
            ObjLoansRegister.CalcFields(ObjLoansRegister."Outstanding Balance");
            LoanBalance := ObjLoansRegister."Outstanding Balance";
        end;
        exit(LoanBalance);
    end;


    procedure FnLoanDisbursement(ObjLoans: Record "Loans Register"; DFilter: Text) LoanBalance: Decimal
    var
        ObjLoansRegister: Record "Loans Register";
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Loan  No.", ObjLoans."Loan  No.");
        ObjLoansRegister.SetFilter("Date filter", DFilter);
        if ObjLoansRegister.Find('-') then begin
            ObjLoansRegister.CalcFields(ObjLoansRegister."Member Share Capital");
            LoanBalance := ObjLoansRegister."Member Share Capital";
        end;
        exit(LoanBalance);
    end;


    procedure FnLoanPaidAmount(ObjLoans: Record "Loans Register"; DFilter: Text) LoanBalance: Decimal
    var
        ObjLoansRegister: Record "Loans Register";
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Loan  No.", ObjLoans."Loan  No.");
        ObjLoansRegister.SetFilter("Date filter", DFilter);
        if ObjLoansRegister.Find('-') then begin
            ObjLoansRegister.CalcFields(ObjLoansRegister."Principal Paid");
            LoanBalance := ObjLoansRegister."Principal Paid";
        end;
        exit(LoanBalance);
    end;


    procedure FnInterestPaid(ObjLoans: Record "Loans Register"; DFilter: Text) LoanBalance: Decimal
    var
        ObjLoansRegister: Record "Loans Register";
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Loan  No.", ObjLoans."Loan  No.");
        ObjLoansRegister.SetFilter("Date filter", DFilter);
        if ObjLoansRegister.Find('-') then begin
            ObjLoansRegister.CalcFields(ObjLoansRegister."Interest Paid");
            LoanBalance := ObjLoansRegister."Interest Paid";
        end;
        exit(LoanBalance);
    end;


    procedure FnGetSavingsProductAccount(MemberNo: Code[50]; ProductCode: Code[100]) FosaAccount: Code[50]
    var
        ObjVendor: Record Vendor;
    begin
        ObjVendor.Reset;
        ObjVendor.SetRange(ObjVendor."BOSA Account No", MemberNo);
        ObjVendor.SetRange(ObjVendor."Account Type", ProductCode);
        if ObjVendor.Find('-') then begin
            FosaAccount := ObjVendor."No.";
        end;
        exit(FosaAccount);
    end;


    procedure FnCreateGnlJournalLineMC(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; GroupCode: Code[100])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."Group Code" := GroupCode;
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnCreateGnlJournalLineAtm(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; TraceID: Code[100])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."ATM SMS" := true;
        GenJournalLine."Trace ID" := TraceID;
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnGetInterestVarianceDueTodate(ObjLoans: Record "Loans Register"): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", '..' + Format(Today));
        ObjLoans.CalcFields("Loan Deposit Multiplier");
        exit(ObjLoans."Loan Deposit Multiplier");
    end;


    procedure FnGetInterestVarianceDueTodateWithFilter(ObjLoans: Record "Loans Register"; DateFilterText: Text[100]): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", DateFilterText);
        ObjLoans.CalcFields("Loan Deposit Multiplier");
        exit(ObjLoans."Loan Deposit Multiplier");
    end;
}

