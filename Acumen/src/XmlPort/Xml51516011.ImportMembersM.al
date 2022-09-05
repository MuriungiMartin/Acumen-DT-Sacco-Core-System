#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516011 "Import MembersM"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(Customer; Customer)
            {
                XmlName = 'Member';
                fieldelement(Root; Customer."No.")
                {
                }
                fieldelement(B; Customer.Name)
                {
                }
                fieldelement(X; Customer."ID No.")
                {
                }
                fieldelement(Q; Customer."Date of Birth")
                {
                }
                fieldelement(AA; Customer.Gender)
                {
                }
                fieldelement(F; Customer."Phone No.")
                {
                }
                fieldelement(N; Customer.Status)
                {
                }
                fieldelement(C; Customer."Registration Date")
                {
                }
                fieldelement(K; Customer."E-Mail")
                {
                }
                fieldelement(D; Customer."Introduced By")
                {
                }
                fieldelement(E; Customer."E-Mail")
                {
                }
                fieldelement(O; Customer."FOSA Account")
                {
                }
                fieldelement(G; Customer."Personal No")
                {
                }
                fieldelement(I; Customer."Customer Posting Group")
                {
                }
                fieldelement(L; Customer."Customer Type")
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

