#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516051 "Next of Kin Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Members Nominee";"Members Nominee")
            {
                XmlName = 'table';
                fieldelement(A;"Members Nominee"."Account No")
                {
                }
                fieldelement(B;"Members Nominee".Name)
                {
                }
                fieldelement(C;"Members Nominee"."ID No.")
                {
                }
                fieldelement(D;"Members Nominee".Relationship)
                {
                }
                fieldelement(E;"Members Nominee"."%Allocation")
                {
                }
                fieldelement(F;"Members Nominee".Telephone)
                {
                }
                fieldelement(G;"Members Nominee".Email)
                {
                }
                fieldelement(H;"Members Nominee".Guardian)
                {
                }
                fieldelement(I;"Members Nominee"."Date Created")
                {
                }
                fieldelement(J;"Members Nominee"."Created By")
                {
                }
                fieldelement(K;"Members Nominee"."Last date Modified")
                {
                }
                fieldelement(L;"Members Nominee"."Modified by")
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

