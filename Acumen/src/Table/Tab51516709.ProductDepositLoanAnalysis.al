#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516709 "Product Deposit>Loan Analysis"
{

    fields
    {
        field(1;"Product Code";Code[20])
        {
            NotBlank = true;
            TableRelation = "Loan Products Setup".Code;
        }
        field(2;"Deposit Multiplier";Integer)
        {
            NotBlank = true;
        }
        field(3;"Minimum Deposit";Decimal)
        {
        }
        field(4;"Minimum Share Capital";Decimal)
        {
        }
        field(5;"Minimum No of Membership Month";Integer)
        {
        }
    }

    keys
    {
        key(Key1;"Product Code","Deposit Multiplier","Minimum Deposit","Minimum Share Capital","Minimum No of Membership Month")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Charges: Record "Loan Charges";
        loantype: Record "Loan Products Setup";
}

