#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516400 "BOSA Receipt Card"
{
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = "Receipts & Payments";
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            group(Transaction)
            {
                Caption = 'Transaction';
                field("Transaction No."; "Transaction No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Source)
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Receipt Mode"; "Receipt Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Excess Transaction Type"; "Excess Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Allocated Amount"; "Allocated Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Un allocated Amount"; "Un allocated Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer No."; "Employer No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Teller Till / Bank  No.';
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque / Slip  No.';
                }
                field("Cheque Date"; "Cheque Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque / Slip  Date';
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Transaction Time"; "Transaction Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                part(Control2; "Receipt AllocationBOSA New")
                {
                    SubPageLink = "Member No" = field(filter("Account No.")),
                                  "Global Dimension 1 Code" = field(filter("Global Dimension 1 Code")),
                                  "Global Dimension 2 Code" = field(filter("Global Dimension 2 Code")),
                                  "Document No" = field(filter("Transaction No."));
                    Visible = false;
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
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cheque := false;
                        //SuggestBOSAEntries();
                    end;
                }
                separator(Action1102760032)
                {
                }
                action("Suggest Payments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Suggest Monthy Repayments';
                    Image = Suggest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ObjTransactions: Record "Receipt Allocation";
                        RunBal: Decimal;
                        Datefilter: Text;
                    begin

                        TestField(Posted, false);
                        TestField("Account No.");
                        TestField(Amount);
                        // ,Registration Fee,Share Capital,Interest Paid,Loan Repayment,Deposit Contribution,Insurance Contribution,Benevolent Fund,Loan,Unallocated Funds,Dividend,FOSA Account

                        ObjTransactions.Reset;
                        ObjTransactions.SetRange(ObjTransactions."Document No", Rec."Transaction No.");
                        if ObjTransactions.Find('-') then
                            ObjTransactions.DeleteAll;
                        Datefilter := '..' + Format("Transaction Date");
                        RunBal := 0;
                        RunBal := Amount;
                        RunBal := FnRunEntranceFee(Rec, RunBal);
                        RunBal := FnRunShareCapital(Rec, RunBal);
                        RunBal := FnRunInterest(Rec, RunBal);
                        RunBal := FnRunPrinciple(Rec, RunBal);
                        RunBal := FnRunDepositContribution(Rec, RunBal);
                        RunBal := FnRunBenevolentFund(Rec, RunBal);
                        if RunBal > 0 then begin
                            if Confirm('Excess Money will allocated to ' + Format("Excess Transaction Type") + '.Do you want to Continue?', true) = false then
                                exit;
                            case "Excess Transaction Type" of
                                "excess transaction type"::Deposits:
                                    FnRunDepositContributionFromExcess(Rec, RunBal);
                                "excess transaction type"::"Fosa Saving":
                                    FnRunSavingsProductExcess(Rec, RunBal, 'ORDINARY');
                            end;
                        end;
                        CalcFields("Allocated Amount");
                        "Un allocated Amount" := (Amount - "Allocated Amount");
                        Modify;
                    end;
                }
            }
        }
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = Basic;
                Caption = 'Post (F11)';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    /*IF ("Receipt Mode"="Receipt Mode"::Cash) AND ("Transaction Date"<> TODAY) THEN
                    ERROR('You cannot post cash transactions with a date not today');
                    //UserSetup.GET(USERID);*/
                    //IF "Posting Date"<>TODAY THEN
                    /*IF UserSetup."Backdate Receipt"=FALSE THEN
                      ERROR('You cannot post the transactions with a date that is not today');*/

                    if Confirm('Do you wish to Receipt Ksh.%1 From %2', true, Amount, Name) = false then
                        exit;

                    if Posted then
                        Error('This receipt is already posted');

                    TestField("Account No.");
                    TestField(Amount);
                    TestField(Remarks);
                    //TESTFIELD("Employer No.");
                    //TESTFIELD("Cheque No.");
                    //TESTFIELD("Cheque Date");

                    if ("Account Type" = "account type"::"G/L Account") or
                       ("Account Type" = "account type"::Debtor) then
                        TransType := 'Withdrawal'
                    else
                        TransType := 'Deposit';

                    BOSABank := "Employer No.";
                    if ("Account Type" = "account type"::Member) or ("Account Type" = "account type"::"FOSA Loan") or ("Account Type" = "account type"::Micro) then begin

                        if Amount <> "Allocated Amount" then
                            Error('Receipt amount must be equal to the allocated amount.');
                    end;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    GenJournalLine.DeleteAll;


                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Document No." := "Transaction No.";
                    GenJournalLine."External Document No." := "Cheque No.";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := "Employer No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := "Posting Date";
                    //GenJournalLine."Posting Date":="Transaction Date";
                    GenJournalLine.Description := 'BT-' + "Account No." + '-' + Remarks;
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    ReceiptAllocations."Global Dimension 1 Code" := "Global Dimension 1 Code";
                    ReceiptAllocations."Global Dimension 2 Code" := "Global Dimension 2 Code";
                    if TransType = 'Withdrawal' then
                        GenJournalLine.Amount := -Amount
                    else
                        GenJournalLine.Amount := Amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    if ("Account Type" <> "account type"::Member) and ("Account Type" <> "account type"::"FOSA Loan") and ("Account Type" <> "account type"::Vendor) and
                      ("Account Type" <> "account type"::Micro) then begin
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Document No." := "Transaction No.";
                        GenJournalLine."External Document No." := "Cheque No.";
                        GenJournalLine."Line No." := LineNo;
                        if "Account Type" = "account type"::"G/L Account" then
                            GenJournalLine."Account Type" := "Account Type"
                        else
                            if "Account Type" = "account type"::Debtor then
                                GenJournalLine."Account Type" := "Account Type"
                            else
                                if "Account Type" = "account type"::Vendor then
                                    GenJournalLine."Account Type" := "Account Type"
                                else
                                    if "Account Type" = "account type"::Member then
                                        GenJournalLine."Account Type" := "Account Type"
                                    else
                                        if "Account Type" = "account type"::Micro then
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                        GenJournalLine."Account No." := "Account No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        //GenJournalLine."Posting Date":="Cheque Date";
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine.Description := 'BT-' + Name + '-' + "Account No." + '-' + Remarks;
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        if TransType = 'Withdrawal' then
                            GenJournalLine.Amount := Amount
                        else
                            GenJournalLine.Amount := -Amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        ReceiptAllocations."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        ReceiptAllocations."Global Dimension 2 Code" := "Global Dimension 2 Code";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;

                    GenSetup.Get();

                    if ("Account Type" = "account type"::Member) or ("Account Type" = "account type"::"FOSA Loan") or ("Account Type" = "account type"::Vendor) or
                      ("Account Type" = "account type"::Micro) then begin
                        ReceiptAllocations.Reset;
                        ReceiptAllocations.SetRange(ReceiptAllocations."Document No", "Transaction No.");
                        if ReceiptAllocations.Find('-') then begin
                            repeat
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := "Transaction No.";
                                GenJournalLine."External Document No." := "Cheque No.";
                                GenJournalLine."Posting Date" := "Posting Date";
                                //        GenJournalLine."Posting Date":="Transaction Date";
                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"FOSA Account" then begin
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := ReceiptAllocations."Account No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine.Description := 'BT-' + Name + '-' + "Account No." + '-' + Remarks;
                                    ReceiptAllocations."Global Dimension 1 Code" := 'FOSA';
                                    ReceiptAllocations."Global Dimension 2 Code" := SURESTEPFactory.FnGetUserBranch();
                                end else begin
                                    if "Account Type" = "account type"::Vendor then begin
                                        //                GenJournalLine."Posting Date":="Transaction Date";
                                        GenJournalLine."Posting Date" := "Transaction Date";
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                        GenJournalLine."Shortcut Dimension 2 Code" := SURESTEPFactory.FnGetUserBranch();
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Account No." := ReceiptAllocations."Member No";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        if ("Receipt Mode" = "receipt mode"::Mpesa) and (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"FOSA Account") then begin
                                            GenJournalLine.Amount := -Amount;
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                            GenJournalLine."Account No." := GenSetup."FOSA MPESA COmm A/C";
                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                                            GenJournalLine."Bal. Account No." := "Account No.";
                                        end;
                                    end;
                                    if ("Account Type" = "account type"::Member) or ("Account Type" = "account type"::Micro) then begin
                                        //                GenJournalLine."Posting Date":="Transaction Date";
                                        GenJournalLine."Posting Date" := "Posting Date";
                                        ReceiptAllocations."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                        ReceiptAllocations."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                        GenJournalLine."Account No." := ReceiptAllocations."Member No";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        if ("Receipt Mode" = "receipt mode"::Mpesa) and (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"FOSA Account") then begin
                                            GenJournalLine.Amount := -Amount;
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                            GenJournalLine."Account No." := GenSetup."FOSA MPESA COmm A/C";
                                        end;
                                    end;
                                end;
                                GenJournalLine.Amount := -ReceiptAllocations.Amount;
                                GenJournalLine."Shortcut Dimension 1 Code" := ReceiptAllocations."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code" := ReceiptAllocations."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type") + '-' + Remarks + '-' + Format("Receipt Mode") + '-' + "Cheque No.";
                                GenJournalLine."Transaction Type" := ReceiptAllocations."Transaction Type";
                                GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                            until ReceiptAllocations.Next = 0;
                        end;


                    end;

                    //Post New
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    if GenJournalLine.Find('-') then begin


                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;
                    //Post New
                    Message('Transaction posted successfully');

                    if Confirm('Do you want to Print Report?', true) = false then
                        BOSARcpt.Reset;
                    BOSARcpt.SetRange(BOSARcpt."Transaction No.", "Transaction No.");
                    if BOSARcpt.Find('-') then
                        Report.Run(51516387, true, true, BOSARcpt);

                    Posted := true;
                    // // Posted:=TRUE;
                    Modify;

                    BOSARcpt.Reset;
                    BOSARcpt.SetRange(BOSARcpt."Transaction No.", "Transaction No.");
                    if BOSARcpt.Find('-') then BEGIN
                        /* IF{ ("Mode of Payment"<>"Mode of Payment"::"Standing order") AND }
                            //("Mode of Payment"<>"Mode of Payment"::"Direct Debit") AND
                            ("Receipt Mode"<>"Receipt Mode"::Mpesa) THEN BEGIN*/
                        //ok:=CONFIRM('Do you want to print Reciept'+FORMAT("Transaction No.")+'?');
                        /*IF CONFIRM('Are you sure you want to print the reciept?',FALSE) = TRUE THEN BEGIN
                        //IF ok THEN BEGIN
                        BOSARcpt.RESET;
                        BOSARcpt.SETRANGE(BOSARcpt."Transaction No.","Transaction No.");
                        IF BOSARcpt.FIND('-') THEN
                        REPORT.RUN(51516486,FALSE,TRUE,BOSARcpt);

                        END;*/
                        //END;
                        // REPORT.RUN(51516486,TRUE,TRUE,BOSARcpt)
                        // END;

                        CurrPage.Close;

                    end;
            }
            action("Reprint Frecipt")
            {
                ApplicationArea = Basic;
                Caption = 'Reprint Receipt';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    TestField(Posted);

                    BOSARcpt.Reset;
                    BOSARcpt.SetRange(BOSARcpt."Transaction No.", "Transaction No.");
                    if BOSARcpt.Find('-') then
                        Report.Run(51516486, true, true, BOSARcpt)
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CalcFields("Allocated Amount");
        "Un allocated Amount" := Amount - "Allocated Amount";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        BOSARcpt.Reset;
        BOSARcpt.SetRange(BOSARcpt.Posted, false);
        BOSARcpt.SetRange(BOSARcpt."User ID", UserId);
        if BOSARcpt.Find('-') then begin
            if BOSARcpt."Account No." = '' then begin
                if BOSARcpt.Count >= 2 then begin
                    Error('There are still some Unused Receipt Nos. Please utilise them first');
                end;
            end;
        end;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        InterestPaid: Decimal;
        PaymentAmount: Decimal;
        RunBal: Decimal;
        Recover: Boolean;
        Cheque: Boolean;
        ReceiptAllocations: Record "Receipt Allocation";
        Loans: Record "Loans Register";
        Commision: Decimal;
        LOustanding: Decimal;
        TotalCommision: Decimal;
        TotalOustanding: Decimal;
        Cust: Record Customer;
        BOSABank: Code[20];
        LineNo: Integer;
        BOSARcpt: Record "Receipts & Payments";
        TellerTill: Record "Bank Account";
        CurrentTellerAmount: Decimal;
        TransType: Text[30];
        RCPintdue: Decimal;
        Text001: label 'This member has reached a maximum share contribution of Kshs. 5,000/=. Do you want to post this transaction as shares contribution?';
        BosaSetUp: Record "Sacco General Set-Up";
        MpesaCharge: Decimal;
        CustPostingGrp: Record "Customer Posting Group";
        MpesaAc: Code[30];
        GenSetup: Record "Sacco General Set-Up";
        ShareCapDefecit: Decimal;
        LoanApp: Record "Loans Register";
        Datefilter: Text;
        SURESTEPFactory: Codeunit "SURESTEP Factory.";
        UserSetup: Record "User Setup";
        ok: Boolean;

    local procedure AllocatedAmountOnDeactivate()
    begin
        CurrPage.Update := true;
    end;

    local procedure FnRunInterest(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    LoanApp.CalcFields(LoanApp."Oustanding Interest");
                    if LoanApp."Oustanding Interest" > 0 then begin
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            AmountToDeduct := ROUND(LoanApp."Oustanding Interest", 0.05, '>');
                            if RunningBalance <= AmountToDeduct then
                                AmountToDeduct := RunningBalance;
                            ObjReceiptTransactions.Init;
                            ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Interest Paid";
                            ObjReceiptTransactions.Validate(ObjReceiptTransactions."Transaction Type");
                            ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                            ObjReceiptTransactions.Validate(ObjReceiptTransactions."Loan No.");

                            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                            ObjReceiptTransactions.Amount := AmountToDeduct;
                            if ObjReceiptTransactions.Amount > 0 then
                                ObjReceiptTransactions.Insert(true);
                            RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunPrinciple(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);

            if LoanApp.Find('-') then begin
                repeat
                    AmountToDeduct := 0;
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            AmountToDeduct := LoanApp."Loan Principle Repayment";
                            if AmountToDeduct > 0 then begin
                                if AmountToDeduct > LoanApp."Outstanding Balance" then
                                    AmountToDeduct := LoanApp."Outstanding Balance";
                                if AmountToDeduct > RunningBalance then
                                    AmountToDeduct := RunningBalance;
                                ObjReceiptTransactions.Init;
                                ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                                ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                                ObjReceiptTransactions."Member No" := LoanApp."Client Code";
                                ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Loan Repayment";
                                ObjReceiptTransactions.Validate(ObjReceiptTransactions."Transaction Type");
                                ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                                ObjReceiptTransactions.Validate(ObjReceiptTransactions."Loan No.");
                                ObjReceiptTransactions."Global Dimension 1 Code" := Format(LoanApp.Source);
                                ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                                ObjReceiptTransactions.Amount := AmountToDeduct;
                                if ObjReceiptTransactions.Amount > 0 then
                                    ObjReceiptTransactions.Insert(true);
                                RunningBalance := RunningBalance - AmountToDeduct;
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunEntranceFee(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
    begin
        if RunningBalance > 0 then begin
            GenSetup.Get();
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
            ObjMember.SetFilter(ObjMember."Registration Date", '>%1', 20181001D); //To Ensure deduction is for New Members Only
            if ObjMember.Find('-') then begin
                ObjMember.CalcFields(ObjMember."Registration Fee Paid");
                if Abs(ObjMember."Registration Fee Paid") < 1000 then begin
                    if ObjMember."Registration Date" <> 0D then begin

                        AmountToDeduct := 0;
                        AmountToDeduct := GenSetup."BOSA Registration Fee Amount" - Abs(ObjMember."Registration Fee Paid");
                        if RunningBalance <= AmountToDeduct then
                            AmountToDeduct := RunningBalance;
                        ObjReceiptTransactions.Init;
                        ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                        ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                        ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Registration Fee";
                        ObjReceiptTransactions.Validate(ObjReceiptTransactions."Transaction Type");
                        ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                        ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                        ObjReceiptTransactions.Amount := AmountToDeduct;
                        if ObjReceiptTransactions.Amount <> 0 then
                            ObjReceiptTransactions.Insert(true);
                        if ObjMember."Registration Fee Paid" = 1000 then
                            ObjMember."Reg Fee Paid." := true;
                        ObjMember.Modify;
                        RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                    end;
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunShareCapital(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
        SharesCap: Decimal;
        DIFF: Decimal;
    begin
        if RunningBalance > 0 then begin
            GenSetup.Get();
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
            ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
            if ObjMember.Find('-') then begin
                //REPEAT Deducted once unless otherwise advised
                ObjMember.CalcFields(ObjMember."Shares Retained");
                if ObjMember."Shares Retained" < GenSetup."Retained Shares" then begin
                    SharesCap := GenSetup."Retained Shares";
                    DIFF := SharesCap - ObjMember."Shares Retained";

                    if DIFF > 1 then begin
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            AmountToDeduct := DIFF;
                            if DIFF > 1 then
                                AmountToDeduct := DIFF;
                            if RunningBalance <= AmountToDeduct then
                                AmountToDeduct := RunningBalance;

                            ObjReceiptTransactions.Init;
                            ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Share Capital";
                            ObjReceiptTransactions.Validate(ObjReceiptTransactions."Transaction Type");
                            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                            ObjReceiptTransactions.Amount := AmountToDeduct;
                            if ObjReceiptTransactions.Amount <> 0 then
                                ObjReceiptTransactions.Insert(true);
                            RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                        end;
                    end;
                end;
                //UNTIL RcptBufLines.NEXT=0;
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRunDepositContribution(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
        SharesCap: Decimal;
        DIFF: Decimal;
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
            ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
            if ObjMember.Find('-') then begin
                AmountToDeduct := 0;
                AmountToDeduct := ROUND(ObjMember."Monthly Contribution", 0.05, '>');
                if RunningBalance <= AmountToDeduct then
                    AmountToDeduct := RunningBalance;

                ObjReceiptTransactions.Init;
                ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Deposit Contribution";
                ObjReceiptTransactions.Validate(ObjReceiptTransactions."Transaction Type");
                ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                ObjReceiptTransactions.Amount := AmountToDeduct;
                if ObjReceiptTransactions.Amount <> 0 then
                    ObjReceiptTransactions.Insert(true);
                RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRunInsuranceContribution(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
    begin
        GenSetup.Get();
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
            if ObjMember.Find('-') then begin
                if ObjMember."Registration Date" <> 0D then begin
                    AmountToDeduct := 0;
                    AmountToDeduct := GenSetup."Insurance Contribution";
                    if RunningBalance <= AmountToDeduct then
                        AmountToDeduct := RunningBalance;
                    ObjReceiptTransactions.Init;
                    ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                    ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                    ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Insurance Contribution";
                    ObjReceiptTransactions.Validate(ObjReceiptTransactions."Transaction Type");
                    ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                    ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                    ObjReceiptTransactions.Amount := AmountToDeduct;
                    if ObjReceiptTransactions.Amount <> 0 then
                        ObjReceiptTransactions.Insert(true);
                    RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunBenevolentFund(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
    begin
        if RunningBalance > 0 then begin
            GenSetup.Get();
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
            if ObjMember.Find('-') then begin
                if ObjMember."Registration Date" <> 0D then begin

                    AmountToDeduct := 0;
                    AmountToDeduct := GenSetup."Risk Fund Amount";
                    if RunningBalance <= AmountToDeduct then
                        AmountToDeduct := RunningBalance;
                    ObjReceiptTransactions.Init;
                    ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                    ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                    ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Benevolent Fund";
                    ObjReceiptTransactions.Validate(ObjReceiptTransactions."Transaction Type");
                    ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                    ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                    ObjReceiptTransactions.Amount := AmountToDeduct;
                    if ObjReceiptTransactions.Amount <> 0 then
                        ObjReceiptTransactions.Insert(true);
                    RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunUnallocatedAmount(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
    begin
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
        if ObjMember.Find('-') then begin
            begin
                AmountToDeduct := 0;
                AmountToDeduct := RunningBalance;
                ObjReceiptTransactions.Init;
                ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Unallocated Funds";
                ObjReceiptTransactions.Validate(ObjReceiptTransactions."Transaction Type");
                ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                ObjReceiptTransactions.Amount := AmountToDeduct;
                if ObjReceiptTransactions.Amount <> 0 then
                    ObjReceiptTransactions.Insert(true);
            end;
        end;
    end;

    local procedure FnRunDepositContributionFromExcess(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
        SharesCap: Decimal;
        DIFF: Decimal;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account";
    begin

        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
        ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
        if ObjMember.Find('-') then begin
            AmountToDeduct := 0;
            AmountToDeduct := RunningBalance + FnReturnAmountToClear(Transtype::"Deposit Contribution");
            ObjReceiptTransactions.Init;
            ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Deposit Contribution";
            ObjReceiptTransactions.Validate(ObjReceiptTransactions."Transaction Type");
            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
            ObjReceiptTransactions.Amount := AmountToDeduct;
            if ObjReceiptTransactions.Amount <> 0 then
                ObjReceiptTransactions.Insert(true);
        end;
    end;

    local procedure FnReturnAmountToClear(TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account") AmountReturned: Decimal
    var
        ObjReceiptAllocation: Record "Receipt Allocation";
    begin
        ObjReceiptAllocation.Reset;
        ObjReceiptAllocation.SetRange("Document No", Rec."Transaction No.");
        ObjReceiptAllocation.SetRange("Transaction Type", TransType);
        if ObjReceiptAllocation.Find('-') then begin
            AmountReturned := ObjReceiptAllocation.Amount;
            ObjReceiptAllocation.Delete;
        end;
        exit;
    end;

    local procedure FnRunSavingsProductExcess(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal; SavingsProduct: Code[100]): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
        SharesCap: Decimal;
        DIFF: Decimal;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account";
    begin
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
        ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
        if ObjMember.Find('-') then begin
            AmountToDeduct := 0;
            AmountToDeduct := RunningBalance + FnReturnAmountToClear(Transtype::"FOSA Account");
            ObjReceiptTransactions.Init;
            ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
            ObjReceiptTransactions."Account No" := ObjMember."FOSA Account";
            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"FOSA Account";
            ObjReceiptTransactions."Global Dimension 1 Code" := 'FOSA';
            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
            ObjReceiptTransactions.Amount := AmountToDeduct;
            if ObjReceiptTransactions.Amount <> 0 then
                ObjReceiptTransactions.Insert(true);
        end;
    end;
}

