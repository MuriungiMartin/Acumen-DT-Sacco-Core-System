#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516289 "Profitability Set up-Micro"
{
    DrillDownPageID = "Profitability Set up";
    LookupPageID = "Profitability Set up";

    fields
    {
        field(1;"Code";Code[10])
        {
        }
        field(2;Description;Text[30])
        {
        }
        field(3;Amount;Decimal)
        {
        }
        field(4;Type;Option)
        {
            OptionCaption = 'Profitability,Business Expenses,Family Expenses';
            OptionMembers = Profitability,"Business Expenses","Family Expenses";
        }
        field(5;"Code Type";Option)
        {
            OptionCaption = ' ,Purchase,Sales';
            OptionMembers = " ",Purchase,Sales;
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

