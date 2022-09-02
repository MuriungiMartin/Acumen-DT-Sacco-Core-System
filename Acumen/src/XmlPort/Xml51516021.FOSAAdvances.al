#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516021 "FOSA Advances"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("FOSA Advances";"FOSA Advances")
            {
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(A;"FOSA Advances"."FOSA Account No")
                {
                }
                fieldelement(B;"FOSA Advances"."Member No")
                {
                }
                fieldelement(C;"FOSA Advances".Name)
                {
                }
                fieldelement(D;"FOSA Advances"."ID No")
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

