#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516035 "Import Phone No"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Member House Groups"; "Member House Groups")
            {
                AutoReplace = true;
                XmlName = 'ChequeImport';
                // fieldelement(A;"Member Cell Groups"."Cell Group Code")
                // {
                // }
                // fieldelement(B;"Member Cell Groups"."Cell Group Name")
                // {
                // }
                // fieldelement(C;"Member Cell Groups"."Group Satatus")
                // {
                // }
                // fieldelement(D;"Member Cell Groups"."Date Formed")
                // {
                // }
                // fieldelement(E;"Member Cell Groups"."Meeting Place")
                // {
                // }
                // fieldelement(F;"Member Cell Groups"."Global Dimension 2 Code")
                // {
                // }
                // fieldelement(G;"Member Cell Groups"."Group Leader")
                // {
                // }
                // fieldelement(H;"Member Cell Groups"."Group Leader Name")
                // {
                // }
                // fieldelement(I;"Member Cell Groups"."Group Leader Phone No")
                // {
                // }
                // fieldelement(J;"Member Cell Groups"."Group Leader Email")
                // {
                // }
                // fieldelement(K;"Member Cell Groups"."Assistant group Leader")
                // {
                // }
                // fieldelement(L;"Member Cell Groups"."Assistant Group Name")
                // {
                // }
                // fieldelement(M;"Member Cell Groups"."Assistant Group Leader Phone N")
                // {
                // }
                // fieldelement(N;"Member Cell Groups"."Assistant Group Leader Email")
                // {
                // }
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

