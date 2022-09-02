#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516112 "Payments Header"
{
    DrillDownPageID = "Payment Voucher List";
    LookupPageID = "Payment Voucher List";

    fields
    {
        field(1;"No.";Code[20])
        {
            Description = 'Stores the reference of the payment voucher in the database';
            NotBlank = false;
        }
        field(2;Date;Date)
        {
            Description = 'Stores the date when the payment voucher was inserted into the system';
            Editable = false;

            trigger OnValidate()
            begin
                if PayLinesExist then begin
                Error('You first need to delete the existing Payment lines before changing the Currency Code'
                );
                end else begin
                   "Paying Bank Account":='';
                   Validate("Paying Bank Account");
                end;
                if  "Currency Code" = xRec."Currency Code" then
                  UpdateCurrencyFactor;

                if "Currency Code" <> xRec."Currency Code" then begin
                    UpdateCurrencyFactor;
                  end else
                    if "Currency Code" <> '' then
                      UpdateCurrencyFactor;

                //Update Payment Lines
                UpdateLines();
            end;
        }
        field(3;"Currency Factor";Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0:15;
            Editable = false;
            MinValue = 0;
        }
        field(4;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            Enabled = true;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                /*
                IF PayLinesExist THEN BEGIN
                ERROR('You first need to delete the existing Payment lines before changing the Currency Code'
                );
                END ELSE BEGIN
                   "Paying Bank Account":='';
                   VALIDATE("Paying Bank Account");
                END;
                IF  "Currency Code" = xRec."Currency Code" THEN
                  UpdateCurrencyFactor;
                
                IF "Currency Code" <> xRec."Currency Code" THEN BEGIN
                    UpdateCurrencyFactor;
                  END ELSE
                    IF "Currency Code" <> '' THEN
                      UpdateCurrencyFactor;
                
                //Update Payment Lines
                UpdateLines();
                */

            end;
        }
        field(9;Payee;Text[100])
        {
            Description = 'Stores the name of the person who received the money';
        }
        field(10;"On Behalf Of";Text[100])
        {
            Description = 'Stores the name of the person on whose behalf the payment voucher was taken';
        }
        field(11;Cashier;Code[50])
        {
            Description = 'Stores the identifier of the cashier in the database';

            trigger OnValidate()
            begin
                  /*
                   UserDept.RESET;
                  UserDept.SETRANGE(UserDept.UserID,Cashier);
                  IF UserDept.FIND('-') THEN
                    //"Global Dimension 1 Code":=UserDept.Department;
                  */

            end;
        }
        field(16;Posted;Boolean)
        {
            Description = 'Stores whether the payment voucher is posted or not';
        }
        field(17;"Date Posted";Date)
        {
            Description = 'Stores the date when the payment voucher was posted';
        }
        field(18;"Time Posted";Time)
        {
            Description = 'Stores the time when the payment voucher was posted';
        }
        field(19;"Posted By";Code[60])
        {
            Description = 'Stores the name of the person who posted the payment voucher';
        }
        field(20;"Total Payment Amount";Decimal)
        {
            CalcFormula = sum("Payment Line".Amount where (No=field("No.")));
            Description = 'Stores the amount of the payment voucher';
            Editable = false;
            FieldClass = FlowField;
        }
        field(28;"Paying Bank Account";Code[20])
        {
            Description = 'Stores the name of the paying bank account in the database';
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin

                BankAcc.Reset;
                "Bank Name":='';
                if BankAcc.Get("Paying Bank Account") then
                  begin
                    if "Pay Mode"="pay mode"::Cash then begin
                      if BankAcc."Bank Type"<>BankAcc."bank type"::Cash then
                         Error('This Payment can only be made against Banks Handling Cash');
                    end;
                    "Bank Name":=BankAcc.Name;
                    //"Currency Code":=BankAcc."Currency Code";
                    // VALIDATE("Currency Code");
                  end;
                PLine.Reset;
                PLine.SetRange(PLine.No,"No.");
                PLine.SetRange(PLine."Account Type",PLine."account type"::"Bank Account");
                PLine.SetRange(PLine."Account No.","Paying Bank Account");
                if PLine.FindFirst then
                   Error(Text002);
            end;
        }
        field(30;"Global Dimension 1 Code";Code[25])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.",1);
                DimVal.SetRange(DimVal.Code,"Global Dimension 1 Code");
                 if DimVal.Find('-') then
                    "Function Name":=DimVal.Name;
                 UpdateLines;
            end;
        }
        field(35;Status;Option)
        {
            Description = 'Stores the status of the record in the database';
            OptionMembers = Pending,"1st Approval","2nd Approval","Cheque Printing",Posted,Cancelled,Checking,VoteBook,"Pending Approval",Approved;
        }
        field(38;"Payment Type";Option)
        {
            OptionCaption = 'Normal,Petty Cash,Tata';
            OptionMembers = Normal,"Petty Cash",Tata;
        }
        field(56;"Shortcut Dimension 2 Code";Code[25])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code,"Shortcut Dimension 2 Code");
                 if DimVal.Find('-') then
                    "Budget Center Name":=DimVal.Name ;
                UpdateLines
            end;
        }
        field(57;"Function Name";Text[100])
        {
            Description = 'Stores the name of the function in the database';
        }
        field(58;"Budget Center Name";Text[100])
        {
            Description = 'Stores the name of the budget center in the database';
        }
        field(59;"Bank Name";Text[100])
        {
            Description = 'Stores the description of the paying bank account in the database';
        }
        field(60;"No. Series";Code[20])
        {
            Description = 'Stores the number series in the database';
        }
        field(61;Select;Boolean)
        {
            Description = 'Enables the user to select a particular record';
        }
        field(62;"Total VAT Amount";Decimal)
        {
            CalcFormula = sum("Payment Line"."VAT Amount" where (No=field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(63;"Total Witholding Tax Amount";Decimal)
        {
            CalcFormula = sum("Payment Line"."Withholding Tax Amount" where (No=field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(64;"Total Net Amount";Decimal)
        {
            CalcFormula = sum("Payment Line"."Net Amount" where (No=field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(65;"Current Status";Code[20])
        {
            Description = 'Stores the current status of the payment voucher in the database';
        }
        field(66;"Cheque No.";Code[20])
        {

            trigger OnValidate()
            begin
                if StrLen("Cheque No.") < 6 then
                  Error('Cheque No. Can not be less than 6 Characters');
            end;
        }
        field(67;"Pay Mode";Option)
        {
            OptionMembers = " ",Cash,Cheque,EFT,"Letter of Credit",FOSA,"Custom 3","Custom 4","Custom 5";
        }
        field(68;"Payment Release Date";Date)
        {

            trigger OnValidate()
            begin
                  //Changed to ensure Release date is not less than the Date entered
                  if "Payment Release Date"<Date then
                     Error('The Payment Release Date cannot be lesser than the Document Date');
            end;
        }
        field(69;"No. Printed";Integer)
        {
        }
        field(70;"VAT Base Amount";Decimal)
        {
        }
        field(71;"Exchange Rate";Decimal)
        {
        }
        field(72;"Currency Reciprical";Decimal)
        {
        }
        field(73;"Current Source A/C Bal.";Decimal)
        {
        }
        field(74;"Cancellation Remarks";Text[250])
        {
        }
        field(75;"Register Number";Integer)
        {
        }
        field(76;"From Entry No.";Integer)
        {
        }
        field(77;"To Entry No.";Integer)
        {
        }
        field(78;"Invoice Currency Code";Code[10])
        {
            Caption = 'Invoice Currency Code';
            Editable = true;
            TableRelation = Currency;
        }
        field(79;"Total Payment Amount LCY";Decimal)
        {
            CalcFormula = sum("Payment Line"."NetAmount LCY" where (No=field("No.")));
            FieldClass = FlowField;
        }
        field(80;"Document Type";Option)
        {
            OptionMembers = "Payment Voucher","Petty Cash";
        }
        field(81;"Shortcut Dimension 3 Code";Code[25])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(3));

            trigger OnValidate()
            begin
                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code,"Shortcut Dimension 3 Code");
                 if DimVal.Find('-') then
                    Dim3:=DimVal.Name
            end;
        }
        field(82;"Shortcut Dimension 4 Code";Code[25])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(4));

            trigger OnValidate()
            begin
                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code,"Shortcut Dimension 4 Code");
                 if DimVal.Find('-') then
                    Dim4:=DimVal.Name
            end;
        }
        field(83;Dim3;Text[250])
        {
        }
        field(84;Dim4;Text[250])
        {
        }
        field(85;"Responsibility Center";Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin
                
                TestField(Status,Status::Pending);
                
                if PayLinesExist then begin
                  Error('You first need to delete the existing Payment lines before changing the Responsibility Center');
                end else begin
                  "Currency Code":='';
                  Validate("Currency Code");
                  "Paying Bank Account":='';
                  Validate("Paying Bank Account");
                end;
                
                
                if not UserMgt.CheckRespCenter(1,"Responsibility Center") then
                  Error(
                    Text001,
                    RespCenter.TableCaption,UserMgt.GetPurchasesFilter);
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
        field(86;"Cheque Type";Option)
        {
            OptionMembers = " ","Computer Check","Manual Check";
        }
        field(87;"Total Retention Amount";Decimal)
        {
            CalcFormula = sum("Payment Line"."Retention  Amount" where (No=field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(88;"Payment Narration";Text[50])
        {
        }
        field(89;"Paying Type";Option)
        {
            OptionCaption = ' ,Vendor,Bank';
            OptionMembers = " ",Vendor,Bank;
        }
        field(90;"Paying Vendor Account";Code[20])
        {
            TableRelation = Vendor."No." where ("Account Type"=const('SAVINGS'));

            trigger OnValidate()
            begin
                Vendor.Reset;
                "Bank Name":='';
                if Vendor.Get("Paying Vendor Account") then
                  begin
                  Payee:=Vendor.Name;
                  end;
            end;
        }
        field(91;"Fosa Bank Account";Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(92;"Expense Account";Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(93;"Expense Type";Option)
        {
            OptionCaption = ' ,Normal,Director,Member';
            OptionMembers = " ",Normal,Director,Member;
        }
        field(94;"Refund Charge";Decimal)
        {
            CalcFormula = sum("Payment Line"."Refund Charge" where (No=field("No.")));
            FieldClass = FlowField;
        }
        field(95;"Net Amount";Decimal)
        {
            CalcFormula = sum("Payment Line"."Net Amount" where (No=field("No.")));
            FieldClass = FlowField;
        }
        field(96;"WithHolding Tax Amount";Decimal)
        {
            CalcFormula = sum("Payment Line"."Withholding Tax Amount" where (No=field("No.")));
            FieldClass = FlowField;
        }
        field(97;"Global Dimension 2 Code";Code[20])
        {
        }
        field(98;"Bank Account Name";Text[50])
        {
        }
        field(99;"Invoice Number";Code[25])
        {
        }
        field(100;"Board Approval Status";Option)
        {
            OptionCaption = 'Approved,Rejected';
            OptionMembers = ,Approved,Rejected;
        }
        field(101;"Board Approval Comment";Text[100])
        {
        }
        field(102;"Board Approved By";Code[60])
        {
        }
        field(103;"Approval Status";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Open,released,rejected,pending';
            OptionMembers = " ",Open,released,rejected,pending;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
            Clustered = true;
        }
        key(Key2;"Responsibility Center")
        {
        }
        key(Key3;"Cheque No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
          //  IF (Status=Status::Approved) OR (Status=Status::Posted) OR (Status=Status::"Pending Approval")THEN
            //   ERROR('You Cannot Delete this record');
    end;

    trigger OnInsert()
    begin

        if "No." = '' then begin
          GenLedgerSetup.Get;
          if "Payment Type"="payment type"::Normal then
            begin
             GenLedgerSetup.TestField(GenLedgerSetup."Payment Voucher Nos");
             NoSeriesMgt.InitSeries(GenLedgerSetup."Payment Voucher Nos",xRec."No. Series",0D,"No.","No. Series");
            end
          else  if "Payment Type"="payment type"::Tata then
            begin
        //      GenLedgerSetup.TESTFIELD(GenLedgerSetup."Tata paymentV Nos");
             // NoSeriesMgt.InitSeries(GenLedgerSetup."Tata paymentV Nos",xRec."No. Series",0D,"No.","No. Series");
            end;
        end;

        UserTemplate.Reset;
        UserTemplate.SetRange(UserTemplate.UserID,UserId);
        if UserTemplate.FindFirst then
          begin
          if "Payment Type"="payment type"::"Petty Cash" then begin
           //UserTemplate.TESTFIELD(UserTemplate."Default Petty Cash Bank");
           //"Paying Bank Account":=UserTemplate."Default Petty Cash Bank";
          end else begin
            "Paying Bank Account":=UserTemplate."Default Payment Bank";
          end;
            Validate("Paying Bank Account");
          end;

        Date:=Today;
        "Payment Release Date":=Today;
        Cashier:=UserId;
        Validate(Cashier);
    end;

    trigger OnModify()
    begin
        if Status=Status::Pending then
          UpdateLines();
        
            /*IF (Status=Status::Approved) OR (Status=Status::Posted) THEN
               ERROR('You Cannot modify an already approved/posted document');*/

    end;

    var
        CStatus: Code[20];
        PVUsers: Record "CshMgt PV Steps Users";
        UserTemplate: Record "Funds User Setup";
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
        PLine: Record "Payment Line";
        RespCenter: Record "Responsibility Center BR";
        UserMgt: Codeunit "User Setup Management BR";
        Text001: label 'Your identification is set up to process from %1 %2 only.';
        CurrExchRate: Record "Currency Exchange Rate";
        PayLine: Record "Payment Line";
        Text002: label 'There is an Account number on the  payment lines the same as Paying Bank Account you are trying to select.';
        Vendor: Record Vendor;
        Gen: Record "Sacco General Set-Up";

    local procedure UpdateCurrencyFactor()
    var
        CurrencyDate: Date;
    begin
        if "Currency Code" <> '' then begin
          CurrencyDate := Date;
          "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate,"Currency Code");
        end else
          "Currency Factor" := 0;
    end;


    procedure UpdateLines()
    begin
        PLine.Reset;
        PLine.SetRange(PLine.No,"No.");
        if PLine.FindFirst then
          begin
            repeat
              PLine."Global Dimension 1 Code":="Global Dimension 1 Code";
              PLine."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
              PLine."Shortcut Dimension 3 Code":="Shortcut Dimension 3 Code";
              PLine."Shortcut Dimension 4 Code":="Shortcut Dimension 4 Code";
              PLine."Currency Factor":="Currency Factor";
              PLine."Paying Bank Account":="Paying Bank Account";
              PayLine."Payment Type":="Payment Type";
              PLine.Validate("Currency Factor");
              PLine.Modify;
            until PLine.Next=0;
          end;
    end;


    procedure PayLinesExist(): Boolean
    begin
        PayLine.Reset;
        PayLine.SetRange("Payment Type","Payment Type");
        PayLine.SetRange(No,"No.");
        exit(PayLine.FindFirst);
    end;
}

