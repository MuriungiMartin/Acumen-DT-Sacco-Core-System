#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516923 "Credit Score Matrix"
{

    fields
    {
        field(1;"Code";Integer)
        {
            AutoIncrement = true;
        }
        field(2;Variable;Option)
        {
            OptionCaption = 'Balance of Current Account,Duration of Credit,Payment of Previous Credits,Purpose of Credit';
            OptionMembers = "Balance of Current Account","Duration of Credit","Payment of Previous Credits","Purpose of Credit";
        }
        field(3;"Value Code";Integer)
        {
        }
        field(4;"Value/Range";Text[250])
        {
        }
        field(5;WoE;Decimal)
        {
            DecimalPlaces = 3:3;
        }
        field(6;Estimate;Decimal)
        {
            DecimalPlaces = 5:5;
        }
        field(7;"Wald stat.";Decimal)
        {
            DecimalPlaces = 5:5;
        }
        field(8;"p value";Decimal)
        {
            DecimalPlaces = 5:5;
        }
        field(9;Scoring;Decimal)
        {
            DecimalPlaces = 3:3;
        }
        field(10;"Rounded scoring";Decimal)
        {
            DecimalPlaces = 0:0;
        }
    }

    keys
    {
        key(Key1;"Code",Variable,"Value/Range")
        {
            Clustered = true;
        }
        key(Key2;Variable)
        {
        }
        key(Key3;"Value/Range")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Code",Variable,"Value/Range")
        {
        }
    }
}

