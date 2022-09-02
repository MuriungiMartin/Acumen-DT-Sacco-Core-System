#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516028 "Import BOSA Loan Guarantors"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Loans Guarantee Details";"Loans Guarantee Details")
            {
                XmlName = 'ChequeImport';
                fieldelement(A;"Loans Guarantee Details"."Member No")
                {
                }
                fieldelement(B;"Loans Guarantee Details"."Loanees  No")
                {
                }
                fieldelement(C;"Loans Guarantee Details"."Amont Guaranteed")
                {
                }
                fieldelement(D;"Loans Guarantee Details"."Loan Product")
                {
                }
                fieldelement(E;"Loans Guarantee Details"."Entry No.")
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

