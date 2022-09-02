#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516024 "Import Loan Details"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Loans Details Buffer";"Loans Details Buffer")
            {
                XmlName = 'ChequeImport';
                fieldelement(A;"Loans Details Buffer"."Loan No")
                {
                }
                fieldelement(B;"Loans Details Buffer"."Cleint Code")
                {
                }
                fieldelement(C;"Loans Details Buffer"."Client Name")
                {
                }
                fieldelement(D;"Loans Details Buffer"."ID No")
                {
                }
                fieldelement(E;"Loans Details Buffer"."Application Date")
                {
                }
                fieldelement(F;"Loans Details Buffer"."Issued Date")
                {
                }
                fieldelement(G;"Loans Details Buffer"."Disburesment Date")
                {
                }
                fieldelement(H;"Loans Details Buffer"."Loan Product Type")
                {
                }
                fieldelement(I;"Loans Details Buffer"."Requested Amount")
                {
                }
                fieldelement(J;"Loans Details Buffer"."Approved Amount")
                {
                }
                fieldelement(K;"Loans Details Buffer".Instalment)
                {
                }
                fieldelement(L;"Loans Details Buffer"."BOSA No")
                {
                }
                fieldelement(M;"Loans Details Buffer"."Interest Rate")
                {
                }
                fieldelement(N;"Loans Details Buffer"."Captured By")
                {
                }
                fieldelement(O;"Loans Details Buffer"."Disbursed By")
                {
                }
                fieldelement(P;"Loans Details Buffer"."Repayment Method")
                {
                }
                fieldelement(Q;"Loans Details Buffer"."Repayment Frequency")
                {
                }
                fieldelement(R;"Loans Details Buffer"."Repayment Start Date")
                {
                }
                fieldelement(S;"Loans Details Buffer".Repayment)
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

