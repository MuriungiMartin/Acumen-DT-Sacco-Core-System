#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 59000 "Bank Acc. ReconciliationAUT"
{
    Caption = 'Bank Acc. Reconciliation';
    DataCaptionFields = "Bank Account No.", "Statement No.";
    // LookupPageID = UnknownPage59003;
    Permissions = TableData "Data Exch." = rimd;

    fields
    {
        field(1; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            NotBlank = true;
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                if "Statement No." = '' then begin
                    BankAcc.LockTable;
                    BankAcc.Get("Bank Account No.");

                    if "Statement Type" = "statement type"::"Payment Application" then begin
                        SetLastPaymentStatementNo(BankAcc);
                        "Statement No." := IncStr(BankAcc."Last Payment Statement No.");
                        BankAcc."Last Payment Statement No." := "Statement No.";
                    end else begin
                        SetLastStatementNo(BankAcc);
                        "Statement No." := IncStr(BankAcc."Last Statement No.");
                        BankAcc."Last Statement No." := "Statement No.";
                    end;

                    "Balance Last Statement" := BankAcc."Balance Last Statement";
                    BankAcc.Modify;
                end;

                CreateDim(Database::"Bank Account", BankAcc."No.");
            end;
        }
        field(2; "Statement No."; Code[20])
        {
            Caption = 'Statement No.';
            NotBlank = true;

            trigger OnValidate()
            begin
                TestField("Bank Account No.");
                if "Statement Type" = "statement type"::"Bank Reconciliation" then begin
                    BankAcc.LockTable;
                    BankAcc.Get("Bank Account No.");
                    BankAcc."Last Statement No." := "Statement No.";
                    BankAcc.Modify;
                end;
            end;
        }
        field(3; "Statement Ending Balance"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Statement Ending Balance';
        }
        field(4; "Statement Date"; Date)
        {
            Caption = 'Statement Date';
        }
        field(5; "Balance Last Statement"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Balance Last Statement';

            trigger OnValidate()
            begin
                TestField("Statement Type", "statement type"::"Bank Reconciliation");
                BankAcc.Get("Bank Account No.");
                if "Balance Last Statement" <> BankAcc."Balance Last Statement" then
                    if not
                       Confirm(
                         Text002, false,
                         FieldCaption("Balance Last Statement"), BankAcc.FieldCaption("Balance Last Statement"),
                         BankAcc.TableCaption)
                    then
                        "Balance Last Statement" := xRec."Balance Last Statement";
            end;
        }
        field(6; "Bank Statement"; Blob)
        {
            Caption = 'Bank Statement';
        }
        field(7; "Total Balance on Bank Account"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Bank Account No.")));
            Caption = 'Total Balance on Bank Account';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Total Applied Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            CalcFormula = sum("Bank Acc. Reconciliation Lines"."Applied Amount" where("Statement Type" = field("Statement Type"), "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.")));
            Caption = 'Total Applied Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Total Transaction Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            CalcFormula = sum("Bank Acc. Reconciliation Lines"."Statement Amount" where("Statement Type" = field("Statement Type"), "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.")));
            Caption = 'Total Transaction Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Statement Type"; Option)
        {
            Caption = 'Statement Type';
            OptionCaption = 'Bank Reconciliation,Payment Application';
            OptionMembers = "Bank Reconciliation","Payment Application";
        }
        field(21; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(22; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim;
            end;
        }
        field(50000; "Total Reconcilled"; Decimal)
        {
            CalcFormula = sum("Bank Acc. Reconciliation Lines"."Applied Amount" where("Bank Account No." = field("Bank Account No."), Difference = filter(0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Total Unreconcilled"; Decimal)
        {
            CalcFormula = sum("Bank Acc. Reconciliation Lines".Difference where("Bank Account No." = field("Bank Account No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Statement Type", "Bank Account No.", "Statement No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if BankAccReconLine.LinesExist(Rec) then
            BankAccReconLine.DeleteAll(true);
    end;

    trigger OnInsert()
    begin
        TestField("Bank Account No.");
        TestField("Statement No.");
        BankAccRecon.Reset;
        BankAccRecon.SetRange("Statement Type", BankAccRecon."Statement Type");
        BankAccRecon.SetRange("Bank Account No.", "Bank Account No.");
        case "Statement Type" of
            "statement type"::"Bank Reconciliation":
                if PostedBankAccStmt.Get("Bank Account No.", "Statement No.") then
                    Error(Text000, "Statement No.");
            "statement type"::"Payment Application":
                if PostedPaymentReconHdr.Get("Bank Account No.", "Statement No.") then
                    Error(Text000, "Statement No.");
        end;
    end;

    trigger OnRename()
    begin
        Error(Text001, TableCaption);
    end;

    var
        Text000: label 'Statement %1 already exists.';
        Text001: label 'You cannot rename a %1.';
        Text002: label '%1 is different from %2 on the %3. Do you want to change the value?';
        BankAcc: Record "Bank Account";
        BankAccRecon: Record "Bank Acc. ReconciliationAUT";
        BankAccReconLine: Record "Bank Acc. Reconciliation Lines";
        PostedBankAccStmt: Record "Bank Account Statements";
        PostedPaymentReconHdr: Record "Posted Payment Recon. Hdr";
        DimMgt: Codeunit DimensionManagement;
        YouChangedDimQst: label 'You may have changed a dimension.\\Do you want to update the lines?';
        NoBankAccountsMsg: label 'You have not set up a bank account.\To use the payments import process, set up a bank account.';
        NoBankAccWithFileFormatMsg: label 'No bank account exists that is ready for import of bank statement files.\Fill the Bank Statement Import Format field on the card of the bank account that you want to use.';
        PostHighConfidentLinesQst: label 'All imported bank statement lines were applied with high confidence level.\Do you want to post the payment applications?';
        MustHaveValueQst: label 'The bank account must have a value in %1. Do you want to open the bank account card?';

    local procedure CreateDim(Type1: Integer; No1: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        OldDimSetID: Integer;
    begin
        SourceCodeSetup.Get;
        TableID[1] := Type1;
        No[1] := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.GetDefaultDimID(
            TableID, No, SourceCodeSetup."Payment Reconciliation Journal", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);

        if (OldDimSetID <> "Dimension Set ID") and LinesExist then begin
            Modify;
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    local procedure GetCurrencyCode(): Code[10]
    var
        BankAcc2: Record "Bank Account";
    begin
        if "Bank Account No." = BankAcc2."No." then
            exit(BankAcc2."Currency Code");

        if BankAcc2.Get("Bank Account No.") then
            exit(BankAcc2."Currency Code");

        exit('');
    end;


    procedure MatchSingle(DateRange: Integer)
    var
        MatchBankRecLines: Codeunit "Match Bank Rec. Liness";
    begin
        MatchBankRecLines.MatchSingle(Rec, DateRange);
    end;


    procedure ImportBankStatement()
    var
        DataExch: Record "Data Exch.";
        ProcessBankAccRecLines: Codeunit "Process Bank Acc. Rec Liness";
    begin
        if BankAccountCouldBeUsedForImport then begin
            DataExch.Init;
            ProcessBankAccRecLines.ImportBankStatement(Rec, DataExch);
        end;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");

        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;


    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        // "Dimension Set ID" :=
        // DimMgt.EditDimensionSet2(
        //   "Dimension Set ID",StrSubstNo('%1 %2',TableCaption,"Statement No."),
        //   "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");

        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Lines";
        NewDimSetID: Integer;
    begin
        // Update all lines with changed dimensions.
        if NewParentDimSetID = OldParentDimSetID then
            exit;

        BankAccReconciliationLine.LockTable;
        if BankAccReconciliationLine.LinesExist(Rec) then begin
            if not Confirm(YouChangedDimQst) then
                exit;

            repeat
                NewDimSetID :=
                  DimMgt.GetDeltaDimSetID(BankAccReconciliationLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if BankAccReconciliationLine."Dimension Set ID" <> NewDimSetID then begin
                    BankAccReconciliationLine."Dimension Set ID" := NewDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(
                      BankAccReconciliationLine."Dimension Set ID",
                      BankAccReconciliationLine."Shortcut Dimension 1 Code",
                      BankAccReconciliationLine."Shortcut Dimension 2 Code");
                    BankAccReconciliationLine.Modify;
                end;
            until BankAccReconciliationLine.Next = 0;
        end;
    end;


    procedure OpenNewWorksheet()
    var
        BankAccount: Record "Bank Account";
        BankAccReconciliation: Record "Bank Acc. ReconciliationAUT";
    begin
        if not SelectBankAccountToUse(BankAccount, false) then
            exit;

        CreateNewBankPaymentAppBatch(BankAccount."No.", BankAccReconciliation);
        OpenWorksheet(BankAccReconciliation);
    end;


    procedure ImportAndProcessToNewStatement()
    var
        BankAccount: Record "Bank Account";
        BankAccReconciliation: Record "Bank Acc. ReconciliationAUT";
        DataExch: Record "Data Exch.";
        DataExchDef: Record "Data Exch. Def";
    begin
        if not SelectBankAccountToUse(BankAccount, true) then
            exit;
        BankAccount.GetDataExchDef(DataExchDef);

        if not DataExch.ImportFileContent(DataExchDef) then
            exit;

        CreateNewBankPaymentAppBatch(BankAccount."No.", BankAccReconciliation);
        ImportAndProcessStatement(BankAccReconciliation, DataExch);
    end;

    local procedure ImportAndProcessStatement(BankAccReconciliation: Record "Bank Acc. ReconciliationAUT"; DataExch: Record "Data Exch.")
    var
        ProcessBankAccRecLines: Codeunit "Process Bank Acc. Rec Liness";
    begin
        if not ProcessBankAccRecLines.ImportBankStatement(BankAccReconciliation, DataExch) then
            exit;

        Commit;
        Codeunit.Run(Codeunit::"Match Bank Pmt. Appl.", BankAccReconciliation);

        if ConfidenceLevelPermitToPost(BankAccReconciliation) then
            Codeunit.Run(Codeunit::"Bank Acc. Reconciliation Post", BankAccReconciliation)
        else
            OpenWorksheet(BankAccReconciliation);
    end;


    procedure CreateNewBankPaymentAppBatch(BankAccountNo: Code[20]; var BankAccReconciliation: Record "Bank Acc. ReconciliationAUT")
    begin
        BankAccReconciliation.Init;
        BankAccReconciliation."Statement Type" := BankAccReconciliation."statement type"::"Payment Application";
        BankAccReconciliation.Validate("Bank Account No.", BankAccountNo);
        BankAccReconciliation.Insert(true);
    end;

    local procedure SelectBankAccountToUse(var BankAccount: Record "Bank Account"; OnlyWithImportFormatSet: Boolean): Boolean
    var
        PaymentBankAccountList: Page "Payment Bank Account List";
    begin
        if OnlyWithImportFormatSet then
            BankAccount.SetFilter("Bank Statement Import Format", '<>%1', '');

        case BankAccount.Count of
            0:
                begin
                    if not BankAccount.Get(CantFindBancAccToUseInPaymentFileImport) then
                        exit(false);

                    exit(true);
                end;
            1:
                BankAccount.FindFirst;
            else begin
                PaymentBankAccountList.LookupMode(true);
                PaymentBankAccountList.SetTableview(BankAccount);
                if PaymentBankAccountList.RunModal = Action::LookupOK then
                    PaymentBankAccountList.GetRecord(BankAccount)
                else
                    exit(false);
            end;
        end;

        exit(true);
    end;


    procedure OpenWorksheet(BankAccReconciliation: Record "Bank Acc. ReconciliationAUT")
    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Lines";
    begin
        SetFiltersOnBankAccReconLineTable(BankAccReconciliation, BankAccReconciliationLine);
        Page.Run(Page::"Payment Reconciliation Journal", BankAccReconciliationLine);
    end;

    local procedure CantFindBancAccToUseInPaymentFileImport(): Code[20]
    var
        BankAccount: Record "Bank Account";
    begin
        if BankAccount.Count = 0 then
            Message(NoBankAccountsMsg)
        else
            Message(NoBankAccWithFileFormatMsg);

        if Page.RunModal(Page::"Payment Bank Account List", BankAccount) = Action::LookupOK then
            if BankAccount."Bank Statement Import Format" <> '' then
                exit(BankAccount."No.");

        exit('');
    end;

    local procedure SetLastPaymentStatementNo(var BankAccount: Record "Bank Account")
    begin
        if BankAccount."Last Payment Statement No." = '' then begin
            BankAccount."Last Payment Statement No." := '0';
            BankAccount.Modify;
        end;
    end;

    local procedure SetLastStatementNo(var BankAccount: Record "Bank Account")
    begin
        if BankAccount."Last Statement No." = '' then begin
            BankAccount."Last Statement No." := '0';
            BankAccount.Modify;
        end;
    end;


    procedure SetFiltersOnBankAccReconLineTable(BankAccReconciliation: Record "Bank Acc. ReconciliationAUT"; var BankAccReconciliationLine: Record "Bank Acc. Reconciliation Lines")
    begin
        BankAccReconciliationLine.FilterGroup := 2;
        BankAccReconciliationLine.SetRange("Statement Type", BankAccReconciliation."Statement Type");
        BankAccReconciliationLine.SetRange("Bank Account No.", BankAccReconciliation."Bank Account No.");
        BankAccReconciliationLine.SetRange("Statement No.", BankAccReconciliation."Statement No.");
        BankAccReconciliationLine.FilterGroup := 0;
    end;

    local procedure ConfidenceLevelPermitToPost(BankAccReconciliation: Record "Bank Acc. ReconciliationAUT"): Boolean
    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Lines";
    begin
        SetFiltersOnBankAccReconLineTable(BankAccReconciliation, BankAccReconciliationLine);
        if BankAccReconciliationLine.Count = 0 then
            exit(false);

        BankAccReconciliationLine.SetFilter("Match Confidence", '<>%1', BankAccReconciliationLine."match confidence"::High);
        if BankAccReconciliationLine.Count <> 0 then
            exit(false);

        if Confirm(PostHighConfidentLinesQst) then
            exit(true);

        exit(false);
    end;

    local procedure LinesExist(): Boolean
    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Lines";
    begin
        exit(BankAccReconciliationLine.LinesExist(Rec));
    end;

    local procedure BankAccountCouldBeUsedForImport(): Boolean
    var
        BankAccount: Record "Bank Account";
    begin
        BankAccount.Get("Bank Account No.");
        if BankAccount."Bank Statement Import Format" <> '' then
            exit(true);

        if not Confirm(MustHaveValueQst, true, BankAccount.FieldCaption("Bank Statement Import Format")) then
            exit(false);

        if Page.RunModal(Page::"Payment Bank Account Card", BankAccount) = Action::LookupOK then
            if BankAccount."Bank Statement Import Format" <> '' then
                exit(true);

        exit(false);
    end;


    procedure GetTempCopy(var BankAccReconciliation: Record "Bank Acc. ReconciliationAUT")
    begin
        if BankAccReconciliation.HasFilter then
            CopyFilters(BankAccReconciliation);

        SetRange("Statement Type", "statement type"::"Bank Reconciliation");
        if not FindSet then
            exit;

        repeat
            BankAccReconciliation := Rec;
            BankAccReconciliation.Insert;
        until Next = 0;
    end;


    procedure GetTempCopyFromBankRecHeader(var BankAccReconciliation: Record "Bank Acc. ReconciliationAUT")
    var
    //  BankRecHeader: Record UnknownRecord10120;
    begin
        if BankAccReconciliation.HasFilter then begin
            //   BankRecHeader.SetFilter("Bank Account No.",BankAccReconciliation.GetFilter("Bank Account No."));
            //   BankRecHeader.SetFilter("Statement No.",BankAccReconciliation.GetFilter("Statement No."));
            //   BankRecHeader.SetFilter("Statement Date",BankAccReconciliation.GetFilter("Statement Date"));
            //   BankRecHeader.SetFilter("Statement Balance",BankAccReconciliation.GetFilter("Balance Last Statement"));
            // end;

            // if not BankRecHeader.FindSet then
            //   exit;

            //repeat
            //   BankAccReconciliation."Statement Type" := BankAccReconciliation."statement type"::"Bank Reconciliation";
            //   BankAccReconciliation."Bank Account No." := BankRecHeader."Bank Account No.";
            //   BankAccReconciliation."Statement No." := BankRecHeader."Statement No.";
            //   BankAccReconciliation."Statement Date" := BankRecHeader."Statement Date";
            //   BankAccReconciliation."Balance Last Statement" := BankRecHeader."Statement Balance";
            //   BankAccReconciliation."Statement Ending Balance" := BankRecHeader.CalculateEndingBalance;
            //   BankAccReconciliation.Insert;
            // until BankRecHeader.Next = 0;
        end;
    end;


    procedure InsertRec(StatementType: Option; BankAccountNo: Code[20])
    begin
        Init;
        Validate("Statement Type", StatementType);
        Validate("Bank Account No.", BankAccountNo);
        Insert(true);
    end;
}

