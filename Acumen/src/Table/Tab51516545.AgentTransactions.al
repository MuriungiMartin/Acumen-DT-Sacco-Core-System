#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516545 "Agent Transactions"
{

    fields
    {
        field(1;"Document No.";Code[20])
        {
        }
        field(2;"Transaction Date";Date)
        {
        }
        field(3;"Account No.";Code[50])
        {
        }
        field(4;Description;Text[220])
        {
        }
        field(5;Amount;Decimal)
        {
            Editable = false;
        }
        field(6;Posted;Boolean)
        {
            Editable = false;
            Enabled = true;
        }
        field(7;"Transaction Type";Option)
        {
            OptionCaption = ',Registration,Withdrawal,Deposit,LoanRepayment,Transfer,Sharedeposit,Schoolfeespayment,Balance,Ministatment,Paybill,Memberactivation,MemberRegistration';
            OptionMembers = ,Registration,Withdrawal,Deposit,LoanRepayment,Transfer,Sharedeposit,Schoolfeespayment,Balance,Ministatment,Paybill,Memberactivation,MemberRegistration;
        }
        field(8;"Transaction Time";DateTime)
        {
        }
        field(9;"Bal. Account No.";Code[30])
        {
        }
        field(10;"Document Date";Date)
        {
        }
        field(11;"Date Posted";Date)
        {
        }
        field(12;"Time Posted";Time)
        {
        }
        field(13;"Account Status";Text[30])
        {
        }
        field(14;Messages;Text[200])
        {
        }
        field(15;"Needs Change";Boolean)
        {
        }
        field(17;"Old Account No";Code[50])
        {
        }
        field(18;Changed;Boolean)
        {
        }
        field(19;"Date Changed";Date)
        {
        }
        field(20;"Time Changed";Time)
        {
        }
        field(21;"Changed By";Code[10])
        {
        }
        field(22;"Approved By";Code[10])
        {
        }
        field(23;"Original Account No";Code[50])
        {
        }
        field(24;"Account Balance";Decimal)
        {
        }
        field(25;"Branch Code";Code[10])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(26;"Activity Code";Code[30])
        {
        }
        field(27;"Global Dimension 1 Filter";Code[20])
        {
        }
        field(28;"Global Dimension 2 Filter";Code[20])
        {
        }
        field(29;"Account No 2";Code[50])
        {
        }
        field(30;CCODE;Text[30])
        {
        }
        field(31;"Transaction Location";Text[30])
        {
        }
        field(32;"Transaction By";Text[30])
        {
        }
        field(33;"Agent Code";Text[30])
        {
        }
        field(34;"Loan No";Code[30])
        {
        }
        field(35;"Account Name";Text[100])
        {
        }
        field(36;Telephone;Text[30])
        {
        }
        field(37;"Id No";Text[30])
        {
        }
        field(38;Branch;Code[10])
        {
        }
        field(39;"Member No";Code[10])
        {
        }
    }

    keys
    {
        key(Key1;"Document No.",Description)
        {
            Clustered = true;
        }
        key(Key2;"Transaction Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Error('You cannot delete transactions.');
    end;

    trigger OnModify()
    begin
        /*
        IF Posted=TRUE THEN BEGIN
        ERROR('You cannot modify posted transactions.');
        END;
        */

    end;
}

