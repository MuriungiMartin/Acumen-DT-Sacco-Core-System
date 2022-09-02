#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516424 "Monthly Interest Acrual"
{

    fields
    {
        field(1;"Document No";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Transaction Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Loan No";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Approved Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Outstanding Balance";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Interest Accrued";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"User ID";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8;Posted;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Member No";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Member Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Interest Rate";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Loan Product";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Employer Code";Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Document No","Loan No")
        {
            Clustered = true;
        }
        key(Key2;"Loan No")
        {
        }
    }

    fieldgroups
    {
    }
}

