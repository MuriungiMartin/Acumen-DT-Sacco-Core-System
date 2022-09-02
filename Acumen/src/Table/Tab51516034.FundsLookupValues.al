#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516034 "Funds Lookup Values"
{

    fields
    {
        field(10;"Code";Code[20])
        {
        }
        field(11;Type;Option)
        {
            OptionCaption = 'Payment,Receipt';
            OptionMembers = Payment,Receipt;
        }
        field(12;Description;Text[50])
        {
        }
        field(13;"Account Type";Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,Investor';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor;
        }
        field(14;"Account No";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

