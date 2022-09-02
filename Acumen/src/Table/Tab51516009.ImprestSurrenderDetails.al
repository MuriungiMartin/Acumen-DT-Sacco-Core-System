#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516009 "Imprest Surrender Details"
{

    fields
    {
        field(1;"Surrender Doc No.";Code[20])
        {
            Editable = false;
            NotBlank = true;

            trigger OnValidate()
            begin
                // IF Pay.GET(No) THEN
                // "Imprest Holder":=Pay."Account No.";
            end;
        }
        field(2;"Account No:";Code[20])
        {
            Editable = false;
            NotBlank = true;
            TableRelation = "G/L Account"."No." where ("Direct Posting"=const(true));

            trigger OnValidate()
            begin
                /*
                IF GLAcc.GET("Account No:") THEN
                 "Account Name":=GLAcc.Name;
                 GLAcc.TESTFIELD("Direct Posting",TRUE);
                IF Pay.GET("Surrender Doc No.") THEN BEGIN
                 IF Pay."Account No."<>'' THEN
                "Imprest Holder":=Pay."Account No."
                  ELSE
                  ERROR('Please Enter the Customer/Account Number');
                END;
                 */

            end;
        }
        field(3;"Account Name";Text[250])
        {
            Editable = false;
        }
        field(4;Amount;Decimal)
        {
            Editable = false;
        }
        field(5;"Due Date";Date)
        {
            Editable = false;
        }
        field(6;"Imprest Holder";Code[20])
        {
            Editable = false;
            TableRelation = Customer."No.";
        }
        field(7;"Actual Spent";Decimal)
        {

            trigger OnValidate()
            begin
                     if "Actual Spent">Amount then
                       Error('The Actual Spent Cannot be more than the Issued Amount');
                     if "Currency Factor"<>0 then
                        "Amount LCY":="Actual Spent"/"Currency Factor"
                       else
                          "Amount LCY":="Actual Spent";
            end;
        }
        field(8;"Apply to";Code[20])
        {
            Editable = false;
        }
        field(9;"Apply to ID";Code[20])
        {
            Editable = false;
        }
        field(10;"Surrender Date";Date)
        {
            Editable = false;
        }
        field(11;Surrendered;Boolean)
        {
            Editable = false;
        }
        field(12;"Cash Receipt No";Code[20])
        {

            trigger OnValidate()
            begin
                /*CustLedger.RESET;
                CustLedger.SETRANGE(CustLedger."Document No.","Cash Receipt No");
                CustLedger.SETRANGE(CustLedger."Source Code",'CASHRECJNL');
                CustLedger.SETRANGE(CustLedger.Open,TRUE);
                IF CustLedger.FIND('-') THEN
                 "Cash Receipt Amount":=ABS(CustLedger.Amount)
                ELSE BEGIN
                   "Cash Receipt Amount":=0;
                   MESSAGE();
                END;*/
                //"Cust. Ledger Entry"."Document No." WHERE (Source Code=CONST(CASHRECJNL),Open=CONST(Yes),Customer No.=FIELD(Account No:))

            end;
        }
        field(13;"Date Issued";Date)
        {
            Editable = false;
        }
        field(14;"Type of Surrender";Option)
        {
            OptionMembers = " ",Cash,Receipt;
        }
        field(15;"Dept. Vch. No.";Code[20])
        {
        }
        field(16;"Cash Surrender Amt";Decimal)
        {
        }
        field(17;"Bank/Petty Cash";Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(18;" Doc No.";Code[20])
        {
            Editable = false;
        }
        field(19;"Shortcut Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Shortcut Dimension 1 Code';
            Editable = false;
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(20;"Shortcut Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Editable = false;
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(21;"Shortcut Dimension 3 Code";Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = Dimension;
        }
        field(22;"Shortcut Dimension 4 Code";Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = Dimension;
        }
        field(23;"Shortcut Dimension 5 Code";Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = Dimension;
        }
        field(24;"Shortcut Dimension 6 Code";Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = Dimension;
        }
        field(25;"Shortcut Dimension 7 Code";Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = Dimension;
        }
        field(26;"Shortcut Dimension 8 Code";Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = Dimension;
        }
        field(27;"VAT Prod. Posting Group";Code[20])
        {
            Editable = false;
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(28;"Imprest Type";Code[20])
        {
            TableRelation = "Receipts and Payment Types".Code where (Type=const(Imprest));
        }
        field(85;"Currency Factor";Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0:15;
            Editable = false;
            MinValue = 0;
        }
        field(86;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            Editable = true;
            TableRelation = Currency;
        }
        field(87;"Amount LCY";Decimal)
        {
        }
        field(88;"Cash Surrender Amt LCY";Decimal)
        {
        }
        field(89;"Imprest Req Amt LCY";Decimal)
        {
        }
        field(90;"Cash Receipt Amount";Decimal)
        {
        }
        field(91;"Line No.";Integer)
        {
        }
        field(480;"Dimension Set ID";Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions
            end;
        }
    }

    keys
    {
        key(Key1;"Surrender Doc No.","Line No.")
        {
            Clustered = true;
            SumIndexFields = "Amount LCY","Imprest Req Amt LCY","Actual Spent";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
          /*Pay.RESET;
          Pay.SETRANGE(Pay.No,"Surrender Doc No.");
          IF Pay.FIND('-') THEN
             IF (Pay.Status=Pay.Status::"Pending Approval") OR (Pay.Status=Pay.Status::Approved)
             THEN
                ERROR('This Document is already Send for Approval/Approved');*/

    end;

    trigger OnModify()
    begin
         /* Pay.RESET;
          Pay.SETRANGE(Pay.No,"Surrender Doc No.");
          IF Pay.FIND('-') THEN
             IF (Pay.Status=Pay.Status::"Pending Approval") OR (Pay.Status=Pay.Status::Approved)
             THEN
                ERROR('This Document is already Send for Approval/Approved');*/

    end;

    var
        GLAcc: Record "G/L Account";
        Pay: Record "Imprest Surrender Header";
        Dim: Record Dimension;
        CustLedger: Record "Cust. Ledger Entry";
        Text000: label 'Receipt No %1 Is already Used in Another Document';
        DimMgt: Codeunit DimensionManagement;


    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID",StrSubstNo('%1 %2','Imprest',"Line No."));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
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
}

