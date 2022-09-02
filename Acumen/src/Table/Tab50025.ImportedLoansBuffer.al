#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50025 "Imported Loans Buffer"
{

    fields
    {
        field(1;"Loan No";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Member No";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Loan Product Type";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Repayment Period";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Applied Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Approved Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Amount Disbursed";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Disbursement Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9;Source;Code[100])
        {
            DataClassification = ToBeClassified;
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

