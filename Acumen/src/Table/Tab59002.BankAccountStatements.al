#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 59002 "Bank Account Statements"
{
    Caption = 'Bank Account Statement';
    DataCaptionFields = "Bank Account No.","Statement No.";
    LookupPageID = "Bank Account Statement List";

    fields
    {
        field(1;"Bank Account No.";Code[20])
        {
            Caption = 'Bank Account No.';
            NotBlank = true;
            TableRelation = "Bank Account";
        }
        field(2;"Statement No.";Code[20])
        {
            Caption = 'Statement No.';
            NotBlank = true;
        }
        field(3;"Statement Ending Balance";Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Statement Ending Balance';
        }
        field(4;"Statement Date";Date)
        {
            Caption = 'Statement Date';
        }
        field(5;"Balance Last Statement";Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Balance Last Statement';
            Editable = false;
        }
        field(50000;Reconcilled;Decimal)
        {
        }
        field(50004;"Open Type";Option)
        {
            OptionCaption = ',Unpresented Cheques List,Uncredited Cheques List';
            OptionMembers = ,Unpresented,Uncredited;
        }
        field(50005;Imported;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Bank Account No.","Statement No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if not Confirm(HasBankEntriesQst,false,"Bank Account No.","Statement No.") then
          Error('');
     //   BankAccStmtLinesDelete.Run(Rec);
    end;

    trigger OnRename()
    begin
        Error(Text000,TableCaption);
    end;

    var
        Text000: label 'You cannot rename a %1.';
        BankAccStmtLinesDelete: Codeunit "BankAccStmtLines-Delete";
        HasBankEntriesQst: label 'One or more bank account ledger entries in bank account %1 have been reconciled for bank account statement %2, which contain information about the bank statement. These bank ledger entries will not be modified if you delete bank account statement %2.\\Do you want to continue?';


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


    procedure HasBankLedgerEntries(): Boolean
    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        BankAccountLedgerEntry.SetRange("Bank Account No.","Bank Account No.");
        BankAccountLedgerEntry.SetRange("Statement No.","Statement No.");
        exit(not BankAccountLedgerEntry.IsEmpty);
    end;
}

