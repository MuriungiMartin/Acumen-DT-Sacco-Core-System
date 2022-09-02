#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516023 "Import Repayment Schedule"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Loan Repayment Schedule";"Loan Repayment Schedule")
            {
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(No;"Loan Repayment Schedule"."Loan No.")
                {
                }
                fieldelement(Mobile_No;"Loan Repayment Schedule"."Member No.")
                {
                }
                fieldelement(Amount;"Loan Repayment Schedule"."Loan Category")
                {
                }
                fieldelement(Header_No;"Loan Repayment Schedule"."Closed Date")
                {
                }
                fieldelement(A;"Loan Repayment Schedule"."Loan Amount")
                {
                }
                fieldelement(B;"Loan Repayment Schedule"."Interest Rate")
                {
                }
                fieldelement(C;"Loan Repayment Schedule"."Monthly Repayment")
                {
                }
                fieldelement(D;"Loan Repayment Schedule"."Member Name")
                {
                }
                fieldelement(E;"Loan Repayment Schedule"."Monthly Interest")
                {
                }
                fieldelement(F;"Loan Repayment Schedule"."Amount Repayed")
                {
                }
                fieldelement(G;"Loan Repayment Schedule"."Repayment Date")
                {
                }
                fieldelement(H;"Loan Repayment Schedule"."Principal Repayment")
                {
                }
                fieldelement(I;"Loan Repayment Schedule".Paid)
                {
                }
                fieldelement(J;"Loan Repayment Schedule"."Remaining Debt")
                {
                }
                fieldelement(K;"Loan Repayment Schedule"."Instalment No")
                {
                }
                fieldelement(L;"Loan Repayment Schedule"."Actual Loan Repayment Date")
                {
                }
                fieldelement(M;"Loan Repayment Schedule"."Repayment Code")
                {
                }
                fieldelement(N;"Loan Repayment Schedule"."Group Code")
                {
                }
                fieldelement(O;"Loan Repayment Schedule"."Loan Application No")
                {
                }
                fieldelement(P;"Loan Repayment Schedule"."Actual Principal Paid")
                {
                }
                fieldelement(Q;"Loan Repayment Schedule"."Actual Interest Paid")
                {
                }
                fieldelement(R;"Loan Repayment Schedule"."Actual Installment Paid")
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

