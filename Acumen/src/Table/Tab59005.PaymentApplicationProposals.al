#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 59005 "Payment Application Proposals"
{
    Caption = 'Payment Application Proposal';

    fields
    {
        field(1;"Bank Account No.";Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account";
        }
        field(2;"Statement No.";Code[20])
        {
            Caption = 'Statement No.';
            TableRelation = "Bank Acc. Reconciliation"."Statement No." where ("Bank Account No."=field("Bank Account No."),
                                                                              "Statement Type"=field("Statement Type"));
        }
        field(3;"Statement Line No.";Integer)
        {
            Caption = 'Statement Line No.';
        }
        field(20;"Statement Type";Option)
        {
            Caption = 'Statement Type';
            OptionCaption = 'Bank Reconciliation,Payment Application';
            OptionMembers = "Bank Reconciliation","Payment Application";
        }
        field(21;"Account Type";Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";

            trigger OnValidate()
            begin
                VerifyLineIsNotApplied;
            end;
        }
        field(22;"Account No.";Code[20])
        {
            Caption = 'Account No.';
            TableRelation = if ("Account Type"=const("G/L Account")) "G/L Account" where ("Account Type"=const(Posting),
                                                                                          Blocked=const(false))
                                                                                          else if ("Account Type"=const(Customer)) Customer
                                                                                          else if ("Account Type"=const(Vendor)) Vendor
                                                                                          else if ("Account Type"=const("Bank Account")) "Bank Account"
                                                                                          else if ("Account Type"=const("Fixed Asset")) "Fixed Asset"
                                                                                          else if ("Account Type"=const("IC Partner")) "IC Partner";

            trigger OnValidate()
            begin
                VerifyLineIsNotApplied;
            end;
        }
        field(23;"Applies-to Entry No.";Integer)
        {
            Caption = 'Applies-to Entry No.';
            TableRelation = if ("Account Type"=const("G/L Account")) "G/L Entry"
                            else if ("Account Type"=const(Customer)) "Cust. Ledger Entry" where (Open=const(true))
                            else if ("Account Type"=const(Vendor)) "Vendor Ledger Entry" where (Open=const(true))
                            else if ("Account Type"=const("Bank Account")) "Bank Account Ledger Entry" where (Open=const(true));
        }
        field(24;"Applied Amount";Decimal)
        {
            Caption = 'Applied Amount';

            trigger OnValidate()
            begin
                if ("Applied Amount" = 0) and (xRec."Applied Amount" <> 0) then
                  Unapply
                else
                  UpdateAppliedAmt;
            end;
        }
        field(25;Applied;Boolean)
        {
            Caption = 'Applied';

            trigger OnValidate()
            var
                BankAccReconLine: Record "Bank Acc. Reconciliation Lines";
            begin
                if xRec.Applied = Applied then
                  exit;

                if not Applied then
                  Unapply;

                if Applied then begin
                  if "Document Type" = "document type"::"Credit Memo" then
                    CrMemoSelectedToApply
                  else begin
                    BankAccReconLine.Get("Statement Type","Bank Account No.","Statement No.","Statement Line No.");
                    if BankAccReconLine.Difference = 0 then
                      Error(PaymentAppliedErr);
                  end;

                  Apply(GetRemainingAmountAfterPosting,"Applies-to Entry No." <> 0);
                end;
            end;
        }
        field(29;"Applied Pmt. Discount";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            Caption = 'Applied Pmt. Discount';
        }
        field(30;Quality;Integer)
        {
            Caption = 'Quality';
        }
        field(31;"Posting Date";Date)
        {
            Caption = 'Posting Date';
        }
        field(32;"Document Type";Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(33;"Document No.";Code[20])
        {
            Caption = 'Document No.';
        }
        field(34;Description;Text[50])
        {
            Caption = 'Description';
        }
        field(35;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(36;"Due Date";Date)
        {
            Caption = 'Due Date';
            Editable = false;
        }
        field(37;"External Document No.";Code[35])
        {
            Caption = 'External Document No.';
        }
        field(50;"Match Confidence";Option)
        {
            Caption = 'Match Confidence';
            Editable = false;
            InitValue = "None";
            OptionCaption = 'None,Low,Medium,High,High - Text-to-Account Mapping,Manual,Accepted';
            OptionMembers = "None",Low,Medium,High,"High - Text-to-Account Mapping",Manual,Accepted;
        }
        field(51;"Pmt. Disc. Due Date";Date)
        {
            Caption = 'Pmt. Disc. Due Date';

            trigger OnValidate()
            begin
                ChangeDiscountAmounts;
            end;
        }
        field(52;"Remaining Pmt. Disc. Possible";Decimal)
        {
            Caption = 'Remaining Pmt. Disc. Possible';

            trigger OnValidate()
            begin
                ChangeDiscountAmounts;
            end;
        }
        field(53;"Pmt. Disc. Tolerance Date";Date)
        {
            Caption = 'Pmt. Disc. Tolerance Date';

            trigger OnValidate()
            begin
                ChangeDiscountAmounts;
            end;
        }
        field(60;"Applied Amt. Incl. Discount";Decimal)
        {
            Caption = 'Applied Amt. Incl. Discount';

            trigger OnValidate()
            begin
                if ("Applied Amt. Incl. Discount" = 0) and Applied then
                  Unapply
                else
                  Validate("Applied Amount","Applied Amt. Incl. Discount");
            end;
        }
        field(61;"Remaining Amount";Decimal)
        {
            Caption = 'Remaining Amount';
            Editable = false;
        }
        field(62;"Remaining Amt. Incl. Discount";Decimal)
        {
            Caption = 'Remaining Amt. Incl. Discount';
            Editable = false;
        }
        field(100;"Sorting Order";Integer)
        {
            Caption = 'Sorting Order';
            Editable = false;
        }
        field(101;"Stmt To Rem. Amount Difference";Decimal)
        {
            Caption = 'Stmt To Rem. Amount Difference';
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Statement Type","Bank Account No.","Statement No.","Statement Line No.","Account Type","Account No.","Applies-to Entry No.")
        {
            Clustered = true;
        }
        key(Key2;Applied,Quality)
        {
        }
        key(Key3;"Sorting Order")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField("Applies-to Entry No.",0);
        if Applied then
          Unapply;
    end;

    trigger OnInsert()
    begin
        UpdateSortingOrder;
    end;

    trigger OnModify()
    begin
        UpdateSortingOrder;
    end;

    trigger OnRename()
    begin
        VerifyLineIsNotApplied;
    end;

    var
        StmtAmtIsFullyAppliedErr: label 'The statement amount is already fully applied.';
        EntryDoesntExistErr: label 'The entry does not exist.';
        CannotChangeAppliedLineErr: label 'You cannot change the line because the entry is applied. Remove the applied entry first.';
        TransactionDateIsBeforePostingDateMsg: label 'Transaction date %1 is before posting date %2.';
        PaymentAppliedErr: label 'The payment is fully applied. To apply the payment to this entry, you must first unapply the payment from another entry.';
        WantToApplyCreditMemoAndInvoicesMsg: label 'If you want to apply Credit Memo and Invoices, it''s better to start from applying Credit Memos first and then apply all others entries.';

    local procedure Unapply()
    var
        AppliedPmtEntry: Record "Applied Payment Entry";
    begin
        if not GetAppliedPaymentEntry(AppliedPmtEntry) then
          Error(EntryDoesntExistErr);

        AppliedPmtEntry.Delete(true);

        TransferFields(AppliedPmtEntry,false);
        Applied := false;

        "Applied Amt. Incl. Discount" := 0;

        Modify(true);
    end;

    local procedure UpdateAppliedAmt()
    var
        AmountToApply: Decimal;
    begin
        AmountToApply := "Applied Amount";
        if Applied then
          Unapply;

        if AmountToApply = 0 then
          exit;

        Apply(AmountToApply,false);
    end;


    procedure GetAppliedPaymentEntry(var AppliedPaymentEntry: Record "Applied Payment Entry"): Boolean
    begin
        exit(
          AppliedPaymentEntry.Get(
            "Statement Type","Bank Account No.",
            "Statement No.","Statement Line No.",
            "Account Type","Account No.","Applies-to Entry No."));
    end;

    local procedure GetLedgEntryInfo()
    var
        TempAppliedPmtEntry: Record "Applied Payment Entry" temporary;
    begin
        TempAppliedPmtEntry.TransferFields(Rec);
        TempAppliedPmtEntry.GetLedgEntryInfo;
        TransferFields(TempAppliedPmtEntry);
    end;


    procedure TransferFromBankAccReconLine(BankAccReconLine: Record "Bank Acc. Reconciliation Lines")
    begin
        "Statement Type" := BankAccReconLine."Statement Type";
        "Bank Account No." := BankAccReconLine."Bank Account No.";
        "Statement No." := BankAccReconLine."Statement No.";
        "Statement Line No." := BankAccReconLine."Statement Line No.";
    end;


    procedure CreateFromAppliedPaymentEntry(AppliedPaymentEntry: Record "Applied Payment Entry")
    var
        BankAccount: Record "Bank Account";
    begin
        Init;
        TransferFields(AppliedPaymentEntry);
        UpdatePaymentDiscInfo;

        if AppliedPaymentEntry."Applied Amount" <> 0 then
          Applied := true;

        BankAccount.Get(AppliedPaymentEntry."Bank Account No.");

        UpdatePaymentDiscInfo;
        UpdateRemainingAmount(BankAccount);
        UpdateRemainingAmountExclDiscount;
        "Applied Amt. Incl. Discount" := "Applied Amount" - "Applied Pmt. Discount";
        Insert(true);
    end;


    procedure CreateFromBankStmtMacthingBuffer(TempBankStmtMatchingBuffer: Record "Bank Statement Matching Buffer" temporary;BankAccReconciliationLine: Record "Bank Acc. Reconciliation Lines";BankAccount: Record "Bank Account")
    var
        BankPmtApplRule: Record "Bank Pmt. Appl. Rule";
    begin
        Init;
        "Account Type" := TempBankStmtMatchingBuffer."Account Type";
        "Account No." := TempBankStmtMatchingBuffer."Account No.";

        if TempBankStmtMatchingBuffer."Entry No." < 0 then
          "Applies-to Entry No." := 0
        else
          "Applies-to Entry No." := TempBankStmtMatchingBuffer."Entry No.";

        GetLedgEntryInfo;
        Quality := TempBankStmtMatchingBuffer.Quality;
        "Match Confidence" := BankPmtApplRule.GetMatchConfidence(TempBankStmtMatchingBuffer.Quality);

        UpdatePaymentDiscInfo;
        UpdateRemainingAmount(BankAccount);
        UpdateRemainingAmountExclDiscount;
        "Stmt To Rem. Amount Difference" := Abs(BankAccReconciliationLine."Statement Amount" - "Remaining Amount");
        "Applied Amt. Incl. Discount" := "Applied Amount" - "Applied Pmt. Discount";
    end;

    local procedure UpdateSortingOrder()
    var
        BankPmtApplRule: Record "Bank Pmt. Appl. Rule";
    begin
        "Sorting Order" := -Quality;
        if Applied then
          "Sorting Order" -= BankPmtApplRule.GetHighestPossibleScore;
    end;

    local procedure Apply(AmtToApply: Decimal;SuggestDiscAmt: Boolean)
    var
        AppliedPaymentEntry: Record "Applied Payment Entry";
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Lines";
    begin
        AppliedPaymentEntry.TransferFields(Rec);

        BankAccReconciliationLine.Get(
          AppliedPaymentEntry."Statement Type",AppliedPaymentEntry."Bank Account No.",
          AppliedPaymentEntry."Statement No.",AppliedPaymentEntry."Statement Line No.");

        if AmtToApply = 0 then
          Error(StmtAmtIsFullyAppliedErr);

        if SuggestDiscAmt then
          AppliedPaymentEntry.Validate("Applies-to Entry No.")
        else
          AppliedPaymentEntry.Validate("Applied Amount",AmtToApply);

        AppliedPaymentEntry.Insert(true);

        TransferFields(AppliedPaymentEntry);
        Applied := true;
        UpdateRemainingAmountExclDiscount;
        "Applied Amt. Incl. Discount" := "Applied Amount" - "Applied Pmt. Discount";
        Modify(true);

        if BankAccReconciliationLine."Transaction Date" < "Posting Date" then
          Message(StrSubstNo(TransactionDateIsBeforePostingDateMsg,BankAccReconciliationLine."Transaction Date","Posting Date"));
    end;


    procedure GetRemainingAmountAfterPostingValue(): Decimal
    begin
        if "Applies-to Entry No." = 0 then
          exit(0);

        exit(GetRemainingAmountAfterPosting);
    end;

    local procedure GetRemainingAmountAfterPosting(): Decimal
    var
        TempAppliedPaymentEntry: Record "Applied Payment Entry" temporary;
    begin
        TempAppliedPaymentEntry.TransferFields(Rec);
        exit(
          TempAppliedPaymentEntry.GetRemAmt -
          TempAppliedPaymentEntry."Applied Amount" -
          TempAppliedPaymentEntry.GetAmtAppliedToOtherStmtLines);
    end;


    procedure RemoveApplications()
    var
        AppliedPaymentEntry: Record "Applied Payment Entry";
        CurrentTempPaymentApplicationProposal: Record "Payment Application Proposals" temporary;
    begin
        CurrentTempPaymentApplicationProposal := Rec;

        AddFilterOnAppliedPmtEntry(AppliedPaymentEntry);

        if AppliedPaymentEntry.FindSet then
          repeat
            Get(
              AppliedPaymentEntry."Statement Type",AppliedPaymentEntry."Bank Account No.",
              AppliedPaymentEntry."Statement No.",AppliedPaymentEntry."Statement Line No.",
              AppliedPaymentEntry."Account Type",AppliedPaymentEntry."Account No.",
              AppliedPaymentEntry."Applies-to Entry No.");
            Unapply;
          until AppliedPaymentEntry.Next = 0;

        Rec := CurrentTempPaymentApplicationProposal;
    end;


    procedure AccountNameDrillDown()
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
    begin
        case "Account Type" of
          "account type"::Customer:
            begin
              Customer.Get("Account No.");
              Page.Run(Page::"Customer Card",Customer);
            end;
          "account type"::Vendor:
            begin
              Vendor.Get("Account No.");
              Page.Run(Page::"Vendor Card",Vendor);
            end;
          "account type"::"G/L Account":
            begin
              GLAccount.Get("Account No.");
              Page.Run(Page::"G/L Account Card",GLAccount);
            end;
        end;
    end;


    procedure GetAccountName(): Text
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
        Name: Text;
    begin
        Name := '';

        case "Account Type" of
          "account type"::Customer:
            if Customer.Get("Account No.") then
              Name := Customer.Name;
          "account type"::Vendor:
            if Vendor.Get("Account No.") then
              Name := Vendor.Name;
          "account type"::"G/L Account":
            if GLAccount.Get("Account No.") then
              Name := GLAccount.Name;
        end;

        exit(Name);
    end;

    local procedure ChangeDiscountAmounts()
    begin
        UpdateLedgEntryDisc;
        UpdateRemainingAmountExclDiscount;

        if "Applied Pmt. Discount" <> 0 then begin
          "Applied Amount" -= "Applied Pmt. Discount";
          "Applied Pmt. Discount" := 0;
        end;

        UpdateAppliedAmt;
    end;

    local procedure UpdateLedgEntryDisc()
    var
        BankAccReconLine: Record "Bank Acc. Reconciliation Lines";
        AppliedPmtEntry: Record "Applied Payment Entrys";
        BankAccReconPost: Codeunit "Bank Acc. Reconciliation Posts";
    begin
        TestField("Applies-to Entry No.");
        AppliedPmtEntry.TransferFields(Rec);
        BankAccReconLine.Get("Statement Type","Bank Account No.","Statement No.","Statement Line No.");

        case "Account Type" of
          "account type"::Customer:
            BankAccReconPost.ApplyCustLedgEntry(
              AppliedPmtEntry,'',BankAccReconLine."Transaction Date",
              "Pmt. Disc. Due Date","Pmt. Disc. Tolerance Date","Remaining Pmt. Disc. Possible");
          "account type"::Vendor:
            BankAccReconPost.ApplyVendLedgEntry(
              AppliedPmtEntry,'',BankAccReconLine."Transaction Date",
              "Pmt. Disc. Due Date","Pmt. Disc. Tolerance Date","Remaining Pmt. Disc. Possible");
        end;
    end;

    local procedure UpdateRemainingAmountExclDiscount()
    var
        BankAccReconLine: Record "Bank Acc. Reconciliation Lines";
    begin
        "Remaining Amt. Incl. Discount" := "Remaining Amount";

        if not ("Document Type" in ["document type"::"Credit Memo","document type"::Invoice]) then
          exit;

        BankAccReconLine.Get("Statement Type","Bank Account No.","Statement No.","Statement Line No.");
        if BankAccReconLine."Transaction Date" > "Pmt. Disc. Due Date" then
          exit;

        "Remaining Amt. Incl. Discount" -= "Remaining Pmt. Disc. Possible";
    end;

    local procedure UpdateRemainingAmount(BankAccount: Record "Bank Account")
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        RemainingAmount: Decimal;
        RemainingAmountLCY: Decimal;
    begin
        "Remaining Amount" := 0;

        if "Applies-to Entry No." = 0 then
          exit;

        case "Account Type" of
          "account type"::"Bank Account":
            begin
              BankAccLedgEntry.SetRange(Open,true);
              BankAccLedgEntry.SetRange("Bank Account No.","Account No.");
              BankAccLedgEntry.SetAutocalcFields("Remaining Amount");
              BankAccLedgEntry.Get("Applies-to Entry No.");
              "Remaining Amount" := BankAccLedgEntry."Remaining Amount";
              exit;
            end;
          "account type"::Customer:
            begin
              CustLedgEntry.SetRange(Open,true);
              CustLedgEntry.SetRange("Customer No.","Account No.");
              CustLedgEntry.SetAutocalcFields("Remaining Amount","Remaining Amt. (LCY)");
              CustLedgEntry.Get("Applies-to Entry No.");

              RemainingAmount := CustLedgEntry."Remaining Amount";
              RemainingAmountLCY := CustLedgEntry."Remaining Amt. (LCY)";
            end;
          "account type"::Vendor:
            begin
              VendLedgEntry.SetRange(Open,true);
              VendLedgEntry.SetRange("Vendor No.","Account No.");
              VendLedgEntry.SetAutocalcFields("Remaining Amount","Remaining Amt. (LCY)");
              VendLedgEntry.Get("Applies-to Entry No.");

              RemainingAmount := VendLedgEntry."Remaining Amount";
              RemainingAmountLCY := VendLedgEntry."Remaining Amt. (LCY)";
            end;
        end;

        if BankAccount.IsInLocalCurrency then
          "Remaining Amount" := RemainingAmountLCY
        else
          "Remaining Amount" := RemainingAmount;
    end;

    local procedure UpdatePaymentDiscInfo()
    var
        AppliedPaymentEntry: Record "Applied Payment Entry";
    begin
        AppliedPaymentEntry.TransferFields(Rec);
        AppliedPaymentEntry.GetDiscInfo("Pmt. Disc. Due Date","Pmt. Disc. Tolerance Date","Remaining Pmt. Disc. Possible");
        if "Remaining Pmt. Disc. Possible" = 0 then begin
          "Pmt. Disc. Due Date" := 0D;
          "Pmt. Disc. Tolerance Date" := 0D;
        end;
    end;

    local procedure VerifyLineIsNotApplied()
    begin
        if Applied then
          Error(CannotChangeAppliedLineErr);
    end;


    procedure AppliesToEntryNoDrillDown()
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        GLEntry: Record "G/L Entry";
    begin
        if "Applies-to Entry No." = 0 then
          exit;

        case "Account Type" of
          "account type"::"G/L Account":
            begin
              GLEntry.SetRange("G/L Account No.","Account No.");
              Page.RunModal(0,GLEntry);
            end;
          "account type"::Customer:
            begin
              CustLedgEntry.SetRange(Open,true);
              CustLedgEntry.SetRange("Customer No.","Account No.");
              CustLedgEntry.Get("Applies-to Entry No.");
              Page.RunModal(0,CustLedgEntry);
            end;
          "account type"::Vendor:
            begin
              VendLedgEntry.SetRange(Open,true);
              VendLedgEntry.SetRange("Vendor No.","Account No.");
              VendLedgEntry.Get("Applies-to Entry No.");
              Page.RunModal(0,VendLedgEntry);
            end;
          "account type"::"Bank Account":
            begin
              BankAccLedgEntry.SetRange(Open,true);
              BankAccLedgEntry.SetRange("Bank Account No.","Account No.");
              BankAccLedgEntry.Get("Applies-to Entry No.");
              Page.RunModal(0,BankAccLedgEntry);
            end;
        end;
    end;

    local procedure CrMemoSelectedToApply()
    var
        AppliedPaymentEntry: Record "Applied Payment Entry";
    begin
        AddFilterOnAppliedPmtEntry(AppliedPaymentEntry);
        if AppliedPaymentEntry.Count > 0 then begin
          AppliedPaymentEntry.SetRange("Document Type","document type"::"Credit Memo");
          if AppliedPaymentEntry.Count = 0 then
            Message(WantToApplyCreditMemoAndInvoicesMsg);
        end;
    end;

    local procedure AddFilterOnAppliedPmtEntry(var AppliedPaymentEntry: Record "Applied Payment Entry")
    begin
        AppliedPaymentEntry.SetRange("Statement Type","Statement Type");
        AppliedPaymentEntry.SetRange("Bank Account No.","Bank Account No.");
        AppliedPaymentEntry.SetRange("Statement No.","Statement No.");
        AppliedPaymentEntry.SetRange("Statement Line No.","Statement Line No.");
    end;
}

