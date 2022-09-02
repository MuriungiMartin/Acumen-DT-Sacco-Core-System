#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516076 "ATM SETUP"
{

    fields
    {
        field(1;ID;Integer)
        {
        }
        field(2;"ATM Bank";Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(3;SaccoChargeAccount;Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(4;BankChargeAccount;Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(5;VendorChargeAccount;Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(6;AtmSettlementAccount;Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(7;VisaSettlementAccount;Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
    }

    keys
    {
        key(Key1;ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

