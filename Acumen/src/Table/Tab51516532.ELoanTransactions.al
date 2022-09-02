#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516532 "E-Loan Transactions"
{

    fields
    {
        field(1;"Account No";Code[30])
        {
        }
        field(2;"Account Name";Text[50])
        {
        }
        field(3;"Document No";Code[30])
        {
        }
        field(4;"Document Date";Date)
        {
        }
        field(5;"Transaction Time";Time)
        {
        }
        field(6;"Transaction Type";Option)
        {
            OptionCaption = ' ,Withdrawal,Deposit,Balance,Ministatement,Airtime,Loan balance,Loan Status,Share Deposit Balance,Transfer to Fosa,Transfer to Bosa,Utility Payment,Loan Application,Standing orders';
            OptionMembers = " ",Withdrawal,Deposit,Balance,Ministatement,Airtime,"Loan balance","Loan Status","Share Deposit Balance","Transfer to Fosa","Transfer to Bosa","Utility Payment","Loan Application","Standing orders";
        }
        field(7;"Telephone Number";Code[30])
        {
        }
        field(8;Posted;Boolean)
        {
        }
        field(9;"Date Posted";DateTime)
        {
        }
        field(10;"Account 2";Text[30])
        {
        }
        field(11;"Loan No";Code[30])
        {
        }
        field(12;Status;Option)
        {
            OptionCaption = 'Pending,Completed,Failed';
            OptionMembers = Pending,Completed,Failed;
        }
        field(13;Comments;Text[50])
        {
        }
        field(14;Amount;Decimal)
        {
        }
        field(15;Charge;Decimal)
        {
        }
        field(16;Description;Text[100])
        {
        }
        field(18;Entry;Integer)
        {
            AutoIncrement = true;
        }
        field(20;Client;Code[50])
        {
        }
        field(21;"Posting Date";Date)
        {
        }
    }

    keys
    {
        key(Key1;Entry,"Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

