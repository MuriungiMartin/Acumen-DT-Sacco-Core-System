#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516010 "Staff Claims Header"
{
    DrillDownPageID = "Staff Claims List";
    LookupPageID = "Staff Claims List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Description = 'Stores the reference of the payment voucher in the database';
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    GenLedgerSetup.Get;
                    NoSeriesMgt.TestManual(GenLedgerSetup."Claim Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Date; Date)
        {
            Description = 'Stores the date when the payment voucher was inserted into the system';

            trigger OnValidate()
            begin
                if ImpLinesExist then begin
                    Error('You first need to delete the existing imprest lines before changing the Currency Code'
                    );
                end;

                if "Currency Code" = xRec."Currency Code" then
                    UpdateCurrencyFactor;

                if "Currency Code" <> xRec."Currency Code" then begin
                    UpdateCurrencyFactor;
                    //RecreatePurchLines(FIELDCAPTION("Currency Code"));
                end else
                    if "Currency Code" <> '' then
                        UpdateCurrencyFactor;

                UpdateHeaderToLine;
            end;
        }
        field(3; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(4; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = true;
            Enabled = true;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if ImpLinesExist then begin
                    Error('You first need to delete the existing imprest lines before changing the Currency Code'
                    );
                end;

                if "Currency Code" = xRec."Currency Code" then
                    UpdateCurrencyFactor;

                if "Currency Code" <> xRec."Currency Code" then begin
                    UpdateCurrencyFactor;
                    //RecreatePurchLines(FIELDCAPTION("Currency Code"));
                end else
                    if "Currency Code" <> '' then
                        UpdateCurrencyFactor;

                UpdateHeaderToLine;
            end;
        }
        field(9; Payee; Text[100])
        {
            Description = 'Stores the name of the person who received the money';
        }
        field(10; "On Behalf Of"; Text[100])
        {
            Description = 'Stores the name of the person on whose behalf the payment voucher was taken';
        }
        field(11; Cashier; Code[50])
        {
            Description = 'Stores the identifier of the cashier in the database';
        }
        field(16; Posted; Boolean)
        {
            Description = 'Stores whether the payment voucher is posted or not';
        }
        field(17; "Date Posted"; Date)
        {
            Description = 'Stores the date when the payment voucher was posted';
        }
        field(18; "Time Posted"; Time)
        {
            Description = 'Stores the time when the payment voucher was posted';
        }
        field(19; "Posted By"; Code[50])
        {
            Description = 'Stores the name of the person who posted the payment voucher';
        }
        field(20; "Total Payment Amount"; Decimal)
        {
            CalcFormula = sum("Payment Line.".Amount where(No = field("No.")));
            Description = 'Stores the amount of the payment voucher';
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Paying Bank Account"; Code[20])
        {
            Description = 'Stores the name of the paying bank account in the database';
            TableRelation = "Bank Account"."No." where("Currency Code" = field("Currency Code"));

            trigger OnValidate()
            begin
                BankAcc.Reset;
                "Bank Name" := '';
                if BankAcc.Get("Paying Bank Account") then begin
                    "Bank Name" := BankAcc.Name;
                    // "Currency Code":=BankAcc."Currency Code";   //Currency Being determined first before document is released for approval
                    // VALIDATE("Currency Code");
                end;
            end;
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 1);
                DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
                if DimVal.Find('-') then
                    "Function Name" := DimVal.Name;

                UpdateHeaderToLine;
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(35; Status; Option)
        {
            Description = 'Stores the status of the record in the database';
            OptionMembers = Pending,"1st Approval","2nd Approval","Cheque Printing",Posted,Cancelled,Checking,VoteBook,"Pending Approval",Approved;
        }
        field(38; "Payment Type"; Option)
        {
            OptionMembers = Imprest;
        }
        field(56; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                if DimVal.Find('-') then
                    "Budget Center Name" := DimVal.Name;

                UpdateHeaderToLine;
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(57; "Function Name"; Text[100])
        {
            Description = 'Stores the name of the function in the database';
        }
        field(58; "Budget Center Name"; Text[100])
        {
            Description = 'Stores the name of the budget center in the database';
        }
        field(59; "Bank Name"; Text[100])
        {
            Description = 'Stores the description of the paying bank account in the database';
        }
        field(60; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
        field(61; Select; Boolean)
        {
            Description = 'Enables the user to select a particular record';
        }
        field(62; "Total VAT Amount"; Decimal)
        {
            CalcFormula = sum("Payment Line."."VAT Amount" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "Total Witholding Tax Amount"; Decimal)
        {
            CalcFormula = sum("Payment Line."."Withholding Tax Amount" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(64; "Total Net Amount"; Decimal)
        {
            CalcFormula = sum("Staff Claim Lines".Amount where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(65; "Current Status"; Code[20])
        {
            Description = 'Stores the current status of the payment voucher in the database';
        }
        field(66; "Cheque No."; Code[20])
        {
        }
        field(67; "Pay Mode"; Option)
        {
            OptionMembers = " ",Cash,Cheque,EFT,"Letter of Credit","Custom 3","Custom 4","Custom 5";
        }
        field(68; "Payment Release Date"; Date)
        {

            trigger OnValidate()
            begin

                //Changed to ensure Release date is not less than the Date entered
                if "Payment Release Date" < Date then
                    Error('The Payment Release Date cannot be lesser than the Document Date');
            end;
        }
        field(69; "No. Printed"; Integer)
        {
        }
        field(70; "VAT Base Amount"; Decimal)
        {
        }
        field(71; "Exchange Rate"; Decimal)
        {
        }
        field(72; "Currency Reciprical"; Decimal)
        {
        }
        field(73; "Current Source A/C Bal."; Decimal)
        {
        }
        field(74; "Cancellation Remarks"; Text[250])
        {
        }
        field(75; "Register Number"; Integer)
        {
        }
        field(76; "From Entry No."; Integer)
        {
        }
        field(77; "To Entry No."; Integer)
        {
        }
        field(78; "Invoice Currency Code"; Code[10])
        {
            Caption = 'Invoice Currency Code';
            Editable = true;
            TableRelation = Currency;
        }
        field(79; "Total Net Amount LCY"; Decimal)
        {
            CalcFormula = sum("Staff Claim Lines"."Amount LCY" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(80; "Document Type"; Option)
        {
            OptionMembers = "Payment Voucher","Petty Cash";
        }
        field(81; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin
                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 3 Code");
                if DimVal.Find('-') then
                    Dim3 := DimVal.Name;

                UpdateHeaderToLine;
            end;
        }
        field(82; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));

            trigger OnValidate()
            begin
                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 4 Code");
                if DimVal.Find('-') then
                    Dim4 := DimVal.Name;

                UpdateHeaderToLine;
            end;
        }
        field(83; Dim3; Text[250])
        {
        }
        field(84; Dim4; Text[250])
        {
        }
        field(85; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin

                TestField(Status, Status::Pending);
                if not UserMgt.CheckRespCenter(1, "Shortcut Dimension 3 Code") then
                    Error(
                      Text001,
                      RespCenter.TableCaption, UserMgt.GetPurchasesFilter);
                /*
               "Location Code" := UserMgt.GetLocation(1,'',"Responsibility Center");
               IF "Location Code" = '' THEN BEGIN
                 IF InvtSetup.GET THEN
                   "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
               END ELSE BEGIN
                 IF Location.GET("Location Code") THEN;
                 "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
               END;

               UpdateShipToAddress;
                  */
                /*
             CreateDim(
               DATABASE::"Responsibility Center","Responsibility Center",
               DATABASE::Vendor,"Pay-to Vendor No.",
               DATABASE::"Salesperson/Purchaser","Purchaser Code",
               DATABASE::Campaign,"Campaign No.");

             IF xRec."Responsibility Center" <> "Responsibility Center" THEN BEGIN
               RecreatePurchLines(FIELDCAPTION("Responsibility Center"));
               "Assigned User ID" := '';
             END;
               */

            end;
        }
        field(86; "Account Type"; Option)
        {
            Caption = 'Account Type';
            Editable = false;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(87; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            Editable = true;
            TableRelation = if ("Account Type" = const(Customer)) Customer;

            trigger OnValidate()
            begin
                Cust.Reset;
                if Cust.Get("Account No.") then begin
                    Cust.TestField("Gen. Bus. Posting Group");
                    Cust.TestField(Blocked, Cust.Blocked::" ");

                    Payee := Cust.Name;
                    "On Behalf Of" := Cust.Name;
                end;

                /*
                    //Check CreditLimit Here In cases where you have a credit limit set for employees
                     Cust.CALCFIELDS(Cust."Balance (LCY)");
                      IF Cust."Balance (LCY)">Cust."Credit Limit (LCY)" THEN
                         ERROR('The allowable unaccounted balance of %1 has been exceeded',Cust."Credit Limit (LCY)");
                 */

            end;
        }
        field(88; "Surrender Status"; Option)
        {
            OptionMembers = " ",Full,Partial;
        }
        field(89; Purpose; Text[50])
        {
        }
        field(90; "External Document No"; Code[20])
        {
        }
        field(91; RecordId; RecordID)
        {
        }
        field(92; "Creation Doc No"; Code[20])
        {
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions
            end;
        }
        field(481; "No. Of Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //    IF (Status=Status::Approved) OR (Status=Status::Posted) OR (Status=Status::"Pending Approval")THEN
        Error('You Cannot Delete this record its status is not Pending');
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            GenLedgerSetup.Get;
            if "Payment Type" = "payment type"::Imprest then begin
                TestNoSeries;
                //NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series",0D,"No.","No. Series");
                NoSeriesMgt.InitSeries(GenLedgerSetup."Claim Nos", xRec."No. Series", 0D, "No.", "No. Series");
            end
        end;

        /*
        UserTemplate.RESET;
        UserTemplate.SETRANGE(UserTemplate.UserID,USERID);
        IF UserTemplate.FINDFIRST THEN
          BEGIN
            "Paying Bank Account":=UserTemplate."Default Payment Bank";
            VALIDATE("Paying Bank Account");
          END;
           */

        Date := Today;
        Cashier := UserId;
        Validate(Cashier);

        //
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Other Advance Staff Account");
            "Account Type" := "account type"::Customer;
            "Account No." := UserSetup."Other Advance Staff Account";
            Validate("Account No.");
        end
        else
            Error('User must be setup under UserSetup Other Advance Staff Account and their respective Account Entered');
        //InsertRecID;

    end;

    trigger OnModify()
    begin
        if Status = Status::Pending then
            UpdateHeaderToLine;

        /* IF (Status=Status::Approved) OR (Status=Status::Posted)OR (Status=Status::"Pending Approval") THEN
            ERROR('You Cannot Modify this record its status is not Pending');*/

    end;

    var
        CStatus: Code[20];
        PVUsers: Record "CshMgt PV Steps Users";
        UserTemplate: Record "Cash Office User Template";
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;
        FA: Record "Fixed Asset";
        BankAcc: Record "Bank Account";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenLedgerSetup: Record "Funds General Setup";
        RecPayTypes: Record "Receipts and Payment Types";
        CashierLinks: Record "Cashier Link";
        GLAccount: Record "G/L Account";
        EntryNo: Integer;
        SingleMonth: Boolean;
        DateFrom: Date;
        DateTo: Date;
        Budget: Decimal;
        CurrMonth: Code[10];
        CurrYR: Code[10];
        BudgDate: Text[30];
        BudgetDate: Date;
        YrBudget: Decimal;
        BudgetDateTo: Date;
        BudgetAvailable: Decimal;
        GenLedSetup: Record "General Ledger Setup";
        "Total Budget": Decimal;
        CommittedAmount: Decimal;
        MonthBudget: Decimal;
        Expenses: Decimal;
        Header: Text[250];
        "Date From": Text[30];
        "Date To": Text[30];
        LastDay: Date;
        TotAmt: Decimal;
        DimVal: Record "Dimension Value";
        PVSteps: Record "CshMgt PV Process Road";
        RespCenter: Record "Responsibility Center BR";
        UserMgt: Codeunit "User Setup Management BR";
        Text001: label 'Your identification is set up to process from %1 %2 only.';
        Pline: Record "Imprest Lines";
        CurrExchRate: Record "Currency Exchange Rate";
        ImpLines: Record "Imprest Lines";
        UserSetup: Record "User Setup";
        DimMgt: Codeunit DimensionManagement;


    procedure UpdateHeaderToLine()
    var
        PayLine: Record "Imprest Lines";
    begin
        PayLine.Reset;
        PayLine.SetRange(PayLine.No, "No.");
        if PayLine.Find('-') then begin
            repeat
                PayLine."Imprest Holder" := "Account No.";
                PayLine."Global Dimension 1 Code" := "Global Dimension 1 Code";
                PayLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                PayLine."Shortcut Dimension 3 Code" := "Shortcut Dimension 3 Code";
                PayLine."Shortcut Dimension 4 Code" := "Shortcut Dimension 4 Code";
                PayLine."Currency Code" := "Currency Code";
                PayLine."Currency Factor" := "Currency Factor";
                PayLine.Validate("Currency Factor");
                PayLine.Modify;
            until PayLine.Next = 0;
        end;
    end;

    local procedure UpdateCurrencyFactor()
    var
        CurrencyDate: Date;
    begin
        if "Currency Code" <> '' then begin
            CurrencyDate := Date;
            "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
        end else
            "Currency Factor" := 0;
    end;


    procedure ImpLinesExist(): Boolean
    begin
        ImpLines.Reset;
        ImpLines.SetRange(No, "No.");
        exit(ImpLines.FindFirst);
    end;


    procedure InsertRecID()
    var
        RecRef: RecordRef;
        RecID: RecordID;
    begin
        RecRef.Open(Database::"Staff Claims Header");
        RecRef.FindLast;
        RecordId := RecRef.RecordId;
        //RecRef := RecID.GETRECORD;
    end;

    local procedure TestNoSeries(): Boolean
    begin
        GenLedgerSetup.TestField(GenLedgerSetup."Claim Nos");
    end;

    local procedure GetNoSeriesCode(): Code[10]
    var
        NoSrsRel: Record "No. Series Relationship";
        NoSeriesCode: Code[20];
    begin
        NoSeriesCode := GenLedgerSetup."Claim Nos";
        /*
        NoSrsRel.SETRANGE(NoSrsRel.Code,NoSeriesCode);
        //NoSrsRel.SETRANGE(NoSrsRel."Responsibility Center","Responsibility Center");
        
        IF NoSrsRel.FINDFIRST THEN
        EXIT(NoSrsRel."Series Code")
        ELSE
        EXIT(NoSeriesCode);
        
        IF NoSrsRel.FINDSET THEN BEGIN
          IF PAGE.RUNMODAL(458,NoSrsRel,NoSrsRel."Series Code") = ACTION::LookupOK THEN
          EXIT(NoSrsRel."Series Code")
        END
        ELSE
        EXIT(NoSeriesCode);
        */
        exit(GetNoSeriesRelCode(NoSeriesCode));

    end;


    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', 'Staff Claim', "No."));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;


    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
    end;


    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;


    procedure GetNoSeriesRelCode(NoSeriesCode: Code[20]): Code[10]
    var
        GenLedgerSetup: Record "General Ledger Setup";
        RespCenter: Record "Responsibility Center BR";
        DimMgt: Codeunit DimensionManagement;
        NoSrsRel: Record "No. Series Relationship";
    begin
        //EXIT(GetNoSeriesRelCode(NoSeriesCode));
        /*
        GenLedgerSetup.GET;
        CASE GenLedgerSetup."Base No. Series" OF
          GenLedgerSetup."Base No. Series"::"1":
           BEGIN
            NoSrsRel.RESET;
            NoSrsRel.SETRANGE(Code,NoSeriesCode);
            NoSrsRel.SETRANGE("Series Filter","Responsibility Center");
            IF NoSrsRel.FINDFIRST THEN
              EXIT(NoSrsRel."Series Code")
           END;
          GenLedgerSetup."Base No. Series"::"2":
           BEGIN
            NoSrsRel.RESET;
            NoSrsRel.SETRANGE(Code,NoSeriesCode);
            NoSrsRel.SETRANGE("Series Filter","Global Dimension 1 Code");
            IF NoSrsRel.FINDFIRST THEN
              EXIT(NoSrsRel."Series Code")
           END;
          GenLedgerSetup."Base No. Series"::"3":
           BEGIN
            NoSrsRel.RESET;
            NoSrsRel.SETRANGE(Code,NoSeriesCode);
            NoSrsRel.SETRANGE("Series Filter","Shortcut Dimension 2 Code");
            IF NoSrsRel.FINDFIRST THEN
              EXIT(NoSrsRel."Series Code")
           END;
          GenLedgerSetup."Base No. Series"::"4":
           BEGIN
            NoSrsRel.RESET;
            NoSrsRel.SETRANGE(Code,NoSeriesCode);
            NoSrsRel.SETRANGE("Series Filter","Shortcut Dimension 3 Code");
            IF NoSrsRel.FINDFIRST THEN
              EXIT(NoSrsRel."Series Code")
           END;
          GenLedgerSetup."Base No. Series"::"5":
           BEGIN
            NoSrsRel.RESET;
            NoSrsRel.SETRANGE(Code,NoSeriesCode);
            NoSrsRel.SETRANGE("Series Filter","Shortcut Dimension 4 Code");
            IF NoSrsRel.FINDFIRST THEN
              EXIT(NoSrsRel."Series Code")
           END;
          ELSE EXIT(NoSeriesCode);
        END;
        */

    end;
}

