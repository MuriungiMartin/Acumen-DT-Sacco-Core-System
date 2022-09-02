#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516052 "Sanctions List Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("AU Sanction List";"AU Sanction List")
            {
                XmlName = 'table';
                fieldelement(A;"AU Sanction List".Code)
                {
                }
                fieldelement(B;"AU Sanction List"."Name of Individual/Entity")
                {
                }
                fieldelement(C;"AU Sanction List"."Date of Birth")
                {
                }
                fieldelement(D;"AU Sanction List"."Palace Of Birth")
                {
                }
                fieldelement(E;"AU Sanction List".Citizenship)
                {
                }
                fieldelement(F;"AU Sanction List"."Listing Information")
                {
                }
                fieldelement(G;"AU Sanction List"."Control Date")
                {
                }
                fieldelement(H;"AU Sanction List"."AU Sactions kenya")
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

