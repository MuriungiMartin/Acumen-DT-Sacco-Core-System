#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516020 "Loans Classification Grouped3."
{

    fields
    {
        field(1;"Loan Product";Code[100])
        {
        }
        field(3;"Sasra Category";Option)
        {
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(4;Performing;Decimal)
        {
            CalcFormula = sum("Loans Register"."Outstanding Balance" where ("Loan Product Type"=field("Loan Product"),
                                                                            "Loans Category"=field(Performing)));
            FieldClass = FlowField;
        }
        field(5;Watch;Decimal)
        {
        }
        field(6;Substandard;Decimal)
        {
        }
        field(7;Doubtful;Decimal)
        {
        }
        field(8;Loss;Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Loan Product","Sasra Category")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

