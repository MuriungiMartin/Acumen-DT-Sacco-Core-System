#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516470 "ATM Charges"
{

    fields
    {
        field(1;"Transaction Type";Option)
        {
            OptionCaption = 'Balance Enquiry,Mini Statement,Cash Withdrawal - Coop ATM,Cash Withdrawal - VISA ATM,Reversal,Utility Payment,POS - Normal Purchase,M-PESA Withdrawal,Airtime Purchase,POS - School Payment,POS - Purchase With Cash Back,POS - Cash Deposit,POS - Benefit Cash Withdrawal,POS - Cash Deposit to Card,POS - M Banking,POS - Cash Withdrawal,POS - Balance Enquiry,POS - Mini Statement,MINIMUM BALANCE';
            OptionMembers = "Balance Enquiry","Mini Statement","Cash Withdrawal - Coop ATM","Cash Withdrawal - VISA ATM",Reversal,"Utility Payment","POS - Normal Purchase","M-PESA Withdrawal","Airtime Purchase","POS - School Payment","POS - Purchase With Cash Back","POS - Cash Deposit","POS - Benefit Cash Withdrawal","POS - Cash Deposit to Card","POS - M Banking","POS - Cash Withdrawal","POS - Balance Enquiry","POS - Mini Statement","MINIMUM BALANCE","POS-Utility Payment";
        }
        field(2;"Total Amount";Decimal)
        {
        }
        field(3;"Sacco Amount";Decimal)
        {
        }
        field(4;Source;Option)
        {
            OptionMembers = ATM,POS;
        }
        field(5;"Atm Income A/c";Code[30])
        {
            TableRelation = "G/L Account";
        }
        field(6;"Atm Bank Settlement A/C";Code[30])
        {
            TableRelation = "Bank Account";
        }
        field(7;ExciseDutyAccount;Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1;"Transaction Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

