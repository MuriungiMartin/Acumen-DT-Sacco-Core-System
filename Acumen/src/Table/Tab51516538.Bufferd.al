#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516538 "Buffer d"
{

    fields
    {
        field(1;"Document No";Code[30])
        {
        }
        field(2;"Loan No";Code[30])
        {
        }
        field(3;"Member Number";Code[30])
        {
        }
        field(4;"Transaction type";Option)
        {
            OptionCaption = 'Repayment,Loan';
            OptionMembers = Repayment,Loan;
        }
        field(5;Amount;Decimal)
        {
        }
        field(6;"Approved Amount";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

