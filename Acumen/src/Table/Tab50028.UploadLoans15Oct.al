#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50028 "Upload Loans 15Oct"
{

    fields
    {
        field(1;"Member No";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Loan Number";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Name;Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Loan Type";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Application Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Applied Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Recommended Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Approved Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Disbursed Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Loan Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

