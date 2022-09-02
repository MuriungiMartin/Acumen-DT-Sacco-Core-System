#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516472 "Loans Control Tables"
{

    fields
    {
        field(1;"Loan No";Code[20])
        {
        }
        field(2;"Member No";Code[20])
        {
        }
        field(3;"Loan Product";Code[20])
        {
        }
        field(4;"Loan Application Date";Date)
        {
        }
        field(5;"Applied Amount";Decimal)
        {
        }
        field(6;"Approved Amount";Decimal)
        {
        }
        field(7;interest;Decimal)
        {
        }
        field(8;"Loan Status";Option)
        {
            OptionCaption = 'Open,Pending,Approved';
            OptionMembers = Open,Pending,Approved;
        }
        field(9;Instaments;Integer)
        {
        }
        field(10;"Repayment method";Option)
        {
            OptionMembers = Amortised;
        }
        field(11;Branch;Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Loan No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

