#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516075 "ATMTransCompleted"
{

    fields
    {
        field(1;Id;Integer)
        {
            AutoIncrement = true;
        }
        field(2;serviceName;Text[50])
        {
        }
        field(3;messageID;Text[200])
        {
        }
        field(4;OPTransactionDate;Date)
        {
        }
        field(5;OPTerminalID;Text[50])
        {
        }
        field(6;OPChannel;Text[50])
        {
        }
        field(7;OPTransactionType;Text[30])
        {
        }
        field(8;OPOriginalMessageID;Text[50])
        {
        }
        field(9;PostingDebitAccount;Text[30])
        {
        }
        field(10;PostingTotalAmount;Decimal)
        {
        }
        field(11;PostingCurrency;Text[30])
        {
        }
        field(12;PostingCreditAccount;Text[30])
        {
        }
        field(13;PostingChargeAmount;Decimal)
        {
        }
        field(14;PostingChargeCurrency;Text[30])
        {
        }
        field(15;PostingFeeAmount;Decimal)
        {
        }
        field(16;PostingFeeCurrency;Text[30])
        {
        }
        field(17;PostingNarrative;Text[100])
        {
        }
        field(18;PostingNarrative1;Text[50])
        {
        }
        field(19;PostingNarrative2;Text[30])
        {
        }
        field(20;InstitutionInstitutionCode;Text[30])
        {
        }
        field(21;InstitutionInstitutionName;Text[30])
        {
        }
        field(22;AccountDebitAccount;Text[30])
        {
        }
        field(23;AccountCreditAccount;Text[30])
        {
        }
        field(24;PostedStatus;Option)
        {
            OptionCaption = '1,2';
            OptionMembers = "1","2";
        }
        field(25;PostingComments;Text[30])
        {
        }
        field(26;SavingsAccountNumber;Text[30])
        {
        }
        field(27;"Transaction Type Charges";Option)
        {
            OptionCaption = 'Balance Enquiry,Mini Statement,Cash Withdrawal - Coop ATM,Cash Withdrawal - VISA ATM,Reversal,Utility Payment,POS - Normal Purchase,M-PESA Withdrawal,Airtime Purchase,POS - School Payment,POS - Purchase With Cash Back,POS - Cash Deposit,POS - Benefit Cash Withdrawal,POS - Cash Deposit to Card,POS - M Banking,POS - Cash Withdrawal,POS - Balance Enquiry,POS - Mini Statement,MINIMUM BALANCE';
            OptionMembers = "Balance Enquiry","Mini Statement","Cash Withdrawal - Coop ATM","Cash Withdrawal - VISA ATM",Reversal,"Utility Payment","POS - Normal Purchase","M-PESA Withdrawal","Airtime Purchase","POS - School Payment","POS - Purchase With Cash Back","POS - Cash Deposit","POS - Benefit Cash Withdrawal","POS - Cash Deposit to Card","POS - M Banking","POS - Cash Withdrawal","POS - Balance Enquiry","POS - Mini Statement","MINIMUM BALANCE";
        }
        field(28;"Reversal Trace ID";Code[30])
        {
        }
        field(29;Amount;Decimal)
        {
        }
        field(30;"POS Vendor";Option)
        {
            OptionCaption = 'ATM Lobby,Agent Banking,Coop Branch POS,Sacco POS';
            OptionMembers = "ATM Lobby","Agent Banking","Coop Branch POS","Sacco POS";
        }
        field(31;"Withdrawal Location";Text[100])
        {
        }
        field(32;"Trace ID";Code[30])
        {
        }
        field(33;Description;Text[30])
        {
        }
        field(34;Source;Text[30])
        {
        }
        field(35;Reversed;Boolean)
        {
        }
        field(36;RecSource;Option)
        {
            OptionCaption = 'ATM,POS,VISA,BRANCH,MERCHANT';
            OptionMembers = ATM,POS,VISA,BRANCH,MERCHANT;
        }
        field(37;"Field Location";Text[120])
        {
        }
        field(38;Status;Option)
        {
            OptionCaption = 'Pending,Posted,Failed,Reversed';
            OptionMembers = Pending,Posted,Failed,Reversed;
        }
        field(39;DocumentNumber;Text[15])
        {
        }
        field(40;TransactionDescription;Text[120])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;Id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

