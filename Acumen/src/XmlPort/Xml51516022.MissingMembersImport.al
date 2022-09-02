#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516022 "Missing Members Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Missing Accounts Buffer";"Missing Accounts Buffer")
            {
                XmlName = 'Paybill';
                fieldelement(A;"Missing Accounts Buffer"."Member No")
                {
                }
                fieldelement(B;"Missing Accounts Buffer"."Member Name")
                {
                }
                fieldelement(C;"Missing Accounts Buffer"."Entry No")
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

