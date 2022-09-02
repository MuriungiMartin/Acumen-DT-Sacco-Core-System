#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516518 "Mobile Charges"
{

    fields
    {
        field(1;"Transaction Type";Option)
        {
            OptionCaption = 'Balance Enquiry,Mini Statement,Cash Withdrawal,Airtime Purchase';
            OptionMembers = "Balance Enquiry","Mini Statement","Cash Withdrawal","Airtime Purchase";
        }
        field(2;"Total Amount";Decimal)
        {
        }
        field(3;"Sacco Amount";Decimal)
        {
        }
        field(4;Source;Option)
        {
            OptionCaption = 'Mobile';
            OptionMembers = Mobile;
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

