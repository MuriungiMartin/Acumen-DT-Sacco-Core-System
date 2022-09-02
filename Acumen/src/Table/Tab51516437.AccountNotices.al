#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516437 "Account Notices"
{

    fields
    {
        field(1;"Account Type";Code[20])
        {
            NotBlank = true;
            TableRelation = "Account Types-Saving Products".Code;
        }
        field(2;"Code";Code[20])
        {
            NotBlank = false;
        }
        field(3;Description;Text[100])
        {
        }
        field(4;Duration;DateFormula)
        {
        }
        field(5;Penalty;Decimal)
        {
        }
        field(6;Type;Option)
        {
            OptionMembers = Other,"Limit Withdrawal","Account Closure";
        }
        field(7;"GL Account";Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(8;"Percentage Of Amount";Decimal)
        {
        }
        field(9;"Use Percentage";Boolean)
        {
        }
        field(10;Minimum;Decimal)
        {
        }
        field(11;Maximum;Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Account Type","Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

