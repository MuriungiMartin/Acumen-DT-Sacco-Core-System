#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50018 "Loans Details Buffer"
{

    fields
    {
        field(1;"Loan No";Code[20])
        {
        }
        field(2;"Cleint Code";Code[20])
        {
        }
        field(3;"Client Name";Code[70])
        {
        }
        field(4;"ID No";Code[20])
        {
        }
        field(5;"Application Date";Date)
        {
        }
        field(6;"Issued Date";Date)
        {
        }
        field(7;"Disburesment Date";Date)
        {
        }
        field(8;"Loan Product Type";Code[20])
        {
        }
        field(9;"Requested Amount";Decimal)
        {
        }
        field(10;"Approved Amount";Decimal)
        {
        }
        field(11;Instalment;Integer)
        {
        }
        field(12;"BOSA No";Code[20])
        {
        }
        field(13;"Interest Rate";Decimal)
        {
        }
        field(14;"Captured By";Code[20])
        {
        }
        field(15;"Disbursed By";Code[20])
        {
        }
        field(16;"Repayment Method";Option)
        {
            OptionCaption = 'Amortised,Reducing Balance,Straight Line,Constants';
            OptionMembers = Amortised,"Reducing Balance","Straight Line",Constants;
        }
        field(17;"Repayment Frequency";Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly,Quaterly';
            OptionMembers = Daily,Weekly,Monthly,Quaterly;
        }
        field(18;"Repayment Start Date";Date)
        {
        }
        field(19;Repayment;Decimal)
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

