#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516500 "Import Jnl"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Loans Register";"Loans Register")
            {
                XmlName = 'Paybill';
                SourceTableView = where("Doublicate Loans"=filter(true));
                fieldelement(A;"Loans Register"."Loan  No.")
                {
                }
                fieldelement(B;"Loans Register"."Client Code")
                {
                }
                fieldelement(E;"Loans Register"."Outstanding Balance")
                {
                }
                fieldelement(D;"Loans Register"."Oustanding Interest")
                {
                }
                fieldelement(Product;"Loans Register"."Loan Product Type")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

