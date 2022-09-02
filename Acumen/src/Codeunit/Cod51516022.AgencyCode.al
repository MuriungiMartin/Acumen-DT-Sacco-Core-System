#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516022 "AgencyCode"
{

    trigger OnRun()
    begin
        //MESSAGE(GetAgentAccount('OLLIN00005'));
        //MESSAGE(GetAccountInfo('01151117932'));
        //MESSAGE(GetAccounts('7918990'));
        //MESSAGE(FORMAT(GetAccountBalance('01151000549')));
        //MESSAGE(GetMiniStatement('01151003626'));
        //MESSAGE(FORMAT(PostAgentTransaction('17390148217650187828')));
        //MESSAGE(GetAccounts('7918990'));
        //MESSAGE(GetLoans('7918990'));
        //MESSAGE(FORMAT(GetTransactionMaxAmount()));
        //MESSAGE(GetTariffCode('Balance'));
        //MESSAGE(FORMAT(GetCharges('')));
        //
        //MESSAGE(AgencyRegistration());
    end;

    var
        Vendor: Record Vendor;
        SavingsProdAccTypes: Record "Account Types-Saving Products";
        AgentApps: Record "Agent Applications";
        AgentTransactions: Record "Agent Transactions";
        LoansRegister: Record "Loans Register";
        accBalance: Decimal;
        VendorLedgEntry: Record "Vendor Ledger Entry";
        amount: Decimal;
        minimunCount: Integer;
        AccountTypes: Record "Account Types-Saving Products";
        miniBalance: Decimal;
        Loans: Integer;
        LoanProductsSetup: Record "Loan Products Setup";
        Members: Record "Member Register";
        dateExpression: Text[20];
        DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        dashboardDataFilter: Date;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        MemberLedgerEntry: Record "Cust. Ledger Entry";
        GenJournalLine: Record "Gen. Journal Line";
        GenBatches: Record "Gen. Journal Batch";
        LineNo: Integer;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        GenLedgerSetup: Record "General Ledger Setup";
        TariffHeader: Record "Agency Tariff Header";
        TariffDetails: Record "Agent Tariff Details";
        commAgent: Decimal;
        commVendor: Decimal;
        commSacco: Decimal;
        TotalCommission: Decimal;
        CloudPESACommACC: Text[20];
        AgentChargesAcc: Text[20];
        GLAccount: Record "G/L Account";
        WithdrawalLimit: Record "Agent Withdrawal Limits";
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;


    procedure GetAccountType(accountNo: Text[100]) accountType: Text[100]
    begin
        begin

            Vendor.Reset;
            Vendor.SetRange(Vendor."No.", accountNo);
            if Vendor.Find('-') then begin
                accountType := Vendor."Account Type";
            end
            else begin
                accountType := '';
            end
        end;
    end;


    procedure GetMinimumBal(accountType: Text[100]) minBalance: Decimal
    begin
        begin
            SavingsProdAccTypes.Reset;
            SavingsProdAccTypes.SetRange(SavingsProdAccTypes.Code, accountType);
            if SavingsProdAccTypes.Find('-') then begin
                minBalance := SavingsProdAccTypes."Minimum Balance";
            end
            else begin
                minBalance := 0.0;
            end
        end;
    end;


    procedure GetAgentAccount("code": Code[20]) account: Text[100]
    begin
        begin
            AgentApps.Reset;
            AgentApps.SetRange(AgentApps."Agent Code", code);
            AgentApps.SetRange(AgentApps.Status, AgentApps.Status::Approved);
            if AgentApps.Find('-') then begin
                account := AgentApps.Account + ':::' + Format(AgentApps.Branch);
            end
            else begin
                account := '';
            end
        end;
    end;


    procedure GetAccounts(idNumber: Text[50]) accounts: Text[1000]
    begin
        begin
            Vendor.Reset;
            Vendor.SetRange(Vendor."ID No.", idNumber);
            Vendor.SetRange(Vendor.Blocked, 0);
            Vendor.SetFilter(Vendor.Status, '%1|%2', 0, 4);
            if Vendor.Find('-') then begin
                accounts := '';
                repeat
                    Vendor.CalcFields(Vendor."Balance (LCY)");
                    Vendor.CalcFields(Vendor."ATM Transactions");
                    Vendor.CalcFields(Vendor."Uncleared Cheques");
                    Vendor.CalcFields(Vendor."EFT Transactions");
                    accBalance := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions");
                    accounts := accounts + '-:-' + Vendor."No." + ':::' + Vendor.Name + ':::' + Vendor."Account Type" + ':::' + Vendor."Phone No." + ':::' +
                    Format(accBalance);
                until Vendor.Next = 0;
            end
            else begin
                accounts := 'none';
            end
        end;
    end;


    procedure InsertAgencyTransaction(docNo: Code[20]; transDate: Date; accNo: Code[50]; description: Text[220]; amount: Decimal; posted: Boolean; transTime: DateTime; balAccNo: Code[30]; docDate: Date; datePosted: Date; timePosted: Time; accStatus: Text[30]; messages: Text[400]; needsChange: Boolean; changeTransNo: Code[20]; oldAccNo: Code[50]; changed: Boolean; dateChanged: Date; timeChanged: Time; changedBy: Code[10]; approvedBy: Code[10]; originalAccNo: Code[50]; accBal: Decimal; branchCode: Code[10]; activityCode: Code[30]; globalDim1Filter: Code[20]; globalDim2Filter: Code[20]; accNo2: Text[20]; ccode: Code[20]; transLocation: Text[30]; transBy: Text[30]; agentCode: Code[20]; loanNo: Code[20]; accName: Text[30]; telephone: Text[20]; idNo: Code[20]; branch: Text[30]; memberNo: Code[20]; transType: Integer) result: Text[20]
    begin
        AgentTransactions.SetRange(AgentTransactions."Document No.", docNo);
        AgentTransactions.SetRange(AgentTransactions.Description, description);
        AgentTransactions.SetRange(AgentTransactions."Transaction Date", transDate);
        if AgentTransactions.Find('-') then begin
            result := 'exists';
        end
        else begin
            AgentTransactions.Init;
            AgentTransactions."Document No." := docNo;
            AgentTransactions."Transaction Date" := transDate;
            AgentTransactions."Account No." := accNo;
            AgentTransactions.Description := description;
            AgentTransactions.Amount := amount;
            AgentTransactions.Posted := posted;
            AgentTransactions."Transaction Time" := transTime;
            AgentTransactions."Bal. Account No." := balAccNo;
            AgentTransactions."Document Date" := docDate;
            AgentTransactions."Date Posted" := datePosted;
            AgentTransactions."Time Posted" := timePosted;
            AgentTransactions."Account Status" := accStatus;
            AgentTransactions.Messages := messages;
            AgentTransactions."Needs Change" := needsChange;
            AgentTransactions."Old Account No" := oldAccNo;
            AgentTransactions.Changed := changed;
            AgentTransactions."Date Changed" := dateChanged;
            AgentTransactions."Time Changed" := timeChanged;
            AgentTransactions."Changed By" := changedBy;
            AgentTransactions."Approved By" := approvedBy;
            AgentTransactions."Original Account No" := originalAccNo;
            AgentTransactions."Branch Code" := branchCode;
            AgentTransactions."Activity Code" := activityCode;
            AgentTransactions."Global Dimension 1 Filter" := globalDim1Filter;
            AgentTransactions."Global Dimension 2 Filter" := globalDim2Filter;
            AgentTransactions."Account No 2" := accNo2;
            AgentTransactions.CCODE := ccode;
            AgentTransactions."Transaction Location" := transLocation;
            AgentTransactions."Transaction By" := transBy;
            AgentTransactions."Agent Code" := agentCode;
            AgentTransactions."Loan No" := loanNo;
            AgentTransactions."Account Name" := accName;
            AgentTransactions.Telephone := telephone;
            AgentTransactions."Id No" := idNo;
            AgentTransactions.Branch := branch;
            AgentTransactions."Member No" := '';
            AgentTransactions."Transaction Type" := transType;

            AgentTransactions.Insert;
            result := 'completed';
        end
    end;


    procedure GetAccountInfo(accountNo: Code[20]) reslt: Text[200]
    begin
        begin
            Vendor.Reset;
            Vendor.SetRange(Vendor."No.", accountNo);
            Vendor.SetRange(Vendor.Blocked, 0);
            Vendor.SetFilter(Vendor.Status, '%1|%2', 0, 4);
            if Vendor.Find('-') then begin
                reslt := Vendor."No." + ':::' + Vendor.Name + ':::' + Vendor."Account Type" + ':::' + Vendor."Mobile Phone No";
            end
            else begin
                reslt := 'none';
            end
        end;
    end;


    procedure GetLoans(idNumber: Code[20]) loans: Text[1000]
    begin
        begin
            Vendor.Reset;
            Vendor.SetRange(Vendor."ID No.", idNumber);
            if Vendor.Find('-') then begin
                LoansRegister.Reset;
                LoansRegister.SetRange(LoansRegister."Client Code", Vendor."BOSA Account No");
                if LoansRegister.Find('-') then begin
                    repeat
                        LoansRegister.CalcFields(LoansRegister."Outstanding Balance", LoansRegister."Interest Due", LoansRegister."Interest to be paid", LoansRegister."Interest Paid");
                        if (LoansRegister."Outstanding Balance" > 0) or (LoansRegister."Interest Due" > 0) then
                            loans := loans + '-:-' + LoansRegister."Loan  No." + ':::' + LoansRegister."Loan Product Type" + ':::' + LoansRegister."Loan Product Type Name" + ':::' + Format(LoansRegister.Source) +
                            ':::' + Format(LoansRegister."Outstanding Balance" + LoansRegister."Interest Due");
                        ;
                    until LoansRegister.Next = 0;
                end;
            end
        end;
    end;


    procedure GetMiniStatement(account: Code[20]) Statement: Text[500]
    begin
        begin
            VendorLedgEntry.Reset;
            VendorLedgEntry.SetCurrentkey(VendorLedgEntry."Entry No.");
            VendorLedgEntry.Ascending(false);
            VendorLedgEntry.SetRange(VendorLedgEntry."Vendor No.", account);
            VendorLedgEntry.SetRange(VendorLedgEntry.Reversed, VendorLedgEntry.Reversed::"0");
            if VendorLedgEntry.Find('-') then begin
                Statement := '';
                repeat
                    VendorLedgEntry.CalcFields(VendorLedgEntry.Amount);
                    amount := VendorLedgEntry.Amount;
                    if amount < 1 then
                        amount := amount * -1;
                    Statement := Statement + Format(VendorLedgEntry."Posting Date") + '-' + VendorLedgEntry.Description + '-KSH ' +
                    Format(amount) + ':::';
                    minimunCount := minimunCount + 1;
                    if minimunCount > 4 then
                        exit
                until VendorLedgEntry.Next = 0
            end
        end;
    end;


    procedure PostAgentTransaction(transID: Code[30]) res: Boolean
    begin
        AgentTransactions.Reset;
        AgentTransactions.SetRange(AgentTransactions."Document No.", transID);
        AgentTransactions.SetRange(AgentTransactions.Posted, false);

        if AgentTransactions.Find('-') then begin
            TariffHeader.Reset();
            TariffHeader.SetRange(TariffHeader."Trans Type", AgentTransactions."Transaction Type");
            if TariffHeader.FindFirst then begin
                TariffDetails.Reset();
                TariffDetails.SetRange(TariffDetails.Code, TariffHeader.Code);
                if TariffDetails.FindFirst then begin
                    commAgent := TariffDetails."Agent Comm";
                    commVendor := TariffDetails."Vendor Comm";
                    commSacco := TariffDetails."Sacco Comm";
                    TotalCommission := commAgent + commVendor + commSacco;
                end;//Tariff Details
            end;//Tariff Header

            if (AgentTransactions."Transaction Type" = AgentTransactions."transaction type"::Deposit) then
                AgentTransactions.Amount := AgentTransactions.Amount * -1;

            AgentApps.Reset;
            AgentApps.SetRange(AgentApps."Agent Code", AgentTransactions."Agent Code");
            if AgentApps.Find('-')
              then begin
                GenLedgerSetup.Reset;
                GenLedgerSetup.Get;
                GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
                CloudPESACommACC := GenLedgerSetup."CloudPESA Comm Acc";
                AgentChargesAcc := GenLedgerSetup."Agent Charges Account";

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'Agency');
                GenJournalLine.DeleteAll;
                //end of deletion

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                GenBatches.SetRange(GenBatches.Name, 'Agency');

                if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name" := 'GENERAL';
                    GenBatches.Name := 'Agency';
                    GenBatches.Description := 'Agency Transactions';
                    GenBatches.Validate(GenBatches."Journal Template Name");
                    GenBatches.Validate(GenBatches.Name);
                    GenBatches.Insert;
                end;//General Jnr Batches
                case AgentTransactions."Transaction Type" of
                    AgentTransactions."transaction type"::Withdrawal,
                    AgentTransactions."transaction type"::Deposit,
                    AgentTransactions."transaction type"::Transfer:
                        begin
                            Vendor.Reset;
                            Vendor.SetRange(Vendor."No.", AgentTransactions."Account No.");
                            if Vendor.Find('-') then begin

                                //Debit Member Account 1
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'Agency';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := AgentTransactions."Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := AgentTransactions."Document No.";
                                GenJournalLine."External Document No." := AgentApps."Agent Code";
                                GenJournalLine."Posting Date" := AgentTransactions."Transaction Date";
                                GenJournalLine.Description := AgentTransactions.Description;
                                GenJournalLine.Amount := AgentTransactions.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Debit/Credit account 2/Agent
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'Agency';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := AgentApps.Account;

                                if (AgentTransactions."Transaction Type" = AgentTransactions."transaction type"::Transfer) then
                                    GenJournalLine."Account No." := AgentTransactions."Account No 2";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := AgentTransactions."Document No.";
                                GenJournalLine."External Document No." := AgentApps."Agent Code";
                                GenJournalLine."Posting Date" := AgentTransactions."Transaction Date";
                                GenJournalLine.Description := AgentTransactions.Description;
                                GenJournalLine.Amount := AgentTransactions.Amount * -1;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                // IF (AgentTransactions."Transaction Type"<>AgentTransactions."Transaction Type"::Deposit) THEN BEGIN
                                //Cr Vendor-Surestep
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'Agency';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := CloudPESACommACC;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := AgentTransactions."Document No.";
                                GenJournalLine."External Document No." := AgentApps."Agent Code";
                                GenJournalLine."Posting Date" := AgentTransactions."Transaction Date";
                                GenJournalLine.Description := 'Agency Banking Charges';
                                GenJournalLine.Amount := -1 * commVendor;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Cr Sacco
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'Agency';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No." := AgentChargesAcc;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := AgentTransactions."Document No.";
                                GenJournalLine."External Document No." := AgentApps."Agent Code";
                                GenJournalLine."Posting Date" := AgentTransactions."Transaction Date";
                                GenJournalLine.Description := 'Agency Banking Charges';
                                GenJournalLine.Amount := -1 * commSacco;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Cr Agent Commision Acc
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'Agency';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := AgentApps."Comm Account";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := AgentTransactions."Document No.";
                                GenJournalLine."External Document No." := AgentApps."Agent Code";
                                GenJournalLine."Posting Date" := AgentTransactions."Transaction Date";
                                GenJournalLine.Description := 'Agency Banking Charges';
                                GenJournalLine.Amount := -1 * commAgent;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Dr Agent Customer
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'Agency';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := AgentTransactions."Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := AgentTransactions."Document No.";
                                GenJournalLine."External Document No." := AgentApps."Agent Code";
                                GenJournalLine."Posting Date" := AgentTransactions."Transaction Date";
                                GenJournalLine.Description := 'Agency Banking Charges';
                                GenJournalLine.Amount := TotalCommission;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                //END;//Check for Deposits/Share Deposits
                            end;//Vendor
                        end;//CASE Deposits, Withdrawal Transfer

                    AgentTransactions."transaction type"::Balance,
                    AgentTransactions."transaction type"::Ministatment:
                        begin
                            //Cr Vendor
                            Vendor.Reset;
                            Vendor.SetRange(Vendor."No.", AgentTransactions."Account No.");
                            //Dr Customer
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'Agency';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := AgentTransactions."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := AgentTransactions."Document No.";
                            GenJournalLine."External Document No." := AgentApps."Agent Code";
                            GenJournalLine."Posting Date" := AgentTransactions."Transaction Date";
                            GenJournalLine.Description := 'Agency Banking Charges';
                            GenJournalLine.Amount := TotalCommission;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                            if Vendor.Find('-') then begin
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'Agency';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := CloudPESACommACC;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := AgentTransactions."Document No.";
                                GenJournalLine."External Document No." := AgentApps."Agent Code";
                                GenJournalLine."Posting Date" := AgentTransactions."Transaction Date";
                                GenJournalLine.Description := 'Agency Banking Charges';
                                GenJournalLine.Amount := -1 * commVendor;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Cr Sacco
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'Agency';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No." := AgentChargesAcc;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := AgentTransactions."Document No.";
                                GenJournalLine."External Document No." := AgentApps."Agent Code";
                                GenJournalLine."Posting Date" := AgentTransactions."Transaction Date";
                                GenJournalLine.Description := 'Agency Banking Charges';
                                GenJournalLine.Amount := -1 * commSacco;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Cr Agent Commision Acc
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'Agency';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := AgentApps."Comm Account";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := AgentTransactions."Document No.";
                                GenJournalLine."External Document No." := AgentApps."Agent Code";
                                GenJournalLine."Posting Date" := AgentTransactions."Transaction Date";
                                GenJournalLine.Description := 'Agency Banking Charges';
                                GenJournalLine.Amount := -1 * commAgent;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                            end;//Vendor
                        end;//CASE mini Statement, Balance
                    AgentTransactions."transaction type"::Sharedeposit:
                        begin

                            Members.Reset;
                            Members.SetRange(Members."No.", AgentTransactions."Account No.");
                            if Members.Find('-') then begin
                                Vendor.Reset;
                                Vendor.SetRange(Vendor."ID No.", AgentTransactions."Id No");
                                Vendor.SetRange(Vendor."Account Type", 'FS151');
                                if Vendor.FindFirst then begin
                                    AgentTransactions.Amount := AgentTransactions.Amount * -1;
                                    //Cr Customer
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'Agency';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                    GenJournalLine."Account No." := AgentTransactions."Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := AgentTransactions."Document No.";
                                    GenJournalLine."External Document No." := AgentApps."Agent Code";
                                    GenJournalLine."Posting Date" := AgentTransactions."Transaction Date";
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Description := AgentTransactions.Description;
                                    GenJournalLine.Amount := AgentTransactions.Amount;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    //Debit Agent
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'Agency';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := AgentApps.Account;
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := AgentTransactions."Document No.";
                                    GenJournalLine."External Document No." := AgentApps."Agent Code";
                                    GenJournalLine."Posting Date" := AgentTransactions."Transaction Date";
                                    GenJournalLine.Description := AgentTransactions.Description;
                                    GenJournalLine.Amount := AgentTransactions.Amount * -1;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    //Cr Vendor-Surestep
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'Agency';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := CloudPESACommACC;
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := AgentTransactions."Document No.";
                                    GenJournalLine."External Document No." := AgentApps."Agent Code";
                                    GenJournalLine."Posting Date" := AgentTransactions."Transaction Date";
                                    GenJournalLine.Description := 'Agency Banking Charges';
                                    GenJournalLine.Amount := -1 * commVendor;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    //Cr Sacco
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'Agency';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                    GenJournalLine."Account No." := AgentChargesAcc;
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := AgentTransactions."Document No.";
                                    GenJournalLine."External Document No." := AgentApps."Agent Code";
                                    GenJournalLine."Posting Date" := AgentTransactions."Transaction Date";
                                    GenJournalLine.Description := 'Agency Banking Charges';
                                    GenJournalLine.Amount := -1 * commSacco;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    //Cr Agent Commision Acc
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'Agency';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := AgentApps."Comm Account";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := AgentTransactions."Document No.";
                                    GenJournalLine."External Document No." := AgentApps."Agent Code";
                                    GenJournalLine."Posting Date" := AgentTransactions."Transaction Date";
                                    GenJournalLine.Description := 'Agency Banking Charges';
                                    GenJournalLine.Amount := -1 * commAgent;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    //Dr Agent Customer
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'Agency';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := Vendor."No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := AgentTransactions."Document No.";
                                    GenJournalLine."External Document No." := AgentApps."Agent Code";
                                    GenJournalLine."Posting Date" := AgentTransactions."Transaction Date";
                                    GenJournalLine.Description := 'Agency Banking Charges';
                                    GenJournalLine.Amount := TotalCommission;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                end;//Vendor
                            end;//Member
                        end;//CASE Shares Deposit
                end;
                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'Agency');
                if GenJournalLine.Find('-') then begin
                    repeat
                        GLPosting.Run(GenJournalLine);
                    until GenJournalLine.Next = 0;
                    AgentTransactions.Posted := true;
                    AgentTransactions."Date Posted" := Today;
                    AgentTransactions.Messages := 'Completed';
                    AgentTransactions."Time Posted" := Time;
                    AgentTransactions.Modify;
                    res := true;
                end
                else begin
                    AgentTransactions.Posted := false;
                    AgentTransactions."Date Posted" := Today;
                    AgentTransactions.Messages := 'Failed';
                    AgentTransactions."Time Posted" := Time;

                    AgentTransactions.Modify;
                end;

            end;//Agent Apps
        end;//Agent Transactions
    end;


    procedure GetAccountBalance(account: Code[30]) bal: Decimal
    begin
        begin
            Vendor.Reset;
            Vendor.SetRange(Vendor."No.", account);
            if Vendor.Find('-') then begin
                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                if AccountTypes.Find('-') then begin
                    miniBalance := AccountTypes."Minimum Balance";
                    Vendor.CalcFields(Vendor."Balance (LCY)");
                    Vendor.CalcFields(Vendor."ATM Transactions");
                    Vendor.CalcFields(Vendor."Uncleared Cheques");
                    Vendor.CalcFields(Vendor."EFT Transactions");
                    bal := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions");
                end;
            end;
        end;
    end;


    procedure GetMember(idNumber: Text[50]) accounts: Text[1000]
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."ID No.", idNumber);
            Members.SetRange(Members.Blocked, 0);
            Members.SetFilter(Members.Status, '%1|%2', 0, 4);
            if Members.Find('-') then begin
                accounts := '';
                repeat
                    accounts := accounts + '-:-' + Members."No." + ':::' + Members.Name + ':::' + Members."Mobile Phone No";
                until Members.Next = 0;
            end
            else begin
                accounts := 'none';
            end
        end;
    end;


    procedure GetTransactionMinAmount() limits: Decimal
    begin
        WithdrawalLimit.Reset;
        WithdrawalLimit.SetRange(WithdrawalLimit.Code, 'NORMAL');
        if WithdrawalLimit.Find('-') then begin
            limits := WithdrawalLimit."Trans Min Amount";
        end;
    end;


    procedure GetTransactionMaxAmount() limits: Decimal
    begin
        WithdrawalLimit.Reset;
        WithdrawalLimit.SetRange(WithdrawalLimit.Code, 'NORMAL');
        if WithdrawalLimit.Find('-') then begin
            limits := WithdrawalLimit."Trans Max Amount";
        end;
    end;


    procedure GetTransactionCharges() limits: Decimal
    begin
        WithdrawalLimit.Reset;
        WithdrawalLimit.SetRange(WithdrawalLimit.Code, 'NORMAL');
        if WithdrawalLimit.Find('-') then begin
            limits := WithdrawalLimit."Trans Max Amount";
        end;
    end;


    procedure GetWithdrawalCharges(type: Text[20]; amount: Decimal) charges: Decimal
    begin
        TariffDetails.Reset;
        TariffDetails.SetRange(TariffDetails.Code, type);
        TariffDetails.SetFilter(TariffDetails."Agent Comm", '<=%1', amount);
        TariffDetails.SetFilter(TariffDetails."Sacco Comm", '>=%1', amount);
        if TariffDetails.Find('-') then begin
            charges := TariffDetails.Charge;
        end;
    end;


    procedure GetCharges(type: Text[20]) charge: Decimal
    begin
        TariffDetails.Reset;
        TariffDetails.SetRange(TariffDetails.Code, type);
        if TariffDetails.Find('-') then begin
            charge := TariffDetails.Charge;
        end;
    end;


    procedure GetTariffCode(type: Text[30]) "code": Text[10]
    begin
        TariffHeader.Reset;
        TariffHeader.SetFilter(TariffHeader."Trans Type", type);
        if TariffHeader.Find('-') then begin
            code := TariffHeader.Code;
        end;
    end;


    procedure InsertMessages(documentNo: Text[30]; phone: Text[20]; message: Text[400]) res: Boolean
    begin
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
            SMSMessages."Account No" := '';
            SMSMessages."Date Entered" := Today;
            SMSMessages."Time Entered" := Time;
            SMSMessages.Source := 'AGENCY';
            SMSMessages."Entered By" := UserId;
            SMSMessages."Sent To Server" := SMSMessages."sent to server"::Yes;
            SMSMessages."SMS Message" := message;
            SMSMessages."Telephone No" := phone;
            if SMSMessages."Telephone No" <> '' then
                SMSMessages.Insert;
            res := true;
        end;
    end;


    procedure AgencyRegistration() memberdetails: Text[500]
    begin
        begin
            begin
                AgentApps.Reset;
                AgentApps.SetRange(AgentApps."Sent To Server", AgentApps."sent to server"::No);
                AgentApps.SetRange(AgentApps.Status, AgentApps.Status::Approved);
                if AgentApps.Find('-') then begin
                    memberdetails := AgentApps."Agent Code" + ':::' + AgentApps."Mobile No" + ':::' + AgentApps.Name;
                end
                else begin
                    memberdetails := '';
                end
            end;
        end;
    end;


    procedure UpdateAgencyRegistration(agentCode: Code[20]) result: Text[30]
    begin
        begin
            begin
                AgentApps.Reset;
                AgentApps.SetRange(AgentApps."Sent To Server", AgentApps."sent to server"::No);
                AgentApps.SetRange(AgentApps."Agent Code", agentCode);
                if AgentApps.Find('-') then begin
                    AgentApps."Sent To Server" := AgentApps."sent to server"::Yes;
                    AgentApps.Modify;
                    result := 'Modified';
                end
                else begin
                    result := 'Failed';
                end
            end;
        end;
    end;
}

