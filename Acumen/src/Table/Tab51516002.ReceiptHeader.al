#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516002 "Receipt Header"
{

    fields
    {
        field(10; "No."; Code[20])
        {
            Editable = false;
        }
        field(11; Date; Date)
        {
            Editable = true;
        }
        field(12; "Posting Date"; Date)
        {
        }
        field(13; "Bank Code"; Code[20])
        {
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                BankAcc.Reset;
                BankAcc.SetRange(BankAcc."No.", "Bank Code");
                if BankAcc.FindFirst then begin
                    "Bank Name" := BankAcc.Name;
                end;
            end;
        }
        field(14; "Bank Name"; Text[50])
        {
            Editable = false;
        }
        field(15; "Bank Balance"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Bank Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Currency Code"; Code[10])
        {
            TableRelation = Currency.Code;

            trigger OnValidate()
            begin
                TestField("Bank Code");
                if "Currency Code" <> '' then begin
                    if BankAcc.Get("Bank Code") then begin
                        BankAcc.TestField(BankAcc."Currency Code", "Currency Code");
                        "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                    end;
                end else begin
                    if BankAcc.Get("Bank Code") then begin
                        BankAcc.TestField(BankAcc."Currency Code", '');
                    end;
                end
            end;
        }
        field(17; "Currency Factor"; Decimal)
        {
        }
        field(18; "Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(19; "Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(20; "Shortcut Dimension 3 Code"; Code[50])
        {
        }
        field(21; "Shortcut Dimension 4 Code"; Code[50])
        {
        }
        field(22; "Shortcut Dimension 5 Code"; Code[50])
        {
        }
        field(23; "Shortcut Dimension 6 Code"; Code[50])
        {
        }
        field(24; "Shortcut Dimension 7 Code"; Code[50])
        {
        }
        field(25; "Shortcut Dimension 8 Code"; Code[50])
        {
        }
        field(26; "Responsibility Center"; Code[50])
        {
        }
        field(27; "Amount Received"; Decimal)
        {

            trigger OnValidate()
            begin

                if "Currency Code" = '' then begin
                    "Amount Received(LCY)" := "Amount Received";
                end else begin
                    "Amount Received(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Amount Received", "Currency Factor"));
                end;
            end;
        }
        field(28; "Amount Received(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(29; "Total Amount"; Decimal)
        {
            CalcFormula = sum("Receipt Line".Amount where("Document No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Total Amount(LCY)"; Decimal)
        {
            CalcFormula = sum("Receipt Line"."Amount(LCY)" where("Document No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "User ID"; Code[50])
        {
            Editable = false;
        }
        field(32; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Rejected,Posted,InTreasuary';
            OptionMembers = New,"Pending Approval",Approved,Rejected,Posted,InTreasuary;
        }
        field(33; Description; Text[100])
        {

            trigger OnValidate()
            begin
                Description := UpperCase(Description);
            end;
        }
        field(34; "Received From"; Text[100])
        {

            trigger OnValidate()
            begin
                "Received From" := UpperCase("Received From");
            end;
        }
        field(35; "On Behalf of"; Text[100])
        {
        }
        field(36; "No. Series"; Code[20])
        {
        }
        field(37; Posted; Boolean)
        {
            Editable = false;
        }
        field(38; "Date Posted"; Date)
        {
        }
        field(39; "Time Posted"; Time)
        {
        }
        field(40; "Posted By"; Code[50])
        {
        }
        field(41; "Cheque No"; Code[20])
        {
        }
        field(42; "Date Created"; Date)
        {
        }
        field(43; "Time Created"; Time)
        {
        }
        field(44; "Receipt Type"; Option)
        {
            OptionCaption = 'Bank,Cash';
            OptionMembers = Bank,Cash;
        }
        field(45; "Created By"; Code[50])
        {
        }
        field(46; "Pay Mode"; Option)
        {
            OptionCaption = ' ,Cash/Mpasa,Cheque,Deposit Slip,EFT,Bankers Cheque,RTGS,STO';
            OptionMembers = " ",Cash,Cheque,"Deposit Slip",EFT,"Bankers Cheque",RTGS,STO;
        }
        field(50; Reversed; Boolean)
        {
            Editable = false;
        }
        field(51; "Reversed By"; Code[30])
        {
            Editable = false;
        }
        field(52; "Reversal Date"; Date)
        {
            Editable = false;
        }
        field(53; "Reversal Time"; Time)
        {
            Editable = false;
        }
        field(54; "Receipt Category"; Option)
        {
            OptionCaption = ' ,1,2,2';
            OptionMembers = " ","1","2","3";
        }
        field(55; "Account No"; Code[20])
        {
        }
        field(56; Cashier; Code[20])
        {
            TableRelation = "User Setup"."User ID";
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
        if Status = Status::New then begin
            ReceiptLines.Reset;
            ReceiptLines.SetRange(ReceiptLines."Document No", "No.");
            if ReceiptLines.FindSet then
                ReceiptLines.DeleteAll;
        end else begin
            Error('You can only delete a new Receipt. The current status is ' + Format(Status));
        end;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            Setup.Get;
            Setup.TestField(Setup."Receipt Nos");
            NoSeriesMgt.InitSeries(Setup."Receipt Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "User ID" := UserId;
        Date := Today;
        "Date Created" := Today;
        "Time Created" := Time;

        //CASHIER VALIDATION
        Banks.Reset;
        Banks.SetRange(Banks.CashierID, UserId);
        Banks.SetRange(Banks."Account Type", Banks."account type"::Cashier);
        if Banks.Find('-') then begin
            "Bank Code" := Banks."No.";
            "Bank Name" := Banks.Name;
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Setup: Record "Funds General Setup";
        BankAcc: Record "Bank Account";
        ok: Boolean;
        ReceiptLine: Record "Receipt Line";
        LineNo: Integer;
        FundsTransTypes: Record "Funds Transaction Types";
        Amount: Decimal;
        "Amount(LCY)": Decimal;
        ReceiptLines: Record "Receipt Line";
        "G/LAcc": Record "G/L Account";
        Customer: Record Customer;
        RHeader: Record "Receipt Header";
        CurrExchRate: Record "Currency Exchange Rate";
        Banks: Record "Bank Account";
}

