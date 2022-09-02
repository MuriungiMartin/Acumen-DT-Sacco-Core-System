#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516405 "Simplified Accounts"
{

    fields
    {
        field(1;"Loan No";Code[10])
        {
        }
        field(2;"Code";Code[10])
        {
        }
        field(3;Description;Text[30])
        {
        }
        field(4;"Account Type";Option)
        {
            OptionCaption = 'Current Asset,Current Liablity,Fixed Asset,Equity,Sales,Credit Sales';
            OptionMembers = "Current Asset","Current Liablity","Fixed Asset",Equity,Sales,"Credit Sales";
        }
        field(5;Amount;Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Loan No","Code",Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

