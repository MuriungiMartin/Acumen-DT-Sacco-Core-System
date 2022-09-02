#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 59003 "Bank Account Statement Lines"
{
    Caption = 'Bank Account Statement Line';

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
            TableRelation = "Bank Account Statement"."Statement No." where ("Bank Account No."=field("Bank Account No."));
        }
        field(3;"Statement Line No.";Integer)
        {
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
        field(6;Description;Text[90])
        {
            Caption = 'Description';
        }
        field(7;"Statement Amount";Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Statement Amount';
        }
        field(8;Difference;Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Difference';
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
        }
        field(10;Type;Option)
        {
            Caption = 'Type';
            OptionCaption = 'Bank Account Ledger Entry,Check Ledger Entry,Difference';
            OptionMembers = "Bank Account Ledger Entry","Check Ledger Entry",Difference;
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
        field(14;"Check No.";Code[20])
        {
            AccessByPermission = TableData "Check Ledger Entry"=R;
            Caption = 'Check No.';
        }
        field(50000;Reconcilled;Boolean)
        {
        }
        field(50001;"Document Date";Date)
        {
        }
        field(50002;Debit;Decimal)
        {
            CalcFormula = sum("Bank Account Statement Lines"."Statement Amount" where ("Statement Amount"=filter(>0),
                                                                                       "Bank Account No."=field("Bank Account No."),
                                                                                       "Statement Line No."=field("Statement Line No.")));
            FieldClass = FlowField;
        }
        field(50003;Credit;Decimal)
        {
            CalcFormula = sum("Bank Account Statement Lines"."Statement Amount" where ("Statement Amount"=filter(<0),
                                                                                       "Bank Account No."=field("Bank Account No."),
                                                                                       "Statement Line No."=field("Statement Line No.")));
            FieldClass = FlowField;
        }
        field(50004;"Open Type";Option)
        {
            OptionCaption = ' ,Unpresented Cheques List,Uncredited Cheques List';
            OptionMembers = " ",Unpresented,Uncredited;
        }
    }

    keys
    {
        key(Key1;"Bank Account No.","Statement No.","Statement Line No.")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
            SumIndexFields = "Statement Amount",Difference;
        }
    }

    fieldgroups
    {
    }

    trigger OnRename()
    begin
        Error(Text000,TableCaption);
    end;

    var
        Text000: label 'You cannot rename a %1.';
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        CheckLedgEntry: Record "Check Ledger Entry";

    local procedure DisplayApplication()
    begin
        case Type of
          Type::"Bank Account Ledger Entry":
            begin
              BankAccLedgEntry.Reset;
              BankAccLedgEntry.SetCurrentkey("Bank Account No.",Open);
              BankAccLedgEntry.SetRange("Bank Account No.","Bank Account No.");
              BankAccLedgEntry.SetRange(Open,false);
              BankAccLedgEntry.SetRange("Statement Status",BankAccLedgEntry."statement status"::Closed);
              BankAccLedgEntry.SetRange("Statement No.","Statement No.");
              BankAccLedgEntry.SetRange("Statement Line No.","Statement Line No.");
              Page.Run(0,BankAccLedgEntry);
            end;
          Type::"Check Ledger Entry":
            begin
              CheckLedgEntry.Reset;
              CheckLedgEntry.SetCurrentkey("Bank Account No.",Open);
              CheckLedgEntry.SetRange("Bank Account No.","Bank Account No.");
              CheckLedgEntry.SetRange(Open,false);
              CheckLedgEntry.SetRange("Statement Status",CheckLedgEntry."statement status"::Closed);
              CheckLedgEntry.SetRange("Statement No.","Statement No.");
              CheckLedgEntry.SetRange("Statement Line No.","Statement Line No.");
              Page.Run(0,CheckLedgEntry);
            end;
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
}

