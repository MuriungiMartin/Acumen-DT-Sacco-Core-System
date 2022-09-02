#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516288 "Appraisal Expenses-Micro"
{

    fields
    {
        field(1;"Code";Code[20])
        {
            TableRelation = "Profitability Set up-Micro";

            trigger OnValidate()
            begin
                if ProfSetUp.Get(Code) then begin
                Description:=ProfSetUp.Description;
                Type:=ProfSetUp.Type;
                end;
            end;
        }
        field(2;Description;Text[30])
        {
        }
        field(3;Type;Option)
        {
            OptionCaption = 'Profitability,Business Expenses,Family Expenses';
            OptionMembers = Profitability,"Business Expenses","Family Expenses";
        }
        field(4;Amount;Decimal)
        {
        }
        field(5;Loan;Code[10])
        {
            TableRelation = "Loans Register";
        }
        field(6;"Client Code";Code[50])
        {
        }
    }

    keys
    {
        key(Key1;Loan,"Client Code","Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ProfSetUp: Record "Profitability Set up-Micro";
}

