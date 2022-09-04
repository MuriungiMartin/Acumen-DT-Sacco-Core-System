#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516043 "Cash Payment Line"
{
    // DrillDownPageID = UnknownPage50032;
    // LookupPageID = UnknownPage50032;

    fields
    {
        field(1; No; Code[20])
        {

            trigger OnValidate()
            begin
                /*
                IF No <> xRec.No THEN BEGIN
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
            TableRelation = "Receipts and Payment Types".Code where(Type = filter(Payment));

            trigger OnValidate()
            begin
                /**
                                "Account No.":='';
                                "Account Name":='';
                                Remarks:='';
                                RecPayTypes.Reset;
                                RecPayTypes.SetRange(RecPayTypes.Code,Type);
                                RecPayTypes.SetRange(RecPayTypes.Type,RecPayTypes.Type::Payment);

                                if RecPayTypes.Find('-') then
                                  begin
                                    Grouping:=RecPayTypes."Default Grouping";
                                    "Require Surrender":=RecPayTypes."Pending Voucher";
                                  end;

                                if RecPayTypes.Find('-') then
                                  begin
                                    "Account Type":=RecPayTypes."Account Type";
                                    "Transaction Name":=RecPayTypes.Description;
                                      if RecPayTypes."Account Type"=RecPayTypes."account type"::"G/L Account" then
                                        begin
                                          RecPayTypes.TestField(RecPayTypes."G/L Account");
                                          "Account No.":=RecPayTypes."G/L Account";
                                          Validate("Account No.");
                                        end;

                                //Banks
                                if RecPayTypes."Account Type"=RecPayTypes."account type"::"Bank Account" then
                                  begin
                                    "Account No.":=RecPayTypes."Bank Account";
                                //    VALIDATE("Account No.");
                                  end;
                                end;
                                **/
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
        field(7; "Cheque Type"; Option)
        {
            OptionMembers = " "," Local","Up Country";
            //   TableRelation = "Member Cue";
        }
        field(8; "Bank Code"; Code[20])
        {
            //  TableRelation = "Cash Payments Header";
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
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Staff';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Staff;
        }
        field(13; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Direct Posting" = const(true)) else
            if ("Account Type" = const(Customer)) Customer where("Customer Posting Group" = field(Grouping)) else
            if ("Account Type" = const(Vendor)) Vendor else
            if ("Account Type" = const("Bank Account")) "Bank Account" else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset" else
            if ("Account Type" = const("IC Partner")) "IC Partner";
            //  if ("Account Type" = const(Staff)) Table55883.Field1;

            trigger OnValidate()
            begin
                /**   HeaderC.Reset;
                   HeaderC.Get(No);
                   "Account Name":='';
                   RecPayTypes.Reset;
                   RecPayTypes.SetRange(RecPayTypes.Code,Type);
                   RecPayTypes.SetRange(RecPayTypes.Type,RecPayTypes.Type::Payment);

                   if "Account Type" in ["account type"::"G/L Account","account type"::Customer,"account type"::Vendor,"account type"::"IC Partner"
                   ,"account type"::Staff]
                   then

                   case "Account Type" of
                     "account type"::"G/L Account":
                       begin
                         GLAcc.Get("Account No.");
                         "Account Name":=GLAcc.Name;
                         "VAT Code":=RecPayTypes."VAT Code";
                         "Withholding Tax Code":=RecPayTypes."Withholding Tax Code";
                         "Global Dimension 1 Code":='';
                       end;
                     "account type"::Customer:
                       begin
                         Cust.Get("Account No.");
                         "Account Name":=Cust.Name;
                         "VAT Code":=RecPayTypes."VAT Code";
                         "Withholding Tax Code":=RecPayTypes."Withholding Tax Code";
                         if "Global Dimension 1 Code"='' then
                           begin
                             "Global Dimension 1 Code":=Cust."Global Dimension 1 Code";
                           end;
                       end;
                     "account type"::Vendor:
                       begin
                         Vend.Get("Account No.");
                         "Account Name":=Vend.Name;
                         "VAT Code":=RecPayTypes."VAT Code";
                         "Withholding Tax Code":=RecPayTypes."Withholding Tax Code";
                         if "Global Dimension 1 Code"='' then
                           begin
                             "Global Dimension 1 Code":=Vend."Global Dimension 1 Code";
                           end;
                         if HeaderC.Payee='' then
                           begin
                             HeaderC.Payee:="Account Name";
                             HeaderC.Modify;
                           end;
                         if HeaderC."On Behalf Of"='' then
                           begin
                             HeaderC."On Behalf Of":="Account Name";
                             HeaderC.Modify;
                           end;
                       end;
                     "account type"::"Bank Account":
                       begin
                         BankAcc.Get("Account No.");
                         "Account Name":=BankAcc.Name;
                         "VAT Code":=RecPayTypes."VAT Code";
                         "Withholding Tax Code":=RecPayTypes."Withholding Tax Code";
                         if "Global Dimension 1 Code"='' then
                           begin
                             "Global Dimension 1 Code":=BankAcc."Global Dimension 1 Code";
                           end;
                       end;
                     "account type"::Staff:
                       begin
                         Emp.Reset;
                         Emp.Get("Account No.");
                         "Account Name":=Emp."First Name" + ' ' + Emp."Middle Name" + Emp."Last Name";
                         "VAT Code":=RecPayTypes."VAT Code";
                         "Withholding Tax Code":=RecPayTypes."Withholding Tax Code";
                       end;
                   end;
                   **/
            end;
        }
        field(14; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
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
        }
        field(20; Amount; Decimal)
        {
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
        }
        field(24; "Withholding Tax Code"; Code[20])
        {
            TableRelation = "Tariff Codes".Code where(Type = const("W/Tax"));
        }
        field(25; "VAT Amount"; Decimal)
        {
        }
        field(26; "Withholding Tax Amount"; Decimal)
        {
        }
        field(27; "Net Amount"; Decimal)
        {
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
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin

                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 1);
                DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
                if DimVal.Find('-') then
                    "Function Name" := DimVal.Name
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
                    "Budget Center Name" := DimVal.Name
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
            TableRelation = "Customer Posting Group".Code;
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
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
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
        field(59; "Function Name"; Text[30])
        {
        }
        field(60; "Budget Center Name"; Text[30])
        {
        }
        field(61; "Farmer Purchase No"; Code[20])
        {
        }
        field(62; "Transporter Ananlysis No"; Code[20])
        {
        }
        field(63; "User ID"; Code[20])
        {
            //   TableRelation = Table2000000002.Field1;
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
        field(68; "Committed Ammount"; Decimal)
        {
            //   TableRelation = "Imprest Details".Amount;
        }
        field(69; "Select to Surrender"; Boolean)
        {
        }
        field(70; "Temp Surr Doc"; Code[20])
        {
        }
        field(71; "Document No."; Code[20])
        {
        }
        field(72; "VAT Prod. Posting Group"; Code[20])
        {
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(73; "VAT Registration No."; Code[20])
        {
        }
        field(74; "VAT Entity Name"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Line No.", No)
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
        key(Key2; No, "Account Type")
        {
            SumIndexFields = Amount, "VAT Amount", "Withholding Tax Amount", "Net Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // if No = '' then begin
        //   GenLedgerSetup.Get;
        //   GenLedgerSetup.TestField(GenLedgerSetup."Normal Payments No");
        //   NoSeriesMgt.InitSeries(GenLedgerSetup."Normal Payments No",xRec."No. Series",0D,No,"No. Series");
        // end;
        // CHead.Reset;
        // CHead.SetRange(CHead."No.",No);
        // if CHead.FindFirst then
        //   begin
        //     "Global Dimension 1 Code":=CHead."Global Dimension 1 Code";
        //     "Shortcut Dimension 2 Code":=CHead."Shortcut Dimension 2 Code";
        //   end;
    end;

    var
        HeaderC: Record "FD Interest Calculation Crite";
        Emp: Record "Salary Processing Header";
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;
        FA: Record "Fixed Asset";
        BankAcc: Record "Bank Account";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenLedgerSetup: Record "Salary Processing Lines";
        RecPayTypes: Record "Fixed Deposit Type";
        CashierLinks: Record "Cheque Types";
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
        GenLedSetup: Record "Salary Processing Lines";
        "Total Budget": Decimal;
        MonthBudget: Decimal;
        Expenses: Decimal;
        Header: Text[250];
        "Date From": Text[30];
        "Date To": Text[30];
        LastDay: Date;
        ImprestReqDet: Record "Status Change Permision";
        LoadImprestDetails: Record Banks;
        TotAmt: Decimal;
        DimVal: Record "Dimension Value";
        CHead: Record "FD Interest Calculation Crite";
}

