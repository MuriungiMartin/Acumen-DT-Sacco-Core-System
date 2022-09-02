#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516053 "Tax Haven Countries Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Tax Haven Countries";"Tax Haven Countries")
            {
                XmlName = 'table';
                fieldelement(A;"Tax Haven Countries".Code)
                {
                }
                fieldelement(B;"Tax Haven Countries".Country)
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

