#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516033 "Import Loans Products"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Loan Products Setup";"Loan Products Setup")
            {
                AutoUpdate = true;
                XmlName = 'ChequeImport';
                fieldelement(A;"Loan Products Setup".Code)
                {
                }
                fieldelement(B;"Loan Products Setup"."Product Description")
                {
                }
                fieldelement(C;"Loan Products Setup"."Interest rate")
                {
                }
                fieldelement(D;"Loan Products Setup".Source)
                {
                }
                fieldelement(E;"Loan Products Setup"."No of Installment")
                {
                }
                fieldelement(F;"Loan Products Setup".Rounding)
                {
                }
                fieldelement(G;"Loan Products Setup"."Rounding Precision")
                {
                }
                fieldelement(H;"Loan Products Setup"."Instalment Period")
                {
                }
                fieldelement(I;"Loan Products Setup"."Penalty Calculation Method")
                {
                }
                fieldelement(J;"Loan Products Setup"."Penalty Paid Account")
                {
                }
                fieldelement(K;"Loan Products Setup"."Max. Loan Amount")
                {
                }
                fieldelement(L;"Loan Products Setup"."Repayment Method")
                {
                }
                fieldelement(M;"Loan Products Setup"."Min. Loan Amount")
                {
                }
                fieldelement(N;"Loan Products Setup"."Loan Account")
                {
                }
                fieldelement(O;"Loan Products Setup"."Loan Interest Account")
                {
                }
                fieldelement(P;"Loan Products Setup"."Receivable Interest Account")
                {
                }
                fieldelement(Q;"Loan Products Setup"."Top Up Commision Account")
                {
                }
                fieldelement(R;"Loan Products Setup"."Top Up Commision")
                {
                }
                fieldelement(S;"Loan Products Setup"."Default Installements")
                {
                }
                fieldelement(T;"Loan Products Setup"."Min No. Of Guarantors")
                {
                }
                fieldelement(U;"Loan Products Setup"."Repayment Frequency")
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

