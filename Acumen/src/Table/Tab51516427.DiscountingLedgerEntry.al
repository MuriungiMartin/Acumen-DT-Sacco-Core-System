#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516427 "Discounting Ledger Entry"
{

    fields
    {
        field(1;No;Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"External Transaction No";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Cheque No";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Amount;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5;Debit;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6;Credit;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Posting Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"User ID";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Fosa Account";Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(11;"Transaction Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Deposit,Discounting,Clearing';
            OptionMembers = " ",Deposit,Discounting,Clearing;
        }
    }

    keys
    {
        key(Key1;No,"Cheque No","Transaction Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

