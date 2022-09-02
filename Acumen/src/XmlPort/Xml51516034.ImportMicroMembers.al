#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516034 "Import Micro Members"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Micro Members";"Micro Members")
            {
                XmlName = 'ChequeImport';
                fieldelement(A;"Micro Members"."Group Account No")
                {
                }
                fieldelement(B;"Micro Members"."Group Account Name")
                {
                }
                fieldelement(C;"Micro Members"."Member No")
                {
                }
                fieldelement(D;"Micro Members"."Member Name")
                {
                }
                fieldelement(E;"Micro Members"."ID No")
                {
                }
                fieldelement(F;"Micro Members"."Mobile No")
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

