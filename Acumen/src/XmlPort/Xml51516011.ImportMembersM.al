#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516011 "Import MembersM"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Member Register";"Member Register")
            {
                XmlName = 'Member';
                fieldelement(Root;"Member Register"."No.")
                {
                }
                fieldelement(B;"Member Register".Name)
                {
                }
                fieldelement(X;"Member Register"."ID No.")
                {
                }
                fieldelement(Q;"Member Register"."Date of Birth")
                {
                }
                fieldelement(AA;"Member Register".Gender)
                {
                }
                fieldelement(F;"Member Register"."Phone No.")
                {
                }
                fieldelement(N;"Member Register".Status)
                {
                }
                fieldelement(C;"Member Register"."Registration Date")
                {
                }
                fieldelement(K;"Member Register"."E-Mail")
                {
                }
                fieldelement(D;"Member Register"."Introduced By")
                {
                }
                fieldelement(E;"Member Register"."E-Mail")
                {
                }
                fieldelement(O;"Member Register"."FOSA Account")
                {
                }
                fieldelement(G;"Member Register"."Personal No")
                {
                }
                fieldelement(I;"Member Register"."Customer Posting Group")
                {
                }
                fieldelement(L;"Member Register"."Customer Type")
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

