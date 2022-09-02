#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516547 "Fixed Deposit Data Buffer"
{

    fields
    {
        field(1;"Account No";Code[20])
        {
        }
        field(2;"Account Name";Code[50])
        {
        }
        field(3;"Amount to Transfer";Decimal)
        {
        }
        field(4;"Fixed Deposit Duration";DateFormula)
        {
        }
        field(5;"FD Interest Rate";Decimal)
        {
        }
        field(6;"Interest Expected";Decimal)
        {
        }
        field(7;"Fixed Deposit Status";Option)
        {
            OptionCaption = ' ,Active,Matured,Closed,Not Matured';
            OptionMembers = " ",Active,Matured,Closed,"Not Matured";
        }
        field(8;"Current Account No";Code[20])
        {
        }
        field(9;"Current Account Name";Code[50])
        {
        }
        field(10;"Account Type";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Account No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

