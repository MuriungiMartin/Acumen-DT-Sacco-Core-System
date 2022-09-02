#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516920 "Tranch Disburesment Details"
{

    fields
    {
        field(1;"Loan No";Code[20])
        {
        }
        field(2;"Client Code";Code[20])
        {
        }
        field(3;"Client Name";Code[50])
        {
        }
        field(4;"Loan Product Type";Code[30])
        {
        }
        field(5;Description;Text[50])
        {
        }
        field(6;"Transaction Date";Date)
        {
        }
    }

    keys
    {
        key(Key1;"Loan No",Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

