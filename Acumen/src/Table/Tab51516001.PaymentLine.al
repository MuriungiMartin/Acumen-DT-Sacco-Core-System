#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516001 "Payment Line."
{
    // DrillDownPageID = UnknownPage53936;
    // LookupPageID = UnknownPage53936;

    fields
    {
        field(1; No; Code[20])
        {
            NotBlank = true;
            TableRelation = "Payment Header."."No.";

            trigger OnValidate()
            begin

                /*IF No <> xRec.No THEN BEGIN
                  GenLedgerSetup.GET;
                  IF "Payment Type"="Payment Type"::Normal THEN BEGIN
                    NoSeriesMgt.TestManual(GenLedgerSetup."Normal Payments No");
                  END
                  ELSE BEGIN
                    NoSeriesMgt.TestManual(GenLedgerSetup."Petty Cash Payments No");
                  END;
                  "No. Series" := '';
                END;
                */

            end;
        }
        field(2; Date; Date)
        {
        }
        field(3; Type; Code[20])
        {
            NotBlank = true;
            TableRelation = "Receipts and Payment Types".Code where(Type = filter(Payment),
                                                                     Blocked = const(false));

            trigger OnValidate()
            var
                TarrifCode: Record "Tariff Codes";
            begin

                "Account No." := '';
                "Account Name" := '';
                Remarks := '';
                RecPayTypes.Reset;
                RecPayTypes.SetRange(RecPayTypes.Code, Type);
                RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Payment);

                if RecPayTypes.Find('-') then begin
                    Grouping := RecPayTypes."Default Grouping";
                    "Require Surrender" := RecPayTypes."Pending Voucher";
                    "Payment Reference" := RecPayTypes."Payment Reference";
                    "Budgetary Control A/C" := RecPayTypes."Direct Expense";

                    if RecPayTypes."VAT Chargeable" = RecPayTypes."vat chargeable"::Yes then begin
                        "VAT Code" := RecPayTypes."VAT Code";
                        if TarrifCode.Get("VAT Code") then
                            "VAT Rate" := TarrifCode.Percentage;
                    end;
                    if RecPayTypes."Withholding Tax Chargeable" = RecPayTypes."withholding tax chargeable"::Yes then begin
                        "Withholding Tax Code" := RecPayTypes."Withholding Tax Code";
                        if TarrifCode.Get("Withholding Tax Code") then
                            "W/Tax Rate" := TarrifCode.Percentage;

                    end;

                    if RecPayTypes."Calculate Retention" = RecPayTypes."calculate retention"::Yes then begin
                        "Retention Code" := RecPayTypes."Retention Code";
                        if TarrifCode.Get("Retention Code") then
                            "Retention Rate" := TarrifCode.Percentage;

                    end;

                    //Added for VAT 6%
                    if RecPayTypes."VAT Chargeable" = RecPayTypes."vat chargeable"::Yes then begin
                        "VAT Withheld Code" := RecPayTypes."VAT Withheld Code";
                        if TarrifCode.Get("VAT Withheld Code") then
                            "VAT 6% Rate" := TarrifCode.Percentage;
                    end;


                end;

                if RecPayTypes.Find('-') then begin
                    "Account Type" := RecPayTypes."Account Type";
                    Validate("Account Type");
                    "Transaction Name" := RecPayTypes.Description;
                    "Budgetary Control A/C" := RecPayTypes."Direct Expense";
                    if RecPayTypes."Account Type" = RecPayTypes."account type"::"G/L Account" then begin
                        if RecPayTypes."G/L Account" <> '' then
                            RecPayTypes.TestField(RecPayTypes."G/L Account");
                        "Account No." := RecPayTypes."G/L Account";
                        Validate("Account No.");
                    end;

                    //Banks
                    if RecPayTypes."Account Type" = RecPayTypes."account type"::"Bank Account" then begin
                        "Account No." := RecPayTypes."Bank Account";
                        Validate("Account No.");
                    end;
                end;

                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    Date := PHead.Date;
                    //PHead.TESTFIELD("Responsibility Center");
                    "Global Dimension 1 Code" := PHead."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := PHead."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := PHead."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := PHead."Shortcut Dimension 4 Code";
                    "Currency Code" := PHead."Currency Code";
                    "Currency Factor" := PHead."Currency Factor";
                    "Payment Type" := PHead."Payment Type";
                end;
            end;
        }
        field(4; "Pay Mode"; Option)
        {
            OptionMembers = " ",Cash,Cheque,EFT,"Custom 2","Custom 3","Custom 4","Custom 5";
        }
        field(5; "Cheque No"; Code[20])
        {
        }
        field(6; "Cheque Date"; Date)
        {
        }
        field(7; "Cheque Type"; Code[20])
        {
        }
        field(8; "Bank Code"; Code[20])
        {
        }
        field(9; "Received From"; Text[100])
        {
        }
        field(10; "On Behalf Of"; Text[100])
        {
        }
        field(11; Cashier; Code[50])
        {
        }
        field(12; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,Staff,Noner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Staff,Noner;

            trigger OnValidate()
            var
                PayLines: Record "Payment Line.";
            begin
                /*
                   PayLines.RESET;
                   PayLines.SETRANGE(PayLines."Account Type",PayLines."Account Type"::Vendor);
                   PayLines.SETRANGE(PayLines.No,No);
                   IF PayLines.FIND('-') THEN
                      ERROR('There is already another existing Payment to a Vendor in this document');
                
                   PayLines.RESET;
                   PayLines.SETRANGE(PayLines."Account Type",PayLines."Account Type"::Customer);
                   PayLines.SETRANGE(PayLines.No,No);
                   IF PayLines.FIND('-') THEN
                      ERROR('There is already another existing Payment to a Customer in this document');
                
                   IF ("Account Type"= "Account Type"::Vendor) OR  ("Account Type"= "Account Type"::Customer) THEN  BEGIN
                      IF PayLinesExist THEN
                      ERROR('There is already another existing Line for this document');
                   END;
                */

            end;
        }
        field(13; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"."No." where("Account Type" = filter(Posting))
            else
            if ("Account Type" = const(Customer)) Customer."No."
            else
            if ("Account Type" = const(Vendor)) Vendor."No."
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"."No."
            else
            if ("Account Type" = const(Member)) "Member Register"."No.";

            trigger OnValidate()
            var
                Text0001: label 'The Account number CANNOT be the same as the Paying Bank Account No.';
            begin
                PH.Reset;
                PH.Get(No);
                "Account Name" := '';
                RecPayTypes.Reset;
                RecPayTypes.SetRange(RecPayTypes.Code, Type);
                RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Payment);

                if "Account Type" in ["account type"::"G/L Account", "account type"::Customer, "account type"::Vendor, "account type"::"IC Partner",
                "account type"::"Bank Account"]
                then
                    case "Account Type" of
                        "account type"::"G/L Account":
                            begin
                                if "Account No." <> '' then
                                    GLAcc.Reset;
                                GLAcc.SetRange(GLAcc."No.", "Account No.");
                                if GLAcc.FindFirst then begin
                                    "Account Name" := GLAcc.Name;
                                    Remarks := GLAcc.Name;
                                    PH.TestField("Global Dimension 1 Code");
                                    PH.TestField("Global Dimension 2 Code");
                                    //"Global Dimension 1 Code":='';
                                    //"Shortcut Dimension 2 Code":='';
                                end;
                            end;
                        "account type"::Customer:
                            begin
                                Cust.Reset;
                                Cust.SetRange(Cust."No.", "Account No.");
                                if Cust.FindFirst then begin
                                    "Account Name" := Cust.Name;
                                    Remarks := Cust.Name;
                                    if "Global Dimension 1 Code" = '' then begin
                                        "Global Dimension 1 Code" := Cust."Global Dimension 1 Code";
                                    end;
                                end;
                            end;
                        "account type"::Vendor:
                            begin
                                Vend.Reset;
                                Vend.SetRange(Vend."No.", "Account No.");
                                if Vend.FindFirst then begin
                                    "Account Name" := Vend.Name;
                                    Remarks := Vend.Name;
                                    if "Global Dimension 1 Code" = '' then begin
                                        "Global Dimension 1 Code" := Vend."Global Dimension 1 Code";
                                    end;
                                end;
                                if PH.Payee = '' then begin
                                    PH.Payee := "Account Name";
                                    PH.Modify;
                                end;
                                if PH."On Behalf Of" = '' then begin
                                    PH."On Behalf Of" := "Account Name";
                                    PH.Modify;
                                end;
                            end;
                        "account type"::"Bank Account":
                            begin
                                if BankAcc.Get("Account No.") then
                                    "Account Name" := BankAcc.Name;
                                PH.TestField("Bank Account");
                                if PH."Bank Account" = "Account No." then
                                    Error(Text0001);
                                if "Global Dimension 1 Code" = '' then begin
                                    "Global Dimension 1 Code" := BankAcc."Global Dimension 1 Code";
                                end;
                            end;
                        "account type"::"IC Partner":
                            begin
                                ICPartner.Reset;
                                ICPartner.Get("Account No.");
                                "Account Name" := ICPartner.Name;
                            end;
                    end;
                //Set the application to Invoice if Account type is vendor
                if "Account Type" = "account type"::Vendor then
                    "Applies-to Doc. Type" := "applies-to doc. type"::Invoice;
            end;
        }
        field(14; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(15; "Account Name"; Text[150])
        {
        }
        field(16; Posted; Boolean)
        {
        }
        field(17; "Date Posted"; Date)
        {
        }
        field(18; "Time Posted"; Time)
        {
        }
        field(19; "Posted By"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(20; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                CalculateTax();
            end;
        }
        field(21; Remarks; Text[250])
        {
        }
        field(22; "Transaction Name"; Text[100])
        {
        }
        field(23; "VAT Code"; Code[20])
        {
            TableRelation = "Tariff Codes".Code where(Type = const(VAT));

            trigger OnValidate()
            begin
                if TariffCode.Get("VAT Code") then
                    "VAT Rate" := TariffCode.Percentage
                else
                    "VAT Rate" := 0;
                CalculateTax();
            end;
        }
        field(24; "Withholding Tax Code"; Code[20])
        {
            TableRelation = "Tariff Codes".Code where(Type = const("W/Tax"));

            trigger OnValidate()
            begin
                if TariffCode.Get("Withholding Tax Code") then
                    "W/Tax Rate" := TariffCode.Percentage
                else
                    "W/Tax Rate" := 0;

                CalculateTax();
            end;
        }
        field(25; "VAT Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                //Should not be entered until VAT Code is entered
                TestField("VAT Code");
                "Net Amount" := Amount - ("VAT Amount" + "Withholding Tax Amount");
                Validate("Net Amount");
            end;
        }
        field(26; "Withholding Tax Amount"; Decimal)
        {

            trigger OnLookup()
            begin
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                     (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                        Error('You Cannot modify documents that are approved/posted/Send for Approval');
                end;
            end;

            trigger OnValidate()
            begin
                //Should not be entered until W/Tax code is entered
                TestField("Withholding Tax Code");
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                     (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                        Error('You Cannot modify documents that are approved/posted/Send for Approval');
                end;

                "Net Amount" := Amount - ("Withholding Tax Amount" + "VAT Amount");
                Validate("Net Amount");
            end;
        }
        field(27; "Net Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Currency Factor" <> 0 then
                    "NetAmount LCY" := "Net Amount" / "Currency Factor"
                else
                    "NetAmount LCY" := "Net Amount";
            end;
        }
        field(28; "Paying Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(29; Payee; Text[100])
        {
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));

            trigger OnValidate()
            begin

                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 1);
                DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
                if DimVal.Find('-') then
                    "Function Name" := DimVal.Name;

                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(31; "Branch Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin

                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Branch Code");
                if DimVal.Find('-') then
                    "Budget Center Name" := DimVal.Name;

                ValidateShortcutDimCode(2, "Branch Code");
            end;
        }
        field(32; "PO/INV No"; Code[20])
        {
        }
        field(33; "Bank Account No"; Code[20])
        {
        }
        field(34; "Cashier Bank Account"; Code[20])
        {
        }
        field(35; Status; Option)
        {
            OptionMembers = Pending,"1st Approval","2nd Approval","Cheque Printing",Posted,Cancelled,Checking,VoteBook;
        }
        field(36; Select; Boolean)
        {
        }
        field(37; Grouping; Code[20])
        {
            TableRelation = "Vendor Posting Group".Code;
        }
        field(38; "Payment Type"; Option)
        {
            OptionMembers = Normal,"Petty Cash";
        }
        field(39; "Bank Type"; Option)
        {
            OptionMembers = Normal,"Petty Cash";
        }
        field(40; "PV Type"; Option)
        {
            OptionMembers = Normal,Other;
        }
        field(41; "Apply to"; Code[20])
        {
            TableRelation = "Vendor Ledger Entry"."Vendor No." where("Vendor No." = field("Account No."));
        }
        field(42; "Apply to ID"; Code[20])
        {
        }
        field(43; "No of Units"; Decimal)
        {
        }
        field(44; "Surrender Date"; Date)
        {
        }
        field(45; Surrendered; Boolean)
        {
        }
        field(46; "Surrender Doc. No"; Code[20])
        {
        }
        field(47; "Vote Book"; Code[10])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                /*
                          IF Amount<=0 THEN
                        ERROR('Please enter the Amount');
                
                       //Confirm the Amount to be issued doesnot exceed the budget and amount Committed
                        EVALUATE(CurrMonth,FORMAT(DATE2DMY(Date,2)));
                        EVALUATE(CurrYR,FORMAT(DATE2DMY(Date,3)));
                        EVALUATE(BudgetDate,FORMAT('01'+'/'+CurrMonth+'/'+CurrYR));
                
                          //Get the last day of the month
                
                          LastDay:=CALCDATE('1M', BudgetDate);
                          LastDay:=CALCDATE('-1D',LastDay);
                
                
                        //Get Budget for the G/L
                      IF GenLedSetup.GET THEN BEGIN
                        GLAccount.SETFILTER(GLAccount."Budget Filter",GenLedSetup."Current Budget");
                        GLAccount.SETRANGE(GLAccount."No.","Vote Book");
                        GLAccount.CALCFIELDS(GLAccount."Budgeted Amount",GLAccount."Net Change");
                        {Get the exact Monthly Budget}
                        //Start from first date of the budget.//BudgetDate
                        GLAccount.SETRANGE(GLAccount."Date Filter",GenLedSetup."Current Budget Start Date",LastDay);
                
                        IF GLAccount.FIND('-') THEN BEGIN
                         GLAccount.CALCFIELDS(GLAccount."Budgeted Amount",GLAccount."Net Change");
                         MonthBudget:=GLAccount."Budgeted Amount";
                         Expenses:=GLAccount."Net Change";
                         BudgetAvailable:=GLAccount."Budgeted Amount"-GLAccount."Net Change";
                         "Total Allocation":=MonthBudget;
                         "Total Expenditure":=Expenses;
                         END;
                
                
                     END;
                
                     CommitmentEntries.RESET;
                     CommitmentEntries.SETCURRENTKEY(CommitmentEntries.Account);
                     CommitmentEntries.SETRANGE(CommitmentEntries.Account,"Vote Book");
                     CommitmentEntries.SETRANGE(CommitmentEntries."Commitment Date",GenLedSetup."Current Budget Start Date",LastDay);
                     CommitmentEntries.CALCSUMS(CommitmentEntries."Committed Amount");
                     CommittedAmount:=CommitmentEntries."Committed Amount";
                
                     "Total Commitments":=CommittedAmount;
                     Balance:=BudgetAvailable-CommittedAmount;
                     "Balance Less this Entry":=BudgetAvailable-CommittedAmount-Amount;
                     MODIFY;
                     {
                     IF CommittedAmount+Amount>BudgetAvailable THEN
                        ERROR('%1,%2,%3,%4','You have Exceeded Budget for G/L Account No',"Vote Book",'by',
                        ABS(BudgetAvailable-(CommittedAmount+Amount)));
                      }
                     //End of Confirming whether Budget Allows Posting
                */

            end;
        }
        field(48; "Total Allocation"; Decimal)
        {
        }
        field(49; "Total Expenditure"; Decimal)
        {
        }
        field(50; "Total Commitments"; Decimal)
        {
        }
        field(51; Balance; Decimal)
        {
        }
        field(52; "Balance Less this Entry"; Decimal)
        {
        }
        field(53; "Applicant Designation"; Text[100])
        {
        }
        field(54; "Petty Cash"; Boolean)
        {
        }
        field(55; "Supplier Invoice No."; Code[30])
        {
        }
        field(56; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(57; "Imprest Request No"; Code[20])
        {
            TableRelation = "Payments-Users" where(Posted = const(false));

            trigger OnValidate()
            begin

                /*
                          TotAmt:=0;
                     //On Delete/Change of Request No. then Clear from Imprest Details
                     IF ("Imprest Request No"='') OR ("Imprest Request No"<>xRec."Imprest Request No") THEN
                        LoadImprestDetails.RESET;
                        LoadImprestDetails.SETRANGE(LoadImprestDetails.No,No);
                        IF LoadImprestDetails.FIND('-') THEN BEGIN
                           LoadImprestDetails.DELETEALL;
                           Amount:=TotAmt;
                           "Net Amount":=Amount;
                           MODIFY;
                
                        END;
                     //New Imprest Details
                     ImprestReqDet.RESET;
                     ImprestReqDet.SETRANGE(ImprestReqDet.No,"Imprest Request No");
                     IF ImprestReqDet.FIND('-') THEN BEGIN
                     REPEAT
                         LoadImprestDetails.INIT;
                         LoadImprestDetails.No:=No;
                         LoadImprestDetails.Date:=ImprestReqDet."Account No:";
                         LoadImprestDetails.Type:=ImprestReqDet."Account Name";
                         LoadImprestDetails."Pay Mode":=ImprestReqDet.Amount;
                         LoadImprestDetails."Cheque No":=ImprestReqDet."Due Date";
                         LoadImprestDetails."Cheque Date":=ImprestReqDet."Imprest Holder";
                         LoadImprestDetails.INSERT;
                         TotAmt:=TotAmt+ImprestReqDet.Amount;
                     UNTIL ImprestReqDet.NEXT=0;
                         Amount:=TotAmt;
                         "Account No.":=ImprestReqDet."Imprest Holder";
                         "Net Amount":=Amount;
                         MODIFY;
                     END;
                {
                       //ImprestDetForm.GETRECORD(LoadImprestDetails);
                }
                      */

            end;
        }
        field(58; "Batched Imprest Tot"; Decimal)
        {
            FieldClass = Normal;
        }
        field(59; "Function Name"; Text[100])
        {
        }
        field(60; "Budget Center Name"; Text[100])
        {
        }
        field(61; "Farmer Purchase No"; Code[20])
        {
        }
        field(62; "Transporter Ananlysis No"; Code[20])
        {
        }
        field(63; "User ID"; Code[30])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(64; "Journal Template"; Code[20])
        {
        }
        field(65; "Journal Batch"; Code[20])
        {
        }
        field(66; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(67; "Require Surrender"; Boolean)
        {
            Editable = false;
        }
        field(68; "Commited Ammount"; Decimal)
        {
            FieldClass = FlowFilter;
            TableRelation = "FOSA Advances"."ID No";
        }
        field(69; "Select to Surrender"; Boolean)
        {
        }
        field(71; "Payment Reference"; Option)
        {
            OptionMembers = Normal,"Farmer Purchase";
        }
        field(72; "ID Number"; Code[8])
        {
        }
        field(73; "VAT Rate"; Decimal)
        {

            trigger OnValidate()
            begin
                /*"VAT Amount":=(Amount * 100);
                "VAT Amount":=Amount-("VAT Amount"/(100 + "VAT Rate"));*/

            end;
        }
        field(74; "Amount With VAT"; Decimal)
        {
        }
        field(75; "Currency Code"; Code[20])
        {
            TableRelation = Currency.Code;
        }
        field(76; "Exchange Rate"; Decimal)
        {
        }
        field(77; "Currency Reciprical"; Decimal)
        {
        }
        field(78; "VAT Prod. Posting Group"; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "VAT Product Posting Group".Code;
        }
        field(79; "Budgetary Control A/C"; Boolean)
        {
        }
        field(81; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('PRODUCT'));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                if DimVal.Find('-') then
                    "Budget Center Name" := DimVal.Name
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
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                if DimVal.Find('-') then
                    "Budget Center Name" := DimVal.Name
            end;
        }
        field(83; Committed; Boolean)
        {
        }
        field(84; "Currency Factor"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Currency Factor" <> 0 then
                    "NetAmount LCY" := "Net Amount" / "Currency Factor"
                else
                    "NetAmount LCY" := "Net Amount";
            end;
        }
        field(85; "NetAmount LCY"; Decimal)
        {
        }
        field(86; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;

            trigger OnLookup()
            begin
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                     (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                        Error('You Cannot modify documents that are approved/posted/Send for Approval');
                end;
            end;

            trigger OnValidate()
            begin
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                     (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                        Error('You Cannot modify documents that are approved/posted/Send for Approval');
                end;
            end;
        }
        field(87; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup()
            var
                VendLedgEntry: Record "Vendor Ledger Entry";
                PayToVendorNo: Code[20];
                OK: Boolean;
                Text000: label 'You must specify %1 or %2.';
            begin
                //CODEUNIT.RUN(CODEUNIT::"Payment Voucher Apply",Rec);
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                     (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                        Error('You Cannot modify documents that are approved/posted/Send for Approval');
                end;

                if (Rec."Account Type" <> Rec."account type"::Customer) and (Rec."Account Type" <> Rec."account type"::Vendor) then
                    Error('You cannot apply to %1', "Account Type");

                with Rec do begin
                    Amount := 0;
                    Validate(Amount);
                    PayToVendorNo := "Account No.";
                    VendLedgEntry.SetCurrentkey("Vendor No.", Open);
                    VendLedgEntry.SetRange("Vendor No.", PayToVendorNo);
                    VendLedgEntry.SetRange(Open, true);
                    if "Applies-to ID" = '' then
                        "Applies-to ID" := No;
                    if "Applies-to ID" = '' then
                        Error(
                          Text000,
                          FieldCaption(No), FieldCaption("Applies-to ID"));
                    //ApplyVendEntries."SetPVLine-Delete"(PVLine,PVLine.FIELDNO("Applies-to ID"));
                    //ApplyVendEntries.SetPVLine(Rec,VendLedgEntry,Rec.FIELDNO("Applies-to ID"));
                    ApplyVendEntries.SetRecord(VendLedgEntry);
                    ApplyVendEntries.SetTableview(VendLedgEntry);
                    ApplyVendEntries.LookupMode(true);
                    OK := ApplyVendEntries.RunModal = Action::LookupOK;
                    Clear(ApplyVendEntries);
                    if not OK then
                        exit;
                    VendLedgEntry.Reset;
                    VendLedgEntry.SetCurrentkey("Vendor No.", Open);
                    VendLedgEntry.SetRange("Vendor No.", PayToVendorNo);
                    VendLedgEntry.SetRange(Open, true);
                    VendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                    if VendLedgEntry.Find('-') then begin
                        "Applies-to Doc. Type" := 0;
                        "Applies-to Doc. No." := '';
                    end else
                        "Applies-to ID" := '';
                end;

                //Calculate  Total To Apply
                VendLedgEntry.Reset;
                VendLedgEntry.SetCurrentkey("Vendor No.", Open, "Applies-to ID");
                VendLedgEntry.SetRange("Vendor No.", PayToVendorNo);
                VendLedgEntry.SetRange(Open, true);
                VendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                if VendLedgEntry.Find('-') then begin
                    VendLedgEntry.CalcSums("Amount to Apply");
                    Amount := Abs(VendLedgEntry."Amount to Apply");
                    Validate(Amount);
                end;
            end;

            trigger OnValidate()
            begin
                //IF "Applies-to Doc. No." <> '' THEN
                //TESTFIELD("Bal. Account No.",'');

                if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (xRec."Applies-to Doc. No." <> '') and
                   ("Applies-to Doc. No." <> '')
                then begin
                    SetAmountToApply("Applies-to Doc. No.", "Account No.");
                    SetAmountToApply(xRec."Applies-to Doc. No.", "Account No.");
                end else
                    if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (xRec."Applies-to Doc. No." = '') then
                        SetAmountToApply("Applies-to Doc. No.", "Account No.")
                    else
                        if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and ("Applies-to Doc. No." = '') then
                            SetAmountToApply(xRec."Applies-to Doc. No.", "Account No.");

                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                     (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                        Error('You Cannot modify documents that are approved/posted/Send for Approval');
                end;
            end;
        }
        field(88; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';

            trigger OnLookup()
            begin
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                     (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                        Error('You Cannot modify documents that are approved/posted/Send for Approval');
                end;
            end;

            trigger OnValidate()
            var
                TempVendLedgEntry: Record "Vendor Ledger Entry";
            begin
                //IF "Applies-to ID" <> '' THEN
                //  TESTFIELD("Bal. Account No.",'');
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                     (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                        Error('You Cannot modify documents that are approved/posted/Send for Approval');
                end;

                if ("Applies-to ID" <> xRec."Applies-to ID") and (xRec."Applies-to ID" <> '') then begin
                    VendLedgEntry.SetCurrentkey("Vendor No.", Open);
                    VendLedgEntry.SetRange("Vendor No.", "Account No.");
                    VendLedgEntry.SetRange(Open, true);
                    VendLedgEntry.SetRange("Applies-to ID", xRec."Applies-to ID");
                    if VendLedgEntry.FindFirst then
                        //VendEntrySetApplID.SetApplId(VendLedgEntry,TempVendLedgEntry,0,0,''); //HAZINA

                        VendLedgEntry.Reset;
                end;
            end;
        }
        field(90; "Retention Code"; Code[20])
        {
            TableRelation = "Tariff Codes".Code where(Type = const(Retention));

            trigger OnValidate()
            begin
                if TariffCode.Get("Retention Code") then
                    "Retention Rate" := TariffCode.Percentage
                else
                    "Retention Rate" := 0;

                CalculateTax();
            end;
        }
        field(91; "Retention  Amount"; Decimal)
        {
        }
        field(92; "Retention Rate"; Decimal)
        {
        }
        field(93; "W/Tax Rate"; Decimal)
        {
        }
        field(94; "Vendor Bank Account"; Code[20])
        {
            TableRelation = if ("Account Type" = const(Vendor)) "Vendor Bank Account".Code where("Vendor No." = field("Account No."));

            trigger OnLookup()
            begin
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                     (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                        Error('You Cannot modify documents that are approved/posted/Send for Approval');
                end;
            end;

            trigger OnValidate()
            begin
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                     (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                        Error('You Cannot modify documents that are approved/posted/Send for Approval');
                end;
            end;
        }
        field(95; "Trip No"; Code[20])
        {
        }
        field(96; "Driver No"; Code[20])
        {
        }
        field(97; "Loan No"; Integer)
        {
        }
        field(98; "Grant No"; Code[20])
        {
            // TableRelation = Jobs."No." where("Currency Code" = field("Currency Code"),
            //                                   "Approval Status" = const(Approved),
            //                                   Status = const(Contract));

            trigger OnValidate()
            begin
                // job.Reset;
                // if job.Get("Grant No") then
                //     "Account Type" := "account type"::Customer;
                //"Account No.":=job."Bill-to Partner No.";
                //VALIDATE("Account No.");
                //"Account Name":=job.Description;
            end;
        }
        field(99; "Grant Phase"; Code[10])
        {
            //    TableRelation = Table54335;
        }
        field(100; "Installment No"; Integer)
        {
        }
        field(101; "Job-Planning Line No"; Integer)
        {
            // TableRelation = Table54345.Field1 where (Field2=field("Grant No"),
            //                                          Field50008=field("Account No."));
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
        field(5601; "FA Posting Type"; Option)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            Caption = 'FA Posting Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Acquisition Cost,Depreciation,Write-Down,Appreciation,Custom 1,Custom 2,Disposal,Maintenance';
            OptionMembers = " ","Acquisition Cost",Depreciation,"Write-Down",Appreciation,"Custom 1","Custom 2",Disposal,Maintenance;

            trigger OnValidate()
            begin
                /*IF  NOT (("Account Type" = "Account Type"::"Fixed Asset") OR
                         ("Bal. Account Type" = "Bal. Account Type"::"Fixed Asset")) AND
                   ("FA Posting Type" = "FA Posting Type"::" ")
                THEN BEGIN
                  "FA Posting Date" := 0D;
                  "Salvage Value" := 0;
                  "No. of Depreciation Days" := 0;
                  "Depr. until FA Posting Date" := FALSE;
                  "Depr. Acquisition Cost" := FALSE;
                  "Maintenance Code" := '';
                  "Insurance No." := '';
                  "Budgeted FA No." := '';
                  "Duplicate in Depreciation Book" := '';
                  "Use Duplication List" := FALSE;
                  "FA Reclassification Entry" := FALSE;
                  "FA Error Entry No." := 0;
                END;
                
                IF "FA Posting Type" <> "FA Posting Type"::"Acquisition Cost" THEN
                  TESTFIELD("Insurance No.",'');
                IF "FA Posting Type" <> "FA Posting Type"::Maintenance THEN
                  TESTFIELD("Maintenance Code",'');
                GetFAVATSetup;
                GetFAAddCurrExchRate;
                */

            end;
        }
        field(50000; "Property Code"; Code[30])
        {
            //  TableRelation = Table56123.Field1;
        }
        field(50001; "Transaction Code"; Code[30])
        {
            //  TableRelation = Table56120.Field1;
        }
        field(50002; "Entry Type[Income/Expense]"; Option)
        {
            OptionCaption = ' ,Income,Expense';
            OptionMembers = " ",Income,Expense;
        }
        field(50003; "Asset No"; Code[10])
        {
            TableRelation = "Fixed Asset"."No.";
        }
        field(56000; "Invoice No."; Code[20])
        {
            TableRelation = "Vendor Ledger Entry"."Document No." where(Open = const(true),
                                                                        "Document Type" = const(Invoice),
                                                                        "Vendor No." = field("Account No."));

            trigger OnValidate()
            begin
                VendLedger.Reset;
                VendLedger.SetRange(VendLedger."Document No.", "Invoice No.");
                VendLedger.SetRange(VendLedger."Vendor No.", "Account No.");
                VendLedger.SetRange(VendLedger."Document Type", VendLedger."document type"::Invoice);
                if VendLedger.FindFirst then begin
                    VendLedger.CalcFields("Remaining Amount");
                    Amount := -VendLedger."Remaining Amount";
                    "Due Date" := VendLedger."Due Date";
                end
            end;
        }
        field(56001; "Due Date"; Date)
        {
        }
        field(56002; "VAT Withhelding Amount"; Decimal)
        {
        }
        field(56003; "VAT Withheld Code"; Code[10])
        {
            TableRelation = "Tariff Codes".Code where(Type = const(VAT));
        }
        field(56004; "VAT 6% Rate"; Decimal)
        {
        }
        field(51516000; "Gen. Bus. Posting Group"; Code[20])
        {
        }
        field(51516001; "Gen. Prod. Posting Group"; Code[20])
        {
        }
        field(51516002; "VAT Bus. Posting Group"; Code[20])
        {
        }
        field(51516003; "Payment Description"; Text[100])
        {
        }
        field(51516004; "W/TAX Code"; Code[10])
        {

            trigger OnValidate()
            begin
                FundsTaxCodes.Reset;
                FundsTaxCodes.SetRange(FundsTaxCodes."Tax Code", "W/TAX Code");
                if FundsTaxCodes.FindFirst then begin
                    "W/TAX Amount" := Amount * (FundsTaxCodes.Percentage / 100);
                    Validate("W/TAX Amount");
                end;
            end;
        }
        field(51516005; "W/TAX Amount"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                "Net Amount" := Amount - "W/TAX Amount";
                if "Currency Code" <> '' then begin
                    "W/TAX Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "W/TAX Amount", "Currency Factor"));
                    "Net Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Net Amount", "Currency Factor"));
                end else begin
                    "W/TAX Amount(LCY)" := "W/TAX Amount";
                    "Net Amount(LCY)" := "Net Amount";
                end;
            end;
        }
        field(51516006; "W/TAX Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(51516007; "Posting Date"; Date)
        {
        }
        field(51516008; "Net Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(51516009; "Loan No."; Code[20])
        {
            TableRelation = if ("Transaction Type" = const(Loan)) "Loans Register"."Loan  No." where("Client Code" = field("Account No."));
        }
        field(51516010; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Registration Fee,Loan,Repayment,Withdrawal,Interest Due,Interest Paid,Benevolent Fund,Deposit Contribution,Penalty Charged,Application Fee,Appraisal Fee,Investment,Unallocated Funds,Shares Capital,Loan Adjustment,Dividend,Withholding Tax,Administration Fee,Insurance Contribution,Prepayment,Withdrawable Deposits,Xmas Contribution,Penalty Paid,Dev Shares,Co-op Shares,Welfare Contribution 2,Loan Penalty,Loan Guard,Lukenya,Konza,Juja,Housing Water,Housing Title,Housing Main,M Pesa Charge ,Insurance Charge,Insurance Paid,FOSA Account,Partial Disbursement';
            OptionMembers = " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","Welfare Contribution 2","Loan Penalty","Loan Guard",Lukenya,Konza,Juja,"Housing Water","Housing Title","Housing Main","M Pesa Charge ","Insurance Charge","Insurance Paid","FOSA Account","Partial Disbursement";
        }
        field(51516011; "Refund Charge"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Line No.", No, Type)
        {
            Clustered = true;
            SumIndexFields = Amount, "VAT Amount", "Withholding Tax Amount", "Net Amount", "NetAmount LCY", "Retention  Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*PHead.RESET;
        PHead.SETRANGE(PHead."No.",No);
         IF PHead.FINDFIRST THEN BEGIN
            IF
            (PHead.Status=PHead.Status::Approved) OR
             (PHead.Status=PHead.Status::Posted) OR
            (PHead.Status=PHead.Status::"Pending Approval")OR (PHead.Status=PHead.Status::Cancelled) THEN
               ERROR('You Cannot Delete this record its already approved/posted/Send for Approval');
         END;
          TESTFIELD(Committed,FALSE);
         */

    end;

    trigger OnInsert()
    begin
        /*{
        IF No = '' THEN BEGIN
          GenLedgerSetup.GET;
          GenLedgerSetup.TESTFIELD(GenLedgerSetup."Normal Payments No");
          NoSeriesMgt.InitSeries(GenLedgerSetup."Normal Payments No",xRec."No. Series",0D,No,"No. Series");
        END;
        }
        PHead.RESET;
        PHead.SETRANGE(PHead."No.",No);
        IF PHead.FINDFIRST THEN
          BEGIN
            Date:=PHead.Date;
            PHead.TESTFIELD("Responsibility Center");
            "Global Dimension 1 Code":=PHead."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code":=PHead."Global Dimension 2 Code";
            "Shortcut Dimension 3 Code":=PHead."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code":=PHead."Shortcut Dimension 4 Code";
            "Currency Code":=PHead."Currency Code";
            "Currency Factor":=PHead."Currency Factor";
            "Payment Type":=PHead."Payment Type";
          END;
        //
        PHead.RESET;
        PHead.SETRANGE(PHead."No.",No);
         IF PHead.FINDFIRST THEN BEGIN
            IF
           //  (PHead.Status=PHead.Status::Approved)
            (PHead.Status=PHead.Status::Posted) OR
             (PHead.Status=PHead.Status::"Pending Approval")OR (PHead.Status=PHead.Status::Cancelled) THEN
               ERROR('You Cannot modify documents that are approved/posted/Send for Approval');
         END;
          TESTFIELD(Committed,FALSE);
          */

    end;

    trigger OnModify()
    begin
        /*PHead.RESET;
        PHead.SETRANGE(PHead."No.",No);
         IF PHead.FINDFIRST THEN BEGIN
            IF (PHead.Status=PHead.Status::Approved) OR (PHead.Status=PHead.Status::Posted) OR
             (PHead.Status=PHead.Status::"Pending Approval") THEN
               ERROR('You Cannot modify documents that are approved/posted/Send for Approval');
         END;
          TESTFIELD(Committed,FALSE);
           */

    end;

    var
        FundsTaxCodes: Record "Funds Tax Codes";
        CurrExchRate: Record "Currency Exchange Rate";
        PH: Record "Payment Header.";
        VLedgEntry: Record "Vendor Ledger Entry";
        ICPartner: Record "IC Partner";
        FPurch: Record "Purch. Inv. Header";
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;
        FA: Record "Fixed Asset";
        BankAcc: Record "Bank Account";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenLedgerSetup: Record "Cash Office Setup";
        RecPayTypes: Record "Receipts and Payment Types";
        CashierLinks: Record "Cash Office User Template";
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
        GenLedSetup: Record "Cash Office Setup";
        "Total Budget": Decimal;
        MonthBudget: Decimal;
        Expenses: Decimal;
        Header: Text[250];
        "Date From": Text[30];
        "Date To": Text[30];
        LastDay: Date;
        ImprestReqDet: Record "Imprest Details-User";
        LoadImprestDetails: Record "Cash Payment Line";
        TotAmt: Decimal;
        DimVal: Record "Dimension Value";
        PHead: Record "Payment Header.";
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendEntrySetApplID: Codeunit "Vend. Entry-SetAppl.ID";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        GenJnILine: Record "Gen. Journal Line";
        ApplyVendEntries: Page "Apply Vendor Entries";
        TariffCode: Record "Tariff Codes";
        DimMgt: Codeunit DimensionManagement;
        VendLedger: Record "Vendor Ledger Entry";
    // job: Record "Jobs";


    procedure SetAmountToApply(AppliesToDocNo: Code[20]; VendorNo: Code[20])
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        VendLedgEntry.SetCurrentkey("Document No.");
        VendLedgEntry.SetRange("Document No.", AppliesToDocNo);
        VendLedgEntry.SetRange("Vendor No.", VendorNo);
        VendLedgEntry.SetRange(Open, true);
        if VendLedgEntry.FindFirst then begin
            if VendLedgEntry."Amount to Apply" = 0 then begin
                VendLedgEntry.CalcFields("Remaining Amount");
                VendLedgEntry."Amount to Apply" := VendLedgEntry."Remaining Amount";
            end else
                VendLedgEntry."Amount to Apply" := 0;
            VendLedgEntry."Accepted Payment Tolerance" := 0;
            VendLedgEntry."Accepted Pmt. Disc. Tolerance" := false;
            Codeunit.Run(Codeunit::"Vend. Entry-Edit", VendLedgEntry);
        end;
    end;


    procedure CalculateTax()
    var
        CalculationType: Option VAT,"W/Tax",Retention,VAT6;
        TaxCalc: Codeunit "Tax Calculation";
        TotalTax: Decimal;
    begin
        "VAT Amount" := 0;
        "Withholding Tax Amount" := 0;
        "Retention  Amount" := 0;
        TotalTax := 0;
        "Net Amount" := 0;
        if Amount <> 0 then begin
            if "VAT Rate" <> 0 then begin
                "VAT Amount" := TaxCalc.CalculateTax(Rec, Calculationtype::VAT);
                TotalTax := TotalTax + "VAT Amount"
            end;

            if "W/Tax Rate" <> 0 then begin
                "Withholding Tax Amount" := TaxCalc.CalculateTax(Rec, Calculationtype::"W/Tax");
                TotalTax := TotalTax + "Withholding Tax Amount"
            end;

            if "Retention Rate" <> 0 then begin
                "Retention  Amount" := TaxCalc.CalculateTax(Rec, Calculationtype::Retention);
                TotalTax := TotalTax + "Retention  Amount"
            end;

            //Added for VAT6% OF VAT
            if "VAT 6% Rate" <> 0 then begin
                "VAT Withhelding Amount" := TaxCalc.CalculateTax(Rec, Calculationtype::VAT6);
                TotalTax := TotalTax + "VAT Withhelding Amount"
            end;

        end;

        "Net Amount" := Amount - TotalTax;
        Validate("Net Amount");
    end;


    procedure PayLinesExist(): Boolean
    var
        PayLine: Record "Payment Line.";
    begin
        PayLine.Reset;
        PayLine.SetRange(No, No);
        exit(PayLine.FindFirst);
    end;


    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', 'Payment', "Line No."));
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
}

