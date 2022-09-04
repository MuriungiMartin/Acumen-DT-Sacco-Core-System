#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516000 "Payment Header."
{
    DrillDownPageID = "Cash Payment List";
    LookupPageID = "Cash Payment List";

    fields
    {
        field(9; Date; Date)
        {
        }
        field(10; "No."; Code[20])
        {
            Editable = false;
        }
        field(11; "Document Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Accounting,Claim,Member Bill,Group Bill';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Accounting",Claim,"Member Bill","Group Bill";
        }
        field(12; "Document Date"; Date)
        {
        }
        field(13; "Posting Date"; Date)
        {
        }
        field(14; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(15; "Currency Factor"; Decimal)
        {
        }
        field(16; Payee; Text[100])
        {
        }
        field(17; "On Behalf Of"; Text[100])
        {
        }
        field(18; "Payment Mode"; Option)
        {
            OptionCaption = ' ,Cash,Cheque,EFT,Letter of Credit,Custom 3,Custom 4,Custom 5';
            OptionMembers = " ",Cash,Cheque,EFT,"Letter of Credit","Custom 3","Custom 4","Custom 5";
        }
        field(19; Amount; Decimal)
        {
            CalcFormula = sum("Payment Line.".Amount where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Amount(LCY)"; Decimal)
        {
            CalcFormula = sum("Payment Line.".Amount where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "VAT Amount"; Decimal)
        {
            CalcFormula = sum("Payment Line."."VAT Amount" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "VAT Amount(LCY)"; Decimal)
        {
            CalcFormula = sum("Payment Line."."VAT Amount" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "WithHolding Tax Amount"; Decimal)
        {
            CalcFormula = sum("Payment Line."."Withholding Tax Amount" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "WithHolding Tax Amount(LCY)"; Decimal)
        {
            CalcFormula = sum("Payment Line."."Withholding Tax Amount" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Net Amount"; Decimal)
        {
            CalcFormula = sum("Payment Line."."Net Amount" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; "Net Amount(LCY)"; Decimal)
        {
            CalcFormula = sum("Payment Line."."NetAmount LCY" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Bank Account"; Code[10])
        {
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                BankAcc.Reset;
                BankAcc.SetRange(BankAcc."No.", "Bank Account");
                if BankAcc.FindFirst then begin
                    "Bank Account Name" := BankAcc.Name;
                end else begin
                    "Bank Account Name" := '';
                end;
            end;
        }
        field(28; "Bank Account Name"; Text[100])
        {
            Editable = false;
        }
        field(29; "Bank Account Balance"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Bank Account")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Cheque Type"; Option)
        {
            OptionCaption = ' ,Computer Cheque,Manual Cheque';
            OptionMembers = " ","Computer Cheque","Manual Cheque";
        }
        field(31; "Cheque No"; Code[20])
        {

            trigger OnValidate()
            begin
                /* PHeader.RESET;
                 IF PHeader.FINDSET THEN BEGIN
                  REPEAT
                    IF PHeader."Cheque No"="Cheque No" THEN
                      ERROR('The Cheque Number has been used in PV No:'+FORMAT(PHeader."No."));
                  UNTIL PHeader.NEXT=0;
                 END;;
                 */

            end;
        }
        field(32; "Payment Description"; Text[100])
        {
        }
        field(33; "Global Dimension 1 Code"; Code[10])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(34; "Global Dimension 2 Code"; Code[10])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(35; "Shortcut Dimension 3 Code"; Code[10])
        {
        }
        field(36; "Shortcut Dimension 4 Code"; Code[10])
        {
        }
        field(37; "Shortcut Dimension 5 Code"; Code[10])
        {
        }
        field(38; "Shortcut Dimension 6 Code"; Code[10])
        {
        }
        field(39; "Shortcut Dimension 7 Code"; Code[10])
        {
        }
        field(40; "Shortcut Dimension 8 Code"; Code[10])
        {
        }
        field(41; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved,Rejected,Posted,Cancelled';
            OptionMembers = New,"Pending Approval",Approved,Rejected,Posted,Cancelled;
        }
        field(42; Posted; Boolean)
        {
        }
        field(43; "Posted By"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(44; "Date Posted"; Date)
        {
            Editable = false;
        }
        field(45; "Time Posted"; Time)
        {
            Editable = false;
        }
        field(46; Cashier; Code[50])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(47; "No. Series"; Code[10])
        {
        }
        field(48; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(49; "Retention Amount"; Decimal)
        {
            Editable = false;
        }
        field(50; "Retention Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(51; "User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(52; "Payment Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Normal,Petty Cash,Express,Cash Purchase,Mobile';
            OptionMembers = Normal,"Petty Cash",Express,"Cash Purchase",Mobile;
        }
        field(53; "Payment Category"; Option)
        {
            Description = 'Board Payment Field';
            OptionCaption = ' ,Normal Payment,Meeting Payment';
            OptionMembers = " ","Normal Payment","Meeting Payment";
        }
        field(54; "Member No"; Code[10])
        {
            Description = 'Board Payment Field';
            TableRelation = customer."No.";// where (Field11=field("Meeting Code"));

            trigger OnValidate()
            begin
                /*Members.RESET;
                Members.SETRANGE(Members."No.","Member No");
                IF Members.FINDFIRST THEN BEGIN
                  Payee:=FORMAT(Members.Title)+Members.Surname+Members.Firstname+Members.Middlename;
                  "Member Name":=FORMAT(Members.Title)+Members.Surname+Members.Firstname+Members.Middlename;
                END;
                */

            end;
        }
        field(55; "Member Name"; Text[50])
        {
            Description = 'Board Payment Field';
            Editable = false;
        }
        field(56; "Meeting Code"; Code[10])
        {
            Description = 'Board Payment Field';
        }
        field(57; "Meeting Name"; Text[50])
        {
            Description = 'Board Payment Field';
        }
        field(58; "Meeting Date"; Date)
        {
            Description = 'Board Payment Field';
        }
        field(59; "No. Printed"; Integer)
        {
        }
        field(60; "Payee Type"; Option)
        {
            OptionCaption = ' ,Vendor,Employee,Board Member';
            OptionMembers = " ",Vendor,Employee,"Board Member";
        }
        field(61; "Payee No"; Code[20])
        {
            TableRelation = if ("Payee Type" = const(Vendor)) Vendor
            else
            if ("Payee Type" = const(Employee)) "HR Employees";

            trigger OnValidate()
            begin
                if "Payee Type" = "payee type"::Vendor then begin
                    Vendor.Reset;
                    Vendor.SetRange(Vendor."No.", "Payee No");
                    if Vendor.FindFirst then begin
                        Payee := Vendor.Name;
                    end;
                end;
                /*IF "Payee Type"="Payee Type"::Employee THEN BEGIN
                   "HR Employee".RESET;
                   "HR Employee".SETRANGE("HR Employee"."No.","Payee No");
                   IF "HR Employee".FINDFIRST THEN BEGIN
                     Payee:="HR Employee"."First Name"+' '+"HR Employee"."Middle Name"+' '+"HR Employee"."Last Name";
                   END;
                END;*/
                /*IF "Payee Type"="Payee Type"::"Board Member" THEN BEGIN
                   Members.RESET;
                   Members.SETRANGE(Members."No.","Payee No");
                   IF Members.FINDFIRST THEN BEGIN
                     Payee:=Members.Firstname+' '+Members.Middlename+' '+Members.Surname;
                   END;
                END;
                */

            end;
        }
        field(62; Reversed; Boolean)
        {
        }
        field(63; "Reversed By"; Code[20])
        {
        }
        field(64; "Reversal Date"; Date)
        {
        }
        field(65; "Reversal Time"; Time)
        {
        }
        field(66; "Allowance Document"; Code[10])
        {
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
        field(69; "Pay Mode"; Option)
        {
            OptionCaption = ' ,Cash,Cheque,Mpesa,RTGS,EFT';
            OptionMembers = " ",Cash,Cheque,Mpesa,RTGS,EFT;
        }
        field(70; "Manual No"; Code[30])
        {
        }
        field(71; "Pay Asset"; Boolean)
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
        key(Key2; "Payment Category")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Status = Status::New then begin
            PaymentLines.Reset;
            PaymentLines.SetRange(PaymentLines.Cashier, "No.");
            if PaymentLines.FindSet then
                PaymentLines.DeleteAll;
        end else begin
            Error('You can only delete a new Payment Document. The current status is ' + Format(Status));
        end;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            if "Payment Type" = "payment type"::Normal then begin   //Cheque Payments
                Setup.Get;
                Setup.TestField(Setup."Payment Voucher Nos");
                NoSeriesMgt.InitSeries(Setup."Payment Voucher Nos", xRec."No. Series", 0D, "No.", "No. Series");
            end;
            if "Payment Type" = "payment type"::"Cash Purchase" then begin       //Cash Payments
                Setup.Get;
                Setup.TestField(Setup."Cash Voucher Nos");
                NoSeriesMgt.InitSeries(Setup."Cash Voucher Nos", xRec."No. Series", 0D, "No.", "No. Series");
            end;
            if "Payment Type" = "payment type"::"Petty Cash" then begin      //PettyCash Payments
                Setup.Get;
                Setup.TestField(Setup."PettyCash Nos");
                NoSeriesMgt.InitSeries(Setup."PettyCash Nos", xRec."No. Series", 0D, "No.", "No. Series");
            end;
            if "Payment Type" = "payment type"::Mobile then begin        //Mobile Payments
                Setup.Get;
                Setup.TestField(Setup."Mobile Payment Nos");
                NoSeriesMgt.InitSeries(Setup."Mobile Payment Nos", xRec."No. Series", 0D, "No.", "No. Series");
            end;

        end;
        "Document Type" := "document type"::Payment;
        "Document Date" := Today;
        "User ID" := UserId;
        Cashier := UserId;
        "Payment Release Date" := Today;
        Date := Today;

        //CASHIER VALIDATION
        Banks.Reset;
        Banks.SetRange(Banks.CashierID, UserId);
        Banks.SetRange(Banks."Account Type", Banks."account type"::Cashier);
        if Banks.Find('-') then begin
            "Bank Account" := Banks."No.";
            "Bank Account Name" := Banks.Name;
        end;
    end;

    var
        Setup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PaymentLines: Record "Payment Line.";
        BankAcc: Record "Bank Account";
        "HR Employee": Record Employee;
        Vendor: Record Vendor;
        PHeader: Record "Payment Header.";
        Banks: Record "Bank Account";
}

