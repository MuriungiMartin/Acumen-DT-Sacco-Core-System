#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516066 "Equity Transaction"
{

    fields
    {
        field(1;Id;Integer)
        {
        }
        field(2;"Transaction Id";Code[100])
        {
        }
        field(3;"Reference No";Code[100])
        {
        }
        field(4;"Transaction Date";Date)
        {
        }
        field(5;"Transaction Amount";Decimal)
        {
        }
        field(6;"Transaction Currency";Code[100])
        {
        }
        field(7;"Transaction Type";Option)
        {
            OptionCaption = 'Transfer,Cash deposit';
            OptionMembers = Transfer,"Cash deposit";
        }
        field(8;"Transaction Particular";Code[100])
        {
        }
        field(9;"Phone No";Code[20])
        {
        }
        field(10;"Debit Account";Code[20])
        {
        }
        field(11;"Debit Customer Name";Text[100])
        {
        }
        field(12;"Date Posted";Date)
        {
        }
        field(13;"Date Processed";Date)
        {
        }
        field(14;"BrTransaction Id";Code[50])
        {
        }
        field(15;Processed;Code[10])
        {
        }
        field(16;Comments;Code[20])
        {
        }
        field(17;Posted;Boolean)
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

