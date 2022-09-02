#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516092 "Bank Acc. Statement Linevb"
{
    Caption = 'Bank Acc. Statement Line';
    Permissions = TableData "Data Exch. Field"=rimd;

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
            TableRelation = "Bank Acc. Reconciliation"."Statement No." where ("Bank Account No."=field("Bank Account No."));
        }
        field(3;"Statement Line No.";Integer)
        {
            AutoIncrement = true;
            Caption = 'Statement Line No.';
        }
        field(4;"Document No.";Code[20])
        {
            Caption = 'Document No.';
        }
        field(5;"Transaction Date";Date)
        {
            Caption = 'Transaction Date';
        }
        field(6;Description;Text[50])
        {
            Caption = 'Description';
        }
        field(7;"Statement Amount";Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Statement Amount';

            trigger OnValidate()
            begin
                Difference := "Statement Amount" - "Applied Amount";
            end;
        }
        field(8;Difference;Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Difference';

            trigger OnValidate()
            begin
                "Statement Amount" := "Applied Amount" + Difference;
            end;
        }
        field(9;"Applied Amount";Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Applied Amount';
            Editable = false;

            trigger OnLookup()
            begin
                DisplayApplication;
            end;

            trigger OnValidate()
            begin
                Difference := "Statement Amount" - "Applied Amount";
            end;
        }
        field(10;Type;Option)
        {
            Caption = 'Type';
            OptionCaption = 'Bank Account Ledger Entry,Check Ledger Entry,Difference';
            OptionMembers = "Bank Account Ledger Entry","Check Ledger Entry",Difference;

            trigger OnValidate()
            begin
                if (Type <> xRec.Type) and
                   ("Applied Entries" <> 0)
                then
                  if Confirm(Text001,false) then begin
                    RemoveApplication(xRec.Type);
                    Validate("Applied Amount",0);
                    "Applied Entries" := 0;
                    "Check No." := '';
                  end else
                    Error(Text002);
            end;
        }
        field(11;"Applied Entries";Integer)
        {
            Caption = 'Applied Entries';
            Editable = false;

            trigger OnLookup()
            begin
                DisplayApplication;
            end;
        }
        field(12;"Value Date";Date)
        {
            Caption = 'Value Date';
        }
        field(13;"Ready for Application";Boolean)
        {
            Caption = 'Ready for Application';
        }
        field(14;"Check No.";Code[80])
        {
            Caption = 'Check No.';
        }
        field(15;"Related-Party Name";Text[50])
        {
            Caption = 'Related-Party Name';
        }
        field(16;"Additional Transaction Info";Text[100])
        {
            Caption = 'Additional Transaction Info';
        }
        field(17;"Posting Exch. Entry No.";Integer)
        {
            Caption = 'Posting Exch. Entry No.';
            Editable = false;
            TableRelation = "Data Exch.";
        }
        field(18;"Posting Exch. Line No.";Integer)
        {
            Caption = 'Posting Exch. Line No.';
            Editable = false;
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
                TestField("Applied Amount",0);
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
                TestField("Applied Amount",0);
                CreateDim(DimMgt.TypeToTableID1("Account Type"),"Account No.");
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
            end;
        }
        field(23;"Transaction Text";Text[140])
        {
            Caption = 'Transaction Text';

            trigger OnValidate()
            begin
                if ("Statement Type" = "statement type"::"Payment Application") or (Description = '') then
                  Description := CopyStr("Transaction Text",1,MaxStrLen(Description));
            end;
        }
        field(24;"Related-Party Bank Acc. No.";Text[50])
        {
            Caption = 'Related-Party Bank Acc. No.';
        }
        field(25;"Related-Party Address";Text[100])
        {
            Caption = 'Related-Party Address';
        }
        field(26;"Related-Party City";Text[50])
        {
            Caption = 'Related-Party City';
        }
        field(31;"Shortcut Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(32;"Shortcut Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(50;"Match Confidence";Option)
        {
            CalcFormula = max("Applied Payment Entry"."Match Confidence" where ("Statement Type"=field("Statement Type"),
                                                                                "Bank Account No."=field("Bank Account No."),
                                                                                "Statement No."=field("Statement No."),
                                                                                "Statement Line No."=field("Statement Line No.")));
            Caption = 'Match Confidence';
            Editable = false;
            FieldClass = FlowField;
            InitValue = "None";
            OptionCaption = 'None,Low,Medium,High,High - Text-to-Account Mapping,Manual,Accepted';
            OptionMembers = "None",Low,Medium,High,"High - Text-to-Account Mapping",Manual,Accepted;
        }
        field(51;"Match Quality";Integer)
        {
            CalcFormula = max("Applied Payment Entry".Quality where ("Bank Account No."=field("Bank Account No."),
                                                                     "Statement No."=field("Statement No."),
                                                                     "Statement Line No."=field("Statement Line No."),
                                                                     "Statement Type"=field("Statement Type")));
            Caption = 'Match Quality';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60;"Sorting Order";Integer)
        {
            Caption = 'Sorting Order';
        }
        field(480;"Dimension Set ID";Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
        field(50000;Reconciled;Boolean)
        {
        }
        field(50004;"Open Type";Option)
        {
            OptionCaption = ' ,Unpresented Cheques List,Uncredited Cheques List';
            OptionMembers = " ",Unpresented,Uncredited;
        }
        field(50005;Imported;Boolean)
        {
            Description = 'Imported from bank statement, not suggested';
        }
        field(50006;"Reconciling Date";Date)
        {
        }
    }

    keys
    {
        key(Key1;"Statement Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        RemoveApplication(Type);
        ClearPostExchEntries;
        RemoveAppliedPaymentEntries;
        DeletePaymentMatchingDetails;
        Find;
    end;

    trigger OnInsert()
    begin
        BankAccRecon.Get("Statement Type","Bank Account No.","Statement No.");
        "Applied Entries" := 0;
        Validate("Applied Amount",0);
    end;

    trigger OnModify()
    begin
        if xRec."Statement Amount" <> "Statement Amount" then
          RemoveApplication(Type);
    end;

    trigger OnRename()
    begin
        Error(Text000,TableCaption);
    end;

    var
        Text000: label 'You cannot rename a %1.';
        Text001: label 'Delete application?';
        Text002: label 'Update canceled.';
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        CheckLedgEntry: Record "Check Ledger Entry";
        BankAccRecon: Record "Bank Acc. Reconciliation";
        BankAccSetStmtNo: Codeunit "Bank Acc. Entry Set Recon.-No.";
        CheckSetStmtNo: Codeunit "Check Entry Set Recon.-No.";
        DimMgt: Codeunit DimensionManagement;
        AmountWithinToleranceRangeTok: label '>=%1&<=%2', Comment='Do not translate.';
        AmountOustideToleranceRangeTok: label '<%1|>%2', Comment='Do not translate.';


    procedure DisplayApplication()
    var
        PaymentApplication: Page "Payment Application";
    begin
        case "Statement Type" of
          "statement type"::"Bank Reconciliation":
            case Type of
              Type::"Bank Account Ledger Entry":
                begin
                  BankAccLedgEntry.Reset;
                  BankAccLedgEntry.SetCurrentkey("Bank Account No.",Open);
                  BankAccLedgEntry.SetRange("Bank Account No.","Bank Account No.");
                  BankAccLedgEntry.SetRange(Open,true);
                  BankAccLedgEntry.SetRange(
                    "Statement Status",BankAccLedgEntry."statement status"::"Bank Acc. Entry Applied");
                  BankAccLedgEntry.SetRange("Statement No.","Statement No.");
                  BankAccLedgEntry.SetRange("Statement Line No.","Statement Line No.");
                  Page.Run(0,BankAccLedgEntry);
                end;
              Type::"Check Ledger Entry":
                begin
                  CheckLedgEntry.Reset;
                  CheckLedgEntry.SetCurrentkey("Bank Account No.",Open);
                  CheckLedgEntry.SetRange("Bank Account No.","Bank Account No.");
                  CheckLedgEntry.SetRange(Open,true);
                  CheckLedgEntry.SetRange(
                    "Statement Status",CheckLedgEntry."statement status"::"Check Entry Applied");
                  CheckLedgEntry.SetRange("Statement No.","Statement No.");
                  CheckLedgEntry.SetRange("Statement Line No.","Statement Line No.");
                  Page.Run(0,CheckLedgEntry);
                end;
            end;
        /*
          "Statement Type"::"Payment Application":
            BEGIN
              TESTFIELD("Statement Amount");
              PaymentApplication.SetBankAccReconcLine(Rec);
              PaymentApplication.RUNMODAL;
            END;
        */
        end;

    end;


    procedure GetCurrencyCode(): Code[10]
    var
        BankAcc: Record "Bank Account";
    begin
        if "Bank Account No." = BankAcc."No." then
          exit(BankAcc."Currency Code");

        if BankAcc.Get("Bank Account No.") then
          exit(BankAcc."Currency Code");

        exit('');
    end;


    procedure GetStyle(): Text
    begin
        if "Applied Entries" <> 0 then
          exit('Favorable');

        exit('');
    end;


    procedure ClearPostExchEntries()
    var
        PostExchField: Record "Data Exch. Field";
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
    begin
        PostExchField.DeleteRelatedRecords("Posting Exch. Entry No.","Posting Exch. Line No.");

        BankAccReconciliationLine.SetRange("Statement Type","Statement Type");
        BankAccReconciliationLine.SetRange("Bank Account No.","Bank Account No.");
        BankAccReconciliationLine.SetRange("Statement No.","Statement No.");
        BankAccReconciliationLine.SetRange("Posting Exch. Entry No.","Posting Exch. Entry No.");
        BankAccReconciliationLine.SetFilter("Statement Line No.",'<>%1',"Statement Line No.");
        if BankAccReconciliationLine.IsEmpty then
          PostExchField.DeleteRelatedRecords("Posting Exch. Entry No.",0);
    end;


    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID",StrSubstNo('%1 %2 %3',TableCaption,"Statement No.","Statement Line No."));
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
    end;


    procedure CreateDim(Type1: Integer;No1: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        TableID: array [10] of Integer;
        No: array [10] of Code[20];
    begin
        SourceCodeSetup.Get;
        TableID[1] := Type1;
        No[1] := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        BankAccReconciliation.Get("Statement Type","Bank Account No.","Statement No.");
        "Dimension Set ID" :=
          DimMgt.GetDefaultDimID(
            TableID,No,SourceCodeSetup."Payment Reconciliation Journal",
            "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code",BankAccReconciliation."Dimension Set ID",Database::"Bank Account");
    end;


    procedure SetUpNewLine()
    begin
        "Transaction Date" := WorkDate;
        "Match Confidence" := "match confidence"::None;
        "Document No." := '';
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
    end;


    procedure LookupShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber,ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber,ShortcutDimCode);
    end;


    procedure ShowShortcutDimCode(var ShortcutDimCode: array [8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID",ShortcutDimCode);
    end;


    procedure AcceptAppliedPaymentEntriesSelectedLines()
    begin
        if FindSet then
          repeat
            AcceptApplication;
          until Next = 0;
    end;


    procedure RejectAppliedPaymentEntriesSelectedLines()
    begin
        if FindSet then
          repeat
            RejectAppliedPayment;
          until Next = 0;
    end;


    procedure RejectAppliedPayment()
    begin
        RemoveAppliedPaymentEntries;
        DeletePaymentMatchingDetails;
    end;


    procedure AcceptApplication()
    var
        AppliedPaymentEntry: Record "Applied Payment Entry";
    begin
        if Difference > 0 then
          TransferRemainingAmountToAccount;

        //AppliedPaymentEntry.FilterAppliedPmtEntry(Rec);
        AppliedPaymentEntry.ModifyAll("Match Confidence","match confidence"::Accepted);
    end;


    procedure RemoveApplication(AppliedType: Option)
    begin
        /*
        IF "Statement Type" = "Statement Type"::"Bank Reconciliation" THEN
          CASE AppliedType OF
            Type::"Bank Account Ledger Entry":
              BEGIN
                BankAccLedgEntry.RESET;
                BankAccLedgEntry.SETCURRENTKEY("Bank Account No.",Open);
                BankAccLedgEntry.SETRANGE("Bank Account No.","Bank Account No.");
                BankAccLedgEntry.SETRANGE(Open,TRUE);
                BankAccLedgEntry.SETRANGE(
                  "Statement Status",BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
                BankAccLedgEntry.SETRANGE("Statement No.","Statement No.");
                BankAccLedgEntry.SETRANGE("Statement Line No.","Statement Line No.");
                BankAccLedgEntry.LOCKTABLE;
                CheckLedgEntry.LOCKTABLE;
                IF BankAccLedgEntry.FIND('-') THEN
                  REPEAT
                    BankAccSetStmtNo.RemoveReconNo(BankAccLedgEntry,Rec,TRUE);
                  UNTIL BankAccLedgEntry.NEXT = 0;
                "Applied Entries" := 0;
                VALIDATE("Applied Amount",0);
                MODIFY;
              END;
            Type::"Check Ledger Entry":
              BEGIN
                CheckLedgEntry.RESET;
                CheckLedgEntry.SETCURRENTKEY("Bank Account No.",Open);
                CheckLedgEntry.SETRANGE("Bank Account No.","Bank Account No.");
                CheckLedgEntry.SETRANGE(Open,TRUE);
                CheckLedgEntry.SETRANGE(
                  "Statement Status",CheckLedgEntry."Statement Status"::"Check Entry Applied");
                CheckLedgEntry.SETRANGE("Statement No.","Statement No.");
                CheckLedgEntry.SETRANGE("Statement Line No.","Statement Line No.");
                BankAccLedgEntry.LOCKTABLE;
                CheckLedgEntry.LOCKTABLE;
                IF CheckLedgEntry.FIND('-') THEN
                  REPEAT
                    CheckSetStmtNo.RemoveReconNo(CheckLedgEntry,Rec,TRUE);
                  UNTIL CheckLedgEntry.NEXT = 0;
                "Applied Entries" := 0;
                VALIDATE("Applied Amount",0);
                "Check No." := '';
                MODIFY;
              END;
          END;
        */

    end;


    procedure SetManualApplication()
    var
        AppliedPaymentEntry: Record "Applied Payment Entry";
    begin
        //AppliedPaymentEntry.FilterAppliedPmtEntry(Rec);
        AppliedPaymentEntry.ModifyAll("Match Confidence","match confidence"::Manual)
    end;

    local procedure RemoveAppliedPaymentEntries()
    var
        AppliedPmtEntry: Record "Applied Payment Entry";
    begin
        /*
        AppliedPmtEntry.SETRANGE("Statement Type","Statement Type");
        AppliedPmtEntry.SETRANGE("Bank Account No.","Bank Account No.");
        AppliedPmtEntry.SETRANGE("Statement No.","Statement No.");
        AppliedPmtEntry.SETRANGE("Statement Line No.","Statement Line No.");
        AppliedPmtEntry.DELETEALL;
        AppliedPmtEntry.FilterAppliedPmtEntry(Rec);
        AppliedPmtEntry.DELETEALL(TRUE);
        
        VALIDATE("Applied Amount",0);
        VALIDATE("Applied Entries",0);
        MODIFY(TRUE);
        */

    end;

    local procedure DeletePaymentMatchingDetails()
    var
        PaymentMatchingDetails: Record "Payment Matching Details";
    begin
        PaymentMatchingDetails.SetRange("Statement Type","Statement Type");
        PaymentMatchingDetails.SetRange("Bank Account No.","Bank Account No.");
        PaymentMatchingDetails.SetRange("Statement No.","Statement No.");
        PaymentMatchingDetails.SetRange("Statement Line No.","Statement Line No.");
        PaymentMatchingDetails.DeleteAll(true);
    end;


    procedure GetAppliedToName(): Text
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


    procedure AppliedToDrillDown()
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


    procedure DrillDownOnNoOfLedgerEntriesWithinAmountTolerance()
    begin
        DrillDownOnNoOfLedgerEntriesBasedOnAmount(AmountWithinToleranceRangeTok);
    end;


    procedure DrillDownOnNoOfLedgerEntriesOutsideOfAmountTolerance()
    begin
        DrillDownOnNoOfLedgerEntriesBasedOnAmount(AmountOustideToleranceRangeTok);
    end;

    local procedure DrillDownOnNoOfLedgerEntriesBasedOnAmount(AmountFilter: Text)
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        MinAmount: Decimal;
        MaxAmount: Decimal;
    begin
        GetAmountRangeForTolerance(MinAmount,MaxAmount);

        case "Account Type" of
          "account type"::Customer:
            begin
              GetCustomerLedgerEntriesInAmountRange(CustLedgerEntry,"Account No.",AmountFilter,MinAmount,MaxAmount);
              Page.Run(Page::"Customer Ledger Entries",CustLedgerEntry);
            end;
          "account type"::Vendor:
            begin
              GetVendorLedgerEntriesInAmountRange(VendorLedgerEntry,"Account No.",AmountFilter,MinAmount,MaxAmount);
              Page.Run(Page::"Vendor Ledger Entries",VendorLedgerEntry);
            end;
        end;
    end;


    procedure GetCustomerLedgerEntriesInAmountRange(var CustLedgerEntry: Record "Cust. Ledger Entry";AccountNo: Code[20];AmountFilter: Text;MinAmount: Decimal;MaxAmount: Decimal): Integer
    var
        BankAccount: Record "Bank Account";
    begin
        CustLedgerEntry.SetAutocalcFields("Remaining Amount","Remaining Amt. (LCY)");
        BankAccount.Get("Bank Account No.");
        GetApplicableCustomerLedgerEntries(CustLedgerEntry,BankAccount."Currency Code",AccountNo);

        if BankAccount.IsInLocalCurrency then
          CustLedgerEntry.SetFilter("Remaining Amt. (LCY)",AmountFilter,MinAmount,MaxAmount)
        else
          CustLedgerEntry.SetFilter("Remaining Amount",AmountFilter,MinAmount,MaxAmount);

        exit(CustLedgerEntry.Count);
    end;


    procedure GetVendorLedgerEntriesInAmountRange(var VendorLedgerEntry: Record "Vendor Ledger Entry";AccountNo: Code[20];AmountFilter: Text;MinAmount: Decimal;MaxAmount: Decimal): Integer
    var
        BankAccount: Record "Bank Account";
    begin
        VendorLedgerEntry.SetAutocalcFields("Remaining Amount","Remaining Amt. (LCY)");

        BankAccount.Get("Bank Account No.");
        GetApplicableVendorLedgerEntries(VendorLedgerEntry,BankAccount."Currency Code",AccountNo);

        if BankAccount.IsInLocalCurrency then
          VendorLedgerEntry.SetFilter("Remaining Amt. (LCY)",AmountFilter,MinAmount,MaxAmount)
        else
          VendorLedgerEntry.SetFilter("Remaining Amount",AmountFilter,MinAmount,MaxAmount);

        exit(VendorLedgerEntry.Count);
    end;

    local procedure GetApplicableCustomerLedgerEntries(var CustLedgerEntry: Record "Cust. Ledger Entry";CurrencyCode: Code[10];AccountNo: Code[20])
    begin
        CustLedgerEntry.SetRange(Open,true);
        CustLedgerEntry.SetRange("Applies-to ID",'');
        CustLedgerEntry.SetFilter("Document Type",'<>%1&<>%2',
          CustLedgerEntry."document type"::Payment,
          CustLedgerEntry."document type"::Refund);

        if CurrencyCode <> '' then
          CustLedgerEntry.SetRange("Currency Code",CurrencyCode);

        if AccountNo <> '' then
          CustLedgerEntry.SetFilter("Customer No.",AccountNo);
    end;

    local procedure GetApplicableVendorLedgerEntries(var VendorLedgerEntry: Record "Vendor Ledger Entry";CurrencyCode: Code[10];AccountNo: Code[20])
    begin
        VendorLedgerEntry.SetRange(Open,true);
        VendorLedgerEntry.SetRange("Applies-to ID",'');
        VendorLedgerEntry.SetFilter("Document Type",'<>%1&<>%2',
          VendorLedgerEntry."document type"::Payment,
          VendorLedgerEntry."document type"::Refund);

        if CurrencyCode <> '' then
          VendorLedgerEntry.SetRange("Currency Code",CurrencyCode);

        if AccountNo <> '' then
          VendorLedgerEntry.SetFilter("Vendor No.",AccountNo);
    end;


    procedure FilterBankRecLines(BankAccRecon: Record "Bank Acc. Reconciliation")
    begin
        Reset;
        SetRange("Statement Type",BankAccRecon."Statement Type");
        SetRange("Bank Account No.",BankAccRecon."Bank Account No.");
        SetRange("Statement No.",BankAccRecon."Statement No.");
    end;


    procedure LinesExist(BankAccRecon: Record "Bank Acc. Reconciliation"): Boolean
    begin
        FilterBankRecLines(BankAccRecon);
        exit(FindSet);
    end;


    procedure GetAppliedToDocumentNo(): Text
    var
        ApplyType: Option "Document No.","Entry No.";
    begin
        exit(GetAppliedNo(Applytype::"Document No."));
    end;


    procedure GetAppliedToEntryNo(): Text
    var
        ApplyType: Option "Document No.","Entry No.";
    begin
        exit(GetAppliedNo(Applytype::"Entry No."));
    end;

    local procedure GetAppliedNo(ApplyType: Option "Document No.","Entry No."): Text
    var
        AppliedPaymentEntry: Record "Applied Payment Entry";
        AppliedNumbers: Text;
    begin
        AppliedPaymentEntry.SetRange("Statement Type","Statement Type");
        AppliedPaymentEntry.SetRange("Bank Account No.","Bank Account No.");
        AppliedPaymentEntry.SetRange("Statement No.","Statement No.");
        AppliedPaymentEntry.SetRange("Statement Line No.","Statement Line No.");

        AppliedNumbers := '';
        if AppliedPaymentEntry.FindSet then begin
          repeat
            if ApplyType = Applytype::"Document No." then begin
              if AppliedPaymentEntry."Document No." <> '' then
                if AppliedNumbers = '' then
                  AppliedNumbers := AppliedPaymentEntry."Document No."
                else
                  AppliedNumbers := AppliedNumbers + ', ' + AppliedPaymentEntry."Document No.";
            end else begin
              if AppliedPaymentEntry."Applies-to Entry No." <> 0 then
                if AppliedNumbers = '' then
                  AppliedNumbers := Format(AppliedPaymentEntry."Applies-to Entry No.")
                else
                  AppliedNumbers := AppliedNumbers + ', ' + Format(AppliedPaymentEntry."Applies-to Entry No.");
            end;
          until AppliedPaymentEntry.Next = 0;
        end;

        exit(AppliedNumbers);
    end;


    procedure TransferRemainingAmountToAccount()
    var
        AppliedPaymentEntry: Record "Applied Payment Entry";
    begin
        /*
        TESTFIELD("Account No.");
        
        AppliedPaymentEntry.TransferFromBankAccReconLine(Rec);
        AppliedPaymentEntry."Account Type" := "Account Type";
        AppliedPaymentEntry."Account No." := "Account No.";
        AppliedPaymentEntry.VALIDATE("Applied Amount",Difference);
        AppliedPaymentEntry.VALIDATE("Match Confidence",AppliedPaymentEntry."Match Confidence"::Manual);
        AppliedPaymentEntry.INSERT(TRUE);
        */

    end;


    procedure GetAmountRangeForTolerance(var MinAmount: Decimal;var MaxAmount: Decimal)
    var
        BankAccount: Record "Bank Account";
        TempAmount: Decimal;
    begin
        BankAccount.Get("Bank Account No.");
        case BankAccount."Match Tolerance Type" of
          BankAccount."match tolerance type"::Amount:
            begin
              MinAmount := "Statement Amount" - BankAccount."Match Tolerance Value";
              MaxAmount := "Statement Amount" + BankAccount."Match Tolerance Value";

              if ("Statement Amount" >= 0) and (MinAmount < 0) then
                MinAmount := 0
              else
                if ("Statement Amount" < 0) and (MaxAmount > 0) then
                  MaxAmount := 0;
            end;
          BankAccount."match tolerance type"::Percentage:
            begin
              MinAmount := "Statement Amount" / (1 + BankAccount."Match Tolerance Value" / 100);
              MaxAmount := "Statement Amount" / (1 - BankAccount."Match Tolerance Value" / 100);

              if "Statement Amount" < 0 then begin
                TempAmount := MinAmount;
                MinAmount := MaxAmount;
                MaxAmount := TempAmount;
              end;
            end;
        end;

        MinAmount := ROUND(MinAmount);
        MaxAmount := ROUND(MaxAmount);
    end;
}

