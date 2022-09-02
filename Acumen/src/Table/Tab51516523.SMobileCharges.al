#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516523 "S-Mobile Charges"
{

    fields
    {
        field(1;"Transaction Type";Option)
        {
            OptionCaption = ' ,Withdrawal,Deposit,Balance,Ministatement,Airtime,Loan balance,Loan Status,Share Deposit Balance,Transfer to Fosa,Transfer to Bosa,Utility Payment,Loan Application,Standing orders';
            OptionMembers = "  ",Withdrawal,Deposit,Balance,Ministatement,Airtime,"Loan balance","Loan Status","Share Deposit Balance","Transfer to Fosa","Transfer to Bosa","Utility Payment","Loan Application","Standing orders";
        }
        field(2;"Total Amount";Decimal)
        {
        }
        field(3;"Sacco Amount";Decimal)
        {
        }
        field(4;Source;Option)
        {
            OptionMembers = ATM,POS,S_Mobile;
        }
        field(5;Tiered;Boolean)
        {
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

