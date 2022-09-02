#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516037 "Savings Product Types"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Account Types-Saving Products";"Account Types-Saving Products")
            {
                AutoUpdate = true;
                XmlName = 'ChequeImport';
                fieldelement(A;"Account Types-Saving Products".Code)
                {
                }
                fieldelement(B;"Account Types-Saving Products".Description)
                {
                }
                fieldelement(C;"Account Types-Saving Products"."Minimum Balance")
                {
                }
                fieldelement(D;"Account Types-Saving Products"."Fee Below Minimum Balance")
                {
                }
                fieldelement(E;"Account Types-Saving Products"."Dormancy Period (M)")
                {
                }
                fieldelement(F;"Account Types-Saving Products"."Interest Calc Min Balance")
                {
                }
                fieldelement(G;"Account Types-Saving Products"."Earns Interest")
                {
                }
                fieldelement(H;"Account Types-Saving Products"."Interest Rate")
                {
                }
                fieldelement(I;"Account Types-Saving Products"."Service Charge")
                {
                }
                fieldelement(J;"Account Types-Saving Products"."Minimum Interest Period (M)")
                {
                }
                fieldelement(K;"Account Types-Saving Products"."Fixed Deposit")
                {
                }
                fieldelement(M;"Account Types-Saving Products"."Posting Group")
                {
                }
                fieldelement(N;"Account Types-Saving Products"."Account No Prefix")
                {
                }
                fieldelement(O;"Account Types-Saving Products"."Interest Expense Account")
                {
                }
                fieldelement(P;"Account Types-Saving Products"."Interest Payable Account")
                {
                }
                fieldelement(Q;"Account Types-Saving Products"."Allow Loan Applications")
                {
                }
                fieldelement(S;"Account Types-Saving Products"."Min Bal. Calc Frequency")
                {
                }
                fieldelement(T;"Account Types-Saving Products"."SMS Description")
                {
                }
                fieldelement(U;"Account Types-Saving Products"."No. Series")
                {
                }
                fieldelement(V;"Account Types-Saving Products"."Ending Series")
                {
                }
                fieldelement(W;"Account Types-Saving Products"."Tax On Interest")
                {
                }
                fieldelement(X;"Account Types-Saving Products"."Interest Tax Account")
                {
                }
                fieldelement(Y;"Account Types-Saving Products"."External EFT Charges")
                {
                }
                fieldelement(Z;"Account Types-Saving Products"."EFT Charges Account")
                {
                }
                fieldelement(AB;"Account Types-Saving Products"."Other Financial Income Account")
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

