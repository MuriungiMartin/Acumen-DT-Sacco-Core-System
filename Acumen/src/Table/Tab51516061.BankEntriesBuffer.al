#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516061 "Bank Entries Buffer"
{

    fields
    {
        field(1;"Entry No.";Integer)
        {
        }
        field(2;"Posting Date";Date)
        {
        }
        field(3;"Document No.";Code[20])
        {
        }
        field(4;"External Document No.";Code[20])
        {
        }
        field(5;"Card No.";Code[20])
        {
        }
        field(6;Description;Text[250])
        {
        }
        field(7;Amount;Decimal)
        {
        }
        field(8;Reconciled;Boolean)
        {
        }
        field(10;Withdrawn;Decimal)
        {
        }
        field(11;"Paid In";Decimal)
        {
        }
        field(12;Inserted;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
            Clustered = true;
        }
        key(Key2;"Posting Date","Document No.","External Document No.",Amount,Reconciled)
        {
        }
    }

    fieldgroups
    {
    }
}

