#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516064 "Coop Transfer"
{

    fields
    {
        field(1;Id;Integer)
        {
        }
        field(2;"Transaction Id";Code[30])
        {
        }
        field(3;"Account No";Code[50])
        {
        }
        field(4;"Transaction Date";Date)
        {
        }
        field(5;"Transaction Amount";Decimal)
        {
        }
        field(6;"Transaction Currency";Code[50])
        {
        }
        field(7;"Transaction Type";Option)
        {
            OptionCaption = 'Withdrawal,Deposits';
            OptionMembers = Withdrawal,Deposits;
        }
        field(8;"Transaction Particular";Code[50])
        {
        }
        field(9;"Depositor Name";Text[100])
        {
        }
        field(10;"Depositor Mobile";Text[30])
        {
        }
        field(11;"Date Posted";Date)
        {
        }
        field(12;"Date Processed";Date)
        {
        }
        field(13;"BrTransaction ID";Code[50])
        {
        }
        field(14;Processed;Code[50])
        {
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

