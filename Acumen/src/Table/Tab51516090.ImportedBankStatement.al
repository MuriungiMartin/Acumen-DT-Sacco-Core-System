#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516090 "Imported Bank Statement.."
{

    fields
    {
        field(9;"Line No";Integer)
        {
        }
        field(10;Date;Date)
        {
            Editable = false;
        }
        field(11;Description;Text[250])
        {
            Editable = false;
        }
        field(12;"Reference No";Code[50])
        {
        }
        field(13;Amount;Decimal)
        {
            Editable = false;
        }
        field(14;Bank;Text[250])
        {
            Editable = false;
        }
        field(15;Receipted;Boolean)
        {
            Editable = false;
        }
        field(16;Reconciled;Boolean)
        {
            Editable = false;
        }
        field(17;"Reconciliation Doc No";Code[20])
        {
            Editable = false;
        }
        field(18;"Reconciliation Date";Date)
        {
            Editable = false;
        }
        field(19;"Receipting Date";Date)
        {
            Editable = false;
        }
        field(20;ReceiptNo;Code[20])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Reference No","Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

