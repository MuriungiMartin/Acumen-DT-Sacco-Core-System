#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 59004 "Applied Payment Entrys"
{
    Caption = 'Applied Payment Entry';
    LookupPageID = "Payment Application";

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
                Validate("Account No.",'');
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
                if "Account No." = '' then
                  CheckApplnIsSameAcc;

                GetAccInfo;
                Validate("Applies-to Entry No.",0);
            end;
        }
        field(23;"Applies-to Entry No.";Integer)
        {
            Caption = 'Applies-to Entry No.';
            TableRelation = if ("Account Type"=const("G/L Account")) "G/L Entry"
                            else if ("Account Type"=const(Customer)) "Cust. Ledger Entry" where (Open=const(true))
                            else if ("Account Type"=const(Vendor)) "Vendor Ledger Entry" where (Open=const(true))
                            else if ("Account Type"=const("Bank Account")) "Bank Account Ledger Entry" where (Open=const(true));

            trigger OnLookup()
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                VendLedgEntry: Record "Vendor Ledger Entry";
                BankAccLedgEntry: Record "Bank Account Ledger Entry";
                GLEntry: Record "G/L Entry";
            begin
                case "Account Type" of
                  "account type"::"G/L Account":
                    begin
                      GLEntry.SetRange("G/L Account No.","Account No.");
                      if Page.RunModal(0,GLEntry) = Action::LookupOK then
                        Validate("Applies-to Entry No.",GLEntry."Entry No.");
                    end;
                  "account type"::Customer:
                    begin
                      CustLedgEntry.SetRange(Open,true);
                      CustLedgEntry.SetRange("Customer No.","Account No.");
                      if Page.RunModal(0,CustLedgEntry) = Action::LookupOK then
                        Validate("Applies-to Entry No.",CustLedgEntry."Entry No.");
                    end;
                  "account type"::Vendor:
                    begin
                      VendLedgEntry.SetRange(Open,true);
                      VendLedgEntry.SetRange("Vendor No.","Account No.");
                      if Page.RunModal(0,VendLedgEntry) = Action::LookupOK then
                        Validate("Applies-to Entry No.",VendLedgEntry."Entry No.");
                    end;
                  "account type"::"Bank Account":
                    begin
                      BankAccLedgEntry.SetRange(Open,true);
                      BankAccLedgEntry.SetRange("Bank Account No.","Account No.");
                      if Page.RunModal(0,BankAccLedgEntry) = Action::LookupOK then
                        Validate("Applies-to Entry No.",BankAccLedgEntry."Entry No.");
                    end;
                end;
            end;

            trigger OnValidate()
            begin
                if "Applies-to Entry No." = 0 then begin
                  Validate("Applied Amount",0);
                  exit;
                end;

                CheckCurrencyCombination;
                GetLedgEntryInfo;
                UpdatePaymentDiscount(SuggestDiscToApply(false));
                Validate("Applied Amount",SuggestAmtToApply);
            end;
        }
        field(24;"Applied Amount";Decimal)
        {
            Caption = 'Applied Amount';

            trigger OnValidate()
            begin
                if "Applies-to Entry No." <> 0 then
                  TestField("Applied Amount");
                CheckEntryAmt;
                UpdatePaymentDiscount(SuggestDiscToApply(true));
                if "Applied Pmt. Discount" <> 0 then
                  "Applied Amount" := SuggestAmtToApply;

                UpdateParentBankAccReconLine(false);
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
            TableRelation = Currency;
        }
        field(36;"Due Date";Date)
        {
            Caption = 'Due Date';
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
    }

    keys
    {
        key(Key1;"Statement Type","Bank Account No.","Statement No.","Statement Line No.","Account Type","Account No.","Applies-to Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        "Applied Amount" := 0;
        "Applied Pmt. Discount" := 0;
        UpdateParentBankAccReconLine(true);
    end;

    trigger OnInsert()
    begin
        if "Applies-to Entry No." <> 0 then
          TestField("Applied Amount");

        CheckApplnIsSameAcc;
    end;

    trigger OnModify()
    begin
        TestField("Applied Amount");
        CheckApplnIsSameAcc;
    end;

    var
        CurrencyMismatchErr: label 'Currency codes on bank account %1 and ledger entry %2 do not match.';
        AmtCannotExceedErr: label 'The Amount to Apply cannot exceed %1. This is because the Remaining Amount on the entry is %2 and the amount assigned to other statement lines is %3.';
        CannotApplyStmtLineErr: label 'You cannot apply to %1 %2 because the statement line already contains an application to %3 %4.', Comment='%1 = Account Type, %2 = Account No., %3 = Account Type, %4 = Account No.';

    local procedure CheckApplnIsSameAcc()
    var
        ExistingAppliedPmtEntry: Record "Applied Payment Entrys";
        BankAccReconLine: Record "Bank Acc. Reconciliation Lines";
    begin
        if "Account No." = '' then
          exit;
        BankAccReconLine.Get("Statement Type","Bank Account No.","Statement No.","Statement Line No.");
        ExistingAppliedPmtEntry.FilterAppliedPmtEntry(BankAccReconLine);
        if ExistingAppliedPmtEntry.FindFirst then
          CheckCurrentMatchesExistingAppln(ExistingAppliedPmtEntry);
        if ExistingAppliedPmtEntry.FindLast then
          CheckCurrentMatchesExistingAppln(ExistingAppliedPmtEntry);
    end;

    local procedure CheckCurrentMatchesExistingAppln(ExistingAppliedPmtEntry: Record "Applied Payment Entrys")
    begin
        if ("Account Type" = ExistingAppliedPmtEntry."Account Type") and
           ("Account No." = ExistingAppliedPmtEntry."Account No.")
        then
          exit;

        Error(
          CannotApplyStmtLineErr,
          "Account Type","Account No.",
          ExistingAppliedPmtEntry."Account Type",
          ExistingAppliedPmtEntry."Account No.");
    end;

    local procedure CheckEntryAmt()
    var
        BankAccReconLine: Record "Bank Acc. Reconciliation Lines";
        AmtAvailableToApply: Decimal;
    begin
        if "Applied Amount" = 0 then
          exit;

        BankAccReconLine.Get("Statement Type","Bank Account No.","Statement No.","Statement Line No.");
        // Amount should not exceed Remaining Amount
        AmtAvailableToApply := GetRemAmt - GetAmtAppliedToOtherStmtLines;
        if "Applies-to Entry No." <> 0 then
          if "Applied Amount" > 0 then begin
            if not ("Applied Amount" in [0..AmtAvailableToApply]) then
              Error(AmtCannotExceedErr,AmtAvailableToApply,GetRemAmt,GetAmtAppliedToOtherStmtLines);
          end else
            if not ("Applied Amount" in [AmtAvailableToApply..0]) then
              Error(AmtCannotExceedErr,AmtAvailableToApply,GetRemAmt,GetAmtAppliedToOtherStmtLines);
    end;

    local procedure UpdateParentBankAccReconLine(IsDelete: Boolean)
    var
        BankAccReconLine: Record "Bank Acc. Reconciliation Lines";
        NewAppliedAmt: Decimal;
    begin
        BankAccReconLine.Get("Statement Type","Bank Account No.","Statement No.","Statement Line No.");

        NewAppliedAmt := GetTotalAppliedAmountInclPmtDisc(IsDelete);

        BankAccReconLine."Applied Entries" := GetNoOfAppliedEntries(IsDelete);

        if IsDelete then begin
          if NewAppliedAmt = 0 then begin
            BankAccReconLine.Validate("Applied Amount",0);
            BankAccReconLine.Validate("Account No.",'')
          end
        end else
          if BankAccReconLine."Applied Amount" = 0 then begin
            BankAccReconLine.Validate("Account Type","Account Type");
            BankAccReconLine.Validate("Account No.","Account No.");
          end else
            CheckApplnIsSameAcc;

        BankAccReconLine.Validate("Applied Amount",NewAppliedAmt);
        BankAccReconLine.Modify;
    end;

    local procedure CheckCurrencyCombination()
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendorLedgEntry: Record "Vendor Ledger Entry";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
    begin
        if IsBankLCY then
          exit;

        if "Applies-to Entry No." = 0 then
          exit;

        case "Account Type" of
          "account type"::Customer:
            begin
              CustLedgEntry.Get("Applies-to Entry No.");
              if not CurrencyMatches("Bank Account No.",CustLedgEntry."Currency Code",GetLCYCode) then
                Error(CurrencyMismatchErr,"Bank Account No.","Applies-to Entry No.");
            end;
          "account type"::Vendor:
            begin
              VendorLedgEntry.Get("Applies-to Entry No.");
              if not CurrencyMatches("Bank Account No.",VendorLedgEntry."Currency Code",GetLCYCode) then
                Error(CurrencyMismatchErr,"Bank Account No.","Applies-to Entry No.");
            end;
          "account type"::"Bank Account":
            begin
              BankAccLedgEntry.Get("Applies-to Entry No.");
              if not CurrencyMatches("Bank Account No.",BankAccLedgEntry."Currency Code",GetLCYCode) then
                Error(CurrencyMismatchErr,"Bank Account No.","Applies-to Entry No.");
            end;
        end;
    end;

    local procedure CurrencyMatches(BankAccNo: Code[20];LedgEntryCurrCode: Code[10];LCYCode: Code[10]): Boolean
    var
        BankAcc: Record "Bank Account";
        BankAccCurrCode: Code[10];
    begin
        BankAcc.Get(BankAccNo);
        BankAccCurrCode := BankAcc."Currency Code";
        if BankAccCurrCode = '' then
          BankAccCurrCode := LCYCode;
        if LedgEntryCurrCode = '' then
          LedgEntryCurrCode := LCYCode;
        exit(LedgEntryCurrCode = BankAccCurrCode);
    end;

    local procedure IsBankLCY(): Boolean
    var
        BankAcc: Record "Bank Account";
    begin
        BankAcc.Get("Bank Account No.");
        exit(BankAcc.IsInLocalCurrency);
    end;

    local procedure GetLCYCode(): Code[10]
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get;
        exit(GLSetup.GetCurrencyCode(''));
    end;


    procedure SuggestAmtToApply(): Decimal
    var
        RemAmtToApply: Decimal;
        LineRemAmtToApply: Decimal;
    begin
        RemAmtToApply := GetRemAmt - GetAmtAppliedToOtherStmtLines;
        LineRemAmtToApply := GetStmtLineRemAmtToApply + "Applied Pmt. Discount";

        if "Account Type" = "account type"::Customer then
          if (LineRemAmtToApply >= 0) and ("Document Type" = "document type"::"Credit Memo") then
            exit(RemAmtToApply);
        if "Account Type" = "account type"::Vendor then
          if (LineRemAmtToApply <= 0) and ("Document Type" = "document type"::"Credit Memo") then
            exit(RemAmtToApply);

        exit(
          AbsMin(
            RemAmtToApply,
            LineRemAmtToApply));
    end;


    procedure SuggestDiscToApply(UseAppliedAmt: Boolean): Decimal
    var
        PmtDiscDueDate: Date;
        PmtDiscToleranceDate: Date;
        RemPmtDiscPossible: Decimal;
    begin
        if InclPmtDisc(UseAppliedAmt) then begin
          GetDiscInfo(PmtDiscDueDate,PmtDiscToleranceDate,RemPmtDiscPossible);
          exit(RemPmtDiscPossible);
        end;
        exit(0);
    end;


    procedure GetDiscInfo(var PmtDiscDueDate: Date;var PmtDiscToleranceDate: Date;var RemPmtDiscPossible: Decimal)
    begin
        PmtDiscDueDate := 0D;
        RemPmtDiscPossible := 0;

        if "Account No." = '' then
          exit;
        if "Applies-to Entry No." = 0 then
          exit;

        case "Account Type" of
          "account type"::Customer:
            GetCustLedgEntryDiscInfo(PmtDiscDueDate,PmtDiscToleranceDate,RemPmtDiscPossible);
          "account type"::Vendor:
            GetVendLedgEntryDiscInfo(PmtDiscDueDate,PmtDiscToleranceDate,RemPmtDiscPossible);
        end;
    end;

    local procedure GetCustLedgEntryDiscInfo(var PmtDiscDueDate: Date;var PmtDiscToleranceDate: Date;var RemPmtDiscPossible: Decimal)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.Get("Applies-to Entry No.");
        PmtDiscDueDate := CustLedgEntry."Pmt. Discount Date";
        PmtDiscToleranceDate := CustLedgEntry."Pmt. Disc. Tolerance Date";
        if IsBankLCY and (CustLedgEntry."Currency Code" <> '') then
          RemPmtDiscPossible :=
            ROUND(CustLedgEntry."Remaining Pmt. Disc. Possible" / CustLedgEntry."Adjusted Currency Factor")
        else
          RemPmtDiscPossible := CustLedgEntry."Remaining Pmt. Disc. Possible";
    end;

    local procedure GetVendLedgEntryDiscInfo(var PmtDiscDueDate: Date;var PmtDiscToleranceDate: Date;var RemPmtDiscPossible: Decimal)
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        VendLedgEntry.Get("Applies-to Entry No.");
        PmtDiscDueDate := VendLedgEntry."Pmt. Discount Date";
        PmtDiscToleranceDate := VendLedgEntry."Pmt. Disc. Tolerance Date";
        VendLedgEntry.CalcFields("Amount (LCY)",Amount);
        if IsBankLCY and (VendLedgEntry."Currency Code" <> '') then
          RemPmtDiscPossible :=
            ROUND(VendLedgEntry."Remaining Pmt. Disc. Possible" / VendLedgEntry."Adjusted Currency Factor")
        else
          RemPmtDiscPossible := VendLedgEntry."Remaining Pmt. Disc. Possible";
    end;


    procedure GetRemAmt(): Decimal
    begin
        if "Account No." = '' then
          exit(0);
        if "Applies-to Entry No." = 0 then
          exit(GetStmtLineRemAmtToApply);

        case "Account Type" of
          "account type"::Customer:
            exit(GetCustLedgEntryRemAmt);
          "account type"::Vendor:
            exit(GetVendLedgEntryRemAmt);
          "account type"::"Bank Account":
            exit(GetBankAccLedgEntryRemAmt);
        end;
    end;

    local procedure GetCustLedgEntryRemAmt(): Decimal
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.Get("Applies-to Entry No.");
        if IsBankLCY and (CustLedgEntry."Currency Code" <> '') then begin
          CustLedgEntry.CalcFields("Remaining Amt. (LCY)");
          exit(CustLedgEntry."Remaining Amt. (LCY)");
        end;
        CustLedgEntry.CalcFields("Remaining Amount");
        exit(CustLedgEntry."Remaining Amount");
    end;

    local procedure GetVendLedgEntryRemAmt(): Decimal
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        VendLedgEntry.Get("Applies-to Entry No.");
        if IsBankLCY and (VendLedgEntry."Currency Code" <> '') then begin
          VendLedgEntry.CalcFields("Remaining Amt. (LCY)");
          exit(VendLedgEntry."Remaining Amt. (LCY)");
        end;
        VendLedgEntry.CalcFields("Remaining Amount");
        exit(VendLedgEntry."Remaining Amount");
    end;

    local procedure GetBankAccLedgEntryRemAmt(): Decimal
    var
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
    begin
        BankAccLedgEntry.Get("Applies-to Entry No.");
        if IsBankLCY then
          exit(
            ROUND(
              BankAccLedgEntry."Remaining Amount" *
              BankAccLedgEntry."Amount (LCY)" / BankAccLedgEntry.Amount));
        exit(BankAccLedgEntry."Remaining Amount");
    end;


    procedure GetStmtLineRemAmtToApply(): Decimal
    var
        BankAccReconLine: Record "Bank Acc. Reconciliation Lines";
    begin
        BankAccReconLine.Get("Statement Type","Bank Account No.","Statement No.","Statement Line No.");

        if BankAccReconLine.Difference = 0 then
          exit(0);

        exit(BankAccReconLine.Difference + GetOldAppliedAmtInclDisc);
    end;

    local procedure GetOldAppliedAmtInclDisc(): Decimal
    var
        OldAppliedPmtEntry: Record "Applied Payment Entrys";
    begin
        OldAppliedPmtEntry := Rec;
        if not OldAppliedPmtEntry.Find then
          exit(0);
        exit(OldAppliedPmtEntry."Applied Amount" - OldAppliedPmtEntry."Applied Pmt. Discount");
    end;

    local procedure AbsMin(Amt1: Decimal;Amt2: Decimal): Decimal
    begin
        if Abs(Amt1) < Abs(Amt2) then
          exit(Amt1);
        exit(Amt2)
    end;

    local procedure GetAccInfo()
    begin
        if "Account No." = '' then
          exit;

        case "Account Type" of
          "account type"::Customer:
            GetCustInfo;
          "account type"::Vendor:
            GetVendInfo;
          "account type"::"Bank Account":
            GetBankAccInfo;
          "account type"::"G/L Account":
            GetGLAccInfo;
        end;
    end;

    local procedure GetCustInfo()
    var
        Cust: Record Customer;
    begin
        Cust.Get("Account No.");
        Description := Cust.Name;
    end;

    local procedure GetVendInfo()
    var
        Vend: Record Vendor;
    begin
        Vend.Get("Account No.");
        Description := Vend.Name;
    end;

    local procedure GetBankAccInfo()
    var
        BankAcc: Record "Bank Account";
    begin
        BankAcc.Get("Account No.");
        Description := BankAcc.Name;
        "Currency Code" := BankAcc."Currency Code";
    end;

    local procedure GetGLAccInfo()
    var
        GLAcc: Record "G/L Account";
    begin
        GLAcc.Get("Account No.");
        Description := GLAcc.Name;
    end;


    procedure GetLedgEntryInfo()
    begin
        if "Applies-to Entry No." = 0 then
          exit;

        case "Account Type" of
          "account type"::Customer:
            GetCustLedgEntryInfo;
          "account type"::Vendor:
            GetVendLedgEntryInfo;
          "account type"::"Bank Account":
            GetBankAccLedgEntryInfo;
        end;
    end;

    local procedure GetCustLedgEntryInfo()
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.Get("Applies-to Entry No.");
        Description := CustLedgEntry.Description;
        "Posting Date" := CustLedgEntry."Posting Date";
        "Due Date" := CustLedgEntry."Due Date";
        "Document Type" := CustLedgEntry."Document Type";
        "Document No." := CustLedgEntry."Document No.";
        "External Document No." := CustLedgEntry."External Document No.";
        "Currency Code" := CustLedgEntry."Currency Code";
    end;

    local procedure GetVendLedgEntryInfo()
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        VendLedgEntry.Get("Applies-to Entry No.");
        Description := VendLedgEntry.Description;
        "Posting Date" := VendLedgEntry."Posting Date";
        "Due Date" := VendLedgEntry."Due Date";
        "Document Type" := VendLedgEntry."Document Type";
        "Document No." := VendLedgEntry."Document No.";
        "External Document No." := VendLedgEntry."External Document No.";
        "Currency Code" := VendLedgEntry."Currency Code";
    end;

    local procedure GetBankAccLedgEntryInfo()
    var
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
    begin
        BankAccLedgEntry.Get("Applies-to Entry No.");
        Description := BankAccLedgEntry.Description;
        "Posting Date" := BankAccLedgEntry."Posting Date";
        "Due Date" := 0D;
        "Document Type" := BankAccLedgEntry."Document Type";
        "Document No." := BankAccLedgEntry."Document No.";
        "External Document No." := BankAccLedgEntry."External Document No.";
        "Currency Code" := BankAccLedgEntry."Currency Code";
    end;


    procedure GetAmtAppliedToOtherStmtLines(): Decimal
    var
        AppliedPmtEntry: Record "Applied Payment Entrys";
    begin
        if "Applies-to Entry No." = 0 then
          exit(0);

        AppliedPmtEntry := Rec;
        AppliedPmtEntry.FilterEntryAppliedToOtherStmtLines;
        AppliedPmtEntry.CalcSums("Applied Amount");
        exit(AppliedPmtEntry."Applied Amount");
    end;


    procedure FilterEntryAppliedToOtherStmtLines()
    begin
        Reset;
        SetRange("Statement Type","Statement Type");
        SetRange("Bank Account No.","Bank Account No.");
        SetRange("Statement No.","Statement No.");
        SetFilter("Statement Line No.",'<>%1',"Statement Line No.");
        SetRange("Account Type","Account Type");
        SetRange("Account No.","Account No.");
        SetRange("Applies-to Entry No.","Applies-to Entry No.");
    end;


    procedure FilterAppliedPmtEntry(BankAccReconLine: Record "Bank Acc. Reconciliation Lines")
    begin
        Reset;
        SetRange("Statement Type",BankAccReconLine."Statement Type");
        SetRange("Bank Account No.",BankAccReconLine."Bank Account No.");
        SetRange("Statement No.",BankAccReconLine."Statement No.");
        SetRange("Statement Line No.",BankAccReconLine."Statement Line No.");
    end;


    procedure AppliedPmtEntryLinesExist(BankAccReconLine: Record "Bank Acc. Reconciliation Lines"): Boolean
    begin
        FilterAppliedPmtEntry(BankAccReconLine);
        exit(FindSet);
    end;


    procedure TransferFromBankAccReconLine(BankAccReconLine: Record "Bank Acc. Reconciliation Lines")
    begin
        "Statement Type" := BankAccReconLine."Statement Type";
        "Bank Account No." := BankAccReconLine."Bank Account No.";
        "Statement No." := BankAccReconLine."Statement No.";
        "Statement Line No." := BankAccReconLine."Statement Line No.";
    end;


    procedure ApplyFromBankStmtMatchingBuf(BankAccReconLine: Record "Bank Acc. Reconciliation Lines";BankStmtMatchingBuffer: Record "Bank Statement Matching Buffer";TextMapperAmount: Decimal;EntryNo: Integer)
    var
        BankPmtApplRule: Record "Bank Pmt. Appl. Rule";
    begin
        Init;
        TransferFromBankAccReconLine(BankAccReconLine);
        Validate("Account Type",BankStmtMatchingBuffer."Account Type");
        Validate("Account No.",BankStmtMatchingBuffer."Account No.");
        if (EntryNo < 0) and (not BankStmtMatchingBuffer."One to Many Match") then begin // text mapper
          Validate("Applies-to Entry No.",0);
          Validate("Applied Amount",TextMapperAmount);
        end else
          Validate("Applies-to Entry No.",EntryNo);
        Validate(Quality,BankStmtMatchingBuffer.Quality);
        Validate("Match Confidence",BankPmtApplRule.GetMatchConfidence(BankStmtMatchingBuffer.Quality));
        Insert(true);
    end;

    local procedure InclPmtDisc(UseAppliedAmt: Boolean): Boolean
    var
        BankAccReconLine: Record "Bank Acc. Reconciliation Lines";
        AmtApplied: Decimal;
        PmtDiscDueDate: Date;
        PmtDiscToleranceDate: Date;
        RemPmtDiscPossible: Decimal;
    begin
        GetDiscInfo(PmtDiscDueDate,PmtDiscToleranceDate,RemPmtDiscPossible);
        if RemPmtDiscPossible = 0 then
          exit(false);
        if not ("Document Type" in ["document type"::"Credit Memo","document type"::Invoice]) then
          exit(false);
        BankAccReconLine.Get("Statement Type","Bank Account No.","Statement No.","Statement Line No.");
        if BankAccReconLine."Transaction Date" > PmtDiscDueDate then
          exit(false);

        if UseAppliedAmt then
          AmtApplied := "Applied Amount" + GetAmtAppliedToOtherStmtLines
        else
          AmtApplied := BankAccReconLine.Difference + GetOldAppliedAmtInclDisc + GetAmtAppliedToOtherStmtLines;

        exit(Abs(AmtApplied) >= Abs(GetRemAmt - RemPmtDiscPossible));
    end;


    procedure GetTotalAppliedAmountInclPmtDisc(IsDelete: Boolean): Decimal
    var
        AppliedPaymentEntry: Record "Applied Payment Entry";
        TotalAmountIncludingPmtDisc: Decimal;
    begin
        AppliedPaymentEntry.SetRange("Statement Type","Statement Type");
        AppliedPaymentEntry.SetRange("Statement No.","Statement No.");
        AppliedPaymentEntry.SetRange("Statement Line No.","Statement Line No.");
        AppliedPaymentEntry.SetRange("Bank Account No.","Bank Account No.");
        AppliedPaymentEntry.SetRange("Account Type","Account Type");
        AppliedPaymentEntry.SetRange("Account No.","Account No.");
        AppliedPaymentEntry.SetFilter("Applies-to Entry No.",'<>%1',"Applies-to Entry No.");

        if IsDelete then
          TotalAmountIncludingPmtDisc := 0
        else
          TotalAmountIncludingPmtDisc := "Applied Amount" - "Applied Pmt. Discount";

        if AppliedPaymentEntry.FindSet then
          repeat
            TotalAmountIncludingPmtDisc += AppliedPaymentEntry."Applied Amount";
            TotalAmountIncludingPmtDisc -= AppliedPaymentEntry."Applied Pmt. Discount";
          until AppliedPaymentEntry.Next = 0;

        exit(TotalAmountIncludingPmtDisc);
    end;

    local procedure GetNoOfAppliedEntries(IsDelete: Boolean): Decimal
    var
        AppliedPaymentEntry: Record "Applied Payment Entry";
    begin
        AppliedPaymentEntry.SetRange("Statement Type","Statement Type");
        AppliedPaymentEntry.SetRange("Statement No.","Statement No.");
        AppliedPaymentEntry.SetRange("Statement Line No.","Statement Line No.");
        AppliedPaymentEntry.SetRange("Bank Account No.","Bank Account No.");
        AppliedPaymentEntry.SetRange("Account Type","Account Type");
        AppliedPaymentEntry.SetRange("Account No.","Account No.");
        AppliedPaymentEntry.SetFilter("Applies-to Entry No.",'<>%1',"Applies-to Entry No.");

        if IsDelete then
          exit(AppliedPaymentEntry.Count);

        exit(AppliedPaymentEntry.Count + 1);
    end;


    procedure UpdatePaymentDiscount(PaymentDiscountAmount: Decimal)
    var
        AppliedPaymentEntry: Record "Applied Payment Entry";
    begin
        // Payment discount must go to last entry only because of posting
        AppliedPaymentEntry.SetRange("Statement Type","Statement Type");
        AppliedPaymentEntry.SetRange("Bank Account No.","Bank Account No.");
        AppliedPaymentEntry.SetRange("Statement No.","Statement No.");
        AppliedPaymentEntry.SetRange("Account Type","Account Type");
        AppliedPaymentEntry.SetRange("Applies-to Entry No.","Applies-to Entry No.");
        AppliedPaymentEntry.SetFilter("Applied Pmt. Discount",'<>0');

        if AppliedPaymentEntry.FindFirst then
          AppliedPaymentEntry.RemovePaymentDiscount;

        if PaymentDiscountAmount = 0 then
          exit;

        AppliedPaymentEntry.SetRange("Applied Pmt. Discount");

        if AppliedPaymentEntry.FindLast then
          if "Statement Line No." < AppliedPaymentEntry."Statement Line No." then begin
            AppliedPaymentEntry.SetPaymentDiscount(PaymentDiscountAmount,true);
            exit;
          end;

        SetPaymentDiscount(PaymentDiscountAmount,false);
    end;


    procedure SetPaymentDiscount(PaymentDiscountAmount: Decimal;DifferentLineThanCurrent: Boolean)
    begin
        Validate("Applied Pmt. Discount",PaymentDiscountAmount);

        if DifferentLineThanCurrent then begin
          "Applied Amount" += "Applied Pmt. Discount";
          Modify(true);
        end;
    end;


    procedure RemovePaymentDiscount()
    begin
        "Applied Amount" := "Applied Amount" - "Applied Pmt. Discount";
        "Applied Pmt. Discount" := 0;
        Modify(true);
    end;
}

