#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516138 "Cashier Transactions Cards"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Transactions;
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            group(Transactions)
            {
                Caption = 'Transactions';
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Savings Product"; "Savings Product")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if Posted = true then
                            Error('You cannot modify an already posted record.');

                        CalcAvailableBal;

                        Clear(AccP.Piccture);
                        Clear(AccP.Signature);
                        if AccP.Get("Account No") then begin
                            /*//Hide Accounts
                            IF AccP.Hide = TRUE THEN BEGIN
                            IF UsersID.GET(USERID) THEN BEGIN
                            IF UsersID."Show Hiden" = FALSE THEN
                            ERROR('You do not have permission to transact on this account.');
                            END;
                            END; */
                            //Hide Accounts
                            AccP.CalcFields(AccP.Piccture, AccP.Signature);
                        end;

                        CalcFields("Uncleared Cheques");
                        if AccP.Get("Account No") then begin
                            //Picture:=AccP.Piccture;

                        end;

                    end;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if Posted = true then
                            Error('You cannot modify an already posted record.');

                        FChequeVisible := false;
                        BChequeVisible := false;
                        BReceiptVisible := false;
                        BOSAReceiptChequeVisible := false;
                        "Branch RefferenceVisible" := false;
                        LRefVisible := false;
                        ChequeTransfVisible := false;
                        ChequeWithdrawalVisible := false;
                        DepositSlipVisible := false;
                        ABCTransactionVisible := false;

                        if TransactionTypes.Get("Transaction Type") then begin
                            if TransactionTypes.Type = TransactionTypes.Type::"Cheque Deposit" then begin
                                FChequeVisible := true;
                                if ("Account No" = '502-00-000300-00') or ("Account No" = '502-00-000303-00') then
                                    BOSAReceiptChequeVisible := true;
                            end;
                            if TransactionTypes.Type = TransactionTypes.Type::"Bankers Cheque" then
                                BChequeVisible := true;

                            if ("Transaction Type" = 'BOSA') or ("Transaction Type" = 'FOSALOAN') then
                                BReceiptVisible := true;

                            if TransactionTypes.Type = TransactionTypes.Type::"ABC Deposit" then
                                ABCTransactionVisible := true;

                            TellerTill.Reset;
                            TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
                            TellerTill.SetRange(TellerTill."Cashier ID", UserId);
                            if TellerTill.Find('-') then begin
                                "Bank Account" := TellerTill."No.";
                            end;

                            if TransactionTypes.Type = TransactionTypes.Type::Transfer then begin
                                ChequeTransfVisible := true;
                            end;

                            if TransactionTypes.Type = TransactionTypes.Type::"Inhouse Cheque Withdrawal" then begin
                                ChequeWithdrawalVisible := true;
                            end;

                            if TransactionTypes.Type = TransactionTypes.Type::"Deposit Slip" then begin
                                DepositSlipVisible := true;
                            end;

                            if TransactionTypes.Type = TransactionTypes.Type::Encashment then
                                BReceiptVisible := true;



                        end;

                        if "Branch Transaction" = true then begin
                            "Branch RefferenceVisible" := true;
                            LRefVisible := true;
                        end;

                        if Acc.Get("Account No") then begin
                            if Acc."Account Category" = Acc."account category"::Project then begin
                                "Branch RefferenceVisible" := true;
                                LRefVisible := true;
                            end;
                        end;


                        CalcAvailableBal;
                    end;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Mode New"; "Transaction Mode New")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction Mode';
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                group(DepositSlip)
                {
                    Visible = DepositSlipVisible;
                    field("Receipt Bank."; "Bank Account")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Receipt Bank';
                    }
                    field("Document Date"; "Document Date")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(BCheque)
                {
                    Caption = '.';
                    Visible = BChequeVisible;
                    field("Bankers Cheque No"; "Bankers Cheque No")
                    {
                        ApplicationArea = Basic;
                    }
                    field(Payee; Payee)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Post Dated"; "Post Dated")
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            "Transaction DateEditable" := false;
                            if "Post Dated" = true then
                                "Transaction DateEditable" := true
                            else
                                "Transaction Date" := Today;
                        end;
                    }
                    field("Cheque Clearing Bank Code"; "Cheque Clearing Bank Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing Bank_ Code';
                    }
                    field("Cheque Clearing Bank"; "Cheque Clearing Bank")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing_Bank';
                        Editable = false;
                    }
                }
                group(BReceipt)
                {
                    Caption = '.';
                    Visible = BReceiptVisible;
                    field("BOSA Account No"; "BOSA Account No")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Allocated Amount"; "Allocated Amount")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Receipt Bank"; "Bank Account")
                    {
                        ApplicationArea = Basic;
                    }
                    field("<Document Date.>"; "Document Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Document Date';
                    }
                }
                group(FCheque)
                {
                    Caption = '.';
                    Visible = FChequeVisible;
                    field("Cheque Type"; "Cheque Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Cheque No"; "Cheque No")
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            if StrLen("Cheque No") <> 6 then
                                Error('Cheque No. cannot contain More or less than 6 Characters.');
                        end;
                    }
                    field("Bank Code"; "Bank Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Source Bank';
                    }
                    field("<Cheque Clearing Bank_Code>"; "Cheque Clearing Bank Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing Bank Code>';
                    }
                    field("<Cheque_Clearing Bank>"; "Cheque Clearing Bank")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing Bank';
                        Editable = false;
                    }
                    field("Expected Maturity Date"; "Expected Maturity Date")
                    {
                        ApplicationArea = Basic;
                    }
                    field(Status; Status)
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("50048"; "Banking Posted")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Banked';
                        Editable = false;
                    }
                    field("Bank Account"; "Bank Account")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    field("Cheque Date"; "Cheque Date")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Cheque Deposit Remarks"; "Cheque Deposit Remarks")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(ChequeWithdrawal)
                {
                    Caption = '.';
                    Visible = ChequeWithdrawalVisible;
                    field("Cheque TypeWith"; "Cheque Type")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Type';
                    }
                    field("Drawer's Account No."; "Drawer's Account No")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Drawer''s Account No.';
                    }
                    field("Drawer's NameWith"; "Drawer's Name")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Drawer''s Name';
                        Editable = false;
                    }
                    field("Drawers Cheque No.With"; "Drawers Cheque No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Drawers Cheque No.';
                    }
                    field("Cheque DateWith"; "Cheque Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Date';
                    }
                    field("Cheque Deposit RemarksWith"; "Cheque Deposit Remarks")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Deposit Remarks';
                    }
                    field("Cheque Clearing Bank Code.With"; "Cheque Clearing Bank Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing Bank Code.';
                    }
                }
                group(ABCTransaction)
                {
                    Caption = '.';
                    field("ABC Transaction Type"; "ABC Transaction Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field("ABC Depositer"; "ABC Depositer")
                    {
                        ApplicationArea = Basic;
                    }
                    field("ABC Depositer ID"; "ABC Depositer ID")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(ChequeTransf)
                {
                    Caption = '.';
                    Visible = ChequeTransfVisible;
                    field("Cheque TypeTR"; "Cheque Type")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Type';
                    }
                    field("Drawer's Account No"; "Drawer's Account No")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Drawer's Name"; "Drawer's Name")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Drawers Cheque No."; "Drawers Cheque No.")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Cheque DateTR"; "Cheque Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Date';
                    }
                    field("Cheque Deposit RemarksTR"; "Cheque Deposit Remarks")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Deposit Remarks';
                    }
                    field("<Cheque Clearing Bank Code.>"; "Cheque Clearing Bank Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing Bank Code.';
                    }
                    group(BOSAReceiptCheque)
                    {
                        Caption = '.';
                        Visible = BOSAReceiptChequeVisible;
                    }
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Description"; "Transaction Description")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Branch Refference"; "Branch Refference")
                {
                    ApplicationArea = Basic;
                    Caption = 'REF';
                    Visible = "Branch RefferenceVisible";
                }
                field("Book Balance"; "Book Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Uncleared Cheques"; "Uncleared Cheques")
                {
                    ApplicationArea = Basic;
                }
                field(AvailableBalance; AvailableBalance)
                {
                    ApplicationArea = Basic;
                    Caption = 'Available Balance';
                    Editable = false;
                }
                field("N.A.H Balance"; "N.A.H Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("ID No"; "ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Cashier; Cashier)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Time"; "Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field(Authorised; Authorised)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature; Signature)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000000; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("Account No");
            }
            part(Control1000000018; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Member No");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Transaction)
            {
                Caption = 'Transaction';
                action("Account Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Card';
                    Image = Vendor;
                    Promoted = true;
                    RunObject = Page "FOSA Account Card";
                    RunPageLink = "No." = field("Account No");
                }
                separator(Action1102760031)
                {
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories Details';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Account Signatory list";
                    RunPageLink = "Account No" = field("Member No");
                }
            }
            action("Account Agent Details")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Agent Account Signatory list";
                RunPageLink = "Account No" = field("Account No");
            }
            action("Members Statistics")
            {
                ApplicationArea = Basic;
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Members Statistics";
                RunPageLink = "No." = field("Member No");
            }
            action("Account Statement")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin

                    Vend.Reset;
                    Vend.SetRange(Vend."No.", "Account No");
                    if Vend.Find('-') then
                        Report.Run(51516476, true, false, Vend)
                end;
            }
            action("Suggest Payments")
            {
                ApplicationArea = Basic;
                Caption = 'Suggest Monthy Repayments';
                Promoted = true;
                PromotedCategory = Process;
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
                ShortCutKey = 'F11';

                trigger OnAction()
                begin
                    //Check if Posted
                    BankLedger.Reset;
                    BankLedger.SetRange(BankLedger."Document No.", No);
                    if BankLedger.Find('-') then begin
                        Posted := true;
                        Modify;
                        Message('Transaction is aready posted');
                        exit;
                    end;





                    //Ensure Min Share Capital Is Contributed
                    BosaSetUp.Get();
                    if Type = 'BOSA Receipt' then begin
                        if Cust.Get("Member No") then begin
                            Cust.CalcFields(Cust."Registration Fee Paid", Cust."Shares Retained");
                            if Cust."Shares Retained" < BosaSetUp."Retained Shares" then begin


                                ReceiptAllocations.Reset;
                                ReceiptAllocations.SetRange(ReceiptAllocations."Document No", No);
                                ReceiptAllocations.SetRange(ReceiptAllocations."Transaction Type", ReceiptAllocations."transaction type"::"Share Capital");
                                if not ReceiptAllocations.Find('-') then
                                    Message('The Member Must first Contribute Min. Share Capital Amount');

                                ReceiptAllocations.Reset;
                                ReceiptAllocations.SetRange(ReceiptAllocations."Document No", No);
                                //ReceiptAllocations.SETRANGE(ReceiptAllocations."Transaction Type",ReceiptAllocations."Transaction Type"::"Shares Capital");
                                if ReceiptAllocations.Find('-') then begin
                                    //IF ReceiptAllocations."Transaction Type"=ReceiptAllocations."Transaction Type"::"Shares Capital" THEN BEGIN
                                    if ReceiptAllocations.Count > 1 then
                                        if ReceiptAllocations.Amount < (BosaSetUp."Retained Shares" - Cust."Shares Retained") then
                                            Message('The Member Must first Contribute Min. Share Capital Amount');


                                end;
                            end;
                        end;
                    end;




                    if Cashier <> UpperCase(UserId) then
                        Error('Cannot post a Transaction being processed by %1', Cashier);

                    BankLedger.Reset;
                    BankLedger.SetRange(BankLedger."Posting Date", Today);
                    BankLedger.SetRange(BankLedger."User ID", "Posted By");
                    BankLedger.SetRange(BankLedger.Description, 'END OF DAY RETURN TO TREASURY');
                    if BankLedger.Find('-') = true then begin
                        Error('You cannot post any transactions after perfoming end of day');
                    end;




                    UsersID.Reset;
                    UsersID.SetRange(UsersID."User Name", UpperCase(UserId));
                    if UsersID.Find('-') then begin
                        //DBranch:=UsersID.Branch;
                        DActivity := 'FOSA';
                        //MESSAGE('%1,%2',Branch,Activity);
                    end;


                    if "Transaction Date" <> Today then begin
                        "Transaction Date" := Today;
                        Modify;
                    end;



                    if Posted = true then
                        Error('The transaction has already been posted.');

                    VarAmtHolder := 0;

                    if Amount <= 0 then
                        Error('Please specify an amount greater than zero.');

                    if "Transaction Type" = '' then
                        Error('Please select the transaction type.');

                    //BOSA Entries
                    if ("Account No" = '502-00-000300-00') or ("Account No" = '502-00-000303-00') then begin
                        TestField("BOSA Account No");
                        if Amount <> "Allocated Amount" then
                            Error('Allocated amount must be equall to the transaction amount.');

                    end;

                    /*
                    IF "Branch Transaction" = TRUE THEN BEGIN
                    IF "Branch Refference" = '' THEN
                    ERROR('You must specify the refference details for branch transactions.');
                    END;*/
                    /*
                    //Project Accounts
                    IF Acc.GET("Account No") THEN BEGIN
                    IF Acc."Account Category" = Acc."Account Category"::Project THEN BEGIN
                    IF "Branch Refference" = '' THEN
                    ERROR('You must specify the refference details for Project transactions.');
                    END;
                    END;*/
                    //Project Accounts


                    "Post Attempted" := true;
                    Modify;

                    if Type = 'Cheque Deposit' then begin
                        TestField("Cheque Type");
                        TestField("Cheque No");
                        TestField("Cheque Date");
                        TestField("Bank Code");

                        PostChequeDep;

                        exit;
                    end;

                    if Type = 'Transfer' then begin
                        TestField("Drawers Cheque No.");
                        TestField("Drawer's Account No");

                        PostTransfer;

                        exit;
                    end;

                    if Type = 'Bankers Cheque' then begin

                        PostBankersCheq;

                        exit;
                    end;

                    if (Type = 'Encashment') or (Type = 'Inhouse Cheque Withdrawal') then begin
                        PostEncashment;

                        exit;
                    end;
                    if Type = 'Deposit Slip' then begin
                        PostDepSlipDep;
                    end;

                    //NON CUST
                    /*
                    IF "Account No" = '507-10000-00' THEN BEGIN
                    PostEncashment;
                    
                    EXIT;
                    
                    END;
                    */
                    //NON CUST
                    if Type = 'BOSA Receipt' then begin
                        PostBOSAEntries;
                        exit;
                    end;

                    if Type = 'Transfer' then begin
                        PostTransfer;
                    end;

                    if (Type = 'Withdrawal') or (Type = 'Cash Deposit') then begin
                        //ADDED
                        //PostCashDepWith;
                    end;

                    if Type = 'ABC Deposit' then begin
                        TestField("ABC Depositer");
                        TestField("ABC Depositer ID");
                        TestField("ABC Transaction Type");
                        //ADDED
                        //PostCashDepWith;
                    end;


                    exit;
                    //ADDED

                end;
            }
            action(SendMail)
            {
                ApplicationArea = Basic;
                Caption = 'SendMail';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    MailContent := 'Bankers cheque transaction' + ' ' + 'of Kshs' + ' ' + Format(Amount) + ' ' + 'for'
                    + ' ' + "Account Name" + ' ' + 'needs your approval';


                    SendEmail;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /*CalcAvailableBal;
        CLEAR(AccP.Piccture);
        CLEAR(AccP.Signature);
        IF AccP.GET("Account No") THEN BEGIN
        AccP.CALCFIELDS(AccP.Piccture);
        AccP.CALCFIELDS(AccP.Signature);
        END;
         */
        SetRange(Cashier, UserId);
        FChequeVisible := false;
        BChequeVisible := false;
        BReceiptVisible := false;
        BOSAReceiptChequeVisible := false;
        ChequeTransfVisible := false;

        if Type = 'Cheque Deposit' then begin
            FChequeVisible := true;
            if ("Account No" = '502-00-000300-00') or ("Account No" = '502-00-000303-00') then
                BOSAReceiptChequeVisible := true;

        end;

        "Branch RefferenceVisible" := false;
        LRefVisible := false;


        if Type = 'Bankers Cheque' then
            BChequeVisible := true;

        if Type = 'Encashment' then
            BReceiptVisible := true;

        if Type = 'ABC Deposit' then
            ABCTransactionVisible := true;


        if ("Transaction Type" = 'BOSA') or ("Transaction Type" = 'FOSALN') then
            BReceiptVisible := true;

        if "Transaction Type" = 'TRANSFER' then
            ChequeTransfVisible := true;

        if "Branch Transaction" = true then begin
            "Branch RefferenceVisible" := true;
            LRefVisible := true;
        end;

        if Acc.Get("Account No") then begin
            if Acc."Account Category" = Acc."account category"::Project then begin
                "Branch RefferenceVisible" := true;
                LRefVisible := true;
            end;
        end;


        "Transaction DateEditable" := false;
        if "Post Dated" = true then
            "Transaction DateEditable" := true;

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if Posted = true then
            Error('You cannot delete an already posted record.');
    end;

    trigger OnInit()
    begin
        "Transaction DateEditable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Clear(Acc.Picture);
        Clear(Acc.Signature);

        "Needs Approval" := "needs approval"::No;
        FChequeVisible := false;

        /*
        CashierTrans.RESET;
         CashierTrans.SETRANGE(CashierTrans.Posted,FALSE);
          CashierTrans.SETRANGE(CashierTrans.Cashier,USERID);
            IF CashierTrans.COUNT >0 THEN
            BEGIN
              IF CashierTrans."Account No"='' THEN BEGIN
              IF CONFIRM('There are still some Unused Transaction Nos. Continue?',FALSE)=FALSE THEN
                BEGIN
                  ERROR('There are still some Unused Transaction Nos. Please utilise them first');
                END;
            END;
            END;
            */

    end;

    trigger OnModifyRecord(): Boolean
    begin
        if xRec.Posted = true then begin
            if Posted = true then
                Error('You cannot modify an already posted record.');
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        TransactionTypes.Type := TransactionTypes.Type::"ABC Deposit";
        "Transaction Type" := 'ABC';
        "Member No" := 'ABC';
        "Member Name" := 'ABC Bank';
        "Account No" := 'ABC';
        "Savings Product" := 'Z_ABC';
        Validate("Transaction Type");
        Validate("Savings Product");
    end;

    trigger OnOpenPage()
    begin
        /*IF UsersID.GET(USERID) THEN BEGIN
        IF UsersID.Branch <> '' THEN
        SETRANGE("Transacting Branch",UsersID.Branch);
        END;*/


        if Posted = true then
            CurrPage.Editable := false;


        FChequeVisible := false;
        BChequeVisible := false;
        BReceiptVisible := false;
        BOSAReceiptChequeVisible := false;
        ChequeTransfVisible := false;
        ChequeWithdrawalVisible := false;
        DepositSlipVisible := false;
        ABCTransactionVisible := false;


        if Type = 'Cheque Deposit' then begin
            FChequeVisible := true;
            if ("Account No" = '502-00-000300-00') or ("Account No" = '502-00-000303-00') then
                BOSAReceiptChequeVisible := true;

        end;

        "Branch RefferenceVisible" := false;
        LRefVisible := false;


        if Type = 'Bankers Cheque' then
            BChequeVisible := true;

        if Type = 'Encashment' then
            BReceiptVisible := true;


        if Type = 'ABC' then
            ABCTransactionVisible := true;

        if ("Transaction Type" = 'BOSA') or ("Transaction Type" = 'FOSALN') then
            BReceiptVisible := true;

        if "Transaction Type" = 'TRANSFER' then
            ChequeTransfVisible := true;

        if TransactionTypes.Type = TransactionTypes.Type::"Inhouse Cheque Withdrawal" then begin
            ChequeWithdrawalVisible := true;
        end;

        if TransactionTypes.Type = TransactionTypes.Type::"Deposit Slip" then begin
            DepositSlipVisible := true;
        end;

        if "Branch Transaction" = true then begin
            "Branch RefferenceVisible" := true;
            LRefVisible := true;
        end;

        if TransactionTypes.Type = TransactionTypes.Type::"ABC Deposit" then begin
            ABCTransactionVisible := true;
        end;

    end;

    var
        LoanBalance: Decimal;
        AvailableBalance: Decimal;
        UnClearedBalance: Decimal;
        LoanSecurity: Decimal;
        LoanGuaranteed: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        window: Dialog;
        Account: Record Vendor;
        TransactionTypes: Record "Transaction Types";
        TransactionCharges: Record "Transaction Charges";
        TCharges: Decimal;
        LineNo: Integer;
        AccountTypes: Record "Account Types-Saving Products";
        GenLedgerSetup: Record "General Ledger Setup";
        MinAccBal: Decimal;
        FeeBelowMinBal: Decimal;
        AccountNo: Code[30];
        NewAccount: Boolean;
        CurrentTellerAmount: Decimal;
        TellerTill: Record "Bank Account";
        IntervalPenalty: Decimal;
        StandingOrders: Record "Standing Orders";
        AccountAmount: Decimal;
        STODeduction: Decimal;
        Charges: Record Charges;
        "Total Deductions": Decimal;
        STODeductedAmount: Decimal;
        NoticeAmount: Decimal;
        AccountNotices: Record "Account Notices";
        Cust: Record Customer;
        AccountHolders: Record Vendor;
        ChargesOnFD: Decimal;
        TotalGuaranted: Decimal;
        VarAmtHolder: Decimal;
        chqtransactions: Record Transactions;
        Trans: Record Transactions;
        TotalUnprocessed: Decimal;
        CustAcc: Record Customer;
        AmtAfterWithdrawal: Decimal;
        TransactionsRec: Record Transactions;
        LoansTotal: Decimal;
        Interest: Decimal;
        InterestRate: Decimal;
        OBal: Decimal;
        Principal: Decimal;
        ATMTrans: Decimal;
        ATMBalance: Decimal;
        TotalBal: Decimal;
        DenominationsRec: Record Denominations;
        TillNo: Code[20];
        FOSASetup: Record "Purchases & Payables Setup";
        Acc: Record Vendor;
        ChequeTypes: Record "Cheque Types";
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        ChBank: Code[20];
        DValue: Record "Dimension Value";
        ReceiptAllocations: Record "Receipt Allocation";
        Loans: Record "Loans Register";
        Commision: Decimal;
        Cheque: Boolean;
        LOustanding: Decimal;
        TotalCommision: Decimal;
        TotalOustanding: Decimal;
        BOSABank: Code[20];
        InterestPaid: Decimal;
        PaymentAmount: Decimal;
        RunBal: Decimal;
        Recover: Boolean;
        genSetup: Record "Sacco General Set-Up";
        MailContent: Text[150];
        supervisor: Record "Supervisors Approval Levels";
        TEXT1: label 'YOU HAVE A TRANSACTION AWAITING APPROVAL';
        AccP: Record Vendor;
        LoansR: Record "Loans Register";
        ClearingCharge: Decimal;
        ClearingRate: Decimal;
        [InDataSet]
        FChequeVisible: Boolean;
        [InDataSet]
        BChequeVisible: Boolean;
        [InDataSet]
        BReceiptVisible: Boolean;
        [InDataSet]
        BOSAReceiptChequeVisible: Boolean;
        [InDataSet]
        "Branch RefferenceVisible": Boolean;
        [InDataSet]
        LRefVisible: Boolean;
        ChequeTransfVisible: Boolean;
        [InDataSet]
        "Transaction DateEditable": Boolean;
        Excise: Decimal;
        Echarge: Decimal;
        BankLedger: Record "Bank Account Ledger Entry";
        Vend: Record Vendor;
        ChequeBook: Record "Cheques Register";
        BosaSetUp: Record "Sacco General Set-Up";
        CashierTrans: Record Transactions;
        ChequeWithdrawalVisible: Boolean;
        DepositSlipVisible: Boolean;
        ABCTransactionVisible: Boolean;


    procedure CalcAvailableBal()
    begin
        ATMBalance := 0;

        TCharges := 0;
        AvailableBalance := 0;
        MinAccBal := 0;
        TotalUnprocessed := 0;
        IntervalPenalty := 0;


        if Account.Get("Account No") then begin
            Account.CalcFields(Account.Balance, Account."Uncleared Cheques", Account."ATM Transactions");

            AccountTypes.Reset;
            AccountTypes.SetRange(AccountTypes.Code, "Savings Product");
            if AccountTypes.Find('-') then begin
                MinAccBal := AccountTypes."Minimum Balance";
                FeeBelowMinBal := AccountTypes."Fee Below Minimum Balance";


                //Check Withdrawal Interval
                if Account.Status <> Account.Status::New then begin
                    if Type = 'Withdrawal' then begin
                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, "Savings Product");
                        if Account."Last Withdrawal Date" <> 0D then begin
                            if CalcDate(AccountTypes."Withdrawal Interval", Account."Last Withdrawal Date") > Today then
                                IntervalPenalty := AccountTypes."Withdrawal Penalty";
                        end;
                    end;
                    //Check Withdrawal Interval

                    //Fixed Deposit
                    ChargesOnFD := 0;
                    if AccountTypes."Fixed Deposit" = true then begin
                        if Account."Expected Maturity Date" > Today then
                            ChargesOnFD := AccountTypes."Charge Closure Before Maturity";
                    end;
                    //Fixed Deposit


                    //Current Charges
                    TransactionCharges.Reset;
                    TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");
                    if TransactionCharges.Find('-') then begin
                        repeat
                            if TransactionCharges."Use Percentage" = true then begin
                                TransactionCharges.TestField("Percentage of Amount");
                                TCharges := TCharges + (TransactionCharges."Percentage of Amount" / 100) * Amount;
                            end else begin
                                TCharges := TCharges + TransactionCharges."Charge Amount";
                            end;
                        until TransactionCharges.Next = 0;
                    end;


                    TotalUnprocessed := Account."Uncleared Cheques";
                    ATMBalance := Account."ATM Transactions";

                    //FD
                    if AccountTypes."Fixed Deposit" = false then begin
                        if Account.Balance < MinAccBal then
                            AvailableBalance := Account.Balance - FeeBelowMinBal - TCharges - MinAccBal - TotalUnprocessed - ATMBalance -
                                              Account."EFT Transactions" + Account."Cheque Discounted"// IntervalPenalty -
                        else
                            AvailableBalance := Account.Balance - TCharges - MinAccBal - TotalUnprocessed - ATMBalance -
                                              Account."EFT Transactions" + Account."Cheque Discounted";//IntervalPenalty -
                    end else begin
                        AvailableBalance := Account.Balance - TCharges - ChargesOnFD - Account."ATM Transactions" + Account."Cheque Discounted";
                    end;
                end;

                /*MESSAGE('FeeBelowMinBal Is %1',FeeBelowMinBal);
                MESSAGE('TCharges Is %1',TCharges);
                MESSAGE('IntervalPenalty Is %1',IntervalPenalty);
                MESSAGE('MinAccBal Is %1',MinAccBal);
                MESSAGE('TotalUnprocessed Is %1',TotalUnprocessed);
                MESSAGE('ATMBalance Is %1',ATMBalance);
                MESSAGE('EFT Transactions Is %1',Account."EFT Transactions");*/


                //FD

            end;
        end;

        if "N.A.H Balance" <> 0 then
            AvailableBalance := "N.A.H Balance";
        Message('Available balance is %1', AvailableBalance);

    end;


    procedure PostChequeDep()
    begin
        DValue.Reset;
        DValue.SetRange(DValue."Global Dimension No.", 2);
        //DValue.SETRANGE(DValue.Code,DBranch);`
        DValue.SetRange(DValue.Code, 'NAIROBI');
        if DValue.Find('-') then begin
            //DValue.TESTFIELD(DValue."Clearing Bank Account");
            //ChBank:=DValue."Clearing Bank Account";
        end else
            //ERROR('Branch not set.');
            ChBank := "Bank Account";

        if ChequeTypes.Get("Cheque Type") then begin
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
            GenJournalLine.DeleteAll;

            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'PURCHASES';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := No;
            GenJournalLine."External Document No." := "Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := "Account No";

            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := "Transaction Date";
            if "Branch Transaction" = true then
                GenJournalLine.Description := "Transaction Type" + '-' + "Branch Refference"
            else
                GenJournalLine.Description := "Transaction Description" + '-' + Description;
            //Project Accounts
            if Acc.Get("Account No") then begin
                if Acc."Account Category" = Acc."account category"::Project then
                    GenJournalLine.Description := "Transaction Type" + '-' + "Branch Refference"
            end;
            //Project Accounts
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := -Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'PURCHASES';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := No;
            GenJournalLine."External Document No." := "Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No." := "Cheque Clearing Bank Code";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := "Transaction Date";
            GenJournalLine.Description := "Account Name";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            //Post Charges
            ChargeAmount := 0;

            LineNo := LineNo + 10000;
            ClearingCharge := 0;
            if ChequeTypes."Use %" = true then begin
                ClearingCharge := ((ChequeTypes."% Of Amount" * 0.01) * Amount);
            end else
                ClearingCharge := ChequeTypes."Clearing Charges";
            //MESSAGE('ClearingCharge%1',ClearingCharge);
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'PURCHASES';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := No;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := "Account No";
            GenJournalLine."External Document No." := "ID No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := "Transaction Date";
            GenJournalLine.Description := 'Clearing Charges';
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := ClearingCharge;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Bal. Account No." := ChequeTypes."Clearing Charges GL Account";
            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
            //Post Charges



            //Excise Duty
            genSetup.Get(0);

            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'PURCHASES';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := No;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := "Account No";
            GenJournalLine."External Document No." := "ID No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := "Transaction Date";
            GenJournalLine.Description := 'Excise Duty';
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := (ClearingCharge * genSetup."Excise Duty(%)") / 100;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Bal. Account No." := genSetup."Excise Duty Account";
            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;




            //Post New
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
            end;

            //Post New


            Posted := true;
            Authorised := Authorised::Yes;
            "Supervisor Checked" := true;
            "Needs Approval" := "needs approval"::No;
            "Frequency Needs Approval" := "frequency needs approval"::No;
            "Date Posted" := Today;
            "Time Posted" := Time;
            "Posted By" := UserId;
            if ChequeTypes."Clearing  Days" = 0 then begin
                Status := Status::Honoured;
                "Cheque Processed" := "cheque processed"::"1";
                "Date Cleared" := Today;
            end;

            Modify;



            Message('Cheque deposited successfully.');

            Trans.Reset;
            Trans.SetRange(Trans.No, No);
            if Trans.Find('-') then
                Report.Run(51516500, false, true, Trans);


        end;
    end;


    procedure PostDepSlipDep()
    begin
        if Type = 'Deposit Slip' then
            DValue.Reset;
        DValue.SetRange(DValue."Global Dimension No.", 2);
        //DValue.SETRANGE(DValue.Code,DBranch);`
        DValue.SetRange(DValue.Code, 'NAIROBI');
        if DValue.Find('-') then begin
            //DValue.TESTFIELD(DValue."Clearing Bank Account");
            //ChBank:=DValue."Clearing Bank Account";
        end else
            //ERROR('Branch not set.');
            ChBank := "Bank Account";

        //IF ChequeTypes.GET("Cheque Type") THEN BEGIN
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := No;
        GenJournalLine."External Document No." := "Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := "Account No";

        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := "Document Date";
        if "Branch Transaction" = true then
            GenJournalLine.Description := "Transaction Type" + '-' + "Branch Refference"
        else
            GenJournalLine.Description := "Transaction Description" + '-' + Description;
        //Project Accounts
        if Acc.Get("Account No") then begin
            if Acc."Account Category" = Acc."account category"::Project then
                GenJournalLine.Description := "Transaction Type" + '-' + "Branch Refference"
        end;
        //Project Accounts
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := No;
        GenJournalLine."External Document No." := "Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := "Bank Account";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := "Document Date";
        GenJournalLine.Description := "Account Name";
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
        /*
        //Post Charges
        ChargeAmount:=0;
        
        LineNo:=LineNo+10000;
        ClearingCharge:=0;
        IF ChequeTypes."Use %" = TRUE THEN BEGIN
        ClearingCharge:=((ChequeTypes."% Of Amount"*0.01)*Amount);
        END ELSE
        ClearingCharge:=ChequeTypes."Clearing Charges";
        //MESSAGE('ClearingCharge%1',ClearingCharge);
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        GenJournalLine."External Document No.":="ID No";
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:='Clearing Charges';
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=ClearingCharge;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No.":=ChequeTypes."Clearing Charges GL Account";
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
        IF GenJournalLine.Amount<>0 THEN
        GenJournalLine.INSERT;
        //Post Charges
        
        
        
        //Excise Duty
        genSetup.GET(0);
        
        LineNo:=LineNo+10000;
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        GenJournalLine."External Document No.":="ID No";
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:='Excise Duty';
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=(ClearingCharge*genSetup."Excise Duty(%)")/100;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No.":=genSetup."Excise Duty Account";
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
        IF GenJournalLine.Amount<>0 THEN
        GenJournalLine.INSERT;
        
        */


        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;

        //Post New


        Posted := true;
        Authorised := Authorised::Yes;
        "Supervisor Checked" := true;
        "Needs Approval" := "needs approval"::No;
        "Frequency Needs Approval" := "frequency needs approval"::No;
        "Date Posted" := Today;
        "Time Posted" := Time;
        "Posted By" := UserId;


        Modify;



        Message('Deposit Slip deposited successfully.');

        Trans.Reset;
        Trans.SetRange(Trans.No, No);
        if Trans.Find('-') then
            Report.Run(51516500, false, true, Trans);


        //END;

    end;


    procedure PostTransfer()
    begin
        DValue.Reset;
        DValue.SetRange(DValue."Global Dimension No.", 2);
        //DValue.SETRANGE(DValue.Code,DBranch);`
        //DValue.SETRANGE(DValue.Code,'NAIROBI');
        if DValue.Find('-') then begin
            //DValue.TESTFIELD(DValue."Clearing Bank Account");
            //ChBank:=DValue."Clearing Bank Account";
        end else
            //ERROR('Branch not set.');
            ChBank := "Bank Account";

        if ChequeTypes.Get("Cheque Type") then begin
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
            GenJournalLine.DeleteAll;

            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'PURCHASES';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := No;
            GenJournalLine."External Document No." := "Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := "Account No";

            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := "Transaction Date";
            if "Branch Transaction" = true then
                GenJournalLine.Description := "Transaction Type" + '-' + "Branch Refference"
            else
                GenJournalLine.Description := "Transaction Description" + '-' + Description;
            //Project Accounts
            if Acc.Get("Account No") then begin
                if Acc."Account Category" = Acc."account category"::Project then
                    GenJournalLine.Description := "Transaction Type" + '-' + "Branch Refference"
            end;
            //Project Accounts
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := -Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            //Debit The drawers Account
            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'PURCHASES';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := No;
            GenJournalLine."External Document No." := "Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := "Drawer's Account No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := "Transaction Date";
            GenJournalLine.Description := "Account Name";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            //Post Charges
            ChargeAmount := 0;

            LineNo := LineNo + 10000;
            ClearingCharge := 0;
            if ChequeTypes."Use %" = true then begin
                ClearingCharge := ((ChequeTypes."% Of Amount" * 0.01) * Amount);
            end else
                ClearingCharge := ChequeTypes."Clearing Charges";
            //MESSAGE('ClearingCharge%1',ClearingCharge);
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'PURCHASES';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := No;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := "Account No";
            GenJournalLine."External Document No." := "ID No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := "Transaction Date";
            GenJournalLine.Description := 'Clearing Charges';
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := ClearingCharge;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Bal. Account No." := ChequeTypes."Clearing Charges GL Account";
            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
            //Post Charges



            //Excise Duty
            genSetup.Get(0);

            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'PURCHASES';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := No;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := "Account No";
            GenJournalLine."External Document No." := "ID No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := "Transaction Date";
            GenJournalLine.Description := 'Excise Duty';
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := (ClearingCharge * genSetup."Excise Duty(%)") / 100;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Bal. Account No." := genSetup."Excise Duty Account";
            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;




            //Post New
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
            end;

            //Post New


            Posted := true;
            Authorised := Authorised::Yes;
            "Supervisor Checked" := true;
            "Needs Approval" := "needs approval"::No;
            "Frequency Needs Approval" := "frequency needs approval"::No;
            "Date Posted" := Today;
            "Time Posted" := Time;
            "Posted By" := UserId;
            if ChequeTypes."Clearing  Days" = 0 then begin
                Status := Status::Honoured;
                "Cheque Processed" := "cheque processed"::"1";
                "Date Cleared" := Today;
            end;

            Modify;

            //Update Cheque Book
            ChequeBook.Reset;
            ChequeBook.SetRange(ChequeBook."Account No.", "Drawers Member No");
            ChequeBook.SetRange(ChequeBook."Cheque No.", "Drawers Cheque No.");
            if ChequeBook.Find('-') then begin
                ChequeBook.Status := ChequeBook.Status::Approved;
                ChequeBook.Modify;
            end;






            Message('Transfer Posted successfully.');

            Trans.Reset;
            Trans.SetRange(Trans.No, No);
            if Trans.Find('-') then
                Report.Run(51516524, false, true, Trans);


        end;
    end;


    procedure PostBankersCheq()
    begin
        //Block Payments
        if Acc.Get("Account No") then begin
            if Acc.Blocked = Acc.Blocked::Payment then
                Error('This account has been blocked from receiving payments.');
        end;


        DValue.Reset;
        DValue.SetRange(DValue."Global Dimension No.", 2);
        DValue.SetRange(DValue.Code, 'Nairobi');
        //DValue.SETRANGE(DValue.Code,DBranch);
        if DValue.Find('-') then begin
            //DValue.TESTFIELD(DValue."Banker Cheque Account");
            //ChBank:=DValue."Banker Cheque Account";
        end else
            Error('Branch not set.');

        CalcAvailableBal;

        //Check withdrawal limits
        if Type = 'Bankers Cheque' then begin
            if AvailableBalance < Amount then begin
                if Authorised = Authorised::Yes then begin
                    Overdraft := true;
                    Modify;
                end;

                if Authorised = Authorised::No then begin
                    if "Branch Transaction" = false then begin
                        "Authorisation Requirement" := 'Bankers Cheque - Over draft';
                        Modify;
                        Message('You cannot issue a Bankers cheque more than the available balance unless authorised.');
                        SendEmail;
                        exit;
                    end;
                end;
                if Authorised = Authorised::Rejected then
                    Error('Bankers cheque transaction has been rejected and therefore cannot proceed.');
                //SendEmail;
            end;
        end;
        //Check withdrawal limits


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := No;
        GenJournalLine."External Document No." := "Bankers Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := "Account No";
        GenJournalLine.Validate(GenJournalLine."Account No.");

        GenJournalLine."Posting Date" := "Transaction Date";
        if "Branch Transaction" = true then
            GenJournalLine.Description := "Transaction Type" + '-' + "Branch Refference"
        else
            GenJournalLine.Description := "Transaction Description" + '-' + Description;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := No;
        GenJournalLine."External Document No." := "Bankers Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := ChBank;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := "Transaction Date";
        GenJournalLine.Description := Payee;//"Account Name";
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;


        //Charges
        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");
        if TransactionCharges.Find('-') then begin
            repeat
                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := No;
                GenJournalLine."External Document No." := "Bankers Cheque No";
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := "Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := "Transaction Date";
                GenJournalLine.Description := TransactionCharges.Description;
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := TransactionCharges."Charge Amount";
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                if TransactionCharges."Due Amount" > 0 then begin
                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Document No." := No;
                    GenJournalLine."External Document No." := "Bankers Cheque No";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := TransactionCharges."G/L Account";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := "Transaction Date";
                    GenJournalLine.Description := TransactionCharges.Description;
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := TransactionCharges."Due Amount";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                    GenJournalLine."Bal. Account No." := ChBank;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                end;

            until TransactionCharges.Next = 0;
        end;

        //Charges

        //Excise Duty
        genSetup.Get(0);

        LineNo := LineNo + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := No;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := "Account No";
        GenJournalLine."External Document No." := "ID No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := "Transaction Date";
        GenJournalLine.Description := 'Excise Duty';
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := (TransactionCharges."Charge Amount" * genSetup."Excise Duty(%)") / 100;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No." := genSetup."Excise Duty Account";
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;



        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;

        //Post New


        "Transaction Available Balance" := AvailableBalance;
        Posted := true;
        Authorised := Authorised::Yes;
        "Supervisor Checked" := true;
        "Needs Approval" := "needs approval"::No;
        "Frequency Needs Approval" := "frequency needs approval"::No;
        "Date Posted" := Today;
        "Time Posted" := Time;
        "Posted By" := UserId;
        Modify;
        /*IF CONFIRM('Are you sure you want to print this bankers cheque?',TRUE)=TRUE THEN BEGIN
        REPORT.RUN(,TRUE,TRUE,Trans)
        END;*/


        Message('Bankers cheque posted successfully.');

    end;


    procedure PostEncashment()
    begin

        //Block Payments
        if Acc.Get("Account No") then begin
            if Acc.Blocked = Acc.Blocked::Payment then
                Error('This account has been blocked from receiving payments.');
        end;


        CalcAvailableBal;

        //Check withdrawal limits
        if (Type = 'Encashment') or (Type = 'Inhouse Cheque Withdrawal') then begin
            if AvailableBalance < Amount then begin
                if Authorised = Authorised::Yes then begin
                    Overdraft := true;
                    Modify;
                end;

                if Authorised = Authorised::No then begin
                    "Authorisation Requirement" := 'Encashment - Over draft';
                    Modify;
                    Message('You cannot issue an encashment more than the available balance unless authorised.');
                    MailContent := 'Withdrawal transaction' + 'TR. No.' + ' ' + No + ' ' + 'of Kshs' + ' ' + Format(Amount) + ' ' + 'for'
                    + ' ' + "Account Name" + ' ' + 'needs your authorization';
                    SendEmail;

                    //SendEmail;
                    exit;
                end;
                if Authorised = Authorised::Rejected then begin
                    MailContent := 'Bankers cheque transaction' + ' ' + 'of Kshs' + ' ' + Format(Amount) + ' ' + 'for'
                    + ' ' + "Account Name" + ' ' + 'needs your approval';
                    SendEmail;
                    Error('Transaction has been rejected and therefore cannot proceed.');

                end;
            end;
        end;
        //Check withdrawal limits



        //Check Teller Balances
        //ADDED DActivity:='';
        //ADDED DBranch:='';

        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        if TellerTill.Find('-') then begin
            //ADDED DActivity:=TellerTill."Global Dimension 1 Code";
            //ADDED DBranch:=TellerTill."Global Dimension 2 Code";
            TillNo := TellerTill."No.";
            TellerTill.CalcFields(TellerTill.Balance);

            CurrentTellerAmount := TellerTill.Balance;

            if CurrentTellerAmount - Amount <= TellerTill."Min. Balance" then
                Message('You need to add more money from the treasury since your balance has gone below the teller replenishing level.');

            if ("Transaction Type" = 'Withdrawal') or ("Transaction Type" = 'Encashment') or ("Transaction Type" = 'Inhouse Cheque Withdrawal') then begin
                if (CurrentTellerAmount - Amount) < 0 then
                    Error('You do not have enough money to carry out this transaction.');

            end;

            if ("Transaction Type" = 'Withdrawal') or ("Transaction Type" = 'Encashment') or ("Transaction Type" = 'INHOUSE CHEQUE WITHDRAWAL') then begin
                if CurrentTellerAmount - Amount >= TellerTill."Maximum Teller Withholding" then
                    Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');

            end else begin
                if CurrentTellerAmount + Amount >= TellerTill."Maximum Teller Withholding" then
                    Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');
            end;


        end;

        if TillNo = '' then
            Error('Teller account not set-up.');

        //Check Teller Balances




        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := No;
        GenJournalLine."External Document No." := "ID No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := "Account No";
        if ("Account No" = '00-0000003000') or ("Account No" = '00-0200003000') then
            GenJournalLine."External Document No." := "ID No";

        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := "Transaction Date";
        GenJournalLine.Description := Payee;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;


        //Charges
        TCharges := 0;
        //ADDED
        TChargeAmount := 0;


        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");

        if TransactionCharges.Find('-') then begin
            repeat
                LineNo := LineNo + 10000;

                ChargeAmount := 0;
                if TransactionCharges."Use Percentage" = true then begin
                    ChargeAmount := (Amount * TransactionCharges."Percentage of Amount") * 0.01
                end else
                    ChargeAmount := TransactionCharges."Charge Amount";


                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := No;
                GenJournalLine."External Document No." := "ID No";
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := "Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := "Transaction Date";
                GenJournalLine.Description := Payee;
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := ChargeAmount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                TChargeAmount := TChargeAmount + ChargeAmount;

            until TransactionCharges.Next = 0;
        end;

        /*
        //Excise
        genSetup.GET();
        
        LineNo:=LineNo+10000;
        
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."External Document No.":="ID No";
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:='Excise Duty';
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=50*genSetup."Excise Duty(%)";
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No.":=genSetup."Excise Duty Account";
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
        IF GenJournalLine.Amount<>0 THEN
        GenJournalLine.INSERT;
        
        */
        //Charges


        //Teller Entry
        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := No;
        GenJournalLine."External Document No." := "ID No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := TillNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := "Transaction Date";
        GenJournalLine.Description := Payee;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -(Amount);
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;


        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;

        //Post New


        "Transaction Available Balance" := AvailableBalance;
        Posted := true;
        Authorised := Authorised::Yes;
        "Supervisor Checked" := true;
        "Needs Approval" := "needs approval"::No;
        "Frequency Needs Approval" := "frequency needs approval"::No;
        "Date Posted" := Today;
        "Time Posted" := Time;
        "Posted By" := UserId;
        Modify;

        //Update Cheque Book
        ChequeBook.Reset;
        ChequeBook.SetRange(ChequeBook."Account No.", "Drawers Member No");
        ChequeBook.SetRange(ChequeBook."Cheque No.", "Drawers Cheque No.");
        if ChequeBook.Find('-') then begin
            ChequeBook.Status := ChequeBook.Status::Approved;
            ChequeBook.Modify;
        end;

        Trans.Reset;
        Trans.SetRange(Trans.No, No);
        if Trans.Find('-') then
            if Type = 'Inhouse Cheque Withdrawal ' then
                Report.Run(51516527, false, true, Trans);

    end;


    procedure PostChequeWith()
    begin
        //Block Payments
        if Acc.Get("Account No") then begin
            if Acc.Blocked = Acc.Blocked::Payment then
                Error('This account has been blocked from receiving payments.');
        end;


        /*DValue.RESET;
        DValue.SETRANGE(DValue."Global Dimension No.",2);
        DValue.SETRANGE(DValue.Code,'Nairobi');
        //DValue.SETRANGE(DValue.Code,DBranch);
        IF DValue.FIND('-') THEN BEGIN
        DValue.TESTFIELD(DValue."Banker Cheque Account");
        ChBank:=DValue."Banker Cheque Account";
        END ELSE
        ERROR('Branch not set.');*/

        CalcAvailableBal;

        //Check withdrawal limits
        if Type = 'Cheque Withdrawal' then begin
            if AvailableBalance < Amount then begin
                if Authorised = Authorised::Yes then begin
                    Overdraft := true;
                    Modify;
                end;

                if Authorised = Authorised::No then begin
                    if "Branch Transaction" = false then begin
                        "Authorisation Requirement" := 'Cheque Withdrawal - Over draft';
                        Modify;
                        Message('You cannot issue a Cheque more than the available balance unless authorised.');
                        SendEmail;
                        exit;
                    end;
                end;
                if Authorised = Authorised::Rejected then
                    Error('Cheque Withdrawal transaction has been rejected and therefore cannot proceed.');
                //SendEmail;
            end;
        end;
        //Check withdrawal limits


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := No;
        GenJournalLine."External Document No." := "Bankers Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := "Account No";
        GenJournalLine.Validate(GenJournalLine."Account No.");

        GenJournalLine."Posting Date" := "Transaction Date";
        if "Branch Transaction" = true then
            GenJournalLine.Description := "Transaction Type" + '-' + "Branch Refference"
        else
            GenJournalLine.Description := Payee; //"Transaction Description"+'-'+Description ;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := No;
        GenJournalLine."External Document No." := "Bankers Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := "Cheque Clearing Bank Code";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := "Transaction Date";
        GenJournalLine.Description := Payee;//"Account Name";
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;


        //Charges
        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");
        if TransactionCharges.Find('-') then begin
            repeat
                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := No;
                GenJournalLine."External Document No." := "Bankers Cheque No";
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                GenJournalLine."Account No." := TransactionCharges."G/L Account";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := "Transaction Date";
                GenJournalLine.Description := TransactionCharges.Description;
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := TransactionCharges."Charge Amount" * -1;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                if TransactionCharges."Due Amount" > 0 then begin
                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Document No." := No;
                    GenJournalLine."External Document No." := "Bankers Cheque No";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := TransactionCharges."G/L Account";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := "Transaction Date";
                    GenJournalLine.Description := TransactionCharges.Description;
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := TransactionCharges."Due Amount";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                    GenJournalLine."Bal. Account No." := ChBank;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                end;

            until TransactionCharges.Next = 0;
        end;


        //Balancing Account
        //Charges
        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");
        if TransactionCharges.Find('-') then begin
            TransactionCharges.CalcFields(TransactionCharges."Total Charges");
            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'PURCHASES';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := No;
            GenJournalLine."External Document No." := "Bankers Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := "Account No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := "Transaction Date";
            GenJournalLine.Description := TransactionCharges.Description;
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := TransactionCharges."Total Charges";
            GenJournalLine.Validate(GenJournalLine.Amount);
            //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"Bank Account";
            //GenJournalLine."Bal. Account No.":=ChBank;
            //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
        end;


        //Charge Overdraft Comission
        /*IF "Authorisation Requirement" ='Over draft' THEN BEGIN
        IF ("Over Draft Type"="Over Draft Type"::AWD) AND ("Excempt Charge"<>TRUE)  THEN BEGIN
        Charges.RESET;
        Charges.SETRANGE(Charges.Code,'AWD');
        IF Charges.FIND('-') THEN BEGIN
        IF Charges."Use Percentage"=TRUE THEN BEGIN
        //OverDraftCharge:=Amount*(Charges."Percentage of Amount"/100);
        //OverDraftChargeAcc:=Charges."GL Account"
        END;
        //OverDraftCharge:=Charges."Charge Amount";
        //OverDraftChargeAcc:=Charges."GL Account"
        END;
        */
        /*
        LineNo:=LineNo+10000;
        
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:='Commision on Overdraft';
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
        IF AccountTypes.GET("Account Type") THEN BEGIN
        GenJournalLine.Amount:=OverDraftCharge;
        END;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No.":=OverDraftChargeAcc;
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
        IF GenJournalLine.Amount<>0 THEN
        GenJournalLine.INSERT;
        END;
        END;
        */

        //Charge Overdraft Comission
        /*IF "Authorisation Requirement" ='Over draft' THEN BEGIN
        IF ("Over Draft Type"="Over Draft Type"::LWD) AND ("Excempt Charge"<>TRUE) THEN BEGIN
        Charges.RESET;
        Charges.SETRANGE(Charges.Code,'OVERDRAFT');
        IF Charges.FIND('-') THEN BEGIN
        IF Charges."Use Percentage"=TRUE THEN BEGIN
        //OverDraftCharge:=Amount*(Charges."Percentage of Amount"/100);
        //IF LoanType.GET("LWD Loan Product") THEN
        //OverDraftChargeAcc:=Charges."GL Account"
        //OverDraftChargeAcc:=LoanType."Loan Interest Account"
        END;
        */
        //OverDraftCharge:=Charges."Charge Amount";
        /*IF LoanType.GET("LWD Loan Product") THEN
        //OverDraftChargeAcc:=Charges."GL Account"
        OverDraftChargeAcc:=LoanType."Loan Interest Account"
        END;
        */
        /*
        LineNo:=LineNo+10000;
        
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:='Commision on Overdraft';
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
        IF AccountTypes.GET("Account Type") THEN BEGIN
        GenJournalLine.Amount:=OverDraftCharge;
        END;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No.":=OverDraftChargeAcc;
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
        IF GenJournalLine.Amount<>0 THEN
        GenJournalLine.INSERT;
        END;
        END;
        */
        //Post New
        /*
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
        GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
        IF GenJournalLine.FIND('-') THEN BEGIN
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco",GenJournalLine);
        END;
        */
        //Post New
        /*
        
        "Transaction Available Balance":=AvailableBalance;
        Posted:=TRUE;
        Authorised:=Authorised::Yes;
        "Supervisor Checked":=TRUE;
        "Needs Approval":="Needs Approval"::No;
        "Frequency Needs Approval":="Frequency Needs Approval"::No;
        "Date Posted":=TODAY;
        "Time Posted":=TIME;
        "Posted By":=USERID;
        MODIFY;
        */
        /*IF CONFIRM('Are you sure you want to print this bankers cheque?',TRUE)=TRUE THEN BEGIN
        REPORT.RUN(,TRUE,TRUE,Trans)
        END;*/


        //Mark Cheque Book
        //ChequeRegister.RESET;
        /*ChequeRegister.SETRANGE(ChequeRegister."Cheque No.","Bankers Cheque No");
        IF ChequeRegister.FIND('-') THEN BEGIN
        ChequeRegister.Issued:=TRUE;
        ChequeRegister.MODIFY;
        */
        //END;
        Message('Cheque Withdrawal posted successfully.');

    end;


    procedure PostBOSAEntries()
    var
        ReceiptAllocation: Record "Receipt Allocation";
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;




        //BOSA Cash Book Entry
        if Type = 'BOSA Receipt' then begin


            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'PURCHASES';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := No;
            GenJournalLine."External Document No." := "Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No." := "Bank Account";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := "Document Date";
            GenJournalLine.Description := "Member Name";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            ReceiptAllocations.Reset;
            ReceiptAllocations.SetRange(ReceiptAllocations."Document No", No);
            if ReceiptAllocations.Find('-') then begin
                repeat
                    if ReceiptAllocations."Mpesa Account Type" <> ReceiptAllocations."mpesa account type"::Vendor then begin
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := No;
                        GenJournalLine."External Document No." := "Cheque No";
                        GenJournalLine."Posting Date" := "Document Date";
                        //IF ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::Repayment THEN BEGIN
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                        GenJournalLine."Account No." := ReceiptAllocations."Member No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type");
                        //END;
                        GenJournalLine.Amount := -ReceiptAllocations.Amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Interest Paid" then
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid"
                        else
                            if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Deposit Contribution" then
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution"
                            else
                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Share Capital" then
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital"
                                else
                                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"FOSA Shares" then
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"FOSA Shares"
                                    //ELSE IF ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::"Security Fund" THEN
                                    //GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Security Fund"
                                    else
                                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Loan Repayment" then
                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment"
                                        else
                                            if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee" then
                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Registration Fee";
                        /* IF ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::"Loan Form Fee" THEN
                        GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Loan Form Fee"*/
                        /*ELSE IF ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::"PassBook Fee" THEN
                        GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"PassBook Fee";*/
                        GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;
                    if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee") and
                       (ReceiptAllocations."Interest Amount" > 0) then begin
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := No;
                        GenJournalLine."External Document No." := "Cheque No";
                        GenJournalLine."Posting Date" := "Document Date";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                        GenJournalLine."Account No." := ReceiptAllocations."Member No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description := 'Interest Paid';
                        GenJournalLine.Amount := -ReceiptAllocations."Interest Amount";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                        GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                    end;


                    if (ReceiptAllocations."Mpesa Account Type" = ReceiptAllocation."mpesa account type"::Vendor) then begin
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := No;
                        GenJournalLine."External Document No." := "Cheque No";
                        GenJournalLine."Posting Date" := "Document Date";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := ReceiptAllocations."Mpesa Account No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description := 'Debt Collector Comission' + '-' + (ReceiptAllocations."Loan No.");
                        GenJournalLine.Amount := -ReceiptAllocations.Amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                    end;


                    //Generate Advice
                    if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee") then begin
                        if LoansR.Get(ReceiptAllocations."Loan No.") then begin
                            LoansR.CalcFields(LoansR."Outstanding Balance");
                            LoansR.Advice := true;
                            if ((LoansR."Outstanding Balance" - ReceiptAllocations.Amount) < LoansR."Loan Principle Repayment") then
                                LoansR."Advice Type" := LoansR."advice type"::Stoppage
                            else
                                LoansR."Advice Type" := LoansR."advice type"::Adjustment;
                            LoansR.Modify;
                        end;
                    end;
                //Generate Advice

                until ReceiptAllocations.Next = 0;
            end;
        end;


        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;

        //Post New


        Posted := true;
        Authorised := Authorised::Yes;
        "Supervisor Checked" := true;
        "Needs Approval" := "needs approval"::No;
        "Frequency Needs Approval" := "frequency needs approval"::No;
        "Date Posted" := Today;
        "Time Posted" := Time;
        "Posted By" := UserId;
        if ChequeTypes."Clearing  Days" = 0 then begin
            Status := Status::Honoured;
            "Cheque Processed" := "cheque processed"::"1";
            "Date Cleared" := Today;
        end;

        /*Trans.RESET;
        Trans.SETRANGE(Trans.No,No);
        IF Trans.FIND('-') THEN BEGIN
        REPORT.RUN(51516516,FALSE,TRUE,Trans);
        END;
        MODIFY;
        */

    end;


    procedure SuggestBOSAEntries()
    begin
        TestField(Posted, false);
        TestField("BOSA Account No");

        ReceiptAllocations.Reset;
        ReceiptAllocations.SetRange(ReceiptAllocations."Document No", No);
        ReceiptAllocations.DeleteAll;

        PaymentAmount := Amount;
        RunBal := PaymentAmount;

        Loans.Reset;
        Loans.SetCurrentkey(Loans.Source, Loans."Client Code");
        Loans.SetRange(Loans."Client Code", "BOSA Account No");
        Loans.SetRange(Loans.Source, Loans.Source::BOSA);
        if Loans.Find('-') then begin
            repeat
                Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due");
                Recover := true;

                if (Loans."Outstanding Balance") > 0 then begin
                    if ((Loans."Outstanding Balance" - Loans."Loan Principle Repayment") <= 0) and (Cheque = false) then
                        Recover := false;

                    if Recover = true then begin

                        Commision := 0;
                        if Cheque = true then begin
                            Commision := (Loans."Outstanding Balance") * 0.1;
                            LOustanding := Loans."Outstanding Balance";
                            if Loans."Interest Due" > 0 then
                                InterestPaid := Loans."Interest Due";
                        end else begin
                            LOustanding := (Loans."Outstanding Balance" - Loans."Loan Principle Repayment");
                            if LOustanding < 0 then
                                LOustanding := 0;
                            if Loans."Interest Due" > 0 then
                                InterestPaid := Loans."Interest Due";
                            if (Loans."Outstanding Balance" - Loans."Loan Principle Repayment") > 0 then begin
                                if (Loans."Outstanding Balance" - Loans."Loan Principle Repayment") > (Loans."Approved Amount" * 1 / 3) then
                                    Commision := LOustanding * 0.1;
                            end;
                        end;

                        if PaymentAmount > 0 then begin
                            if RunBal < (LOustanding + Commision + InterestPaid) then begin
                                if RunBal < InterestPaid then
                                    InterestPaid := RunBal;
                                //Commision:=(RunBal-InterestPaid)*0.1;
                                Commision := (RunBal - InterestPaid) - ((RunBal - InterestPaid) / 1.1);
                                LOustanding := (RunBal - InterestPaid) - Commision;

                            end;
                        end;


                        TotalCommision := TotalCommision + Commision;
                        TotalOustanding := TotalOustanding + LOustanding + InterestPaid + Commision;

                        RunBal := RunBal - (LOustanding + InterestPaid + Commision);

                        if (LOustanding + InterestPaid) > 0 then begin
                            ReceiptAllocations.Init;
                            ReceiptAllocations."Document No" := No;
                            ReceiptAllocations."Member No" := "BOSA Account No";
                            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Registration Fee";
                            ReceiptAllocations."Loan No." := Loans."Loan  No.";
                            ReceiptAllocations.Amount := ROUND(LOustanding, 0.01);
                            ReceiptAllocations."Interest Amount" := ROUND(InterestPaid, 0.01);
                            ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                            ReceiptAllocations.Insert;
                        end;

                        if Commision > 0 then begin
                            ReceiptAllocations.Init;
                            ReceiptAllocations."Document No" := No;
                            ReceiptAllocations."Member No" := "BOSA Account No";
                            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Loan Repayment";
                            ReceiptAllocations."Loan No." := Loans."Loan  No.";
                            ReceiptAllocations.Amount := ROUND(Commision, 0.01);
                            ReceiptAllocations."Interest Amount" := 0;
                            ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                            ReceiptAllocations.Insert;
                        end;

                    end;
                end;

            until Loans.Next = 0;
        end;

        if RunBal > 0 then begin
            ReceiptAllocations.Init;
            ReceiptAllocations."Document No" := No;
            ReceiptAllocations."Member No" := "BOSA Account No";
            //ReceiptAllocations."Transaction Type":=ReceiptAllocations."Transaction Type"::"Security Fund";
            ReceiptAllocations."Loan No." := '';
            ReceiptAllocations.Amount := RunBal;
            ReceiptAllocations."Interest Amount" := 0;
            ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
            ReceiptAllocations.Insert;

        end;
    end;


    procedure SendEmail()
    begin
        /*
        //send e-mail to supervisor
        supervisor.RESET;
        supervisor.SETFILTER(supervisor."Transaction Type",'withdrawal');
        IF supervisor.FIND('-') THEN BEGIN
         // MailContent:=TEXT1;
        REPEAT
        
         genSetup.GET(0);
         SMTPMAIL.NewMessage(genSetup."Sender Address",'Transactions' +''+'');
         SMTPMAIL.SetWorkMode();
         SMTPMAIL.ClearAttachments();
         SMTPMAIL.ClearAllRecipients();
         SMTPMAIL.SetDebugMode();
         SMTPMAIL.SetFromAdress(genSetup."Sender Address");
         SMTPMAIL.SetHost(genSetup."Outgoing Mail Server");
         SMTPMAIL.SetUserID(genSetup."Sender User ID");
         SMTPMAIL.AddLine(MailContent);
         SMTPMAIL.SetToAdress(supervisor."E-mail Address");
         SMTPMAIL.Send;
         UNTIL supervisor.NEXT=0;
        END;
        */

    end;
}

