#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516416 "Prepaid Remitance"
{

    fields
    {
        field(1;"Line No";Integer)
        {
        }
        field(2;"Staff No.";Code[20])
        {
        }
        field(3;"Loan No.";Code[10])
        {
        }
        field(5;Amount;Decimal)
        {
        }
        field(7;"Member No.";Code[50])
        {
        }
        field(8;"Member Name";Text[50])
        {
        }
    }

    keys
    {
        key(Key1;"Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

