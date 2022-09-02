#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516287 "Micro Profitability Analysis"
{

    fields
    {
        field(1;"Code";Code[20])
        {
            TableRelation = "Profitability Set up-Micro".Code where (Type=const(Profitability));

            trigger OnValidate()
            begin

                ProfitSetUp.Reset;
                ProfitSetUp.SetRange(ProfitSetUp.Code,Code);
                if ProfitSetUp.FindFirst then begin
                Description:=ProfitSetUp.Description ;
                "Code Type":=ProfitSetUp."Code Type";
                //MODIFY;
                end;
            end;
        }
        field(2;"Client Code";Code[20])
        {
        }
        field(3;"Average Monthly Sales";Decimal)
        {
        }
        field(4;"Average Monthly Purchase";Decimal)
        {
        }
        field(5;"Gross Profit";Decimal)
        {
        }
        field(6;"Loan No.";Code[10])
        {
            TableRelation = "Loans Register";
        }
        field(7;Amount;Decimal)
        {
        }
        field(8;Description;Text[80])
        {
            Editable = false;
        }
        field(9;"Code Type";Option)
        {
            Editable = false;
            OptionCaption = ' ,Purchase,Sales';
            OptionMembers = " ",Purchase,Sales;
        }
    }

    keys
    {
        key(Key1;"Loan No.","Client Code","Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ProfitSetUp: Record "Profitability Set up-Micro";
}

